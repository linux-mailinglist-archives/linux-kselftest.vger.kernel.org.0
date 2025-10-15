Return-Path: <linux-kselftest+bounces-43265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAA2BE0D1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 23:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77D364E6267
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 21:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10592D97A9;
	Wed, 15 Oct 2025 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFaG+w1z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4F72D24AC
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563940; cv=none; b=SzTFN3XwU3YDDlKiFZAA42EipBFXH+1vec7YE0UY4UsKLEhWE8Gv+zH0QQWKDybtI9fVEZl/FE7lDcrvb9oWvOqKuC2sBDPtPdaTnKX0duZTu6J3McGBlbswQBs35T6hdQbL881BJsOexkZMhjscL3AFqpNTmX/7/sKdvdRuwWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563940; c=relaxed/simple;
	bh=8zVysIIXaYtcWT2JOEzeVWG1yxNu517cXTEwo7Q8FUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8W3lbm7lSyDvzcA2lK3ld9sqrX6P7gF870ejRAvfEnk5H+c8pXg85THGzYAHxOW7dls4ZLhVvjIXj0Zmqe7Oueu3Zftuy/82+F1pqmR2U2jWUncvjsE0kmTqg4dWdWsCnJsccXknT6M55+a8z9q5se2I0I2Fd2r4675uIVs4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFaG+w1z; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63bdc7d939fso27594a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563937; x=1761168737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an2G/9d47hEEnOP9myHHqMnuHCaBvnAN8tAqBfiHYNY=;
        b=NFaG+w1zWBaUITqy6ANSkJbjhx3mDovIPeKnsVQO0+q04BFqVFrY+y0R77QHzBRgrN
         wXPw7Z970ihngnXZxDDQQIFzOijSTsGz5sKux5yD9vHbXP/bMm5Qre67qk/hfqFJlTJQ
         Rn6GjOXt2lUupc3F1EKitigK7hY0uPZ5WRBXZyJva3lAEEc9tdjyoWqFCO7y7FYMkvQJ
         9kAfsmdbQvut95/TLvWOeSL6N0RrGlMcD5m3Li5QcXnCZlXB2TOk6ZtrVHVdP7lCjevh
         O3Evd2Y12moDZ9hoil2zB7ikeOwB2aVGOu03e3ddvs9aMz5xzbGijDiDTzZN6Eq8RfxO
         z5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563937; x=1761168737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an2G/9d47hEEnOP9myHHqMnuHCaBvnAN8tAqBfiHYNY=;
        b=MSvAnBael7vCL0E+89fo9mc2qNQn7AivKAykFquZBIixZtlFjnlRYLRRbXSncpnSLp
         d1GA9/KSUGyqLfOBAQ66QwRKhbMK19l9f1ZFq9WrGXYplknD6HP0GGhe87lWB7YN0VG9
         cY7qwZd+jTu0AmVy9bWaPNDH95Bll8cuWF7ipsdLtFatAt/eK9T+ycUbNh+X39JcJLrP
         rauF6gFhMbs2mEQfV/34+2N7SbtvTUxtgiSpvHkBDwj7fc8u+F+y4ijogrvYXvQGVXkv
         nObiEHf+k1Wvl45ZnvA3+b2OO8KqKSa/XzHIGjVGBA0NKd/PLkNgqv1B/mTNgV3GcE/s
         zOaw==
X-Forwarded-Encrypted: i=1; AJvYcCWhdZN0ffPqrZDizVqqpoMYLSVeQ8w6VACCF5/n/UHjmr5djoHZcHwIBZUWKalk2mA1OXSjIMRZMElRiYuyeI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCw1Di23iyx5WxwvKXr+G+x1+8h1Ajbp2aCWQtI84Evimjwzrm
	X71ZHb54JSkXRGo/2LMGxoA73ZndVxMnjWxYy/4iJ2dzEYyOsgTjKgwFQXKtrWj4ACKIaCQepih
	rmQYOvkwFPAU0GuyTM2YOZdNKy6HPn0Q=
