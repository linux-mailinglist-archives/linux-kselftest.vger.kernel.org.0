Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187C4713291
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 May 2023 06:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjE0EkO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 May 2023 00:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE0EkN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 May 2023 00:40:13 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C15116;
        Fri, 26 May 2023 21:40:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53474b0c494so1279338a12.3;
        Fri, 26 May 2023 21:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685162409; x=1687754409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4Ww4pR8G2utT3K2bbW8xaj4QmJ3Wt/jZZqzofUtcWE=;
        b=A74DL8Q4DBzF0Z6FcZYQrb2CQEYG7hR8PFMC4iSAM39qaoPweJZR6KhnTz6zkpelnT
         mJQl7gI/jFAxLVOJvvrYB4W8v3m5h4D/KJ7ddEKs6u+M88J/5qXyGJWNj9hsOzKY0Nby
         1w2nyIpWUiq+YzmF0GQh2+gcnSOGmS3PYcD9aFmwr7jQ8WJrbKJedxJIjdYj4qpfw7bU
         bigzvTp8pFZ622H1sqq033M+R06K76qJFvY/SHg60x4829d6uJFDw/ALpVI1NbnOpySk
         C2Jv6kCYqhrhDtl8GvEm6kRdnebjfsRp2ar38iSZPJuIJV1duQNTz1JgZDhFoSd7GOTI
         OxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685162409; x=1687754409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4Ww4pR8G2utT3K2bbW8xaj4QmJ3Wt/jZZqzofUtcWE=;
        b=eEmhLstcu3p3jyOKxp+ZvPZglqfO7h5Pu8V+hfxhpSNReYhEbGYspnlHvX9viicsG0
         1CWdWZi6ONyOQrOAcVXN7zZ4F2hLRvi1IHLtJuACW8jcn4lgdgM3+4QdFilJWUikbMMG
         xTr3ZLuIKZBPkqx+aGJs9jK5RvLgUg3gJj+IXxKix845c/DczWAIwWVZykGt7aGXEpYJ
         CCuH9bmzdOt4w3jawTNK307ei2/J2Rnvx1Gui1vuc3CkFDeMfX611wOOzFVKcZ5vE4B7
         LNEeuZwOfMQPUpKBsupEekSSxF1S886v+iWXug5go2zvPjjXrv/rG3xgVFThjHo5Z4OA
         gOxg==
X-Gm-Message-State: AC+VfDzMqh16mzjsSKJSaQvYm0jQVK8o2TcsFmJxOqcDcevxAP5l3Vxc
        Pp94nbEq3S1LFKw9NvQZSfnT2v5vzLraARRBkWM=
X-Google-Smtp-Source: ACHHUZ5yZoB0X7s4N0O+zQBiLFv/r01hx/wD+ndF/jf1FxaTKEz5W0ZlXm3ZPW98liLtb73XTlLmOgAgKDuYMdW5f3I=
X-Received: by 2002:a17:902:b18f:b0:1af:babd:7b84 with SMTP id
 s15-20020a170902b18f00b001afbabd7b84mr3697062plr.41.1685162408839; Fri, 26
 May 2023 21:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684999824.git.haibo1.xu@intel.com> <da390e6200e838fce320a2a43b2f87951b4e0bbb.1684999824.git.haibo1.xu@intel.com>
 <20230525-2bab5376987792eab73507ac@orel>
In-Reply-To: <20230525-2bab5376987792eab73507ac@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Sat, 27 May 2023 12:39:57 +0800
Message-ID: <CAJve8o=5ji5D-S8k+GaGd7sH7KXNWxDaWhD3jyxtHizKSMtjbA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] KVM: riscv: selftests: Add get-reg-list test
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>, maz@kernel.org,
        oliver.upton@linux.dev, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 26, 2023 at 1:18=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, May 25, 2023 at 03:38:35PM +0800, Haibo Xu wrote:
