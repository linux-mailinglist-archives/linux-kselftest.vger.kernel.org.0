Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734D672BE21
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbjFLKB1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 06:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjFLJ70 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 05:59:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52012659D;
        Mon, 12 Jun 2023 02:42:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25bbcf3c0acso934424a91.2;
        Mon, 12 Jun 2023 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686562976; x=1689154976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUYPp+hE6bUfZvlw5hUubOeouQBM9mL02uhwGUtCt/o=;
        b=lAZo6lDccQDSvGUYPlisPUQxKGJ0bZprCtiq/n/bIHVvkerVaetP610xENSzipJGIE
         ifCGxtuoLW0/avbXPmFEESxfW+lOUeMfm2Y1CKY+g/PZAMQeW6VM0P6FBV+zS/yLr3OR
         OYNRTaO1gwZU9B0LqiXf82AwNw+V9uk+6BfpZahWjH97qO4G2wyuelJcCGh9A+jx8Kic
         pcw1AnH8x2YEQYC6Rg2NLoI5xAgN2m4dL7DNP0DM5io/RnnUpDacHYPujvRLRYw689T+
         tCQDKgkBRf4pCBNpce+u6jTq1pgS5hIFDmmyw7kQLMwsmSgXtPfpeo2i3IN59qxfSsYd
         Q0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562976; x=1689154976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUYPp+hE6bUfZvlw5hUubOeouQBM9mL02uhwGUtCt/o=;
        b=REtHRZgjSjZjOhoYcNdaqo2xS/7sajd22WqyksZwtbDkyBnFZfpAllPR0KG2QMGbfS
         l3qD6xZSjWDuEcpslMKAz9D34SYnwQryqqX47ePcv9k4YLSuvJHsdCvsgviE+1vHHTVg
         k/1ZRH3Pmv/IPmSTECEsfbDgMpgZjlQptpm5OR3iLcA9ffUvguxFPd/k506KxzkjAQqb
         d4+U2XBj7GiErJdPglM9cdvHCuDToWEq+4KQJO5tEWY05JDlFvyTw90Yv6GfQiFTlv2a
         fSecVSHMYmzKGKZWpmuGP79MbCOpKnRRdKFpZePsalvVfrAt2YB208yoQXjln2zlCI0a
         tuUw==
X-Gm-Message-State: AC+VfDyKvC652jZd1LmU//RR4Gp3D3+5kmxmsao3d45kG9/Pb3uejEO6
        fF56qSaS4yE0od2/yczYQ8co4dvCQbfAcO9YEZI=
X-Google-Smtp-Source: ACHHUZ4VBRAidGz39SgXlQXhDAgb4BZgjRs74HYqFrtTZGRr3WZAidMyxlzlW2rL6DQl/H4FvpMekalJdcy8+YYBTjY=
X-Received: by 2002:a17:90a:7063:b0:25b:db23:c578 with SMTP id
 f90-20020a17090a706300b0025bdb23c578mr2552687pjk.12.1686562975462; Mon, 12
 Jun 2023 02:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686275310.git.haibo1.xu@intel.com> <8cd4ce50f5f4a639f4508085959aae222d4d4386.1686275310.git.haibo1.xu@intel.com>
 <20230609-fba04b424a4d46574e04e587@orel> <CAJve8okgJNBjhEmziM2pO057wQek70JV8EJGjbYpdT1pUvuLng@mail.gmail.com>
 <20230612-b6c96bf6ec13426641a819dd@orel>
In-Reply-To: <20230612-b6c96bf6ec13426641a819dd@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Mon, 12 Jun 2023 17:42:43 +0800
Message-ID: <CAJve8okpJo-ruSmn7+q3FiX-Jv41fnWV-oiKuq2ugHBDGOf4UQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] KVM: riscv: selftests: Add get-reg-list test
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
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
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

