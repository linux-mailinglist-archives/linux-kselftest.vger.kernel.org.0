Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F385A793432
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 05:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjIFDor (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 23:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjIFDoq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 23:44:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1A519A;
        Tue,  5 Sep 2023 20:44:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bd6611873aso49427221fa.1;
        Tue, 05 Sep 2023 20:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693971879; x=1694576679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsDEUlxdejj2vrr2k7q+YBgRw0mYkdzfQP5j9GXagKY=;
        b=CjOWuMKKFbtwCiF7UuoxAOANwiw+99i7X2z2gIWIuekZ13t+LdNE21iCjdqQH49+K+
         ONGON8Ofp/m1Q7Pep6x/JaTTIf369AYqncqDEHX4JvVWxie8gYnewFZlrtSVJyZGcmML
         6eLI6oCd4aX5RyYI4+WBDAp/4z+dykmZxA6f9onJ0nr7yqT1fbQW4SPtMI2NQeAmZBA2
         jxcjQSqwgzGtqugJra/nrGIgdue2yXxm3e3+7GiSbU+G1AnDKAykUg88wzjRpooetKm2
         gq1ulZPVJ2UT3MZjSjAGS18sfgCWL8Ce2nyVd46sFaxcSi5Tcjawh2PyaB5aihfN+qZg
         5wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693971879; x=1694576679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsDEUlxdejj2vrr2k7q+YBgRw0mYkdzfQP5j9GXagKY=;
        b=MUrfCV4xLKwFZi41J8F/aMPqCKshpkn5Q7EGD/zUyYJM/TiQtzl1MLsdlxHjM47uY9
         qv8beFojbyXFNQ0oeXW7gYJmc6QFMjX0HPSzt65E4s3kMLTGL1cU4ZtCoUME8b2a64iv
         DNviyOJJ3tGgTcXIZ7w9EUN7OW8Xh8S0I/QP3Cw1DZL5FXKkwjtV9i/clTKx0ly8XGFH
         MN6D+eUQCk9oLoU+6s99cobgcMhWFy3af2ypEaSThX0n3Hv68hkxQQds5x1waRHGf/MR
         0PlZZfl6DHW9HegU791GPlLFrxwOFH27S5yLwzgYjlsW3AXpAWgyGHlQ67Aa7vEjhm77
         np+g==
X-Gm-Message-State: AOJu0YzlrVUZfkyXiIeRTTFHtLQiWDyxlLGwYFehDgExjVURUujK+PGr
        DNn+An3nSZfnBXV4qgtwoopB0AgDWbpFhcE2I1w=
X-Google-Smtp-Source: AGHT+IFGfHyG7w9fWKRAfs9DF/Db63z1Jii1GoTaSb+cavCNy8v7KYhRkAjKnKwriELDq/SIFdm69mw1Pgvfrp+iPBc=
X-Received: by 2002:a2e:8792:0:b0:2bc:b224:98ac with SMTP id
 n18-20020a2e8792000000b002bcb22498acmr1343723lji.31.1693971878911; Tue, 05
 Sep 2023 20:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693659382.git.haibo1.xu@intel.com> <c87337cfd7fb135e2efed589360a78c26a402eac.1693659382.git.haibo1.xu@intel.com>
 <20230904-11e853ffe3d8e9cf9ec6079d@orel> <CAJve8onwjBQcbVy75qyOF3A51-T0WyBkmeCV_wOZvzaPcrBVFg@mail.gmail.com>
In-Reply-To: <CAJve8onwjBQcbVy75qyOF3A51-T0WyBkmeCV_wOZvzaPcrBVFg@mail.gmail.com>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 6 Sep 2023 11:44:26 +0800
Message-ID: <CAJve8ok-zZAG7T3t5XD-CtJn47tTE867Xaaw_YHYy1XmUL41rw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] KVM: arm64: selftest: Split arch_timer test code
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Lei Wang <lei4.wang@intel.com>, Like Xu <likexu@tencent.com>,
        Peter Gonda <pgonda@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 6, 2023 at 10:14=E2=80=AFAM Haibo Xu <xiaobo55x@gmail.com> wrot=
