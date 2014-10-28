-- 在redis 数据库中维护一张表, 保证b2bua 连接到redis 可以通过ip/mac得到一个相同
-- 的id. 如果id不存在就生成一个没有被使用的id. id(0-80000)
redis.call('select', 1)
local af = redis.call('hget', 'VOSID', KEYS[1])
if af then
    return af
end
local af =  redis.call('hvals', 'VOSID')

local i = 0;
local found;
while i < 80000 do

    found = false;
    for key, value in pairs(af) do  
        if value == tostring(i) then
            found = true 
            break
        end
    end
    if found then 
        i = i + 1
    else
        redis.call("hset", 'VOSID', KEYS[1], tostring(i));
        break
    end
end
redis.call('select', 0)
return tostring(i)

