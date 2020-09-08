Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C04D2609B7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Sep 2020 06:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgIHE7z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Sep 2020 00:59:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47178 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgIHE7z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Sep 2020 00:59:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 2488328F7E8
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Organization: Collabora
References: <20200904203147.2908430-1-krisman@collabora.com>
        <20200904203147.2908430-2-krisman@collabora.com>
        <20200907101608.ldfhhvcy3vmrkg6b@wittgenstein>
Date:   Tue, 08 Sep 2020 00:59:49 -0400
In-Reply-To: <20200907101608.ldfhhvcy3vmrkg6b@wittgenstein> (Christian
        Brauner's message of "Mon, 7 Sep 2020 12:16:08 +0200")
Message-ID: <87wo14n9ru.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Fri, Sep 04, 2020 at 04:31:39PM -0400, Gabriel Krisman Bertazi wrote:
>> index afe01e232935..3511c98a7849 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -959,7 +959,11 @@ struct task_struct {
>>  	kuid_t				loginuid;
>>  	unsigned int			sessionid;
>>  #endif
>> -	struct seccomp			seccomp;
>> +
>> +	struct {
>> +		unsigned int			syscall_intercept;
>> +		struct seccomp			seccomp;
>> +	};
>
> If there's no specific reason to do this I'd not wrap this in an
> anonymous struct. It doesn't really buy anything and there doesn't seem
> to be  precedent in struct task_struct right now. Also, if this somehow
> adds padding it seems you might end up increasing the size of struct
> task_struct more than necessary by accident? (I might be wrong
> though.)

Hi Christian,

Thanks for your review on this and on the other patches of this series.

I wrapped these to prevent struct layout randomization from separating
the flags field from seccomp, as they are going to be used together and
I was trying to reduce overhead to seccomp entry due to two cache misses
when reading this structure.  Measuring it seccomp_benchmark didn't show
any difference with the unwrapped version, so perhaps it was a bit of
premature optimization?

>> diff --git a/include/linux/syscall_intercept.h b/include/linux/syscall_intercept.h
>> new file mode 100644
>> index 000000000000..725d157699da
>> --- /dev/null
>> +++ b/include/linux/syscall_intercept.h
>> @@ -0,0 +1,70 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2020 Collabora Ltd.
>> + */
>> +#ifndef _SYSCALL_INTERCEPT_H
>> +#define _SYSCALL_INTERCEPT_H
>> +
>> +#include <linux/sched.h>
>> +#include <linux/sched/signal.h>
>> +#include <linux/thread_info.h>
>> +
>> +#define SYSINT_SECCOMP		0x1
>
> <bikeshed>
>
> Can we maybe use a better name for this? I noone minds the extra
> characters I'd suggest:
> SYSCALL_INTERCEPT_SECCOMP
> or
> SYS_INTERCEPT_SECCOMP
>
> </bikeshed>
>

will do.

Thanks,

-- 
Gabriel Krisman Bertazi
