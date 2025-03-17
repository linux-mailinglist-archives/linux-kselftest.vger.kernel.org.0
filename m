Return-Path: <linux-kselftest+bounces-29173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661CA63A3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 02:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705F2188D2B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 01:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB52413AD26;
	Mon, 17 Mar 2025 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="diSUR5Iz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFD582D98
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174982; cv=none; b=Lmv+ok8UceokayZXGyz29aUtXl+WmBbxFCRD/7pmnw9raJ18P8gmfdHHOcwj+nMqxVH546uhc82A+gLv6eaCjgt/hgW5YKfRARdCgIFjwUUZfEBVRbmqWm03q0iXQjOlrJFcfpFoqNjpr6myD6gcwyIVeu+BRpPG1lOSrxtHxO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174982; c=relaxed/simple;
	bh=sBUAav1FFvgBjKgeVxJ0EVH51r2m9LIesRdspscRl6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUYZB+FSYzg2k6ck/t9pqyDBAujXelXkXbDuYuQs5VKY9E/CpS70Z7sG50zFpi30cvNId6A134qHVG83Q4XKjIpwWojN3Mq9j0JDXtvjpMY/Tqrp+GbLoeh90VVOCyqJK75mrnVPJhfN9n2DwR2mCRPBAhlPMztJ614qJ4z8G7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=diSUR5Iz; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85b41281b50so97850939f.3
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Mar 2025 18:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1742174980; x=1742779780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXV1YPaItWH5GuExWu6nvtOdHmuNPHwz3fpSrmXloOk=;
        b=diSUR5Izi2iYU8RfmW2sNMI4WfqfOfMPLcj4LO1eV6fJhUr4v00czUvxtuyU+Ttiqs
         Hz8coVWSDDD18gQZ0kdUDcs/MS4bgtBH/FgDrrRzd3OlfOR5pA4sMU0RJD+a/EfkecQ5
         HO3YcqeFrgAGO+vWzOYH2UiyGo7YaF/t2ORovxZlp6vS6QyM07x0kkWnBYBVkIeGMY4d
         2AteIgOv5ZhsJ7q3ZKlVuqsI2ggEYBXJahAX55mtEOf4pRbFHutQKlTIIksyHYoVEwMJ
         9ADSDS2n0OZTi/688Rhk5+FDJn7FtMMoxS9uD3ipcWipZFLvsVi0XKx2shuLfdLdZYLI
         5Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742174980; x=1742779780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXV1YPaItWH5GuExWu6nvtOdHmuNPHwz3fpSrmXloOk=;
        b=fwswimwUdBFgHdqOgn3b8zX+n05LrdF7JRy/OK/O7GKeH/6kg7dsxhlqHZkGA2gX/P
         PS7Cl1a04VPe6ZmemMBIjVDNQ61Bqyrz+JX2L69tDGyac4geb0SklZ6eTWPVYWujKQau
         SOywtO4TQ8JQ1J/IkKaVNIf/oWqw39tr4ynkDHmU/dq7RZW9cm6aV3Fn86yV1m7U5EcH
         6tEN+2K1YJmNTAg2kteie1IuMoZ8F0kz0Js1HtMxWCEQSLwwf9kBDpn8c+D1QzCo0l0Z
         tH0PcIPJKF5xMbRw71x8TFT1j24GB1KWThbPWbxlJqohNFtvDtgUvTAq9aRp0o3Psp9w
         kVcw==
X-Forwarded-Encrypted: i=1; AJvYcCWPJDOSJK2EVaKkchasMmSIQTnuyXTOaZ4EAhYIWEOK+JpKmmdFK2ZZyLHQseWcWqD5EoGdMorbDOxOU83JZDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4wxVO+HizJJXknvjb4veAVQwmPd2aUiFncASSvwlg3xGrEqS
	+ystwrQNUWZOWmTtWVf/OQ+ny8i9wJ4iEpp7aAwIKrczQdWw2G2q3A0zVBQTZbefQBkdz44+Ipn
	sMrSR71reIFEU5dXMYLm2sF8m5Vz/EbjukZcQBQ==
