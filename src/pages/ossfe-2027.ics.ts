import type { APIRoute } from 'astro';
import cfp from '../data/cfp.json';

// Fixed so rebuilds produce a byte-identical file: a changing DTSTAMP would make
// every deploy look like an edit to calendar clients. Bump it by hand (together
// with SEQUENCE) whenever the dates below actually change.
const DTSTAMP = '20260811T000000Z';
const SEQUENCE = 0;

/** Escape an RFC 5545 TEXT value. */
function escapeText(value: string): string {
  return value
    .replace(/\\/g, '\\\\')
    .replace(/;/g, '\\;')
    .replace(/,/g, '\\,')
    .replace(/\r?\n/g, '\\n');
}

/** Fold a content line to 75 octets, continuations prefixed with one space. */
function fold(line: string): string {
  const bytes = new TextEncoder().encode(line);
  if (bytes.length <= 75) return line;

  const out: string[] = [];
  let current = '';
  let currentBytes = 0;
  // 75 octets on the first line, 74 after that: the leading space counts too.
  let limit = 75;

  for (const char of line) {
    const size = new TextEncoder().encode(char).length;
    if (currentBytes + size > limit) {
      out.push(current);
      current = '';
      currentBytes = 0;
      limit = 74;
    }
    current += char;
    currentBytes += size;
  }
  out.push(current);

  return out.join('\r\n ');
}

/** "2027-06-01" -> "20270601", with an optional day offset. */
function toDateValue(iso: string, addDays = 0): string {
  const date = new Date(`${iso}T00:00:00Z`);
  date.setUTCDate(date.getUTCDate() + addDays);
  return date.toISOString().slice(0, 10).replace(/-/g, '');
}

type Event = {
  uid: string;
  summary: string;
  description: string;
  start: string;
  /** Inclusive last day. DTEND is written as the day after this one. */
  end: string;
  location?: string;
  /** Days before the start to fire a reminder. Omit for no alarm. */
  alarmDaysBefore?: number;
};

function renderEvent(event: Event, url: string): string[] {
  const lines = [
    'BEGIN:VEVENT',
    `UID:${event.uid}`,
    `DTSTAMP:${DTSTAMP}`,
    `SEQUENCE:${SEQUENCE}`,
    `DTSTART;VALUE=DATE:${toDateValue(event.start)}`,
    `DTEND;VALUE=DATE:${toDateValue(event.end, 1)}`,
    `SUMMARY:${escapeText(event.summary)}`,
    `DESCRIPTION:${escapeText(event.description)}`,
    `URL:${url}`,
    // Deadlines should not read as busy time; only the conference blocks days.
    `TRANSP:${event.location ? 'OPAQUE' : 'TRANSPARENT'}`,
  ];

  if (event.location) {
    lines.push(`LOCATION:${escapeText(event.location)}`);
  }

  if (event.alarmDaysBefore) {
    lines.push(
      'BEGIN:VALARM',
      'ACTION:DISPLAY',
      `DESCRIPTION:${escapeText(event.summary)}`,
      `TRIGGER:-P${event.alarmDaysBefore}D`,
      'END:VALARM',
    );
  }

  lines.push('END:VEVENT');
  return lines;
}

export const GET: APIRoute = ({ site }) => {
  const { meta, calendar, programmeNote } = cfp;
  const url = new URL(import.meta.env.BASE_URL, site).href;
  const cfpUrl = `https://${meta.cfpUrl}`;

  const events: Event[] = [
    {
      uid: 'ossfe-2027-conference@ossfe.org',
      summary: meta.event,
      description: `Open Source Software for Fusion Energy. ${programmeNote}\n\n${url}`,
      start: calendar.start,
      end: calendar.end,
      location: calendar.locationFull,
    },
    {
      uid: 'ossfe-2027-cfp-opens@ossfe.org',
      summary: `${meta.event}: call for proposals opens`,
      description: `Submissions open at ${cfpUrl}`,
      start: calendar.cfpOpens,
      end: calendar.cfpOpens,
    },
    {
      uid: 'ossfe-2027-cfp-closes@ossfe.org',
      summary: `${meta.event}: call for proposals closes`,
      description: `Last day to submit at ${cfpUrl}`,
      start: calendar.cfpCloses,
      end: calendar.cfpCloses,
      alarmDaysBefore: 7,
    },
    {
      uid: 'ossfe-2027-early-bird-opens@ossfe.org',
      summary: `${meta.event}: early-bird tickets on sale`,
      description: `Registration opens at the early-bird rate. ${url}`,
      start: calendar.earlyBirdOpens,
      end: calendar.earlyBirdOpens,
    },
    {
      uid: 'ossfe-2027-early-bird-ends@ossfe.org',
      summary: `${meta.event}: early-bird tickets end`,
      description: `Last day to register at the early-bird rate. ${url}`,
      start: calendar.earlyBirdEnds,
      end: calendar.earlyBirdEnds,
      alarmDaysBefore: 7,
    },
  ];

  const lines = [
    'BEGIN:VCALENDAR',
    'VERSION:2.0',
    'PRODID:-//OSSFE//OSSFE 2027//EN',
    'CALSCALE:GREGORIAN',
    'METHOD:PUBLISH',
    `X-WR-CALNAME:${escapeText(meta.event)}`,
    ...events.flatMap((event) => renderEvent(event, url)),
    'END:VCALENDAR',
  ];

  const body = lines.map(fold).join('\r\n') + '\r\n';

  return new Response(body, {
    headers: { 'Content-Type': 'text/calendar; charset=utf-8' },
  });
};