On Mon, Jun 12, 2023 at 5:11=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Sat, Jun 10, 2023 at 11:12:15AM +0800, Haibo Xu wrote:
> > On Fri, Jun 9, 2023 at 9:35=E2=80=AFPM Andrew Jones <ajones@ventanamicr=
o.com> wrote:
> > >
> > > On Fri, Jun 09, 2023 at 10:12:18AM +0800, Haibo Xu wrote:
> > > > get-reg-list test is used to check for KVM registers regressions
> > > > during VM migration which happens when destination host kernel
> > > > missing registers that the source host kernel has. The blessed
> > > > list registers was created by running on v6.4-rc5.
> > > >
> > > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > > ---
> > > >  tools/testing/selftests/kvm/Makefile          |   1 +
> > > >  tools/testing/selftests/kvm/get-reg-list.c    |  28 +
> > > >  .../selftests/kvm/include/riscv/processor.h   |   3 +
> > > >  .../selftests/kvm/riscv/get-reg-list.c        | 611 ++++++++++++++=
++++
> > > >  4 files changed, 643 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/kvm/riscv/get-reg-list.=
c
> > > >
> > > > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/s=
elftests/kvm/Makefile
> > > > index d90cad19c9ee..f7bcda903dd9 100644
> > > > --- a/tools/testing/selftests/kvm/Makefile
> > > > +++ b/tools/testing/selftests/kvm/Makefile
> > > > @@ -174,6 +174,7 @@ TEST_GEN_PROGS_s390x +=3D kvm_binary_stats_test
> > > >
> > > >  TEST_GEN_PROGS_riscv +=3D demand_paging_test
> > > >  TEST_GEN_PROGS_riscv +=3D dirty_log_test
> > > > +TEST_GEN_PROGS_riscv +=3D get-reg-list
> > > >  TEST_GEN_PROGS_riscv +=3D kvm_create_max_vcpus
> > > >  TEST_GEN_PROGS_riscv +=3D kvm_page_table_test
> > > >  TEST_GEN_PROGS_riscv +=3D set_memory_region_test
> > > > diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/tes=
ting/selftests/kvm/get-reg-list.c
> > > > index abacb95c21c6..73f40e0842b8 100644
> > > > --- a/tools/testing/selftests/kvm/get-reg-list.c
> > > > +++ b/tools/testing/selftests/kvm/get-reg-list.c
> > > > @@ -133,6 +133,34 @@ static struct kvm_vcpu *vcpu_config_get_vcpu(s=
truct vcpu_reg_list *c, struct kvm
> > > >       return vcpu;
> > > >  }
> > > >  #else
> > > > +static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > > > +{
> > > > +     int ret;
> > > > +     unsigned long value;
> > > > +
> > > > +     ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> > > > +     if (ret) {
> > > > +             printf("Failed to get ext %d", ext);
> > > > +             return false;
> > > > +     }
> > > > +
> > > > +     return !!value;
> > > > +}
> > > > +
> > > > +static void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_l=
ist *c)
> > > > +{
> > > > +     struct vcpu_reg_sublist *s;
> > > > +
> > > > +     for_each_sublist(c, s) {
> > > > +             if (!s->feature)
> > > > +                     continue;
> > >
> > > Using zero to mean "not specified" means we can't test for
> > > KVM_RISCV_ISA_EXT_A, but that's probably OK, since Linux always has '=
a',
> > > so we'll never need to check for it.
> > >
> >
> > Almost all the features would be enabled by default for RISC-V vCPU if
> > the host has the corresponding extension.
> > Just leave the gatekeeper to the vcpu_finialize() to check whether the
> > feature was supported before triggering the test.
>
> Yes, but you can't check if 'a' is available here, because
> KVM_RISCV_ISA_EXT_A is 0 and 0 also means "not specified", as
> shown above with the "if 0, continue". But, as I said, it
> doesn't matter. 'a' will always be present.
>

Yes, hit a corner case.

> >
> > > > +
> > > > +             __TEST_REQUIRE(vcpu_has_ext(vcpu, s->feature),
> > > > +                            "%s: %s not available, skipping tests\=
n",
> > > > +                            config_name(c), s->name);
> > > > +     }
> > > > +}
> > > > +
> > > >  static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list =
*c, struct kvm_vm *vm)
> > > >  {
> > > >       return __vm_vcpu_add(vm, 0);
> > > > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h =
b/tools/testing/selftests/kvm/include/riscv/processor.h
> > > > index d00d213c3805..5b62a3d2aa9b 100644
> > > > --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > > > +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > > > @@ -38,6 +38,9 @@ static inline uint64_t __kvm_reg_id(uint64_t type=
, uint64_t idx,
> > > >                                            KVM_REG_RISCV_TIMER_REG(=
name), \
> > > >                                            KVM_REG_SIZE_U64)
> > > >
> > > > +#define RISCV_ISA_EXT_REG(idx)       __kvm_reg_id(KVM_REG_RISCV_IS=
A_EXT, \
> > > > +                                          idx, KVM_REG_SIZE_ULONG)
> > > > +
> > > >  /* L3 index Bit[47:39] */
> > > >  #define PGTBL_L3_INDEX_MASK                  0x0000FF8000000000ULL
> > > >  #define PGTBL_L3_INDEX_SHIFT                 39
> > > > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/too=
ls/testing/selftests/kvm/riscv/get-reg-list.c
> > > > new file mode 100644
> > > > index 000000000000..0f371d99d471
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > > > @@ -0,0 +1,611 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Check for KVM_GET_REG_LIST regressions.
> > > > + *
> > > > + * Copyright (C) 2020, Red Hat, Inc.
> > >
> > > I don't think we need the Red Hat copyright. This is a completely new
> > > work.
> > >
> >
> > Sure, will remove it.
> >
> > > > + * Copyright (c) 2023 Intel Corporation
> > > > + *
> > > > + */
> > > > +#include <stdio.h>
> > > > +#include "kvm_util.h"
> > > > +#include "test_util.h"
> > > > +#include "processor.h"
> > > > +
> > > > +#define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK)
> > > > +
> > > > +static const char *config_id_to_str(__u64 id)
> > > > +{
> > > > +     /* reg_off is the offset into struct kvm_riscv_config */
> > > > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_CONFIG);
> > > > +
> > > > +     switch (reg_off) {
> > > > +     case KVM_REG_RISCV_CONFIG_REG(isa):
> > > > +             return "KVM_REG_RISCV_CONFIG_REG(isa)";
> > > > +     case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
> > > > +             return "KVM_REG_RISCV_CONFIG_REG(zicbom_block_size)";
> > > > +     case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
> > > > +             return "KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)";
> > > > +     case KVM_REG_RISCV_CONFIG_REG(mvendorid):
> > > > +             return "KVM_REG_RISCV_CONFIG_REG(mvendorid)";
> > > > +     case KVM_REG_RISCV_CONFIG_REG(marchid):
> > > > +             return "KVM_REG_RISCV_CONFIG_REG(marchid)";
> > > > +     case KVM_REG_RISCV_CONFIG_REG(mimpid):
> > > > +             return "KVM_REG_RISCV_CONFIG_REG(mimpid)";
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * Config regs would grow regularly with new pseudo reg added=
, so
> > > > +      * just show raw id to indicate a new pseudo config reg.
> > > > +      */
> > > > +     return strdup_printf("KVM_REG_RISCV_CONFIG_REG(%lld) /* UNKNO=
WN */", reg_off);
> > > > +}
> > > > +
> > > > +static const char *core_id_to_str(const char *prefix, __u64 id)
> > > > +{
> > > > +     /* reg_off is the offset into struct kvm_riscv_core */
> > > > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_CORE);
> > > > +
> > > > +     switch (reg_off) {
> > > > +     case KVM_REG_RISCV_CORE_REG(regs.pc):
> > > > +             return "KVM_REG_RISCV_CORE_REG(regs.pc)";
> > > > +     case KVM_REG_RISCV_CORE_REG(regs.ra):
> > > > +             return "KVM_REG_RISCV_CORE_REG(regs.ra)";
> > > > +     case KVM_REG_RISCV_CORE_REG(regs.sp):
> > > > +             return "KVM_REG_RISCV_CORE_REG(regs.sp)";
> > > > +     case KVM_REG_RISCV_CORE_REG(regs.gp):
> > > > +             return "KVM_REG_RISCV_CORE_REG(regs.gp)";
> > > > +     case KVM_REG_RISCV_CORE_REG(regs.tp):
> > > > +             return "KVM_REG_RISCV_CORE_REG(regs.tp)";
> > > > +     case KVM_REG_RISCV_CORE_REG(regs.t0) ... KVM_REG_RISCV_CORE_R=
EG(regs.t2):
> > > > +             return strdup_printf("KVM_REG_RISCV_CORE_REG(regs.t%l=
ld)",
> > > > +                        reg_off - KVM_REG_RISCV_CORE_REG(regs.t0))=
;
> > > > +     case KVM_REG_RISCV_CORE_REG(regs.s0) ... KVM_REG_RISCV_CORE_R=
EG(regs.s1):
> > > > +             return strdup_printf("KVM_REG_RISCV_CORE_REG(regs.s%l=
ld)",
> > > > +                        reg_off - KVM_REG_RISCV_CORE_REG(regs.s0))=
;
> > > > +     case KVM_REG_RISCV_CORE_REG(regs.a0) ... KVM_REG_RISCV_CORE_R=
EG(regs.a7):
> > > > +             return strdup_printf("KVM_REG_RISCV_CORE_REG(regs.a%l=
ld)",
> > > > +                        reg_off - KVM_REG_RISCV_CORE_REG(regs.a0))=
;
> > > > +     case KVM_REG_RISCV_CORE_REG(regs.s2) ... KVM_REG_RISCV_CORE_R=
EG(regs.s11):
> > > > +             return strdup_printf("KVM_REG_RISCV_CORE_REG(regs.s%l=
ld)",
> > > > +                        reg_off - KVM_REG_RISCV_CORE_REG(regs.s2) =
+ 2);
> > > > +     case KVM_REG_RISCV_CORE_REG(regs.t3) ... KVM_REG_RISCV_CORE_R=
EG(regs.t6):
> > > > +             return strdup_printf("KVM_REG_RISCV_CORE_REG(regs.t%l=
ld)",
> > > > +                        reg_off - KVM_REG_RISCV_CORE_REG(regs.t3) =
+ 3);
> > > > +     case KVM_REG_RISCV_CORE_REG(mode):
> > > > +             return "KVM_REG_RISCV_CORE_REG(mode)";
> > > > +     }
> > > > +
> > > > +     TEST_FAIL("%s: Unknown core reg id: 0x%llx", prefix, id);
> > > > +     return NULL;
> > > > +}
> > > > +
> > > > +#define RISCV_CSR_GENERAL(csr) \
> > > > +     "KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(" #csr ")"
> > > > +#define RISCV_CSR_AIA(csr) \
> > > > +     "KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_REG(" #csr ")"
> > > > +
> > > > +static const char *general_csr_id_to_str(__u64 reg_off)
> > > > +{
> > > > +     /* reg_off is the offset into struct kvm_riscv_csr */
> > > > +     switch (reg_off) {
> > > > +     case KVM_REG_RISCV_CSR_REG(sstatus):
> > > > +             return RISCV_CSR_GENERAL(sstatus);
> > > > +     case KVM_REG_RISCV_CSR_REG(sie):
> > > > +             return RISCV_CSR_GENERAL(sie);
> > > > +     case KVM_REG_RISCV_CSR_REG(stvec):
> > > > +             return RISCV_CSR_GENERAL(stvec);
> > > > +     case KVM_REG_RISCV_CSR_REG(sscratch):
> > > > +             return RISCV_CSR_GENERAL(sscratch);
> > > > +     case KVM_REG_RISCV_CSR_REG(sepc):
> > > > +             return RISCV_CSR_GENERAL(sepc);
> > > > +     case KVM_REG_RISCV_CSR_REG(scause):
> > > > +             return RISCV_CSR_GENERAL(scause);
> > > > +     case KVM_REG_RISCV_CSR_REG(stval):
> > > > +             return RISCV_CSR_GENERAL(stval);
> > > > +     case KVM_REG_RISCV_CSR_REG(sip):
> > > > +             return RISCV_CSR_GENERAL(sip);
> > > > +     case KVM_REG_RISCV_CSR_REG(satp):
> > > > +             return RISCV_CSR_GENERAL(satp);
> > > > +     case KVM_REG_RISCV_CSR_REG(scounteren):
> > > > +             return RISCV_CSR_GENERAL(scounteren);
> > > > +     }
> > > > +
> > > > +     TEST_FAIL("Unknown general csr reg: 0x%llx", reg_off);
> > > > +     return NULL;
> > > > +}
> > > > +
> > > > +static const char *aia_csr_id_to_str(__u64 reg_off)
> > > > +{
> > > > +     /* reg_off is the offset into struct kvm_riscv_aia_csr */
> > > > +     switch (reg_off) {
> > > > +     case KVM_REG_RISCV_CSR_AIA_REG(siselect):
> > > > +             return RISCV_CSR_AIA(siselect);
> > > > +     case KVM_REG_RISCV_CSR_AIA_REG(iprio1):
> > > > +             return RISCV_CSR_AIA(iprio1);
> > > > +     case KVM_REG_RISCV_CSR_AIA_REG(iprio2):
> > > > +             return RISCV_CSR_AIA(iprio2);
> > > > +     case KVM_REG_RISCV_CSR_AIA_REG(sieh):
> > > > +             return RISCV_CSR_AIA(sieh);
> > > > +     case KVM_REG_RISCV_CSR_AIA_REG(siph):
> > > > +             return RISCV_CSR_AIA(siph);
> > > > +     case KVM_REG_RISCV_CSR_AIA_REG(iprio1h):
> > > > +             return RISCV_CSR_AIA(iprio1h);
> > > > +     case KVM_REG_RISCV_CSR_AIA_REG(iprio2h):
> > > > +             return RISCV_CSR_AIA(iprio2h);
> > > > +     }
> > > > +
> > > > +     TEST_FAIL("Unknown aia csr reg: 0x%llx", reg_off);
> > > > +     return NULL;
> > > > +}
> > > > +
> > > > +static const char *csr_id_to_str(const char *prefix, __u64 id)
> > > > +{
> > > > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_CSR);
> > > > +     __u64 reg_subtype =3D reg_off & KVM_REG_RISCV_SUBTYPE_MASK;
> > > > +
> > > > +     reg_off &=3D ~KVM_REG_RISCV_SUBTYPE_MASK;
> > > > +
> > > > +     switch (reg_subtype) {
> > > > +     case KVM_REG_RISCV_CSR_GENERAL:
> > > > +             return general_csr_id_to_str(reg_off);
> > > > +     case KVM_REG_RISCV_CSR_AIA:
> > > > +             return aia_csr_id_to_str(reg_off);
> > > > +     }
> > > > +
> > > > +     TEST_FAIL("%s: Unknown csr subtype: 0x%llx", prefix, reg_subt=
ype);
> > > > +     return NULL;
> > > > +}
> > > > +
> > > > +static const char *timer_id_to_str(const char *prefix, __u64 id)
> > > > +{
> > > > +     /* reg_off is the offset into struct kvm_riscv_timer */
> > > > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_TIMER);
> > > > +
> > > > +     switch (reg_off) {
> > > > +     case KVM_REG_RISCV_TIMER_REG(frequency):
> > > > +             return "KVM_REG_RISCV_TIMER_REG(frequency)";
> > > > +     case KVM_REG_RISCV_TIMER_REG(time):
> > > > +             return "KVM_REG_RISCV_TIMER_REG(time)";
> > > > +     case KVM_REG_RISCV_TIMER_REG(compare):
> > > > +             return "KVM_REG_RISCV_TIMER_REG(compare)";
> > > > +     case KVM_REG_RISCV_TIMER_REG(state):
> > > > +             return "KVM_REG_RISCV_TIMER_REG(state)";
> > > > +     }
> > > > +
> > > > +     TEST_FAIL("%s: Unknown timer reg id: 0x%llx", prefix, id);
> > > > +     return NULL;
> > > > +}
> > > > +
> > > > +static const char *fp_f_id_to_str(const char *prefix, __u64 id)
> > > > +{
> > > > +     /* reg_off is the offset into struct __riscv_f_ext_state */
> > > > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_FP_F);
> > > > +
> > > > +     switch (reg_off) {
> > > > +     case KVM_REG_RISCV_FP_F_REG(f[0]) ...
> > > > +          KVM_REG_RISCV_FP_F_REG(f[31]):
> > > > +             return strdup_printf("KVM_REG_RISCV_FP_F_REG(f[%lld])=
", reg_off);
> > > > +     case KVM_REG_RISCV_FP_F_REG(fcsr):
> > > > +             return "KVM_REG_RISCV_FP_F_REG(fcsr)";
> > > > +     }
> > > > +
> > > > +     TEST_FAIL("%s: Unknown fp_f reg id: 0x%llx", prefix, id);
> > > > +     return NULL;
> > > > +}
> > > > +
> > > > +static const char *fp_d_id_to_str(const char *prefix, __u64 id)
> > > > +{
> > > > +     /* reg_off is the offset into struct __riscv_d_ext_state */
> > > > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_FP_D);
> > > > +
> > > > +     switch (reg_off) {
> > > > +     case KVM_REG_RISCV_FP_D_REG(f[0]) ...
> > > > +          KVM_REG_RISCV_FP_D_REG(f[31]):
> > > > +             return strdup_printf("KVM_REG_RISCV_FP_D_REG(f[%lld])=
", reg_off);
> > > > +     case KVM_REG_RISCV_FP_D_REG(fcsr):
> > > > +             return "KVM_REG_RISCV_FP_D_REG(fcsr)";
> > > > +     }
> > > > +
> > > > +     TEST_FAIL("%s: Unknown fp_d reg id: 0x%llx", prefix, id);
> > > > +     return NULL;
> > > > +}
> > > > +
> > > > +static const char *isa_ext_id_to_str(__u64 id)
> > > > +{
> > > > +     /* reg_off is the offset into unsigned long kvm_isa_ext_arr[]=
 */
> > > > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_ISA_EXT);
> > > > +
> > > > +     static const char * const kvm_isa_ext_reg_name[] =3D {
> > > > +             "KVM_RISCV_ISA_EXT_A",
> > > > +             "KVM_RISCV_ISA_EXT_C",
> > > > +             "KVM_RISCV_ISA_EXT_D",
> > > > +             "KVM_RISCV_ISA_EXT_F",
> > > > +             "KVM_RISCV_ISA_EXT_H",
> > > > +             "KVM_RISCV_ISA_EXT_I",
> > > > +             "KVM_RISCV_ISA_EXT_M",
> > > > +             "KVM_RISCV_ISA_EXT_SVPBMT",
> > > > +             "KVM_RISCV_ISA_EXT_SSTC",
> > > > +             "KVM_RISCV_ISA_EXT_SVINVAL",
> > > > +             "KVM_RISCV_ISA_EXT_ZIHINTPAUSE",
> > > > +             "KVM_RISCV_ISA_EXT_ZICBOM",
> > > > +             "KVM_RISCV_ISA_EXT_ZICBOZ",
> > > > +             "KVM_RISCV_ISA_EXT_ZBB",
> > > > +             "KVM_RISCV_ISA_EXT_SSAIA",
> > > > +     };
> > > > +
> > > > +     if (reg_off >=3D ARRAY_SIZE(kvm_isa_ext_reg_name)) {
> > > > +             /*
> > > > +              * isa_ext regs would grow regularly with new isa ext=
ension added, so
> > > > +              * just show "reg" to indicate a new extension.
> > > > +              */
> > > > +             return strdup_printf("%lld /* UNKNOWN */", reg_off);
> > > > +     }
> > > > +
> > > > +     return kvm_isa_ext_reg_name[reg_off];
> > > > +}
> > > > +
> > > > +static const char *sbi_ext_single_id_to_str(__u64 reg_off)
> > > > +{
> > > > +     /* reg_off is KVM_RISCV_SBI_EXT_ID */
> > > > +     static const char * const kvm_sbi_ext_reg_name[] =3D {
> > > > +             "KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_V01",
> > > > +             "KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_TIME",
> > > > +             "KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_IPI",
> > > > +             "KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_RFENCE"=
,
> > > > +             "KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_SRST",
> > > > +             "KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_HSM",
> > > > +             "KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_PMU",
> > > > +             "KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_EXPERIM=
ENTAL",
> > > > +             "KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR"=
,
> > > > +     };
> > > > +
> > > > +     if (reg_off >=3D ARRAY_SIZE(kvm_sbi_ext_reg_name)) {
> > > > +             /*
> > > > +              * sbi_ext regs would grow regularly with new sbi ext=
ension added, so
> > > > +              * just show "reg" to indicate a new extension.
> > > > +              */
> > > > +             return strdup_printf("KVM_REG_RISCV_SBI_SINGLE | %lld=
 /* UNKNOWN */", reg_off);
> > > > +     }
> > > > +
> > > > +     return kvm_sbi_ext_reg_name[reg_off];
> > > > +}
> > > > +
> > > > +static const char *sbi_ext_multi_id_to_str(__u64 reg_subtype, __u6=
4 reg_off)
> > > > +{
> > > > +     if (reg_off > KVM_REG_RISCV_SBI_MULTI_REG_LAST) {
> > > > +             /*
> > > > +              * sbi_ext regs would grow regularly with new sbi ext=
ension added, so
> > > > +              * just show "reg" to indicate a new extension.
> > > > +              */
> > > > +             return strdup_printf("%lld /* UNKNOWN */", reg_off);
> > > > +     }
> > > > +
> > > > +     switch (reg_subtype) {
> > > > +     case KVM_REG_RISCV_SBI_MULTI_EN:
> > > > +             return strdup_printf("KVM_REG_RISCV_SBI_MULTI_EN | %l=
ld", reg_off);
> > > > +     case KVM_REG_RISCV_SBI_MULTI_DIS:
> > > > +             return strdup_printf("KVM_REG_RISCV_SBI_MULTI_DIS | %=
lld", reg_off);
> > > > +     }
> > > > +
> > > > +     return NULL;
> > > > +}
> > > > +
> > > > +static const char *sbi_ext_id_to_str(const char *prefix, __u64 id)
> > > > +{
> > > > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_SBI_EXT);
> > > > +     __u64 reg_subtype =3D reg_off & KVM_REG_RISCV_SUBTYPE_MASK;
> > > > +
> > > > +     reg_off &=3D ~KVM_REG_RISCV_SUBTYPE_MASK;
> > > > +
> > > > +     switch (reg_subtype) {
> > > > +     case KVM_REG_RISCV_SBI_SINGLE:
> > > > +             return sbi_ext_single_id_to_str(reg_off);
> > > > +     case KVM_REG_RISCV_SBI_MULTI_EN:
> > > > +     case KVM_REG_RISCV_SBI_MULTI_DIS:
> > > > +             return sbi_ext_multi_id_to_str(reg_subtype, reg_off);
> > > > +     }
> > > > +
> > > > +     TEST_FAIL("%s: Unknown sbi ext subtype: 0x%llx", prefix, reg_=
subtype);
> > > > +     return NULL;
> > > > +}
> > > > +
> > > > +void print_reg(const char *prefix, __u64 id)
> > > > +{
> > > > +     const char *reg_size =3D NULL;
> > > > +
> > > > +     TEST_ASSERT((id & KVM_REG_ARCH_MASK) =3D=3D KVM_REG_RISCV,
> > > > +                 "%s: KVM_REG_RISCV missing in reg id: 0x%llx", pr=
efix, id);
> > > > +
> > > > +     switch (id & KVM_REG_SIZE_MASK) {
> > > > +     case KVM_REG_SIZE_U32:
> > > > +             reg_size =3D "KVM_REG_SIZE_U32";
> > > > +             break;
> > > > +     case KVM_REG_SIZE_U64:
> > > > +             reg_size =3D "KVM_REG_SIZE_U64";
> > > > +             break;
> > > > +     case KVM_REG_SIZE_U128:
> > > > +             reg_size =3D "KVM_REG_SIZE_U128";
> > > > +             break;
> > > > +     default:
> > > > +             TEST_FAIL("%s: Unexpected reg size: 0x%llx in reg id:=
 0x%llx",
> > > > +                       prefix, (id & KVM_REG_SIZE_MASK) >> KVM_REG=
_SIZE_SHIFT, id);
> > > > +     }
> > > > +
> > > > +     switch (id & KVM_REG_RISCV_TYPE_MASK) {
> > > > +     case KVM_REG_RISCV_CONFIG:
> > > > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CONFIG |=
 %s,\n",
> > >
> > > All the work to try and use KVM_REG_SIZE_ULONG in the right places wi=
ll be
> > > lost if we print a reg list and then copy+paste it as a blessed list.=
 On
> > > 64-bit, the only thing supported now, we'll get U64, but if we ever
> > > supported 32-bit, then we'd get U32. This is unfortunate, but there's
> > > nothing we can do about it. Either we can't have a true print+copy+pa=
ste
> > > workflow or we should assume we'll only support 64-bit and only use U=
64
> > > in the blessed lists (from a copy+paste). But, we've already got ULON=
G
> > > in there now, so we can just leave it and burn this bridge later.
> > >
> >
> > Yes, the print_reg would print U64  for riscv64 system and U32 for risc=
v32.
> > As commented in v2 patch, it seems 32-bit was not supported in other AR=
CHs.
> > If riscv follows this assumption, I think U64 was better for print_reg.
>
> It's not better, but there's no way to avoid it. The information that it
> was a ULONG, instead of U64, has been lost at this point. The only way
> to print it correctly is to create a reg-size mapping and then look it up=
,
> rather than decode it. We can add a lookup when/if adding 32-bit support.
>

Sure, just leave it as ULONG here.

> >
> >
> > > > +                             reg_size, config_id_to_str(id));
> > > > +             break;
> > > > +     case KVM_REG_RISCV_CORE:
> > > > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CORE | %=
s,\n",
> > > > +                             reg_size, core_id_to_str(prefix, id))=
;
> > > > +             break;
> > > > +     case KVM_REG_RISCV_CSR:
> > > > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CSR | %s=
,\n",
> > > > +                             reg_size, csr_id_to_str(prefix, id));
> > > > +             break;
> > > > +     case KVM_REG_RISCV_TIMER:
> > > > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_TIMER | =
%s,\n",
> > > > +                             reg_size, timer_id_to_str(prefix, id)=
);
> > > > +             break;
> > > > +     case KVM_REG_RISCV_FP_F:
> > > > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_F | %=
s,\n",
> > > > +                             reg_size, fp_f_id_to_str(prefix, id))=
;
> > > > +             break;
> > > > +     case KVM_REG_RISCV_FP_D:
> > > > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_D | %=
s,\n",
> > > > +                             reg_size, fp_d_id_to_str(prefix, id))=
;
> > > > +             break;
> > > > +     case KVM_REG_RISCV_ISA_EXT:
> > > > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_ISA_EXT =
| %s,\n",
> > > > +                             reg_size, isa_ext_id_to_str(id));
> > > > +             break;
> > > > +     case KVM_REG_RISCV_SBI_EXT:
> > > > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_SBI_EXT =
| %s,\n",
> > > > +                             reg_size, sbi_ext_id_to_str(prefix, i=
d));
> > > > +             break;
> > > > +     default:
> > > > +             TEST_FAIL("%s: Unexpected reg type: 0x%llx in reg id:=
 0x%llx", prefix,
> > > > +                             (id & KVM_REG_RISCV_TYPE_MASK) >> KVM=
_REG_RISCV_TYPE_SHIFT, id);
> > > > +     }
> > > > +}
> > > > +
> > > > +/*
> > > > + * The current blessed list was primed with the output of kernel v=
ersion
> > > > + * v6.4-rc5 and then later updated with new registers.
> > > > + */
> > > > +static __u64 base_regs[] =3D {
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | K=
VM_REG_RISCV_CONFIG_REG(isa),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | K=
VM_REG_RISCV_CONFIG_REG(mvendorid),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | K=
VM_REG_RISCV_CONFIG_REG(marchid),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | K=
VM_REG_RISCV_CONFIG_REG(mimpid),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.pc),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.ra),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.sp),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.gp),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.tp),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.t0),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.t1),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.t2),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.s0),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.s1),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.a0),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.a1),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.a2),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.a3),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.a4),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.a5),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.a6),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.a7),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.s2),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.s3),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.s4),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.s5),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.s6),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.s7),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.s8),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.s9),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.s10),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.s11),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.t3),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.t4),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.t5),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(regs.t6),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM=
_REG_RISCV_CORE_REG(mode),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sstatus),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sie),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(stvec),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sscratch),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sepc),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(scause),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(stval),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sip),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(satp),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(scounteren),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_=
REG_RISCV_TIMER_REG(frequency),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_=
REG_RISCV_TIMER_REG(time),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_=
REG_RISCV_TIMER_REG(compare),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_=
REG_RISCV_TIMER_REG(state),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_A,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_C,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_D,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_F,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_I,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_M,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_V01,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_TIME,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_IPI,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_RFENCE,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_SRST,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_HSM,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_PMU,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_EXPERIMENTAL,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_MULTI_EN | 0,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_MULTI_DIS | 0,
> > > > +};
> > > > +
> > > > +/*
> > > > + * The rejects_set list registers that should skip set test.
> > > > + *  - KVM_REG_RISCV_TIMER_REG(state): set would fail if it was not=
 initialized properly.
> > > > + *  - KVM_REG_RISCV_TIMER_REG(frequency): set not supported
> > > > + *  - KVM_REG_RISCV_CONFIG_REG(zicbom_block_size): set not support=
ed
> > > > + *  - KVM_REG_RISCV_CONFIG_REG(zicboz_block_size): set not support=
ed
> > > > + *  - KVM_RISCV_ISA_EXT_SVPBMT: set not supported
> > > > + *  - KVM_RISCV_ISA_EXT_SVINVA: set not supported
> > > > + *  - KVM_RISCV_ISA_EXT_SSAIA: set not supported
> > > > + */
> > > > +static __u64 base_rejects_set[] =3D {
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | K=
VM_REG_RISCV_CONFIG_REG(zicbom_block_size),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | K=
VM_REG_RISCV_CONFIG_REG(zicboz_block_size),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_=
REG_RISCV_TIMER_REG(frequency),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_=
REG_RISCV_TIMER_REG(state),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_SVPBMT,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_SVINVAL,
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_SSAIA,
> > >
> > > These aren't all base registers. I think we should divide the reject =
lists
> > > up too, especially considering the idea I wrote in the last patch, wh=
ich
> > > is to test setting the rejects to ensure the expected error is return=
ed.
> > > The error may be different for a rejected set of a supported register=
 vs.
> > > that of an unsupported register.
> > >
> >
> > Yes, the reject list should divide up too. Will change it in V4.
> >
> > > > +};
> > > > +
> > > > +static __u64 zicbom_regs[] =3D {
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | K=
VM_REG_RISCV_CONFIG_REG(zicbom_block_size),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_ZICBOM,
> > > > +};
> > > > +
> > > > +static __u64 zicboz_regs[] =3D {
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | K=
VM_REG_RISCV_CONFIG_REG(zicboz_block_size),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_ZICBOZ,
> > > > +};
> > > > +
> > > > +static __u64 aia_csr_regs[] =3D {
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(sieh),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siph),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1h),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_=
REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2h),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_SSAIA,
> > > > +};
> > > > +
> > > > +static __u64 fp_f_regs[] =3D {
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[0]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[1]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[2]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[3]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[4]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[5]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[6]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[7]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[8]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[9]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[10]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[11]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[12]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[13]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[14]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[15]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[16]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[17]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[18]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[19]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[20]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[21]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[22]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[23]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[24]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[25]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[26]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[27]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[28]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[29]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[30]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(f[31]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_R=
EG_RISCV_FP_F_REG(fcsr),
> > > > +};
> > > > +
> > > > +static __u64 fp_d_regs[] =3D {
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[0]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[1]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[2]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[3]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[4]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[5]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[6]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[7]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[8]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[9]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[10]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[11]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[12]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[13]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[14]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[15]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[16]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[17]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[18]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[19]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[20]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[21]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[22]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[23]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[24]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[25]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[26]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[27]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[28]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[29]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[30]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(f[31]),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_D | KVM_R=
EG_RISCV_FP_D_REG(fcsr),
> > > > +};
> > > > +
> > > > +#define BASE_SUBLIST \
> > > > +     {"base", .regs =3D base_regs, .regs_n =3D ARRAY_SIZE(base_reg=
s), \
> > > > +             .rejects_set =3D base_rejects_set, .rejects_set_n =3D=
 ARRAY_SIZE(base_rejects_set),}
> > > > +#define ZICBOM_REGS_SUBLIST \
> > > > +     {"zicbom", .feature =3D KVM_RISCV_ISA_EXT_ZICBOM, .regs =3D z=
icbom_regs, \
> > > > +             .regs_n =3D ARRAY_SIZE(zicbom_regs),}
> > > > +#define ZICBOZ_REGS_SUBLIST \
> > > > +     {"zicboz", .feature =3D KVM_RISCV_ISA_EXT_ZICBOZ, .regs =3D z=
icboz_regs, \
> > > > +             .regs_n =3D ARRAY_SIZE(zicboz_regs),}
> > > > +#define AIA_REGS_SUBLIST \
> > > > +     {"aia", .feature =3D KVM_RISCV_ISA_EXT_SSAIA, .regs =3D aia_c=
sr_regs, \
> > > > +             .regs_n =3D ARRAY_SIZE(aia_csr_regs),}
> > > > +#define FP_F_REGS_SUBLIST \
> > > > +     {"fp_f", .feature =3D KVM_RISCV_ISA_EXT_F, .regs =3D fp_f_reg=
s, \
> > > > +             .regs_n =3D ARRAY_SIZE(fp_f_regs),}
> > > > +#define FP_D_REGS_SUBLIST \
> > > > +     {"fp_d", .feature =3D KVM_RISCV_ISA_EXT_D, .regs =3D fp_d_reg=
s, \
> > > > +             .regs_n =3D ARRAY_SIZE(fp_d_regs),}
> > > > +
> > > > +static struct vcpu_reg_list zicbo_config =3D {
> > > > +     .sublists =3D {
> > > > +     BASE_SUBLIST,
> > > > +     ZICBOM_REGS_SUBLIST,
> > > > +     ZICBOZ_REGS_SUBLIST,
> > >
> > > It's possible to have zicbom without zicboz and vice-versa. Since
> > > finalize_vcpu() will skip the whole test when it detects a missing
> > > feature for a config, then we won't be able to test one without the
> > > other. It's a bit annoying, but I think we may need a separate config
> > > for each independent extension.
> > >
> >
> > Sure.
> >
> > > > +     {0},
> > > > +     },
> > > > +};
> > > > +
> > > > +static struct vcpu_reg_list aia_config =3D {
> > > > +     .sublists =3D {
> > > > +     BASE_SUBLIST,
> > > > +     AIA_REGS_SUBLIST,
> > > > +     {0},
> > > > +     },
> > > > +};
> > > > +
> > > > +static struct vcpu_reg_list fp_f_d_config =3D {
> > > > +     .sublists =3D {
> > > > +     BASE_SUBLIST,
> > > > +     FP_F_REGS_SUBLIST,
> > > > +     FP_D_REGS_SUBLIST,
> > > > +     {0},
> > > > +     },
> > > > +};
> > > > +
> > > > +struct vcpu_reg_list *vcpu_configs[] =3D {
> > > > +     &zicbo_config,
> > > > +     &aia_config,
> > > > +     &fp_f_d_config,
> > > > +};
> > > > +int vcpu_configs_n =3D ARRAY_SIZE(vcpu_configs);
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > I see we have a bit of a problem with the configs for riscv. Since we
> > > don't disable anything we're not testing, then for any test that is
> > > missing, for example, the f and d registers, we'll get output like
> > > "There are 66 new registers. Consider adding them to the blessed reg
> > > list with the following lines:" and then a dump of all the f and d
> > > registers. The test doesn't fail, but it's messy and confusing. Ideal=
ly
> > > we'd disable all registers of all sublists not in the config, probabl=
y
> > > by starting by disabling everything and then only reenabling the ones
> > > in the config.
> > >
> > > Anything that can't be disabled is either a KVM bug, i.e. we should
> > > be able to disable it, because we can't expect every host to have it,
> > > or it needs to be in the base register sublist (meaning every host
> > > will always have it).
> > >
> >
> > Yes, as mentioned above, all the features would be enabled for vCPU by =
default
> > if it's available on the host. I think we can disable all the feature
> > bits at the start of
> > finalize_vcpu() and only enable the feature bits corresponding to the
> > specified config.
> >
>
> Yup.
>
> Thanks,
> drew
