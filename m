Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5171B3A9C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgDVIzt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 04:55:49 -0400
Received: from mail.loongson.cn ([114.242.206.163]:55280 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgDVIzs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 04:55:48 -0400
Received: from [10.130.0.79] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz9uGBqBeCtIqAA--.31S3;
        Wed, 22 Apr 2020 16:55:35 +0800 (CST)
Subject: Re: [PATCH v3 3/4] kmod: Return directly if module name is empty in
 request_module()
To:     Jessica Yu <jeyu@kernel.org>
References: <1587386035-5188-1-git-send-email-yangtiezhu@loongson.cn>
 <1587386035-5188-4-git-send-email-yangtiezhu@loongson.cn>
 <20200420181931.GJ11244@42.do-not-panic.com>
 <675147f7-2762-c574-4c3d-de6b25a5a44a@loongson.cn>
 <20200421144931.GA20103@linux-8ccs>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Al Viro <viro@zeniv.linux.org.uk>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <13aeb92d-047f-29a4-4d18-dcbd0519a218@loongson.cn>
Date:   Wed, 22 Apr 2020 16:55:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200421144931.GA20103@linux-8ccs>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxz9uGBqBeCtIqAA--.31S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4xuw1DGrW7XFWUtF15twb_yoWrAw15pa
        y5Ga1FyF4Dtw4UAan2qw47W3WSyw48XFW5Xr1DWr1fCFZ0gFnrAr13G3yY9FZrur4UKr1j
        vr48tay7uayDA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfU8Z2-UUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/21/2020 10:49 PM, Jessica Yu wrote:
> +++ Tiezhu Yang [21/04/20 11:07 +0800]:
>> On 04/21/2020 02:19 AM, Luis Chamberlain wrote:
>>> On Mon, Apr 20, 2020 at 08:33:54PM +0800, Tiezhu Yang wrote:
>>>> If module name is empty, it is better to return directly at the 
>>>> beginning
>>>> of request_module() without doing the needless call_modprobe() 
>>>> operation.
>>>>
>>>> Call trace:
>>>>
>>>> request_module()
>>>>       |
>>>>       |
>>>> __request_module()
>>>>       |
>>>>       |
>>>> call_modprobe()
>>>>       |
>>>>       |
>>>> call_usermodehelper_exec() -- retval = sub_info->retval;
>>>>       |
>>>>       |
>>>> call_usermodehelper_exec_work()
>>>>       |
>>>>       |
>>>> call_usermodehelper_exec_sync() -- sub_info->retval = ret;
>>>>       |
>>>>       | --> call_usermodehelper_exec_async() --> do_execve()
>>>>       |
>>>> kernel_wait4(pid, (int __user *)&ret, 0, NULL);
>>>>
>>>> sub_info->retval is 256 after call kernel_wait4(), the function
>>>> call_usermodehelper_exec() returns sub_info->retval which is 256,
>>>> then call_modprobe() and __request_module() returns 256.
>>>>
>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>> Thanks for looking into this. I still cannot find where
>>> userspace it returns 256. Can you? If I run modprobe without
>>> an argument I see 1 returned.
>>>
>>> At least kmod [0] has a series of cmd helper structs, the one for 
>>> modprobe
>>> seems to be kmod_cmd_compat_modprobe, and I can see -1 returned which
>>> can be converted to 255. It can also return EXIT_FAILURE or 
>>> EXIT_SUCCESS
>>> and /usr/include/stdlib.h defines these as 1 and 0 respectively.
>
> I'm also seeing modprobe return 1 as exit status when I run it without
> arguments. I don't think the 256 value is coming from modprobe though,
> see below -
>
>>> https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/
>>>
>>>   Luis
>>
>> Here is my understanding:
>>
>> When build and execute the following application, we can see the exit 
>> status is 256.
>>
>> $ ./system
>> modprobe: FATAL: Module  not found in directory 
>> /lib/modules/4.18.0-147.5.1.el8_1.x86_64
>> exit status = 256
>>
>> $ ./execl
>> modprobe: FATAL: Module  not found in directory 
>> /lib/modules/4.18.0-147.5.1.el8_1.x86_64
>> exit status = 256
>
> I am going to guess this has something to do with how system() and
> waitpid() (and the wait family of syscalls in general) encode the exit
> status in their return values. According to their man pages, you need
> to use the appropriate WIF* macros to get the actual exit code of the
> child process.
>
> From system(3):
>
>    the return value is a "wait status" that can be examined using the
>    macros described in waitpid(2).  (i.e., WIFEXITED(),
>    WEXITSTATUS(), and so on)
>
> From waitpid(2):
>
>     If  wstatus  is  not  NULL,  wait()  and  waitpid() store status
>     information in the int to which it points.  This integer can be
>     inspected with the following macros (which take the integer
>     itself as an argument, not a pointer to it, as is done in wait()
>     and waitpid()!):
>
>       WEXITSTATUS(wstatus)
>              returns the exit status of the child.  This consists of
>              the least significant 8 bits of the status argument that
>              the child specified in a call to exit(3) or _exit(2) or
>              as the argument for a return statement in main(). This
>              macro should be employed only if WIFEXITED returned
>              true.
>
> In your test code, you are reading &status directly. To obtain the
> exit status, you need to use WEXITSTATUS(status), or right shift the
> value by 8 bits. That gives you 1, which was the original exit code
> given by modprobe. That's why you see an exit code of 1 when running
> modprobe directly and you see 256 when using system() and waitpid()
> and don't use the WIF* macros.
>
> As for why __request_module() returns 256, I am guessing this would
> come from kernel_wait4(), but I did not dive into the call path to
> verify this yet.

+Cc Al Viro <viro@zeniv.linux.org.uk>

Hi Al,

When module name is empty, __request_module() returns 256.
What do you think about this case and patch?
Thank you very much for your attention.

patch v3:
https://lore.kernel.org/patchwork/patch/1227274/

patch v4 (update the commit message):
https://lore.kernel.org/patchwork/patch/1227981/

>
> Jessica

