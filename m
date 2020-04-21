Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE4A1B2A76
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Apr 2020 16:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgDUOti (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Apr 2020 10:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgDUOth (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Apr 2020 10:49:37 -0400
Received: from linux-8ccs (p5B281662.dip0.t-ipconnect.de [91.40.22.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AAD5206A1;
        Tue, 21 Apr 2020 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587480577;
        bh=SgQiBrSQ+PD4FbQVsWRH9o97ApUK/0hXOneHAMyuIM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0L8bmATeCztOdFcTU5cEDz0mnDPS7WMXwF9DzQ6s2ZMQy1B+s3B/IXhqUrpouSRxc
         cQs5ROhMlVbtU+7Dhb8t8E6pabowPHrBxaJsexUOu9SxZ1w87JPcKk7fHN6bLbM22q
         VJd8+j2qqwLXKmHzNqjDe5oi9kjjDeQaDlrYZVYQ=
Date:   Tue, 21 Apr 2020 16:49:32 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v3 3/4] kmod: Return directly if module name is empty in
 request_module()
Message-ID: <20200421144931.GA20103@linux-8ccs>
References: <1587386035-5188-1-git-send-email-yangtiezhu@loongson.cn>
 <1587386035-5188-4-git-send-email-yangtiezhu@loongson.cn>
 <20200420181931.GJ11244@42.do-not-panic.com>
 <675147f7-2762-c574-4c3d-de6b25a5a44a@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <675147f7-2762-c574-4c3d-de6b25a5a44a@loongson.cn>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+++ Tiezhu Yang [21/04/20 11:07 +0800]:
>On 04/21/2020 02:19 AM, Luis Chamberlain wrote:
>>On Mon, Apr 20, 2020 at 08:33:54PM +0800, Tiezhu Yang wrote:
>>>If module name is empty, it is better to return directly at the beginning
>>>of request_module() without doing the needless call_modprobe() operation.
>>>
>>>Call trace:
>>>
>>>request_module()
>>>       |
>>>       |
>>>__request_module()
>>>       |
>>>       |
>>>call_modprobe()
>>>       |
>>>       |
>>>call_usermodehelper_exec() -- retval = sub_info->retval;
>>>       |
>>>       |
>>>call_usermodehelper_exec_work()
>>>       |
>>>       |
>>>call_usermodehelper_exec_sync() -- sub_info->retval = ret;
>>>       |
>>>       | --> call_usermodehelper_exec_async() --> do_execve()
>>>       |
>>>kernel_wait4(pid, (int __user *)&ret, 0, NULL);
>>>
>>>sub_info->retval is 256 after call kernel_wait4(), the function
>>>call_usermodehelper_exec() returns sub_info->retval which is 256,
>>>then call_modprobe() and __request_module() returns 256.
>>>
>>>Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>Thanks for looking into this. I still cannot find where
>>userspace it returns 256. Can you? If I run modprobe without
>>an argument I see 1 returned.
>>
>>At least kmod [0] has a series of cmd helper structs, the one for modprobe
>>seems to be kmod_cmd_compat_modprobe, and I can see -1 returned which
>>can be converted to 255. It can also return EXIT_FAILURE or EXIT_SUCCESS
>>and /usr/include/stdlib.h defines these as 1 and 0 respectively.

I'm also seeing modprobe return 1 as exit status when I run it without
arguments. I don't think the 256 value is coming from modprobe though,
see below -

>>https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/
>>
>>   Luis
>
>Here is my understanding:
>
>When build and execute the following application, we can see the exit 
>status is 256.
>
>$ ./system
>modprobe: FATAL: Module  not found in directory 
>/lib/modules/4.18.0-147.5.1.el8_1.x86_64
>exit status = 256
>
>$ ./execl
>modprobe: FATAL: Module  not found in directory 
>/lib/modules/4.18.0-147.5.1.el8_1.x86_64
>exit status = 256

I am going to guess this has something to do with how system() and
waitpid() (and the wait family of syscalls in general) encode the exit
status in their return values. According to their man pages, you need
to use the appropriate WIF* macros to get the actual exit code of the
child process.

From system(3):

    the return value is a "wait status" that can be examined using the
    macros described in waitpid(2).  (i.e., WIFEXITED(),
    WEXITSTATUS(), and so on)

From waitpid(2):

     If  wstatus  is  not  NULL,  wait()  and  waitpid() store status
     information in the int to which it points.  This integer can be
     inspected with the following macros (which take the integer
     itself as an argument, not a pointer to it, as is done in wait()
     and waitpid()!):

       WEXITSTATUS(wstatus)
              returns the exit status of the child.  This consists of
              the least significant 8 bits of the status argument that
              the child specified in a call to exit(3) or _exit(2) or
              as the argument for a return statement in main().  This
              macro should be employed only if WIFEXITED returned
              true.

In your test code, you are reading &status directly. To obtain the
exit status, you need to use WEXITSTATUS(status), or right shift the
value by 8 bits. That gives you 1, which was the original exit code
given by modprobe. That's why you see an exit code of 1 when running
modprobe directly and you see 256 when using system() and waitpid()
and don't use the WIF* macros.

As for why __request_module() returns 256, I am guessing this would
come from kernel_wait4(), but I did not dive into the call path to
verify this yet.

Jessica
