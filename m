Return-Path: <linux-kselftest+bounces-45687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B516C5FFB4
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 05:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE4EB357E43
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 04:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4303186284;
	Sat, 15 Nov 2025 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrvJiNUs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5863B9
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763179856; cv=none; b=sXcsSWAP7CI7xb2fsy8vOBoUab9T7VPXKqp30j3poKCDdNqwLWP9DDwqRoSimL6hoazo3wJqFWs6/+BPH8MnWV+ctVOwRzgTAGpve+nMDv1YH0Xs1NZ/rm+YiI/wyE/q9n5e8Vj6Q6Ef0X2bon4eujdXTSsYgkydEyEP9+gOrwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763179856; c=relaxed/simple;
	bh=c7teKy4ItZgyp3xlcjtkDbDVM0QGblBeLWyazUqKWFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2G0DeJ5N254MAb/wO5q65TW+wK+iEGplfAS0R/ROUW931sFaGHaRqLKKIYrEanOoZJ3uPiFSL2wSs+kqFVhP/E+w/9dmkcDnebQMoOmLaI4AbSwjfmQgvw0yXngQdvPEkC+HgVmCtNuYsg/wRAXCKolsU9YqGELQl578k8pzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrvJiNUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C025C19425
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 04:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763179856;
	bh=c7teKy4ItZgyp3xlcjtkDbDVM0QGblBeLWyazUqKWFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FrvJiNUslYpFoo3W32AN14HpG5TypwMDCwIry/sJj313bGQ6kG6KcQnvNwDYbK9oX
	 Q2rbIuWhRfr5bOZc9HRtg8kwoVVzoUxvaypfZ84fxvKeVbkUSUIlF+rbQkzVxiWuuT
	 q/h0u4Ehs9E/eHxbqiuwQceQjvxIwZww7Q8NqWi+Tj+ZVsEV3MtxHAYGSTShwSHRml
	 IRdhCV3uUaXAxTwRr7IS3k8A0gsXJjcmuYdS+1lsRIILZ7APtvQbLj/mWJ7eNMw8Xz
	 0hsosv3eNNjtrhNaU8Vbrehf4g8j78OBKIIUBWrAWitgrf7fDkChbrRdX8V2MSOiGr
	 yJiGnZeiiA1dw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so4399222a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 20:10:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXElZ1hQWhb3N/u3MeCmquD+jow14FBgJ/AIareMpkpOa0huFj4ssDBCluHcDRcN8FJ+CNAlOldcgtfeDWiHTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywov++8uO1e7JU856WMNbIMgp17p4yOH1zL1OWhqVV1EOPdFL04
	oma7WEsVNccsBDNAUPiGaJYLyIT6QKoqv7BBoc+QJH6Gx3VrdjJd2fhRov3Y5y2KyIjXpw9DUN0
	kYnzgDAguMNi2vX7B/YOoog6sPC12GRA=
X-Google-Smtp-Source: AGHT+IG0XKHIXfZdA9rJ7CjF/zMBjgNVny3+MRhH7TEbhoDkyNXLkt1iqlvGMujQLRoKFiNZggkH746hb4BKjrkUjjg=
X-Received: by 2002:a05:6402:13cd:b0:640:a26e:3d86 with SMTP id
 4fb4d7f45d1cf-64350deef65mr4600478a12.1.1763179854945; Fri, 14 Nov 2025
 20:10:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104113700.1561752-1-maobibo@loongson.cn> <20251104113700.1561752-5-maobibo@loongson.cn>
In-Reply-To: <20251104113700.1561752-5-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 15 Nov 2025 12:10:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7S5AQXb35iEL3at3nmXx68cKoM9s1bGUvJE-WCeb6Ufg@mail.gmail.com>
X-Gm-Features: AWmQ_bmV5vLhAgM4oaNjM3999HpiR-0a6Eu5NK8a7013QNIrGY3qTGN7e_1Gzu8
Message-ID: <CAAhV-H7S5AQXb35iEL3at3nmXx68cKoM9s1bGUvJE-WCeb6Ufg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] KVM: LoongArch: selftests: Add timer test case
 with one-shot mode
