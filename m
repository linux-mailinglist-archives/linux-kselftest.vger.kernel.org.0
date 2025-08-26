Return-Path: <linux-kselftest+bounces-39902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 242FCB352C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 06:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FDC1A84C5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 04:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3D22DF718;
	Tue, 26 Aug 2025 04:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LNPR+FqI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926202D23B6
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 04:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756183098; cv=none; b=KsmwS1EOFRoQqhr2UPmCtevo5ZEn2wKWzDcuQUdQ9VeuFVN9xpGOs2NOcUhLTzoc8+76pK80adkP3TgOFiO5pmOSad6VfMdDtdXFx+KPFfUp8ZQMVMui4XNP2B2hsR4+0i57JGMnHFAZfvQHOJANTRN3D4YPdhrlYfJHWV8VgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756183098; c=relaxed/simple;
	bh=X2421H26tLXUHDTMe41vhjohMOE82E/n39NqynbbubA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWpmClqQgaGlhkgJSmdlROt2ttVCPirdgRs+Fh9xpXE780wZcYcXdu8CxYatfVxvqKO2YAjgsRctPQimcov4yGPLhSBz8VroGd04BFD8ux03Zt8N2egL6oWBjnf9VHtIBk343jb3NQ47NroKvMWB3v1UvJfAaJMueiyPz/9RRsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LNPR+FqI; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109c59dc9so70022001cf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 21:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1756183095; x=1756787895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFgnn+/KkXNVaL/+B3uRwl6TtlDHiFj4dBOMY55dlhY=;
        b=LNPR+FqI6Zhvj78Gt5ad6XYJqXYuZxeewPRFeWU+cseuliJ8SPz2DpYRhfEWHAIopD
         2Nt9veCVgsvGqC2ilMWe+UX2IU5TlQgVGgtl7/UfUExHtmlSkep4A9iDJw5TV7IYmrLR
         5k8SgODIxRp9ivp0Vpi9LypfesEJ6t9zrMwjYn7HJ+cKev00EwuAmXVqfwDPLS+9RBib
         VIUHNkWylgvNl8qw6+2lUZVWtGI9WdS+sHDPPP4e/+A1avLZ4NVvyEP8oKNxHjj29AWJ
         /ez5Ohkuvk8LDybIf5K+okuNfli1wehE+VmJGbAkn7vhA1QoEeQFI48294St1kEjepCx
         8hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756183095; x=1756787895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFgnn+/KkXNVaL/+B3uRwl6TtlDHiFj4dBOMY55dlhY=;
        b=Tcuug/OGMjEb/pKYAUmsoQ3epav9Li977AOIpdMaOv9mtX/AMOLkFFoFo/m8uv7Nhk
         JQr1UpR8BLI8CUuqxTAL6QCw5ujR1JLhifsPyVcssuYQ3SHOKjblz/YGYc4HfnXfUYM6
         1UvSa0x18JrPsh4DUCeSXlzitIF2nx9feHo/b+xR91ho7nQn52LVNnk8e9yC2WZz0bmI
         /wLdu+0yjLbRfx/Zi0PaxsIPmO4N26ZwEqE77Oe+DV08msq0nAoCXDTsOLYhkcMeFKXm
         DhnbtQgqsPSuMENC5+mblcJxVw+ueNrRU3jsoAWsGU5CKKT6u9EzLFiPHGEtkaQQDst6
         A2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrCDIULlL8XnIeyG2z+IBOD+Ckay/u6Ypo5LDmxE/xSg75DgfGYEIGSS3sQR6M7fVw6rxoS1X7ORcnI9KIAro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTiK3Uh5JKp5Az1oPz67iuonL4Yxk4Zz5C4rCufgddDYMoU/yA
	3pms9B8c1aY8vyESGe05Mg4zSKFwzWUygkf2oOUhb/8iix55Pc80NG6fQgUiLnIQPcfo9P1xv1z
	+0+H684NC8v1gva2IFFOXTjbVssrk53wrqC5fqtZsBQ==
