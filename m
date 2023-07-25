Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D000D76115D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 12:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjGYKuY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 06:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjGYKuE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 06:50:04 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3E41BE6
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 03:49:58 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-765a4ff26cdso496655985a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 03:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690282197; x=1690886997;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bMmHwdZlQT+P6lJr6em+mpkMjk2rV9wBSh6rSZ0uNY=;
        b=lG40hefI1rqtX4VPi950MewOISlMiKtqIlP9xcF3XCYAb77PkT3OrAkeFX8sRIBCUH
         lUMe8arWl2ZGGtvsaPoaznASXmSLSN6smMtBmFXVLMj7SyJkP8I5sTzRpitBh2kvOSpA
         umt9kEQZvTbov4Lbk9wb/skGslWPm/d8pGPlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690282197; x=1690886997;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bMmHwdZlQT+P6lJr6em+mpkMjk2rV9wBSh6rSZ0uNY=;
        b=AZ6rPOhXnE2KHPvAT5vhTmxi3Jz3mE+NnU0tBBvBDkXa6az4aDZMu0RrLbkT2Mn5BD
         FYxiWvFkG8nOWFjdyB7Hab2tHl+97TesK0wQ1Xe58ulRZMg/a7aFJ/SRzqcoEyRg2SBQ
         A2fQOOnpwWy6HukZWz4MTtUs+OAq33hKMwXsm1egVkjmhra5c8cKJbc3CE+Eht+WPjlV
         6UgOboIcmwtUP7h5OQBko49AhZbLrYmJ9vfNer5pNkC5yeet75SnebMCGIOYrGkL+/GX
         5m7aQSF1fntBneb7u8r7iYEHwh+opmcisz3lr9JNjzSv0QuifyiTj5L8HNFkmQ95HC/K
         LVvg==
X-Gm-Message-State: ABy/qLZ8EQg1Nz1XSAC3FeOMoXB0JP1zxpCsKKfvof/IadKRMh1SsxUj
        SRzf5QR9BrEkIL8xhsZQe0+UAg==
X-Google-Smtp-Source: APBJJlGXysVwoVyL6xHsATW7iGx9aK7yPIYYidloTa4vCgFYT/KC5iWpTFNx4CxxlyjKdputgHklZg==
X-Received: by 2002:a05:620a:220c:b0:765:abeb:a13e with SMTP id m12-20020a05620a220c00b00765abeba13emr2067168qkh.60.1690282197400;
        Tue, 25 Jul 2023 03:49:57 -0700 (PDT)
Received: from smtpclient.apple ([192.145.116.44])
        by smtp.gmail.com with ESMTPSA id o7-20020a05620a15c700b00767cd2dbd82sm3601564qkm.15.2023.07.25.03.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 03:49:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 18/20] context_tracking,x86: Defer kernel text patching IPIs
Date:   Tue, 25 Jul 2023 06:49:45 -0400
Message-Id: <6EBAEEED-6F38-472D-BA31-9C61179EFA2F@joelfernandes.org>
References: <20230720163056.2564824-19-vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
In-Reply-To: <20230720163056.2564824-19-vschneid@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Interesting series Valentin. Some high-level question/comments on this one:

> On Jul 20, 2023, at 12:34 PM, Valentin Schneider <vschneid@redhat.com> wro=
te:
>=20
> =EF=BB=BFtext_poke_bp_batch() sends IPIs to all online CPUs to synchronize=

> them vs the newly patched instruction. CPUs that are executing in userspac=
e
> do not need this synchronization to happen immediately, and this is
> actually harmful interference for NOHZ_FULL CPUs.

Does the amount of harm not correspond to practical frequency of text_poke?=20=

How often does instruction patching really happen? If it is very infrequent
then I am not sure if it is that harmful.

>=20
> As the synchronization IPIs are sent using a blocking call, returning from=

> text_poke_bp_batch() implies all CPUs will observe the patched
> instruction(s), and this should be preserved even if the IPI is deferred.
> In other words, to safely defer this synchronization, any kernel
> instruction leading to the execution of the deferred instruction
> sync (ct_work_flush()) must *not* be mutable (patchable) at runtime.