> > get-reg-list test is used to check for KVM registers regressions
> > during VM migration which happens when destination host kernel
> > missing registers that the source host kernel has. The blessed
> > list registers was created by running on v6.4-rc2.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/Makefile          |   3 +
> >  tools/testing/selftests/kvm/get-reg-list.c    |  35 +-
> >  .../selftests/kvm/include/riscv/processor.h   |   3 +
> >  .../selftests/kvm/riscv/get-reg-list.c        | 539 ++++++++++++++++++
> >  4 files changed, 579 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/kvm/riscv/get-reg-list.c
> >
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selft=
ests/kvm/Makefile
> > index 921d5db0f72b..4194b33ff77e 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -13,6 +13,8 @@ else ifeq ($(ARCH),arm64)
> >       ARCH_DIR :=3D aarch64
> >  else ifeq ($(ARCH),s390)
> >       ARCH_DIR :=3D s390x
> > +else ifeq ($(ARCH),riscv)
> > +     ARCH_DIR :=3D riscv
>
> Why is this necessary? The else below already does the same thing, no?
>

Good catch! This is not necessary. Will remove it in v3.

> >  else
> >       ARCH_DIR :=3D $(ARCH)
> >  endif
> > @@ -177,6 +179,7 @@ TEST_GEN_PROGS_riscv +=3D kvm_create_max_vcpus
> >  TEST_GEN_PROGS_riscv +=3D kvm_page_table_test
> >  TEST_GEN_PROGS_riscv +=3D set_memory_region_test
> >  TEST_GEN_PROGS_riscv +=3D kvm_binary_stats_test
> > +TEST_GEN_PROGS_riscv +=3D get-reg-list
>
> Please add this in the list in alphabetic order.
>

Sure.

> >
> >  SPLIT_TESTS +=3D get-reg-list
> >
> > diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing=
/selftests/kvm/get-reg-list.c
> > index ebd6b580b33b..b5821ada2dae 100644
> > --- a/tools/testing/selftests/kvm/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/get-reg-list.c
> > @@ -150,9 +150,42 @@ static struct kvm_vcpu *vcpu_config_get_vcpu(struc=
t vcpu_reg_list *c, struct kvm
> >       return vcpu;
> >  }
> >  #else
> > +static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, long cap)
> > +{
> > +     int ret;
> > +     unsigned long value;
> > +
> > +     ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(cap), &value);
> > +     if (ret) {
> > +             printf("Failed to get cap %ld", cap);
> > +             return false;
> > +     }
> > +
> > +     return !!value;
> > +}
> > +
> > +static void check_supported(struct kvm_vcpu *vcpu, struct vcpu_reg_lis=
t *c)
>
> Taking my feedback on the other patch this is now named finalize_vcpu()
> and...
>

Sure.

> > +{
> > +     struct vcpu_reg_sublist *s;
> > +
> > +     for_each_sublist(c, s) {
> > +             if (!s->capability)
> > +                     continue;
> > +
> > +             __TEST_REQUIRE(vcpu_has_ext(vcpu, s->capability),
>
> ...instead of 'capability' this is 'extension' and...
>

Will reuse the 'feature' member.

> > +                            "%s: %s not available, skipping tests\n",
> > +                            config_name(c), s->name);
> > +     }
> > +}
> > +
> >  static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, =
struct kvm_vm *vm)
> >  {
> > -     return __vm_vcpu_add(vm, 0);
> > +     struct kvm_vcpu *vcpu;
> > +
> > +     vcpu =3D __vm_vcpu_add(vm, 0);
> > +     check_supported(vcpu, c);
> > +
> > +     return vcpu;
>
> ...this hunk can be dropped.
>

Sure.

> >  }
> >  #endif
> >
> > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/to=
ols/testing/selftests/kvm/include/riscv/processor.h
> > index d00d213c3805..5b62a3d2aa9b 100644
> > --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > @@ -38,6 +38,9 @@ static inline uint64_t __kvm_reg_id(uint64_t type, ui=
nt64_t idx,
> >                                            KVM_REG_RISCV_TIMER_REG(name=
), \
> >                                            KVM_REG_SIZE_U64)
> >
> > +#define RISCV_ISA_EXT_REG(idx)       __kvm_reg_id(KVM_REG_RISCV_ISA_EX=
T, \
> > +                                          idx, KVM_REG_SIZE_ULONG)
> > +
> >  /* L3 index Bit[47:39] */
> >  #define PGTBL_L3_INDEX_MASK                  0x0000FF8000000000ULL
> >  #define PGTBL_L3_INDEX_SHIFT                 39
> > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/t=
esting/selftests/kvm/riscv/get-reg-list.c
> > new file mode 100644
> > index 000000000000..511dfe8d5a38
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > @@ -0,0 +1,539 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Check for KVM_GET_REG_LIST regressions.
> > + *
> > + * Copyright (C) 2020, Red Hat, Inc.
> > + * Copyright (c) 2023 Intel Corporation
> > + *
> > + * The test was port from the get-reg-list.c on aarch64.
>
> You can probably drop this 'ported' comment now that this file is only
> adding riscv specific code.
>

