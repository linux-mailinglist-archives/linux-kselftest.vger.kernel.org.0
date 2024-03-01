Return-Path: <linux-kselftest+bounces-5688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B833386DAE1
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 05:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD441C2314C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 04:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD185102B;
	Fri,  1 Mar 2024 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="fgvO7kpX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A43F50278
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709268814; cv=none; b=rKmcqzlq5flbnTRlWV6MQNRdoop41hgMQy3YuSTDnPLxhUR6NzJJOZpOLJ+kAixqM/xA0KIQmmC4OX0E+9OgJjadiTxe4tnuSCoS+lrC4qFjk1vWfjOnKpyN5QKOyFvz+4l0SdK7BH4JVDGJRCI2A4R4T+pKgiKb1P6QcldxdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709268814; c=relaxed/simple;
	bh=8ZH9AyJ+xU1bmbATL4Qv8AX1fQNbVKSedUNCsAKNXLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpU50knkYTR8OMDrSjZXrjqyQrQGlCPowZYsbTTKXPxNu4EeMe4NjIOsL6uG/AZ/gnVGVyGkfv2D36l0GsOeOn0F3Y5HsID/PPp9V+He65PHf07tWbSLOt+nQ1VRd/aUnP8WX1x9YhvmJepOLygfkIuq3V00+0kpa5pqCWHYYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=fgvO7kpX; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c7c984699fso71811039f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 20:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1709268811; x=1709873611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHf6nfkVPD7L9IoFJ6h/nCUsLd5vKy2G9YCRH63MbH0=;
        b=fgvO7kpXPUA7WuYawVZ83QLgPqEG28qCQEkrJBvWaMRxq5iDuCw2NmUYJbb0EO5ML1
         yuazSMrVYd29+J0JPxShoLEK+SaoFiNGA1GI6pK1LfsVt4f7PXKY2IUlqyIMFkqtMMCt
         R1/spF/p8vfyZzNDcITZ0jMNUOJoZw4ibMXBHoRCHG9SricpWNWICTWuTjSis7w4wN8o
         1s7fVh3YYDj9SwCqqMF/0L1Un6gRV+RsHyhiMETX2JaiGF8LK6NlbQkqUtbOgJX8O/m/
         jVXKnanGilAXZ1+15qoazrQjdhVkYVnVJFyQZsMG4PDlT1McB8zuiBPUsTdWl+b8dUr2
         UtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709268811; x=1709873611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHf6nfkVPD7L9IoFJ6h/nCUsLd5vKy2G9YCRH63MbH0=;
        b=DMeSAd7oxz7+pbljtn/rVMYG/i9/3JNY9ZAyxM03BIl1oPjKbm4WV8gwgi/X5okb+i
         OSujQXNt2DJDrAmHDabWruiw688FendeFORN0Xe8IEfuOyvZRiGgATO/W/Q+jfQbNoNd
         uGimgsciOxRAL9Md9ra6c/W3scaPz6sK5EjcDziwqsOqTDP0Pec/GWczibVr5asxZjiD
         mG7vReiSwgHcEAkBW6bgX254XgrmBpN5+qBVXLfiZUfNA3++CJAZfuCiWVQC8amyO8jy
         1HJzQpAyXLpuVI9T6qr1BZPS54i+8P3zDcf+x3DQ803CPIxN5a0+vtJLq8xUvOBYg/WY
         AndA==
X-Forwarded-Encrypted: i=1; AJvYcCV4wovQihSXLO3nQ9zuNSXjBtUOfLsPD/UkOnWpNNJJtUrWNWuDCfTf8hSLQdvZZj6MqqiZ6NuvBBc2UIbQEIFYTXE6xju8jz99p96UcITq
X-Gm-Message-State: AOJu0YxSBFPOet3SAo18rFmBT6TpRioRaa8885GxomsaIEVvUStMi/Xz
	9xv8BRWbvf48mPIjxdTXvHV4MplQHT/aTLtMLsKnvs5SQh177DWArFKfjgrynQWe/S2+V4n0Hot
	/jt0U7vWz0PcLbtkwwM9Di5lrmpRIA1lMEp/maw==
X-Google-Smtp-Source: AGHT+IE14lajb9MhqXWHjx3BllnF/9ijrqfTyvGTyWw00VqyQL0Pulbq0RlNOnjkeJCiq/rNZT9G8Z7BRuMG+B0VW4c=
X-Received: by 2002:a05:6e02:1e0b:b0:363:ad01:f052 with SMTP id
 g11-20020a056e021e0b00b00363ad01f052mr1054974ila.24.1709268811574; Thu, 29
 Feb 2024 20:53:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229010130.1380926-1-atishp@rivosinc.com> <20240229010130.1380926-16-atishp@rivosinc.com>
