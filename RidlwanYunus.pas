{

                            Online Pascal Compiler.
                Code, Compile, Run and Debug Pascal program online.
Write your code in this editor and press "Run" button to execute it.

}


program RidlwanYunus;

Uses crt, sysutils;

Type
    pItem = ^tItem;
    tItem = record
                id      : integer;
                namaMenu    : string[30];
                jumlah  : integer;
                jumlahHarga  : longint;
                next    : pItem;
            end;
var
    head, last, searchedItem  : pItem;
    temp  : tItem;  
    searchedIndex, searchedField  : integer;
    newValue : string[30];
    pilihan   : integer;

function add(last : pItem; content : tItem): pItem;
var 
    cur : pItem;
begin
    new(cur);
    cur^.id:=content.id;
    cur^.namaMenu:=content.namaMenu;
    cur^.jumlah:=content.jumlah;
    cur^.jumlahHarga:=content.jumlahHarga;
    cur^.next:=nil; 
    if last<>nil then last^.next:=cur; 
    add:=cur; 
end;

procedure update(var head : pItem; updateNode : pItem; index: integer; newValue: string);
var cur : pItem;
begin
    if head=nil then 
        exit;
    
    cur:=updateNode; 
    
    if index=1 then
        cur^.id := strToInt(newValue);
     
    if index=2 then
        cur^.namaMenu := newValue;
     
    if index=3 then
        cur^.jumlah := strToInt(newValue);
    
    if index=4 then
        cur^.jumlahHarga := strToInt(newValue);
end;

procedure delete(var head : pItem; var tail: pItem; searchedItem : pItem);
var 
    bef, cur, aft : pItem;
begin
    if head=nil then 
        exit;
    
    cur:=searchedItem; 
    aft:=cur^.next;
    bef:=head;
    
    if bef<>cur then
    begin
        while (bef^.next<>cur) and (bef<>nil) do 
        begin   
            
            bef:=bef^.next;
            if (bef^.next= tail) and (cur = tail) then
            begin
                tail := bef;
            end;
        end;
        bef^.next:=aft;
        dispose(cur);
    end
    else
    begin
        dispose(head); 
        head:=aft;
    end;
end;

function find(head : pItem; id: integer):pItem;
var 
    cur : pItem; 
    found : boolean;
begin
    writeln('you searched: ', id);
    cur:=head;
    while cur<>nil do
    begin
        writeln(cur^.id);
        if cur^.id=id then
        begin
            found:=true; break;
        end;
        cur:=cur^.next;
    end;

    if found then 
    begin
        find:=cur;
    end
    else 
        find:=nil;
end;

function printFormat(word: string; limit: integer): string;
var
    i, diff: integer;
    wordFormatted: string;
begin
    
    diff := limit - Length(word);
    wordFormatted := word;
    for i:=1 to diff do
    begin
        wordFormatted := wordFormatted + ' ';
    end;
    printFormat := wordFormatted;
end;

procedure display(head : pItem);
var 
    cur : pItem;
begin
    cur:=head;
    writeln('----------------------------------------------');
    writeln(printFormat('No',4), printFormat('Sedia',20), printFormat('Porsi',10), printFormat('Jumlah Harga',12));
    writeln('----------------------------------------------');
    while cur<>nil do
    begin
        writeln(printFormat(intToStr(cur^.id),4), printFormat(cur^.namaMenu,20), printFormat(intToStr(cur^.jumlah),10), printFormat(intToStr(cur^.jumlahHarga),12));
        cur:=cur^.next;
    end;
    writeln('----------------------------------------------');
end;

begin
  head:=nil; 
  last:=nil;
  searchedItem := nil;
  
  repeat
    writeln('1: Lihat'#9'2: Tambah'#9'3: Ubah'#9'4: Hapus'#9'0: Keluar');
    write('Pilihan: '); readln(pilihan);

    if pilihan = 0 then
    begin
        break;
    end
    else if pilihan = 1 then
    begin
        display(head);
    end
    else if pilihan = 2 then
    begin
        write('id'#9': '); readln(temp.id);
        write('Nama'#9': '); readln(temp.namaMenu);
        write('Jumlah'#9': '); readln(temp.jumlah);
        write('Harga'#9': '); readln(temp.jumlahHarga);
        last:=add(last,temp);
        if head=nil then head:=last;
        display(head);
    end
    else if pilihan = 3 then
    begin
        write('Edit Node: '); readln(searchedIndex);
        searchedItem := find(head, searchedIndex);
        write('Index: '); readln(searchedField);
        write('New value: '); readln(newValue);
        update(head, searchedItem, searchedField, newValue);
        display(head);
    end
    else if pilihan = 4 then
    begin
        write('Delete Node: '); readln(searchedIndex);
        searchedItem := find(head, searchedIndex);
        delete(head, last, searchedItem);
        display(head);
    end;
  until false;
end.