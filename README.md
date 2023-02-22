I spent too much time loosing too many of my shell commands.

I spent too much time figuring out the right approach for using them.

I want you to save your time and sanity.

Here is an opinionated, no-nonsense approach for managing your shell command history, with the accompanying tools and setup scripts.

The guiding principles are:
- All shell commands should be saved immediately and systematically: they represent the change of state of your systems.

- Shell command histories should be "transient": they should not be meant to accumulate with time and stay untouched, but instead, be examined in order for you to identify and categorize their relevant parts, which themselves should be collected and exploited (e.g. installation commands should translate to added lines in a bootstrapping shell script or Ansible playbook ; useful functions or commands created in the heat of the moment should be gathered into a personal library or as Navi cheats).

- Shell history should be stored in fluid, semi-structured text: because your commands are likely to be personal and specialized, no AI-assisted tool is likely to replace you for the processing stage, which will be manual, and consist in gradually and iteratively regrouping, reshaping and triaging the incoming history lines.

- Shell history should be collected and stored in a unique location.

That's it for now. Stay tuned.

This repo is a work in progress. Feel free to join !