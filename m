Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C77E74AAAF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 07:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjGGFlu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 01:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjGGFlt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 01:41:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E631BEE;
        Thu,  6 Jul 2023 22:41:46 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666ecf9a081so1181093b3a.2;
        Thu, 06 Jul 2023 22:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688708506; x=1691300506;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA6QNDl75tvt5aLRLx9pQj4FIjUYGJr/B33YsnAoOhc=;
        b=ficYMA01ds8ca77DZ0jaRMOHaBwrPtrqXskXdBmaR+bGEpMNGB766GH85iksaqQLTn
         bqVurPTJg/Wn4VCfKZYLtEsfmNENLaHAt+4ClUFF+/Xec5moWL8N9rQ8j3UpZMOozVuf
         ouuZnDvSk4LTQU5NhD+vsJ0QOKNRTJ4UFBoKI80jgHJTThJlg8cnX27oMj+QMIO4jpgg
         hhP4e1UxcSN5Ud2LYwsOsIppf/LOp/N/IBuOqVRIvGPfip2QeMa0KDSva368FyXgv/h5
         2D3FIWpRCdfQAqHqMvZPabDUEMnN5NY82kNFakUE8r+Qhvi0TeAOb/XnFxI6lEhB+eJH
         G8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688708506; x=1691300506;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MA6QNDl75tvt5aLRLx9pQj4FIjUYGJr/B33YsnAoOhc=;
        b=CawePNrjD1x+U2nq+ZhwzhglAh4DX0ZJ0DILbutK/QA7FKc5ayq33U8PJ+C5/51504
         umnPUhJn5ZlVI5TJlHrBHzxGBfyvUMvHerkUyG+i1d2upJLXwKpVdazVMqB/+Dp90C4Q
         hvdGy+BD8MyGKEJ1SD3zJU1jacTJY+qPU1ZEN33GhO11+bg54RGRvUgrFBSzjZ7xDz/6
         ZCy9lCciA/++b0VzcqKp4TN3JqYzzqzzpYW6XevCj1GLusLqPax54rYji+HSyXaaVHHB
         MZdTck22uIsdKm6XK5ca8g0RYLjPTjpqWttBspwLJzRCxlcsa9wJvpq0JOth3UXDsS6k
         FvyQ==
X-Gm-Message-State: ABy/qLYRVg1Tu1x2X/LyTIXUP5C0yAlBi7nXQHK+ExhrccHHrDvWlgZu
        3OYXOeOMXf+WMjrIsWj0Jj/65nxfRNE=
X-Google-Smtp-Source: APBJJlEPIvdyuTU4+FFMk01YPukRyyrjieqLh5loz+OzBr8uTY1fCpjvUKj5w1avjMCVmrMpZYb6Mg==
X-Received: by 2002:a05:6a20:914d:b0:119:be71:1596 with SMTP id x13-20020a056a20914d00b00119be711596mr4236870pzc.13.1688708505830;
        Thu, 06 Jul 2023 22:41:45 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id d2-20020aa78142000000b00662c4ca18ebsm2099825pfn.128.2023.07.06.22.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 22:41:45 -0700 (PDT)
Date:   Thu, 06 Jul 2023 22:41:43 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Tero Kristo <tero.kristo@linux.intel.com>
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
Message-ID: <64a7a597b1e9e_dddea208db@john.notmuch>
In-Reply-To: <CAADnVQK0rzHWxxx7LMFSTuBx18A+6H6AEkKFHNDkPwbPUbsk4Q@mail.gmail.com>
References: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
 <20230703105745.1314475-2-tero.kristo@linux.intel.com>
 <CAADnVQL2Tn+2rP0hVB3kdB0At12qVu+vJ_WbJzrkxqOJ5va2vQ@mail.gmail.com>
 <64a64e46b7d5b_b20ce208de@john.notmuch>
 <4b874e4c-4ad3-590d-3885-b4a3b894524e@linux.intel.com>
 <CAADnVQK0rzHWxxx7LMFSTuBx18A+6H6AEkKFHNDkPwbPUbsk4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/tsc: Add new BPF helper call bpf_rdtsc
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

Alexei Starovoitov wrote:
> On Thu, Jul 6, 2023 at 4:59=E2=80=AFAM Tero Kristo <tero.kristo@linux.i=
ntel.com> wrote:
> >
> >
> > On 06/07/2023 08:16, John Fastabend wrote:
> > > Alexei Starovoitov wrote:
> > >> On Mon, Jul 3, 2023 at 3:58=E2=80=AFAM Tero Kristo <tero.kristo@li=
nux.intel.com> wrote:
> > >>> Currently the raw TSC counter can be read within kernel via rdtsc=
_ordered()
> > >>> and friends, and additionally even userspace has access to it via=
 the
> > >>> RDTSC assembly instruction. BPF programs on the other hand don't =
have
> > >>> direct access to the TSC counter, but alternatively must go throu=
gh the
> > >>> performance subsystem (bpf_perf_event_read), which only provides =
relative
> > >>> value compared to the start point of the program, and is also muc=
h slower
> > >>> than the direct read. Add a new BPF helper definition for bpf_rdt=
sc() which
> > >>> can be used for any accurate profiling needs.
> > >>>
> > >>> A use-case for the new API is for example wakeup latency tracing =
via
> > >>> eBPF on Intel architecture, where it is extremely beneficial to b=
e able
> > >>> to get raw TSC timestamps and compare these directly to the value=