If it is not infrequent, then are you handling the case where userland
spends multiple seconds before entering the kernel, and all this while
the blocking call waits? Perhaps in such situation you want the real IPI
to be sent out instead of the deferred one?

thanks,

 - Joel


>=20
> This means we must pay attention to mutable instructions in the early entr=
y
> code:
> - alternatives
> - static keys
> - all sorts of probes (kprobes/ftrace/bpf/???)
>=20
> The early entry code leading to ct_work_flush() is noinstr, which gets rid=

> of the probes.
>=20
> Alternatives are safe, because it's boot-time patching (before SMP is
> even brought up) which is before any IPI deferral can happen.
>=20
> This leaves us with static keys. Any static key used in early entry code
> should be only forever-enabled at boot time, IOW __ro_after_init (pretty
> much like alternatives). Objtool is now able to point at static keys that
> don't respect this, and all static keys used in early entry code have now
> been verified as behaving like so.
>=20
> Leverage the new context_tracking infrastructure to defer sync_core() IPIs=

> to a target CPU's next kernel entry.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
> arch/x86/include/asm/context_tracking_work.h |  6 +++--
> arch/x86/include/asm/text-patching.h         |  1 +
> arch/x86/kernel/alternative.c                | 24 ++++++++++++++++----
> arch/x86/kernel/kprobes/core.c               |  4 ++--
> arch/x86/kernel/kprobes/opt.c                |  4 ++--
> arch/x86/kernel/module.c                     |  2 +-
> include/linux/context_tracking_work.h        |  4 ++--
> 7 files changed, 32 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/context_tracking_work.h b/arch/x86/inclu=
de/asm/context_tracking_work.h
> index 5bc29e6b2ed38..2c66687ce00e2 100644
> --- a/arch/x86/include/asm/context_tracking_work.h
> +++ b/arch/x86/include/asm/context_tracking_work.h
> @@ -2,11 +2,13 @@
> #ifndef _ASM_X86_CONTEXT_TRACKING_WORK_H
> #define _ASM_X86_CONTEXT_TRACKING_WORK_H
>=20
> +#include <asm/sync_core.h>
> +
> static __always_inline void arch_context_tracking_work(int work)
> {
>    switch (work) {
> -    case CONTEXT_WORK_n:
> -        // Do work...
> +    case CONTEXT_WORK_SYNC:
> +        sync_core();
>        break;
>    }
> }
> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/t=
ext-patching.h
> index 29832c338cdc5..b6939e965e69d 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -43,6 +43,7 @@ extern void text_poke_early(void *addr, const void *opco=
de, size_t len);
>  */
> extern void *text_poke(void *addr, const void *opcode, size_t len);
> extern void text_poke_sync(void);
> +extern void text_poke_sync_deferrable(void);
> extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
> extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
> extern void *text_poke_copy_locked(void *addr, const void *opcode, size_t l=
en, bool core_ok);
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c=

