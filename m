Return-Path: <linux-kselftest+bounces-1893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACB8812858
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 07:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C5DB21290
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 06:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB03D278;
	Thu, 14 Dec 2023 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="eRIUpeIz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9218BB7
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 22:42:05 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5913e3a9e05so1691812eaf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 22:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702536125; x=1703140925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13FmDcyhjs8ErKIoJ2M5PIcR4M2jPsANXaNJ5AXqq5M=;
        b=eRIUpeIzvZoO+xQ2FMwUCIDzsCV9mf+9FnGH5q+3fs7MQ3BbLbVuYLB+f9Wo0Zw8eX
         vUKAwLK+cAQFyJnMZTnC7QTRI5bGRICNxuG2UfA8ZwgyQCwLo49JUKRZFsFQksiig95n
         p4HVYGb/yCCu7Bt0jyVQPeXR8aUoCBz2QH2FKCK3clueoFBiOtAthFiMwuVz1pqYIsSO
         yPUMJqeqSR665rO51XjLlUgj+bYnYXOZyZi31Ijl1hAh0xAH2YrWe3IwBQXVUfVF+1CF
         qe/LgaXXw2ScD+Pqj/kSEk6UY54H82Fz8TMdBCd7+k5hOxbYdv8vS9KU9j8c5MWyb+8L
         fodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702536125; x=1703140925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13FmDcyhjs8ErKIoJ2M5PIcR4M2jPsANXaNJ5AXqq5M=;
        b=XrPYkDdja/6pVt2IgpVd9qOjRFb/+i1JP9MkF7G5mYSVWKOe3FKvSJAw12zvAjX+fC
         bSbP2WwR1J1n4KACu83t3qDcUd5duZoH/qwW3AvBZNctdTm42MOB6mP/kWuAgC6nwI8w
         GKnVMyMLTc/467MU3DyXz4RLYLNkT2CGy4i/6eV3XC0rNhpJtjwTgXqt0W/lc2glx7pH
         E5WyF+lbkWl+YTJsppzg8GJfj3EGV3hIYLtNkTrDTxRFBdtEOLI61XjYe6QARA34yYof
         /6qJqkSJCIvpVJ97ziGMsmVeBIUqWyU9jejuO+hY2WzQB4ATeobv1pRytzIzcvdkIVZt
         b3cA==
X-Gm-Message-State: AOJu0YzvZql42/zTrkIC78y7rh5wYTQham4Drf4bkALUwwf8n0Je8vfn
	VYsyz1bqQVAkh5obIIQoh+8Yel3Xn3yGfhDLKHIsHw==
X-Google-Smtp-Source: AGHT+IEfDp47zSpKQdKI+0bZaATu9JMKD/6G8am64FM5JEj6y0PGHRStMTIbBSF49LOiFWpoZuIijoOssdjeHIMVFgM=
X-Received: by 2002:a05:6358:4194:b0:170:ee27:bfa1 with SMTP id
 w20-20020a056358419400b00170ee27bfa1mr5103478rwc.5.1702536124532; Wed, 13 Dec
 2023 22:42:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702371136.git.haibo1.xu@intel.com> <636e8c3bf8b35be089182569621eaff331242d98.1702371136.git.haibo1.xu@intel.com>
In-Reply-To: <636e8c3bf8b35be089182569621eaff331242d98.1702371136.git.haibo1.xu@intel.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 14 Dec 2023 12:11:53 +0530
Message-ID: <CAAhSdy2=MbAS0evdVH0afB1OqNAH9e8_fLSyCmhAe-4_m4jo7w@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] KVM: arm64: selftests: Split arch_timer test code
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Atish Patra <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Greentime Hu <greentime.hu@sifive.com>, Heiko Stuebner <heiko@sntech.de>, 
	Samuel Holland <samuel@sholland.org>, Minda Chen <minda.chen@starfivetech.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Sean Christopherson <seanjc@google.com>, Peter Xu <peterx@redhat.com>, 
	Like Xu <likexu@tencent.com>, Vipin Sharma <vipinsh@google.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Thomas Huth <thuth@redhat.com>, 
	Aaron Lewis <aaronlewis@google.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc, Hi Oliver,

