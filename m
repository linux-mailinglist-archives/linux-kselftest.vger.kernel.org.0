Return-Path: <linux-kselftest+bounces-48346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B5ECFB2F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 22:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDFB0301D639
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 21:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2322E542C;
	Tue,  6 Jan 2026 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="TJX9aIbr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B922A1D5
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767736763; cv=none; b=SPUzbsaKTVZ18rdZRY207klklGI+VnDf75xE1UTVdcjLy7VkNFtAi/pXPKUyzV7D9TOisqHeZx7oic1BtDmtPe2gsPdE/6F8mnMASsQp2CyL2YqWerpjL/vplhk+m1pXk6U+lJBTo5iudXmlnwBzUaoG/yCatUC8IOCxRsu5EKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767736763; c=relaxed/simple;
	bh=R750ce8l0b1/9c3Z50heUqbSocJzXDRY75RUpcUqZLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A45We+5x8kP0WL7NN/8ov0ly94b3xko6GHo8UAp6gCPNIvqinAF2CfAwAgDG6d/Ca4pBNoasBNSxaNqNv9TOz8NXhAQOU6ff33wGQMaiZ8+fSgYJK9iT8ojCSxIUITLAIOqPHwHdkfT0wcFU+THDqtZnzuj/P5mTfhgoEtqBVo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=TJX9aIbr; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-598ed017e4cso115376e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 13:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1767736759; x=1768341559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LL3o3bW6MpYlg3UB2wT1gIb9eTOIw0Vn+8gxrCV87M4=;
        b=TJX9aIbreelHnRvNdXPJX3eYO/YTrQFbCanjxQUwiLuGb1VKbMCYAR7MBClPfOv1M7
         Zox9ZtWfqWYtKPNARtrwk9oLE5ZHS8uLyYQ/X8Jp9zbF6nI75TpTIPbeC7MBxL3Qw0rc
         0u+ONWOod1ZevK74CwvQfL0Ceb6UffW0ZMyBcTTYN8F9UoX11af9MNvL4B2gbPuiSGOK
         fL4d6Kbws2q0fwLtvAAd1FTynes7eAHCRtbVYCAajZg1hnuMk925JzIQ3tvLCV8t+dBR
         t6Eeahkxwc35jDfRLLlEPXfGLti/t9PdkApIUfFMgZhGz/kxlI03ErI3jCTgNZ2LsVnZ
         hUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767736759; x=1768341559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LL3o3bW6MpYlg3UB2wT1gIb9eTOIw0Vn+8gxrCV87M4=;
        b=vyDvEUB0lrMCSrWnKSyQSyn+OsN7ROvJV3NQfk29vFLtsNgTFf9EoJ5JdyzLroRyIL
         eKMqXyFyQL1QGl2AF8aFq5se4qmgCvFW+ubOkmbBxjEcxTGuW4gTjFftf0QBig+B7e30
         hSPov5nkiNB1mYqwvmQOuidwkcR3YFA3BzC+Z6F9Xgpx+6W3+eTJu+RI+FlLQQlsFmjm
         SOmHfMgsiQHFqjhRysvlN7rKoRUQTaRQqU2uM7ougFrby/wP+HuZ31Br4gSqYbdHYYkY
         U1qU2hB0xtDrLXg6BL0CUvkjT9VwyqeNrfpbu50J01yuVfVK8jRFW7+wDd8+f9xbxKaE
         UjOA==
X-Forwarded-Encrypted: i=1; AJvYcCW1cBNFhg0IgaTWckdAd31IhbdTDNvg3rudKJziOSsPdARTrsVStpv4xOH7jCL8dqgxDJjwisqkQF300oYXrdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdrs7Y6j2zXKIMVpjxphT0+usmdtAB4BnvV3hhj7cyOS0rv+Wx
	f6x8Rhe96QPPxpKswDf2XmQvI+Jf0apLV0UclgkNptF0Hp4wcg28vm6G6otVTIHrvZOr0/t9iPX
	vCwY8gnV1nvuoul1dL64HxzIRCVZrV8bXR7FlTvwFtA==
