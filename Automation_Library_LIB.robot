%%writefile alp_sqa_reserve.robot
*** Settings ***
Library            SeleniumLibrary
Library            String
Suite Setup        Open Browser And Login
Suite Teardown     Close All Browsers

*** Variables ***
${BROWSER}         Chrome
${USERNAME}        User
${PASSWORD}        Pw
${BASE_URL}        https://trial.uc.ac.id/
${HOME_URL}        https://trial.uc.ac.id/home
${CATALOG_URL}     https://trial.uc.ac.id/library_catalogl/index
${BASKET_URL}      https://trial.uc.ac.id/library_catalogl/basket
${REQ_FORM_URL}    https://trial.uc.ac.id/library_req_collection/form
${REQ_DATA_URL}    https://trial.uc.ac.id/library_req_collection/data

# --- LOCATORS ---
${LOC_USER}            name=username
${LOC_PASS}            name=password
${BTN_LOGIN}           xpath=//button[contains(text(),'Sign In')]

*** Test Cases ***

TC-1.01 & TC-1.02: Akses Navigasi Menu Catalog
    [Documentation]    Buka Online Catalog dan ganti parameter Location.
    # 1. Buka Online Catalog melalui Hamburger Menu
    Wait Until Page Contains Element    xpath=//button[@data-bs-target='#mainmenu-modal']    timeout=10s
    Safe Click    xpath=//button[@data-bs-target='#mainmenu-modal']
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'My Activity')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'Library')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'Online Catalog')]
    Sleep    3s
    
    # 2. Ganti location ke Universitas Ciputra Surabaya
    Wait Until Page Contains Element    xpath=(//select[contains(@class,'_value')])[1]    timeout=10s
    Select From List By Label           xpath=(//select[contains(@class,'_value')])[1]    Universitas Ciputra Surabaya
    Sleep    1s
    
    # 3. Tekan tombol search
    Safe Click    id=search
    Sleep    2s

TC-1.03: Pencarian Spesifik Kata Kunci 'Tech'
    [Documentation]    Lakukan pencarian spesifik di textbox Title.
    # 4. Isi title buku dengan 'Tech'
    Input Text    xpath=//input[contains(@class,'reqOpt')]    Tech
    Sleep    1s
    
    # 5. Klik 'Search'
    Safe Click    id=search
    Sleep    3s

TC-1.05: Pengujian Multi-Filter Kombinasi Beriringan
    [Documentation]    Tambahkan lebih dari 2 filter kombinasi.
    # 6. Add filter
    Safe Click    id=filter
    Wait Until Page Contains Element    xpath=(//select[contains(@name,'category')])[last()]    timeout=5s
    Sleep    1s
    
    # 7. Pilih kategori 'Author'
    Select From List By Value    xpath=(//select[contains(@name,'category')])[last()]    author
    Sleep    1s
    
    # 8. Input 'Powell' di bagian 'Author'
    Input Text    xpath=(//input[contains(@class,'_value')])[last()]    Powell
    Sleep    1s
    
    # 9. Klik 'Search'
    Safe Click    id=search
    Sleep    3s

TC-1.09: Verifikasi Pop-Up Detail Availability & Reasoning
    [Documentation]    Klik status Availability (Available/Not Available).
    # 10. Tekan link 'not available' pada buku berjudul 'Advanced Marker Technique...'
    Scroll Element Into View    xpath=//tr[contains(., 'Advanced Marker Technique')]
    Sleep    0.5s
    Run Keyword And Ignore Error    Safe Click    xpath=//tr[contains(., 'Advanced Marker Technique')]//a[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'not available')]
    Sleep    2s
    
    # 11. Klik 'Close' pada pop up
    Close Modal Popup

TC-1.07: Reset Seluruh Parameter Kembali ke Kondisi Bawaan
    [Documentation]    Tekan tombol Clear Filter.
    # 12. Hapus filter
    Safe Click    id=clear
    Sleep    1s
    
    # 13. Klik 'Search'
    Safe Click    id=search
    Sleep    3s
    
    # 14. Add filter
    Safe Click    id=filter
    Sleep    1s
    
    # 15. Set filter ke Publish year
    Select From List By Value    xpath=(//select[contains(@name,'category')])[last()]    a.publish_year
    Sleep    1s
    
    # 16. Input 2010
    Input Text    xpath=(//input[contains(@class,'_value')])[last()]    2010
    Sleep    1s
    
    # 17. Klik 'Search'
    Safe Click    id=search
    Sleep    3s
    
    # 18. Add filter
    Safe Click    id=filter
    Sleep    1s
    
    # 19. Set filter ke Author
    Select From List By Value    xpath=(//select[contains(@name,'category')])[last()]    author
    Sleep    1s
    
    # 20. Input Chan
    Input Text    xpath=(//input[contains(@class,'_value')])[last()]    Chan
    Sleep    1s
    
    # 21. Klik 'Search'
    Safe Click    id=search
    Sleep    3s
    
    # 22. Klik availability yang Available
    Run Keyword And Ignore Error    Safe Click    xpath=(//a[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'available') and not(contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'not'))])[1]
    Sleep    2s
    
    # 23. Close popup
    Close Modal Popup
    
    # 24. Kosongkan title
    Clear Element Text    xpath=//input[contains(@class,'reqOpt')]
    Sleep    1s
    
    # 25. Klik 'Search'
    Safe Click    id=search
    Sleep    3s
    
    # 26. Clear filter
    Safe Click    id=clear
    Sleep    1s
    
    # 27. Input title Tech
    Input Text    xpath=//input[contains(@class,'reqOpt')]    Tech
    Sleep    1s
    
    # 28. Klik 'Search'
    Safe Click    id=search
    Sleep    3s

TC-2.01: State Management Checkbox Buku Lintas Halaman
    [Documentation]    Ceklis beberapa checkbox buku di halaman berbeda lalu Add to Basket.
    # 29. Scroll ke paling bawah
    Scroll To Bottom
    
    # 30. Centang buku 'Advanced Facilitation Strategies'
    Tick Book    Advanced Facilitation Strategies
    Sleep    0.5s
    
    # 31. Centang buku 'Advanced Underwater Photography'
    Tick Book    Advanced Underwater Photography
    Sleep    0.5s
    
    # 32. Scroll & Tekan tombol add to basket
    Scroll Element Into View    id=btn_add_basket
    Sleep    0.5s
    Safe Click    id=btn_add_basket
    Sleep    2s
    
    # 33. Menutup pop-up alert Add to Basket
    Close Modal Popup
    
    # 34. Pergi ke My Reservation Basket melalui Hamburger Menu
    Go To    ${HOME_URL}
    Sleep    2s
    Safe Click    xpath=//button[@data-bs-target='#mainmenu-modal']
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'My Activity')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'Library')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'My Reservation Basket')]
    Sleep    3s
    
    # 35. Memastikan KEDUA buku masuk Basket Loan List
    Run Keyword And Continue On Failure    Page Should Contain    Advanced Facilitation Strategies
    Run Keyword And Continue On Failure    Page Should Contain    Advanced Underwater Photography

TC-1.08: Pengujian Fungsionalitas Dropdown Pagination Tabel
    [Documentation]    Ubah dropdown Pagination.
    # 36. Balik ke Online Catalog melalui Hamburger Menu
    Go To    ${HOME_URL}
    Sleep    2s
    Safe Click    xpath=//button[@data-bs-target='#mainmenu-modal']
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'My Activity')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'Library')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'Online Catalog')]
    Sleep    3s
    
    # 37. Pilih KEMBALI Location agar tidak hilang, lalu isi 'Tech'
    Wait Until Page Contains Element    xpath=(//select[contains(@class,'_value')])[1]    timeout=5s
    Select From List By Label           xpath=(//select[contains(@class,'_value')])[1]    Universitas Ciputra Surabaya
    Sleep    1s
    Input Text    xpath=//input[contains(@class,'reqOpt')]    Tech
    Sleep    1s
    
    # 38. Klik Search
    Safe Click    id=search
    Sleep    3s
    
    # 39. Ubah pagination ke 25
    Wait Until Page Contains Element    xpath=//select[contains(@name,'length')]    timeout=5s
    Select From List By Value    xpath=//select[contains(@name,'length')]    25
    Sleep    3s
    Scroll To Top
    
    # 40. Ubah pagination ke 50
    Select From List By Value    xpath=//select[contains(@name,'length')]    50
    Sleep    3s
    Scroll To Top

TC-2.05: Pengujian Fitur Overwrite State Keranjang via 'Delete Previous Basket'
    [Documentation]    Ceklis "Delete Previous Basket" lalu lakukan penambahan buku baru.
    # 41. Scroll paling bawah
    Scroll To Bottom
    
    # 42. Scroll & Tekan 'Asking Librarian'
    Scroll Element Into View    id=btn_asking
    Sleep    0.5s
    Safe Click    id=btn_asking
    Sleep    2s
    
    # 43. Tutup tab Whatsapp
    ${handles}=    Get Window Handles
    ${count}=    Get Length    ${handles}
    Run Keyword If    ${count} > 1    Close Tab And Return
    
    # 44. Centang buku '1000 Product Designs'
    Tick Book    1000 Product Designs
    Sleep    0.5s
    
    # 45. Centang buku '150 Projects To Strengthen'
    Tick Book    150 Projects To Strengthen
    Sleep    0.5s
    
    # 46. Scroll & Tekan link view collection judul Agritech LENGKAP
    Scroll Element Into View    xpath=//tr[contains(., 'Agritech : Jurnal Teknologi Pertanian : Vol 45, No 2 (2025)')]
    Sleep    0.5s
    Run Keyword And Ignore Error    Safe Click    xpath=//tr[contains(., 'Agritech: Jurnal Teknologi Pertanian: Vol 45, No 2 (2025)')]//a[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'view collection')]
    Sleep    3s
    
    # 47. Tutup tab Agritech
    ${handles2}=    Get Window Handles
    ${count2}=    Get Length    ${handles2}
    Run Keyword If    ${count2} > 1    Close Tab And Return
    
    # 48. Pindah page 3
    Go To Page    3
    
    # 49. Centang buku 'Creating a Learning Culture'
    Tick Book    Creating a Learning Culture
    Sleep    0.5s
    
    # 50. Centang buku 'Competitive Strategy'
    Tick Book    Competitive Strategy
    Sleep    0.5s
    
    # 51. Centang buku 'Competence-based'
    Tick Book    Competence-based Assessment
    Sleep    0.5s
    
    # 52. Scroll & Centang delete previous basket
    Scroll Element Into View    id=ch_delete_basket
    Sleep    0.5s
    Safe Click    id=ch_delete_basket
    
    # 53. Scroll & Add to basket
    Scroll Element Into View    id=btn_add_basket
    Sleep    0.5s
    Safe Click    id=btn_add_basket
    Sleep    2s
    
    # 54. Menutup pop-up alert
    Close Modal Popup

TC-2.04: Validasi Deteksi Duplikasi Buku di dalam Keranjang (Basket)
    [Documentation]    Tambahkan buku yang sudah persis ada di dalam Basket untuk memicu alert duplikasi.
    # 55. Pindah page 2
    Go To Page    2
    
    # 56. Centang buku 'Baking Technology'
    Tick Book    Baking Technology and Nutrition : towards a healthier world
    
    # 57. Centang buku 'Bancroft'
    Tick Book    Bancroft's Theory and Practice of Histological Techniques
    
    # 58. Centang buku 'Basic of Dental'
    Tick Book    Basic of Dental Technology : a step by step approach
    
    # 59. Centang buku 'Basic Technical Drawing'
    Tick Book    Basic Technical Drawing
    
    # 60. Centang buku 'Batik'
    Tick Book    Batik : modern concepts and techniques
    
    # 61. Centang buku 'Beverages'
    Tick Book    Beverages : processing & technology
    
    # 62. Centang buku 'Be a Startup Superstar'
    Tick Book    Be a Startup Superstar : ignite your career working at a tech startup
    
    # 63. Centang buku 'Big Book Of Drawing'
    Tick Book    Big Book Of Drawing, The : the history, study, materials, techniques, subjects, theory, and practice of artistic drawing
    
    # 64. Centang buku 'Book Art Studio'
    Tick Book    Book Art Studio Handbook : techniques and methods for binding books, creating albums, making boxes and more
    
    # 65. Centang buku 'Capitalist'
    Tick Book    Capitalist Imperative, The : territory, technology, and industrial growth
    
    # 66. Centang buku 'Color Knitting'
    Tick Book    Color Knitting with Confidence : unlock the secrets of fair isle, intarsia, and more with 30 vibrant colorwork techniques
    
    # 67. UNCHECK delete previous basket
    Uncheck Delete Basket
    
    # 68. Scroll & Add to basket
    Safe Click    id=btn_add_basket
    Sleep    2s
    
    # 69. Menutup pop-up alert
    Close Modal Popup
    
    # 70. Centang buku duplikat
    Tick Book    Baking Technology and Nutrition : towards a healthier world
    Sleep    0.5s
    
    # 71. Centang buku duplikat
    Tick Book    Bancroft's Theory and Practice of Histological Techniques
    Sleep    0.5s
    
    # 72. UNCHECK delete previous basket
    Uncheck Delete Basket
    
    # 73. Scroll & Add to basket (Duplikat)
    Safe Click    id=btn_add_basket
    Sleep    2s
    
    # 74. Menutup pop-up alert
    Close Modal Popup
    
    # 75. Tambah buku penutup modul Basket
    Tick Book    Baking Technology and Nutrition : towards a healthier world
    Sleep    0.5s
    
    # 76. Centang penutup kedua
    Tick Book    Bancroft's Theory and Practice of Histological Techniques
    Sleep    0.5s
    
    # 77. Centang buku 'CommIT: Communication'
    Tick Book    CommIT : Communication
    Sleep    0.5s
    
    # 78. UNCHECK delete previous basket
    Uncheck Delete Basket
    
    # 79. Scroll & Add to basket
    Safe Click    id=btn_add_basket
    Sleep    2s
    
    # 80. Menutup pop-up alert
    Close Modal Popup

TC-3.02: Negatif Pengujian Field Mandatory Kosong (Freeze Handling)
    [Documentation]    Kosongkan field mandatory, lalu klik Submit.
    # 81. Masuk ke My Reservation Basket via Hamburger
    Go To    ${HOME_URL}
    Sleep    2s
    Safe Click    xpath=//button[@data-bs-target='#mainmenu-modal']
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'My Activity')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'Library')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'My Reservation Basket')]
    Sleep    3s
    Execute Javascript    window.scrollTo({top: document.body.scrollHeight, behavior: 'smooth'});
    Sleep    4s
    Execute Javascript    window.scrollTo({top: 0, behavior: 'smooth'});
    Sleep    2s
    
    # 82. Kembali ke Online Catalog via Hamburger
    Go To    ${HOME_URL}
    Sleep    2s
    Safe Click    xpath=//button[@data-bs-target='#mainmenu-modal']
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'My Activity')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'Library')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'Online Catalog')]
    Sleep    3s
    
    # 83. Memilih location Universitas Ciputra Surabaya
    Wait Until Page Contains Element    xpath=(//select[contains(@class,'_value')])[1]
    Select From List By Label           xpath=(//select[contains(@class,'_value')])[1]    Universitas Ciputra Surabaya
    Sleep    1s
    
    # 84. Isi title 'SSS'
    Input Text       xpath=//input[contains(@class,'reqOpt')]    SSS
    Sleep    1s
    
    # 85. Klik Search
    Safe Click    id=search
    Sleep    3s
    
    # 86. Scroll & Tekan tombol Request Collection
    Scroll Element Into View    id=btn_req_collection
    Sleep    0.5s
    Safe Click    id=btn_req_collection
    Sleep    3s
    
    # 87. Pindah fokus ke tab baru (Formulir Request)
    ${handles_form}=    Get Window Handles
    Switch Window    ${handles_form}[-1]
    
    # 88. Tunggu form muncul di tab baru
    Wait Until Page Contains Element    id=title    timeout=20s
    
    # 89. Set Collection Type
    Execute Javascript    $('#collection_type').val('H').trigger('change');
    Sleep    1s
    
    # 90. Isi form awal (tahun kosong)
    Execute Javascript    document.getElementById('title').value = "SSS";
    Execute Javascript    document.getElementById('author').value = "BearBrand";
    Execute Javascript    document.getElementById('publisher').value = "UC";
    Execute Javascript    document.getElementById('isbn').value = "111-123";
    Execute Javascript    document.getElementById('edition').value = "1";
    Execute Javascript    document.getElementById('year').value = "";
    Sleep    1s
    
    # 91. Scroll & Tekan tombol 'Submit Data'
    Scroll Element Into View    id=btn_submit
    Sleep    0.5s
    Safe Click    id=btn_submit
    
    # 92. Tunggu simulasi bug stuck "Please Wait"
    Sleep    5s
    
    # 93. Refresh halaman di tab yang SAMA
    Reload Page
    Wait Until Page Contains Element    id=title    timeout=20s
    Sleep    3s

TC-3.01: Pengisian Valid Formulir Request Collection
    [Documentation]    Isi seluruh teks dengan valid, tekan Submit.
    # 94. Isi form lengkap
    Execute Javascript    $('#collection_type').val('H').trigger('change');
    Execute Javascript    document.getElementById('title').value = "SSS";
    Execute Javascript    document.getElementById('author').value = "BearBrand";
    Execute Javascript    document.getElementById('publisher').value = "UC";
    Execute Javascript    document.getElementById('isbn').value = "111-123";
    Execute Javascript    document.getElementById('edition').value = "1";
    Execute Javascript    document.getElementById('year').value = "2026";
    Sleep    1s
    
    # 95. Scroll & Submit data kedua (SUKSES)
    Scroll Element Into View    id=btn_submit
    Sleep    0.5s
    Safe Click    id=btn_submit
    Run Keyword And Ignore Error    Wait Until Page Contains    Successfully Saved    timeout=10s
    
    # 96. Menutup Popup Sukses
    Close Modal Popup
    Sleep    2s

TC-3.03: Edge Case Duplikasi Pengajuan Buku yang Sudah Ada
    [Documentation]    Ajukan Request menggunakan Judul dan ISBN yang statusnya terdaftar secara aktif.
    # 97. Pengujian Negatif Database Validation
    Execute Javascript    $('#collection_type').val('H').trigger('change');
    Execute Javascript    document.getElementById('title').value = "SSS";
    Execute Javascript    document.getElementById('author').value = "BearBrand";
    Execute Javascript    document.getElementById('publisher').value = "UC";
    Execute Javascript    document.getElementById('isbn').value = "111-123";
    Execute Javascript    document.getElementById('edition').value = "1";
    Execute Javascript    document.getElementById('year').value = "2026";
    Sleep    1s
    Scroll Element Into View    id=btn_submit
    Sleep    0.5s
    Safe Click    id=btn_submit
    Sleep    3s

TC-3.04: Validasi Entri Data Melalui Pencarian di Sub-Menu Data
    [Documentation]    Buka sub-menu Data di Library Req Collection untuk memverifikasi entri.
    # 98. Kembali ke Dashboard
    Go To    ${HOME_URL}
    Sleep    2s
    
    # 99. Buka Request Collection Data via Hamburger Menu
    Wait Until Page Contains Element    xpath=//button[@data-bs-target='#mainmenu-modal']    timeout=10s
    Safe Click    xpath=//button[@data-bs-target='#mainmenu-modal']
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'My Activity')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'Library')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'Library Req Collection')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'Data') and contains(@href, 'library_req_collection/data')]
    Sleep    3s
    
    # 100. Mencari 'BBB' di tabel Data
    Wait Until Element Is Visible    xpath=//input[@type='search']    timeout=5s
    Input Text       xpath=//input[@type='search']    SSS
    Sleep    2s
    
    # 101. Verifikasi 'BBB' muncul di tabel
    Run Keyword And Continue On Failure    Page Should Contain    SSS

