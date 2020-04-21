Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA871B1C63
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Apr 2020 05:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgDUDHj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 23:07:39 -0400
Received: from mail.loongson.cn ([114.242.206.163]:59710 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbgDUDHj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 23:07:39 -0400
Received: from [10.130.0.79] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2tuY55e_GEqAA--.26S3;
        Tue, 21 Apr 2020 11:07:27 +0800 (CST)
Subject: Re: [PATCH v3 3/4] kmod: Return directly if module name is empty in
 request_module()
To:     Luis Chamberlain <mcgrof@kernel.org>
References: <1587386035-5188-1-git-send-email-yangtiezhu@loongson.cn>
 <1587386035-5188-4-git-send-email-yangtiezhu@loongson.cn>
 <20200420181931.GJ11244@42.do-not-panic.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <675147f7-2762-c574-4c3d-de6b25a5a44a@loongson.cn>
Date:   Tue, 21 Apr 2020 11:07:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200420181931.GJ11244@42.do-not-panic.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxz2tuY55e_GEqAA--.26S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw47KF4rCrWxZr18CFW7Arb_yoW5Xw1Upa
        y5AF4rKr4Utr4kAan2qrWxG3Wftr4xXrW3Jrnru3WfCFZ0grnrAr1Uuw4UWF4UCrZ5Kr1j
        vFWkJayrWFWDZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfUnQ6pDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/21/2020 02:19 AM, Luis Chamberlain wrote:
> On Mon, Apr 20, 2020 at 08:33:54PM +0800, Tiezhu Yang wrote:
>> If module name is empty, it is better to return directly at the beginning
>> of request_module() without doing the needless call_modprobe() operation.
>>
>> Call trace:
>>
>> request_module()
>>        |
>>        |
>> __request_module()
>>        |
>>        |
>> call_modprobe()
>>        |
>>        |
>> call_usermodehelper_exec() -- retval = sub_info->retval;
>>        |
>>        |
>> call_usermodehelper_exec_work()
>>        |
>>        |
>> call_usermodehelper_exec_sync() -- sub_info->retval = ret;
>>        |
>>        | --> call_usermodehelper_exec_async() --> do_execve()
>>        |
>> kernel_wait4(pid, (int __user *)&ret, 0, NULL);
>>
>> sub_info->retval is 256 after call kernel_wait4(), the function
>> call_usermodehelper_exec() returns sub_info->retval which is 256,
>> then call_modprobe() and __request_module() returns 256.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Thanks for looking into this. I still cannot find where
> userspace it returns 256. Can you? If I run modprobe without
> an argument I see 1 returned.
>
> At least kmod [0] has a series of cmd helper structs, the one for modprobe
> seems to be kmod_cmd_compat_modprobe, and I can see -1 returned which
> can be converted to 255. It can also return EXIT_FAILURE or EXIT_SUCCESS
> and /usr/include/stdlib.h defines these as 1 and 0 respectively.
>
> https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/
>
>    Luis

Here is my understanding:

When build and execute the following application, we can see the exit 
status is 256.

$ ./system
modprobe: FATAL: Module  not found in directory 
/lib/modules/4.18.0-147.5.1.el8_1.x86_64
exit status = 256

$ ./execl
modprobe: FATAL: Module  not found in directory 
/lib/modules/4.18.0-147.5.1.el8_1.x86_64
exit status = 256

$ cat system.c
#include <stdio.h>
#include <stdlib.h>

int main()
{
     int status = 0;

     status = system("modprobe ''");
     printf("exit status = %d\n", status);

     return status;
}

$ cat execl.c
#include <sys/wait.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

int main()
{
     pid_t pid, w;
     int status;

     pid = fork();
     if (pid == -1) {
         perror("fork");
         exit(EXIT_FAILURE);
     }

     if (pid == 0) {
         execl("/bin/sh", "sh", "-c", "modprobe aaa", (char *) 0);
     } else {
         w = waitpid(pid, &status, 0);
         if (w == -1) {
             perror("waitpid");
             exit(EXIT_FAILURE);
         }

         printf("exit status = %d\n", status);

         exit(EXIT_SUCCESS);
     }

     return 0;
}

The exit status of child process is wrote to the address of variable 
"status"
after call waitpid()in the user space that correspond with 
kernel_wait4() [1]
in the kernel space.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/exit.c#n1576

