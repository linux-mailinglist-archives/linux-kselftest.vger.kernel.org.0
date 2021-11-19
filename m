Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154A8456752
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 02:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhKSBPh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 20:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhKSBPg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 20:15:36 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF161C06174A
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 17:12:35 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r11so35257197edd.9
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 17:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wK6B2URQKiioFYJXC3wE9DBQbAOigpHXbFKyVO8IlQQ=;
        b=CMnubC1liyKFsF4BuJRRELgsahf4EFnmYx/5rfqjarwViMgTKogdGAuqvGirTScTFC
         X89dngrDbB1iS4+Ayufls7UNs2Xaiu2xsh4n92JH/UWCkZJirUXTyRKPcMRNHGdjlQLY
         JSxuobyyyZBnHUfL5x/t0TAznCCNdksF+0IOgXo6atgDV2Sbj3juB1WiRfhsNKFdLJIO
         zi6++ueH7f4yd0Q7x6GBaqihSYUQ+fDRtjCRHGngZw74SbNa0ceAPn28hdTUCE9X/szE
         s5X1qj5IglVC+EVbT51I2lJQ6hO2u3waIMQnyWm+jN50uxqzoDoB7n7qUd3mikHyttHa
         +VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wK6B2URQKiioFYJXC3wE9DBQbAOigpHXbFKyVO8IlQQ=;
        b=4ojwSTwIAcSJUB1WbeyyjvI8MFVfNF3o+CEjmuVIHnzfK20CgmIVJwCGl60otLrRc4
         esIwXMDhMSe6n/NVIZYduVzc8JlStMyYS0m4n2KOMR3MQpTpLiKEuW0wGPiBX/UTiPOs
         UAO9bVTOjVO7Xax3eatBa72RXj07eUqk92DxqaIW5IbGUmeXyHzLj3QsQdMGrbkm3g05
         pZIQ3wHP+/28OBetEU4+9xvK+dl5iQtly+jEX58zgLqwYcZ/quvkMqV6uFqAFtU2qpO6
         tZ095zq/U35xmvF97ehx4rP7UQXllvu2gokFbKrVgKCMFGB1CIAeKaRY++ZLzGcc5bdC
         N7Aw==
X-Gm-Message-State: AOAM533xxPSySR7YTxMo8H/w5utXN1Qg2OvRjyH2wZa60xIVj1+a3htB
        J5e0/oRGp+oHWE1z8fgYe7N0W+T6Qcqu4yY/F6LnyA==
X-Google-Smtp-Source: ABdhPJwSApuFMiEaAZ9GvVXe7oBeoItavBWlFOpqOtLkWC4On9DpcbKroIBsOHBEybKZYMbP19DQalCAbSM826hBDHA=
X-Received: by 2002:a05:6402:3590:: with SMTP id y16mr18592508edc.343.1637284354160;
 Thu, 18 Nov 2021 17:12:34 -0800 (PST)
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
In-Reply-To: <87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org>
From:   Kyle Huey <me@kylehuey.com>
Date:   Thu, 18 Nov 2021 17:12:23 -0800
Message-ID: <CAP045Ap=1U07er7Y2XO9wmiRtKLoKL4u8zek48ROU668=G9D3A@mail.gmail.com>
Subject: Re: [PATCH 0/2] SA_IMMUTABLE fixes
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

On Thu, Nov 18, 2021 at 1:58 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>
> SA_IMMUTABLE fixed issues with force_sig_seccomp and the introduction
> for force_sig_fatal where the exit previously could not be interrupted
> but now it can.  Unfortunately it added that behavior to all force_sig
> functions under the right conditions which debuggers usage of SIG_TRAP
> and debuggers handling of SIGSEGV.
>
> Solve that by limiting SA_IMMUTABLE to just the cases that historically
> debuggers have not been able to intercept.
>
> The first patch changes force_sig_info_to_task to take a flag
> that requests which behavior is desired.
>
> The second patch adds force_exit_sig which replaces force_fatal_sig
> in the cases where historically userspace would only find out about
> the ``signal'' after the process has exited.
>
> The first one with the hunk changing force_fatal_sig removed should be
> suitable for backporting to v5.15. v5.15 does not implement
> force_fatal_sig.
>
> This should be enough to fix the regressions.
>
> Kyle if you can double check me that I have properly fixed these issues
> that would be appreciated.
>
> Any other review or suggestions to improve the names would be
> appreciated.  I think I have named things reasonably well but I am very
> close to the code so it is easy for me to miss things.
>
> Eric W. Biederman (2):
>       signal: Don't always set SA_IMMUTABLE for forced signals
>       signal: Replace force_fatal_sig with force_exit_sig when in doubt
>
>  arch/m68k/kernel/traps.c              |  2 +-
>  arch/powerpc/kernel/signal_32.c       |  2 +-
>  arch/powerpc/kernel/signal_64.c       |  4 ++--
>  arch/s390/kernel/traps.c              |  2 +-
>  arch/sparc/kernel/signal_32.c         |  4 ++--
>  arch/sparc/kernel/windows.c           |  2 +-
>  arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
>  arch/x86/kernel/vm86_32.c             |  2 +-
>  include/linux/sched/signal.h          |  1 +
>  kernel/entry/syscall_user_dispatch.c  |  4 ++--
>  kernel/signal.c                       | 36 ++++++++++++++++++++++++++++-------
>  11 files changed, 42 insertions(+), 19 deletions(-)
>
> Eric

rr's test suite passes with both diffs applied

Tested-by: Kyle Huey <khuey@kylehuey.com>

- Kyle