X-Gm-Gg: ASbGncuuh2efkqjNgcE+xljaflYJUV7YPBKvq2f5ZGNxYGpYLI4fUvY80M6TaeJsHwn
	p8bSTXT+00RiZi9R5tvNmSAAB9QgjRb/XOoaHRBX8sAnFojjEmctvbkl9NXtJjtUEP79PYMtFE8
	ZQdfT5TL6CL/iezuZ0ifAUllFijyWwmH1zMYKAe/V8GwZ6+EsBh+Jj0o1Us89ah/UYTOoK5hgna
	8BH/4zB+xCaO4pSwONh4xEo39j5mZqO7g==
X-Google-Smtp-Source: AGHT+IETKXp4XkWEQ4U32sIWCcsCD1bfRNMB8NWYLayln3kcDdXtKdJRAQEty2d2BGBYtgl6wpMhbm29twcjTOJnDpM=
X-Received: by 2002:a05:6402:34d1:b0:63c:343:2485 with SMTP id
 4fb4d7f45d1cf-63c03439d20mr349068a12.3.1760563936779; Wed, 15 Oct 2025
 14:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007115840.2320557-1-geomatsi@gmail.com> <20251007115840.2320557-5-geomatsi@gmail.com>
 <CAFTtA3MObvXRHxbULghGcT=ThrBDeFDJzUY7LOhgNnarzpYeGg@mail.gmail.com>
In-Reply-To: <CAFTtA3MObvXRHxbULghGcT=ThrBDeFDJzUY7LOhgNnarzpYeGg@mail.gmail.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 15 Oct 2025 16:32:05 -0500
X-Gm-Features: AS18NWAGi9Py3C8rtbFuAwojqdEayvWFLUvCpApDZcPh7rosVGDCcfhgBNv2VKo
Message-ID: <CAFTtA3NoOZEMqYD6+vjP=09T15GiThjVy1LeDX0U8CC-4HMKOA@mail.gmail.com>
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

On Wed, Oct 15, 2025 at 3:18=E2=80=AFPM Andy Chiu <andybnac@gmail.com> wrot=
e:
>
> On Tue, Oct 7, 2025 at 6:58=E2=80=AFAM Sergey Matyukevich <geomatsi@gmail=
.com> wrote:
> >
> > When ptrace updates vector CSR registers for a traced process, the
> > changes may not be immediately visible to the next ptrace operations
> > due to vector context switch optimizations.
> >
> > The function 'riscv_v_vstate_save' saves context only if mstatus.VS is
> > 'dirty'. However mstatus.VS of the traced process context may remain
> > 'clean' between two breakpoints, if no vector instructions were execute=
d
> > between those two breakpoints. In this case the vector context will not
> > be saved at the second breakpoint. As a result, the second ptrace may
> > read stale vector CSR values.
>
> IIUC, the second ptrace should not get the stale vector CSR values.
> The second riscv_vr_get() should be reading from the context memory
> (vstate), which is updated from the last riscv_vr_set(). The user's
> vstate should remain the same since last riscv_vr_set(). Could you
> explain more on how this bug is observed and why only CSRs are
> affected but not v-regs as well?

From looking into your test, I can see that you were trying to set an
invalid configuration to Vetor CSRs and expect vill to be reflected
upon next read. Yes, this is not happening on the current
implementation as it was not expecting invalid input from the user,
which should be taken into consideration. Thanks for spotting the
case!

According to the spec, "The use of vtype encodings with LMUL <
SEWMIN/ELEN is reserved, implementations can set vill if they do not
support these configurations." This mean the implementation may
actually support this configuration. If that is the case, I think we
should not allow this to be configured through the vector ptrace
interface, which is designed to support 1.0 (and 0.7) specs. That
means, we should not allow this problematic configuration to pass
through riscv_vr_set(), reach user space, then the forced save.

I would opt for validating all CSR configurations in the first place.
Could you also help enforce checks on other reserved bits as well?

Thanks,
Andy

