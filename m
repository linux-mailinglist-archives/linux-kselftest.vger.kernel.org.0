Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39271B0073
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 06:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgDTEIv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 00:08:51 -0400
Received: from mail.loongson.cn ([114.242.206.163]:59174 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbgDTEIv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 00:08:51 -0400
Received: from [10.130.0.79] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj2hOIJ1eDPgpAA--.3S3;
        Mon, 20 Apr 2020 12:08:47 +0800 (CST)
Subject: Re: [PATCH 3/4] kmod: Return directly if module name is empty in
 request_module()
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
References: <1587187200-13109-1-git-send-email-yangtiezhu@loongson.cn>
 <1587187200-13109-3-git-send-email-yangtiezhu@loongson.cn>
 <20200418054519.GX11244@42.do-not-panic.com>
 <CAB=NE6XD7XCmsTAg3+mw=b8WZnKJiwha5t4DBJFt5w+b_DsNkg@mail.gmail.com>
 <b9c6e6e6-571a-b957-755f-72f2b0f538c5@loongson.cn>
 <20200418071905.GE11244@42.do-not-panic.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f7dad626-ab6d-f362-acf1-d24e5f5cdf47@loongson.cn>
Date:   Mon, 20 Apr 2020 12:08:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200418071905.GE11244@42.do-not-panic.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxj2hOIJ1eDPgpAA--.3S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45WrW8XFyrCF4ftw4rGrg_yoW5GF1DpF
        W5JFs5tF4rtr1jvFn2yr1kWFySgw4UJFs5X3WDur1rZFn0grnIyr1UGw15ury5ur4xKr10
        yr4vqrW3ur15GFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVW8XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUjGYLDUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/18/2020 03:19 PM, Luis Chamberlain wrote:
> On Sat, Apr 18, 2020 at 01:58:45PM +0800, Tiezhu Yang wrote:
>> On 04/18/2020 01:48 PM, Luis Chamberlain wrote:
>>> On Fri, Apr 17, 2020 at 11:45 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>>> On Sat, Apr 18, 2020 at 01:19:59PM +0800, Tiezhu Yang wrote:
>>>>> If module name is empty, it is better to return directly at the beginning
>>>>> of request_module() without doing the needless call_modprobe() operation.
>>>>>
>>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>>> ---
>>>>>    kernel/kmod.c | 5 +++++
>>>>>    1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/kernel/kmod.c b/kernel/kmod.c
>>>>> index 3cd075c..5851444 100644
>>>>> --- a/kernel/kmod.c
>>>>> +++ b/kernel/kmod.c
>>>>> @@ -28,6 +28,8 @@
>>>>>
>>>>>    #include <trace/events/module.h>
>>>>>
>>>>> +#define MODULE_NOT_FOUND 256
>>>>> +
>>>>>    /*
>>>>>     * Assuming:
>>>>>     *
>>>>> @@ -144,6 +146,9 @@ int __request_module(bool wait, const char *fmt, ...)
>>>>>         if (ret >= MODULE_NAME_LEN)
>>>>>                 return -ENAMETOOLONG;
>>>>>
>>>>> +     if (strlen(module_name) == 0)
>>>>> +             return MODULE_NOT_FOUND;
>>>> I'd rather we just use something standard like -EINVAL.
>>>> What do we return if its not found? Then use that value.
>>> Also, are we testing for this condition yet? If not can we add one?
>> Yes, kmod_test_0001_driver() in tools/testing/selftests/kmod/kmod.sh tests
>> this case and expects result MODULE_NOT_FOUND which is 256.
> OK I see now I had put:
>
> errno_name_to_val()
> {
>          case "$1" in
> 	# kmod calls modprobe and upon of a module not found
> 	# modprobe returns just 1... However in the
> 	# kernel we *sometimes* see 256...
> 	MODULE_NOT_FOUND)
> 		echo 256;;
>
> I found that through testing, however there was nothing set in stone,
> nothing documented. While you are at it, can you find the places where
> this is returned in the kernel code? We should clear this up and
> se things straight. We cannot change what we gave userspace already
> though.

Call Trace:

__request_module()
       |
       |
call_modprobe()
       |
       |
call_usermodehelper_exec()   -- retval = sub_info->retval;
       |
       |
call_usermodehelper_exec_work()
       |
       |
call_usermodehelper_exec_sync()   -- sub_info->retval = ret;
       |
       | --> call_usermodehelper_exec_async() --> do_execve()
       |
kernel_wait4(pid, (int __user *)&ret, 0, NULL);

__request_module() returns the exist status of child process, if module name
is empty or non-exist, sub_info->retval is 256 after call kernel_wait4().

Should I add this analysis to the commit message?

Thanks,
Tiezhu Yang

>
>    Luis