On Tue, Dec 12, 2023 at 2:49=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wrot=
e:
>
> Split the arch-neutral test code out of aarch64/arch_timer.c
> and put them into a common arch_timer.c. This is a preparation
> to share timer test codes in riscv.
>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Can you please review this patch ?

We want to take this entire series through KVM RISC-V tree.

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/Makefile          |   3 +-
>  .../selftests/kvm/aarch64/arch_timer.c        | 275 +-----------------
>  tools/testing/selftests/kvm/arch_timer.c      | 249 ++++++++++++++++
>  .../testing/selftests/kvm/include/test_util.h |   2 +
>  .../selftests/kvm/include/timer_test.h        |  43 +++
>  5 files changed, 302 insertions(+), 270 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/arch_timer.c
>  create mode 100644 tools/testing/selftests/kvm/include/timer_test.h
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftes=
ts/kvm/Makefile
> index 2200f06b740b..4838ea899bbb 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -151,7 +151,6 @@ TEST_GEN_PROGS_x86_64 +=3D system_counter_offset_test
>  TEST_GEN_PROGS_EXTENDED_x86_64 +=3D x86_64/nx_huge_pages_test
>
>  TEST_GEN_PROGS_aarch64 +=3D aarch64/aarch32_id_regs
> -TEST_GEN_PROGS_aarch64 +=3D aarch64/arch_timer
>  TEST_GEN_PROGS_aarch64 +=3D aarch64/debug-exceptions
>  TEST_GEN_PROGS_aarch64 +=3D aarch64/hypercalls
>  TEST_GEN_PROGS_aarch64 +=3D aarch64/page_fault_test
> @@ -163,6 +162,7 @@ TEST_GEN_PROGS_aarch64 +=3D aarch64/vgic_init
>  TEST_GEN_PROGS_aarch64 +=3D aarch64/vgic_irq
>  TEST_GEN_PROGS_aarch64 +=3D aarch64/vpmu_counter_access
>  TEST_GEN_PROGS_aarch64 +=3D access_tracking_perf_test
> +TEST_GEN_PROGS_aarch64 +=3D arch_timer
>  TEST_GEN_PROGS_aarch64 +=3D demand_paging_test
>  TEST_GEN_PROGS_aarch64 +=3D dirty_log_test
>  TEST_GEN_PROGS_aarch64 +=3D dirty_log_perf_test
> @@ -201,6 +201,7 @@ TEST_GEN_PROGS_riscv +=3D kvm_page_table_test
>  TEST_GEN_PROGS_riscv +=3D set_memory_region_test
>  TEST_GEN_PROGS_riscv +=3D kvm_binary_stats_test
>
> +SPLIT_TESTS +=3D arch_timer
>  SPLIT_TESTS +=3D get-reg-list
>
>  TEST_PROGS +=3D $(TEST_PROGS_$(ARCH_DIR))
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/tes=
ting/selftests/kvm/aarch64/arch_timer.c
> index 274b8465b42a..6fb47ba07e5b 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -1,64 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * arch_timer.c - Tests the aarch64 timer IRQ functionality
> - *
>   * The test validates both the virtual and physical timer IRQs using
> - * CVAL and TVAL registers. This consitutes the four stages in the test.
> - * The guest's main thread configures the timer interrupt for a stage
> - * and waits for it to fire, with a timeout equal to the timer period.
> - * It asserts that the timeout doesn't exceed the timer period.
> - *
> - * On the other hand, upon receipt of an interrupt, the guest's interrup=
t
> - * handler validates the interrupt by checking if the architectural stat=
e
> - * is in compliance with the specifications.
> - *
> - * The test provides command-line options to configure the timer's
> - * period (-p), number of vCPUs (-n), and iterations per stage (-i).
> - * To stress-test the timer stack even more, an option to migrate the
> - * vCPUs across pCPUs (-m), at a particular rate, is also provided.
> + * CVAL and TVAL registers.
>   *
>   * Copyright (c) 2021, Google LLC.
>   */
>  #define _GNU_SOURCE
>
> -#include <stdlib.h>
> -#include <pthread.h>
> -#include <linux/kvm.h>
> -#include <linux/sizes.h>
> -#include <linux/bitmap.h>
> -#include <sys/sysinfo.h>
> -
> -#include "kvm_util.h"
> -#include "processor.h"
> -#include "delay.h"
>  #include "arch_timer.h"
> +#include "delay.h"
>  #include "gic.h"
> +#include "processor.h"
> +#include "timer_test.h"
>  #include "vgic.h"
>
> -#define NR_VCPUS_DEF                   4
> -#define NR_TEST_ITERS_DEF              5
> -#define TIMER_TEST_PERIOD_MS_DEF       10
> -#define TIMER_TEST_ERR_MARGIN_US       100
> -#define TIMER_TEST_MIGRATION_FREQ_MS   2
> -
> -struct test_args {
> -       int nr_vcpus;
> -       int nr_iter;
> -       int timer_period_ms;
> -       int migration_freq_ms;
> -       struct kvm_arm_counter_offset offset;
> -};
> -
> -static struct test_args test_args =3D {
> -       .nr_vcpus =3D NR_VCPUS_DEF,
> -       .nr_iter =3D NR_TEST_ITERS_DEF,
> -       .timer_period_ms =3D TIMER_TEST_PERIOD_MS_DEF,
> -       .migration_freq_ms =3D TIMER_TEST_MIGRATION_FREQ_MS,
> -       .offset =3D { .reserved =3D 1 },
> -};
> -
> -#define msecs_to_usecs(msec)           ((msec) * 1000LL)
> -
>  #define GICD_BASE_GPA                  0x8000000ULL
>  #define GICR_BASE_GPA                  0x80A0000ULL
>
> @@ -70,22 +25,8 @@ enum guest_stage {
>         GUEST_STAGE_MAX,
>  };
>
> -/* Shared variables between host and guest */
> -struct test_vcpu_shared_data {
> -       int nr_iter;
> -       enum guest_stage guest_stage;
> -       uint64_t xcnt;
> -};
> -
> -static struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
> -static pthread_t pt_vcpu_run[KVM_MAX_VCPUS];
> -static struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
> -
>  static int vtimer_irq, ptimer_irq;
>
> -static unsigned long *vcpu_done_map;
> -static pthread_mutex_t vcpu_done_map_lock;
> -
>  static void
>  guest_configure_timer_action(struct test_vcpu_shared_data *shared_data)
>  {
> @@ -222,137 +163,6 @@ static void guest_code(void)
>         GUEST_DONE();
>  }
>
> -static void *test_vcpu_run(void *arg)
> -{
> -       unsigned int vcpu_idx =3D (unsigned long)arg;
> -       struct ucall uc;
> -       struct kvm_vcpu *vcpu =3D vcpus[vcpu_idx];
> -       struct kvm_vm *vm =3D vcpu->vm;
> -       struct test_vcpu_shared_data *shared_data =3D &vcpu_shared_data[v=
cpu_idx];
> -
> -       vcpu_run(vcpu);
> -
> -       /* Currently, any exit from guest is an indication of completion =
*/
> -       pthread_mutex_lock(&vcpu_done_map_lock);
> -       __set_bit(vcpu_idx, vcpu_done_map);
> -       pthread_mutex_unlock(&vcpu_done_map_lock);
> -
> -       switch (get_ucall(vcpu, &uc)) {
> -       case UCALL_SYNC:
> -       case UCALL_DONE:
> -               break;
> -       case UCALL_ABORT:
> -               sync_global_from_guest(vm, *shared_data);
> -               fprintf(stderr, "Guest assert failed,  vcpu %u; stage; %u=
; iter: %u\n",
> -                       vcpu_idx, shared_data->guest_stage, shared_data->=
nr_iter);
> -               REPORT_GUEST_ASSERT(uc);
> -               break;
> -       default:
> -               TEST_FAIL("Unexpected guest exit\n");
> -       }
> -
> -       return NULL;
> -}
> -
> -static uint32_t test_get_pcpu(void)
> -{
> -       uint32_t pcpu;
> -       unsigned int nproc_conf;
> -       cpu_set_t online_cpuset;
> -
> -       nproc_conf =3D get_nprocs_conf();
> -       sched_getaffinity(0, sizeof(cpu_set_t), &online_cpuset);
> -
> -       /* Randomly find an available pCPU to place a vCPU on */
> -       do {
> -               pcpu =3D rand() % nproc_conf;
> -       } while (!CPU_ISSET(pcpu, &online_cpuset));
> -
> -       return pcpu;
> -}
> -
> -static int test_migrate_vcpu(unsigned int vcpu_idx)
> -{
> -       int ret;
> -       cpu_set_t cpuset;
> -       uint32_t new_pcpu =3D test_get_pcpu();
> -
> -       CPU_ZERO(&cpuset);
> -       CPU_SET(new_pcpu, &cpuset);
> -
> -       pr_debug("Migrating vCPU: %u to pCPU: %u\n", vcpu_idx, new_pcpu);
> -
> -       ret =3D pthread_setaffinity_np(pt_vcpu_run[vcpu_idx],
> -                                    sizeof(cpuset), &cpuset);
> -
> -       /* Allow the error where the vCPU thread is already finished */
> -       TEST_ASSERT(ret =3D=3D 0 || ret =3D=3D ESRCH,
> -                   "Failed to migrate the vCPU:%u to pCPU: %u; ret: %d\n=
",
> -                   vcpu_idx, new_pcpu, ret);
> -
> -       return ret;
> -}
> -
> -static void *test_vcpu_migration(void *arg)
> -{
> -       unsigned int i, n_done;
> -       bool vcpu_done;
> -
> -       do {
> -               usleep(msecs_to_usecs(test_args.migration_freq_ms));
> -
> -               for (n_done =3D 0, i =3D 0; i < test_args.nr_vcpus; i++) =
{
> -                       pthread_mutex_lock(&vcpu_done_map_lock);
> -                       vcpu_done =3D test_bit(i, vcpu_done_map);
> -                       pthread_mutex_unlock(&vcpu_done_map_lock);
> -
> -                       if (vcpu_done) {
> -                               n_done++;
> -                               continue;
> -                       }
> -
> -                       test_migrate_vcpu(i);
> -               }
> -       } while (test_args.nr_vcpus !=3D n_done);
> -
> -       return NULL;
> -}
> -
> -static void test_run(struct kvm_vm *vm)
> -{
> -       pthread_t pt_vcpu_migration;
> -       unsigned int i;
> -       int ret;
> -
> -       pthread_mutex_init(&vcpu_done_map_lock, NULL);
> -       vcpu_done_map =3D bitmap_zalloc(test_args.nr_vcpus);
> -       TEST_ASSERT(vcpu_done_map, "Failed to allocate vcpu done bitmap\n=
");
> -
> -       for (i =3D 0; i < (unsigned long)test_args.nr_vcpus; i++) {
> -               ret =3D pthread_create(&pt_vcpu_run[i], NULL, test_vcpu_r=
un,
> -                                    (void *)(unsigned long)i);
> -               TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n", i=
);
> -       }
> -
> -       /* Spawn a thread to control the vCPU migrations */
> -       if (test_args.migration_freq_ms) {
> -               srand(time(NULL));
> -
> -               ret =3D pthread_create(&pt_vcpu_migration, NULL,
> -                                       test_vcpu_migration, NULL);
> -               TEST_ASSERT(!ret, "Failed to create the migration pthread=
\n");
> -       }
> -
> -
> -       for (i =3D 0; i < test_args.nr_vcpus; i++)
> -               pthread_join(pt_vcpu_run[i], NULL);
> -
> -       if (test_args.migration_freq_ms)
> -               pthread_join(pt_vcpu_migration, NULL);
> -
> -       bitmap_free(vcpu_done_map);
> -}
> -
>  static void test_init_timer_irq(struct kvm_vm *vm)
>  {
>         /* Timer initid should be same for all the vCPUs, so query only v=
CPU-0 */
> @@ -369,7 +179,7 @@ static void test_init_timer_irq(struct kvm_vm *vm)
>
>  static int gic_fd;
>
> -static struct kvm_vm *test_vm_create(void)
> +struct kvm_vm *test_vm_create(void)
>  {
>         struct kvm_vm *vm;
>         unsigned int i;
> @@ -400,81 +210,8 @@ static struct kvm_vm *test_vm_create(void)
>         return vm;
>  }
>
> -static void test_vm_cleanup(struct kvm_vm *vm)
> +void test_vm_cleanup(struct kvm_vm *vm)
>  {
>         close(gic_fd);
>         kvm_vm_free(vm);
>  }
> -
> -static void test_print_help(char *name)
> -{
> -       pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_p=
eriod_ms]\n",
> -               name);
> -       pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u=
)\n",
> -               NR_VCPUS_DEF, KVM_MAX_VCPUS);
> -       pr_info("\t-i: Number of iterations per stage (default: %u)\n",
> -               NR_TEST_ITERS_DEF);
> -       pr_info("\t-p: Periodicity (in ms) of the guest timer (default: %=
u)\n",
> -               TIMER_TEST_PERIOD_MS_DEF);
> -       pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different=
 pCPU. 0 to turn off (default: %u)\n",
