{

                            Online Pascal Compiler.
                Code, Compile, Run and Debug Pascal program online.
Write your code in this editor and press "Run" button to execute it.

}


program Hello;
Uses crt;
Type
  pMyqueue = ^tMyqueue;
  tMyqueue = record
               name    : string[30];
               address : string[40];
               next    : pMyqueue;
             end;
var
  head, last, whattodel : pMyqueue;
  temp       : tMyqueue;  { Temporary record }
  searchedName      : string[30];
  pilihan   : integer;

{ This function add content to the last, then output the last pointer }
function add(last : pMyqueue; content : tMyqueue):pMyqueue;
var 
    cur : pMyqueue;
    y : ^word;
begin
  new(cur);                       { Create a new pointer, step a }
  cur^.name:=content.name;        { fill it up with data; still step a }
  cur^.address:=content.address;
  cur^.next:=nil;                     { step b }
  
  y := addr(cur);
  writeln(y^);
  
    
  if last<>nil then last^.next:=cur;  { step c }
  add:=cur;             { Last is no longer the tail, but cur is; step d }
end;

procedure update(var head : pMyqueue; updateNode : pMyqueue; index: integer; newValue: string);
var bef, cur, aft : pMyqueue;
begin
    if head=nil then 
        exit;
    
    cur:=updateNode; 
    
    if index=1 then
        cur^.name := newValue;
    
    if index=2 then
        cur^.address := newValue;
    

end;

procedure delete(var head : pMyqueue; whattodel : pMyqueue);
var bef, cur, aft : pMyqueue;
begin
    if head=nil then 
        exit;
    
    cur:=whattodel; 
    aft:=cur^.next;
    bef:=head;
    
    if bef<>cur then
    begin
        while (bef^.next<>cur) and (bef<>nil) do 
            bef:=bef^.next;
        bef^.next:=aft;
        dispose(cur);
    end
    else
    begin
        dispose(head); 
        head:=aft;
    end;
end;

function find(head : pMyqueue; name: string):pMyqueue;
var 
    cur : pMyqueue; 
    found : boolean;
    y : ^word;
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
        y := addr(cur);
        writeln(y^);

        find:=cur;
    end
    else 
        find:=nil;
end;

procedure display(head : pMyqueue);
var cur : pMyqueue;
begin
  cur:=head;           { Step 1 }
  while cur<>nil do    { Step 2 }
  begin
    writeln(cur^.name:35,cur^.address);  { Step 3 }
    cur:=cur^.next;
  end;
end;

procedure destroy(var head : pMyqueue);
var cur : pMyqueue;
begin
  cur:=head;           { Step 1 }
  while cur<>nil do    { Step 2 }
  begin
    cur:=cur^.next;
    dispose(head);     { Step 3 }
    head:=cur;         { Step 4 }
  end;
end;

begin
  head:=nil; last:=nil;               { Set all pointers to nil }
  whattodel := nil;
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
        whattodel := find(head, searchedName);
        update(head, whattodel, 1, 'xxx');
        display(head);
    end
    else if pilihan = 4 then
    begin
        write('Delete Node: '); readln(searchedName);
        whattodel := find(head, searchedName);
        delete(head, whattodel);
        display(head);
    end;
  until false;          { Repeat forever }
  readkey;
  destroy(head);
end.