X-Gm-Gg: AY/fxX45fd9DlcItfcYlh2uwSmfMMtpGHOAr8Va18NH80JYgtgHOFLPh/v77Dmh0JQX
	sXi5kNogo7AfCNKJV7lRtO4Wmta/Ph6PusAFTIRl/tOdJ36RMAPlL1OBt3bLRXnu6pA5ZGlcj3Y
	LsqkHHnY34hK3US7ycd5EJIoQ/7Xc4szoiTbJeEodA2R7LCY0zf8a68QhK5kMDs9BFYsIvi6n6z
	BRfi+ZvhYax8Pmay7TzDVz7BE0DIYQ+zTM+rjxazvFJtzEyntPMX06TxRXGf6mx77nufvmmh5vA
	2eFUI+wKIYN6CBKTmQdUBZBpBoGfuIDIwY/7DA==
X-Google-Smtp-Source: AGHT+IFERCo72QSYQ9BzZEPvaFJgZQRgyBmU4cYQWVcDInctiS26qpqxPn6hY068jsKe3lhdV1BwzBrHbSc2L3Zyss0=
X-Received: by 2002:a05:6512:114a:b0:592:f383:3aad with SMTP id
 2adb3069b0e04-59b6f05b7demr61003e87.8.1767736758907; Tue, 06 Jan 2026
 13:59:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209064050.2746540-1-christoph.muellner@vrull.eu>
 <20240209064050.2746540-5-christoph.muellner@vrull.eu> <tencent_5F1B1F8D209B3699631D6E6C4C668848E306@qq.com>
 <CAMOCf+juAnfmC=TfGCGdpeZQbnSLULPwPOyx2A2Jfi3vDs89xg@mail.gmail.com>
In-Reply-To: <CAMOCf+juAnfmC=TfGCGdpeZQbnSLULPwPOyx2A2Jfi3vDs89xg@mail.gmail.com>
From: Philipp Tomsich <philipp.tomsich@vrull.eu>
Date: Tue, 6 Jan 2026 22:59:07 +0100
X-Gm-Features: AQt7F2qlljFWWTVJtocRnU4jpH1jcXaCnpY9JFdlTfKbJD82kTjuaoWjPmtJsQ4
Message-ID: <CAAeLtUBWT+K6mrHsoyBqjzYzjTtf1xUevsHYk3+xBWEqTsZ6Eg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] RISC-V: Implement prctl call to set/get the
 memory consistency model
To: Hans Boehm <hboehm@google.com>
Cc: Yangyu Chen <cyy@cyyself.name>, =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>, 
	linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, Peter Zijlstra <peterz@infradead.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Anup Patel <apatel@ventanamicro.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Guo Ren <guoren@kernel.org>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will@kernel.org>, 
	Daniel Lustig <dlustig@nvidia.com>, Brendan Sweeney <turtwig@utexas.edu>, 
	Andrew Waterman <andrew@sifive.com>, Brendan Sweeney <brs@berkeley.edu>, 
	Andrea Parri <parri.andrea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The standardisation of Ssdtso is on-hold (probably permanently) in
response to feedback received during the review process.
Unless a strong consensus forms around the need to standardise for one
vertical or the other, I don't see Ssdtso moving forward given the
concerns regarding possible fragmentation for the ecosystem.

Best,
Philipp.


On Tue, 6 Jan 2026 at 22:54, Hans Boehm <hboehm@google.com> wrote:
>
> I'm not sure what the Sstdso status is.
>
> I would also greatly prefer to not have such a dynamic switching facility=
 generally available, for reasons very similar to those that Will Deacon ga=
ve in the earlier ARM discussion. If this is generally available, I expect =
people to use it to work around memory ordering bugs in one software compon=
ent by switching the entire process to TSO mode, even on hardware with an u=
noptimized TSO implementation. This will impose pressure to optimize TSO ev=
erywhere. We will increase pressure to ship TSO libraries to take advantage=
 of situations in which we're running in TSO mode. I think there is signifi=
cant risk of splitting the ecosystem in this way, possibly with an eventual=
 painful migration from RVWMO to TSO. IIRC, SPARC went through something va=
guely similar in its early days.
>
> Dealing with one memory model per platform is complicated enough; we don'=
t want two.
>
> If you do this somewhere under the covers to implement an x86 VM, OK. But=
 please don't let apps switch memory models.