> -               TIMER_TEST_MIGRATION_FREQ_MS);
> -       pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n")=
;
> -       pr_info("\t-h: print this help screen\n");
> -}
> -
> -static bool parse_args(int argc, char *argv[])
> -{
> -       int opt;
> -
> -       while ((opt =3D getopt(argc, argv, "hn:i:p:m:o:")) !=3D -1) {
> -               switch (opt) {
> -               case 'n':
> -                       test_args.nr_vcpus =3D atoi_positive("Number of v=
CPUs", optarg);
> -                       if (test_args.nr_vcpus > KVM_MAX_VCPUS) {
> -                               pr_info("Max allowed vCPUs: %u\n",
> -                                       KVM_MAX_VCPUS);
> -                               goto err;
> -                       }
> -                       break;
> -               case 'i':
> -                       test_args.nr_iter =3D atoi_positive("Number of it=
erations", optarg);
> -                       break;
> -               case 'p':
> -                       test_args.timer_period_ms =3D atoi_positive("Peri=
odicity", optarg);
> -                       break;
> -               case 'm':
> -                       test_args.migration_freq_ms =3D atoi_non_negative=
("Frequency", optarg);
> -                       break;
> -               case 'o':
> -                       test_args.offset.counter_offset =3D strtol(optarg=
, NULL, 0);
> -                       test_args.offset.reserved =3D 0;
> -                       break;
> -               case 'h':
> -               default:
> -                       goto err;
> -               }
> -       }
> -
> -       return true;
> -
> -err:
> -       test_print_help(argv[0]);
> -       return false;
> -}
> -
> -int main(int argc, char *argv[])
> -{
> -       struct kvm_vm *vm;
> -
> -       if (!parse_args(argc, argv))
> -               exit(KSFT_SKIP);
> -
> -       __TEST_REQUIRE(!test_args.migration_freq_ms || get_nprocs() >=3D =
2,
> -                      "At least two physical CPUs needed for vCPU migrat=
ion");
> -
> -       vm =3D test_vm_create();
> -       test_run(vm);
> -       test_vm_cleanup(vm);
> -
> -       return 0;
> -}
> diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/sel=
ftests/kvm/arch_timer.c
> new file mode 100644
> index 000000000000..6e442dbcfc8b
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/arch_timer.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * arch_timer.c - Tests the arch timer IRQ functionality
> + *
> + * The guest's main thread configures the timer interrupt and waits
> + * for it to fire, with a timeout equal to the timer period.
> + * It asserts that the timeout doesn't exceed the timer period plus
> + * an error margin of 100us.
> + *
> + * On the other hand, upon receipt of an interrupt, the guest's interrup=
t
> + * handler validates the interrupt by checking if the architectural stat=
e
> + * is in compliance with the specifications.
> + *
> + * The test provides command-line options to configure the timer's
> + * period (-p), number of vCPUs (-n), and iterations per stage (-i).
> + * To stress-test the timer stack even more, an option to migrate the
> + * vCPUs across pCPUs (-m), at a particular rate, is also provided.
> + *
> + * Copyright (c) 2021, Google LLC.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdlib.h>
> +#include <pthread.h>
> +#include <linux/sizes.h>
> +#include <linux/bitmap.h>
> +#include <sys/sysinfo.h>
> +
> +#include "timer_test.h"
> +
> +struct test_args test_args =3D {
> +       .nr_vcpus =3D NR_VCPUS_DEF,
> +       .nr_iter =3D NR_TEST_ITERS_DEF,
> +       .timer_period_ms =3D TIMER_TEST_PERIOD_MS_DEF,
> +       .migration_freq_ms =3D TIMER_TEST_MIGRATION_FREQ_MS,
> +       .offset =3D { .reserved =3D 1 },
> +};
> +
> +struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
> +struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
> +
> +static pthread_t pt_vcpu_run[KVM_MAX_VCPUS];
> +static unsigned long *vcpu_done_map;
> +static pthread_mutex_t vcpu_done_map_lock;
> +
> +static void *test_vcpu_run(void *arg)
> +{
> +       unsigned int vcpu_idx =3D (unsigned long)arg;
> +       struct ucall uc;
> +       struct kvm_vcpu *vcpu =3D vcpus[vcpu_idx];
> +       struct kvm_vm *vm =3D vcpu->vm;
> +       struct test_vcpu_shared_data *shared_data =3D &vcpu_shared_data[v=
cpu_idx];
> +
> +       vcpu_run(vcpu);
> +
> +       /* Currently, any exit from guest is an indication of completion =
*/
> +       pthread_mutex_lock(&vcpu_done_map_lock);
> +       __set_bit(vcpu_idx, vcpu_done_map);
> +       pthread_mutex_unlock(&vcpu_done_map_lock);
> +
> +       switch (get_ucall(vcpu, &uc)) {
> +       case UCALL_SYNC:
> +       case UCALL_DONE:
> +               break;
> +       case UCALL_ABORT:
> +               sync_global_from_guest(vm, *shared_data);
> +               fprintf(stderr, "Guest assert failed,  vcpu %u; stage; %u=
; iter: %u\n",
> +                       vcpu_idx, shared_data->guest_stage, shared_data->=
nr_iter);
> +               REPORT_GUEST_ASSERT(uc);
> +               break;
> +       default:
> +               TEST_FAIL("Unexpected guest exit\n");
> +       }
> +
> +       return NULL;
> +}
> +
> +static uint32_t test_get_pcpu(void)
> +{
> +       uint32_t pcpu;
> +       unsigned int nproc_conf;
> +       cpu_set_t online_cpuset;
> +
> +       nproc_conf =3D get_nprocs_conf();
> +       sched_getaffinity(0, sizeof(cpu_set_t), &online_cpuset);
> +
> +       /* Randomly find an available pCPU to place a vCPU on */
> +       do {
> +               pcpu =3D rand() % nproc_conf;
> +       } while (!CPU_ISSET(pcpu, &online_cpuset));
> +
> +       return pcpu;
> +}
> +
> +static int test_migrate_vcpu(unsigned int vcpu_idx)
> +{
> +       int ret;
> +       cpu_set_t cpuset;
> +       uint32_t new_pcpu =3D test_get_pcpu();
> +
> +       CPU_ZERO(&cpuset);
> +       CPU_SET(new_pcpu, &cpuset);
> +
> +       pr_debug("Migrating vCPU: %u to pCPU: %u\n", vcpu_idx, new_pcpu);
> +
> +       ret =3D pthread_setaffinity_np(pt_vcpu_run[vcpu_idx],
> +                                    sizeof(cpuset), &cpuset);
> +
> +       /* Allow the error where the vCPU thread is already finished */
> +       TEST_ASSERT(ret =3D=3D 0 || ret =3D=3D ESRCH,
> +                   "Failed to migrate the vCPU:%u to pCPU: %u; ret: %d\n=
",
> +                   vcpu_idx, new_pcpu, ret);
> +
> +       return ret;
> +}
> +
> +static void *test_vcpu_migration(void *arg)
> +{
> +       unsigned int i, n_done;
> +       bool vcpu_done;
> +
> +       do {
> +               usleep(msecs_to_usecs(test_args.migration_freq_ms));
> +
> +               for (n_done =3D 0, i =3D 0; i < test_args.nr_vcpus; i++) =
{
> +                       pthread_mutex_lock(&vcpu_done_map_lock);
> +                       vcpu_done =3D test_bit(i, vcpu_done_map);
> +                       pthread_mutex_unlock(&vcpu_done_map_lock);
> +
> +                       if (vcpu_done) {
> +                               n_done++;
> +                               continue;
> +                       }
> +
> +                       test_migrate_vcpu(i);
> +               }
> +       } while (test_args.nr_vcpus !=3D n_done);
> +
> +       return NULL;
> +}
> +
> +static void test_run(struct kvm_vm *vm)
> +{
> +       pthread_t pt_vcpu_migration;
> +       unsigned int i;
> +       int ret;
> +
> +       pthread_mutex_init(&vcpu_done_map_lock, NULL);
> +       vcpu_done_map =3D bitmap_zalloc(test_args.nr_vcpus);
> +       TEST_ASSERT(vcpu_done_map, "Failed to allocate vcpu done bitmap\n=
");
> +
> +       for (i =3D 0; i < (unsigned long)test_args.nr_vcpus; i++) {
> +               ret =3D pthread_create(&pt_vcpu_run[i], NULL, test_vcpu_r=
un,
> +                                    (void *)(unsigned long)i);
> +               TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n", i=
);
> +       }
> +
> +       /* Spawn a thread to control the vCPU migrations */
> +       if (test_args.migration_freq_ms) {
> +               srand(time(NULL));
> +
> +               ret =3D pthread_create(&pt_vcpu_migration, NULL,
> +                                       test_vcpu_migration, NULL);
> +               TEST_ASSERT(!ret, "Failed to create the migration pthread=
\n");
> +       }
> +
> +
> +       for (i =3D 0; i < test_args.nr_vcpus; i++)
> +               pthread_join(pt_vcpu_run[i], NULL);
> +
> +       if (test_args.migration_freq_ms)
> +               pthread_join(pt_vcpu_migration, NULL);
> +
> +       bitmap_free(vcpu_done_map);
> +}
> +
> +static void test_print_help(char *name)
> +{
> +       pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_p=
eriod_ms]\n",
> +               name);
> +       pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u=
)\n",
> +               NR_VCPUS_DEF, KVM_MAX_VCPUS);
> +       pr_info("\t-i: Number of iterations per stage (default: %u)\n",
> +               NR_TEST_ITERS_DEF);
> +       pr_info("\t-p: Periodicity (in ms) of the guest timer (default: %=
u)\n",
> +               TIMER_TEST_PERIOD_MS_DEF);
> +       pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different=
 pCPU. 0 to turn off (default: %u)\n",
> +               TIMER_TEST_MIGRATION_FREQ_MS);
> +       pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n")=
;
> +       pr_info("\t-h: print this help screen\n");
> +}
> +
> +static bool parse_args(int argc, char *argv[])
> +{
> +       int opt;
> +
> +       while ((opt =3D getopt(argc, argv, "hn:i:p:m:o:")) !=3D -1) {
> +               switch (opt) {
> +               case 'n':
> +                       test_args.nr_vcpus =3D atoi_positive("Number of v=
CPUs", optarg);
> +                       if (test_args.nr_vcpus > KVM_MAX_VCPUS) {
> +                               pr_info("Max allowed vCPUs: %u\n",
> +                                       KVM_MAX_VCPUS);
> +                               goto err;
> +                       }
> +                       break;
> +               case 'i':
> +                       test_args.nr_iter =3D atoi_positive("Number of it=
erations", optarg);
> +                       break;
> +               case 'p':
> +                       test_args.timer_period_ms =3D atoi_positive("Peri=
odicity", optarg);
> +                       break;
> +               case 'm':
> +                       test_args.migration_freq_ms =3D atoi_non_negative=
("Frequency", optarg);
> +                       break;
> +               case 'o':
> +                       test_args.offset.counter_offset =3D strtol(optarg=
, NULL, 0);
> +                       test_args.offset.reserved =3D 0;
> +                       break;
> +               case 'h':
> +               default:
> +                       goto err;
> +               }
> +       }
> +
> +       return true;
> +
> +err:
> +       test_print_help(argv[0]);
> +       return false;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       struct kvm_vm *vm;
> +
> +       if (!parse_args(argc, argv))
> +               exit(KSFT_SKIP);
> +
> +       __TEST_REQUIRE(!test_args.migration_freq_ms || get_nprocs() >=3D =
2,
> +                      "At least two physical CPUs needed for vCPU migrat=
ion");
> +
> +       vm =3D test_vm_create();
> +       test_run(vm);
> +       test_vm_cleanup(vm);
> +
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/test=
ing/selftests/kvm/include/test_util.h
> index 8e5f413a593d..36387e7ee8b2 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -20,6 +20,8 @@
>  #include <sys/mman.h>
>  #include "kselftest.h"
>
> +#define msecs_to_usecs(msec)    ((msec) * 1000LL)
> +
>  static inline int _no_printf(const char *format, ...) { return 0; }
>
>  #ifdef DEBUG
> diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/tes=
ting/selftests/kvm/include/timer_test.h
> new file mode 100644
> index 000000000000..2234c513b510
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/timer_test.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * timer test specific header
> + *
> + * Copyright (C) 2018, Google LLC
> + */
> +
> +#ifndef SELFTEST_KVM_TIMER_TEST_H
> +#define SELFTEST_KVM_TIMER_TEST_H
> +
> +#include "kvm_util.h"
> +
> +#define NR_VCPUS_DEF            4
> +#define NR_TEST_ITERS_DEF       5
> +#define TIMER_TEST_PERIOD_MS_DEF    10
> +#define TIMER_TEST_ERR_MARGIN_US    100
> +#define TIMER_TEST_MIGRATION_FREQ_MS    2
> +
> +/* Timer test cmdline parameters */
> +struct test_args {
> +       int nr_vcpus;
> +       int nr_iter;
> +       int timer_period_ms;
> +       int migration_freq_ms;
> +       /* TODO: Change arm specific type to a common one */
> +       struct kvm_arm_counter_offset offset;
> +};
> +
> +/* Shared variables between host and guest */
> +struct test_vcpu_shared_data {
> +       int nr_iter;
> +       int guest_stage;
> +       uint64_t xcnt;
> +};
> +
> +extern struct test_args test_args;
> +extern struct kvm_vcpu *vcpus[];
> +extern struct test_vcpu_shared_data vcpu_shared_data[];
> +
> +struct kvm_vm *test_vm_create(void);
> +void test_vm_cleanup(struct kvm_vm *vm);
> +
> +#endif /* SELFTEST_KVM_TIMER_TEST_H */
> --
> 2.34.1
>