>
> Thanks,
> Andy
>
> >
> > Fix this by introducing a TIF flag that forces vector context save on
> > the next context switch, regardless of mstatus.VS state. Set this
> > flag on ptrace oprations that modify vector CSR registers.
> >
> > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> > ---
> >  arch/riscv/include/asm/thread_info.h | 2 ++
> >  arch/riscv/include/asm/vector.h      | 3 +++
> >  arch/riscv/kernel/process.c          | 2 ++
> >  arch/riscv/kernel/ptrace.c           | 5 +++++
> >  4 files changed, 12 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/=
asm/thread_info.h
> > index 836d80dd2921..e05e9aa89c43 100644
> > --- a/arch/riscv/include/asm/thread_info.h
> > +++ b/arch/riscv/include/asm/thread_info.h
> > @@ -118,7 +118,9 @@ int arch_dup_task_struct(struct task_struct *dst, s=
truct task_struct *src);
> >
> >  #define TIF_32BIT                      16      /* compat-mode 32bit pr=
ocess */
> >  #define TIF_RISCV_V_DEFER_RESTORE      17      /* restore Vector befor=
e returing to user */
> > +#define TIF_RISCV_V_FORCE_SAVE         13      /* force Vector context=
 save */
> >
> >  #define _TIF_RISCV_V_DEFER_RESTORE     BIT(TIF_RISCV_V_DEFER_RESTORE)
> > +#define _TIF_RISCV_V_FORCE_SAVE                BIT(TIF_RISCV_V_FORCE_S=
AVE)
> >
> >  #endif /* _ASM_RISCV_THREAD_INFO_H */
> > diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/v=
ector.h
> > index b61786d43c20..d3770e13da93 100644
> > --- a/arch/riscv/include/asm/vector.h
> > +++ b/arch/riscv/include/asm/vector.h
> > @@ -370,6 +370,9 @@ static inline void __switch_to_vector(struct task_s=
truct *prev,
> >  {
> >         struct pt_regs *regs;
> >
> > +       if (test_and_clear_tsk_thread_flag(prev, TIF_RISCV_V_FORCE_SAVE=
))
> > +               __riscv_v_vstate_dirty(task_pt_regs(prev));
> > +
> >         if (riscv_preempt_v_started(prev)) {
> >                 if (riscv_v_is_on()) {
> >                         WARN_ON(prev->thread.riscv_v_flags & RISCV_V_CT=
X_DEPTH_MASK);
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index 31a392993cb4..47959c55cefb 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -183,6 +183,7 @@ void flush_thread(void)
> >         kfree(current->thread.vstate.datap);
> >         memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_=
state));
> >         clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
> > +       clear_tsk_thread_flag(current, TIF_RISCV_V_FORCE_SAVE);
> >  #endif
> >  #ifdef CONFIG_RISCV_ISA_SUPM
> >         if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
> > @@ -205,6 +206,7 @@ int arch_dup_task_struct(struct task_struct *dst, s=
truct task_struct *src)
> >         memset(&dst->thread.vstate, 0, sizeof(struct __riscv_v_ext_stat=
e));
> >         memset(&dst->thread.kernel_vstate, 0, sizeof(struct __riscv_v_e=
xt_state));
> >         clear_tsk_thread_flag(dst, TIF_RISCV_V_DEFER_RESTORE);
> > +       clear_tsk_thread_flag(dst, TIF_RISCV_V_FORCE_SAVE);
> >
> >         return 0;
> >  }
> > diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> > index 906cf1197edc..569f756bef23 100644
> > --- a/arch/riscv/kernel/ptrace.c
> > +++ b/arch/riscv/kernel/ptrace.c
> > @@ -148,6 +148,11 @@ static int riscv_vr_set(struct task_struct *target=
,
> >         if (vstate->vlenb !=3D ptrace_vstate.vlenb)
> >                 return -EINVAL;
> >
> > +       if (vstate->vtype !=3D ptrace_vstate.vtype ||
> > +           vstate->vcsr !=3D ptrace_vstate.vcsr ||
> > +           vstate->vl !=3D ptrace_vstate.vl)
> > +               set_tsk_thread_flag(target, TIF_RISCV_V_FORCE_SAVE);
> > +
> >         vstate->vstart =3D ptrace_vstate.vstart;
> >         vstate->vl =3D ptrace_vstate.vl;
> >         vstate->vtype =3D ptrace_vstate.vtype;
> > --
> > 2.51.0
> >