e:
>
> On Mon, Sep 4, 2023 at 9:24=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
> >
> > On Sat, Sep 02, 2023 at 08:59:24PM +0800, Haibo Xu wrote:
> > > Split the arch-neutral test code out of aarch64/arch_timer.c
> > > and put them into a common arch_timer.c. This is a preparation
> > > to share timer test codes in riscv.
> > >
> > > Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > ---
> > >  tools/testing/selftests/kvm/Makefile          |   9 +-
> > >  .../selftests/kvm/aarch64/arch_timer.c        | 288 +---------------=
--
> > >  tools/testing/selftests/kvm/arch_timer.c      | 252 +++++++++++++++
> > >  .../selftests/kvm/include/timer_test.h        |  52 ++++
> > >  4 files changed, 317 insertions(+), 284 deletions(-)
> > >  create mode 100644 tools/testing/selftests/kvm/arch_timer.c
> > >  create mode 100644 tools/testing/selftests/kvm/include/timer_test.h
> > >
> > > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/sel=
ftests/kvm/Makefile
> > > index 0b9c42fbce8c..fb8904e2c06a 100644
> > > --- a/tools/testing/selftests/kvm/Makefile
> > > +++ b/tools/testing/selftests/kvm/Makefile
> > > @@ -140,7 +140,6 @@ TEST_GEN_PROGS_x86_64 +=3D system_counter_offset_=
test
> > >  TEST_GEN_PROGS_EXTENDED_x86_64 +=3D x86_64/nx_huge_pages_test
> > >
> > >  TEST_GEN_PROGS_aarch64 +=3D aarch64/aarch32_id_regs
> > > -TEST_GEN_PROGS_aarch64 +=3D aarch64/arch_timer
> > >  TEST_GEN_PROGS_aarch64 +=3D aarch64/debug-exceptions
> > >  TEST_GEN_PROGS_aarch64 +=3D aarch64/hypercalls
> > >  TEST_GEN_PROGS_aarch64 +=3D aarch64/page_fault_test
> > > @@ -150,6 +149,7 @@ TEST_GEN_PROGS_aarch64 +=3D aarch64/vcpu_width_co=
nfig
> > >  TEST_GEN_PROGS_aarch64 +=3D aarch64/vgic_init
> > >  TEST_GEN_PROGS_aarch64 +=3D aarch64/vgic_irq
> > >  TEST_GEN_PROGS_aarch64 +=3D access_tracking_perf_test
> > > +TEST_GEN_PROGS_aarch64 +=3D arch_timer
> > >  TEST_GEN_PROGS_aarch64 +=3D demand_paging_test
> > >  TEST_GEN_PROGS_aarch64 +=3D dirty_log_test
> > >  TEST_GEN_PROGS_aarch64 +=3D dirty_log_perf_test
> > > @@ -188,6 +188,7 @@ TEST_GEN_PROGS_riscv +=3D set_memory_region_test
> > >  TEST_GEN_PROGS_riscv +=3D kvm_binary_stats_test
> > >
> > >  SPLIT_TESTS +=3D get-reg-list
> > > +SPLIT_TESTS +=3D arch_timer
> > >
> > >  TEST_PROGS +=3D $(TEST_PROGS_$(ARCH_DIR))
> > >  TEST_GEN_PROGS +=3D $(TEST_GEN_PROGS_$(ARCH_DIR))
> > > @@ -248,13 +249,10 @@ TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(SPLI=
T_TESTS_OBJS))
> > >  -include $(TEST_DEP_FILES)
> > >
> > >  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
> > > -     $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBK=
VM_OBJS) $(LDLIBS) -o $@
> > > +     $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLI=
BS) -o $@
> > >  $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
> > >       $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
> > >
> > > -$(SPLIT_TESTS_TARGETS): %: %.o $(SPLIT_TESTS_OBJS)
> > > -     $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLI=
BS) -o $@
> > > -
> > >  EXTRA_CLEAN +=3D $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) $(=
SPLIT_TESTS_OBJS) cscope.*
> > >
> > >  x :=3D $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ)=
)))
> > > @@ -273,6 +271,7 @@ $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
> > >  x :=3D $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
> > >  $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
> > >  $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
> > > +$(SPLIT_TESTS_TARGETS): $(OUTPUT)/%: $(ARCH_DIR)/%.o
> >
> > The improvements to the Makefile to avoid SPLIT_TESTS_TARGETS needing i=
ts
> > own $(CC) line should preferably be done in a separate, preliminary pat=
ch.
> >
>
> Yes, Will move the change to a separate patch.
>
> > >
> > >  cscope: include_paths =3D $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) in=
clude lib ..
> > >  cscope:
> > > diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools=
/testing/selftests/kvm/aarch64/arch_timer.c
> > > index b63859829a96..ceb649548751 100644
> > > --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> > > +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> > > @@ -1,91 +1,25 @@
> > >  // SPDX-License-Identifier: GPL-2.0-only
> > >  /*
> > > - * arch_timer.c - Tests the aarch64 timer IRQ functionality
> > > - *
> > >   * The test validates both the virtual and physical timer IRQs using
> > > - * CVAL and TVAL registers. This consitutes the four stages in the t=
est.
> > > - * The guest's main thread configures the timer interrupt for a stag=
e
> > > - * and waits for it to fire, with a timeout equal to the timer perio=
d.
> > > - * It asserts that the timeout doesn't exceed the timer period.
> > > - *
> > > - * On the other hand, upon receipt of an interrupt, the guest's inte=
rrupt
> > > - * handler validates the interrupt by checking if the architectural =
state
> > > - * is in compliance with the specifications.
> > > - *
> > > - * The test provides command-line options to configure the timer's
> > > - * period (-p), number of vCPUs (-n), and iterations per stage (-i).
> > > - * To stress-test the timer stack even more, an option to migrate th=
e
> > > - * vCPUs across pCPUs (-m), at a particular rate, is also provided.
> > > + * CVAL and TVAL registers.
> > >   *
> > >   * Copyright (c) 2021, Google LLC.
> > >   */
> > >  #define _GNU_SOURCE
> > >
> > > -#include <stdlib.h>
> > > -#include <pthread.h>
> > > -#include <linux/kvm.h>
> > > -#include <linux/sizes.h>
> > > -#include <linux/bitmap.h>
> > > -#include <sys/sysinfo.h>
> > > -
> > > -#include "kvm_util.h"
> > > -#include "processor.h"
> > > -#include "delay.h"
> > >  #include "arch_timer.h"
> > > +#include "delay.h"
> > >  #include "gic.h"
> > > +#include "processor.h"
> > > +#include "timer_test.h"
> > >  #include "vgic.h"
> > >
> > > -#define NR_VCPUS_DEF                 4
> > > -#define NR_TEST_ITERS_DEF            5
> > > -#define TIMER_TEST_PERIOD_MS_DEF     10
> > > -#define TIMER_TEST_ERR_MARGIN_US     100
> > > -#define TIMER_TEST_MIGRATION_FREQ_MS 2
> > > -
> > > -struct test_args {
> > > -     int nr_vcpus;
> > > -     int nr_iter;
> > > -     int timer_period_ms;
> > > -     int migration_freq_ms;
> > > -     struct kvm_arm_counter_offset offset;
> > > -};
> > > -
> > > -static struct test_args test_args =3D {
> > > -     .nr_vcpus =3D NR_VCPUS_DEF,
> > > -     .nr_iter =3D NR_TEST_ITERS_DEF,
> > > -     .timer_period_ms =3D TIMER_TEST_PERIOD_MS_DEF,
> > > -     .migration_freq_ms =3D TIMER_TEST_MIGRATION_FREQ_MS,
> > > -     .offset =3D { .reserved =3D 1 },
> > > -};
> > > -
> > > -#define msecs_to_usecs(msec)         ((msec) * 1000LL)
> > > -
> > > -#define GICD_BASE_GPA                        0x8000000ULL
> > > -#define GICR_BASE_GPA                        0x80A0000ULL
> > > -
> > > -enum guest_stage {
> > > -     GUEST_STAGE_VTIMER_CVAL =3D 1,
> > > -     GUEST_STAGE_VTIMER_TVAL,
> > > -     GUEST_STAGE_PTIMER_CVAL,
> > > -     GUEST_STAGE_PTIMER_TVAL,
> > > -     GUEST_STAGE_MAX,
> > > -};
> > > -
> > > -/* Shared variables between host and guest */
> > > -struct test_vcpu_shared_data {
> > > -     int nr_iter;
> > > -     enum guest_stage guest_stage;
> > > -     uint64_t xcnt;
> > > -};
> > > -
> > > -static struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
> > > -static pthread_t pt_vcpu_run[KVM_MAX_VCPUS];
> > > -static struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
> > > +extern struct test_args test_args;
> > > +extern struct kvm_vcpu *vcpus[];
> > > +extern struct test_vcpu_shared_data vcpu_shared_data[];
> > >
> > >  static int vtimer_irq, ptimer_irq;
> > >
> > > -static unsigned long *vcpu_done_map;
> > > -static pthread_mutex_t vcpu_done_map_lock;
> > > -
> > >  static void
> > >  guest_configure_timer_action(struct test_vcpu_shared_data *shared_da=
ta)
> > >  {
> > > @@ -222,137 +156,6 @@ static void guest_code(void)
> > >       GUEST_DONE();
> > >  }
> > >
> > > -static void *test_vcpu_run(void *arg)
> > > -{
> > > -     unsigned int vcpu_idx =3D (unsigned long)arg;
> > > -     struct ucall uc;
> > > -     struct kvm_vcpu *vcpu =3D vcpus[vcpu_idx];
> > > -     struct kvm_vm *vm =3D vcpu->vm;
> > > -     struct test_vcpu_shared_data *shared_data =3D &vcpu_shared_data=
[vcpu_idx];
> > > -
> > > -     vcpu_run(vcpu);
> > > -
> > > -     /* Currently, any exit from guest is an indication of completio=
n */
> > > -     pthread_mutex_lock(&vcpu_done_map_lock);
> > > -     __set_bit(vcpu_idx, vcpu_done_map);
> > > -     pthread_mutex_unlock(&vcpu_done_map_lock);
> > > -
> > > -     switch (get_ucall(vcpu, &uc)) {
> > > -     case UCALL_SYNC:
> > > -     case UCALL_DONE:
> > > -             break;
> > > -     case UCALL_ABORT:
> > > -             sync_global_from_guest(vm, *shared_data);
> > > -             fprintf(stderr, "Guest assert failed,  vcpu %u; stage; =
%u; iter: %u\n",
> > > -                     vcpu_idx, shared_data->guest_stage, shared_data=
->nr_iter);
> > > -             REPORT_GUEST_ASSERT(uc);
> > > -             break;
> > > -     default:
> > > -             TEST_FAIL("Unexpected guest exit\n");
> > > -     }
> > > -
> > > -     return NULL;
> > > -}
> > > -
> > > -static uint32_t test_get_pcpu(void)
> > > -{
> > > -     uint32_t pcpu;
> > > -     unsigned int nproc_conf;
> > > -     cpu_set_t online_cpuset;
> > > -
> > > -     nproc_conf =3D get_nprocs_conf();
> > > -     sched_getaffinity(0, sizeof(cpu_set_t), &online_cpuset);
> > > -
> > > -     /* Randomly find an available pCPU to place a vCPU on */
> > > -     do {
> > > -             pcpu =3D rand() % nproc_conf;
> > > -     } while (!CPU_ISSET(pcpu, &online_cpuset));
> > > -
> > > -     return pcpu;
> > > -}
> > > -
> > > -static int test_migrate_vcpu(unsigned int vcpu_idx)
> > > -{
> > > -     int ret;
> > > -     cpu_set_t cpuset;
> > > -     uint32_t new_pcpu =3D test_get_pcpu();
> > > -
> > > -     CPU_ZERO(&cpuset);
> > > -     CPU_SET(new_pcpu, &cpuset);
> > > -
> > > -     pr_debug("Migrating vCPU: %u to pCPU: %u\n", vcpu_idx, new_pcpu=
);
> > > -
> > > -     ret =3D pthread_setaffinity_np(pt_vcpu_run[vcpu_idx],
> > > -                                  sizeof(cpuset), &cpuset);
> > > -
> > > -     /* Allow the error where the vCPU thread is already finished */
> > > -     TEST_ASSERT(ret =3D=3D 0 || ret =3D=3D ESRCH,
> > > -                 "Failed to migrate the vCPU:%u to pCPU: %u; ret: %d=
\n",
> > > -                 vcpu_idx, new_pcpu, ret);
> > > -
> > > -     return ret;
> > > -}
> > > -
> > > -static void *test_vcpu_migration(void *arg)
> > > -{
> > > -     unsigned int i, n_done;
> > > -     bool vcpu_done;
> > > -
> > > -     do {
> > > -             usleep(msecs_to_usecs(test_args.migration_freq_ms));
> > > -
> > > -             for (n_done =3D 0, i =3D 0; i < test_args.nr_vcpus; i++=
) {
> > > -                     pthread_mutex_lock(&vcpu_done_map_lock);
> > > -                     vcpu_done =3D test_bit(i, vcpu_done_map);
> > > -                     pthread_mutex_unlock(&vcpu_done_map_lock);
> > > -
> > > -                     if (vcpu_done) {
> > > -                             n_done++;
> > > -                             continue;
> > > -                     }
> > > -
> > > -                     test_migrate_vcpu(i);
> > > -             }
> > > -     } while (test_args.nr_vcpus !=3D n_done);
> > > -
> > > -     return NULL;
> > > -}
> > > -
> > > -static void test_run(struct kvm_vm *vm)
> > > -{
> > > -     pthread_t pt_vcpu_migration;
> > > -     unsigned int i;
> > > -     int ret;
> > > -
> > > -     pthread_mutex_init(&vcpu_done_map_lock, NULL);
> > > -     vcpu_done_map =3D bitmap_zalloc(test_args.nr_vcpus);
> > > -     TEST_ASSERT(vcpu_done_map, "Failed to allocate vcpu done bitmap=
\n");
> > > -
> > > -     for (i =3D 0; i < (unsigned long)test_args.nr_vcpus; i++) {
> > > -             ret =3D pthread_create(&pt_vcpu_run[i], NULL, test_vcpu=
_run,
> > > -                                  (void *)(unsigned long)i);
> > > -             TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n",=
 i);
> > > -     }
> > > -
> > > -     /* Spawn a thread to control the vCPU migrations */
> > > -     if (test_args.migration_freq_ms) {
> > > -             srand(time(NULL));
> > > -
> > > -             ret =3D pthread_create(&pt_vcpu_migration, NULL,
> > > -                                     test_vcpu_migration, NULL);
> > > -             TEST_ASSERT(!ret, "Failed to create the migration pthre=
ad\n");
> > > -     }
> > > -
> > > -
> > > -     for (i =3D 0; i < test_args.nr_vcpus; i++)
> > > -             pthread_join(pt_vcpu_run[i], NULL);
> > > -
> > > -     if (test_args.migration_freq_ms)
> > > -             pthread_join(pt_vcpu_migration, NULL);
> > > -
> > > -     bitmap_free(vcpu_done_map);
> > > -}
> > > -
> > >  static void test_init_timer_irq(struct kvm_vm *vm)
> > >  {
> > >       /* Timer initid should be same for all the vCPUs, so query only=
 vCPU-0 */
> > > @@ -369,7 +172,7 @@ static void test_init_timer_irq(struct kvm_vm *vm=
)
> > >
> > >  static int gic_fd;
> > >
> > > -static struct kvm_vm *test_vm_create(void)
> > > +struct kvm_vm *test_vm_create(void)
> > >  {
> > >       struct kvm_vm *vm;
> > >       unsigned int i;
> > > @@ -400,81 +203,8 @@ static struct kvm_vm *test_vm_create(void)
> > >       return vm;
> > >  }
> > >
> > > -static void test_vm_cleanup(struct kvm_vm *vm)
> > > +void test_vm_cleanup(struct kvm_vm *vm)
> > >  {
> > >       close(gic_fd);
> > >       kvm_vm_free(vm);
> > >  }
> > > -
> > > -static void test_print_help(char *name)
> > > -{
> > > -     pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer=
_period_ms]\n",
> > > -             name);
> > > -     pr_info("\t-n: Number of vCPUs to configure (default: %u; max: =
%u)\n",
> > > -             NR_VCPUS_DEF, KVM_MAX_VCPUS);
> > > -     pr_info("\t-i: Number of iterations per stage (default: %u)\n",
> > > -             NR_TEST_ITERS_DEF);
> > > -     pr_info("\t-p: Periodicity (in ms) of the guest timer (default:=
 %u)\n",
