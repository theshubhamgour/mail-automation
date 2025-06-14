function sendJobApplications() {
  // Get the active spreadsheet and sheet
  var spreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = spreadsheet.getActiveSheet();
  
  // Get data from the sheet (assuming headers in row 1)
  var data = sheet.getDataRange().getValues();
  
  // Applicant details
  var applicantName = "Shubham Gour"; // Replace with your name
  var applicantEmail = Session.getActiveUser().getEmail(); // Gets the email of the logged-in user
  var resumeFileId = "YOUR_RESUME_FILE_ID"; // Replace with your Google Drive resume PDF file ID
  
  // Get the resume file from Google Drive
  var resumeFile;
  try {
    resumeFile = DriveApp.getFileById(resumeFileId);
  } catch (e) {
    Logger.log("Error accessing resume file: " + e);
    return; // Exit if resume file is not accessible
  }
  
  // Email template
  function createEmailTemplate(companyName, jobDesignation) {
    var subject = "Application for " + jobDesignation + " Position at " + companyName;
    var body = "Dear Hiring Manager,\n\n" +
               "I hope this email finds you well. I am writing to express my interest in the " +
               jobDesignation + " position at " + companyName + ". With my skills and experience, " +
               "I am confident in my ability to contribute to your team.\n\n" +
               "Please find my resume attached for your review. I would welcome the opportunity " +
               "to discuss how my qualifications align with your needs.\n\n" +
               "Thank you for considering my application. I look forward to the possibility of " +
               "contributing to " + companyName + ".\n\n" +
               "Best regards,\n" + applicantName;
    return {subject: subject, body: body};
  }
  
  // Loop through rows (skip header row)
  for (var i = 1; i < data.length; i++) {
    var row = data[i];
    var companyName = row[0]; // Name of the Comany (Column A)
    var jobDesignation = row[1]; // Job Desgination (Column B)
    var hrEmail = row[2]; // HR Email (Column C)
    var emailSentStatus = row[3]; // Email Sent Status (Column D)
    
    // Check if email has already been sent (green checkmark present)
    if (emailSentStatus === "✔") {
      Logger.log("Email already sent for row " + (i + 1) + ": " + hrEmail);
      continue; // Skip to the next row
    }
    
    // Validate email
    if (hrEmail && hrEmail.includes("@")) {
      try {
        var emailContent = createEmailTemplate(companyName, jobDesignation);
        
        // Send email with resume attachment
        GmailApp.sendEmail(
          hrEmail,
          emailContent.subject,
          emailContent.body,
          {
            from: applicantEmail,
            name: applicantName,
            attachments: [resumeFile.getBlob()]
          }
        );
        
        // Add green checkmark to column D
        sheet.getRange(i + 1, 4).setValue("✔").setFontColor("green");
        Logger.log("Email sent to: " + hrEmail + " with resume and checkmark added in row " + (i + 1));
      } catch (e) {
        Logger.log("Failed to send email to " + hrEmail + " in row " + (i + 1) + ": " + e);
      }
    } else {
      Logger.log("Invalid or missing email in row " + (i + 1) + ": " + hrEmail);
    }
  }
}
