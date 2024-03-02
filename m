Return-Path: <linux-kselftest+bounces-5775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7911786EDBE
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 02:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308822868FC
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 01:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B500363CB;
	Sat,  2 Mar 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="akoefP/A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738207489
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Mar 2024 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341309; cv=none; b=BWBIuiR5J6l+AO4pSmY+XGYuC3Rq0Q1l3f6sjmyMJXDO78VlCYTvGDjzImyKFqvSWCP3eFixu50P/oleOKmgddopMKkLMirDgN1z4aGbVm4MgqI+tgCzRMLkzrNIsD0k97Ot9BPjRhaM/n9GJrVJHs+CYHJ5nX4Q0mxDCPZiSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341309; c=relaxed/simple;
	bh=GwPcVVLbj2MMAd6Z1gdTCPL3uoeB5dkTqJWECZ59g1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YV7OLvwuDuWTmcgMBuCCEpdWC1m8G0fDmUNuz5mNG09yZMxdwPUwN783rtR99Jgmr3PL3JwRujW1kxZYBJQa6QZZeYsBeCa/yTg2CC8FsGFioFc4f3A48coaoDXmyPN80l6j+gL0rwRPUIZdz+iabH38p+LYVd+veCi5C8u3k2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=akoefP/A; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso2325680e87.1
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Mar 2024 17:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709341305; x=1709946105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNsNUmNsB3DHgU+D56n3/8yttfwCGWOdve4uEYNjPrg=;
        b=akoefP/AXUptl1QQVi2T6ozZSdBknzKrt97GkG76aXtJTvyDpdadC/7P3WAImCeQuT
         3GXayDa6uTusZ/DDZ4uzgW9KDKOO8KMkCgcIPsLgvZp3cZiBMtEUUR8RO/t7zUF59okY
         v7hPe1BGaqvUuqyrQfjEVCfFYU6CQw556gjNffMrCXMxaL8cbAUIIxI0rpByeHeUa8CB
         NGg3DToHWglBEhNcOyYtbePvYBpfxP2sz0ChNigvzRhKmF6MAe+MsQl49Huk4T8VhXsd
         XksFBTZWubAi21ZVyrueWY3+bKaxziJlHMnhb66TGtuY2bmjZ2lGr0p+KsNvAf0AJVr+
         Kgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341305; x=1709946105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNsNUmNsB3DHgU+D56n3/8yttfwCGWOdve4uEYNjPrg=;
        b=uHrm05XvTFAoUa7jwuB6wRvLEetN9hSvqePoCBz+N+Kamb3ljklbydRt46Fz2CDhjD
         pbz3hepETzUskIBBiQnG3rcM/hDxsP+uuq8tYVjbUoiRgZ5LewUs9tASEIokA2LTcKoS
         6Q9FX7BuBLpavG+CvPRM3FoC87uNPmau+77iFR327cAJcSHn4AcwFd8IzddH196Z4nAf
         lx2aHnWnHeOV9DnuQ5VeF8HsNiL6ArQwZQByxLI9uYCZ6PyQH6SklLvNQvCGIaoV7gNn
         ykewcfiBkWxa2LKhkqe6RQns4aBNCrQuoc6AJw4h/mO3gybHDiAaiM+tfp0Ljm5HNzPA
         5/1w==
X-Forwarded-Encrypted: i=1; AJvYcCUDtb1HhmEGGILhykHENK+UnqlT9HK8K6JdmxOrJCDtpYXoeIER/YOJy69JIeQUDc1eAUW44PU4iVDhz1n37JWm5sXee/R5NFYtcwTO1ANf
X-Gm-Message-State: AOJu0YyZVQOdYQAT1yZeXO/a4dvN713yCdpOa9hABqxqz8wiLszvPlGW
	W3qAxwgNOseyNIMTSmNZklN4lf3fFKUCeg4nhUWEUMyAlsPDQXZ/rpwC8epGBtITGWaBAPXaIlf
	njXyiEwu6hrCizFc5Jk0zOPYQOCEtO6fSd3RFQA==