X-Gm-Gg: ASbGncvUx30P6Etf4G2A8FXqX0fPmF8UD8YYkbLEAvbYESD5GLABE81PNOUQ43uce7K
	HSGwIC1p3Huy0NfzhkjYOmOyxzApKByH1SQJJrCuJbIFihPJlW/V/GYinQlzi8/aP4dLWMSCOw9
	5TM/cIi29ahHsasXmzCZvAYLqYcIhXeeqmn7eCs40E2r88Fq3LLYuyNFVMYHZqkmBhMyrO+5Q2W
	95B
X-Google-Smtp-Source: AGHT+IHEa8+pSI1Wy0Fw7b+dsO/b6DhMiB4aK96KXN4AsIVMUjL2PWvpxHoNQpi2wUkC4qjdixdxGk6/65/eeyTbpoI=
X-Received: by 2002:a05:622a:1818:b0:4af:1cd4:d782 with SMTP id
 d75a77b69052e-4b2aaad2b0dmr171048541cf.45.1756183095317; Mon, 25 Aug 2025
 21:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822174715.1269138-1-jesse@rivosinc.com> <20250822174715.1269138-6-jesse@rivosinc.com>
In-Reply-To: <20250822174715.1269138-6-jesse@rivosinc.com>
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
Date: Tue, 26 Aug 2025 10:08:04 +0530
X-Gm-Features: Ac12FXyOy-huds2B1fJwOJPw53ZPIRvf9djC3OVxcNJyBPYY2odcHNK5kYVsNfY
Message-ID: <CAPd4Wexw_DtndDqRZzXK0PEOAkb4yWB4x8rf5eRdJOLMS-+8SQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] riscv: hw_breakpoint: Use icount for single stepping
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Shuah Khan <shuah@kernel.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Deepak Gupta <debug@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Atish Patra <atishp@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Evan Green <evan@rivosinc.com>, WangYuli <wangyuli@uniontech.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Nam Cao <namcao@linutronix.de>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Joel Granados <joel.granados@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Celeste Liu <coelacanthushex@gmail.com>, 
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Nylon Chen <nylon.chen@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 11:17=E2=80=AFPM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> The Sdtrig RISC-V ISA extension does not have a resume flag for
> returning to and executing the instruction at the breakpoint.
> To avoid skipping the instruction or looping, it is necessary to remove
> the hardware breakpoint and single step. Use the icount feature of
> Sdtrig to accomplish this. Use icount as default with an option to allow
> software-based single stepping when hardware or SBI does not have
> icount functionality, as it may cause unwanted side effects when reading
> the instruction from memory.

Can you please elaborate on this? I remember noticing the absence of
the resume flag which was causing loops.

