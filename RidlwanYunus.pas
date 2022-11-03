program RidlwanYunus;

Uses crt, sysutils;

Type
    pItem = ^tItem;     { Pointer yang menyimpan alamat pada record tItem }
    tItem = record      { Record yang memuat attribute attribute pada nota }
                id : integer;
                namaMenu : string[30];
                jumlah : integer;
                jumlahHarga : longint;
                next : pItem;
            end;
var
    head, last, searchedItem : pItem;
    temp : tItem;  
    searchedIndex, searchedField : integer;
    newValue : string[30];
    pilihan : string[1];

{ Fungsi untuk menambah node pada list }
function add(last : pItem; content : tItem): pItem;
var 
    cur : pItem;
begin
    new(cur);       { Mendefinisikan variabel disertai dengan alamat baru }
    cur^.id:=content.id;     { Insialisasi pointer dengan value }
    cur^.namaMenu:=content.namaMenu; { pada temporary record content }
    cur^.jumlah:=content.jumlah;
    cur^.jumlahHarga:=content.jumlahHarga;
    cur^.next:=nil; 
    
    if last<>nil then last^.next:=cur; 
    add:=cur; 
end;

{ Prosedur untuk mengedit salah satu attribute pada node }
procedure update(var head : pItem; updateNode : pItem; index: integer; newValue: string);
var cur : pItem;
begin
    if head=nil then 
        exit;
    
    cur:=updateNode; 
    
    if index=1 then
        cur^.id := strToInt(newValue);  { mengubah nilai pada attribute id }
     
    if index=2 then
        cur^.namaMenu := newValue;      { mengubah nilai pada attribute namaMenu }
     
    if index=3 then
        cur^.jumlah := strToInt(newValue); { mengubah nilai pada attribute jumlah }
    
    if index=4 then
        cur^.jumlahHarga := strToInt(newValue); { mengubah nilai pada attribute jumlahHarga }
end;

{ Prosedur untuk menghapus node berdasarkan node yang ditemukan }
procedure delete(var head : pItem; var tail: pItem; searchedItem : pItem);
var 
    bef, cur, aft : pItem;
begin
    if head=nil then 
        exit;
    
    cur:=searchedItem;  { pointer current = node yang dicari }
    aft:=cur^.next;     { pointer after = current + 1 di depan }
    bef:=head;          { pointer before = pointer head (first node) }
    
    if bef<>cur then    { jika head = node yang dicari }
    begin
        while (bef^.next<>cur) and (bef<>nil) do { loop mulai dari head sampai pointer ditemukan }
        begin   
            
            bef:=bef^.next; { node = node + 1 }
            if (bef^.next= tail) and (cur = tail) then { cek apakah node yang dicari adalah tail (last node) }
            begin   
                tail := bef;    { tail = node sebelum node yang dicari }
            end;
        end;
        bef^.next:=aft;         { 1 node sebelum node yang dicari disambungkan node yang dicari + 1  }
        dispose(cur);           { Hapus node yang dicari  }
    end
    else                { jika head != node yang dicari }
    begin
        dispose(head);  { hapus head }
        head:=aft;      { head = head + 1 node }
    end;
end;

{ Fungsi untuk mencari node berdasarkan id }
function find(head : pItem; id: integer):pItem;
var 
    cur : pItem; 
    found : boolean;
begin
    cur:=head;              { current node = head }
    while cur<>nil do
    begin
        if cur^.id=id then  { cek apakah attribute id pada current node sama dengan id yang dicari }
        begin
            found:=true; break;
        end;
        cur:=cur^.next;     { current node = node + 1 }
    end;

    if found then 
    begin
        find:=cur;          { return current node jika ditemukan }
    end
    else 
        find:=nil;          { return null node jika tidak }
end;

function printFormat(word: string; limit: integer): string;
var
    i, diff: integer;
    wordFormatted: string;
begin
    
    diff := limit - Length(word);   { selisih panjang limit - panjang input kata }
    wordFormatted := word;
    for i:=1 to diff do
    begin
        wordFormatted := wordFormatted + ' '; { isi selisih dengan spasi ' ' }
    end;
    printFormat := wordFormatted;
end;

procedure display(head : pItem);
var 
    cur : pItem;
    totalHarga : longint;
begin
    cur:=head;
    totalHarga := 0;
    
    writeln;
    writeln('WARUNG SATE KAMBING');
    writeln('PAK DADI SOLO');
    writeln('-------------------------------------------------');
    writeln(printFormat('No',4), printFormat('Sedia',20), printFormat('Porsi',10), printFormat('Jumlah Harga',12));
    writeln('-------------------------------------------------');
    while cur<>nil do
    begin
        writeln(printFormat(intToStr(cur^.id),4), printFormat(cur^.namaMenu,20), printFormat(intToStr(cur^.jumlah),10), printFormat(intToStr(cur^.jumlahHarga),12));
        totalHarga := totalHarga + cur^.jumlahHarga;
        
        cur:=cur^.next;
    end;
    writeln('-------------------------------------------------');
    writeln(printFormat('Total Harga',15), printFormat(' ',19), printFormat(intToStr(totalHarga),12));
end;

begin
  head:=nil; 
  last:=nil;
  searchedItem := nil;
  
  display(head);
  
  repeat
    writeln(printFormat('(v): Lihat',15),printFormat('(a): Tambah',15),printFormat('(e): Edit',15),printFormat('(d): Hapus', 15), printFormat('(x): Keluar', 15));
    write('Pilihan: '); readln(pilihan);

    if pilihan = 'x' then       { Exit }
    begin
        break;
    end
    else if pilihan = 'v' then  { View }
    begin
        display(head);
    end
    else if pilihan = 'a' then  { Add }
    begin
        write(printFormat('id',15),': '); readln(temp.id);
        write(printFormat('Nama',15),': '); readln(temp.namaMenu);
        write(printFormat('Jumlah',15),': '); readln(temp.jumlah);
        write(printFormat('Jumlah Harga',15),': '); readln(temp.jumlahHarga);
        last:=add(last,temp);
        if head=nil then head:=last;
        display(head);
    end
    else if pilihan = 'e' then  { Edit }
    begin
        write('Edit Node: '); readln(searchedIndex);
        searchedItem := find(head, searchedIndex);
        
        
        writeln(printFormat('Daftar Index',15));
        writeln(printFormat('(1) No',15));
        writeln(printFormat('(2) Sedia',15));
        writeln(printFormat('(3) Porsi',15));
        writeln(printFormat('(4) Jumlah Harga',15));
        write('Index: '); readln(searchedField);
        
        write('New value: '); readln(newValue);
        update(head, searchedItem, searchedField, newValue);
        display(head);
    end
    else if pilihan = 'd' then  { Delete }
    begin
        write('Delete Node: '); readln(searchedIndex);
        searchedItem := find(head, searchedIndex);
        delete(head, last, searchedItem);
        display(head);
    end;
  until false;
end.