> > >>> programmed to the MSR_IA32_TSC_DEADLINE register. This way a dire=
ct
> > >>> latency value from the hardware interrupt to the execution of the=

> > >>> interrupt handler can be calculated. Having the functionality wit=
hin
> > >>> eBPF also has added benefits of allowing to filter any other rele=
vant
> > >>> data like C-state residency values, and also to drop any irreleva=
nt
> > >>> data points directly in the kernel context, without passing all t=
he
> > >>> data to userspace for post-processing.
> > >>>
> > >>> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > >>> ---
> > >>>   arch/x86/include/asm/msr.h |  1 +
> > >>>   arch/x86/kernel/tsc.c      | 23 +++++++++++++++++++++++
> > >>>   2 files changed, 24 insertions(+)
> > >>>
> > >>> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/ms=
r.h
> > >>> index 65ec1965cd28..3dde673cb563 100644
> > >>> --- a/arch/x86/include/asm/msr.h
> > >>> +++ b/arch/x86/include/asm/msr.h
> > >>> @@ -309,6 +309,7 @@ struct msr *msrs_alloc(void);
> > >>>   void msrs_free(struct msr *msrs);
> > >>>   int msr_set_bit(u32 msr, u8 bit);
> > >>>   int msr_clear_bit(u32 msr, u8 bit);
> > >>> +u64 bpf_rdtsc(void);
> > >>>
> > >>>   #ifdef CONFIG_SMP
> > >>>   int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);=

> > >>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > >>> index 344698852146..ded857abef81 100644
> > >>> --- a/arch/x86/kernel/tsc.c
> > >>> +++ b/arch/x86/kernel/tsc.c
> > >>> @@ -15,6 +15,8 @@
> > >>>   #include <linux/timex.h>
> > >>>   #include <linux/static_key.h>
> > >>>   #include <linux/static_call.h>
> > >>> +#include <linux/btf.h>
> > >>> +#include <linux/btf_ids.h>
> > >>>
> > >>>   #include <asm/hpet.h>
> > >>>   #include <asm/timer.h>
> > >>> @@ -29,6 +31,7 @@
> > >>>   #include <asm/intel-family.h>
> > >>>   #include <asm/i8259.h>
> > >>>   #include <asm/uv/uv.h>
> > >>> +#include <asm/tlbflush.h>
> > >>>
> > >>>   unsigned int __read_mostly cpu_khz;    /* TSC clocks / usec, no=
t used here */
> > >>>   EXPORT_SYMBOL(cpu_khz);
> > >>> @@ -1551,6 +1554,24 @@ void __init tsc_early_init(void)
> > >>>          tsc_enable_sched_clock();
> > >>>   }
> > >>>
> > >>> +u64 bpf_rdtsc(void)
> > >>> +{
> > >>> +       /* Check if Time Stamp is enabled only in ring 0 */
> > >>> +       if (cr4_read_shadow() & X86_CR4_TSD)
> > >>> +               return 0;
> > >> Why check this? It's always enabled in the kernel, no?
> >
> > It is always enabled, but there are certain syscalls that can be used=
 to
> > disable the TSC access for oneself. prctl(PR_SET_TSC, ...) and
> > seccomp(SET_MODE_STRICT,...). Not having the check in place would in
> > theory allow a restricted BPF program to circumvent this (if there ev=
er
> > was such a thing.) But yes, I do agree this part is a bit debatable
> > whether it should be there at all.
> =

> What do you mean 'circumvent' ?
> It's a tracing bpf prog running in the kernel loaded by root
> and reading tsc for the purpose of the kernel.
> There is no unprivileged access to tsc here.
> =

> >
> > >>> +
> > >>> +       return rdtsc_ordered();
> > >> Why _ordered? Why not just rdtsc ?
> > >> Especially since you want to trace latency. Extra lfence will ruin=

> > >> the measurements.
> > >>
> > > If we used it as a fast way to order events on multiple CPUs I
> > > guess we need the lfence? We use ktime_get_ns() now for things
> > > like this when we just need an order counter. We have also
> > > observed time going backwards with this and have heuristics
> > > to correct it but its rare.
> >
> > Yeah, I think it is better to induce some extra latency instead of
> > having some weird ordering issues with the timestamps.
> =

> lfence is not 'some extra latency'.
> I suspect rdtsc_ordered() will be slower than bpf_ktime_get_ns().
> What's the point of using it then?

I would only use it if its faster then bpf_ktime_get_ns() and
have already figured out how to handle rare unordered events
so I think its OK to relax somewhat strict ordering. =


> =

> >
> > Also, things like the ftrace also use rdtsc_ordered() as its underlyi=
ng
> > clock, if you use x86-tsc as the trace clock (see
> > arch/x86/kernel/trace_clock.c.)
> >
> > -Tero
> >


