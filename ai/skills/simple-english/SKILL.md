---
name: simple-english
description: Write English text in ASD-STE100 Simplified Technical English. Use when writing or rewriting GitLab issues, MR descriptions, comments, runbooks, incident reports, docs or Slack posts in English, or when asked for "simple English", "STE" or "ASD-STE100". Does not apply to text in other languages.
---

# Simple English (ASD-STE100)

Write every English sentence by these rules. They come from ASD-STE100 Simplified Technical English. The goal: one clear meaning, easy for non-native readers and for translation tools.

## Scope

- Use it for English text only. If the issue, thread or doc is in Spanish, write in Spanish and do not apply these rules.
- Keep code, commands, file paths, service names, error messages and quotes exactly as they are. The rules apply to your own words only.

## Words

1. Use simple, common words. Use one word for one meaning, and keep that meaning in the whole text.
   - "start", not "initiate" or "kick off"
   - "use", not "utilize" or "leverage"
   - "help", not "facilitate"
   - "make sure", not "ensure"
   - "show", not "display" or "surface"
   - "about", not "approximately"
   - "before", not "prior to"
2. Use the same term for the same thing every time. Do not use synonyms for variety ("service", then "app", then "component" for the same thing).
3. Do not use phrasal verbs. "Find", not "find out". "Stop", not "shut down". "Examine", not "look into". "Continue", not "carry on".
4. Technical names (service names, field names, states, products) are allowed. Write them the same way every time.
5. Do not use slang, idioms or jargon that a non-native reader can misunderstand ("low-hanging fruit", "ballpark", "on the radar").
6. Write abbreviations in full the first time, unless the team uses them every day (MR, API, PR are OK).

## Verbs

7. Use only these verb forms: imperative ("Restart the pod."), simple present ("The job fails."), simple past ("The job failed."), future with "will" ("The job will fail."), and the past participle as an adjective ("the failed job").
8. Do not use "-ing" verb forms as verbs ("The job is failing" → "The job fails"). An "-ing" word is OK only when it is part of a technical name ("incremental routing").
9. Use the active voice: "Jorge merged the MR", not "The MR was merged by Jorge". In descriptive text, passive is allowed only when the actor is not known or not important.
10. Do not hide the action in a noun: "Configure the zones", not "Do the configuration of the zones".

## Sentences

11. Procedures (steps, instructions): maximum 20 words per sentence. One instruction per sentence, unless two actions happen at the same time.
12. Descriptive text (context, analysis): maximum 25 words per sentence.
13. Do not remove words to make a sentence shorter. Keep "the", "a" and "that".
14. Put a condition first: "If the alert fires again, open an issue." not "Open an issue if the alert fires again."
15. Maximum 3 nouns in a noun cluster. "Queue zone configuration error" (4 nouns) → "error in the configuration of the queue zone".
16. Use vertical lists for steps, options and three or more items.

## Paragraphs and structure

17. One topic per paragraph. Maximum 6 sentences per paragraph.
18. Start with the most important information: the problem or the request first, then the details.
19. Write procedures as numbered steps. Start each step with the verb.
20. Put a warning or caution before the step it applies to, not after. Start it with the command: "Do not delete the table. Data uses it."

## Issue template (default shape)

When you write an issue, use this structure unless the repo has its own template:

```markdown
## Problem
<What happens. Who it affects. Since when. 1–3 short sentences.>

## Expected result
<What must happen.>

## Steps to reproduce
1. <Verb first.>
2. <...>

## Data
- <Logs, links, IDs, counts.>

## Proposed action
- <Who does what.>
```

## Check before you finish

Read the text again and fix each item:
- [ ] Each sentence has a maximum of 20 words (procedures) or 25 words (descriptions).
- [ ] No "-ing" verbs, no phrasal verbs, no passive voice without a reason.
- [ ] One word for one meaning. The same term for the same thing.
- [ ] No noun cluster of more than 3 words.
- [ ] Conditions come first. Warnings come before the step.
- [ ] Code, names and quotes are unchanged.

## Example

Before:
> We've been seeing the Instaleap consumer failing intermittently since the deploy was rolled out, which is likely caused by 4xx responses being retried, so we should look into filtering those out.

After:
> The Instaleap consumer fails sometimes. This started after the last deploy. The probable cause: the consumer retries 4xx responses. Change the consumer so that it does not retry 4xx responses.
