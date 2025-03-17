Return-Path: <linux-kselftest+bounces-29174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA436A63A49
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 02:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1952188F282
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 01:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B7113B7B3;
	Mon, 17 Mar 2025 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nsIWc+O/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F69433CB
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742175011; cv=none; b=X2MyI0XuwcGb4LjRD6Dghdu0S5yrUCa6OHb8ef/TLkw8HlVnRR8knZf6fJlzzcNb6U3ij/bDA4t6akRnlKHvpaLXSUjq0kX/6gAIialUxdZMi3ObxaaFGiI1Iw52MeaomfFu/4CJR7806iMxTfivR+B5Q8YEz541kRHjE93RQJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742175011; c=relaxed/simple;
	bh=NpMOVBOS8yDuSZNKzTrt0KxgDiVsUGvJ2JbhENakTNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwWVHx06cQvY0Bt9pmdfwt1dZZCs0Gw3YsNgVZYYHgUssdq36FqnMFZDFYP59myOND5ue4XVIAbOFdh6Ptsf98aKVncNrNfTy8QBmXQoByzrdUKLCp4FOZmhXbhMlSuNINGKrJXHkrNeUACo1lwCTGlDi2QoBti2GSzdHZmCCHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nsIWc+O/; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85afd2b9106so378271039f.0
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Mar 2025 18:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1742175009; x=1742779809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BgPqh2lb+Uwmfrt3ADGADV+FsUyp9TAnyh5DCYwF0A=;
        b=nsIWc+O/ppJ7J/pbLyPRpD1W8bBeIBxD+xARdZE9HgJoHY64QdMpzrp6rqO9TWODOR
         0DQbp5KVOI29hBfzxbAQ31dcrfg9YcPczk3CJxA1ijt6XNpUm4uvKleEwsZovXCQSN8V
         p5pi5lBt2gByZkLoL61XUb9hQuZjxFxpaNCvTSuwEdTLEzkRgLGgIsMnZICDnvwiauyL
         3jnu1LIHVRM19MtZu6TXbU2cMmOiQ4fo3QpD7PDFU3ttVfhVCox614lVyVB2pLrV8m+6
         XtDcPPBnDOKTOR5mJ+tat0bwpb55/ka6z0MmAWFcxpaMsFA12DZ5BNCwZXimF2SAlcQe
         bVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742175009; x=1742779809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BgPqh2lb+Uwmfrt3ADGADV+FsUyp9TAnyh5DCYwF0A=;
        b=Cfq8vpmfXx1xf8LvO4pnDTLdm0pCPQOaTt6bmWQ3HNOQxAoIMG6idr08sz4rXQa+8o
         UGAavhjvSC4QfR4R9+OhuI5H2r9C7pqg+OyAZYAmlOFFFcUrqAASpZRyeyj1RbioNiYw
         ycxi6pugPavY85mHK5aBbqSgIeVw0gBOFqk8P8ypDebh9m+RphsxS4YZ7+S6XBtVzf3h
         Xy5fqpRZATNrxc29ZAJvjlt6mQWhsoTRCK/JV0+vumvpj1b9CpSXur9BteGGhbZ9WGCv
         BbApMSQCjcUCGPk3pFQLeLo7rstUcXNLua/Gj4Kz84Cd6dTLaeo675uTDwLzoAujh7U5
         mjbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU98tRFsLq3aolwJJMW7Ewm79Wh55L2dr7kT0RtOMctnYBR9CbXj4KOSh/ysG3ffckJ6uJKi+OzNSPXT0WdqLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsVND5DvOTNzq3FhE9GVtlFFYzduGa6IxjrEfJyEs1+60hLwpc
	NBjDZNrq0AiZS/yGuLUvCcKHV0uXrUQd6FXObjNFkbT2zDwqEDQuAwyouIHkp02GkupD0OM33kV
	KKkm8uMySazk+uDX5TnAbFk0XEFKidGOVLXBAoA==
X-Gm-Gg: ASbGnctQHB0at2NvhfY+JvnibKE0hxMMcPkQJcMClTealgkj8tZi6CnvBNPmwtP5tKD
	oLhJiejmt1y4tmXSwYRKDj/Ze0Vp0966tOKkiYQGRsEgG6H+EENPU10V17koAYg879D5w3Z37D6
	BSiEY3FUTgWIXkKe8il7Ek6fZfgBua
X-Google-Smtp-Source: AGHT+IFIq9kkasXmtYBi1bOlasABayp5RTyarU6d4HJ+lY/VA6wq4Lo3I/SyszKkcRTrfrE4ClECajli89b3tva72eM=
X-Received: by 2002:a05:6602:3f09:b0:85d:a1c4:ee03 with SMTP id
 ca18e2360f4ac-85dc47d36b5mr1483188839f.7.1742175009124; Sun, 16 Mar 2025
 18:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com> <20250314-v5_user_cfi_series-v12-13-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-13-e51202b53138@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 17 Mar 2025 09:29:57 +0800
