-- b2bua 脚本. 一个redis请求得到呼叫信息.
local af =  redis.call('hkeys', 'User:Line:' .. ARGV[1])

for key, value in pairs(af) do  
    local  ids = redis.call('hmget', 'Dialog:' .. value, 'caller_CallID', 'callee_CallID')
    if ids[1] == ARGV[2] or ids[2] == ARGV[2] then
        return  redis.call('hmget', "Dialog:" .. value, 'caller_CallID', 'callee_CallID')
    end
end 
return "404"
