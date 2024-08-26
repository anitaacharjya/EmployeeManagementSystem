package com.pcs.employee.controller;

import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.UnitValue;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Image;
import com.itextpdf.io.image.ImageData;
import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.borders.Border;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.Locale;

@WebServlet("/downloadPayslip")
public class PayslipDownloadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Retrieve payslip details
        String employeeName = request.getParameter("name");
        String employeeId = request.getParameter("employeeId");
        String department = request.getParameter("department");
        String paymentDate = request.getParameter("paymentDate");
        double basicSalary = Double.parseDouble(request.getParameter("basicSalary"));
        double hra = Double.parseDouble(request.getParameter("hra"));
        double allowances = Double.parseDouble(request.getParameter("allowances"));
        double deductions = Double.parseDouble(request.getParameter("deductions"));
        double netSalary = basicSalary + hra + allowances - deductions;

        // Set response to PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=payslip.pdf");

        // Create PDF document
        PdfWriter writer = new PdfWriter(response.getOutputStream());
        PdfDocument pdfDoc = new PdfDocument(writer);
        Document document = new Document(pdfDoc);

        // Add company information with styling
        Paragraph companyName = new Paragraph("Perennation Computer Solutions Global Private Limited")
                .setBold().setFontSize(16).setTextAlignment(TextAlignment.CENTER);
        document.add(companyName);

        document.add(new Paragraph("Kolkata: ZIOKS, 11th, Godrej Genesis Building, EP Block, Sector V, Bidhannagar, Kolkata, West Bengal 700091")
                .setFontSize(10).setTextAlignment(TextAlignment.CENTER));
        document.add(new Paragraph("Bengaluru: 57/65, Chikkalakshmaiah Layout, Hosur main road, Bengaluru, Karnataka 560029")
                .setFontSize(10).setTextAlignment(TextAlignment.CENTER));
        document.add(new Paragraph("Website: www.pcsglobal.in")
                .setFontSize(10).setTextAlignment(TextAlignment.CENTER));

        // Add payslip title
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        LocalDate paymentDatestr = LocalDate.parse(paymentDate,formatter); // Parse the string into a LocalDate object

     // Extract the month and year
     String month = paymentDatestr.getMonth().getDisplayName(TextStyle.FULL, Locale.ENGLISH); // e.g., "July"
     int year = paymentDatestr.getYear(); // e.g., 2024

     // Generate the payslip title dynamically
     String payslipTitle = "Pay Slip for the Month of " + month + ", " + year;

     // Add the title to the document
     document.add(new Paragraph(payslipTitle).setBold().setFontSize(14).setTextAlignment(TextAlignment.CENTER));

        // Add employee details section with a table
        float[] columnWidths = {1, 2}; // Adjust as per your layout
        Table employeeTable = new Table(columnWidths);
        employeeTable.setWidth(UnitValue.createPercentValue(100)); // Set table to 100% width

        employeeTable.addCell(new Cell().add(new Paragraph("Employee Name:").setBold()).setBorder(Border.NO_BORDER));
        employeeTable.addCell(new Cell().add(new Paragraph(employeeName)).setBorder(Border.NO_BORDER));
        employeeTable.addCell(new Cell().add(new Paragraph("Employee No:").setBold()).setBorder(Border.NO_BORDER));
        employeeTable.addCell(new Cell().add(new Paragraph(employeeId)).setBorder(Border.NO_BORDER));
        employeeTable.addCell(new Cell().add(new Paragraph("Designation:").setBold()).setBorder(Border.NO_BORDER));
       //employeeTable.addCell(new Cell().add(new Paragraph(designation)).setBorder(Border.NO_BORDER));
        employeeTable.addCell(new Cell().add(new Paragraph("Payment Date:").setBold()).setBorder(Border.NO_BORDER));
        employeeTable.addCell(new Cell().add(new Paragraph(paymentDate)).setBorder(Border.NO_BORDER));
        employeeTable.addCell(new Cell().add(new Paragraph("Bank Name:").setBold()).setBorder(Border.NO_BORDER));
        //employeeTable.addCell(new Cell().add(new Paragraph(bankName)).setBorder(Border.NO_BORDER));
        employeeTable.addCell(new Cell().add(new Paragraph("Account Number:").setBold()).setBorder(Border.NO_BORDER));
        //employeeTable.addCell(new Cell().add(new Paragraph(accountNumber)).setBorder(Border.NO_BORDER));
     // Set margins, if needed
        document.setMargins(10, 10, 10, 10);

        // Add the table to the document
        document.add(employeeTable);

        // Add earnings and deductions in a table with styling
        float[] columnWidths1 = {6, 4}; // Define column widths as a proportion
        Table salaryTable = new Table(columnWidths1);

        
        // OR set the width to 100% of the available page width
        salaryTable.setWidth(UnitValue.createPercentValue(100));

        // Table header
        salaryTable.addCell(new Cell().add(new Paragraph("Earnings").setBold()).setBackgroundColor(ColorConstants.LIGHT_GRAY).setTextAlignment(TextAlignment.CENTER));
        salaryTable.addCell(new Cell().add(new Paragraph("Amount (INR)").setBold()).setBackgroundColor(ColorConstants.LIGHT_GRAY).setTextAlignment(TextAlignment.CENTER));

        // Earnings rows
        salaryTable.addCell(new Cell().add(new Paragraph("Basic Salary")));
        salaryTable.addCell(new Cell().add(new Paragraph(String.valueOf(basicSalary))));
        salaryTable.addCell(new Cell().add(new Paragraph("Central Govt NATS Stipend")));
        //salaryTable.addCell(new Cell().add(new Paragraph(String.valueOf(centralGovtStipend))));

        // Deductions row
        salaryTable.addCell(new Cell().add(new Paragraph("Deductions")).setBackgroundColor(ColorConstants.LIGHT_GRAY));
        salaryTable.addCell(new Cell().add(new Paragraph(String.valueOf(deductions))).setBackgroundColor(ColorConstants.LIGHT_GRAY));

        // Net salary row
        salaryTable.addCell(new Cell().add(new Paragraph("Net Salary").setBold()).setBackgroundColor(ColorConstants.LIGHT_GRAY));
        salaryTable.addCell(new Cell().add(new Paragraph(String.valueOf(netSalary)).setBold()).setBackgroundColor(ColorConstants.LIGHT_GRAY));

        // Add table to the document
        document.add(salaryTable);

        // Footer section
        document.add(new Paragraph("This is a computer-generated payslip and does not require a signature.")
                .setTextAlignment(TextAlignment.CENTER).setMarginTop(20));
        document.add(new Paragraph("Company URL: http://www.pcsglobal.in/")
                .setTextAlignment(TextAlignment.CENTER));

        // Close document
        document.close();
    }
}