X-Google-Smtp-Source: AGHT+IFkMZmpJbAJcB7zaT8/GZd7++yGoS+DQetYD+qcioQPLE9PKZGGc/uSwHR7RgEn2Rjbj7sEJfD+WcQ0nZ9fPoA=
X-Received: by 2002:a05:6512:2214:b0:512:f7e0:47ce with SMTP id
 h20-20020a056512221400b00512f7e047cemr2845402lfu.44.1709341305475; Fri, 01
 Mar 2024 17:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229010130.1380926-1-atishp@rivosinc.com> <20240229010130.1380926-14-atishp@rivosinc.com>
 <CAAhSdy3HYzc1fPBg88-7cYogT5y1Y9+4-syx4-7scxZsbmBeuQ@mail.gmail.com>
In-Reply-To: <CAAhSdy3HYzc1fPBg88-7cYogT5y1Y9+4-syx4-7scxZsbmBeuQ@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 1 Mar 2024 17:01:34 -0800
Message-ID: <CAHBxVyH_91dgZcSQDJ8E1=Fre-+JZiGz2QOVrJqDay7jfdD80g@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] KVM: riscv: selftests: Add SBI PMU selftest
To: Anup Patel <anup@brainfault.org>
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

On Thu, Feb 29, 2024 at 8:47=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Thu, Feb 29, 2024 at 6:32=E2=80=AFAM Atish Patra <atishp@rivosinc.com>=
 wrote:
> >
> > This test implements basic sanity test and cycle/instret event
> > counting tests.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
>
> I feel the test should have been called sbi_pmu_test but no need to
> revise this series. I will take care of it at the time of merging.
>

Sure. I am going to send v5 anyway. I have changed the name there.

> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Regards,
> Anup
>
> > ---
> >  tools/testing/selftests/kvm/Makefile        |   1 +
> >  tools/testing/selftests/kvm/riscv/sbi_pmu.c | 340 ++++++++++++++++++++
> >  2 files changed, 341 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/riscv/sbi_pmu.c
> >
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selft=
ests/kvm/Makefile
> > index 426f85798aea..b2dce6843b9e 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -195,6 +195,7 @@ TEST_GEN_PROGS_riscv +=3D kvm_create_max_vcpus
> >  TEST_GEN_PROGS_riscv +=3D kvm_page_table_test
> >  TEST_GEN_PROGS_riscv +=3D set_memory_region_test
> >  TEST_GEN_PROGS_riscv +=3D steal_time
> > +TEST_GEN_PROGS_riscv +=3D riscv/sbi_pmu
> >
> >  SPLIT_TESTS +=3D arch_timer
> >  SPLIT_TESTS +=3D get-reg-list
> > diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu.c b/tools/testin=
g/selftests/kvm/riscv/sbi_pmu.c
> > new file mode 100644
> > index 000000000000..fc1fc5eea99e
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
> > @@ -0,0 +1,340 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * arch_timer.c - Tests the riscv64 sstc timer IRQ functionality
> > + *
> > + * The test validates the sstc timer IRQs using vstimecmp registers.
> > + * It's ported from the aarch64 arch_timer test.
> > + *
> > + * Copyright (c) 2024, Rivos Inc.
> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <sys/types.h>
> > +#include "kvm_util.h"
> > +#include "test_util.h"
> > +#include "processor.h"
> > +
> > +/* Maximum counters (firmware + hardware)*/
> > +#define RISCV_MAX_PMU_COUNTERS 64
> > +union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
> > +
> > +/* Cache the available counters in a bitmask */
> > +static unsigned long counter_mask_available;
> > +
> > +unsigned long pmu_csr_read_num(int csr_num)
> > +{
> > +#define switchcase_csr_read(__csr_num, __val)          {\
> > +       case __csr_num:                                 \
> > +               __val =3D csr_read(__csr_num);            \
> > +               break; }
> > +#define switchcase_csr_read_2(__csr_num, __val)                {\
> > +       switchcase_csr_read(__csr_num + 0, __val)        \
> > +       switchcase_csr_read(__csr_num + 1, __val)}
> > +#define switchcase_csr_read_4(__csr_num, __val)                {\
> > +       switchcase_csr_read_2(__csr_num + 0, __val)      \
> > +       switchcase_csr_read_2(__csr_num + 2, __val)}
> > +#define switchcase_csr_read_8(__csr_num, __val)                {\
> > +       switchcase_csr_read_4(__csr_num + 0, __val)      \
> > +       switchcase_csr_read_4(__csr_num + 4, __val)}
> > +#define switchcase_csr_read_16(__csr_num, __val)       {\
> > +       switchcase_csr_read_8(__csr_num + 0, __val)      \
> > +       switchcase_csr_read_8(__csr_num + 8, __val)}
> > +#define switchcase_csr_read_32(__csr_num, __val)       {\
> > +       switchcase_csr_read_16(__csr_num + 0, __val)     \
> > +       switchcase_csr_read_16(__csr_num + 16, __val)}
> > +
> > +       unsigned long ret =3D 0;
> > +
> > +       switch (csr_num) {
> > +       switchcase_csr_read_32(CSR_CYCLE, ret)
> > +       switchcase_csr_read_32(CSR_CYCLEH, ret)
> > +       default :
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +#undef switchcase_csr_read_32
> > +#undef switchcase_csr_read_16
> > +#undef switchcase_csr_read_8
> > +#undef switchcase_csr_read_4
> > +#undef switchcase_csr_read_2
> > +#undef switchcase_csr_read
> > +}
> > +
> > +static inline void dummy_func_loop(int iter)
> > +{
> > +       int i =3D 0;
> > +
> > +       while (i < iter) {
> > +               asm volatile("nop");
> > +               i++;
> > +       }
> > +}
> > +
> > +static void guest_illegal_exception_handler(struct ex_regs *regs)
> > +{
> > +       __GUEST_ASSERT(regs->cause =3D=3D EXC_INST_ILLEGAL,
> > +                      "Unexpected exception handler %lx\n", regs->caus=
e);
> > +
> > +       /* skip the trapping instruction */
> > +       regs->epc +=3D 4;
> > +}
> > +
> > +static unsigned long get_counter_index(unsigned long cbase, unsigned l=
ong cmask,
> > +                                      unsigned long cflags,
> > +                                      unsigned long event)
> > +{
> > +       struct sbiret ret;
> > +
> > +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, c=
base, cmask,
> > +                       cflags, event, 0, 0);
> > +       __GUEST_ASSERT(ret.error =3D=3D 0, "config matching failed %ld\=
n", ret.error);
> > +       GUEST_ASSERT((ret.value < RISCV_MAX_PMU_COUNTERS) &&
> > +                   ((1UL << ret.value) & counter_mask_available));
> > +
> > +       return ret.value;
> > +}
> > +
> > +static unsigned long get_num_counters(void)
> > +{
> > +       struct sbiret ret;
> > +
> > +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_NUM_COUNTERS, 0, 0, =
0, 0, 0, 0);
> > +
> > +       __GUEST_ASSERT(ret.error =3D=3D 0, "Unable to retrieve number o=
f counters from SBI PMU");
> > +
> > +       __GUEST_ASSERT(ret.value < RISCV_MAX_PMU_COUNTERS,
> > +                      "Invalid number of counters %ld\n", ret.value);
> > +
> > +       return ret.value;
> > +}
> > +
> > +static void update_counter_info(int num_counters)
> > +{
> > +       int i =3D 0;
> > +       struct sbiret ret;
> > +
> > +       for (i =3D 0; i < num_counters; i++) {
> > +               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_=
INFO, i, 0, 0, 0, 0, 0);
> > +
> > +               /* There can be gaps in logical counter indicies*/
> > +               if (!ret.error)
> > +                       GUEST_ASSERT_NE(ret.value, 0);
> > +
> > +               ctrinfo_arr[i].value =3D ret.value;
> > +               counter_mask_available |=3D BIT(i);
> > +       }
> > +
> > +       GUEST_ASSERT(counter_mask_available > 0);
> > +}
> > +
> > +static unsigned long read_counter(int idx, union sbi_pmu_ctr_info ctri=
nfo)
> > +{
> > +       unsigned long counter_val =3D 0;
> > +       struct sbiret ret;
> > +
> > +       __GUEST_ASSERT(ctrinfo.type < 2, "Invalid counter type %d", ctr=
info.type);
> > +
> > +       if (ctrinfo.type =3D=3D SBI_PMU_CTR_TYPE_HW) {
> > +               counter_val =3D pmu_csr_read_num(ctrinfo.csr);
> > +       } else if (ctrinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW) {
> > +               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_R=
EAD, idx, 0, 0, 0, 0, 0);
> > +               GUEST_ASSERT(ret.error =3D=3D 0);
> > +               counter_val =3D ret.value;
> > +       }
> > +
> > +       return counter_val;
> > +}
> > +
> > +static void start_counter(unsigned long counter, unsigned long start_f=
lags,
> > +                         unsigned long ival)
> > +{
> > +       struct sbiret ret;
> > +
> > +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, count=
er, 1, start_flags,
> > +                       ival, 0, 0);
> > +       __GUEST_ASSERT(ret.error =3D=3D 0, "Unable to start counter %ld=
\n", counter);
> > +}
> > +
> > +static void stop_counter(unsigned long counter, unsigned long stop_fla=
gs)
> > +{
> > +       struct sbiret ret;
> > +
> > +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, counte=
r, 1, stop_flags,
> > +                       0, 0, 0);
> > +       if (stop_flags & SBI_PMU_STOP_FLAG_RESET)
> > +               __GUEST_ASSERT(ret.error =3D=3D SBI_ERR_ALREADY_STOPPED=
,
> > +                              "Unable to stop counter %ld\n", counter)=
;
> > +       else
> > +               __GUEST_ASSERT(ret.error =3D=3D 0, "Unable to stop coun=
ter %ld error %ld\n",
> > +                              counter, ret.error);
> > +}
> > +
> > +static void test_pmu_event(unsigned long event)
> > +{
> > +       unsigned long counter;
> > +       unsigned long counter_value_pre, counter_value_post;
> > +       unsigned long counter_init_value =3D 100;
> > +
> > +       counter =3D get_counter_index(0, counter_mask_available, 0, eve=
nt);
> > +       counter_value_pre =3D read_counter(counter, ctrinfo_arr[counter=
]);
> > +
> > +       /* Do not set the initial value */
> > +       start_counter(counter, 0, counter_init_value);
> > +       dummy_func_loop(10000);
> > +
> > +       stop_counter(counter, 0);
> > +
> > +       counter_value_post =3D read_counter(counter, ctrinfo_arr[counte=
r]);
> > +       __GUEST_ASSERT(counter_value_post > counter_value_pre,
> > +                      "counter_value_post %lx counter_value_pre %lx\n"=
,
> > +                      counter_value_post, counter_value_pre);
> > +
> > +       /* Now set the initial value and compare */
> > +       start_counter(counter, SBI_PMU_START_FLAG_SET_INIT_VALUE, count=
er_init_value);
> > +       dummy_func_loop(10000);
> > +
> > +       stop_counter(counter, 0);
> > +
> > +       counter_value_post =3D read_counter(counter, ctrinfo_arr[counte=
r]);
> > +       __GUEST_ASSERT(counter_value_post > counter_init_value,
> > +                      "counter_value_post %lx counter_init_value %lx\n=
",
> > +                      counter_value_post, counter_init_value);
> > +
> > +       stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
> > +}
> > +
> > +static void test_invalid_event(void)
> > +{
> > +       struct sbiret ret;
> > +       unsigned long event =3D 0x1234; /* A random event */
> > +
> > +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, 0=
,
> > +                       counter_mask_available, 0, event, 0, 0);
> > +       GUEST_ASSERT_EQ(ret.error, SBI_ERR_NOT_SUPPORTED);
> > +}
> > +
> > +static void test_pmu_events(int cpu)
> > +{
> > +       int num_counters =3D 0;
> > +
> > +       /* Get the counter details */
> > +       num_counters =3D get_num_counters();
> > +       update_counter_info(num_counters);
> > +
> > +       /* Sanity testing for any random invalid event */
> > +       test_invalid_event();
> > +
> > +       /* Only these two events are guranteed to be present */
> > +       test_pmu_event(SBI_PMU_HW_CPU_CYCLES);
> > +       test_pmu_event(SBI_PMU_HW_INSTRUCTIONS);
> > +
> > +       GUEST_DONE();
> > +}
> > +
> > +static void test_pmu_basic_sanity(int cpu)
> > +{
> > +       long out_val =3D 0;
> > +       bool probe;
> > +       struct sbiret ret;
> > +       int num_counters =3D 0, i;
> > +       unsigned long counter_val =3D -1;
> > +       union sbi_pmu_ctr_info ctrinfo;
> > +
> > +       probe =3D guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
> > +       GUEST_ASSERT(probe && out_val =3D=3D 1);
> > +
> > +       num_counters =3D get_num_counters();
> > +
> > +       for (i =3D 0; i < num_counters; i++) {
> > +               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_=
INFO, i,
> > +                               0, 0, 0, 0, 0);
> > +
> > +               /* There can be gaps in logical counter indicies*/
> > +               if (!ret.error)
> > +                       GUEST_ASSERT_NE(ret.value, 0);
> > +               else
> > +                       continue;
> > +
> > +               ctrinfo.value =3D ret.value;
> > +
> > +               /* Accesibility check of hardware and read capability o=
f firmware counters */
> > +               counter_val =3D read_counter(i, ctrinfo);
> > +               /* The spec doesn't mandate any initial value. Verify i=
f a sane value */
> > +               GUEST_ASSERT_NE(counter_val, -1);
> > +       }
> > +
> > +       GUEST_DONE();
> > +}
> > +
> > +static void run_vcpu(struct kvm_vcpu *vcpu)
> > +{
> > +       struct ucall uc;
> > +
> > +       vcpu_run(vcpu);
> > +       switch (get_ucall(vcpu, &uc)) {
> > +       case UCALL_ABORT:
> > +               REPORT_GUEST_ASSERT(uc);
> > +               break;
> > +       case UCALL_DONE:
> > +       case UCALL_SYNC:
> > +               break;
> > +       default:
> > +               TEST_FAIL("Unknown ucall %lu", uc.cmd);
> > +               break;
> > +       }
> > +}
> > +
> > +void test_vm_destroy(struct kvm_vm *vm)
> > +{
> > +       memset(ctrinfo_arr, 0, sizeof(union sbi_pmu_ctr_info) * RISCV_M=
AX_PMU_COUNTERS);
> > +       counter_mask_available =3D 0;
> > +       kvm_vm_free(vm);
> > +}
> > +
> > +static void test_vm_basic_test(void *guest_code)
> > +{
> > +       struct kvm_vm *vm;
> > +       struct kvm_vcpu *vcpu;
> > +
> > +       vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> > +       __TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV=
_SBI_EXT_PMU)),
> > +                                  "SBI PMU not available, skipping tes=
t");
> > +       vm_init_vector_tables(vm);
> > +       /* Illegal instruction handler is required to verify read acces=
s without configuration */
> > +       vm_install_exception_handler(vm, EXC_INST_ILLEGAL, guest_illega=
l_exception_handler);
> > +
> > +       vcpu_init_vector_tables(vcpu);
> > +       vcpu_args_set(vcpu, 1, 0);
> > +       run_vcpu(vcpu);
> > +
> > +       test_vm_destroy(vm);
> > +}
> > +
> > +static void test_vm_events_test(void *guest_code)
> > +{
> > +       struct kvm_vm *vm =3D NULL;
> > +       struct kvm_vcpu *vcpu =3D NULL;
> > +
> > +       vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> > +       __TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV=
_SBI_EXT_PMU)),
> > +                                  "SBI PMU not available, skipping tes=
t");
> > +       vcpu_args_set(vcpu, 1, 0);
> > +       run_vcpu(vcpu);
> > +
> > +       test_vm_destroy(vm);
> > +}
> > +
> > +int main(void)
> > +{
> > +       test_vm_basic_test(test_pmu_basic_sanity);
> > +       pr_info("SBI PMU basic test : PASS\n");
> > +
> > +       test_vm_events_test(test_pmu_events);
> > +       pr_info("SBI PMU event verification test : PASS\n");
> > +
> > +       return 0;
> > +}
> > --
> > 2.34.1
> >

