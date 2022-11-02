{

                            Online Pascal Compiler.
                Code, Compile, Run and Debug Pascal program online.
Write your code in this editor and press "Run" button to execute it.

}


program RidlwanYunus;
Uses crt;
Type
  pItem = ^tItem;
  tItem = record
               name    : string[30];
               address : string[40];
               next    : pItem;
             end;
var
  head, last, searchedItem : pItem;
  temp       : tItem;  
  searchedName      : string[30];
  pilihan   : integer;


function add(last : pItem; content : tItem):pItem;
var 
    cur : pItem;
    y : ^word;
begin
  new(cur);
  cur^.name:=content.name;
  cur^.address:=content.address;
  cur^.next:=nil;

  if last<>nil then last^.next:=cur; 
  add:=cur; 
end;

procedure update(var head : pItem; updateNode : pItem; index: integer; newValue: string);
var bef, cur, aft : pItem;
begin
    if head=nil then 
        exit;
    
    cur:=updateNode; 
    
    if index=1 then
        cur^.name := newValue;
    
    if index=2 then
        cur^.address := newValue;
    

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

function find(head : pItem; name: string):pItem;
var 
    cur : pItem; 
    found : boolean;
begin
    writeln('you searched: ', name);
    cur:=head;
    while cur<>nil do
    begin
        writeln(cur^.name);
        if cur^.name=name then
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

procedure display(head : pItem);
var cur : pItem;
begin
  cur:=head;
  while cur<>nil do
  begin
    writeln(cur^.name:35,cur^.address);
    cur:=cur^.next;
  end;
end;

begin
  head:=nil; last:=nil;
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
        write('Name     : '); readln(temp.name);
        write('Address  : '); readln(temp.address);
        last:=add(last,temp);
        if head=nil then head:=last;
        display(head);
    end
    else if pilihan = 3 then
    begin
        write('Edit Node: '); readln(searchedName);
        searchedItem := find(head, searchedName);
        update(head, searchedItem, 1, 'xxx');
        display(head);
    end
    else if pilihan = 4 then
    begin
        write('Delete Node: '); readln(searchedName);
        searchedItem := find(head, searchedName);
        delete(head, last, searchedItem);
        display(head);
    end;
  until false;
end.