X-Gm-Features: AQ5f1JrP5j_jWeX4yoQDmxgHc7C_BW3_CH6nIyiVQO54RVQmiKVGFtDika6nCYk
Message-ID: <CANXhq0o2gxV462GY6h=_4GmBDcDf3oeh-L=WXzz=AsMCV=x2Kw@mail.gmail.com>
Subject: Re: [PATCH v12 13/28] prctl: arch-agnostic prctl for indirect branch tracking
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
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
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

On Sat, Mar 15, 2025 at 6:51=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Three architectures (x86, aarch64, riscv) have support for indirect branc=
h
> tracking feature in a very similar fashion. On a very high level, indirec=
t
> branch tracking is a CPU feature where CPU tracks branches which uses
> memory operand to perform control transfer in program. As part of this
> tracking on indirect branches, CPU goes in a state where it expects a
> landing pad instr on target and if not found then CPU raises some fault
> (architecture dependent)
>
> x86 landing pad instr - `ENDBRANCH`
> arch64 landing pad instr - `BTI`
> riscv landing instr - `lpad`
>
> Given that three major arches have support for indirect branch tracking,
> This patch makes `prctl` for indirect branch tracking arch agnostic.
>
> To allow userspace to enable this feature for itself, following prtcls ar=
e
> defined:
>  - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect
>    branch tracking.
>  - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch
>    tracking.
>    Following status options are allowed
>        - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
>          thread.
>        - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on use=
r
>          thread.
>  - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branc=
h
>    tracking for user thread.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>  include/linux/cpu.h        |  4 ++++
>  include/uapi/linux/prctl.h | 27 +++++++++++++++++++++++++++
>  kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
>
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 6a0a8f1c7c90..fb0c394430c6 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -204,4 +204,8 @@ static inline bool cpu_mitigations_auto_nosmt(void)
>  }
>  #endif
>
> +int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __u=
ser *status);
> +int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long sta=
tus);
> +int arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long st=
atus);
> +
>  #endif /* _LINUX_CPU_H_ */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 5c6080680cb2..6cd90460cbad 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -353,4 +353,31 @@ struct prctl_mm_map {
>   */
>  #define PR_LOCK_SHADOW_STACK_STATUS      76
>
> +/*
> + * Get the current indirect branch tracking configuration for the curren=
t
> + * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STAT=
US.
> + */
> +#define PR_GET_INDIR_BR_LP_STATUS      77
> +
> +/*
> + * Set the indirect branch tracking configuration. PR_INDIR_BR_LP_ENABLE=
 will
> + * enable cpu feature for user thread, to track all indirect branches an=
d ensure
> + * they land on arch defined landing pad instruction.
> + * x86 - If enabled, an indirect branch must land on `ENDBRANCH` instruc=
tion.
> + * arch64 - If enabled, an indirect branch must land on `BTI` instructio=
n.
> + * riscv - If enabled, an indirect branch must land on `lpad` instructio=
n.
> + * PR_INDIR_BR_LP_DISABLE will disable feature for user thread and indir=
ect
> + * branches will no more be tracked by cpu to land on arch defined landi=
ng pad
> + * instruction.
> + */
> +#define PR_SET_INDIR_BR_LP_STATUS      78
> +# define PR_INDIR_BR_LP_ENABLE            (1UL << 0)
> +
> +/*
> + * Prevent further changes to the specified indirect branch tracking
> + * configuration.  All bits may be locked via this call, including
> + * undefined bits.
> + */
> +#define PR_LOCK_INDIR_BR_LP_STATUS      79
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index cb366ff8703a..f347f3518d0b 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2336,6 +2336,21 @@ int __weak arch_lock_shadow_stack_status(struct ta=
sk_struct *t, unsigned long st
>         return -EINVAL;
>  }
>
> +int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned l=
ong __user *status)
> +{
> +       return -EINVAL;
> +}
> +
> +int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned l=
ong status)
> +{
> +       return -EINVAL;
> +}
> +
> +int __weak arch_lock_indir_br_lp_status(struct task_struct *t, unsigned =
long status)
> +{
> +       return -EINVAL;
> +}
> +
>  #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
>
>  #ifdef CONFIG_ANON_VMA_NAME
> @@ -2811,6 +2826,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,
>                         return -EINVAL;
>                 error =3D arch_lock_shadow_stack_status(me, arg2);
>                 break;
> +       case PR_GET_INDIR_BR_LP_STATUS:
> +               if (arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +               error =3D arch_get_indir_br_lp_status(me, (unsigned long =
__user *)arg2);
> +               break;
> +       case PR_SET_INDIR_BR_LP_STATUS:
> +               if (arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +               error =3D arch_set_indir_br_lp_status(me, arg2);
> +               break;
> +       case PR_LOCK_INDIR_BR_LP_STATUS:
> +               if (arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +               error =3D arch_lock_indir_br_lp_status(me, arg2);
> +               break;
>         default:
>                 trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
>                 error =3D -EINVAL;
>

LGTM

Reviewed-by: Zong Li <zong.li@sifive.com>

> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

