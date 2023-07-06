Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D110374A48E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 21:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjGFTve (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 15:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGFTvc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 15:51:32 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B298E1FC4;
        Thu,  6 Jul 2023 12:51:29 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b703a0453fso17067641fa.3;
        Thu, 06 Jul 2023 12:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688673088; x=1691265088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgieecZWTUuXEPx1wGrMdeFVGmlpK0/k5HVeYL3HOg0=;
        b=rWCcZv1/dLtL/JLJ861MyL5B54iLbDsJBjj0vwGBe118DpBzSrzN+VkRMXQ5xkikZ6
         gKqJcM3Y27C9QU77OZpea1B6rxI5pN6lsDrJmugBU/rpfEQbSu0lWuvQwzEk5q2ftlaI
         N21Mz3r0Q7dj0IiiqhY8Jm2ex/6RqHXrfok3DIwcyvFWuW+IH0T7zvlH071VBDxgD7sv
         CXkEYua5Ly/N35XVy9+jPSa4UGb/eHLppVidwzZXax3KEwsShmFwCtJyjmWMLfBl13yO
         N1v9PFYVRfYFs+qWn9MFm1TfilmaEUhqNN76zNc2CTcHcpuo7ODva/i/rnAyktxN7VbQ
         n6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688673088; x=1691265088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgieecZWTUuXEPx1wGrMdeFVGmlpK0/k5HVeYL3HOg0=;
        b=htzQsngFLv6gOeWEHiOu2ljUL2SebbunKSjqw22zpxS/Z7z/wpkVsawSwsDJw8W0qH
         TmSCplUda2r+i7dZjigaJaSTaWNxS3GRTz4uXUBJtYdGko6eXTAe6yUEmpz9ZCcKrXKO
         wCP5KCOgStpLtk6Wl4P1p0RMiQER2wT1jyS019pf5hhQyotaqHz2qxRHRvTKmK+kCLch
         b0bFgX2oi4wTn1zJGlnx/emY7rYZsunRQp9MXHCDJ0WcU8GC0g3TXkskE7DTMDl40/he
         hWCYK8pxpDobkQzTRJjKro8N1adSO5ggrArQ7xR87K7hyr2jZzmpfM/FgP66URRqkMUg
         URsw==
X-Gm-Message-State: ABy/qLa8ta+lKQY7vt2gc+XFVy4vflH/6p4jzyzILZyzsK+TOzMI3hSU
        qtTVxOvvHro8czgwQ2rCddM5gQ9+ooCvH1nwmfeUctdslYg=
X-Google-Smtp-Source: APBJJlEwASUXHveD3DnsS+U8M73zhlC/QfqVRYy6fEn7rTXXfZKa+5+C576cGdN4Ho3+U8K3nli+4gavaEKHGZqL5z4=
X-Received: by 2002:a2e:380b:0:b0:2b6:fe55:7318 with SMTP id
 f11-20020a2e380b000000b002b6fe557318mr2761393lja.12.1688673087592; Thu, 06
 Jul 2023 12:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
 <20230703105745.1314475-2-tero.kristo@linux.intel.com> <CAADnVQL2Tn+2rP0hVB3kdB0At12qVu+vJ_WbJzrkxqOJ5va2vQ@mail.gmail.com>
 <64a64e46b7d5b_b20ce208de@john.notmuch> <4b874e4c-4ad3-590d-3885-b4a3b894524e@linux.intel.com>
In-Reply-To: <4b874e4c-4ad3-590d-3885-b4a3b894524e@linux.intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 6 Jul 2023 12:51:16 -0700
Message-ID: <CAADnVQK0rzHWxxx7LMFSTuBx18A+6H6AEkKFHNDkPwbPUbsk4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/tsc: Add new BPF helper call bpf_rdtsc
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 6, 2023 at 4:59=E2=80=AFAM Tero Kristo <tero.kristo@linux.intel=
.com> wrote:
>
>
> On 06/07/2023 08:16, John Fastabend wrote:
> > Alexei Starovoitov wrote:
> >> On Mon, Jul 3, 2023 at 3:58=E2=80=AFAM Tero Kristo <tero.kristo@linux.=
intel.com> wrote:
> >>> Currently the raw TSC counter can be read within kernel via rdtsc_ord=
ered()
> >>> and friends, and additionally even userspace has access to it via the
> >>> RDTSC assembly instruction. BPF programs on the other hand don't have
> >>> direct access to the TSC counter, but alternatively must go through t=
he
> >>> performance subsystem (bpf_perf_event_read), which only provides rela=
tive
> >>> value compared to the start point of the program, and is also much sl=
ower
> >>> than the direct read. Add a new BPF helper definition for bpf_rdtsc()=
 which
> >>> can be used for any accurate profiling needs.
> >>>
> >>> A use-case for the new API is for example wakeup latency tracing via
> >>> eBPF on Intel architecture, where it is extremely beneficial to be ab=
le
> >>> to get raw TSC timestamps and compare these directly to the value
> >>> programmed to the MSR_IA32_TSC_DEADLINE register. This way a direct
> >>> latency value from the hardware interrupt to the execution of the
> >>> interrupt handler can be calculated. Having the functionality within
> >>> eBPF also has added benefits of allowing to filter any other relevant
> >>> data like C-state residency values, and also to drop any irrelevant
> >>> data points directly in the kernel context, without passing all the
> >>> data to userspace for post-processing.
> >>>
> >>> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> >>> ---
> >>>   arch/x86/include/asm/msr.h |  1 +
> >>>   arch/x86/kernel/tsc.c      | 23 +++++++++++++++++++++++
> >>>   2 files changed, 24 insertions(+)
> >>>
> >>> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> >>> index 65ec1965cd28..3dde673cb563 100644
> >>> --- a/arch/x86/include/asm/msr.h
> >>> +++ b/arch/x86/include/asm/msr.h
> >>> @@ -309,6 +309,7 @@ struct msr *msrs_alloc(void);
> >>>   void msrs_free(struct msr *msrs);
> >>>   int msr_set_bit(u32 msr, u8 bit);
> >>>   int msr_clear_bit(u32 msr, u8 bit);
> >>> +u64 bpf_rdtsc(void);
> >>>
> >>>   #ifdef CONFIG_SMP
> >>>   int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
> >>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> >>> index 344698852146..ded857abef81 100644
> >>> --- a/arch/x86/kernel/tsc.c
> >>> +++ b/arch/x86/kernel/tsc.c
> >>> @@ -15,6 +15,8 @@
> >>>   #include <linux/timex.h>
> >>>   #include <linux/static_key.h>
> >>>   #include <linux/static_call.h>
> >>> +#include <linux/btf.h>
> >>> +#include <linux/btf_ids.h>
> >>>
> >>>   #include <asm/hpet.h>
> >>>   #include <asm/timer.h>
> >>> @@ -29,6 +31,7 @@
> >>>   #include <asm/intel-family.h>
> >>>   #include <asm/i8259.h>
> >>>   #include <asm/uv/uv.h>
> >>> +#include <asm/tlbflush.h>
> >>>
> >>>   unsigned int __read_mostly cpu_khz;    /* TSC clocks / usec, not us=
ed here */
> >>>   EXPORT_SYMBOL(cpu_khz);
> >>> @@ -1551,6 +1554,24 @@ void __init tsc_early_init(void)
> >>>          tsc_enable_sched_clock();
> >>>   }
> >>>
> >>> +u64 bpf_rdtsc(void)
> >>> +{
> >>> +       /* Check if Time Stamp is enabled only in ring 0 */
> >>> +       if (cr4_read_shadow() & X86_CR4_TSD)
> >>> +               return 0;
> >> Why check this? It's always enabled in the kernel, no?
>
> It is always enabled, but there are certain syscalls that can be used to
> disable the TSC access for oneself. prctl(PR_SET_TSC, ...) and
> seccomp(SET_MODE_STRICT,...). Not having the check in place would in
> theory allow a restricted BPF program to circumvent this (if there ever
> was such a thing.) But yes, I do agree this part is a bit debatable
> whether it should be there at all.

What do you mean 'circumvent' ?
It's a tracing bpf prog running in the kernel loaded by root
and reading tsc for the purpose of the kernel.
There is no unprivileged access to tsc here.

>
> >>> +
> >>> +       return rdtsc_ordered();
> >> Why _ordered? Why not just rdtsc ?
> >> Especially since you want to trace latency. Extra lfence will ruin
> >> the measurements.
> >>
> > If we used it as a fast way to order events on multiple CPUs I
> > guess we need the lfence? We use ktime_get_ns() now for things
> > like this when we just need an order counter. We have also
> > observed time going backwards with this and have heuristics
> > to correct it but its rare.
>
> Yeah, I think it is better to induce some extra latency instead of
> having some weird ordering issues with the timestamps.

lfence is not 'some extra latency'.
I suspect rdtsc_ordered() will be slower than bpf_ktime_get_ns().
What's the point of using it then?

>
> Also, things like the ftrace also use rdtsc_ordered() as its underlying
> clock, if you use x86-tsc as the trace clock (see
> arch/x86/kernel/trace_clock.c.)
>
> -Tero
>