>
> Hans
>
> On Mon, Jan 5, 2026 at 11:46=E2=80=AFPM Yangyu Chen <cyy@cyyself.name> wr=
ote:
>>
>> Hi Mullner,
>>
>> Thanks for this work, although it has already lasted for about 2 years.
>>
>> On 9/2/2024 14:40, Christoph M=C3=BCllner wrote:
>> > We can use the PR_{S,G}ET_MEMORY_CONSISTENCY_MODEL prctl calls to chan=
ge
>> > the memory consistency model at run-time if we have Ssdtso.
>> > This patch registers RISCV_WMO and RISCV_TSO as valid arguments
>> > for these prctl calls and implements the glue code to switch
>> > between these.
>> >
>> > Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
>> > ---
>> >   .../mm/dynamic-memory-consistency-model.rst   | 12 +++-
>> >   arch/riscv/include/asm/processor.h            |  7 ++
>> >   arch/riscv/kernel/Makefile                    |  1 +
>> >   arch/riscv/kernel/dtso.c                      | 67 +++++++++++++++++=
++
>> >   include/uapi/linux/prctl.h                    |  2 +
>> >   5 files changed, 88 insertions(+), 1 deletion(-)
>> >   create mode 100644 arch/riscv/kernel/dtso.c
>> >
>> > diff --git a/Documentation/mm/dynamic-memory-consistency-model.rst b/D=
ocumentation/mm/dynamic-memory-consistency-model.rst
>> > index 1fce855a1fad..c8188c174e27 100644
>> > --- a/Documentation/mm/dynamic-memory-consistency-model.rst
>> > +++ b/Documentation/mm/dynamic-memory-consistency-model.rst
>> > @@ -73,4 +73,14 @@ Supported memory consistency models
>> >   This section defines the memory consistency models which are support=
ed
>> >   by the prctl interface.
>> >
>> > -<none>
>> > +RISC-V
>> > +------
>> > +
>> > +RISC-V uses RVWMO (RISC-V weak memory ordering) as default memory con=
sistency
>> > +model. TSO (total store ordering) is another specified model and prov=
ides
>> > +additional ordering guarantees. Switching user-mode processes from RV=
WMO to TSO
>> > +is possible when the Ssdtso extension is available.
>> > +
>> > +* :c:macro:`PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO`: RISC-V weak memor=
y ordering (default).
>> > +
>> > +* :c:macro:`PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO`: RISC-V total stor=
e ordering.
>> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/a=
sm/processor.h
>> > index a8509cc31ab2..05e05fddc94d 100644
>> > --- a/arch/riscv/include/asm/processor.h
>> > +++ b/arch/riscv/include/asm/processor.h
>> > @@ -184,6 +184,13 @@ extern int set_unalign_ctl(struct task_struct *ts=
k, unsigned int val);
>> >   #define GET_UNALIGN_CTL(tsk, addr)  get_unalign_ctl((tsk), (addr))
>> >   #define SET_UNALIGN_CTL(tsk, val)   set_unalign_ctl((tsk), (val))
>> >
>> > +#ifdef CONFIG_RISCV_ISA_SSDTSO
>> > +extern int dtso_set_memory_consistency_model(unsigned long arg);
>> > +extern int dtso_get_memory_consistency_model(void);
>> > +#define SET_MEMORY_CONSISTENCY_MODEL(arg)    dtso_set_memory_consiste=
ncy_model(arg)
>> > +#define GET_MEMORY_CONSISTENCY_MODEL()               dtso_get_memory_=
consistency_model()
>> > +#endif /* CONIG_RISCV_ISA_SSDTSO */
>> > +
>> >   #endif /* __ASSEMBLY__ */
>> >
>> >   #endif /* _ASM_RISCV_PROCESSOR_H */
>> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> > index f71910718053..85f7291da498 100644
>> > --- a/arch/riscv/kernel/Makefile
>> > +++ b/arch/riscv/kernel/Makefile
>> > @@ -65,6 +65,7 @@ obj-$(CONFIG_RISCV_MISALIGNED)      +=3D traps_misal=
igned.o
>> >   obj-$(CONFIG_FPU)           +=3D fpu.o
>> >   obj-$(CONFIG_RISCV_ISA_V)   +=3D vector.o
>> >   obj-$(CONFIG_RISCV_ISA_V)   +=3D kernel_mode_vector.o
>> > +obj-$(CONFIG_RISCV_ISA_SSDTSO)       +=3D dtso.o
>> >   obj-$(CONFIG_SMP)           +=3D smpboot.o
>> >   obj-$(CONFIG_SMP)           +=3D smp.o
>> >   obj-$(CONFIG_SMP)           +=3D cpu_ops.o
>> > diff --git a/arch/riscv/kernel/dtso.c b/arch/riscv/kernel/dtso.c
>> > new file mode 100644
>> > index 000000000000..591d5f9de0f5
>> > --- /dev/null
>> > +++ b/arch/riscv/kernel/dtso.c
>> > @@ -0,0 +1,67 @@
>> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> > +/*
>> > + * Copyright (c) 2024 Christoph Muellner <christoph.muellner@vrull.eu=
>
>> > + */
>> > +
>> > +#include <linux/cpu.h>
>> > +#include <linux/smp.h>
>> > +#include <linux/prctl.h>
>> > +
>> > +#include <asm/cpu.h>
>> > +#include <asm/dtso.h>
>> > +
>> > +#include <trace/events/ipi.h>
>> > +
>> > +int dtso_set_memory_consistency_model(unsigned long arg)
>> > +{
>> > +     int cpu;
>> > +     unsigned long cur_model =3D get_memory_consistency_model(current=
);
>> > +     unsigned long new_model;
>> > +
>> > +     switch (arg) {
>> > +     case PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO:
>> > +             new_model =3D RISCV_MEMORY_CONSISTENCY_MODEL_WMO;
>> > +             break;
>> > +     case PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO:
>> > +             new_model =3D RISCV_MEMORY_CONSISTENCY_MODEL_TSO;
>> > +             break;
>> > +     default:
>> > +             return -EINVAL;
>> > +     }
>> > +
>> > +     /* No change requested. */
>> > +     if (cur_model =3D=3D new_model)
>> > +             return 0;
>> > +
>> > +     /* Enabling TSO only works if DTSO is available. */
>> > +     if (new_model =3D=3D PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO && !h=
as_dtso())
>> > +             return -EINVAL;
>> > +
>> > +     /* Switching TSO->WMO is not allowed. */
>> > +     if (new_model =3D=3D RISCV_MEMORY_CONSISTENCY_MODEL_WMO)
>> > +             return -EINVAL;
>> > +
>> > +     /* Set the new model in the task struct. */
>> > +     set_memory_consitency_model(current, new_model);
>> > +
>> > +     /*
>> > +      * We need to reschedule all threads of the current process.
>> > +      * Let's do this by rescheduling all CPUs.
>> > +      * This is stricter than necessary, but since this call is
>> > +      * not expected to happen frequently the impact is low.
>> > +      */
>> > +     for_each_cpu(cpu, cpu_online_mask)
>> > +             smp_send_reschedule(cpu);
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +int dtso_get_memory_consistency_model(void)
>> > +{
>> > +     unsigned long cur_model =3D get_memory_consistency_model(current=
);
>> > +
>> > +     if (cur_model =3D=3D RISCV_MEMORY_CONSISTENCY_MODEL_TSO)
>> > +             return PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO;
>> > +
>> > +     return PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO;
>> > +}
>> > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> > index 579662731eaa..20264bdc3092 100644
>> > --- a/include/uapi/linux/prctl.h
>> > +++ b/include/uapi/linux/prctl.h
>> > @@ -308,5 +308,7 @@ struct prctl_mm_map {
>> >
>> >   #define PR_SET_MEMORY_CONSISTENCY_MODEL             71
>> >   #define PR_GET_MEMORY_CONSISTENCY_MODEL             72
>> > +# define PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO       1
>> > +# define PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO       2
>>
>> Should we replace "PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO" with
>> "PR_MEMORY_CONSISTENCY_MODEL_TSO", so that it can share the same key as
>> Apple's TSO implementation [1]? RISC-V Ssdtso would make such prctl more
>> likely to be accepted.
>>
>> [1] https://lore.kernel.org/lkml/20240411-tso-v1-0-754f11abfbff@marcan.s=
t/
>>
>> Thanks,
>> Yangyu Chen
>>
>> >
>> >   #endif /* _LINUX_PRCTL_H */
>>