Sure.

> > + */
> > +#include <stdio.h>
> > +#include "kvm_util.h"
> > +#include "test_util.h"
> > +#include "processor.h"
> > +
> > +#define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK)
> > +
> > +static const char *config_id_to_str(__u64 id)
> > +{
> > +     /* reg_off is the offset into struct kvm_riscv_config */
> > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_CONFIG);
> > +
> > +     switch (reg_off) {
> > +     case KVM_REG_RISCV_CONFIG_REG(isa):
> > +             return "KVM_REG_RISCV_CONFIG_REG(isa)";
> > +     case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
> > +             return "KVM_REG_RISCV_CONFIG_REG(zicbom_block_size)";
> > +     case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
> > +             return "KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)";
> > +     case KVM_REG_RISCV_CONFIG_REG(mvendorid):
> > +             return "KVM_REG_RISCV_CONFIG_REG(mvendorid)";
> > +     case KVM_REG_RISCV_CONFIG_REG(marchid):
> > +             return "KVM_REG_RISCV_CONFIG_REG(marchid)";
> > +     case KVM_REG_RISCV_CONFIG_REG(mimpid):
> > +             return "KVM_REG_RISCV_CONFIG_REG(mimpid)";
> > +     }
> > +
> > +     /*
> > +      * Config regs would grow regularly with new pseudo reg added, so
> > +      * just show raw id to indicate a new pseudo config reg.
> > +      */
> > +     return strdup_printf("KVM_REG_RISCV_CONFIG_REG(%lld)/* UNKNOWN */=
", reg_off);
>                                                             ^ I'd add a
>                                            space here before the /*
>                                            And same comment for the other
>                                            UNKNOWNs below.

Sure.

> > +}
> > +
> > +static const char *core_id_to_str(const char *prefix, __u64 id)
> > +{
> > +     /* reg_off is the offset into struct kvm_riscv_core */
> > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_CORE);
> > +
> > +     switch (reg_off) {
> > +     case KVM_REG_RISCV_CORE_REG(regs.pc):
> > +             return "KVM_REG_RISCV_CORE_REG(regs.pc)";
> > +     case KVM_REG_RISCV_CORE_REG(regs.ra) ...
> > +          KVM_REG_RISCV_CORE_REG(regs.t6):
> > +             return strdup_printf("KVM_REG_RISCV_CORE_REG(regs.regs[%l=
ld])", reg_off);
> > +     case KVM_REG_RISCV_CORE_REG(mode):
> > +             return "KVM_REG_RISCV_CORE_REG(mode)";
> > +     }
> > +
> > +     TEST_FAIL("%s: Unknown core reg id: 0x%llx", prefix, id);
> > +     return NULL;
> > +}
> > +
> > +#define RISCV_CSR_GENERAL(csr) \
> > +     "KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(" #csr ")"
> > +#define RISCV_CSR_AIA(csr) \
> > +     "KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_REG(" #csr ")"
> > +
> > +static const char *general_csr_id_to_str(__u64 reg_off)
> > +{
> > +     /* reg_off is the offset into struct kvm_riscv_csr */
> > +     switch (reg_off) {
> > +     case KVM_REG_RISCV_CSR_REG(sstatus):
> > +             return RISCV_CSR_GENERAL(sstatus);
> > +     case KVM_REG_RISCV_CSR_REG(sie):
> > +             return RISCV_CSR_GENERAL(sie);
> > +     case KVM_REG_RISCV_CSR_REG(stvec):
> > +             return RISCV_CSR_GENERAL(stvec);
> > +     case KVM_REG_RISCV_CSR_REG(sscratch):
> > +             return RISCV_CSR_GENERAL(sscratch);
> > +     case KVM_REG_RISCV_CSR_REG(sepc):
> > +             return RISCV_CSR_GENERAL(sepc);
> > +     case KVM_REG_RISCV_CSR_REG(scause):
> > +             return RISCV_CSR_GENERAL(scause);
> > +     case KVM_REG_RISCV_CSR_REG(stval):
> > +             return RISCV_CSR_GENERAL(stval);
> > +     case KVM_REG_RISCV_CSR_REG(sip):
> > +             return RISCV_CSR_GENERAL(sip);
> > +     case KVM_REG_RISCV_CSR_REG(satp):
> > +             return RISCV_CSR_GENERAL(satp);
> > +     case KVM_REG_RISCV_CSR_REG(scounteren):
> > +             return RISCV_CSR_GENERAL(scounteren);
> > +     }
> > +
> > +     TEST_FAIL("Unknown general csr reg: 0x%llx", reg_off);
> > +     return NULL;
> > +}
> > +
> > +static const char *aia_csr_id_to_str(__u64 reg_off)
> > +{
> > +     /* reg_off is the offset into struct kvm_riscv_aia_csr */
> > +     switch (reg_off) {
> > +     case KVM_REG_RISCV_CSR_AIA_REG(siselect):
> > +             return RISCV_CSR_AIA(siselect);
> > +     case KVM_REG_RISCV_CSR_AIA_REG(iprio1):
> > +             return RISCV_CSR_AIA(iprio1);
> > +     case KVM_REG_RISCV_CSR_AIA_REG(iprio2):
> > +             return RISCV_CSR_AIA(iprio2);
> > +     case KVM_REG_RISCV_CSR_AIA_REG(sieh):
> > +             return RISCV_CSR_AIA(sieh);
> > +     case KVM_REG_RISCV_CSR_AIA_REG(siph):
> > +             return RISCV_CSR_AIA(siph);
> > +     case KVM_REG_RISCV_CSR_AIA_REG(iprio1h):
> > +             return RISCV_CSR_AIA(iprio1h);
> > +     case KVM_REG_RISCV_CSR_AIA_REG(iprio2h):
> > +             return RISCV_CSR_AIA(iprio2h);
> > +     }
> > +
> > +     TEST_FAIL("Unknown aia csr reg: 0x%llx", reg_off);
> > +     return NULL;
> > +}
> > +
> > +static const char *csr_id_to_str(const char *prefix, __u64 id)
> > +{
> > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_CSR);
> > +     __u64 reg_subtype =3D reg_off & KVM_REG_RISCV_SUBTYPE_MASK;
> > +
> > +     reg_off &=3D ~KVM_REG_RISCV_SUBTYPE_MASK;
> > +
> > +     switch (reg_subtype) {
> > +     case KVM_REG_RISCV_CSR_GENERAL:
> > +             return general_csr_id_to_str(reg_off);
> > +     case KVM_REG_RISCV_CSR_AIA:
> > +             return aia_csr_id_to_str(reg_off);
> > +     }
> > +
> > +     TEST_FAIL("%s: Unknown csr subtype: 0x%llx", prefix, reg_subtype)=
;
> > +     return NULL;
> > +}
> > +
> > +static const char *timer_id_to_str(const char *prefix, __u64 id)
> > +{
> > +     /* reg_off is the offset into struct kvm_riscv_timer */
> > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_TIMER);
> > +
> > +     switch (reg_off) {
> > +     case KVM_REG_RISCV_TIMER_REG(frequency):
> > +             return "KVM_REG_RISCV_TIMER_REG(frequency)";
> > +     case KVM_REG_RISCV_TIMER_REG(time):
> > +             return "KVM_REG_RISCV_TIMER_REG(time)";
> > +     case KVM_REG_RISCV_TIMER_REG(compare):
> > +             return "KVM_REG_RISCV_TIMER_REG(compare)";
> > +     case KVM_REG_RISCV_TIMER_REG(state):
> > +             return "KVM_REG_RISCV_TIMER_REG(state)";
> > +     }
> > +
> > +     TEST_FAIL("%s: Unknown timer reg id: 0x%llx", prefix, id);
> > +     return NULL;
> > +}
> > +
> > +static const char *fp_f_id_to_str(const char *prefix, __u64 id)
> > +{
> > +     /* reg_off is the offset into struct __riscv_f_ext_state */
> > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_FP_F);
> > +
> > +     switch (reg_off) {
> > +     case KVM_REG_RISCV_FP_F_REG(f[0]) ...
> > +          KVM_REG_RISCV_FP_F_REG(f[31]):
> > +             return strdup_printf("KVM_REG_RISCV_FP_F_REG(f[%lld])", r=
eg_off);
> > +     case KVM_REG_RISCV_FP_F_REG(fcsr):
> > +             return "KVM_REG_RISCV_FP_F_REG(fcsr)";
> > +     }
> > +
> > +     TEST_FAIL("%s: Unknown fp_f reg id: 0x%llx", prefix, id);
> > +     return NULL;
> > +}
> > +
> > +static const char *fp_d_id_to_str(const char *prefix, __u64 id)
> > +{
> > +     /* reg_off is the offset into struct __riscv_d_ext_state */
> > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_FP_D);
> > +
> > +     switch (reg_off) {
> > +     case KVM_REG_RISCV_FP_D_REG(f[0]) ...
> > +          KVM_REG_RISCV_FP_D_REG(f[31]):
> > +             return strdup_printf("KVM_REG_RISCV_FP_D_REG(f[%lld])", r=
eg_off);
> > +     case KVM_REG_RISCV_FP_D_REG(fcsr):
> > +             return "KVM_REG_RISCV_FP_D_REG(fcsr)";
> > +     }
> > +
> > +     TEST_FAIL("%s: Unknown fp_d reg id: 0x%llx", prefix, id);
> > +     return NULL;
> > +}
> > +
> > +static const char *isa_ext_id_to_str(__u64 id)
> > +{
> > +     /* reg_off is the offset into unsigned long kvm_isa_ext_arr[] */
> > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_ISA_EXT);
> > +
> > +     static const char * const kvm_isa_ext_reg_name[] =3D {
> > +             "KVM_RISCV_ISA_EXT_A",
> > +             "KVM_RISCV_ISA_EXT_C",
> > +             "KVM_RISCV_ISA_EXT_D",
> > +             "KVM_RISCV_ISA_EXT_F",
> > +             "KVM_RISCV_ISA_EXT_H",
> > +             "KVM_RISCV_ISA_EXT_I",
> > +             "KVM_RISCV_ISA_EXT_M",
> > +             "KVM_RISCV_ISA_EXT_SVPBMT",
> > +             "KVM_RISCV_ISA_EXT_SSTC",
> > +             "KVM_RISCV_ISA_EXT_SVINVAL",
> > +             "KVM_RISCV_ISA_EXT_ZIHINTPAUSE",
> > +             "KVM_RISCV_ISA_EXT_ZICBOM",
> > +             "KVM_RISCV_ISA_EXT_ZICBOZ",
> > +             "KVM_RISCV_ISA_EXT_ZBB",
> > +             "KVM_RISCV_ISA_EXT_SSAIA",
> > +     };
> > +
> > +     if (reg_off >=3D ARRAY_SIZE(kvm_isa_ext_reg_name)) {
> > +             /*
> > +              * isa_ext regs would grow regularly with new isa extensi=
on added, so
> > +              * just show "reg" to indicate a new extension.
> > +              */
> > +             return strdup_printf("%lld/* UNKNOWN */", reg_off);
> > +     }
> > +
> > +     return kvm_isa_ext_reg_name[reg_off];
> > +}
> > +
> > +static const char *sbi_ext_single_id_to_str(__u64 reg_off)
> > +{
> > +     /* reg_off is KVM_RISCV_SBI_EXT_ID */
> > +     static const char * const kvm_sbi_ext_reg_name[] =3D {
> > +             "KVM_RISCV_SBI_EXT_V01",
> > +             "KVM_RISCV_SBI_EXT_TIME",
> > +             "KVM_RISCV_SBI_EXT_IPI",
> > +             "KVM_RISCV_SBI_EXT_RFENCE",
> > +             "KVM_RISCV_SBI_EXT_SRST",
> > +             "KVM_RISCV_SBI_EXT_HSM",
> > +             "KVM_RISCV_SBI_EXT_PMU",
> > +             "KVM_RISCV_SBI_EXT_EXPERIMENTAL",
> > +             "KVM_RISCV_SBI_EXT_VENDOR",
> > +     };
> > +
> > +     if (reg_off >=3D ARRAY_SIZE(kvm_sbi_ext_reg_name)) {
> > +             /*
> > +              * sbi_ext regs would grow regularly with new sbi extensi=
on added, so
> > +              * just show "reg" to indicate a new extension.
> > +              */
> > +             return strdup_printf("%lld/* UNKNOWN */", reg_off);
>
> This should include KVM_REG_RISCV_SBI_SINGLE
>

Sure.

> > +     }
> > +
> > +     return kvm_sbi_ext_reg_name[reg_off];
>
> This should also include KVM_REG_RISCV_SBI_SINGLE
>

Sure.

> > +}
> > +
> > +static const char *sbi_ext_multi_id_to_str(__u64 reg_subtype, __u64 re=
g_off)
> > +{
> > +     if (reg_off > KVM_REG_RISCV_SBI_MULTI_REG_LAST) {
> > +             /*
> > +              * sbi_ext regs would grow regularly with new sbi extensi=
on added, so
> > +              * just show "reg" to indicate a new extension.
> > +              */
> > +             return strdup_printf("%lld/* UNKNOWN */", reg_off);
> > +     }
> > +
> > +     switch (reg_subtype) {
> > +     case KVM_REG_RISCV_SBI_MULTI_EN:
> > +             return strdup_printf("KVM_REG_RISCV_SBI_MULTI_EN | %lld",=
 reg_off);
> > +     case KVM_REG_RISCV_SBI_MULTI_DIS:
> > +             return strdup_printf("KVM_REG_RISCV_SBI_MULTI_DIS | %lld"=
, reg_off);
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +static const char *sbi_ext_id_to_str(const char *prefix, __u64 id)
> > +{
> > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_SBI_EXT);
> > +     __u64 reg_subtype =3D reg_off & KVM_REG_RISCV_SUBTYPE_MASK;
> > +
> > +     reg_off &=3D ~KVM_REG_RISCV_SUBTYPE_MASK;
> > +
> > +     switch (reg_subtype) {
> > +     case KVM_REG_RISCV_SBI_SINGLE:
> > +             return sbi_ext_single_id_to_str(reg_off);
> > +     case KVM_REG_RISCV_SBI_MULTI_EN:
> > +     case KVM_REG_RISCV_SBI_MULTI_DIS:
> > +             return sbi_ext_multi_id_to_str(reg_subtype, reg_off);
> > +     }
> > +
> > +     TEST_FAIL("%s: Unknown sbi ext subtype: 0x%llx", prefix, reg_subt=
ype);
> > +     return NULL;
> > +}
> > +
> > +void print_reg(const char *prefix, __u64 id)
> > +{
> > +     const char *reg_size =3D NULL;
> > +
> > +     TEST_ASSERT((id & KVM_REG_ARCH_MASK) =3D=3D KVM_REG_RISCV,
> > +                 "%s: KVM_REG_RISCV missing in reg id: 0x%llx", prefix=
, id);
> > +
> > +     switch (id & KVM_REG_SIZE_MASK) {
> > +     case KVM_REG_SIZE_U32:
> > +             reg_size =3D "KVM_REG_SIZE_U32";
> > +             break;
> > +     case KVM_REG_SIZE_U64:
> > +             reg_size =3D "KVM_REG_SIZE_U64";
> > +             break;
> > +     case KVM_REG_SIZE_U128:
> > +             reg_size =3D "KVM_REG_SIZE_U128";
> > +             break;
> > +     default:
> > +             TEST_FAIL("%s: Unexpected reg size: 0x%llx in reg id: 0x%=
llx",
> > +                       prefix, (id & KVM_REG_SIZE_MASK) >> KVM_REG_SIZ=
E_SHIFT, id);
> > +     }
> > +
> > +     switch (id & KVM_REG_RISCV_TYPE_MASK) {
> > +     case KVM_REG_RISCV_CONFIG:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CONFIG | %s,=
\n",
> > +                             reg_size, config_id_to_str(id));
> > +             break;
> > +     case KVM_REG_RISCV_CORE:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CORE | %s,\n=
",
> > +                             reg_size, core_id_to_str(prefix, id));
> > +             break;
> > +     case KVM_REG_RISCV_CSR:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CSR | %s,\n"=
,
> > +                             reg_size, csr_id_to_str(prefix, id));
> > +             break;
> > +     case KVM_REG_RISCV_TIMER:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_TIMER | %s,\=
n",
> > +                             reg_size, timer_id_to_str(prefix, id));
> > +             break;
> > +     case KVM_REG_RISCV_FP_F:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_F | %s,\n=
",
> > +                             reg_size, fp_f_id_to_str(prefix, id));
> > +             break;
> > +     case KVM_REG_RISCV_FP_D:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_D | %s,\n=
",
> > +                             reg_size, fp_d_id_to_str(prefix, id));
> > +             break;
> > +     case KVM_REG_RISCV_ISA_EXT:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_ISA_EXT | %s=
,\n",
> > +                             reg_size, isa_ext_id_to_str(id));
> > +             break;
> > +     case KVM_REG_RISCV_SBI_EXT:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_SBI_EXT | %s=
,\n",
> > +                             reg_size, sbi_ext_id_to_str(prefix, id));
> > +             break;
> > +     default:
> > +             TEST_FAIL("%s: Unexpected reg type: 0x%llx in reg id: 0x%=
llx", prefix,
> > +                             (id & KVM_REG_RISCV_TYPE_MASK) >> KVM_REG=
_RISCV_TYPE_SHIFT, id);
> > +     }
> > +}
> > +
> > +/*
> > + * The current blessed list was primed with the output of kernel versi=
on
> > + * v6.4-rc2 and then later updated with new registers.
> > + */
> > +static __u64 base_regs[] =3D {
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG |
> > +                                     KVM_REG_RISCV_CONFIG_REG(isa),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG |
> > +                                     KVM_REG_RISCV_CONFIG_REG(mvendori=
d),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG |
> > +                                     KVM_REG_RISCV_CONFIG_REG(marchid)=
,
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG |
> > +                                     KVM_REG_RISCV_CONFIG_REG(mimpid),
>
> No need to wrap these lines. It looks better to go long. And the output o=
f
> print_reg() doesn't wrap and this should just be a copy+paste of that. Bu=
t
> I see print_reg() output wasn't used to generate these lists since...
>

Just want to fix some warning from the checkpatch script. Will align
the print_reg() output with it in v3.

> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.pc),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.ra),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.sp),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.gp),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.tp),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.t0),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.t1),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.t2),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.s0),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.s1),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.a0),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.a1),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.a2),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.a3),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.a4),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.a5),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.a6),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.a7),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.s2),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.s3),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.s4),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.s5),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.s6),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.s7),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.s8),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.s9),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.s10),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.s11),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.t3),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.t4),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.t5),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(regs.t6),
>
> ...all the above would just be indices rather than named registers. I
> guess that's better for these registers.
>