In-Reply-To: <20240229010130.1380926-16-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 1 Mar 2024 10:23:21 +0530
Message-ID: <CAAhSdy3OpFTKh2AZxXiBJi6674yaBRcMPSOXi5o3YRy0pHatuA@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] KVM: riscv: selftests: Add a test for counter overflow
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
> Add a test for verifying overflow interrupt. Currently, it relies on
> overflow support on cycle/instret events. This test works for cycle/
> instret events which support sampling via hpmcounters on the platform.
> There are no ISA extensions to detect if a platform supports that. Thus,
> this test will fail on platform with virtualization but doesn't
> support overflow on these two events.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/riscv/sbi_pmu.c | 126 +++++++++++++++++++-
>  1 file changed, 125 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu.c b/tools/testing/=
selftests/kvm/riscv/sbi_pmu.c
> index 8ea2a6db6610..c0264c636054 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
> @@ -8,6 +8,7 @@
>   * Copyright (c) 2024, Rivos Inc.
>   */
>
> +#include "asm/csr.h"
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -16,6 +17,7 @@
>  #include "kvm_util.h"
>  #include "test_util.h"
>  #include "processor.h"
> +#include "arch_timer.h"
>
>  /* Maximum counters (firmware + hardware)*/
>  #define RISCV_MAX_PMU_COUNTERS 64
> @@ -26,6 +28,11 @@ union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNT=
ERS];
>  static void *snapshot_gva;
>  static vm_paddr_t snapshot_gpa;
>
> +static int pmu_irq =3D IRQ_PMU_OVF;
> +
> +static int vcpu_shared_irq_count;
> +static int counter_in_use;
> +
>  /* Cache the available counters in a bitmask */
>  static unsigned long counter_mask_available;
>
> @@ -69,7 +76,9 @@ unsigned long pmu_csr_read_num(int csr_num)
>  #undef switchcase_csr_read
>  }
>
> -static inline void dummy_func_loop(int iter)
> +static void stop_counter(unsigned long counter, unsigned long stop_flags=
);
> +
> +static inline void dummy_func_loop(uint64_t iter)
>  {
>         int i =3D 0;
>
> @@ -88,6 +97,26 @@ static void guest_illegal_exception_handler(struct ex_=
regs *regs)
>         regs->epc +=3D 4;
>  }
>
> +static void guest_irq_handler(struct ex_regs *regs)
> +{
> +       unsigned int irq_num =3D regs->cause & ~CAUSE_IRQ_FLAG;
> +       struct riscv_pmu_snapshot_data *snapshot_data =3D snapshot_gva;
> +       unsigned long overflown_mask;
> +
> +       /* Stop all counters first to avoid further interrupts */
> +       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0, 1UL << counte=
r_in_use,
> +                 SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT, 0, 0, 0);
> +
> +       csr_clear(CSR_SIP, BIT(pmu_irq));
> +
> +       overflown_mask =3D READ_ONCE(snapshot_data->ctr_overflow_mask);
> +       GUEST_ASSERT(overflown_mask & (1UL << counter_in_use));
> +
> +       /* Validate that we are in the correct irq handler */
> +       GUEST_ASSERT_EQ(irq_num, pmu_irq);
> +       WRITE_ONCE(vcpu_shared_irq_count, vcpu_shared_irq_count+1);
> +}
> +
>  static unsigned long get_counter_index(unsigned long cbase, unsigned lon=
g cmask,
>                                        unsigned long cflags,
>                                        unsigned long event)
> @@ -263,6 +292,32 @@ static void test_pmu_event_snapshot(unsigned long ev=
ent)
>         stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
>  }
>
> +static void test_pmu_event_overflow(unsigned long event)
> +{
> +       unsigned long counter;
> +       unsigned long counter_value_post;
> +       unsigned long counter_init_value =3D ULONG_MAX - 10000;
> +       struct riscv_pmu_snapshot_data *snapshot_data =3D snapshot_gva;
> +
> +       counter =3D get_counter_index(0, counter_mask_available, 0, event=
);
> +       counter_in_use =3D counter;
> +
> +       /* The counter value is updated w.r.t relative index of cbase pas=
sed to start/stop */
> +       WRITE_ONCE(snapshot_data->ctr_values[0], counter_init_value);
> +       start_counter(counter, SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT, 0);
> +       dummy_func_loop(10000);
> +       udelay(msecs_to_usecs(2000));
> +       /* irq handler should have stopped the counter */
> +
> +       counter_value_post =3D READ_ONCE(snapshot_data->ctr_values[counte=
r_in_use]);
> +       /* The counter value after stopping should be less the init value=
 due to overflow */
> +       __GUEST_ASSERT(counter_value_post < counter_init_value,
> +                      "counter_value_post %lx counter_init_value %lx for=
 counter\n",
> +                      counter_value_post, counter_init_value);
> +
> +       stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
> +}
> +
>  static void test_invalid_event(void)
>  {
>         struct sbiret ret;
> @@ -361,6 +416,43 @@ static void test_pmu_events_snaphost(int cpu)
>         GUEST_DONE();
>  }
>
> +static void test_pmu_events_overflow(int cpu)
> +{
> +       long out_val =3D 0;
> +       bool probe;
> +       int num_counters =3D 0;
> +       unsigned long sbi_impl_version;
> +
> +       probe =3D guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
> +       GUEST_ASSERT(probe && out_val =3D=3D 1);
> +
> +       sbi_impl_version =3D get_host_sbi_impl_version();
> +       if (sbi_impl_version >=3D sbi_mk_version(2, 0))
> +               __GUEST_ASSERT(0, "SBI implementation version doesn't sup=
port PMU Snapshot");
> +
> +       snapshot_set_shmem(snapshot_gpa, 0);
> +       csr_set(CSR_IE, BIT(pmu_irq));
> +       local_irq_enable();
> +
> +       /* Get the counter details */
> +       num_counters =3D get_num_counters();
> +       update_counter_info(num_counters);
> +
> +       /*
> +        * Qemu supports overflow for cycle/instruction.
> +        * This test may fail on any platform that do not support overflo=
w for these two events.
> +        */
> +       test_pmu_event_overflow(SBI_PMU_HW_CPU_CYCLES);
> +       GUEST_ASSERT_EQ(vcpu_shared_irq_count, 1);
> +
> +       /* Renable the interrupt again for another event */
> +       csr_set(CSR_IE, BIT(pmu_irq));
> +       test_pmu_event_overflow(SBI_PMU_HW_INSTRUCTIONS);
> +       GUEST_ASSERT_EQ(vcpu_shared_irq_count, 2);
> +
> +       GUEST_DONE();
> +}
> +
>  static void run_vcpu(struct kvm_vcpu *vcpu)
>  {
>         struct ucall uc;
> @@ -449,6 +541,35 @@ static void test_vm_events_snapshot_test(void *guest=
_code)
>         test_vm_destroy(vm);
>  }
>
> +static void test_vm_events_overflow(void *guest_code)
> +{
> +       struct kvm_vm *vm =3D NULL;
> +       struct kvm_vcpu *vcpu =3D NULL;
> +
> +       vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +       __TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(KVM_RISCV_S=
BI_EXT_PMU)),
> +                                  "SBI PMU not available, skipping test"=
);
> +
> +       __TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_I=
SA_EXT_SSCOFPMF)),
> +                                  "Sscofpmf is not available, skipping o=
verflow test");
> +
> +
> +       test_vm_setup_snapshot_mem(vm, vcpu);
> +       vm_init_vector_tables(vm);
> +       vm_install_interrupt_handler(vm, guest_irq_handler);
> +
> +       vcpu_init_vector_tables(vcpu);
> +       /* Initialize guest timer frequency. */
> +       vcpu_get_reg(vcpu, RISCV_TIMER_REG(frequency), &timer_freq);
> +       sync_global_to_guest(vm, timer_freq);
> +
> +       vcpu_args_set(vcpu, 1, 0);
> +
> +       run_vcpu(vcpu);
> +
> +       test_vm_destroy(vm);
> +}
> +
>  int main(void)
>  {
>         test_vm_basic_test(test_pmu_basic_sanity);
> @@ -460,5 +581,8 @@ int main(void)
>         test_vm_events_snapshot_test(test_pmu_events_snaphost);
>         pr_info("SBI PMU event verification with snapshot test : PASS\n")=
;
>
> +       test_vm_events_overflow(test_pmu_events_overflow);
> +       pr_info("SBI PMU event verification with overflow test : PASS\n")=
;
> +
>         return 0;
>  }
> --
> 2.34.1
>