>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> OpenSBI implementation of sbi_debug_read_triggers does not return the
> updated CSR values. There needs to be a check for working
> sbi_debug_read_triggers before this works.
>
> https://lists.riscv.org/g/tech-prs/message/1476
>
> RFC -> V1:
>  - Add dbtr_mode to rv_init_icount_trigger
>  - Add icount_triggered to check which breakpoint was triggered
>  - Fix typo: s/affects/effects
>  - Move HW_BREAKPOINT_COMPUTE_STEP to Platform type
> V1 -> V2:
>  - Remove HW_BREAKPOINT_COMPUTE_STEP kconfig option
> ---
>  arch/riscv/kernel/hw_breakpoint.c | 173 ++++++++++++++++++++++++++----
>  1 file changed, 155 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_bre=
akpoint.c
> index 3f96e744a711..f12306247436 100644
> --- a/arch/riscv/kernel/hw_breakpoint.c
> +++ b/arch/riscv/kernel/hw_breakpoint.c
> @@ -20,6 +20,7 @@
>  #define DBTR_TDATA1_DMODE              BIT_UL(__riscv_xlen - 5)
>
>  #define DBTR_TDATA1_TYPE_MCONTROL      (2UL << DBTR_TDATA1_TYPE_SHIFT)
> +#define DBTR_TDATA1_TYPE_ICOUNT                (3UL << DBTR_TDATA1_TYPE_=
SHIFT)
>  #define DBTR_TDATA1_TYPE_MCONTROL6     (6UL << DBTR_TDATA1_TYPE_SHIFT)
>
>  #define DBTR_TDATA1_MCONTROL6_LOAD             BIT(0)
> @@ -62,6 +63,14 @@
>         (FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZELO_FIELD, lo) | \
>          FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZEHI_FIELD, hi))
>
> +#define DBTR_TDATA1_ICOUNT_U                   BIT(6)
> +#define DBTR_TDATA1_ICOUNT_S                   BIT(7)
> +#define DBTR_TDATA1_ICOUNT_PENDING             BIT(8)
> +#define DBTR_TDATA1_ICOUNT_M                   BIT(9)
> +#define DBTR_TDATA1_ICOUNT_COUNT_FIELD         GENMASK(23, 10)
> +#define DBTR_TDATA1_ICOUNT_VU                  BIT(25)
> +#define DBTR_TDATA1_ICOUNT_VS                  BIT(26)
> +
>  enum dbtr_mode {
>         DBTR_MODE_U =3D 0,
>         DBTR_MODE_S,
> @@ -79,6 +88,7 @@ static DEFINE_PER_CPU(union sbi_dbtr_shmem_entry, sbi_d=
btr_shmem);
>
>  /* number of debug triggers on this cpu . */
>  static int dbtr_total_num __ro_after_init;
> +static bool have_icount __ro_after_init;
>  static unsigned long dbtr_type __ro_after_init;
>  static unsigned long dbtr_init __ro_after_init;
>
> @@ -129,6 +139,7 @@ static int arch_smp_teardown_sbi_shmem(unsigned int c=
pu)
>  static void init_sbi_dbtr(void)
>  {
>         struct sbiret ret;
> +       unsigned long dbtr_count =3D 0;
>
>         /*
>          * Called by hw_breakpoint_slots and arch_hw_breakpoint_init.
> @@ -143,6 +154,19 @@ static void init_sbi_dbtr(void)
>                 return;
>         }
>
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> +               DBTR_TDATA1_TYPE_ICOUNT, 0, 0, 0, 0, 0);
> +       if (ret.error) {
> +               pr_warn("%s: failed to detect icount triggers. error: %ld=
.\n",
> +                       __func__, ret.error);
> +       } else if (!ret.value) {
> +               pr_warn("%s: No icount triggers available. "
> +                       "Falling-back to computing single step address.\n=
", __func__);
> +       } else {
> +               dbtr_count =3D ret.value;
> +               have_icount =3D true;
> +       }
> +
>         ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
>                         DBTR_TDATA1_TYPE_MCONTROL6, 0, 0, 0, 0, 0);
>         if (ret.error) {
> @@ -151,7 +175,7 @@ static void init_sbi_dbtr(void)
>         } else if (!ret.value) {
>                 pr_warn("%s: No mcontrol6 triggers available.\n", __func_=
_);
>         } else {
> -               dbtr_total_num =3D ret.value;
> +               dbtr_total_num =3D min_not_zero((unsigned long)ret.value,=
 dbtr_count);
>                 dbtr_type =3D DBTR_TDATA1_TYPE_MCONTROL6;
>                 return;
>         }
> @@ -166,7 +190,7 @@ static void init_sbi_dbtr(void)
>                 pr_err("%s: No mcontrol triggers available.\n", __func__)=
;
>                 dbtr_total_num =3D 0;
>         } else {
> -               dbtr_total_num =3D ret.value;
> +               dbtr_total_num =3D min_not_zero((unsigned long)ret.value,=
 dbtr_count);
>                 dbtr_type =3D DBTR_TDATA1_TYPE_MCONTROL;
>         }
>  }
> @@ -320,6 +344,36 @@ static int rv_init_mcontrol6_trigger(const struct pe=
rf_event_attr *attr,
>         return 0;
>  }
>
> +static int rv_init_icount_trigger(struct arch_hw_breakpoint *hw, enum db=
tr_mode mode)
> +{
> +       unsigned long tdata1 =3D DBTR_TDATA1_TYPE_ICOUNT;
> +
> +       /* Step one instruction */
> +       tdata1 |=3D FIELD_PREP(DBTR_TDATA1_ICOUNT_COUNT_FIELD, 1);
> +
> +       switch (mode) {
> +       case DBTR_MODE_U:
> +               tdata1 |=3D DBTR_TDATA1_ICOUNT_U;
> +               break;
> +       case DBTR_MODE_S:
> +               tdata1 |=3D DBTR_TDATA1_ICOUNT_S;
> +               break;
> +       case DBTR_MODE_VS:
> +               tdata1 |=3D DBTR_TDATA1_ICOUNT_VS;
> +               break;
> +       case DBTR_MODE_VU:
> +               tdata1 |=3D DBTR_TDATA1_ICOUNT_VU;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       hw->tdata1 =3D tdata1;
> +       hw->tdata2 =3D 0;
> +
> +       return 0;
> +}
> +
>  int hw_breakpoint_arch_parse(struct perf_event *bp,
>                              const struct perf_event_attr *attr,
>                              struct arch_hw_breakpoint *hw)
> @@ -372,24 +426,28 @@ static int setup_singlestep(struct perf_event *even=
t, struct pt_regs *regs)
>         /* Remove breakpoint even if return error as not to loop */
>         arch_uninstall_hw_breakpoint(event);
>
> -       ret =3D get_insn_nofault(regs, regs->epc, &insn);
> -       if (ret < 0)
> -               return ret;
> +       if (have_icount) {
> +               rv_init_icount_trigger(bp, DBTR_MODE_U);
> +       } else {
> +               ret =3D get_insn_nofault(regs, regs->epc, &insn);
> +               if (ret < 0)
> +                       return ret;
>
> -       next_addr =3D get_step_address(regs, insn);
> +               next_addr =3D get_step_address(regs, insn);
>
> -       ret =3D get_insn_nofault(regs, next_addr, &insn);
> -       if (ret < 0)
> -               return ret;
> +               ret =3D get_insn_nofault(regs, next_addr, &insn);
> +               if (ret < 0)
> +                       return ret;
>
> -       bp_insn.bp_type =3D HW_BREAKPOINT_X;
> -       bp_insn.bp_addr =3D next_addr;
> -       /* Get the size of the intruction */
> -       bp_insn.bp_len =3D GET_INSN_LENGTH(insn);
> +               bp_insn.bp_type =3D HW_BREAKPOINT_X;
> +               bp_insn.bp_addr =3D next_addr;
> +               /* Get the size of the intruction */
> +               bp_insn.bp_len =3D GET_INSN_LENGTH(insn);
>
> -       ret =3D hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
> -       if (ret)
> -               return ret;
> +               ret =3D hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
> +               if (ret)
> +                       return ret;
> +       }
>
>         ret =3D arch_install_hw_breakpoint(event);
>         if (ret)
> @@ -400,6 +458,79 @@ static int setup_singlestep(struct perf_event *event=
, struct pt_regs *regs)
>         return 0;
>  }
>
> +/**
> + * icount_triggered - Check if event's icount was triggered.
> + * @event: Perf event to check
> + *
> + * Check the given perf event's icount breakpoint was triggered.
> + *
> + * Returns:    1 if icount was triggered.
> + *             0 if icount was not triggered.
> + *             negative on failure.
> + */
> +static int icount_triggered(struct perf_event *event)
> +{
> +       union sbi_dbtr_shmem_entry *shmem =3D this_cpu_ptr(&sbi_dbtr_shme=
m);
> +       struct sbiret ret;
> +       struct perf_event **slot;
> +       unsigned long tdata1;
> +       int i;
> +
> +       for (i =3D 0; i < dbtr_total_num; i++) {
> +               slot =3D this_cpu_ptr(&pcpu_hw_bp_events[i]);
> +
> +               if (*slot =3D=3D event)
> +                       break;
> +       }
> +
> +       if (i =3D=3D dbtr_total_num) {
> +               pr_warn("%s: Breakpoint not installed.\n", __func__);
> +               return -ENOENT;
> +       }
> +
> +       raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> +                             *this_cpu_ptr(&ecall_lock_flags));
> +
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_READ,
> +                       i, 1, 0, 0, 0, 0);
> +       tdata1 =3D shmem->data.tdata1;
> +
> +       raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> +                                  *this_cpu_ptr(&ecall_lock_flags));
> +       if (ret.error) {
> +               pr_warn("%s: failed to read trigger. error: %ld\n", __fun=
c__, ret.error);
> +               return sbi_err_map_linux_errno(ret.error);

To avoid a flurry of events or messages, it would probably be good to
disable the trigger.

> +       }
> +
> +       /*
> +        * The RISC-V Debug Specification
> +        * Tim Newsome, Paul Donahue (Ventana Micro Systems)
> +        * Version 1.0, Revised 2025-02-21: Ratified
I think mentioning the version number and section would be enough.

> +        * 5.7.13. Instruction Count (icount, at 0x7a1)
> +        * When count is 1 and the trigger matches, then pending becomes =
set.
> +        * In addition count will become 0 unless it is hard-wired to 1.
> +        * When pending is set, the trigger fires just before any further
> +        * instructions are executed in a mode where the trigger is enabl=
ed.
> +        * As the trigger fires, pending is cleared. In addition, if coun=
t is
> +        * hard-wired to 1 then m, s, u, vs, and vu are all cleared.
> +        */
> +       if (FIELD_GET(DBTR_TDATA1_ICOUNT_COUNT_FIELD, tdata1) =3D=3D 0)
> +               return 1;
> +
> +       if (FIELD_GET(DBTR_TDATA1_ICOUNT_COUNT_FIELD, tdata1) !=3D 1)
> +               return 0;
> +
> +       if (tdata1 & DBTR_TDATA1_ICOUNT_U)
> +               return 0;
> +       if (tdata1 & DBTR_TDATA1_ICOUNT_S)
> +               return 0;
> +       if (tdata1 & DBTR_TDATA1_ICOUNT_VU)
> +               return 0;
> +       if (tdata1 & DBTR_TDATA1_ICOUNT_VU)
> +               return 0;
> +       return 1;
> +}
> +
>  /*
>   * HW Breakpoint/watchpoint handler
>   */
> @@ -460,7 +591,10 @@ static int hw_breakpoint_handler(struct pt_regs *reg=
s)
>
>                 if (bp->in_callback) {
>                         expecting_callback =3D true;
> -                       if (regs->epc !=3D bp->next_addr) {
> +                       if (have_icount) {
> +                               if (icount_triggered(event) !=3D 1)
> +                                       continue;
> +                       } else if (regs->epc !=3D bp->next_addr) {
>                                 continue;
>                         }
>
> @@ -477,7 +611,10 @@ static int hw_breakpoint_handler(struct pt_regs *reg=
s)
>
>         }
>
> -       if (expecting_callback) {
> +       if (expecting_callback && have_icount) {
> +               pr_err("%s: in_callback was set, but icount was not trigg=
ered, epc (%lx).\n",
> +                      __func__, regs->epc);
> +       } else if (expecting_callback) {
>                 pr_err("%s: in_callback was set, but epc (%lx) was not at=
 next address(%lx).\n",
>                        __func__, regs->epc, bp->next_addr);
>         }

Is this just for debugging or do you want to commit it?

Regards
Himanshu
> --
> 2.43.0
>

