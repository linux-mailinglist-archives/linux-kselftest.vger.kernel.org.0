Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897092CB14C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 01:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgLBAFW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Dec 2020 19:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgLBAFV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Dec 2020 19:05:21 -0500
X-Gm-Message-State: AOAM532W4eCAfUg9wllaGhqD6F5qcf+drdE2OHGi21z68PWkcF+2m9JA
        vKl8Ii0gUvs1UhQcQEkFRwpUFzh+tcEMjV5PdhiYBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606867479;
        bh=MqZW0Kfi+WCzwtfCOe3WGgKsYtrojnTX6iECyZ6P9Xk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l7EZ3AnQeBR/r8NKChuI6/sqfxX0hbTSvhlgC0ZSLauwWe03sElSna+Z6JBWNaYLC
         qv7ko/LDWbmUXrC4OpiibjmJFiC8R/ER5S74YymnJ8L+Rsm51QqBriDO7KlL8yJqeF
         oL3OZBf5uX4vMl5myJwTKSK1ngI8BpjDKAJA3XDI=
X-Google-Smtp-Source: ABdhPJzikCVJryvvhw4L+oXSN5ZndFaYLqG6xj4S6SpaZ4WSCAExQ4chC3KAH3f7HzB/kzju/bPFLeC6EuZ+rnWlEvw=
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr99779wmc.176.1606867477970;
 Tue, 01 Dec 2020 16:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20201127193238.821364-1-krisman@collabora.com> <20201127193238.821364-5-krisman@collabora.com>
In-Reply-To: <20201127193238.821364-5-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 1 Dec 2020 16:04:24 -0800
X-Gmail-Original-Message-ID: <CALCETrV2SCLg1tUUbC1SeQhyn9097ktncEKvd=jh2woSZ3g8ow@mail.gmail.com>
Message-ID: <CALCETrV2SCLg1tUUbC1SeQhyn9097ktncEKvd=jh2woSZ3g8ow@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] entry: Support Syscall User Dispatch on common
 syscall entry
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Paul Gofman <gofmanp@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 27, 2020 at 11:33 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Syscall User Dispatch (SUD) must take precedence over seccomp and
> ptrace, since the use case is emulation (it can be invoked with a
> different ABI) such that seccomp filtering by syscall number doesn't
> make sense in the first place.  In addition, either the syscall is
> dispatched back to userspace, in which case there is no resource for to
> trace, or the syscall will be executed, and seccomp/ptrace will execute
> next.
>
> Since SUD runs before tracepoints, it needs to be a SYSCALL_WORK_EXIT as
> well, just to prevent a trace exit event when dispatch was triggered.
> For that, the on_syscall_dispatch() examines context to skip the
> tracepoint, audit and other work.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> Changes since v6:
>   - Update do_syscall_intercept signature (Christian Brauner)
>   - Move it to before tracepoints
>   - Use SYSCALL_WORK flags
> ---
>  include/linux/entry-common.h |  2 ++
>  kernel/entry/common.c        | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 49b26b216e4e..a6e98b4ba8e9 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -44,10 +44,12 @@
>                                  SYSCALL_WORK_SYSCALL_TRACE |           \
>                                  SYSCALL_WORK_SYSCALL_EMU |             \
>                                  SYSCALL_WORK_SYSCALL_AUDIT |           \
> +                                SYSCALL_WORK_SYSCALL_USER_DISPATCH |   \
>                                  ARCH_SYSCALL_WORK_ENTER)
>  #define SYSCALL_WORK_EXIT      (SYSCALL_WORK_SYSCALL_TRACEPOINT |      \
>                                  SYSCALL_WORK_SYSCALL_TRACE |           \
>                                  SYSCALL_WORK_SYSCALL_AUDIT |           \
> +                                SYSCALL_WORK_SYSCALL_USER_DISPATCH |   \
>                                  ARCH_SYSCALL_WORK_EXIT)
>
>  /*
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index f1b12dc32ff4..ec20aba3b890 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -6,6 +6,8 @@
>  #include <linux/livepatch.h>
>  #include <linux/audit.h>
>
> +#include "common.h"
> +
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/syscalls.h>
>
> @@ -47,6 +49,16 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  {
>         long ret = 0;
>
> +       /*
> +        * Handle Syscall User Dispatch.  This must comes first, since
> +        * the ABI here can be something that doesn't make sense for
> +        * other syscall_work features.
> +        */
> +       if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
> +               if (do_syscall_user_dispatch(regs))
> +                       return -1L;
> +       }
> +
>         /* Handle ptrace */
>         if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
>                 ret = arch_syscall_enter_tracehook(regs);
> @@ -232,6 +244,11 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
>  {
>         bool step;
>
> +       if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
> +               if (on_syscall_dispatch())
> +                       return;
> +       }

I think this would be less confusing if you just open-coded the body
of on_syscall_dispatch here and got rid of the helper.

--Andy
