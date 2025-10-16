Project overview
This repository contains an end-to-end automated test solution for the SwagLabs demo application and an additional credential-driven login test using an external practice site. The flow includes Robot Framework test suites, Jenkins CI/CD pipeline, report publishing (Robot + JUnit), and automated Jira comments for build results.

Key features
• 	Full E2E Robot Framework test suites for the SwagLabs application.
• 	Credential-driven login tests using an external practice URL for data-driven validation.
• 	Jenkins pipeline that runs tests, archives artifacts, publishes Robot and JUnit reports, and posts a comment to the linked Jira issue with build status.
• 	Automated reporting with viewable HTML reports and CI logs.
• 	Branching workflow compatible with company Main → feature branch → PR merge model.

Repository layout
• 	/tests/ — Robot Framework test suites and resource files.
• 	/resources/ — Page objects, keywords, and common libraries.
• 	/data/ — Test data files (Excel, CSV).
• 	/reports/ — Generated Robot HTML reports and JUnit XML outputs.
• 	Jenkinsfile — Pipeline definition for CI/CD.
• 	README.md — This file.
• 	requirements.txt — Python and library dependencies.
• 	.github/ or .gitlab/ — Optional CI templates and issue/PR templates.

Prerequisites
• 	Git installed and access to the repo.
• 	Python 3.8+ and pip.
• 	Robot Framework and required libraries from requirements.txt.
• 	Jenkins server configured with agents able to run Robot tests and access the AUT.
• 	Jira account with API token and permission to add comments to issues.
• 	curl available on Jenkins agent for Jira API calls.


1 - Clone the repo
git clone <repo-url>
cd <repo-directory>

2 - Create and activate virtualenv
python -m venv .venv
source .venv/bin/activate   # Linux/macOS
.venv\Scripts\activate      # Windows PowerShell

3 - Install dependencies
pip install -r requirements.txt

4 - Run the test suites locally
robot -d reports tests/

5 - Output: HTML report in reports/ and JUnit XML for CI.

Test





