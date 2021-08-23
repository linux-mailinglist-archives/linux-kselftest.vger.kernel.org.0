Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972773F53BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 01:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhHWXrZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Aug 2021 19:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhHWXrY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Aug 2021 19:47:24 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7EDC061757
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Aug 2021 16:46:41 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z2so18824915iln.0
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Aug 2021 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoLC1EF3mIR0GlW76GBSt/BwmQNgwhehtB+DBCRZ1+A=;
        b=ieObiuqzWjKenmS5fhA2KlEkngO02xDQilv8lvyC4D+Pum4HGeAM9YxrBJ5RPaEH5c
         PGwcQsuTYK9YcMbFvagX/tRluioVmxc7JQ/E+ZVw74iOQ6LsUBKtpPK4jaP5BXHtEL4x
         SmlfHvpixi+DllUCXuPzWjk6zA/bHNc5X7kKlPwDC7KYnYUitdlnuKoubqVwn2cV7gOG
         ulU1tZsjuJop5z0MpLhwF91iwokwJU9Z3bomsD5Bk6Y7d8MArYcUfNpo8XIx8Hi+8Kxs
         KqiQ43yho6JDD+dtIDSv50yTeg4macRVXUgyVaAuhZWmWsa290Q1RghpXqQhiy4RJxzC
         WFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoLC1EF3mIR0GlW76GBSt/BwmQNgwhehtB+DBCRZ1+A=;
        b=oEReWGLBoH1c+jo95ea4B+UsYVp8sHxzg4VLERTolCm+gD3AXjNmvoCDpFIKCmNIBv
         OqNushsRSKCrxiaeo7DN6IZ7IIcqxWCE3Xxlnn5EinPMnoADuvebxEPSbTNsFe3+UVx0
         kM035BQtg4Wl02S1vOXomx3KFL/ks7TpoHTzR1hiCN9fgUOSikRtPT69i/M4ELGquQVH
         3Fb2edIAEw/nHE9jc/3qtvd2R0sHHDZOFEuWW8QG4GH+1hRitN6sR+s0on/+s0QJ/E1g
         qjQD0IpRAO20DWxMXCfGdHs1rQsCaUdvaBP8Jr2qSlOD5u+Rz/Q6P4Zq5PBdTknSd80+
         zoBA==
X-Gm-Message-State: AOAM532IxaJvonEFmmDq4xLt8Omuf0dQNDSwzJhK/Qg63slQpGHytChm
        4s9IVMS8WqWXyLh/2KYsw3OIPuJdlrO/NLjpJFOoCw==
X-Google-Smtp-Source: ABdhPJyUnfiO2iZsMzYl0bECsz2yA5wsBXuFbRA5eIkM+UStG915jCcxL3fRugWbjAHUfvQrnihJ/kDPcNr29FpWrqY=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr24801438ils.203.1629762401039;
 Mon, 23 Aug 2021 16:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210820225002.310652-1-seanjc@google.com> <20210820225002.310652-6-seanjc@google.com>
In-Reply-To: <20210820225002.310652-6-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 23 Aug 2021 16:46:30 -0700
Message-ID: <CANgfPd_Vh52oWyMMcqL2iTVgcXQp3QDsM5MrAZxr=xe33rPMhg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] KVM: selftests: Remove __NR_userfaultfd syscall fallback
To:     Sean Christopherson <seanjc@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 20, 2021 at 3:50 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Revert the __NR_userfaultfd syscall fallback added for KVM selftests now
> that x86's unistd_{32,63}.h overrides are under uapi/ and thus not in
> KVM sefltests' search path, i.e. now that KVM gets x86 syscall numbers
> from the installed kernel headers.
>
> No functional change intended.
>
> Cc: Ben Gardon <bgardon@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  tools/arch/x86/include/uapi/asm/unistd_64.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
> index 4205ed4158bf..cb52a3a8b8fc 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_64.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
> @@ -1,7 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __NR_userfaultfd
> -#define __NR_userfaultfd 282
> -#endif
>  #ifndef __NR_perf_event_open
>  # define __NR_perf_event_open 298
>  #endif
> --
> 2.33.0.rc2.250.ged5fa647cd-goog
>