TC-4.01: Penghapusan Buku dari Keranjang Menggunakan Tombol 'X'
    [Documentation]    Lakukan penghapusan buku (remove) dari Reserve Collection.
    # 102. Kembali ke Dashboard
    Go To    ${HOME_URL}
    Sleep    2s
    Safe Click    xpath=//button[@data-bs-target='#mainmenu-modal']
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'My Activity')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'Library')]
    Sleep    1s
    Safe Click    xpath=//a[contains(normalize-space(), 'My Reservation Basket')]
    Sleep    3s
    
    # 104. Hapus buku 'Be a Startup Superstar' dari Basket Reserve List
    Remove From Basket Reserve List    Be a Startup Superstar

TC-4.03: Verifikasi Agregasi Pemesanan via Tombol 'Reserve'
    [Documentation]    Cek apakah sistem mem-booking semua daftar secara agregat.
    # 105. Scroll & Tekan 'Reserve Collection'
    Scroll Element Into View    id=btn_reserve
    Sleep    1s
    Safe Click    id=btn_reserve
    Sleep    3s

TC-4.02: Pengujian Kerentanan Freeze Fungsionalitas Pasca Reload Parsial
    [Documentation]    Setelah melakukan tindakan simpan, tekan tombol 'X' kembali.
    # 107. Tekan 'Reserve Collection' lagi
    Scroll Element Into View    id=btn_reserve
    Safe Click    id=btn_reserve
    Sleep    4s