> > > -             TIMER_TEST_PERIOD_MS_DEF);
> > > -     pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to differe=
nt pCPU. 0 to turn off (default: %u)\n",
> > > -             TIMER_TEST_MIGRATION_FREQ_MS);
> > > -     pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n=
");
> > > -     pr_info("\t-h: print this help screen\n");
> > > -}
> > > -
> > > -static bool parse_args(int argc, char *argv[])
> > > -{
> > > -     int opt;
> > > -
> > > -     while ((opt =3D getopt(argc, argv, "hn:i:p:m:o:")) !=3D -1) {
> > > -             switch (opt) {
> > > -             case 'n':
> > > -                     test_args.nr_vcpus =3D atoi_positive("Number of=
 vCPUs", optarg);
> > > -                     if (test_args.nr_vcpus > KVM_MAX_VCPUS) {
> > > -                             pr_info("Max allowed vCPUs: %u\n",
> > > -                                     KVM_MAX_VCPUS);
> > > -                             goto err;
> > > -                     }
> > > -                     break;
> > > -             case 'i':
> > > -                     test_args.nr_iter =3D atoi_positive("Number of =
iterations", optarg);
> > > -                     break;
> > > -             case 'p':
> > > -                     test_args.timer_period_ms =3D atoi_positive("Pe=
riodicity", optarg);
> > > -                     break;
> > > -             case 'm':
> > > -                     test_args.migration_freq_ms =3D atoi_non_negati=
ve("Frequency", optarg);
> > > -                     break;
> > > -             case 'o':
> > > -                     test_args.offset.counter_offset =3D strtol(opta=
rg, NULL, 0);
> > > -                     test_args.offset.reserved =3D 0;
> > > -                     break;
> > > -             case 'h':
> > > -             default:
> > > -                     goto err;
> > > -             }
> > > -     }
> > > -
> > > -     return true;
> > > -
> > > -err:
> > > -     test_print_help(argv[0]);
> > > -     return false;
> > > -}
> > > -
> > > -int main(int argc, char *argv[])
> > > -{
> > > -     struct kvm_vm *vm;
> > > -
> > > -     if (!parse_args(argc, argv))
> > > -             exit(KSFT_SKIP);
> > > -
> > > -     __TEST_REQUIRE(!test_args.migration_freq_ms || get_nprocs() >=
=3D 2,
> > > -                    "At least two physical CPUs needed for vCPU migr=
ation");
> > > -
> > > -     vm =3D test_vm_create();
> > > -     test_run(vm);
> > > -     test_vm_cleanup(vm);
> > > -
> > > -     return 0;
> > > -}
> > > diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing=
/selftests/kvm/arch_timer.c
> > > new file mode 100644
> > > index 000000000000..529024f58c98
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/kvm/arch_timer.c
> > > @@ -0,0 +1,252 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * arch_timer.c - Tests the arch timer IRQ functionality
> > > + *
> > > + * The guest's main thread configures the timer interrupt for and wa=
its
> >
> > It looks like the text was edited to remove the 'stage' references, whi=
ch
> > is fine by me, but the 'for' should have also been removed.
> >
> >
>
> Sure!
>
> > > + * for it to fire, with a timeout equal to the timer period.
> > > + * It asserts that the timeout doesn't exceed the timer period.
> > > + *
> > > + * On the other hand, upon receipt of an interrupt, the guest's inte=
rrupt
> > > + * handler validates the interrupt by checking if the architectural =
state
> > > + * is in compliance with the specifications.
> > > + *
> > > + * The test provides command-line options to configure the timer's
> > > + * period (-p), number of vCPUs (-n), and iterations per stage (-i).
> > > + * To stress-test the timer stack even more, an option to migrate th=
e
> > > + * vCPUs across pCPUs (-m), at a particular rate, is also provided.
> > > + *
> > > + * Copyright (c) 2021, Google LLC.
> > > + */
> > > +
> > > +#define _GNU_SOURCE
> > > +
> > > +#include <stdlib.h>
> > > +#include <pthread.h>
> > > +#include <linux/sizes.h>
> > > +#include <linux/bitmap.h>
> > > +#include <sys/sysinfo.h>
> > > +
> > > +#include "timer_test.h"
> > > +
> > > +struct test_args test_args =3D {
> > > +    .nr_vcpus =3D NR_VCPUS_DEF,
> > > +    .nr_iter =3D NR_TEST_ITERS_DEF,
> > > +    .timer_period_ms =3D TIMER_TEST_PERIOD_MS_DEF,
> > > +    .migration_freq_ms =3D TIMER_TEST_MIGRATION_FREQ_MS,
> > > +#ifdef __aarch64__
> > > +    .offset =3D { .reserved =3D 1 },
> > > +#endif
> >
> > Please run checkpatch, there are spaces instead of tabs in the struct.
> >
>
> Yes, the tabs were changed to spaces while copying. Will change it and
> run checkpatch to catch this kind of error in next version.
>
> > > +};
> > > +
> > > +struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
> > > +struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
> > > +
> > > +static pthread_t pt_vcpu_run[KVM_MAX_VCPUS];
> > > +static unsigned long *vcpu_done_map;
> > > +static pthread_mutex_t vcpu_done_map_lock;
> > > +
> > > +static void *test_vcpu_run(void *arg)
> > > +{
> > > +     unsigned int vcpu_idx =3D (unsigned long)arg;
> > > +     struct ucall uc;
> > > +     struct kvm_vcpu *vcpu =3D vcpus[vcpu_idx];
> > > +     struct kvm_vm *vm =3D vcpu->vm;
> > > +     struct test_vcpu_shared_data *shared_data =3D &vcpu_shared_data=
[vcpu_idx];
> > > +
> > > +     vcpu_run(vcpu);
> > > +
> > > +     /* Currently, any exit from guest is an indication of completio=
n */
> > > +     pthread_mutex_lock(&vcpu_done_map_lock);
> > > +     __set_bit(vcpu_idx, vcpu_done_map);
> > > +     pthread_mutex_unlock(&vcpu_done_map_lock);
> > > +
> > > +     switch (get_ucall(vcpu, &uc)) {
> > > +     case UCALL_SYNC:
> > > +     case UCALL_DONE:
> > > +             break;
> > > +     case UCALL_ABORT:
> > > +             sync_global_from_guest(vm, *shared_data);
> > > +             fprintf(stderr, "Guest assert failed,  vcpu %u; stage; =
%u; iter: %u\n",
> > > +                     vcpu_idx, shared_data->guest_stage, shared_data=
->nr_iter);
> > > +             REPORT_GUEST_ASSERT(uc);
> > > +             break;
> > > +     default:
> > > +             TEST_FAIL("Unexpected guest exit\n");
> > > +     }
> > > +
> > > +     pr_info("PASS(vCPU-%d).\n", vcpu_idx);
> >
> > This is new. I can live with it, but generally we don't want to modify
> > functions while moving them.
> >
>
> Yes, this change was supposed to go with patch 8/8.
>
> > > +
> > > +     return NULL;
> > > +}
> > > +
> > > +static uint32_t test_get_pcpu(void)
> > > +{
> > > +     uint32_t pcpu;
> > > +     unsigned int nproc_conf;
> > > +     cpu_set_t online_cpuset;
> > > +
> > > +     nproc_conf =3D get_nprocs_conf();
> > > +     sched_getaffinity(0, sizeof(cpu_set_t), &online_cpuset);
> > > +
> > > +     /* Randomly find an available pCPU to place a vCPU on */
> > > +     do {
> > > +             pcpu =3D rand() % nproc_conf;
> > > +     } while (!CPU_ISSET(pcpu, &online_cpuset));
> > > +
> > > +     return pcpu;
> > > +}
> > > +
> > > +static int test_migrate_vcpu(unsigned int vcpu_idx)
> > > +{
> > > +     int ret;
> > > +     cpu_set_t cpuset;
> > > +     uint32_t new_pcpu =3D test_get_pcpu();
> > > +
> > > +     CPU_ZERO(&cpuset);
> > > +     CPU_SET(new_pcpu, &cpuset);
> > > +
> > > +     pr_debug("Migrating vCPU: %u to pCPU: %u\n", vcpu_idx, new_pcpu=
);
> > > +
> > > +     ret =3D pthread_setaffinity_np(pt_vcpu_run[vcpu_idx],
> > > +                                  sizeof(cpuset), &cpuset);
> > > +
> > > +     /* Allow the error where the vCPU thread is already finished */
> > > +     TEST_ASSERT(ret =3D=3D 0 || ret =3D=3D ESRCH,
> > > +                 "Failed to migrate the vCPU:%u to pCPU: %u; ret: %d=
\n",
> > > +                 vcpu_idx, new_pcpu, ret);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static void *test_vcpu_migration(void *arg)
> > > +{
> > > +     unsigned int i, n_done;
> > > +     bool vcpu_done;
> > > +
> > > +     do {
> > > +             usleep(msecs_to_usecs(test_args.migration_freq_ms));
> > > +
> > > +             for (n_done =3D 0, i =3D 0; i < test_args.nr_vcpus; i++=
) {
> > > +                     pthread_mutex_lock(&vcpu_done_map_lock);
> > > +                     vcpu_done =3D test_bit(i, vcpu_done_map);
> > > +                     pthread_mutex_unlock(&vcpu_done_map_lock);
> > > +
> > > +                     if (vcpu_done) {
> > > +                             n_done++;
> > > +                             continue;
> > > +                     }
> > > +
> > > +                     test_migrate_vcpu(i);
> > > +             }
> > > +     } while (test_args.nr_vcpus !=3D n_done);
> > > +
> > > +     return NULL;
> > > +}
> > > +
> > > +static void test_run(struct kvm_vm *vm)
> > > +{
> > > +     pthread_t pt_vcpu_migration;
> > > +     unsigned int i;
> > > +     int ret;
> > > +
> > > +     pthread_mutex_init(&vcpu_done_map_lock, NULL);
> > > +     vcpu_done_map =3D bitmap_zalloc(test_args.nr_vcpus);
> > > +     TEST_ASSERT(vcpu_done_map, "Failed to allocate vcpu done bitmap=
\n");
> > > +
> > > +     for (i =3D 0; i < (unsigned long)test_args.nr_vcpus; i++) {
> > > +             ret =3D pthread_create(&pt_vcpu_run[i], NULL, test_vcpu=
_run,
> > > +                                  (void *)(unsigned long)i);
> > > +             TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n",=
 i);
> > > +     }
> > > +
> > > +     /* Spawn a thread to control the vCPU migrations */
> > > +     if (test_args.migration_freq_ms) {
> > > +             srand(time(NULL));
> > > +
> > > +             ret =3D pthread_create(&pt_vcpu_migration, NULL,
> > > +                                     test_vcpu_migration, NULL);
> > > +             TEST_ASSERT(!ret, "Failed to create the migration pthre=
ad\n");
> > > +     }
> > > +
> > > +
> > > +     for (i =3D 0; i < test_args.nr_vcpus; i++)
> > > +             pthread_join(pt_vcpu_run[i], NULL);
> > > +
> > > +     if (test_args.migration_freq_ms)
> > > +             pthread_join(pt_vcpu_migration, NULL);
> > > +
> > > +     bitmap_free(vcpu_done_map);
> > > +}
> > > +
> > > +static void test_print_help(char *name)
> > > +{
> > > +     pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer=
_period_ms]\n",
> > > +             name);
> > > +     pr_info("\t-n: Number of vCPUs to configure (default: %u; max: =
%u)\n",
> > > +             NR_VCPUS_DEF, KVM_MAX_VCPUS);
> > > +     pr_info("\t-i: Number of iterations per stage (default: %u)\n",
> > > +             NR_TEST_ITERS_DEF);
> > > +     pr_info("\t-p: Periodicity (in ms) of the guest timer (default:=
 %u)\n",
> > > +             TIMER_TEST_PERIOD_MS_DEF);
> > > +     pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to differe=
nt pCPU. 0 to turn off (default: %u)\n",
> > > +             TIMER_TEST_MIGRATION_FREQ_MS);
> > > +     pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n=
");
> > > +     pr_info("\t-h: print this help screen\n");
> > > +}
> > > +
> > > +static bool parse_args(int argc, char *argv[])
> > > +{
> > > +     int opt;
> > > +
> > > +     while ((opt =3D getopt(argc, argv, "hn:i:p:m:o:")) !=3D -1) {
> > > +             switch (opt) {
> > > +             case 'n':
> > > +                     test_args.nr_vcpus =3D atoi_positive("Number of=
 vCPUs", optarg);
> > > +                     if (test_args.nr_vcpus > KVM_MAX_VCPUS) {
> > > +                             pr_info("Max allowed vCPUs: %u\n",
> > > +                                     KVM_MAX_VCPUS);
> > > +                             goto err;
> > > +                     }
> > > +                     break;
> > > +             case 'i':
> > > +                     test_args.nr_iter =3D atoi_positive("Number of =
iterations", optarg);
> > > +                     break;
> > > +             case 'p':
> > > +                     test_args.timer_period_ms =3D atoi_positive("Pe=
riodicity", optarg);
> > > +                     break;
> > > +             case 'm':
> > > +                     test_args.migration_freq_ms =3D atoi_non_negati=
ve("Frequency", optarg);
> > > +                     break;
> > > +             case 'o':
> > > +                     test_args.offset.counter_offset =3D strtol(opta=
rg, NULL, 0);
> > > +                     test_args.offset.reserved =3D 0;
> > > +                     break;
> > > +             case 'h':
> > > +             default:
> > > +                     goto err;
> > > +             }
> > > +     }
> > > +
> > > +     return true;
> > > +
> > > +err:
> > > +     test_print_help(argv[0]);
> > > +     return false;
> > > +}
> > > +
> > > +int main(int argc, char *argv[])
> > > +{
> > > +     struct kvm_vm *vm;
> > > +
> > > +     if (!parse_args(argc, argv))
> > > +             exit(KSFT_SKIP);
> > > +
> > > +     __TEST_REQUIRE(!test_args.migration_freq_ms || get_nprocs() >=
=3D 2,
> > > +                    "At least two physical CPUs needed for vCPU migr=
ation");
> > > +
> > > +     vm =3D test_vm_create();
> > > +     test_run(vm);
> > > +     test_vm_cleanup(vm);
> > > +
> > > +     return 0;
> > > +}
> > > diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools=
/testing/selftests/kvm/include/timer_test.h
> > > new file mode 100644
> > > index 000000000000..109e4d635627
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/kvm/include/timer_test.h
> > > @@ -0,0 +1,52 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * tools/testing/selftests/kvm/include/timer_test.h
> > > + *
> > > + * Copyright (C) 2018, Google LLC
> > > + */
> > > +
> > > +#ifndef SELFTEST_KVM_TIMER_TEST_H
> > > +#define SELFTEST_KVM_TIMER_TEST_H
> > > +
> > > +#include "kvm_util.h"
> > > +
> > > +#define NR_VCPUS_DEF            4
> > > +#define NR_TEST_ITERS_DEF       5
> > > +#define TIMER_TEST_PERIOD_MS_DEF    10
> > > +#define TIMER_TEST_ERR_MARGIN_US    100
> > > +#define TIMER_TEST_MIGRATION_FREQ_MS    2
> > > +
> > > +#define msecs_to_usecs(msec)    ((msec) * 1000LL)
> >
> > I'd move the above to include/test_util.h
> >
>
> Yes, msecs_to_usecs() macro should be a common API for all the tests.
>
> > > +
> > > +#define GICD_BASE_GPA    0x8000000ULL
> > > +#define GICR_BASE_GPA    0x80A0000ULL
> >
> > These defines belong in aarch64/arch_timer.c
> >
>
> These 2 defines were also defined in other test cases, shall we move them
> to an aarch64 specific header file? Maybe
> tools/testing/selftests/kvm/include/aarch64/gic.h?
>
> > > +
> > > +enum guest_stage {
> > > +     GUEST_STAGE_VTIMER_CVAL=3D1,
> > > +     GUEST_STAGE_VTIMER_TVAL,
> > > +     GUEST_STAGE_PTIMER_CVAL,
> > > +     GUEST_STAGE_PTIMER_TVAL,
> > > +     GUEST_STAGE_MAX,
> > > +};
> >
> > This enum also belongs in aarch64/arch_timer.c
> >
>
> Yes, it should be in aarch64/arch_timer.c
>

After moving the above enum definition to aarch64/arch_timer.c, the
below errors was reported
while compiling kvm/arch_timer.o

include/timer_test.h:37:26: error: field =E2=80=98guest_stage=E2=80=99 has =
incomplete type
   37 |         enum guest_stage guest_stage;
        |                                        ^~~~~~~~~~~

Since kvm/arch_timer.c was independent of kvm/aarch64/arch_timer.c
during OBJ compiling,
I think it may be not possible to move the enum definition to
aarch64/arch_timer.c

If we keep the definition in this header file, we can enclose it with
#ifdef __aarch64__ for aarch64 only.

> > > +
> > > +/* Timer test cmdline parameters */
> > > +struct test_args
> > > +{
> > > +     int nr_vcpus;
> > > +     int nr_iter;
> > > +     int timer_period_ms;
> > > +     int migration_freq_ms;
> > > +     struct kvm_arm_counter_offset offset;
> > > +};
> > > +
> > > +/* Shared variables between host and guest */
> > > +struct test_vcpu_shared_data {
> > > +     int nr_iter;
> > > +     enum guest_stage guest_stage;
> > > +     uint64_t xcnt;
> > > +};
> > > +
> > > +struct kvm_vm* test_vm_create(void);
> >
> > Move * next to function name.
> >
>
> Sure, thanks!
>
> > > +void test_vm_cleanup(struct kvm_vm *vm);
> > > +
> > > +#endif /* SELFTEST_KVM_TIMER_TEST_H */
> > > --
> > > 2.34.1
> > >
> >
> > Thanks,
> > drew
