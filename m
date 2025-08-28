Return-Path: <linux-kselftest+bounces-40208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B62CB3A898
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 19:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478381C82C64
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 17:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF7A3375BE;
	Thu, 28 Aug 2025 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su5q8iz/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F422F01;
	Thu, 28 Aug 2025 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756403221; cv=none; b=Tj/0ezm80qVWyQOQbFLYcL5pFRhY9FEftAFWBoLCsiKHy1BF04T2qmwK4rQiFk/EE79Dx7f8vt9lzuya2r5Zfrp6Xycu+4aMU80O7uqoSQsS/m2OjhrT5ez7jniLTb7byUUo4vVSludwHAHhAolwVASLHHMNlyg6VZ1Jb0qaE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756403221; c=relaxed/simple;
	bh=rZP6qTbqGtSIo/j16m46eXXWlP8S9wPoOQ4vZa5lhCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxXLMWHRn29ZJyxYpLLtebt6MFtajiAQd/T2z31TQI6AkRC4s4AQEL38+RIwlOgjX5JEJUJOTrU8BsjMPZYXRs+uaHz9kUQw5G7IlABDrKX2xuNQP3u4Dmz4fIwxmvM1T8/6UuS+lp2fZODq7eMiGsb33dXMWM1FNJy6XW6+IUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su5q8iz/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c68ac7e238so632724f8f.1;
        Thu, 28 Aug 2025 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756403218; x=1757008018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5BQ+lgCm+hFgInYum/X7ZXkFamcbZPOD/z43fL4xMo=;
        b=Su5q8iz/xMrLnGpMMWZmED+5CS2RucTG1CZDQb1kgAZEmD7ZVXiYRXofx7pg6RgKgG
         I/iGvylw7exYqt80JII7iBRjrHIMS3/vwOO95hQuaThRpNVlrCKZfVvl64ZDvU+dBs6d
         9oBOBQYmNyr1XdSqXX43R+TJKSqooopqHVIbVblMUipHfamEO/86NZBTvWTKm6fYTZkj
         xPkVsSH9BoBOL8Uu3uzVxxc8nBzMOiUcVQPACgpkPaKNdecSjKHGkXHYjvVQRRKSQh/L
         d9Ic4rrjdKRxj0UF7rmAyHY3ipQm3gGR9k9Xj2/NM+Tpw0es/zJAiaF/WShY1mRxG0mC
         aCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756403218; x=1757008018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5BQ+lgCm+hFgInYum/X7ZXkFamcbZPOD/z43fL4xMo=;
        b=hubqoVX6cqM7pZpr1QIAPgIPkqh/lb2vPdEtAL3PQZyUjDKGERbvRtLuruBBmPkZGb
         qTnYtmhYi68J0AW99sGOkSjfUO2ygvj5+WEX1+7e0e57iQoccwysBSR0zLQP1D2mkxIT
         umFA3CogqQZ7H2+uY2P5cuPLS1WknX34oLmOe3vaQhHonKbsOahGr7OSc4ZZxDnkybKV
         M5QMjbkxk+HHLKIWXn3bFb+uQ5aKWARTG0NTVBNXYJbq5oazwj4WRoOY5rgYvRAIp71F
         UlWwumifBsEvQyXztf6lqVQpnl4jGSo734iD5Saa996K3HtYWCSl/Wei4MU4gBD86ill
         +56w==
X-Forwarded-Encrypted: i=1; AJvYcCW41KouZW9aWW57oL+c7R3cmyOH4VQYIH8hAPUO/CP8JBop4uAinet9H64iVWpbfElTALdHtD1QZWrZajdpbco4cg==@vger.kernel.org, AJvYcCX2se59qse08woPxrYcFgOEuoIh2TadSxfSqZI1lCwVuhKXwyUhM5u1rDJuDAoJw+4K3RHdBLN1HUfNvQs7V+IE@vger.kernel.org, AJvYcCXj1PKO8Wcf6Pgr7UH9+DnQLd+cafc4fbAy/4qHU/Z+eIowtkRBb4eUwom5CR5RKjtnpvnel3fZpRa6/Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQAHSJQKfPQ6oezVLHT5dYa7VOiaBP8MCfPyNdJIM0GadNFtZ1
	GR13ok57NbQMdpu0a7KV0firlTvbUT5U4GKk2N1oRNluBDIHuZ0fjkiWz5erBjBpVLL7Q8WP1KG
	p55ee9WVHB/9rbgY0RPuuCaOFkqCy7JY=