TC-4.04: Validasi Kuota Batas Maksimal (Over Limit 5 Buku)
    [Documentation]    Klik Online Booking pada daftar yang berisi lebih dari limit batas.
    # 109. Tekan 'Online Booking' (Tunggu benar-benar siap dan terlihat)
    Wait Until Element Is Visible    id=btn_booking    timeout=10s
    Scroll Element Into View         id=btn_booking
    Sleep    1s
    Execute Javascript    document.getElementById('btn_booking').click();
    Sleep    2s
    
    # 110. Submit kosong (Memicu alert)
    Wait Until Element Is Visible    id=btn_submit    timeout=10s
    Scroll Element Into View         id=btn_submit
    Sleep    1s
    Execute Javascript    document.getElementById('btn_submit').click();
    Sleep    3s
    
    # 111. Tutup Paksa Modal Alert Merah
    Force Close Modal

    Scroll Element Into View    id=btn_booking
    Sleep    1s
    Safe Click    id=btn_booking
    Sleep    2s
    
    # 112. Isi Alamat Dummy
    Wait Until Element Is Visible    id=alamat    timeout=5s
    Input Text    id=alamat          Jalan Dummy
    
    # 113. Isi Telp Dummy
    Input Text    id=no_telepon      08123456789
    Sleep    1s
    
    # 114. Tekan Submit
    Safe Click    id=btn_submit
    Sleep    3s
    
    # 115. Tutup modal hasil submit
    Force Close Modal
    
    # 118. Hapus buku dari Basket Loan List
    Remove From Basket Loan List    Baking Technology and Nutrition
    Sleep    1s
    Remove From Basket Loan List    Bancroft's Theory and Practice
    Sleep    1s
    Remove From Basket Loan List    Basic Technical Drawing
    Sleep    1s

    # 120. Tekan 'Online Booking'
    Scroll Element Into View    id=btn_booking
    Safe Click    id=btn_booking
    Wait Until Element Is Visible    id=alamat    timeout=5s
    Sleep    1s

    Clear Element Text    id=alamat
    Sleep    1s
    Clear Element Text    id=no_telepon
    Sleep    1s

    Force Close Modal
    
    Scroll Element Into View    id=btn_booking
    Sleep    1s
    Safe Click    id=btn_booking
    Sleep    2s

    # 121. Isi Alamat Citraland
    Input Text    id=alamat          Citraland Surabaya
    
    # 122. Isi Telp Citraland
    Input Text    id=no_telepon      081234567890
    Sleep    1s
    
    # 123. Tekan Submit
    Safe Click    id=btn_submit
    Sleep    3s
    
    # 124. Tutup modal sukses
    Force Close Modal
    
    # 125. Tekan 'Online Booking' lagi
    Safe Click    id=btn_booking
    Sleep    2s

