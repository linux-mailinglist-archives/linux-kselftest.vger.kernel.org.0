Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A977493F7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 05:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjGFDCd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 23:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGFDCc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 23:02:32 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C58E1BCE;
        Wed,  5 Jul 2023 20:02:29 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so2159621fa.1;
        Wed, 05 Jul 2023 20:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688612547; x=1691204547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTKKIJCHTCVFOUWI8yzjuH8jTs7YZY25eKcjmR6z40c=;
        b=WpSlm28dW2EP+fXT1NWDEEGuPxj6Lg1rau7KoRhKFcCbmGfKsLXr9+Iu8Tv4xQGhvE
         Gbow9Crh1C/i/MVAo1uoQLnlMS5GbCz6a7hoPgYYO5Pa5URJjJuJYolO1veiZLKo7YM5
         GqQoEYFaePDqqBYE/I/f+/U3HKsChgVCdsNCbEdkaS7GLhH0vIctk1Mn5WDE0/gzcVVO
         kO6qzOWTux0GOQLtHTq1cQHB0qdY0xpfeBzIGjNIFuJlVAyt8rA6lUWSAvqMyJhmdJhQ
         IZ1MesyS6RtFVeHQ5l+XthklYFZFs99rIMWSbzMkLG37OwD8JH0Rs/NjpLPk5Ubqoly6
         DIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688612547; x=1691204547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTKKIJCHTCVFOUWI8yzjuH8jTs7YZY25eKcjmR6z40c=;
        b=PzeGrDU6yYn8Ohw8uDqx9mYwYd5upTG2TEdKgfjvWZnrpuVq4xXy2L39BVwmBL4/tf
         Vzpji7ESg7OSC9RRrXYAn5VGBj4Clt8HK0yYoB98FNaAUvPNUsUdTZptDYn3PLziXy/F
         2pjgt/NaAio+DXlwoB6BcWMg4cEHim4RzE3Kej6xQD4Ub9Mh5uJ51cxFVpiTloycX4sd
         0fQ9zOW9xv30LDNwQ69u3UonjDaPIZ0z53lHd+yq6g6CtUxquO/AXKSQua9XPqQ+lnoD
         WsPMwRsfiJxe68PiaVOgqLDYULSMlRIhJ1XRbAWH4AMqWDhdZ0V48vyEBuKYl0ClBqwD
         F0sQ==
X-Gm-Message-State: ABy/qLZ8tp4JVqDqedI0tH1LNOqVYBOQCUWFERwLOs+SBZH1RbdYtYXA
        F6ZwScytzaBTucQs9YW2jHbR2VfiRe6junsQeU0=
X-Google-Smtp-Source: APBJJlE/n7LATDpB0GrHw/lFuQ3+lX4DrPgLSokVCx2bDHiganLZureDsLNHp3F9TQSoIyVj782cIBtmePWUC8VcXWk=
X-Received: by 2002:a2e:a40f:0:b0:2b6:efcf:1463 with SMTP id
 p15-20020a2ea40f000000b002b6efcf1463mr345677ljn.6.1688612547169; Wed, 05 Jul
 2023 20:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230703105745.1314475-1-tero.kristo@linux.intel.com> <20230703105745.1314475-2-tero.kristo@linux.intel.com>
In-Reply-To: <20230703105745.1314475-2-tero.kristo@linux.intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 5 Jul 2023 20:02:16 -0700
Message-ID: <CAADnVQL2Tn+2rP0hVB3kdB0At12qVu+vJ_WbJzrkxqOJ5va2vQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/tsc: Add new BPF helper call bpf_rdtsc
To:     Tero Kristo <tero.kristo@linux.intel.com>
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

On Mon, Jul 3, 2023 at 3:58=E2=80=AFAM Tero Kristo <tero.kristo@linux.intel=
.com> wrote:
>
> Currently the raw TSC counter can be read within kernel via rdtsc_ordered=
()
> and friends, and additionally even userspace has access to it via the
> RDTSC assembly instruction. BPF programs on the other hand don't have
> direct access to the TSC counter, but alternatively must go through the
> performance subsystem (bpf_perf_event_read), which only provides relative
> value compared to the start point of the program, and is also much slower
> than the direct read. Add a new BPF helper definition for bpf_rdtsc() whi=
ch
> can be used for any accurate profiling needs.
>
> A use-case for the new API is for example wakeup latency tracing via
> eBPF on Intel architecture, where it is extremely beneficial to be able
> to get raw TSC timestamps and compare these directly to the value
> programmed to the MSR_IA32_TSC_DEADLINE register. This way a direct
> latency value from the hardware interrupt to the execution of the
> interrupt handler can be calculated. Having the functionality within
> eBPF also has added benefits of allowing to filter any other relevant
> data like C-state residency values, and also to drop any irrelevant
> data points directly in the kernel context, without passing all the
> data to userspace for post-processing.
>
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>  arch/x86/include/asm/msr.h |  1 +
>  arch/x86/kernel/tsc.c      | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index 65ec1965cd28..3dde673cb563 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -309,6 +309,7 @@ struct msr *msrs_alloc(void);
>  void msrs_free(struct msr *msrs);
>  int msr_set_bit(u32 msr, u8 bit);
>  int msr_clear_bit(u32 msr, u8 bit);
> +u64 bpf_rdtsc(void);
>
>  #ifdef CONFIG_SMP
>  int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 344698852146..ded857abef81 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -15,6 +15,8 @@
>  #include <linux/timex.h>
>  #include <linux/static_key.h>
>  #include <linux/static_call.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
>
>  #include <asm/hpet.h>
>  #include <asm/timer.h>
> @@ -29,6 +31,7 @@
>  #include <asm/intel-family.h>
>  #include <asm/i8259.h>
>  #include <asm/uv/uv.h>
> +#include <asm/tlbflush.h>
>
>  unsigned int __read_mostly cpu_khz;    /* TSC clocks / usec, not used he=
re */
>  EXPORT_SYMBOL(cpu_khz);
> @@ -1551,6 +1554,24 @@ void __init tsc_early_init(void)
>         tsc_enable_sched_clock();
>  }
>
> +u64 bpf_rdtsc(void)
> +{
> +       /* Check if Time Stamp is enabled only in ring 0 */
> +       if (cr4_read_shadow() & X86_CR4_TSD)
> +               return 0;

Why check this? It's always enabled in the kernel, no?

> +
> +       return rdtsc_ordered();

Why _ordered? Why not just rdtsc ?
Especially since you want to trace latency. Extra lfence will ruin
the measurements.
