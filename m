Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D584280303
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgJAPkh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 11:40:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50465 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731885AbgJAPkh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 11:40:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kO0h8-0001LN-6U; Thu, 01 Oct 2020 15:40:34 +0000
Subject: Re: [PATCH] selftests/ftrace: check for do_sys_openat2 in user-memory
 test
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201001085641.51130-1-colin.king@canonical.com>
 <20201001104448.427a0eaa@gandalf.local.home>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <80cee321-d8ed-31fd-2f53-d9306b1d9545@canonical.com>
Date:   Thu, 1 Oct 2020 16:40:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001104448.427a0eaa@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 01/10/2020 15:44, Steven Rostedt wrote:
> On Thu,  1 Oct 2020 09:56:41 +0100
> Colin King <colin.king@canonical.com> wrote:
> 
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> More recent libc implementations are now using openat/openat2 system
>> calls so also add do_sys_openat2 to the tracing so that the test
>> passes on these systems because do_sys_open may not be called.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  .../testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc  | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
>> index a30a9c07290d..cf1b4c3e9e6b 100644
>> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
>> @@ -9,6 +9,8 @@ grep -A10 "fetcharg:" README | grep -q '\[u\]<offset>' || exit_unsupported
>>  :;: "user-memory access syntax and ustring working on user memory";:
>>  echo 'p:myevent do_sys_open path=+0($arg2):ustring path2=+u0($arg2):string' \
>>  	> kprobe_events  
>> +echo 'p:myevent2 do_sys_openat2 path=+0($arg2):ustring path2=+u0($arg2):string' \
>> +	> kprobe_events
>>
> 
> This still wont work, because the rest of the code only enables the myevent
> event, and not the one you just added.

Yep, I botched this and tested the wrong fix.

> 
> Did you see this broken before, and this patch fixes it?

So this test breaks with a recent libc and support tools built against
libc.  I believe the do_sys_open is not being detected because
do_sys_openat2 is being called instead.

Not sure now of the correct way to fix this.

> 
> -- Steve
> 
>  
>>  grep myevent kprobe_events | \
>>  	grep -q 'path=+0($arg2):ustring path2=+u0($arg2):string'
> 