TC-5.01 & TC-5.02: Akses History & Pengujian Filter Kolom Search
    [Documentation]    Buka Online Booking History dan lakukan pencarian keyword.
    # 130. Tekan 'Online Booking History'
    Scroll Element Into View    id=btn_view_history
    Safe Click    id=btn_view_history
    Wait Until Page Contains    Online Booking Data    timeout=5s
    Sleep    2s
    
    # 131. Search buku
    Wait Until Element Is Visible    xpath=//div[@id='tbl_view_history_filter']//input    timeout=5s
    Input Text       xpath=//div[@id='tbl_view_history_filter']//input    CommitIT
    Sleep    2s
    
    # 132. Verifikasi & Selesai
    Page Should Contain    Showing 0 to 0 of 0
    Force Close Modal

# TC-5.03: Manipulasi Kolom Navigasi dan Pembersihan Elemen Loan Data
#     [Documentation]    Lakukan navigasi dan observasi error alert.
#     # 133. Remove From Loan Data
#     Remove From Loan Data    CommitIT
#     Sleep    2s

*** Keywords ***
Open Browser And Login
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    ${LOC_USER}    timeout=15s
    Input Text        ${LOC_USER}    ${USERNAME}
    Sleep    1s
    Input Password    ${LOC_PASS}    ${PASSWORD}
    Sleep    1s
    Safe Click        ${BTN_LOGIN}
    Wait Until Page Contains    My Activity    timeout=15s

