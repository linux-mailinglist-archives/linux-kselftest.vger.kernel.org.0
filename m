Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA14D276212
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Sep 2020 22:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIWU2S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Sep 2020 16:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgIWU2S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Sep 2020 16:28:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FB6C0613CE;
        Wed, 23 Sep 2020 13:28:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B2C3A29C66D
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>, luto@kernel.org,
        tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Organization: Collabora
References: <20200904203147.2908430-1-krisman@collabora.com>
        <20200904203147.2908430-2-krisman@collabora.com>
        <20200907101608.ldfhhvcy3vmrkg6b@wittgenstein>
        <87wo14n9ru.fsf@collabora.com> <202009221241.4C36E4EB@keescook>
Date:   Wed, 23 Sep 2020 16:28:12 -0400
In-Reply-To: <202009221241.4C36E4EB@keescook> (Kees Cook's message of "Tue, 22
        Sep 2020 12:42:53 -0700")
Message-ID: <87v9g45jc3.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, Sep 08, 2020 at 12:59:49AM -0400, Gabriel Krisman Bertazi wrote:
>> Christian Brauner <christian.brauner@ubuntu.com> writes:
>> 
>> > On Fri, Sep 04, 2020 at 04:31:39PM -0400, Gabriel Krisman Bertazi wrote:
>> >> index afe01e232935..3511c98a7849 100644
>> >> --- a/include/linux/sched.h
>> >> +++ b/include/linux/sched.h
>> >> @@ -959,7 +959,11 @@ struct task_struct {
>> >>  	kuid_t				loginuid;
>> >>  	unsigned int			sessionid;
>> >>  #endif
>> >> -	struct seccomp			seccomp;
>> >> +
>> >> +	struct {
>> >> +		unsigned int			syscall_intercept;
>> >> +		struct seccomp			seccomp;
>> >> +	};
>> >
>> > If there's no specific reason to do this I'd not wrap this in an
>> > anonymous struct. It doesn't really buy anything and there doesn't seem
>> > to be  precedent in struct task_struct right now. Also, if this somehow
>> > adds padding it seems you might end up increasing the size of struct
>> > task_struct more than necessary by accident? (I might be wrong
>> > though.)
>> 
>> Hi Christian,
>> 
>> Thanks for your review on this and on the other patches of this series.
>> 
>> I wrapped these to prevent struct layout randomization from separating
>> the flags field from seccomp, as they are going to be used together and
>> I was trying to reduce overhead to seccomp entry due to two cache misses
>> when reading this structure.  Measuring it seccomp_benchmark didn't show
>> any difference with the unwrapped version, so perhaps it was a bit of
>> premature optimization?
>
> That should not be a thing to think about here. Structure randomization
> already has a mode to protect against cache line issues. I would leave
> this as just a new member; no wrapping struct.

Makes sense.  I will drop it for the next iteration.  Thanks!

-- 
Gabriel Krisman Bertazi
