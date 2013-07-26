class HomeController < ApplicationController
  def to_pdf_images
    html = render_to_string(:action => "html_with_images.html.haml", :layout => 'custom')
    kit = PDFKit.new(html)
    #add css
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/application.css"
    # generate pdf file
    file = kit.to_file("#{Rails.root}/tmp/certificate.pdf")
    # get path of generated pdf file
    logger.info "#{file.path}"
    #send file to user on action end
    send_data(kit.to_pdf, :filename => 'test_report_with_images.pdf', :type => 'application/pdf') 
  end

  def to_pdf_table
    html = render_to_string(:action => "html_with_table.html.haml", :layout => false)
    kit = PDFKit.new(html)
    send_data(kit.to_pdf, :filename => 'test_report_with_table.pdf', :type => 'application/pdf')
  end

  def generate_certificate
    html = render_to_string(:action => "certificate.html.erb", :layout => 'custom')
    kit = PDFKit.new(html)
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/application.css"
    send_data(kit.to_pdf, :filename => 'certificate.pdf', :type => 'application/pdf')
  end  
end