Safe Click
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    timeout=5s
    ${element}=   Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}
    Sleep    1s

Tick Book
    [Arguments]    ${title}
    ${js_code}=    Set Variable    var title = "${title}"; var rows = document.querySelectorAll('tr'); for(var i=0; i<rows.length; i++) { if(rows[i].innerText.includes(title)) { var cb = rows[i].querySelector('input[type="checkbox"]'); if(cb) { cb.checked = true; cb.dispatchEvent(new Event('change')); } } }
    Execute Javascript    ${js_code}

Remove Book
    [Arguments]    ${title}
    Scroll Element Into View    xpath=//tbody[@id='list_basket2']//tr[contains(., "${title}")]
    Sleep    0.5s
    ${js_code}=    Set Variable    var title = "${title}"; var rows = document.querySelectorAll('#list_basket2 tr'); for(var i=0; i<rows.length; i++) { if(rows[i].innerText.includes(title)) { var btn = rows[i].querySelector('button.btn-red'); if(btn) { btn.click(); } } }
    Execute Javascript    ${js_code}
    Sleep    1s

Remove From Basket Loan List
    [Arguments]    ${title}
    Scroll Element Into View    xpath=//tbody[@id='list_basket2']
    Sleep    0.5s
    Execute Javascript    
    ...    var rows = document.querySelectorAll('#list_basket2 tr');
    ...    for(var i = 0; i < rows.length; i++) {
    ...        if(rows[i].innerText.includes("${title}")) {
    ...            var btn = rows[i].querySelector('button.btn-red');
    ...            if(btn) { btn.click(); break; }
    ...        }
    ...    }
    Sleep    1.5s

