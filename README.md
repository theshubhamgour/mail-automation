# JobApplicationEmailer

A Google Apps Script project that automates sending job application emails to companies listed in a Google Spreadsheet. It attaches a resume from a Google Drive link, tracks sent emails with a green checkmark, and provides a custom menu for easy triggering.

## Features
- **Automated Email Sending**: Reads company details (name, job designation, HR email, resume link) from a Google Spreadsheet and sends personalized job application emails.
- **Resume Attachment**: Attaches a resume PDF from a Google Drive link specified in the spreadsheet.
- **Email Tracking**: Adds a green checkmark (`✔`) in the spreadsheet to mark successfully sent emails, preventing duplicates.
- **Custom Menu**: Adds a "Job Application" menu with a "Send Emails" option in Google Sheets for easy triggering.
- **Reusable**: Processes only rows without a checkmark, making it reusable for new entries or resending emails.
- **Error Handling**: Skips invalid emails or inaccessible resumes, logging errors for troubleshooting.

## Spreadsheet Structure
The Google Spreadsheet should have the following columns:

| Name of the Comany | Job Desgination | HR Email         | Resume Link                                        | Mail Sent |
|--------------------|-----------------|------------------|----------------------------------------------------|-----------|
| SeinCloud Technologies | UI/UX         | iamtheshubhamgour@gmail.com | https://drive.google.com/file/d/FILE_ID/view?usp=sharing |           |

- **Name of the Comany**: Company name (e.g., SeinCloud Technologies).
- **Job Desgination**: Job title (e.g., UI/UX).
- **HR Email**: HR email address (e.g., iamtheshubhamgour@gmail.com).
- **Resume Link**: Google Drive shareable link to the resume PDF (e.g., https://drive.google.com/file/d/FILE_ID/view?usp=sharing).
- **Mail Sent**: Leave blank; a green `✔` will be added after a successful email send.

## Setup Instructions
1. **Create a Google Spreadsheet**:
   - Set up a Google Spreadsheet with the structure above.
   - Add company details in the respective columns.
   - Ensure resume PDFs in Google Drive are accessible (set sharing to "Anyone with the link").

2. **Add the Script**:
   - Open the Google Spreadsheet.
   - Go to `Extensions > Apps Script`.
   - Copy and paste the script from `script.gs` into the Apps Script editor.
   - Update the `applicantName` variable in the script with your name.
   - Save the script (e.g., name it `SendJobApplications`).

3. **Authorize the Script**:
   - Refresh the spreadsheet to see the "Job Application" menu.
   - Click `Job Application > Send Emails` to run the script.
   - Grant permissions when prompted (access to spreadsheet, Gmail, and Google Drive).

4. **Share with Others**:
   - Share the spreadsheet with edit access.
   - Shared users can click `Job Application > Send Emails` to send emails from their Gmail account.

## Usage
- Add new rows to the spreadsheet with company details and resume links.
- Click `Job Application > Send Emails` to send emails to all rows without a green checkmark in the "Mail Sent" column.
- To resend an email (e.g., with a new resume), clear the `✔` in the "Mail Sent" column and rerun the script.

## Notes
- **Gmail Limits**: Gmail has sending limits (~100-150 emails/day for free accounts, 2,000 for Google Workspace). Be mindful when sending to many companies.
- **Resume Access**: Ensure resume PDFs are accessible to the script and shared users.
- **Attachment Size**: Resume PDFs must be under Gmail’s attachment size limit (25 MB).
- **Error Logs**: Check `View > Logs` in the Apps Script editor for troubleshooting.

## Contributing
Feel free to fork this repository, make improvements, and submit pull requests. Suggestions for additional features (e.g., email templates, retry logic) are welcome!

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.