> index 72646d75b6ffe..fcce480e1919e 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -18,6 +18,7 @@
> #include <linux/mmu_context.h>
> #include <linux/bsearch.h>
> #include <linux/sync_core.h>
> +#include <linux/context_tracking.h>
> #include <asm/text-patching.h>
> #include <asm/alternative.h>
> #include <asm/sections.h>
> @@ -1933,9 +1934,24 @@ static void do_sync_core(void *info)
>    sync_core();
> }
>=20
> +static bool do_sync_core_defer_cond(int cpu, void *info)
> +{
> +    return !ct_set_cpu_work(cpu, CONTEXT_WORK_SYNC);
> +}
> +
> +static void __text_poke_sync(smp_cond_func_t cond_func)
> +{
> +    on_each_cpu_cond(cond_func, do_sync_core, NULL, 1);
> +}
> +
> void text_poke_sync(void)
> {
> -    on_each_cpu(do_sync_core, NULL, 1);
> +    __text_poke_sync(NULL);
> +}
> +
> +void text_poke_sync_deferrable(void)
> +{
> +    __text_poke_sync(do_sync_core_defer_cond);
> }
>=20
> /*
> @@ -2145,7 +2161,7 @@ static void text_poke_bp_batch(struct text_poke_loc *=
tp, unsigned int nr_entries
>        text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
>    }
>=20
> -    text_poke_sync();
> +    text_poke_sync_deferrable();
>=20
>    /*
>     * Second step: update all but the first byte of the patched range.
> @@ -2207,7 +2223,7 @@ static void text_poke_bp_batch(struct text_poke_loc *=
tp, unsigned int nr_entries
>         * not necessary and we'd be safe even without it. But
>         * better safe than sorry (plus there's not only Intel).
>         */
> -        text_poke_sync();
> +        text_poke_sync_deferrable();
>    }
>=20
>    /*
> @@ -2228,7 +2244,7 @@ static void text_poke_bp_batch(struct text_poke_loc *=
tp, unsigned int nr_entries
>    }
>=20
>    if (do_sync)
> -        text_poke_sync();
> +        text_poke_sync_deferrable();
>=20
>    /*
>     * Remove and wait for refs to be zero.
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core=
.c
> index f7f6042eb7e6c..a38c914753397 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -735,7 +735,7 @@ void arch_arm_kprobe(struct kprobe *p)
>    u8 int3 =3D INT3_INSN_OPCODE;
>=20
>    text_poke(p->addr, &int3, 1);
> -    text_poke_sync();
> +    text_poke_sync_deferrable();
>    perf_event_text_poke(p->addr, &p->opcode, 1, &int3, 1);
> }
>=20
> @@ -745,7 +745,7 @@ void arch_disarm_kprobe(struct kprobe *p)
>=20
>    perf_event_text_poke(p->addr, &int3, 1, &p->opcode, 1);
>    text_poke(p->addr, &p->opcode, 1);
> -    text_poke_sync();
> +    text_poke_sync_deferrable();
> }
>=20
> void arch_remove_kprobe(struct kprobe *p)
> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c=

> index 57b0037d0a996..88451a744ceda 100644
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -521,11 +521,11 @@ void arch_unoptimize_kprobe(struct optimized_kprobe *=
op)
>           JMP32_INSN_SIZE - INT3_INSN_SIZE);
>=20
>    text_poke(addr, new, INT3_INSN_SIZE);
> -    text_poke_sync();
> +    text_poke_sync_deferrable();
>    text_poke(addr + INT3_INSN_SIZE,
>          new + INT3_INSN_SIZE,
>          JMP32_INSN_SIZE - INT3_INSN_SIZE);
> -    text_poke_sync();
> +    text_poke_sync_deferrable();
>=20
>    perf_event_text_poke(op->kp.addr, old, JMP32_INSN_SIZE, new, JMP32_INSN=
_SIZE);
> }
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index b05f62ee2344b..8b4542dc51b6d 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -242,7 +242,7 @@ static int write_relocate_add(Elf64_Shdr *sechdrs,
>                   write, apply);
>=20
>    if (!early) {
> -        text_poke_sync();
> +        text_poke_sync_deferrable();
>        mutex_unlock(&text_mutex);
>    }
>=20
> diff --git a/include/linux/context_tracking_work.h b/include/linux/context=
_tracking_work.h
> index fb74db8876dd2..13fc97b395030 100644
> --- a/include/linux/context_tracking_work.h
> +++ b/include/linux/context_tracking_work.h
> @@ -5,12 +5,12 @@
> #include <linux/bitops.h>
>=20
> enum {
> -    CONTEXT_WORK_n_OFFSET,
> +    CONTEXT_WORK_SYNC_OFFSET,
>    CONTEXT_WORK_MAX_OFFSET
> };
>=20
> enum ct_work {
> -    CONTEXT_WORK_n        =3D BIT(CONTEXT_WORK_n_OFFSET),
> +    CONTEXT_WORK_SYNC     =3D BIT(CONTEXT_WORK_SYNC_OFFSET),
>    CONTEXT_WORK_MAX      =3D BIT(CONTEXT_WORK_MAX_OFFSET)
> };
>=20
> --=20
> 2.31.1
>=20