Remove From Loan Data
    [Arguments]    ${title}
    Scroll Element Into View    xpath=//tbody[@id='grid_data_body_circulation']//tr[contains(., "${title}")]
    Sleep    0.5s
    ${js_code}=    Set Variable    var title = "${title}"; var rows = document.querySelectorAll('#grid_data_body_circulation tr'); for(var i=0; i<rows.length; i++) { if(rows[i].innerText.includes(title)) { var btn = rows[i].querySelector('button.btn-red, button.btn-danger'); if(btn) { btn.click(); } } }
    Execute Javascript    ${js_code}
    Sleep    1s

Remove From Basket Reserve List
    [Arguments]    ${title}
    Wait Until Page Contains Element    id=list_basket    timeout=10s
    Sleep    1s
    Scroll Element Into View    xpath=//tbody[@id='list_basket']//tr[contains(., "${title}")]
    Sleep    0.5s
    ${js_code}=    Set Variable    var title = "${title}"; var rows = document.querySelectorAll('#list_basket tr'); for(var i=0; i<rows.length; i++) { if(rows[i].innerText.includes(title)) { var btn = rows[i].querySelector('button.btn-red'); if(btn) { btn.click(); break; } } }
    Execute Javascript    ${js_code}
    Sleep    1s

Close Modal Popup
    Sleep    1s
    Run Keyword And Ignore Error    Safe Click    xpath=//div[contains(@class,'modal-header') and contains(@style,'display: block')]//button[@class='close']
    Run Keyword And Ignore Error    Execute Javascript    var xs = document.querySelectorAll('button.close, span[aria-hidden="true"]'); for(let i=0; i<xs.length; i++) { if(xs[i].innerText.includes('×') && xs[i].offsetWidth > 0) { xs[i].click(); break; } }
    Sleep    1s
    Run Keyword And Ignore Error    Handle Alert    action=ACCEPT    timeout=1s

Uncheck Delete Basket
    ${is_checked}=    Run Keyword And Return Status    Checkbox Should Be Selected    id=ch_delete_basket
    Run Keyword If    '${is_checked}'=='True'    Execute Javascript    document.getElementById('ch_delete_basket').click();

Go To Page
    [Arguments]    ${page_number}
    ${locator}=    Set Variable    xpath=//a[contains(@class, 'paginate_button') and text()='${page_number}']
    Run Keyword And Ignore Error    Safe Click    ${locator}
    Sleep    3s
    Scroll To Top

Scroll To Bottom
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    1s

Scroll To Top
    Execute Javascript    window.scrollTo(0, 0)
    Sleep    1s

Close Tab And Return
    Switch Window    NEW
    Close Window
    Switch Window    MAIN
    Sleep    1s

Force Close Modal
    Execute Javascript    $('.modal').modal('hide'); $('.modal-backdrop').remove(); $('body').removeClass('modal-open');
    Sleep    1s