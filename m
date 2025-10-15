Return-Path: <linux-kselftest+bounces-43260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB50BE09D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 22:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C68319A7FE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 20:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167752C027D;
	Wed, 15 Oct 2025 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJfr3dfN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5180728A3F2
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559535; cv=none; b=NLK4EkhqeQ4ojIslGwOTelXJDoC+tqjGDhuGedaw7H0ZoxJG96iSHG8exif8cjojtIVq/sy8dAw6DaYB2pUgJt3z6zyf9VopryqF/E8YtQxnnrcaf5F3upBy6im2oWMpi8EYGyO+/ZZ043FY3DYT4nc1bauHR2Kb4qZ+t0NUICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559535; c=relaxed/simple;
	bh=RMU247VBfdCk1PNbG3GvfLLm7n0H5cFPzUvQhXwUYYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccXrtyk8Xqaf5dytx/GuLS95cgSe3TZzamOejYRAio0XPwrI+f7/pilYxPBpC0z+6J7Cqzc61/297xDtdzTHuQzVpA1tNJrvIUKzcyRDsLtNQCLR2Q4azalORDdHEZcvm1xpKmXIh9k79Ogm1Y4SNrQYS268m/7APxlgsNf9fnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJfr3dfN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63bfbbbdd0bso1082361a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760559531; x=1761164331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJg9X9PlIoB/ST2nyyuoIjib7x+oaPTrM9+LsomMQTU=;
        b=UJfr3dfNkLHutdKzb+g0EIecpLScCVUKlYyIgzB4++gjqZR84q4eeXDpdCMxKFkFa1
         cC7eTs/h7prczMZm/TNHxmKRch1fcmZO0yrj5w0UtykTrex26ktnTFIQ4Izjqxgg0m2K
         RFaXb6F9j7kfGjwgtA3OewjeC8XO1tGknEarIHAk6vJgsennBpm9vChhJ/UpO9E+K78f
         Th76Ng+lzjRDB/IrWGN8Xbxm/Gf4ed19SAbsBTf3QhPQmhPruijC7JmCDLMbzNiC6Y+C
         Peheo9MP9aWuhN/bMtZpeUNUzhi/ZeTY+l3FevokjzeUMaRcslAXi3WxcjqcRF4ZF5ml
         xfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760559531; x=1761164331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJg9X9PlIoB/ST2nyyuoIjib7x+oaPTrM9+LsomMQTU=;
        b=nOXifAoxVYCHd5PejacGdW7T1pvBAbosnaefOU0Puf66Le7cBLKZ7ele7/wTQ5VI02
         xjnf91UGTyZA2ytOjTq5Eu1AprV6nwPLSgjYHKhtUp2s3MW7eS6/4QjISLXhqbyvDVjf
         PoiwQl+RcCXwjcYzmlZ+xE9dgFqWgSdtU7yx0qjc6nBwHroJDX3eOU/9F3UBBlKBwC7P
         hXKBLrtrDpsFKTzN3CpcVhkMrAvJv32TPBbpUUx2acinD/AG5e9rtYtxRnhFhNTxbROB
         564GAs8C2FmJJcj2xhvGaPb8XNzq8YC69tCrx1yaYGHq0FW2qDQExJo+zWhF3+aodXON
         s7bQ==
X-Forwarded-Encrypted: i=1; AJvYcCURKXpBtP7YWm3vFxRAwhnDop9CTgh5TttRThX2797rXm01AxuGV5APmA65cr2TOd0sEaQkxsVzhhjBTPf2PrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeSUk5Yfwa91Up/k7CQG3f4mq+rFbLoVFhhWQi8T74xHCycoHe
	SBa+kkAWRsqPMllPjQddWtFSAKJE+Qj9mwPjCqdxJ/pGpKJTfVFd7gcsXnRa/neLVogf7FiViyg
	rI39/+efN5QOQjvf5JjV0hUvPEp5cEzU=
X-Gm-Gg: ASbGncvrpOIAe39Hb21fA7k8aQLzbyC3z+SB1qGYK5c0icBp8OawxU9J/c4Znxy8yl8
	86O5FZuPhl76fFmjic3VdHxL6bff2vU+d2ryLIThyQ2+TXz/l2hNfrQrodmltoy4glf1vHrOzfP
	oYQp8LG0fGzZ2NE9j4Cy7/STP5DuQ/V7mfTaX6/I7lSalpkH0ZMes0VnOQr2lXmnR5RHiQlvGiO
	5q7LUd2DAf8CLAJvx7gDFo=
X-Google-Smtp-Source: AGHT+IENKf4WvhhBBJ2iUPr22yFEcCC4h7iTdaK4CP7B8HphHP1g/duXTL3pcv4SsEGCtifhINNijtPNnW4w/XdOi2o=
X-Received: by 2002:a05:6402:5205:b0:634:5297:e3bc with SMTP id
 4fb4d7f45d1cf-639d5b5e42bmr29802751a12.6.1760559530474; Wed, 15 Oct 2025
 13:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007115840.2320557-1-geomatsi@gmail.com> <20251007115840.2320557-5-geomatsi@gmail.com>