To: Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Tue, Nov 4, 2025 at 7:37=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> Add timer test case based on common arch_timer code, one-shot mode
> is tested with timer interrupt.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      | 10 +-
>  .../kvm/include/loongarch/arch_timer.h        | 79 +++++++++++++++
>  .../kvm/include/loongarch/processor.h         | 10 ++
>  .../selftests/kvm/lib/loongarch/processor.c   |  4 +-
>  .../selftests/kvm/loongarch/arch_timer.c      | 98 +++++++++++++++++++
>  5 files changed, 196 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/loongarch/arch_ti=
mer.h
>  create mode 100644 tools/testing/selftests/kvm/loongarch/arch_timer.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index 148d427ff24b..662adf8f309b 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -183,6 +183,8 @@ TEST_GEN_PROGS_arm64 +=3D memslot_perf_test
>  TEST_GEN_PROGS_arm64 +=3D mmu_stress_test
>  TEST_GEN_PROGS_arm64 +=3D rseq_test
>  TEST_GEN_PROGS_arm64 +=3D steal_time
> +SPLIT_TESTS_arm64    +=3D arch_timer
> +SPLIT_TESTS_arm64    +=3D get-reg-list
>
>  TEST_GEN_PROGS_s390 =3D $(TEST_GEN_PROGS_COMMON)
>  TEST_GEN_PROGS_s390 +=3D s390/memop
> @@ -209,6 +211,8 @@ TEST_GEN_PROGS_riscv +=3D memslot_perf_test
>  TEST_GEN_PROGS_riscv +=3D mmu_stress_test
>  TEST_GEN_PROGS_riscv +=3D rseq_test
>  TEST_GEN_PROGS_riscv +=3D steal_time
> +SPLIT_TESTS_riscv    +=3D arch_timer
> +SPLIT_TESTS_riscv    +=3D get-reg-list
>
>  TEST_GEN_PROGS_loongarch +=3D coalesced_io_test
>  TEST_GEN_PROGS_loongarch +=3D demand_paging_test
> @@ -222,10 +226,10 @@ TEST_GEN_PROGS_loongarch +=3D kvm_page_table_test
>  TEST_GEN_PROGS_loongarch +=3D memslot_modification_stress_test
>  TEST_GEN_PROGS_loongarch +=3D memslot_perf_test
>  TEST_GEN_PROGS_loongarch +=3D set_memory_region_test
> +TEST_GEN_PROGS_loongarch +=3D arch_timer
These tests should be in alpha-betical order.

Huacai