X-Gm-Gg: ASbGncsCmg4foRmCw0vVqW/5YZXQz/JISyWfNdAEmmO4lXbKuMrTHuopBI+S+aIxxDP
	tjPrMeCUX6bspSEbhXZZEFYxNSd88x/eAvFQFf4gV1XjaYA42C5/Rq+4qLBNSGrylZQy5J1L6eS
	r7z+/B4/IALJ2juaTt9aNHEqDjrrjE/E8sFWcaEcW1fjTsswHKQDkD9knvO5anmuwutVz0QX+iV
	Q1rkY2z
X-Google-Smtp-Source: AGHT+IHvqyc3pb900sJBUTlrQWedECpbYpMB5xKIU+44UTfcRa//ZihI5MLQ29+opQFj6apn6sL8VahQFE2wKNg2fAw=
X-Received: by 2002:a5d:5d0a:0:b0:3b8:f358:e80d with SMTP id
 ffacd0b85a97d-3c5db8ab097mr20611204f8f.5.1756403217733; Thu, 28 Aug 2025
 10:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPd4Wexw_DtndDqRZzXK0PEOAkb4yWB4x8rf5eRdJOLMS-+8SQ@mail.gmail.com>
 <aK68IJPqa4YOo1S_@ghost>
In-Reply-To: <aK68IJPqa4YOo1S_@ghost>
From: Jesse T <mr.bossman075@gmail.com>
Date: Thu, 28 Aug 2025 13:46:21 -0400
X-Gm-Features: Ac12FXy3BQPFYJAdE_d0UGKSqV1g-N92aO_29KxePtztahgp0gtMrPVagjhdXHs
Message-ID: <CAJFTR8QKhMVVGa2BRpBcDvXggq5anX5wjTGH7V0_ex0JZfa7sw@mail.gmail.com>
Subject: Re: [PATCH 5/8] riscv: hw_breakpoint: Use icount for single stepping
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, 
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Shuah Khan <shuah@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Deepak Gupta <debug@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@rivosinc.com>, Anup Patel <apatel@ventanamicro.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, WangYuli <wangyuli@uniontech.com>, 
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

On Wed, Aug 27, 2025 at 4:04=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Tue, Aug 26, 2025 at 10:08:04AM +0530, Himanshu Chauhan wrote:
> > On Fri, Aug 22, 2025 at 11:17=E2=80=AFPM Jesse Taube <jesse@rivosinc.co=
m> wrote:
> > >
> > > The Sdtrig RISC-V ISA extension does not have a resume flag for
> > > returning to and executing the instruction at the breakpoint.
> > > To avoid skipping the instruction or looping, it is necessary to remo=
ve
> > > the hardware breakpoint and single step. Use the icount feature of
> > > Sdtrig to accomplish this. Use icount as default with an option to al=
low
> > > software-based single stepping when hardware or SBI does not have
> > > icount functionality, as it may cause unwanted side effects when read=
ing
> > > the instruction from memory.
> >
> > Can you please elaborate on this? I remember noticing the absence of
> > the resume flag which was causing loops.

Yes, signal handler based hardware debugging doesn't work, only ptrace base=
d.
ARM64 and ARM also don't support signal handler based hardware
debugging as seen in a later patch.

> Thank you for your feedback. Jesse's internship came to an end last
> Friday (August 22nd) so I will be picking up these patches, but I have
> also added her personal email onto this thread.

I forgot to CC my personal email sorry....

