Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721A77494EC
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 07:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjGFFQ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 01:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGFFQ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 01:16:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA05D131;
        Wed,  5 Jul 2023 22:16:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666ed230c81so358681b3a.0;
        Wed, 05 Jul 2023 22:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688620617; x=1691212617;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx7w2Kkc75R0iLRtqLk6J1lR9xFeYMxQMIJBRyYkH78=;
        b=seCUmcP4lI6wdy0X4XOKpUvypqAO6BqDAiDkndg1lM9nIdWIeidGgqdzoq+cO/sGOL
         iW+bUDaoevC6dICM5bryXfOJh7QQ0F+GcwjIJWNaAOBwajqOALS4H4qmYKNX6jURSo2H
         wsIZ7mkjO1DQNyQB3uCP/CIWyNFQmBkm+64G79jKePEPPRH9wvjottZF5aRy/c8VyssW
         CaiR/VzphbKL7wym3o1uXQJYAynKUItVDnhzOhvs/jpWb58oi/qMrOZRjQVmYMISjqi6
         hwwqsHFw82ulyDEpQk+/bIaWpzLEIPQm5ICi1IPwJqt0cx4ohtT0e7VKEZaxtxgV4Lj9
         l8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688620617; x=1691212617;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mx7w2Kkc75R0iLRtqLk6J1lR9xFeYMxQMIJBRyYkH78=;
        b=N2wvlFa8UnVJDmQENVpvgTNQOviHw1AeSq5kAUGdGwGNwp5IvERqEXR8kLzPtEXCfu
         +5GbPeDzs1zNm4TPCnqe0IGCqfle3wUmjelHwDhgSoGXFlOL7/rZ+RzmaoHCCKQhbmxm
         pMXxbIXSUnRwSZEgEE9cqbTUb/GPSbrUcr+tMffSTxcC8N674lq70ayk0sciWGpol4tI
         jnPwI5Vo1CoAMYlWSX8NTPGyni8kcaScf3aHer1c4GXEQ4K1elOeOhike8LoZgdJxpA4
         TSfnmQYiTD+jW4a1h0ESuzeOss1Xu5inw0G9cNWlcAaGwlOM+YPwkhQlDb7J2aFaZhn9
         F3xw==
X-Gm-Message-State: ABy/qLZe332+u+u10DvnRkRYZ26SL/+KCsZGH6m09K9aI1oS2xnU9GXG
        yfiO/uuySTd/JBQgDttdlNU=
X-Google-Smtp-Source: APBJJlEMMgVkMBr2cG8PfgQ9ELM03LrpG8fUZq7Uv4DlAHcRjZmgHr6VAuqLcEHtNIpfg1xW5HBO/g==
X-Received: by 2002:a05:6a00:1709:b0:67c:5c21:b430 with SMTP id h9-20020a056a00170900b0067c5c21b430mr1163971pfc.33.1688620616758;
        Wed, 05 Jul 2023 22:16:56 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b00679a4b56e41sm392371pfo.43.2023.07.05.22.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 22:16:56 -0700 (PDT)
Date:   Wed, 05 Jul 2023 22:16:54 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Tero Kristo <tero.kristo@linux.intel.com>
Cc:     Shuah Khan <shuah@kernel.org>,
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
Message-ID: <64a64e46b7d5b_b20ce208de@john.notmuch>
In-Reply-To: <CAADnVQL2Tn+2rP0hVB3kdB0At12qVu+vJ_WbJzrkxqOJ5va2vQ@mail.gmail.com>
References: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
 <20230703105745.1314475-2-tero.kristo@linux.intel.com>
 <CAADnVQL2Tn+2rP0hVB3kdB0At12qVu+vJ_WbJzrkxqOJ5va2vQ@mail.gmail.com>
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
> On Mon, Jul 3, 2023 at 3:58=E2=80=AFAM Tero Kristo <tero.kristo@linux.i=
ntel.com> wrote:
> >
> > Currently the raw TSC counter can be read within kernel via rdtsc_ord=
ered()
> > and friends, and additionally even userspace has access to it via the=

> > RDTSC assembly instruction. BPF programs on the other hand don't have=

> > direct access to the TSC counter, but alternatively must go through t=
he
> > performance subsystem (bpf_perf_event_read), which only provides rela=
tive
> > value compared to the start point of the program, and is also much sl=
ower
> > than the direct read. Add a new BPF helper definition for bpf_rdtsc()=
 which
> > can be used for any accurate profiling needs.
> >
> > A use-case for the new API is for example wakeup latency tracing via
> > eBPF on Intel architecture, where it is extremely beneficial to be ab=
le
> > to get raw TSC timestamps and compare these directly to the value
> > programmed to the MSR_IA32_TSC_DEADLINE register. This way a direct
> > latency value from the hardware interrupt to the execution of the
> > interrupt handler can be calculated. Having the functionality within
> > eBPF also has added benefits of allowing to filter any other relevant=

> > data like C-state residency values, and also to drop any irrelevant
> > data points directly in the kernel context, without passing all the
> > data to userspace for post-processing.
> >
> > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > ---
> >  arch/x86/include/asm/msr.h |  1 +
> >  arch/x86/kernel/tsc.c      | 23 +++++++++++++++++++++++
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> > index 65ec1965cd28..3dde673cb563 100644
> > --- a/arch/x86/include/asm/msr.h
> > +++ b/arch/x86/include/asm/msr.h
> > @@ -309,6 +309,7 @@ struct msr *msrs_alloc(void);
> >  void msrs_free(struct msr *msrs);
> >  int msr_set_bit(u32 msr, u8 bit);
> >  int msr_clear_bit(u32 msr, u8 bit);
> > +u64 bpf_rdtsc(void);
> >
> >  #ifdef CONFIG_SMP
> >  int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 344698852146..ded857abef81 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -15,6 +15,8 @@
> >  #include <linux/timex.h>
> >  #include <linux/static_key.h>
> >  #include <linux/static_call.h>
> > +#include <linux/btf.h>
> > +#include <linux/btf_ids.h>
> >
> >  #include <asm/hpet.h>
> >  #include <asm/timer.h>
> > @@ -29,6 +31,7 @@
> >  #include <asm/intel-family.h>
> >  #include <asm/i8259.h>
> >  #include <asm/uv/uv.h>
> > +#include <asm/tlbflush.h>
> >
> >  unsigned int __read_mostly cpu_khz;    /* TSC clocks / usec, not use=
d here */
> >  EXPORT_SYMBOL(cpu_khz);
> > @@ -1551,6 +1554,24 @@ void __init tsc_early_init(void)
> >         tsc_enable_sched_clock();
> >  }
> >
> > +u64 bpf_rdtsc(void)
> > +{
> > +       /* Check if Time Stamp is enabled only in ring 0 */
> > +       if (cr4_read_shadow() & X86_CR4_TSD)
> > +               return 0;
> =

> Why check this? It's always enabled in the kernel, no?
> =

> > +
> > +       return rdtsc_ordered();
> =

> Why _ordered? Why not just rdtsc ?
> Especially since you want to trace latency. Extra lfence will ruin
> the measurements.
> =


If we used it as a fast way to order events on multiple CPUs I
guess we need the lfence? We use ktime_get_ns() now for things
like this when we just need an order counter. We have also
observed time going backwards with this and have heuristics
to correct it but its rare.=