In-Reply-To: <20251007115840.2320557-5-geomatsi@gmail.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 15 Oct 2025 15:18:38 -0500
X-Gm-Features: AS18NWAb6axIg7I2IqjVTHpzLs99BpK8lkg12YGdZJcKZxCb1gstwLw4-MW_Txc
Message-ID: <CAFTtA3MObvXRHxbULghGcT=ThrBDeFDJzUY7LOhgNnarzpYeGg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] riscv: vector: allow to force vector context save
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Han Gao <rabenda.cn@gmail.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Nam Cao <namcao@linutronix.de>, 
	Joel Granados <joel.granados@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 6:58=E2=80=AFAM Sergey Matyukevich <geomatsi@gmail.c=
om> wrote:
>
> When ptrace updates vector CSR registers for a traced process, the
> changes may not be immediately visible to the next ptrace operations
> due to vector context switch optimizations.
>
> The function 'riscv_v_vstate_save' saves context only if mstatus.VS is
> 'dirty'. However mstatus.VS of the traced process context may remain
> 'clean' between two breakpoints, if no vector instructions were executed
> between those two breakpoints. In this case the vector context will not
> be saved at the second breakpoint. As a result, the second ptrace may
> read stale vector CSR values.

IIUC, the second ptrace should not get the stale vector CSR values.
The second riscv_vr_get() should be reading from the context memory
(vstate), which is updated from the last riscv_vr_set(). The user's
vstate should remain the same since last riscv_vr_set(). Could you
explain more on how this bug is observed and why only CSRs are
affected but not v-regs as well?

Thanks,
Andy

>
> Fix this by introducing a TIF flag that forces vector context save on
> the next context switch, regardless of mstatus.VS state. Set this
> flag on ptrace oprations that modify vector CSR registers.
>
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>  arch/riscv/include/asm/thread_info.h | 2 ++
>  arch/riscv/include/asm/vector.h      | 3 +++
>  arch/riscv/kernel/process.c          | 2 ++
>  arch/riscv/kernel/ptrace.c           | 5 +++++
>  4 files changed, 12 insertions(+)
>
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> index 836d80dd2921..e05e9aa89c43 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -118,7 +118,9 @@ int arch_dup_task_struct(struct task_struct *dst, str=
uct task_struct *src);
>
>  #define TIF_32BIT                      16      /* compat-mode 32bit proc=
ess */
>  #define TIF_RISCV_V_DEFER_RESTORE      17      /* restore Vector before =
returing to user */
> +#define TIF_RISCV_V_FORCE_SAVE         13      /* force Vector context s=
ave */
>
>  #define _TIF_RISCV_V_DEFER_RESTORE     BIT(TIF_RISCV_V_DEFER_RESTORE)
> +#define _TIF_RISCV_V_FORCE_SAVE                BIT(TIF_RISCV_V_FORCE_SAV=
E)
>
>  #endif /* _ASM_RISCV_THREAD_INFO_H */
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index b61786d43c20..d3770e13da93 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -370,6 +370,9 @@ static inline void __switch_to_vector(struct task_str=
uct *prev,
>  {
>         struct pt_regs *regs;
>
> +       if (test_and_clear_tsk_thread_flag(prev, TIF_RISCV_V_FORCE_SAVE))
> +               __riscv_v_vstate_dirty(task_pt_regs(prev));
> +
>         if (riscv_preempt_v_started(prev)) {
>                 if (riscv_v_is_on()) {
>                         WARN_ON(prev->thread.riscv_v_flags & RISCV_V_CTX_=
DEPTH_MASK);
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 31a392993cb4..47959c55cefb 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -183,6 +183,7 @@ void flush_thread(void)
>         kfree(current->thread.vstate.datap);
>         memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_st=
ate));
>         clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
> +       clear_tsk_thread_flag(current, TIF_RISCV_V_FORCE_SAVE);
>  #endif
>  #ifdef CONFIG_RISCV_ISA_SUPM
>         if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
> @@ -205,6 +206,7 @@ int arch_dup_task_struct(struct task_struct *dst, str=
uct task_struct *src)
>         memset(&dst->thread.vstate, 0, sizeof(struct __riscv_v_ext_state)=
);
>         memset(&dst->thread.kernel_vstate, 0, sizeof(struct __riscv_v_ext=
_state));
>         clear_tsk_thread_flag(dst, TIF_RISCV_V_DEFER_RESTORE);
> +       clear_tsk_thread_flag(dst, TIF_RISCV_V_FORCE_SAVE);
>
>         return 0;
>  }
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index 906cf1197edc..569f756bef23 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -148,6 +148,11 @@ static int riscv_vr_set(struct task_struct *target,
>         if (vstate->vlenb !=3D ptrace_vstate.vlenb)
>                 return -EINVAL;
>
> +       if (vstate->vtype !=3D ptrace_vstate.vtype ||
> +           vstate->vcsr !=3D ptrace_vstate.vcsr ||
> +           vstate->vl !=3D ptrace_vstate.vl)
> +               set_tsk_thread_flag(target, TIF_RISCV_V_FORCE_SAVE);
> +
>         vstate->vstart =3D ptrace_vstate.vstart;
>         vstate->vl =3D ptrace_vstate.vl;
>         vstate->vtype =3D ptrace_vstate.vtype;
> --
> 2.51.0
>