X-Gm-Gg: ASbGncuhZo6o2r3eFpZwLkvSqRG4hko8NOQztBo8nKTQgThRWSUgTuXXOmnarQ4VNTJ
	szOkFLTGUw5Bed/RLocrIjuIrp4XSqQ5i5UWtDG6tfDI6di3QjxSwZEyqNnTmK4dqUBdzbaKDo9
	EgGt2J7mwJLwPI8CQLsW4iDprhB9KItaegkaLAywo=
X-Google-Smtp-Source: AGHT+IHhjOPG6EGR3h5ZoxINkquScgFy27rLR9k3To3zRQ6sSX22EXVVLbZqhYGhk5BG8qHjIGiTQP6ZKF5VsUZ7wNw=
X-Received: by 2002:a05:6e02:2146:b0:3d4:700f:67e2 with SMTP id
 e9e14a558f8ab-3d483a142bcmr103325245ab.10.1742174980058; Sun, 16 Mar 2025
 18:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com> <20250314-v5_user_cfi_series-v12-14-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-14-e51202b53138@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 17 Mar 2025 09:29:28 +0800
X-Gm-Features: AQ5f1Jq1XMUvueQ2i8jGfmFKuB0WixGyohaNaR6cxlktpRaErRRA5S28rQgfU70
Message-ID: <CANXhq0oz72vtaAxKH02ccJg+JHO9JnWbWhfwdDAgNd14ghNMCg@mail.gmail.com>
Subject: Re: [PATCH v12 14/28] riscv: Implements arch agnostic indirect branch
 tracking prctls
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
> prctls implemented are:
> PR_SET_INDIR_BR_LP_STATUS, PR_GET_INDIR_BR_LP_STATUS and
> PR_LOCK_INDIR_BR_LP_STATUS
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/usercfi.h | 16 +++++++-
>  arch/riscv/kernel/entry.S        |  2 +-
>  arch/riscv/kernel/process.c      |  5 +++
>  arch/riscv/kernel/usercfi.c      | 79 ++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 100 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/us=
ercfi.h
> index c4dcd256f19a..a8cec7c14d1d 100644
> --- a/arch/riscv/include/asm/usercfi.h
> +++ b/arch/riscv/include/asm/usercfi.h
> @@ -16,7 +16,9 @@ struct kernel_clone_args;
>  struct cfi_status {
>         unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
>         unsigned long ubcfi_locked : 1;
> -       unsigned long rsvd : ((sizeof(unsigned long) * 8) - 2);
> +       unsigned long ufcfi_en : 1; /* Enable for forward cfi. Note that =
ELP goes in sstatus */
> +       unsigned long ufcfi_locked : 1;
> +       unsigned long rsvd : ((sizeof(unsigned long) * 8) - 4);
>         unsigned long user_shdw_stk; /* Current user shadow stack pointer=
 */
>         unsigned long shdw_stk_base; /* Base address of shadow stack */
>         unsigned long shdw_stk_size; /* size of shadow stack */
> @@ -33,6 +35,10 @@ bool is_shstk_locked(struct task_struct *task);
>  bool is_shstk_allocated(struct task_struct *task);
>  void set_shstk_lock(struct task_struct *task);
>  void set_shstk_status(struct task_struct *task, bool enable);
> +bool is_indir_lp_enabled(struct task_struct *task);
> +bool is_indir_lp_locked(struct task_struct *task);
> +void set_indir_lp_status(struct task_struct *task, bool enable);
> +void set_indir_lp_lock(struct task_struct *task);
>
>  #define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK (PR_SHADOW_STACK_ENABLE)
>
> @@ -58,6 +64,14 @@ void set_shstk_status(struct task_struct *task, bool e=
nable);
>
>  #define set_shstk_status(task, enable)
>
> +#define is_indir_lp_enabled(task) false
> +
> +#define is_indir_lp_locked(task) false
> +
> +#define set_indir_lp_status(task, enable)
> +
> +#define set_indir_lp_lock(task)
> +
>  #endif /* CONFIG_RISCV_USER_CFI */
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 68c99124ea55..00494b54ff4a 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -143,7 +143,7 @@ SYM_CODE_START(handle_exception)
>          * Disable the FPU/Vector to detect illegal usage of floating poi=
nt
>          * or vector in kernel space.
>          */
> -       li t0, SR_SUM | SR_FS_VS
> +       li t0, SR_SUM | SR_FS_VS | SR_ELP
>
>         REG_L s0, TASK_TI_USER_SP(tp)
>         csrrc s1, CSR_STATUS, t0
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index cd11667593fe..4587201dd81d 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -160,6 +160,11 @@ void start_thread(struct pt_regs *regs, unsigned lon=
g pc,
>         set_shstk_status(current, false);
>         set_shstk_base(current, 0, 0);
>         set_active_shstk(current, 0);
> +       /*
> +        * disable indirect branch tracking on exec.
> +        * libc will enable it later via prctl.
> +        */
> +       set_indir_lp_status(current, false);
>
>  #ifdef CONFIG_64BIT
>         regs->status &=3D ~SR_UXL;
> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> index b93b324eed26..7937bcef9271 100644
> --- a/arch/riscv/kernel/usercfi.c
> +++ b/arch/riscv/kernel/usercfi.c
> @@ -72,6 +72,35 @@ void set_shstk_lock(struct task_struct *task)
>         task->thread_info.user_cfi_state.ubcfi_locked =3D 1;
>  }
>
> +bool is_indir_lp_enabled(struct task_struct *task)
> +{
> +       return task->thread_info.user_cfi_state.ufcfi_en ? true : false;
> +}
> +
> +bool is_indir_lp_locked(struct task_struct *task)
> +{
> +       return task->thread_info.user_cfi_state.ufcfi_locked ? true : fal=
se;
> +}
> +
> +void set_indir_lp_status(struct task_struct *task, bool enable)
> +{
> +       if (!cpu_supports_indirect_br_lp_instr())
> +               return;
> +
> +       task->thread_info.user_cfi_state.ufcfi_en =3D enable ? 1 : 0;
> +
> +       if (enable)
> +               task->thread.envcfg |=3D ENVCFG_LPE;
> +       else
> +               task->thread.envcfg &=3D ~ENVCFG_LPE;
> +
> +       csr_write(CSR_ENVCFG, task->thread.envcfg);
> +}
> +
> +void set_indir_lp_lock(struct task_struct *task)
> +{
> +       task->thread_info.user_cfi_state.ufcfi_locked =3D 1;
> +}
>  /*
>   * If size is 0, then to be compatible with regular stack we want it to =
be as big as
>   * regular stack. Else PAGE_ALIGN it and return back
> @@ -372,3 +401,53 @@ int arch_lock_shadow_stack_status(struct task_struct=
 *task,
>
>         return 0;
>  }
> +
> +int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __u=
ser *status)
> +{
> +       unsigned long fcfi_status =3D 0;
> +
> +       if (!cpu_supports_indirect_br_lp_instr())
> +               return -EINVAL;
> +
> +       /* indirect branch tracking is enabled on the task or not */
> +       fcfi_status |=3D (is_indir_lp_enabled(t) ? PR_INDIR_BR_LP_ENABLE =
: 0);
> +
> +       return copy_to_user(status, &fcfi_status, sizeof(fcfi_status)) ? =
-EFAULT : 0;
> +}
> +
> +int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long sta=
tus)
> +{
> +       bool enable_indir_lp =3D false;
> +
> +       if (!cpu_supports_indirect_br_lp_instr())
> +               return -EINVAL;
> +
> +       /* indirect branch tracking is locked and further can't be modifi=
ed by user */
> +       if (is_indir_lp_locked(t))
> +               return -EINVAL;
> +
> +       /* Reject unknown flags */
> +       if (status & ~PR_INDIR_BR_LP_ENABLE)
> +               return -EINVAL;
> +
> +       enable_indir_lp =3D (status & PR_INDIR_BR_LP_ENABLE) ? true : fal=
se;
> +       set_indir_lp_status(t, enable_indir_lp);
> +
> +       return 0;
> +}
> +
> +int arch_lock_indir_br_lp_status(struct task_struct *task,
> +                                unsigned long arg)
> +{
> +       /*
> +        * If indirect branch tracking is not supported or not enabled on=
 task,
> +        * nothing to lock here
> +        */
> +       if (!cpu_supports_indirect_br_lp_instr() ||
> +           !is_indir_lp_enabled(task) || arg !=3D 0)
> +               return -EINVAL;
> +
> +       set_indir_lp_lock(task);
> +
> +       return 0;
> +}
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

