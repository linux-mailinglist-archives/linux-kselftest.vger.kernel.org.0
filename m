Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D83456757
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 02:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhKSBRJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 20:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbhKSBRI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 20:17:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DC6C061756
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 17:14:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r11so35269739edd.9
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 17:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMATBO9ysyU+08F7274xPF36JtWrj7gJdRWN8Esowvw=;
        b=F0lg0ofqm2qN554EDAxroXtEceDC2I4ZmYURRw8rXQxDtOCoIFd8d6ygxiIoG4nDe5
         3OWfqc7R0+RUvEDtOhpqR9Bz085xgPeHHM0vFmQtlJUG6OZjfiz0aQMl8HYYz02pNKwz
         fcTG4kc4N1i5eBs6HReWnVO/IK49E21rqICDyWAydaxneAbLLn+kOIon3+jkeRyrYh/4
         NRj3k7nyY9c8NrnvtVfpI2xnscq1yvmXcpI7rBKKw4ghI2LhGQiGgMzCR0vARYTC76Dp
         YWK98gBSKy3ZUxnoNbu7soBe/DV9E5oTfTopVDtKkhK0uAMy+OzOw914pFcUWVEZzZLh
         3+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMATBO9ysyU+08F7274xPF36JtWrj7gJdRWN8Esowvw=;
        b=QStqinqHt8a/sxW127DXWol+GYENxrILDXnHm7lBizIjlkrzfnYJqgWYMAeaejtZGT
         2h2R1Jjpt6PzmfdPbFvR7Dx7KsZjbXy+GXZZIz7iXlYeB48qOxnghXV0WtBKxi9tjrCc
         D36xRWH6t1q5pSJM5S1fc/QSM6mEdEVk+tsIJ+kPAK1W15MeuncemzggmiocapuqKWsw
         Cm/ivIXUMOIrld9RLIlsLqKKUZQRRV2YR8Z0J9Ni0SSGeoQqRtaJF9+qQmjyLZSXYzor
         2bXxjIjITYAptYCLMsop+EJDVm9G3rZhfBTnJFQ5Tl5XtH4s5OL6inDWtIRkDW1AbVTc
         iEVw==
X-Gm-Message-State: AOAM5313X+3VvdZsPBtgoQOTUDbtqJzwGezh4f8FQ0bu6qltuRpDRVbI
        3BsGIgLHAaUP9HuUTZvZq2eSpN99s8gAeNWswrFffw==
X-Google-Smtp-Source: ABdhPJz5derP9yku9LYM7aE9l5YVII8m00Gkd3fLlekKm1DPilHAhQrEpyIBHBt3pBboGZQAsvQAq6I1GlGsoiHuAR8=
X-Received: by 2002:a17:906:390:: with SMTP id b16mr2562163eja.123.1637284444878;
 Thu, 18 Nov 2021 17:14:04 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook> <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
 <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org> <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
 <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
 <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
 <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
 <202111171728.D85A4E2571@keescook> <87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org>
 <877dd5qfw5.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <877dd5qfw5.fsf_-_@email.froward.int.ebiederm.org>
From:   Kyle Huey <me@kylehuey.com>
Date:   Thu, 18 Nov 2021 17:13:52 -0800
Message-ID: <CAP045Aose7Lg_OE0-MijGBg27gWo+Sk3hbxuN3AtQ8OPC9w9+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] signal: Don't always set SA_IMMUTABLE for forced signals
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Oliver Sang <oliver.sang@intel.com>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 18, 2021 at 2:05 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>
> Recently to prevent issues with SECCOMP_RET_KILL and similar signals
> being changed before they are delivered SA_IMMUTABLE was added.
>
> Unfortunately this broke debuggers[1][2] which reasonably expect to be
> able to trap synchronous SIGTRAP and SIGSEGV even when the target
> process is not configured to handle those signals.
>
> Update force_sig_to_task to support both the case when we can
> allow the debugger to intercept and possibly ignore the
> signal and the case when it is not safe to let userspace
> known about the signal until the process has exited.

s/known/know/

>
> Reported-by: Kyle Huey <me@kylehuey.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Cc: stable@vger.kernel.org
> [1] https://lkml.kernel.org/r/CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com
> [2] https://lkml.kernel.org/r/20211117150258.GB5403@xsang-OptiPlex-902

This link doesn't work.

> Fixes: 00b06da29cf9 ("signal: Add SA_IMMUTABLE to ensure forced siganls do not get changed")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/signal.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 7c4b7ae714d4..02058c983bd6 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1298,6 +1298,12 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
>         return ret;
>  }
>
> +enum sig_handler {
> +       HANDLER_CURRENT, /* If reachable use the current handler */
> +       HANDLER_SIG_DFL, /* Always use SIG_DFL handler semantics */
> +       HANDLER_EXIT,    /* Only visible as the proces exit code */
> +};
> +
>  /*
>   * Force a signal that the process can't ignore: if necessary
>   * we unblock the signal and change any SIG_IGN to SIG_DFL.
> @@ -1310,7 +1316,8 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
>   * that is why we also clear SIGNAL_UNKILLABLE.
>   */
>  static int
> -force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool sigdfl)
> +force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
> +       enum sig_handler handler)
>  {
>         unsigned long int flags;
>         int ret, blocked, ignored;
> @@ -1321,9 +1328,10 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool
>         action = &t->sighand->action[sig-1];
>         ignored = action->sa.sa_handler == SIG_IGN;
>         blocked = sigismember(&t->blocked, sig);
> -       if (blocked || ignored || sigdfl) {
> +       if (blocked || ignored || (handler != HANDLER_CURRENT)) {
>                 action->sa.sa_handler = SIG_DFL;
> -               action->sa.sa_flags |= SA_IMMUTABLE;
> +               if (handler == HANDLER_EXIT)
> +                       action->sa.sa_flags |= SA_IMMUTABLE;
>                 if (blocked) {
>                         sigdelset(&t->blocked, sig);
>                         recalc_sigpending_and_wake(t);
> @@ -1343,7 +1351,7 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool
>
>  int force_sig_info(struct kernel_siginfo *info)
>  {
> -       return force_sig_info_to_task(info, current, false);
> +       return force_sig_info_to_task(info, current, HANDLER_CURRENT);
>  }
>
>  /*
> @@ -1660,7 +1668,7 @@ void force_fatal_sig(int sig)
>         info.si_code = SI_KERNEL;
>         info.si_pid = 0;
>         info.si_uid = 0;
> -       force_sig_info_to_task(&info, current, true);
> +       force_sig_info_to_task(&info, current, HANDLER_SIG_DFL);
>  }
>
>  /*
> @@ -1693,7 +1701,7 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
>         info.si_flags = flags;
>         info.si_isr = isr;
>  #endif
> -       return force_sig_info_to_task(&info, t, false);
> +       return force_sig_info_to_task(&info, t, HANDLER_CURRENT);
>  }
>
>  int force_sig_fault(int sig, int code, void __user *addr
> @@ -1813,7 +1821,8 @@ int force_sig_seccomp(int syscall, int reason, bool force_coredump)
>         info.si_errno = reason;
>         info.si_arch = syscall_get_arch(current);
>         info.si_syscall = syscall;
> -       return force_sig_info_to_task(&info, current, force_coredump);
> +       return force_sig_info_to_task(&info, current,
> +               force_coredump ? HANDLER_EXIT : HANDLER_CURRENT);
>  }
>
>  /* For the crazy architectures that include trap information in
> --
> 2.20.1

- Kyle