> +SPLIT_TESTS_loongarch    =3D arch_timer
>
> -SPLIT_TESTS +=3D arch_timer
> -SPLIT_TESTS +=3D get-reg-list
> -
> +SPLIT_TESTS +=3D $(SPLIT_TESTS_$(ARCH))
>  TEST_PROGS +=3D $(TEST_PROGS_$(ARCH))
>  TEST_GEN_PROGS +=3D $(TEST_GEN_PROGS_$(ARCH))
>  TEST_GEN_PROGS_EXTENDED +=3D $(TEST_GEN_PROGS_EXTENDED_$(ARCH))
> diff --git a/tools/testing/selftests/kvm/include/loongarch/arch_timer.h b=
/tools/testing/selftests/kvm/include/loongarch/arch_timer.h
> new file mode 100644
> index 000000000000..94b1cba2744d
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/loongarch/arch_timer.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * LoongArch Constant Timer specific interface
> + */
> +#ifndef SELFTEST_KVM_ARCH_TIMER_H
> +#define SELFTEST_KVM_ARCH_TIMER_H
> +
> +#include "processor.h"
> +/* LoongArch timer frequency is constant 100MHZ */
> +#define        TIMER_FREQ              (100UL << 20)
> +#define msec_to_cycles(msec)    (TIMER_FREQ * (unsigned long)(msec) / 10=
00)
> +#define usec_to_cycles(usec)   (TIMER_FREQ * (unsigned long)(usec) / 100=
0000)
> +#define cycles_to_usec(cycles) ((unsigned long)(cycles) * 1000000 / TIME=
R_FREQ)
> +
> +static inline unsigned long timer_get_cycles(void)
> +{
> +       unsigned long val =3D 0;
> +
> +       __asm__ __volatile__(
> +               "rdtime.d %0, $zero\n\t"
> +               : "=3Dr"(val)
> +               :
> +       );
> +
> +       return val;
> +}
> +
> +static inline void timer_set_next_cmp_ms(unsigned int msec, bool period)
> +{
> +       unsigned long val;
> +
> +       val =3D msec_to_cycles(msec) & CSR_TCFG_VAL;
> +       val |=3D CSR_TCFG_EN;
> +       if (period)
> +               val |=3D CSR_TCFG_PERIOD;
> +       csr_write(val, LOONGARCH_CSR_TCFG);
> +}
> +
> +static inline unsigned long timer_get_val(void)
> +{
> +       return csr_read(LOONGARCH_CSR_TVAL);
> +}
> +
> +static inline unsigned long timer_get_cfg(void)
> +{
> +       return csr_read(LOONGARCH_CSR_TCFG);
> +}
> +
> +static inline void timer_irq_enable(void)
> +{
> +       unsigned long val;
> +
> +       val =3D csr_read(LOONGARCH_CSR_ECFG);
> +       val |=3D ECFGF_TIMER;
> +       csr_write(val, LOONGARCH_CSR_ECFG);
> +}
> +
> +static inline void timer_irq_disable(void)
> +{
> +       unsigned long val;
> +
> +       val =3D csr_read(LOONGARCH_CSR_ECFG);
> +       val &=3D ~ECFGF_TIMER;
> +       csr_write(val, LOONGARCH_CSR_ECFG);
> +}
> +
> +static inline void __delay(uint64_t cycles)
> +{
> +       uint64_t start =3D timer_get_cycles();
> +
> +       while ((timer_get_cycles() - start) < cycles)
> +               cpu_relax();
> +}
> +
> +static inline void udelay(unsigned long usec)
> +{
> +       __delay(usec_to_cycles(usec));
> +}
> +#endif /* SELFTEST_KVM_ARCH_TIMER_H */
> diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/=
tools/testing/selftests/kvm/include/loongarch/processor.h
> index b027f8f4dac7..61f6e215046b 100644
> --- a/tools/testing/selftests/kvm/include/loongarch/processor.h
> +++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
> @@ -83,6 +83,8 @@
>  #define LOONGARCH_CSR_PRMD             0x1
>  #define LOONGARCH_CSR_EUEN             0x2
>  #define LOONGARCH_CSR_ECFG             0x4
> +#define  ECFGB_TIMER                   11
> +#define  ECFGF_TIMER                   (BIT_ULL(ECFGB_TIMER))
>  #define LOONGARCH_CSR_ESTAT            0x5  /* Exception status */
>  #define  CSR_ESTAT_EXC_SHIFT           16
>  #define  CSR_ESTAT_EXC_WIDTH           6
> @@ -111,6 +113,14 @@
>  #define LOONGARCH_CSR_KS1              0x31
>  #define LOONGARCH_CSR_TMID             0x40
>  #define LOONGARCH_CSR_TCFG             0x41
> +#define  CSR_TCFG_VAL                  (BIT_ULL(48) - BIT_ULL(2))
> +#define  CSR_TCFG_PERIOD_SHIFT         1
> +#define  CSR_TCFG_PERIOD               (0x1UL << CSR_TCFG_PERIOD_SHIFT)
> +#define  CSR_TCFG_EN                   (0x1UL)
> +#define LOONGARCH_CSR_TVAL             0x42
> +#define LOONGARCH_CSR_TINTCLR          0x44 /* Timer interrupt clear */
> +#define  CSR_TINTCLR_TI_SHIFT          0
> +#define  CSR_TINTCLR_TI                        (1 << CSR_TINTCLR_TI_SHIF=
T)
>  /* TLB refill exception entry */
>  #define LOONGARCH_CSR_TLBRENTRY                0x88
>  #define LOONGARCH_CSR_TLBRSAVE         0x8b
> diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tool=
s/testing/selftests/kvm/lib/loongarch/processor.c
> index 20ba476ccb72..436990258068 100644
> --- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
> +++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
> @@ -271,8 +271,8 @@ static void loongarch_vcpu_setup(struct kvm_vcpu *vcp=
u)
>                 TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
>         }
>
> -       /* user mode and page enable mode */
> -       val =3D PLV_USER | CSR_CRMD_PG;
> +       /* kernel mode and page enable mode */
> +       val =3D PLV_KERN | CSR_CRMD_PG;
>         loongarch_set_csr(vcpu, LOONGARCH_CSR_CRMD, val);
>         loongarch_set_csr(vcpu, LOONGARCH_CSR_PRMD, val);
>         loongarch_set_csr(vcpu, LOONGARCH_CSR_EUEN, 1);
> diff --git a/tools/testing/selftests/kvm/loongarch/arch_timer.c b/tools/t=
esting/selftests/kvm/loongarch/arch_timer.c
> new file mode 100644
> index 000000000000..2a2cebcf3885
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/loongarch/arch_timer.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *
> + * The test validates one-shot constant timer IRQ using CSR_TCFG and
> + * CSR_TVAL registers.
> + */
> +#include "arch_timer.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "timer_test.h"
> +#include "ucall_common.h"
> +
> +static void guest_irq_handler(struct ex_regs *regs)
> +{
> +       uint64_t xcnt, val, cfg, xcnt_diff_us;
> +       unsigned int intid;
> +       uint32_t cpu =3D guest_get_vcpuid();
> +       struct test_vcpu_shared_data *shared_data =3D &vcpu_shared_data[c=
pu];
> +
> +       intid =3D !!(regs->estat & BIT(INT_TI));
> +
> +       /* Make sure we are dealing with the correct timer IRQ */
> +       GUEST_ASSERT_EQ(intid, 1);
> +
> +       cfg =3D timer_get_cfg();
> +
> +       /*
> +        * On physical machine, value of LOONGARCH_CSR_TVAL is BIT_ULL(48=
) - 1
> +        * On virtual machine, its value counts down from BIT_ULL(48) - 1
> +        */
> +       val =3D timer_get_val();
> +       xcnt =3D timer_get_cycles();
> +       xcnt_diff_us =3D cycles_to_usec(xcnt - shared_data->xcnt);
> +
> +       /* Basic 'timer condition met' check */
> +       __GUEST_ASSERT(val > cfg,
> +                       "val =3D 0x%lx, cfg =3D 0x%lx, xcnt_diff_us =3D 0=
x%lx",
> +                       val, cfg, xcnt_diff_us);
> +
> +       csr_write(CSR_TINTCLR_TI, LOONGARCH_CSR_TINTCLR);
> +       WRITE_ONCE(shared_data->nr_iter, shared_data->nr_iter + 1);
> +}
> +
> +static void guest_test_oneshot_timer(uint32_t cpu)
> +{
> +       uint32_t irq_iter, config_iter;
> +       uint64_t us;
> +       struct test_vcpu_shared_data *shared_data =3D &vcpu_shared_data[c=
pu];
> +
> +       shared_data->nr_iter =3D 0;
> +       shared_data->guest_stage =3D 0;
> +       us =3D msecs_to_usecs(test_args.timer_period_ms) + test_args.time=
r_err_margin_us;
> +       for (config_iter =3D 0; config_iter < test_args.nr_iter; config_i=
ter++) {
> +               shared_data->xcnt =3D timer_get_cycles();
> +
> +               /* Setup the next interrupt */
> +               timer_set_next_cmp_ms(test_args.timer_period_ms, false);
> +               /* Setup a timeout for the interrupt to arrive */
> +               udelay(us);
> +
> +               irq_iter =3D READ_ONCE(shared_data->nr_iter);
> +               __GUEST_ASSERT(config_iter + 1 =3D=3D irq_iter,
> +                               "config_iter + 1 =3D 0x%x, irq_iter =3D 0=
x%x.\n"
> +                               "  Guest timer interrupt was not triggere=
d within the specified\n"
> +                               "  interval, try to increase the error ma=
rgin by [-e] option.\n",
> +                               config_iter + 1, irq_iter);
> +       }
> +}
> +
> +static void guest_code(void)
> +{
> +       uint32_t cpu =3D guest_get_vcpuid();
> +
> +       timer_irq_enable();
> +       local_irq_enable();
> +       guest_test_oneshot_timer(cpu);
> +
> +       GUEST_DONE();
> +}
> +
> +struct kvm_vm *test_vm_create(void)
> +{
> +       struct kvm_vm *vm;
> +       int nr_vcpus =3D test_args.nr_vcpus;
> +
> +       vm =3D vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> +       vm_init_descriptor_tables(vm);
> +       vm_install_exception_handler(vm, EXCCODE_INT, guest_irq_handler);
> +
> +       /* Make all the test's cmdline args visible to the guest */
> +       sync_global_to_guest(vm, test_args);
> +       return vm;
> +}
> +
> +void test_vm_cleanup(struct kvm_vm *vm)
> +{
> +       kvm_vm_free(vm);
> +}
> --
> 2.39.3
>

