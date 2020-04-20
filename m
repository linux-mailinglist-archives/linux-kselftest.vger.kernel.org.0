Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02F71B0076
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 06:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgDTELY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 00:11:24 -0400
Received: from mail.loongson.cn ([114.242.206.163]:59520 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgDTELY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 00:11:24 -0400
Received: from [10.130.0.79] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxH97pIJ1eNvgpAA--.2S3;
        Mon, 20 Apr 2020 12:11:21 +0800 (CST)
Subject: Re: [PATCH 3/4] kmod: Return directly if module name is empty in
 request_module()
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
References: <1587187200-13109-1-git-send-email-yangtiezhu@loongson.cn>
 <1587187200-13109-3-git-send-email-yangtiezhu@loongson.cn>
 <20200418054519.GX11244@42.do-not-panic.com>
 <CAB=NE6XD7XCmsTAg3+mw=b8WZnKJiwha5t4DBJFt5w+b_DsNkg@mail.gmail.com>
 <b9c6e6e6-571a-b957-755f-72f2b0f538c5@loongson.cn>
 <20200418071905.GE11244@42.do-not-panic.com>
 <f7dad626-ab6d-f362-acf1-d24e5f5cdf47@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <59e2fffd-f0a0-0a93-83f7-093ac61e5b0b@loongson.cn>
Date:   Mon, 20 Apr 2020 12:11:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <f7dad626-ab6d-f362-acf1-d24e5f5cdf47@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxH97pIJ1eNvgpAA--.2S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWDur1ktw1DCF1xGryrtFb_yoW5WrWxpF
        WUJFs5tr4UJr1jyFn2qwn5WFyftw4DJFs5XF1DCryrAFn0grnIyr1UWw45ury3uF4xKr10
        yr4kXrW3ur45CFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUb38n5UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/20/2020 12:08 PM, Tiezhu Yang wrote:
> On 04/18/2020 03:19 PM, Luis Chamberlain wrote:
>> On Sat, Apr 18, 2020 at 01:58:45PM +0800, Tiezhu Yang wrote:
>>> On 04/18/2020 01:48 PM, Luis Chamberlain wrote:
>>>> On Fri, Apr 17, 2020 at 11:45 PM Luis Chamberlain 
>>>> <mcgrof@kernel.org> wrote:
>>>>> On Sat, Apr 18, 2020 at 01:19:59PM +0800, Tiezhu Yang wrote:
>>>>>> If module name is empty, it is better to return directly at the 
>>>>>> beginning
>>>>>> of request_module() without doing the needless call_modprobe() 
>>>>>> operation.
>>>>>>
>>>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>>>> ---
>>>>>>    kernel/kmod.c | 5 +++++
>>>>>>    1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/kernel/kmod.c b/kernel/kmod.c
>>>>>> index 3cd075c..5851444 100644
>>>>>> --- a/kernel/kmod.c
>>>>>> +++ b/kernel/kmod.c
>>>>>> @@ -28,6 +28,8 @@
>>>>>>
>>>>>>    #include <trace/events/module.h>
>>>>>>
>>>>>> +#define MODULE_NOT_FOUND 256
>>>>>> +
>>>>>>    /*
>>>>>>     * Assuming:
>>>>>>     *
>>>>>> @@ -144,6 +146,9 @@ int __request_module(bool wait, const char 
>>>>>> *fmt, ...)
>>>>>>         if (ret >= MODULE_NAME_LEN)
>>>>>>                 return -ENAMETOOLONG;
>>>>>>
>>>>>> +     if (strlen(module_name) == 0)
>>>>>> +             return MODULE_NOT_FOUND;
>>>>> I'd rather we just use something standard like -EINVAL.
>>>>> What do we return if its not found? Then use that value.
>>>> Also, are we testing for this condition yet? If not can we add one?
>>> Yes, kmod_test_0001_driver() in tools/testing/selftests/kmod/kmod.sh 
>>> tests
>>> this case and expects result MODULE_NOT_FOUND which is 256.
>> OK I see now I had put:
>>
>> errno_name_to_val()
>> {
>>          case "$1" in
>>     # kmod calls modprobe and upon of a module not found
>>     # modprobe returns just 1... However in the
>>     # kernel we *sometimes* see 256...
>>     MODULE_NOT_FOUND)
>>         echo 256;;
>>
>> I found that through testing, however there was nothing set in stone,
>> nothing documented. While you are at it, can you find the places where
>> this is returned in the kernel code? We should clear this up and
>> se things straight. We cannot change what we gave userspace already
>> though.
>
> Call Trace:
>
> __request_module()
>       |
>       |
> call_modprobe()
>       |
>       |
> call_usermodehelper_exec()   -- retval = sub_info->retval;
>       |
>       |
> call_usermodehelper_exec_work()
>       |
>       |
> call_usermodehelper_exec_sync()   -- sub_info->retval = ret;
>       |
>       | --> call_usermodehelper_exec_async() --> do_execve()
>       |
> kernel_wait4(pid, (int __user *)&ret, 0, NULL);
>
> __request_module() returns the exist status of child process, if 
> module name

Sorry for the typo: exist status --> exit status

> is empty or non-exist, sub_info->retval is 256 after call kernel_wait4().
>
> Should I add this analysis to the commit message?
>
> Thanks,
> Tiezhu Yang
>
>>
>>    Luis
>

