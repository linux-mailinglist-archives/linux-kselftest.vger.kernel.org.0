Return-Path: <linux-kselftest+bounces-21975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 074739C7FE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 02:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D23CB22996
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 01:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B6A1E3DCF;
	Thu, 14 Nov 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Pb+djdOC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D91E3799
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731547229; cv=none; b=HjdttmuL5vHzUEYKGyDGahLvAYdoodGcMWf9ghELGAF+Kdcj8Kd4Uwn8MWNWcaX6JNcBNJMjdUQFJXmAGlLxqUMuJTKIqZ+W0YQVgnbx0RaS4QD84e6OGXNMEn37+Se/O1I06irXhkV55g7ba1cxL44TuOZPzzNFZ40A7snoRuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731547229; c=relaxed/simple;
	bh=xSvom9lskxNK0UF5iZb6SncOtreR76x57qIy79NHHvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGE+npKQ3I9PLDU4w5vU0o7kl2YsRIfwOdWQlDQHt/3KEcBh/Tb3a84CBJva2/poJOxSN3dl1vtJjZN12Gc/TVUhrLuIrw44Nc6ZEgWER7pWowBhrj7aWypNwaJsoSUZg4Z3FjTfn0QLPepXd39aYnsjQXRck4aa9EoYGldVS0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Pb+djdOC; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-296085d59caso48428fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 17:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1731547226; x=1732152026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEwME0rw8Umq6ByU2WCdJWTmv3KeHZlgw9873wiLpdQ=;
        b=Pb+djdOC8ubPNcQF6UlYVgL8+cG8xSjZKorhsLjmvqOaSPkiUVQ9+btmYUmX5jRUQx
         LrqmZxZhh8iRi9GJ9sOBVElfln9VTN2FIK55XE0exQgaFHSTgXKuougMMgCeK5d5MHjY
         FGSLd0dVbpYZAlJFYq7DV/ZIBuZXxvEewz28x9/rYsuquYJjpaH4ER+bF9up5CgEVEdm
         fW1Jakt4kJPZeRAQH3Lvpnsadau/F8hX/WR7ZSBXGSsqBcJIY+2s6xXmg6sHOxb82U8Q
         b4aBYjZfhkxVAtalOaVhDaF+IQv9Jvh5s8Xbn+f35KVQyr/9qSRpRD1ZZORFWdjHkIif
         sQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731547226; x=1732152026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEwME0rw8Umq6ByU2WCdJWTmv3KeHZlgw9873wiLpdQ=;
        b=MtfSTgrmS+OE00gGgdxdyeKJ3Lq4SxteBM9zKkZmzK7vDgt1ithKj0wvymeS4k1Isw
         9zLhpFhXLpRdDyKxa2cdWfY0wYifyErbxH71B9XEX1U4ZRxi5JpHvMILMpQ8pojPmHr/
         CirYgvrASAAL4vnFeVW2n4buHtOAcMQz16u7ufTc6TLukAs8Dm6wa+CHKMZ5ffJZyfw3
         6/UOQUJpqXRi4mEFbzHOevJRWX6QWfdoBCZNr2LuYPpn2r0jDZgtBWzyhOn3ZXg5kxXN
         2dYnRjTf3C5czSBe+m9ojzqORxLV+8iHLCcLufnRXAZojcuzvNMyHqBjzLhCm+b2YuAX
         T5TA==
X-Forwarded-Encrypted: i=1; AJvYcCV2yFS5+puBkQAPqNLdCHOi3AAgM7swDUrZWykLYi7eKD1/cZUl2HUVx1BLYZrQjTgT7u1RXCjrZ7n5CJoVHNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6K0jfMlr3axGBXK4iHJOpy+YXeRsWx9SS88oh5sUpYv5H8KAi
	7aqaozkQ9H+61iA8pFolQWwsUtwRRYpuy9ettabGR1ZAvRejm079BYks5u2P3CdZi9XNVvKC/VX
	gVK9A6JkB0AlZKnYjl+rrzV0eDGiONy9joYMeJA==
X-Google-Smtp-Source: AGHT+IEA0jv4B7iCg3zwq7SuzwM249FvuvavDHpayC9Iml6orm79ui/r12Xx7CfDO8cyCb2ZZ1C/3tpsPtuzZFHDjDU=
X-Received: by 2002:a05:6870:469e:b0:287:8706:ae3 with SMTP id
 586e51a60fabf-29560059eafmr20528628fac.11.1731547226302; Wed, 13 Nov 2024
 17:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
 <20241111-v5_user_cfi_series-v8-24-dce14aa30207@rivosinc.com>
 <CAKddAkCCVjNHUinPWtOiK8Ki_ZkdoUCawfv1-+0B69J_1aJv5Q@mail.gmail.com> <ZzVNKvCu4MOs7O5z@debug.ba.rivosinc.com>