You mean to show it as KVM_REG_RISCV_CORE_REG(regs.regs[0]) ...
KVM_REG_RISCV_CORE_REG(regs.regs[31])?

> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_R=
ISCV_CORE_REG(mode),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RI=
SCV_CSR_REG(sstatus),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RI=
SCV_CSR_REG(sie),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RI=
SCV_CSR_REG(stvec),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RI=
SCV_CSR_REG(sscratch),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RI=
SCV_CSR_REG(sepc),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RI=
SCV_CSR_REG(scause),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RI=
SCV_CSR_REG(stval),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RI=
SCV_CSR_REG(sip),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RI=
SCV_CSR_REG(satp),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RI=
SCV_CSR_REG(scounteren),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_=
RISCV_TIMER_REG(frequency),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_=
RISCV_TIMER_REG(time),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_=
RISCV_TIMER_REG(compare),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_=
RISCV_TIMER_REG(state),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_A,
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_C,
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_D,
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_F,
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_H,
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_I,
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_M,
>
> I think all the above should have the size KVM_REG_SIZE_ULONG. Please als=
o
> test with a 32-bit host.
>

Yes, it should be ULONG. Will test with a riscv32 machine.

> > +};
> > +
> > +/*
> > + * The rejects_set list registers that should skip set test.
> > + *  - KVM_REG_RISCV_TIMER_REG(state): set would fail if it was not ini=
tialized properly.
> > + *  - KVM_REG_RISCV_TIMER_REG(frequency): set not supported
> > + *  - KVM_REG_RISCV_CONFIG_REG(zicbom_block_size): set not supported
> > + *  - KVM_REG_RISCV_CONFIG_REG(zicboz_block_size): set not supported
> > + *  - KVM_RISCV_ISA_EXT_SVPBMT: set not supported
> > + *  - KVM_RISCV_ISA_EXT_SVINVA: set not supported
> > + *  - KVM_RISCV_ISA_EXT_SSAIA: set not supported
> > + */
> > +static __u64 base_rejects_set[] =3D {
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG |
> > +                                     KVM_REG_RISCV_CONFIG_REG(zicbom_b=
lock_size),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG |
> > +                                     KVM_REG_RISCV_CONFIG_REG(zicboz_b=
lock_size),
>
> I wouldn't wrap these either.
>

Sure.

> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_=
RISCV_TIMER_REG(frequency),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_=
RISCV_TIMER_REG(state),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_SVPBMT,
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_SVINVAL,
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_SSAIA,
>
> Also most of these should be KVM_REG_SIZE_ULONG.
>

Yes

> > +};
> > +
> > +static __u64 fp_f_regs[] =3D {
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[0]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[1]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[2]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[3]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[4]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[5]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[6]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[7]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[8]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[9]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[10]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[11]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[12]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[13]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[14]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[15]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[16]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[17]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[18]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[19]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[20]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[21]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[22]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[23]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[24]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[25]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[26]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[27]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[28]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[29]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[30]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(f[31]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_R=
ISCV_FP_F_REG(fcsr),
> > +};
> > +
> > +static __u64 fp_d_regs[] =3D {
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[0]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[1]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[2]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[3]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[4]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[5]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[6]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[7]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[8]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[9]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[10]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[11]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[12]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[13]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[14]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[15]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[16]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[17]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[18]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[19]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[20]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[21]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[22]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[23]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[24]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[25]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[26]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[27]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[28]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[29]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[30]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(f[31]),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_D | KVM_REG_R=
ISCV_FP_D_REG(fcsr),
> > +};
> > +
> > +#define BASE_SUBLIST \
> > +     {"base", .regs =3D base_regs, .regs_n =3D ARRAY_SIZE(base_regs), =
\
> > +             .rejects_set =3D base_rejects_set, .rejects_set_n =3D ARR=
AY_SIZE(base_rejects_set),}
> > +#define FP_F_REGS_SUBLIST \
> > +     {"fp_f_regs", .capability =3D KVM_RISCV_ISA_EXT_F, .regs =3D fp_f=
_regs, \
> > +             .regs_n =3D ARRAY_SIZE(fp_f_regs),}
> > +#define FP_D_REGS_SUBLIST \
> > +     {"fp_d_regs", .capability =3D KVM_RISCV_ISA_EXT_D, .regs =3D fp_d=
_regs, \
> > +             .regs_n =3D ARRAY_SIZE(fp_d_regs),}
> > +
> > +static struct vcpu_reg_list fp_f_d_config =3D {
> > +     .sublists =3D {
> > +     BASE_SUBLIST,
> > +     FP_F_REGS_SUBLIST,
> > +     FP_D_REGS_SUBLIST,
> > +     {0},
> > +     },
> > +};
>
> What about configs which include the zicbo* block size registers, AIA
> register configs, and the ISA and SBI registers?
>

Yes, this should be also covered with different vcpu_reg_list combinations.
It may be a little complicated since riscv has many different kinds of
extensions.
I will try to cover this support in v3.

> > +
> > +struct vcpu_reg_list *vcpu_configs[] =3D {
> > +     &fp_f_d_config,
> > +};
> > +int vcpu_configs_n =3D ARRAY_SIZE(vcpu_configs);
> > --
> > 2.34.1
> >
>
> Thanks,
> drew