> When a breakpoint is triggered and the kernel gains control, the last
> instruction to execute was the instruction before the instruction where
> the breakpoint is installed. If execution was to be resumed at this
> stage, the same breakpoint would be triggered again. So single stepping
> requires a careful dance of enabling and disabling breakpoints. However,
> we can avoid this overhead and code complexity can be reduced by using
> the icount trigger which allows a direct method for single stepping.
>
> >
> > >
> > > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > > ---
> > > OpenSBI implementation of sbi_debug_read_triggers does not return the
> > > updated CSR values. There needs to be a check for working
> > > sbi_debug_read_triggers before this works.
> > >
> > > https://lists.riscv.org/g/tech-prs/message/1476
> > >
> > > RFC -> V1:
> > >  - Add dbtr_mode to rv_init_icount_trigger
> > >  - Add icount_triggered to check which breakpoint was triggered
> > >  - Fix typo: s/affects/effects
> > >  - Move HW_BREAKPOINT_COMPUTE_STEP to Platform type
> > > V1 -> V2:
> > >  - Remove HW_BREAKPOINT_COMPUTE_STEP kconfig option
> > > ---
> > >  arch/riscv/kernel/hw_breakpoint.c | 173 ++++++++++++++++++++++++++--=
--
> > >  1 file changed, 155 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw=
_breakpoint.c
> > > index 3f96e744a711..f12306247436 100644
> > > --- a/arch/riscv/kernel/hw_breakpoint.c
> > > +++ b/arch/riscv/kernel/hw_breakpoint.c
> > > @@ -20,6 +20,7 @@
> > >  #define DBTR_TDATA1_DMODE              BIT_UL(__riscv_xlen - 5)
> > >
> > >  #define DBTR_TDATA1_TYPE_MCONTROL      (2UL << DBTR_TDATA1_TYPE_SHIF=
T)
> > > +#define DBTR_TDATA1_TYPE_ICOUNT                (3UL << DBTR_TDATA1_T=
YPE_SHIFT)
> > >  #define DBTR_TDATA1_TYPE_MCONTROL6     (6UL << DBTR_TDATA1_TYPE_SHIF=
T)
> > >
> > >  #define DBTR_TDATA1_MCONTROL6_LOAD             BIT(0)
> > > @@ -62,6 +63,14 @@
> > >         (FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZELO_FIELD, lo) | \
> > >          FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZEHI_FIELD, hi))
> > >
> > > +#define DBTR_TDATA1_ICOUNT_U                   BIT(6)
> > > +#define DBTR_TDATA1_ICOUNT_S                   BIT(7)
> > > +#define DBTR_TDATA1_ICOUNT_PENDING             BIT(8)
> > > +#define DBTR_TDATA1_ICOUNT_M                   BIT(9)
> > > +#define DBTR_TDATA1_ICOUNT_COUNT_FIELD         GENMASK(23, 10)
> > > +#define DBTR_TDATA1_ICOUNT_VU                  BIT(25)
> > > +#define DBTR_TDATA1_ICOUNT_VS                  BIT(26)
> > > +
> > >  enum dbtr_mode {
> > >         DBTR_MODE_U =3D 0,
> > >         DBTR_MODE_S,
> > > @@ -79,6 +88,7 @@ static DEFINE_PER_CPU(union sbi_dbtr_shmem_entry, s=
bi_dbtr_shmem);
> > >
> > >  /* number of debug triggers on this cpu . */
> > >  static int dbtr_total_num __ro_after_init;
> > > +static bool have_icount __ro_after_init;
> > >  static unsigned long dbtr_type __ro_after_init;
> > >  static unsigned long dbtr_init __ro_after_init;
> > >
> > > @@ -129,6 +139,7 @@ static int arch_smp_teardown_sbi_shmem(unsigned i=
nt cpu)
> > >  static void init_sbi_dbtr(void)
> > >  {
> > >         struct sbiret ret;
> > > +       unsigned long dbtr_count =3D 0;
> > >
> > >         /*
> > >          * Called by hw_breakpoint_slots and arch_hw_breakpoint_init.
> > > @@ -143,6 +154,19 @@ static void init_sbi_dbtr(void)
> > >                 return;
> > >         }
> > >
> > > +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> > > +               DBTR_TDATA1_TYPE_ICOUNT, 0, 0, 0, 0, 0);
> > > +       if (ret.error) {
> > > +               pr_warn("%s: failed to detect icount triggers. error:=
 %ld.\n",
> > > +                       __func__, ret.error);
> > > +       } else if (!ret.value) {
> > > +               pr_warn("%s: No icount triggers available. "
> > > +                       "Falling-back to computing single step addres=
s.\n", __func__);
> > > +       } else {
> > > +               dbtr_count =3D ret.value;
> > > +               have_icount =3D true;
> > > +       }
> > > +
> > >         ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> > >                         DBTR_TDATA1_TYPE_MCONTROL6, 0, 0, 0, 0, 0);
> > >         if (ret.error) {
> > > @@ -151,7 +175,7 @@ static void init_sbi_dbtr(void)
> > >         } else if (!ret.value) {
> > >                 pr_warn("%s: No mcontrol6 triggers available.\n", __f=
unc__);
> > >         } else {
> > > -               dbtr_total_num =3D ret.value;
> > > +               dbtr_total_num =3D min_not_zero((unsigned long)ret.va=
lue, dbtr_count);
> > >                 dbtr_type =3D DBTR_TDATA1_TYPE_MCONTROL6;
> > >                 return;
> > >         }
> > > @@ -166,7 +190,7 @@ static void init_sbi_dbtr(void)
> > >                 pr_err("%s: No mcontrol triggers available.\n", __fun=
c__);
> > >                 dbtr_total_num =3D 0;
> > >         } else {
> > > -               dbtr_total_num =3D ret.value;
> > > +               dbtr_total_num =3D min_not_zero((unsigned long)ret.va=
lue, dbtr_count);
> > >                 dbtr_type =3D DBTR_TDATA1_TYPE_MCONTROL;
> > >         }
> > >  }
> > > @@ -320,6 +344,36 @@ static int rv_init_mcontrol6_trigger(const struc=
t perf_event_attr *attr,
> > >         return 0;
> > >  }
> > >
> > > +static int rv_init_icount_trigger(struct arch_hw_breakpoint *hw, enu=
m dbtr_mode mode)
> > > +{
> > > +       unsigned long tdata1 =3D DBTR_TDATA1_TYPE_ICOUNT;
> > > +
> > > +       /* Step one instruction */
> > > +       tdata1 |=3D FIELD_PREP(DBTR_TDATA1_ICOUNT_COUNT_FIELD, 1);
> > > +
> > > +       switch (mode) {
> > > +       case DBTR_MODE_U:
> > > +               tdata1 |=3D DBTR_TDATA1_ICOUNT_U;
> > > +               break;
> > > +       case DBTR_MODE_S:
> > > +               tdata1 |=3D DBTR_TDATA1_ICOUNT_S;
> > > +               break;
> > > +       case DBTR_MODE_VS:
> > > +               tdata1 |=3D DBTR_TDATA1_ICOUNT_VS;
> > > +               break;
> > > +       case DBTR_MODE_VU:
> > > +               tdata1 |=3D DBTR_TDATA1_ICOUNT_VU;
> > > +               break;
> > > +       default:
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       hw->tdata1 =3D tdata1;
> > > +       hw->tdata2 =3D 0;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  int hw_breakpoint_arch_parse(struct perf_event *bp,
> > >                              const struct perf_event_attr *attr,
> > >                              struct arch_hw_breakpoint *hw)
> > > @@ -372,24 +426,28 @@ static int setup_singlestep(struct perf_event *=
event, struct pt_regs *regs)
> > >         /* Remove breakpoint even if return error as not to loop */
> > >         arch_uninstall_hw_breakpoint(event);
> > >
> > > -       ret =3D get_insn_nofault(regs, regs->epc, &insn);
> > > -       if (ret < 0)
> > > -               return ret;
> > > +       if (have_icount) {
> > > +               rv_init_icount_trigger(bp, DBTR_MODE_U);
> > > +       } else {
> > > +               ret =3D get_insn_nofault(regs, regs->epc, &insn);
> > > +               if (ret < 0)
> > > +                       return ret;
> > >
> > > -       next_addr =3D get_step_address(regs, insn);
> > > +               next_addr =3D get_step_address(regs, insn);
> > >
> > > -       ret =3D get_insn_nofault(regs, next_addr, &insn);
> > > -       if (ret < 0)
> > > -               return ret;
> > > +               ret =3D get_insn_nofault(regs, next_addr, &insn);
> > > +               if (ret < 0)
> > > +                       return ret;
> > >
> > > -       bp_insn.bp_type =3D HW_BREAKPOINT_X;
> > > -       bp_insn.bp_addr =3D next_addr;
> > > -       /* Get the size of the intruction */
> > > -       bp_insn.bp_len =3D GET_INSN_LENGTH(insn);
> > > +               bp_insn.bp_type =3D HW_BREAKPOINT_X;
> > > +               bp_insn.bp_addr =3D next_addr;
> > > +               /* Get the size of the intruction */
> > > +               bp_insn.bp_len =3D GET_INSN_LENGTH(insn);
> > >
> > > -       ret =3D hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
> > > -       if (ret)
> > > -               return ret;
> > > +               ret =3D hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > >
> > >         ret =3D arch_install_hw_breakpoint(event);
> > >         if (ret)
> > > @@ -400,6 +458,79 @@ static int setup_singlestep(struct perf_event *e=
vent, struct pt_regs *regs)
> > >         return 0;
> > >  }
> > >
> > > +/**
> > > + * icount_triggered - Check if event's icount was triggered.
> > > + * @event: Perf event to check
> > > + *
> > > + * Check the given perf event's icount breakpoint was triggered.
> > > + *
> > > + * Returns:    1 if icount was triggered.
> > > + *             0 if icount was not triggered.
> > > + *             negative on failure.
> > > + */
> > > +static int icount_triggered(struct perf_event *event)
> > > +{
> > > +       union sbi_dbtr_shmem_entry *shmem =3D this_cpu_ptr(&sbi_dbtr_=
shmem);
> > > +       struct sbiret ret;
> > > +       struct perf_event **slot;
> > > +       unsigned long tdata1;
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < dbtr_total_num; i++) {
> > > +               slot =3D this_cpu_ptr(&pcpu_hw_bp_events[i]);
> > > +
> > > +               if (*slot =3D=3D event)
> > > +                       break;
> > > +       }
> > > +
> > > +       if (i =3D=3D dbtr_total_num) {
> > > +               pr_warn("%s: Breakpoint not installed.\n", __func__);
> > > +               return -ENOENT;
> > > +       }
> > > +
> > > +       raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> > > +                             *this_cpu_ptr(&ecall_lock_flags));
> > > +
> > > +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_READ,
> > > +                       i, 1, 0, 0, 0, 0);
> > > +       tdata1 =3D shmem->data.tdata1;
> > > +
> > > +       raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> > > +                                  *this_cpu_ptr(&ecall_lock_flags));
> > > +       if (ret.error) {
> > > +               pr_warn("%s: failed to read trigger. error: %ld\n", _=
_func__, ret.error);
> > > +               return sbi_err_map_linux_errno(ret.error);
> >
> > To avoid a flurry of events or messages, it would probably be good to
> > disable the trigger.
>
> That is a good point.

Agreed

> >
> > > +       }
> > > +
> > > +       /*
> > > +        * The RISC-V Debug Specification
> > > +        * Tim Newsome, Paul Donahue (Ventana Micro Systems)
> > > +        * Version 1.0, Revised 2025-02-21: Ratified
> > I think mentioning the version number and section would be enough.
>
> Agreed.

I wasn't sure the best way to cite this, Version number and section is
ok with me.

> > > +        * 5.7.13. Instruction Count (icount, at 0x7a1)
> > > +        * When count is 1 and the trigger matches, then pending beco=
mes set.
> > > +        * In addition count will become 0 unless it is hard-wired to=
 1.
> > > +        * When pending is set, the trigger fires just before any fur=
ther
> > > +        * instructions are executed in a mode where the trigger is e=
nabled.
> > > +        * As the trigger fires, pending is cleared. In addition, if =
count is
> > > +        * hard-wired to 1 then m, s, u, vs, and vu are all cleared.
> > > +        */
> > > +       if (FIELD_GET(DBTR_TDATA1_ICOUNT_COUNT_FIELD, tdata1) =3D=3D =
0)
> > > +               return 1;
> > > +
> > > +       if (FIELD_GET(DBTR_TDATA1_ICOUNT_COUNT_FIELD, tdata1) !=3D 1)
> > > +               return 0;
> > > +
> > > +       if (tdata1 & DBTR_TDATA1_ICOUNT_U)
> > > +               return 0;
> > > +       if (tdata1 & DBTR_TDATA1_ICOUNT_S)
> > > +               return 0;
> > > +       if (tdata1 & DBTR_TDATA1_ICOUNT_VU)
> > > +               return 0;
> > > +       if (tdata1 & DBTR_TDATA1_ICOUNT_VU)
> > > +               return 0;
> > > +       return 1;
> > > +}
> > > +
> > >  /*
> > >   * HW Breakpoint/watchpoint handler
> > >   */
> > > @@ -460,7 +591,10 @@ static int hw_breakpoint_handler(struct pt_regs =
*regs)
> > >
> > >                 if (bp->in_callback) {
> > >                         expecting_callback =3D true;
> > > -                       if (regs->epc !=3D bp->next_addr) {
> > > +                       if (have_icount) {
> > > +                               if (icount_triggered(event) !=3D 1)
> > > +                                       continue;
> > > +                       } else if (regs->epc !=3D bp->next_addr) {
> > >                                 continue;
> > >                         }
> > >
> > > @@ -477,7 +611,10 @@ static int hw_breakpoint_handler(struct pt_regs =
*regs)
> > >
> > >         }
> > >
> > > -       if (expecting_callback) {
> > > +       if (expecting_callback && have_icount) {
> > > +               pr_err("%s: in_callback was set, but icount was not t=
riggered, epc (%lx).\n",
> > > +                      __func__, regs->epc);
> > > +       } else if (expecting_callback) {
> > >                 pr_err("%s: in_callback was set, but epc (%lx) was no=
t at next address(%lx).\n",
> > >                        __func__, regs->epc, bp->next_addr);
> > >         }
> >
> > Is this just for debugging or do you want to commit it?
>
> I believe this was intentional, but perhaps it is not a useful print.

It is for someone to find out that a spurious debug trigger event
happened as it is expecting either an icount event or
a mcontrol event at next_addr if this did not happen it will send a
SIG_DEBUG to the user process.

Ignore my previous response as it was HTML.

Thanks,
Jesse

> - Charlie
>
> >
> > Regards
> > Himanshu
> > > --
> > > 2.43.0
> > >

