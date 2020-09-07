Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9408F25F779
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Sep 2020 12:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgIGKP3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Sep 2020 06:15:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59694 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgIGKP1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Sep 2020 06:15:27 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kFEBG-0005Rk-Rm; Mon, 07 Sep 2020 10:15:22 +0000
Date:   Mon, 7 Sep 2020 12:15:22 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 6/9] kernel: entry: Support Syscall User Dispatch for
 common syscall entry
Message-ID: <20200907101522.zo6qzgp4qfzkz7cs@wittgenstein>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-7-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-7-krisman@collabora.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:44PM -0400, Gabriel Krisman Bertazi wrote:
> Syscall User Dispatch (SUD) must take precedence over seccomp, since the
> use case is emulation (it can be invoked with a different ABI) such that
> seccomp filtering by syscall number doesn't make sense in the first
> place.  In addition, either the syscall is dispatched back to userspace,
> in which case there is no resource for seccomp to protect, or the

Tbh, I'm torn here. I'm not a super clever attacker but it feels to me
that this is still at least a clever way to circumvent a seccomp
sandbox.
If I'd be confined by a seccomp profile that would cause me to be
SIGKILLed when I try do open() I could prctl() myself to do user
dispatch to prevent that from happening, no?

> syscall will be executed, and seccomp will execute next.
> 
> Regarding ptrace, I experimented with before and after, and while the
> same ABI argument applies, I felt it was easier to debug if I let ptrace
> happen for syscalls that are dispatched back to userspace.  In addition,
> doing it after ptrace makes the code in syscall_exit_work slightly
> simpler, since it doesn't require special handling for this feature.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  kernel/entry/common.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 44fd089d59da..fdb0c543539d 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -6,6 +6,8 @@
>  #include <linux/audit.h>
>  #include <linux/syscall_intercept.h>
>  
> +#include "common.h"
> +
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/syscalls.h>
>  
> @@ -47,6 +49,12 @@ static inline long do_syscall_intercept(struct pt_regs *regs)
>  	int sysint_work = READ_ONCE(current->syscall_intercept);
>  	int ret;
>  
> +	if (sysint_work & SYSINT_USER_DISPATCH) {
> +		ret = do_syscall_user_dispatch(regs);
> +		if (ret == -1L)
> +			return ret;
> +	}
> +
>  	if (sysint_work & SYSINT_SECCOMP) {
>  		ret = __secure_computing(NULL);
>  		if (ret == -1L)
> -- 
> 2.28.0