In-Reply-To: <ZzVNKvCu4MOs7O5z@debug.ba.rivosinc.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 14 Nov 2024 09:20:14 +0800
Message-ID: <CAKddAkDbGYeONaksq6fzLzx47BHZo3Ar7Sog3MOgf7Y+Birovw@mail.gmail.com>
Subject: Re: [PATCH v8 24/29] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Deepak

On Thu, Nov 14, 2024 at 9:06=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> On Thu, Nov 14, 2024 at 12:13:38AM +0800, Nick Hu wrote:
> >Hi Deepak
> >
> >On Tue, Nov 12, 2024 at 5:08=E2=80=AFAM Deepak Gupta <debug@rivosinc.com=
> wrote:
> >>
> >> Kernel will have to perform shadow stack operations on user shadow sta=
ck.
> >> Like during signal delivery and sigreturn, shadow stack token must be
> >> created and validated respectively. Thus shadow stack access for kerne=
l
> >> must be enabled.
> >>
> >> In future when kernel shadow stacks are enabled for linux kernel, it m=
ust
> >> be enabled as early as possible for better coverage and prevent imbala=
nce
> >> between regular stack and shadow stack. After `relocate_enable_mmu` ha=
s
> >> been done, this is as early as possible it can enabled.
> >>
> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> >> ---
> >>  arch/riscv/kernel/asm-offsets.c |  4 ++++
> >>  arch/riscv/kernel/head.S        | 12 ++++++++++++
> >>  2 files changed, 16 insertions(+)
> >>
> >> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-o=
ffsets.c
> >> index 766bd33f10cb..a22ab8a41672 100644
> >> --- a/arch/riscv/kernel/asm-offsets.c
> >> +++ b/arch/riscv/kernel/asm-offsets.c
> >> @@ -517,4 +517,8 @@ void asm_offsets(void)
> >>         DEFINE(FREGS_A6,            offsetof(struct ftrace_regs, a6));
> >>         DEFINE(FREGS_A7,            offsetof(struct ftrace_regs, a7));
> >>  #endif
> >> +       DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
> >> +       DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
> >> +       DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
> >> +       DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
> >>  }
> >> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> >> index 356d5397b2a2..6244408ca917 100644
> >> --- a/arch/riscv/kernel/head.S
> >> +++ b/arch/riscv/kernel/head.S
> >> @@ -164,6 +164,12 @@ secondary_start_sbi:
> >>         call relocate_enable_mmu
> >>  #endif
> >>         call .Lsetup_trap_vector
> >> +       li a7, SBI_EXT_FWFT
> >> +       li a6, SBI_EXT_FWFT_SET
> >> +       li a0, SBI_FWFT_SHADOW_STACK
> >> +       li a1, 1 /* enable supervisor to access shadow stack access */
> >> +       li a2, SBI_FWFT_SET_FLAG_LOCK
> >> +       ecall
> >>         scs_load_current
> >>         call smp_callin
> >>  #endif /* CONFIG_SMP */
> >> @@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
> >>         la tp, init_task
> >>         la sp, init_thread_union + THREAD_SIZE
> >>         addi sp, sp, -PT_SIZE_ON_STACK
> >> +       li a7, SBI_EXT_FWFT
> >> +       li a6, SBI_EXT_FWFT_SET
> >> +       li a0, SBI_FWFT_SHADOW_STACK
> >> +       li a1, 1 /* enable supervisor to access shadow stack access */
> >> +       li a2, SBI_FWFT_SET_FLAG_LOCK
> >> +       ecall
> >>         scs_load_current
> >>
> >>  #ifdef CONFIG_KASAN
> >>
> >> --
> >> 2.45.0
> >>
> >Should we clear the SBI_FWFT_SET_FLAG_LOCK before the cpu hotplug
> >otherwise the menvcfg.sse won't be set by the fwft set sbi call when
> >the hotplug cpu back to kernel?
>
> Hmm...
>
> An incoming hotplug CPU has no features setup on it.
> I see that `sbi_cpu_start` will supply `secondary_start_sbi` as start
> up code for incoming CPU. `secondary_start_sbi` is in head.S which conver=
ges
> in `.Lsecondary_start_common`. And thus hotplugged CPU should be
> issuing shadow stack set FWFT sbi as well.
>
> Am I missing something ?
>
This is the correct flow. However the opensbi will deny it due to the
SBI_FWFT_SET_FLAG_LOCK already being set.
So the menvcfg.sse will not set by this flow.

if (conf->flags & SBI_FWFT_SET_FLAG_LOCK)
                return SBI_EDENIED;

Regards,
Nick
> >
> >Regards,
> >Nick
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv

