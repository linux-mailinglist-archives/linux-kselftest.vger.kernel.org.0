Return-Path: <linux-kselftest+bounces-5686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9CD86DAD9
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 05:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC8F282175
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 04:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39EA4F8B2;
	Fri,  1 Mar 2024 04:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="bMuq+vJY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423224EB3A
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 04:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709268468; cv=none; b=Ao7MHhqc4QqPRKpLroQwdIJZrlw8IrxY11lfx4pItnXmQOoEjNPbk6aaZ7VLrhrlf0W3wHioOE/vy4vXK5KjQ/GrFm1dHCUNnDcn6HclEzBnSwGOOvgBx81ZJi+SGCZxMMLXZ8YAydZW11/go39gxH2HYkdX56mQwlnNVqupGdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709268468; c=relaxed/simple;
	bh=2Kx/8De/zGNTEiKivlxpiGDKzhQ7rwI4Gz5ao+Dc+bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeJQThGhhqdbPQ0G2pvUi+iC8soxcP9E137lFQQWnGObpfNFIrYplnkO4BUVrYJQ5t+pjdBjXIPm39V9gkX75jOPouU4EqwCosSHFKrZi7x8tJQZqAdw/Pynk+UFOEImhGo/7lRag1/nYF6CNmoFVIeFlaFgA627/OgCXmgx5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=bMuq+vJY; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3652731b2b7so6642945ab.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 20:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1709268466; x=1709873266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dh6EmicrvydaeefNlVfBuSYTMpXKsDP8irGz9s4PCAI=;
        b=bMuq+vJYRqCsdBK7tVJZkR/VA2paFOYSplEDbo7c3HSKZ7PAFUk2YOwWzO28paBvdp
         OvRLYFCu0153HIDdAaV99PHk4x+XffXwyy4OLEOk/rhx0fXDFv7ugzCritPAHmw6PuPU
         j9KzZnVPnp5ljU5LAkK9ilJj8H4a7waSxV5plvsmS1GqvMb9mKlvAsxgBIqlr30qeVzj
         lT2COVWs/ADFxAYsiN/M6ini7tE9bkgE1kzzBQ0dsej3EuBrKWFIaOvW4LC4isehWkNA
         yfpaVnHF8G1U+lkk+mu9pIrHSgV2dE5UTqge5JRKCy6EMAvOk56Maya60dUGLCDzu5z7
         Hwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709268466; x=1709873266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dh6EmicrvydaeefNlVfBuSYTMpXKsDP8irGz9s4PCAI=;
        b=ZCrk9rlZogG+ZdAPylt06gxDj+khLFyGCBDWhsTN74CgL4I4Fr5PM35lNRJvLWYfos
         aMjjOOdBKKoVYoRpoYRnbcfqClGUWZap0/ihruGGbCHx/xbhcHh/spkaUVP8BakpuZ2Q
         InCDJW/ZMsgRhcc9p5DMXn/Fal4V4I7V+vrj7PbhZgJwCGPujm9qcaWi4Zr99oSbYgrc
         zhtizpcuebL4eE+tT7BsWfUOzHMzyfgcU+AXjc+Fa4RR+3QY0CkReW51f2qRwz+p/lFO
         hkij80V51PdxPOZhpIkhcjDnhponyKp0eSsGiLG6S5ZzaM17mWJzi91z4fmyRRE1uwZg
         KXqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVInLxRw/KbPio+oZ8aNUjuldyh1OD2QDPow1g47T48NXjJAbloGVrltQ5P+TOozgPm9BLbeVO32y/LT6GT0x6Qsam9LueBlPaEYSMQF0Lk
X-Gm-Message-State: AOJu0YyPQ9aCCSHzIk53TNvVOwweH73fRHZnbG8dBXbcySm9WTnto4TJ
	t8KaBwWJlirx1b615X2VEWZEq3FNIdMZN+7cH1ichtXpmx0Zn+4Z68wW0h1yyEiz4GSx+I+B0FF
	3unqtZThbEGgA3am78TyFJ56wj8kD7WM7L7q1Ew==
X-Google-Smtp-Source: AGHT+IFQrfT74kzngPichSZmsT8UVp8fvCTSuRLcSgY309GgseLRD9lfR3Y3izMJLl2uiTzVYMVeBi6VuTOl33+rotM=
X-Received: by 2002:a05:6e02:1bc9:b0:365:bb5e:9f2f with SMTP id
 x9-20020a056e021bc900b00365bb5e9f2fmr824065ilv.13.1709268466318; Thu, 29 Feb
 2024 20:47:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229010130.1380926-1-atishp@rivosinc.com> <20240229010130.1380926-14-atishp@rivosinc.com>
In-Reply-To: <20240229010130.1380926-14-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 1 Mar 2024 10:17:36 +0530
Message-ID: <CAAhSdy3HYzc1fPBg88-7cYogT5y1Y9+4-syx4-7scxZsbmBeuQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] KVM: riscv: selftests: Add SBI PMU selftest
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:32=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> This test implements basic sanity test and cycle/instret event
> counting tests.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

I feel the test should have been called sbi_pmu_test but no need to
revise this series. I will take care of it at the time of merging.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/Makefile        |   1 +
>  tools/testing/selftests/kvm/riscv/sbi_pmu.c | 340 ++++++++++++++++++++
>  2 files changed, 341 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/riscv/sbi_pmu.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftes=
ts/kvm/Makefile
> index 426f85798aea..b2dce6843b9e 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -195,6 +195,7 @@ TEST_GEN_PROGS_riscv +=3D kvm_create_max_vcpus
>  TEST_GEN_PROGS_riscv +=3D kvm_page_table_test
>  TEST_GEN_PROGS_riscv +=3D set_memory_region_test
>  TEST_GEN_PROGS_riscv +=3D steal_time
> +TEST_GEN_PROGS_riscv +=3D riscv/sbi_pmu
>
>  SPLIT_TESTS +=3D arch_timer
>  SPLIT_TESTS +=3D get-reg-list
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu.c b/tools/testing/=
selftests/kvm/riscv/sbi_pmu.c
> new file mode 100644
> index 000000000000..fc1fc5eea99e
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * arch_timer.c - Tests the riscv64 sstc timer IRQ functionality
> + *
> + * The test validates the sstc timer IRQs using vstimecmp registers.
> + * It's ported from the aarch64 arch_timer test.
> + *
> + * Copyright (c) 2024, Rivos Inc.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include "kvm_util.h"
> +#include "test_util.h"
> +#include "processor.h"
> +
> +/* Maximum counters (firmware + hardware)*/
> +#define RISCV_MAX_PMU_COUNTERS 64
> +union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
> +
> +/* Cache the available counters in a bitmask */
> +static unsigned long counter_mask_available;
> +
> +unsigned long pmu_csr_read_num(int csr_num)
> +{
> +#define switchcase_csr_read(__csr_num, __val)          {\
> +       case __csr_num:                                 \
> +               __val =3D csr_read(__csr_num);            \
> +               break; }
> +#define switchcase_csr_read_2(__csr_num, __val)                {\
> +       switchcase_csr_read(__csr_num + 0, __val)        \
> +       switchcase_csr_read(__csr_num + 1, __val)}
> +#define switchcase_csr_read_4(__csr_num, __val)                {\
> +       switchcase_csr_read_2(__csr_num + 0, __val)      \
> +       switchcase_csr_read_2(__csr_num + 2, __val)}
> +#define switchcase_csr_read_8(__csr_num, __val)                {\
> +       switchcase_csr_read_4(__csr_num + 0, __val)      \
> +       switchcase_csr_read_4(__csr_num + 4, __val)}
> +#define switchcase_csr_read_16(__csr_num, __val)       {\
> +       switchcase_csr_read_8(__csr_num + 0, __val)      \
> +       switchcase_csr_read_8(__csr_num + 8, __val)}
> +#define switchcase_csr_read_32(__csr_num, __val)       {\
> +       switchcase_csr_read_16(__csr_num + 0, __val)     \
> +       switchcase_csr_read_16(__csr_num + 16, __val)}
> +
> +       unsigned long ret =3D 0;
> +
> +       switch (csr_num) {
> +       switchcase_csr_read_32(CSR_CYCLE, ret)
> +       switchcase_csr_read_32(CSR_CYCLEH, ret)
> +       default :
> +               break;
> +       }
> +
> +       return ret;
> +#undef switchcase_csr_read_32
> +#undef switchcase_csr_read_16
> +#undef switchcase_csr_read_8
> +#undef switchcase_csr_read_4
> +#undef switchcase_csr_read_2
> +#undef switchcase_csr_read
> +}
> +
> +static inline void dummy_func_loop(int iter)
> +{
> +       int i =3D 0;
> +
> +       while (i < iter) {
> +               asm volatile("nop");
> +               i++;
> +       }
> +}
> +
> +static void guest_illegal_exception_handler(struct ex_regs *regs)
> +{
> +       __GUEST_ASSERT(regs->cause =3D=3D EXC_INST_ILLEGAL,
> +                      "Unexpected exception handler %lx\n", regs->cause)=
;
> +
> +       /* skip the trapping instruction */
> +       regs->epc +=3D 4;
> +}
> +
> +static unsigned long get_counter_index(unsigned long cbase, unsigned lon=
g cmask,
> +                                      unsigned long cflags,
> +                                      unsigned long event)
> +{
> +       struct sbiret ret;
> +
> +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cba=
se, cmask,
> +                       cflags, event, 0, 0);
> +       __GUEST_ASSERT(ret.error =3D=3D 0, "config matching failed %ld\n"=
, ret.error);
> +       GUEST_ASSERT((ret.value < RISCV_MAX_PMU_COUNTERS) &&
> +                   ((1UL << ret.value) & counter_mask_available));
> +
> +       return ret.value;
> +}
> +
> +static unsigned long get_num_counters(void)
> +{
> +       struct sbiret ret;
> +
> +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_NUM_COUNTERS, 0, 0, 0,=
 0, 0, 0);
> +
> +       __GUEST_ASSERT(ret.error =3D=3D 0, "Unable to retrieve number of =
counters from SBI PMU");
> +
> +       __GUEST_ASSERT(ret.value < RISCV_MAX_PMU_COUNTERS,
> +                      "Invalid number of counters %ld\n", ret.value);
> +
> +       return ret.value;
> +}
> +
> +static void update_counter_info(int num_counters)
> +{
> +       int i =3D 0;
> +       struct sbiret ret;
> +
> +       for (i =3D 0; i < num_counters; i++) {
> +               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_IN=
FO, i, 0, 0, 0, 0, 0);
> +
> +               /* There can be gaps in logical counter indicies*/
> +               if (!ret.error)
> +                       GUEST_ASSERT_NE(ret.value, 0);
> +
> +               ctrinfo_arr[i].value =3D ret.value;
> +               counter_mask_available |=3D BIT(i);
> +       }
> +
> +       GUEST_ASSERT(counter_mask_available > 0);
> +}
> +
> +static unsigned long read_counter(int idx, union sbi_pmu_ctr_info ctrinf=
o)
> +{
> +       unsigned long counter_val =3D 0;
> +       struct sbiret ret;
> +
> +       __GUEST_ASSERT(ctrinfo.type < 2, "Invalid counter type %d", ctrin=
fo.type);
> +
> +       if (ctrinfo.type =3D=3D SBI_PMU_CTR_TYPE_HW) {
> +               counter_val =3D pmu_csr_read_num(ctrinfo.csr);
> +       } else if (ctrinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW) {
> +               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_REA=
D, idx, 0, 0, 0, 0, 0);
> +               GUEST_ASSERT(ret.error =3D=3D 0);
> +               counter_val =3D ret.value;
> +       }
> +
> +       return counter_val;
> +}
> +
> +static void start_counter(unsigned long counter, unsigned long start_fla=
gs,
> +                         unsigned long ival)
> +{
> +       struct sbiret ret;
> +
> +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, counter=
, 1, start_flags,
> +                       ival, 0, 0);
> +       __GUEST_ASSERT(ret.error =3D=3D 0, "Unable to start counter %ld\n=
", counter);
> +}
> +
> +static void stop_counter(unsigned long counter, unsigned long stop_flags=
)
> +{
> +       struct sbiret ret;
> +
> +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, counter,=
 1, stop_flags,
> +                       0, 0, 0);
> +       if (stop_flags & SBI_PMU_STOP_FLAG_RESET)
> +               __GUEST_ASSERT(ret.error =3D=3D SBI_ERR_ALREADY_STOPPED,
> +                              "Unable to stop counter %ld\n", counter);
> +       else
> +               __GUEST_ASSERT(ret.error =3D=3D 0, "Unable to stop counte=
r %ld error %ld\n",
> +                              counter, ret.error);
> +}
> +
> +static void test_pmu_event(unsigned long event)
> +{
> +       unsigned long counter;
> +       unsigned long counter_value_pre, counter_value_post;
> +       unsigned long counter_init_value =3D 100;
> +
> +       counter =3D get_counter_index(0, counter_mask_available, 0, event=
);
> +       counter_value_pre =3D read_counter(counter, ctrinfo_arr[counter])=
;
> +
> +       /* Do not set the initial value */
> +       start_counter(counter, 0, counter_init_value);
> +       dummy_func_loop(10000);
> +
> +       stop_counter(counter, 0);
> +
> +       counter_value_post =3D read_counter(counter, ctrinfo_arr[counter]=
);
> +       __GUEST_ASSERT(counter_value_post > counter_value_pre,
> +                      "counter_value_post %lx counter_value_pre %lx\n",
> +                      counter_value_post, counter_value_pre);
> +
> +       /* Now set the initial value and compare */
> +       start_counter(counter, SBI_PMU_START_FLAG_SET_INIT_VALUE, counter=
_init_value);
> +       dummy_func_loop(10000);
> +
> +       stop_counter(counter, 0);
> +
> +       counter_value_post =3D read_counter(counter, ctrinfo_arr[counter]=
);
> +       __GUEST_ASSERT(counter_value_post > counter_init_value,
> +                      "counter_value_post %lx counter_init_value %lx\n",
> +                      counter_value_post, counter_init_value);
> +
> +       stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
> +}
> +
> +static void test_invalid_event(void)
> +{
> +       struct sbiret ret;
> +       unsigned long event =3D 0x1234; /* A random event */
> +
> +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, 0,
> +                       counter_mask_available, 0, event, 0, 0);
> +       GUEST_ASSERT_EQ(ret.error, SBI_ERR_NOT_SUPPORTED);
> +}
> +
> +static void test_pmu_events(int cpu)
> +{
> +       int num_counters =3D 0;
> +
> +       /* Get the counter details */
> +       num_counters =3D get_num_counters();
> +       update_counter_info(num_counters);
> +
> +       /* Sanity testing for any random invalid event */
> +       test_invalid_event();
> +
> +       /* Only these two events are guranteed to be present */
> +       test_pmu_event(SBI_PMU_HW_CPU_CYCLES);
> +       test_pmu_event(SBI_PMU_HW_INSTRUCTIONS);
> +
> +       GUEST_DONE();
> +}
> +
> +static void test_pmu_basic_sanity(int cpu)
> +{
> +       long out_val =3D 0;
> +       bool probe;
> +       struct sbiret ret;
> +       int num_counters =3D 0, i;
> +       unsigned long counter_val =3D -1;
> +       union sbi_pmu_ctr_info ctrinfo;
> +
> +       probe =3D guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
> +       GUEST_ASSERT(probe && out_val =3D=3D 1);
> +
> +       num_counters =3D get_num_counters();
> +
> +       for (i =3D 0; i < num_counters; i++) {
> +               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_IN=
FO, i,
> +                               0, 0, 0, 0, 0);
> +
> +               /* There can be gaps in logical counter indicies*/
> +               if (!ret.error)
> +                       GUEST_ASSERT_NE(ret.value, 0);
> +               else
> +                       continue;
> +
> +               ctrinfo.value =3D ret.value;
> +
> +               /* Accesibility check of hardware and read capability of =
firmware counters */
> +               counter_val =3D read_counter(i, ctrinfo);
> +               /* The spec doesn't mandate any initial value. Verify if =
a sane value */
> +               GUEST_ASSERT_NE(counter_val, -1);
> +       }
> +
> +       GUEST_DONE();
> +}
> +
> +static void run_vcpu(struct kvm_vcpu *vcpu)
> +{
> +       struct ucall uc;
> +
> +       vcpu_run(vcpu);
> +       switch (get_ucall(vcpu, &uc)) {
> +       case UCALL_ABORT:
> +               REPORT_GUEST_ASSERT(uc);
> +               break;
> +       case UCALL_DONE:
> +       case UCALL_SYNC:
> +               break;
> +       default:
> +               TEST_FAIL("Unknown ucall %lu", uc.cmd);
> +               break;
> +       }
> +}
> +
> +void test_vm_destroy(struct kvm_vm *vm)
> +{
> +       memset(ctrinfo_arr, 0, sizeof(union sbi_pmu_ctr_info) * RISCV_MAX=
_PMU_COUNTERS);
> +       counter_mask_available =3D 0;
> +       kvm_vm_free(vm);
> +}
> +
> +static void test_vm_basic_test(void *guest_code)
> +{
> +       struct kvm_vm *vm;
> +       struct kvm_vcpu *vcpu;
> +
> +       vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +       __TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_S=
BI_EXT_PMU)),
> +                                  "SBI PMU not available, skipping test"=
);
> +       vm_init_vector_tables(vm);
> +       /* Illegal instruction handler is required to verify read access =
without configuration */
> +       vm_install_exception_handler(vm, EXC_INST_ILLEGAL, guest_illegal_=
exception_handler);
> +
> +       vcpu_init_vector_tables(vcpu);
> +       vcpu_args_set(vcpu, 1, 0);
> +       run_vcpu(vcpu);
> +
> +       test_vm_destroy(vm);
> +}
> +
> +static void test_vm_events_test(void *guest_code)
> +{
> +       struct kvm_vm *vm =3D NULL;
> +       struct kvm_vcpu *vcpu =3D NULL;
> +
> +       vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +       __TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_S=
BI_EXT_PMU)),
> +                                  "SBI PMU not available, skipping test"=
);
> +       vcpu_args_set(vcpu, 1, 0);
> +       run_vcpu(vcpu);
> +
> +       test_vm_destroy(vm);
> +}
> +
> +int main(void)
> +{
> +       test_vm_basic_test(test_pmu_basic_sanity);
> +       pr_info("SBI PMU basic test : PASS\n");
> +
> +       test_vm_events_test(test_pmu_events);
> +       pr_info("SBI PMU event verification test : PASS\n");
> +
> +       return 0;
> +}
> --
> 2.34.1
>

