Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4B07078DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 06:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjERERi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 00:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjERERf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 00:17:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177A435AD;
        Wed, 17 May 2023 21:17:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso563283a12.1;
        Wed, 17 May 2023 21:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684383450; x=1686975450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhDH77Vm7x2oymCccWNYX5/coR9dTpwzl5TaxOdCCvs=;
        b=fT7hTlgSYl1z7vsyQX8ahX8aMQfbsjlx8f7vYU+n+xBmXMBCDlkiL7bTP0RRqi7O1j
         Wn/NoBou88etbZzmx0gwNZiwjxPi8+NDl0Mek5vnxYtiFfMhIYEusVsey4c3OJoCoX9E
         kdNl20M9m1+/7RvAIM0DrJ5pQMuvvXAoRXSLOmQC5dGD9b2EA7GY/6lqceMd8lWMznLn
         SmL3AtHEdHWEn1yKgCGPlKKul/LCf1PmTreVAlQ10jaHPvUp+mlcU6KufPbpFbJSn8G9
         Wmx/76By/jU/XEB5byRKIGhX5JX4fMhqFG3N2Ah8NmdG7jWWwVoqOTXKUznaonMXr3L2
         cHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684383450; x=1686975450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhDH77Vm7x2oymCccWNYX5/coR9dTpwzl5TaxOdCCvs=;
        b=XUks7cGRVX1ZP7kwo31oHQ7Ije92jnggyuiRBlNfKJe3/ysu3x9jB3nk02wD8dDczZ
         b0J30ghNF8YzDFBf2ZSphK8fmjjjqPPFgamjU2UlCacw1KgkwA/xIrgjf+gCTiEq2pGp
         eMoncc1TGpER00YPoK0/PY3FGI00D2XS9o02jk+A0N1mNs1RDht1eOyOb/Kn9P6MdVMY
         sPdeNZnKVOKfVRbdY8ooliTfbIRvNSYhpZVQt/oEtxFJeYkGk/dV4tmfw9htktFHwtcJ
         dZUNEUVV6YYFRkGUC5KCptO2jV+cVKfmIPZ5VjcIC6UafCJKbDiNMpStdJISfAXdWGRS
         ++aA==
X-Gm-Message-State: AC+VfDy3TEkiwlMmICGp4I1jffGFQStEjhDigfYDH5P9/EKTeKd6dppc
        p82R0gQIzbhHlfm6EvKQmzmYlTv3CZRBt45Y9NA=
X-Google-Smtp-Source: ACHHUZ6lvonfAuKeDA66c2xfYYc07vNLakDKOrykUDm39vXbCfXTe15jptBihxzoazviBDd25zfveCFv2kvI6yvTwqs=
X-Received: by 2002:a17:902:e5ce:b0:1a9:2a9e:30a8 with SMTP id
 u14-20020a170902e5ce00b001a92a9e30a8mr1272902plf.9.1684383450164; Wed, 17 May
 2023 21:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683791148.git.haibo1.xu@intel.com> <751a84a9691c86df0e65cdb02abf1e073892d1ca.1683791148.git.haibo1.xu@intel.com>
 <20230511-28ec368a8168342c68ca2187@orel>
In-Reply-To: <20230511-28ec368a8168342c68ca2187@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Thu, 18 May 2023 12:17:18 +0800
Message-ID: <CAJve8okVFr-m6go6dCg7Cf=Uq3Yt9Xmxi0Z3B2vbWvahvx4GgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Add riscv get-reg-list test
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 17, 2023 at 7:06=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, May 11, 2023 at 05:22:49PM +0800, Haibo Xu wrote:
> > get-reg-list test is used to check for KVM registers regressions
> > during VM migration which happens when destination host kernel
> > missing registers that the source host kernel has. The blessed
> > list registers was created by running on v6.2.
>
> v6.2? But get-reg-list is getting introduced with this patch, so it'll
> land in a 6.4 rc at the earliest. I don't see how can we generate the
> initial blessed list with anything earlier?
>
Thanks for pointing this out!

The story is, initially, the patch was developed and verified based on
our local v6.2 kernel tree.
According to my understanding, the blessed list should include the
minimum set of registers that
a platform should support(pls correct me if I was wrong) and registers
in v6.2 seem to meet the
requirement, so I chose the blessed list based on it.

To be frank, the comments above was a little misleading and I'll
change it to v6.4 since both v6.2
and v6.4 do have similar registers support.

> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/Makefile          |   3 +
> >  .../selftests/kvm/include/riscv/processor.h   |   3 +
> >  .../selftests/kvm/riscv/get-reg-list.c        | 869 ++++++++++++++++++
> >  3 files changed, 875 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/riscv/get-reg-list.c
> >
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selft=
ests/kvm/Makefile
> > index 7a5ff646e7e7..fbb2e984297a 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -13,6 +13,8 @@ else ifeq ($(ARCH),arm64)
> >       ARCH_DIR :=3D aarch64
> >  else ifeq ($(ARCH),s390)
> >       ARCH_DIR :=3D s390x
> > +else ifeq ($(ARCH),riscv)
> > +     ARCH_DIR :=3D riscv
> >  else
> >       ARCH_DIR :=3D $(ARCH)
> >  endif
> > @@ -171,6 +173,7 @@ TEST_GEN_PROGS_s390x +=3D rseq_test
> >  TEST_GEN_PROGS_s390x +=3D set_memory_region_test
> >  TEST_GEN_PROGS_s390x +=3D kvm_binary_stats_test
> >
> > +TEST_GEN_PROGS_riscv +=3D riscv/get-reg-list
> >  TEST_GEN_PROGS_riscv +=3D demand_paging_test
> >  TEST_GEN_PROGS_riscv +=3D dirty_log_test
> >  TEST_GEN_PROGS_riscv +=3D kvm_create_max_vcpus
> > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/to=
ols/testing/selftests/kvm/include/riscv/processor.h
> > index d00d213c3805..0adf9cb34126 100644
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
> > +                                          idx, KVM_REG_SIZE_U64)
>
>                                                   ^ KVM_REG_SIZE_ULONG
>

Will fix it in next version, thanks!

> > +
> >  /* L3 index Bit[47:39] */
> >  #define PGTBL_L3_INDEX_MASK                  0x0000FF8000000000ULL
> >  #define PGTBL_L3_INDEX_SHIFT                 39
> > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/t=
esting/selftests/kvm/riscv/get-reg-list.c
> > new file mode 100644
> > index 000000000000..dec1df0c6e72
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > @@ -0,0 +1,869 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Check for KVM_GET_REG_LIST regressions.
> > + *
> > + * Copyright (C) 2020, Red Hat, Inc.
> > + * Copyright (c) 2023 Intel Corporation
> > + *
> > + * The test was port from the get-reg-list.c on aarch64.
> > + */
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <sys/types.h>
> > +#include <sys/wait.h>
> > +#include "kvm_util.h"
> > +#include "test_util.h"
> > +#include "processor.h"
> > +
> > +static struct kvm_reg_list *reg_list;
> > +static __u64 *blessed_reg, blessed_n;
> > +
> > +struct reg_sublist {
> > +     const char *name;
> > +     long capability;
> > +     __u64 *regs;
> > +     __u64 regs_n;
> > +     __u64 *rejects_set;
> > +     __u64 rejects_set_n;
> > +};
> > +
> > +struct vcpu_config {
> > +     char *name;
> > +     struct reg_sublist sublists[];
> > +};
> > +
> > +static struct vcpu_config *vcpu_configs[];
> > +static int vcpu_configs_n;
> > +
> > +#define for_each_sublist(c, s)                                        =
       \
> > +     for ((s) =3D &(c)->sublists[0]; (s)->regs; ++(s))
> > +
> > +#define for_each_reg(i)                                               =
               \
> > +     for ((i) =3D 0; (i) < reg_list->n; ++(i))
> > +
> > +#define for_each_missing_reg(i)                                       =
       \
> > +     for ((i) =3D 0; (i) < blessed_n; ++(i))                   \
> > +             if (!find_reg(reg_list->reg, reg_list->n, blessed_reg[i])=
)
> > +
> > +#define for_each_new_reg(i)                                           =
       \
> > +     for_each_reg(i)                                                  =
               \
> > +             if (!find_reg(blessed_reg, blessed_n, reg_list->reg[i]))
> > +
> > +static const char *config_name(struct vcpu_config *c)
> > +{
> > +     struct reg_sublist *s;
> > +     int len =3D 0;
> > +
> > +     if (c->name)
> > +             return c->name;
> > +
> > +     for_each_sublist(c, s)
> > +             len +=3D strlen(s->name) + 1;
> > +
> > +     c->name =3D malloc(len);
> > +
> > +     len =3D 0;
> > +     for_each_sublist(c, s) {
> > +             if (!strcmp(s->name, "base"))
> > +                     continue;
> > +             strcat(c->name + len, s->name);
> > +             len +=3D strlen(s->name) + 1;
> > +             c->name[len - 1] =3D '+';
> > +     }
> > +     c->name[len - 1] =3D '\0';
> > +
> > +     return c->name;
> > +}
> > +
> > +static bool find_reg(__u64 regs[], __u64 nr_regs, __u64 reg)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < nr_regs; ++i)
> > +             if (reg =3D=3D regs[i])
> > +                     return true;
> > +     return false;
> > +}
> > +
> > +static const char *str_with_index(const char *template, __u64 index)
> > +{
> > +     char *str, *p;
> > +     int n;
> > +
> > +     str =3D strdup(template);
> > +     p =3D strstr(str, "##");
> > +     n =3D sprintf(p, "%lld", index);
> > +     strcat(p + n, strstr(template, "##") + 2);
> > +
> > +     return (const char *)str;
> > +}
> > +
> > +#define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK)
> > +
> > +static const char *config_id_to_str(struct vcpu_config *c, __u64 id)
> > +{
> > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_CONFIG);
> > +
> > +     /*
> > +      * reg_off is the offset into struct kvm_riscv_config
> > +      */
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
> > +     default:
> > +             /* Config regs would grow regularly with new pseudo reg a=
dded, so
> > +              * just show "##UNKNOWN##" to indicate a new pseudo confi=
g reg.
> > +              */
> > +             printf("%s: Unknown config reg id: 0x%llx", config_name(c=
), id);
> > +             return "##UNKNOWN##";
>
> The idea of these *to_str functions is to dump output that can be
> copy+pasted into a reg array (hence the trailing commas in print_reg
> lines). So we can't just print random lines here or return '##UNKOWN##',
> as that won't compile. Instead, the default should return
>
>   str_with_index("KVM_REG_RISCV_CONFIG_REG(##)", reg_off)
>

Thanks for sharing the detailed idea, will fix it in next version!

> > +     }
> > +}
> > +
> > +static const char *core_id_to_str(struct vcpu_config *c, __u64 id)
> > +{
> > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_CORE);
> > +
> > +     /*
> > +      * reg_off is the offset into struct kvm_riscv_core
> > +      */
> > +     switch (reg_off) {
> > +     case KVM_REG_RISCV_CORE_REG(regs.pc):
> > +             return "KVM_REG_RISCV_CORE_REG(regs.pc)";
> > +     case KVM_REG_RISCV_CORE_REG(regs.ra) ...
> > +          KVM_REG_RISCV_CORE_REG(regs.t6):
> > +             return str_with_index("KVM_REG_RISCV_CORE_REG(regs.regs[#=
#])", reg_off);
> > +     case KVM_REG_RISCV_CORE_REG(mode):
> > +             return "KVM_REG_RISCV_CORE_REG(mode)";
> > +     }
> > +
> > +     TEST_FAIL("%s: Unknown core reg id: 0x%llx", config_name(c), id);
> > +     return NULL;
> > +}
> > +
> > +static const char *general_csr_id_to_str(__u64 reg_off)
> > +{
> > +     /*
> > +      * reg_off is the offset into struct kvm_riscv_csr
> > +      */
> > +     switch (reg_off) {
> > +     case KVM_REG_RISCV_CSR_REG(sstatus):
> > +             return "KVM_REG_RISCV_CSR_REG(sstatus)";
>
> We also need the subtype. So this should be something like
>
>  #define CSR_GENERAL(csr) \
>      "KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(" #csr ")"
>
>   return CSR_GENERAL(sstatus);
>
> and similar below for the AIA CSRs.
>

Sure, thanks for the suggestion!

> > +     case KVM_REG_RISCV_CSR_REG(sie):
> > +             return "KVM_REG_RISCV_CSR_REG(sie)";
> > +     case KVM_REG_RISCV_CSR_REG(stvec):
> > +             return "KVM_REG_RISCV_CSR_REG(stvec)";
> > +     case KVM_REG_RISCV_CSR_REG(sscratch):
> > +             return "KVM_REG_RISCV_CSR_REG(sscratch)";
> > +     case KVM_REG_RISCV_CSR_REG(sepc):
> > +             return "KVM_REG_RISCV_CSR_REG(sepc)";
> > +     case KVM_REG_RISCV_CSR_REG(scause):
> > +             return "KVM_REG_RISCV_CSR_REG(scause)";
> > +     case KVM_REG_RISCV_CSR_REG(stval):
> > +             return "KVM_REG_RISCV_CSR_REG(stval)";
> > +     case KVM_REG_RISCV_CSR_REG(sip):
> > +             return "KVM_REG_RISCV_CSR_REG(sip)";
> > +     case KVM_REG_RISCV_CSR_REG(satp):
> > +             return "KVM_REG_RISCV_CSR_REG(satp)";
> > +     case KVM_REG_RISCV_CSR_REG(scounteren):
> > +             return "KVM_REG_RISCV_CSR_REG(scounteren)";
> > +     default:
> > +             TEST_FAIL("Unknown general csr reg: 0x%llx", reg_off);
> > +             return NULL;
>
> nit: It'd be nice to have a pattern for this TEST_FAIL. Either
> outside the switch and not have a default or always the default.
> It seems to be changing function by function.
>

Will unify the pattern in next version.

> > +     }
> > +}
> > +
> > +static const char *aia_csr_id_to_str(__u64 reg_off)
> > +{
> > +     /*
> > +      * reg_off is the offset into struct kvm_riscv_aia_csr
> > +      */
> > +     switch (reg_off) {
> > +     case KVM_REG_RISCV_CSR_AIA_REG(siselect):
> > +             return "KVM_REG_RISCV_CSR_AIA_REG(siselect)";
> > +     case KVM_REG_RISCV_CSR_AIA_REG(iprio1):
> > +             return "KVM_REG_RISCV_CSR_AIA_REG(iprio1)";
> > +     case KVM_REG_RISCV_CSR_AIA_REG(iprio2):
> > +             return "KVM_REG_RISCV_CSR_AIA_REG(iprio2)";
> > +     case KVM_REG_RISCV_CSR_AIA_REG(sieh):
> > +             return "KVM_REG_RISCV_CSR_AIA_REG(sieh)";
> > +     case KVM_REG_RISCV_CSR_AIA_REG(siph):
> > +             return "KVM_REG_RISCV_CSR_AIA_REG(siph)";
> > +     case KVM_REG_RISCV_CSR_AIA_REG(iprio1h):
> > +             return "KVM_REG_RISCV_CSR_AIA_REG(iprio1h)";
> > +     case KVM_REG_RISCV_CSR_AIA_REG(iprio2h):
> > +             return "KVM_REG_RISCV_CSR_AIA_REG(iprio2h)";
> > +     default:
> > +             TEST_FAIL("Unknown aia csr reg: 0x%llx", reg_off);
> > +             return NULL;
> > +     }
> > +}
> > +
> > +static const char *csr_id_to_str(struct vcpu_config *c, __u64 id)
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
> > +     default:
> > +             TEST_FAIL("%s: Unknown csr reg id: 0x%llx", config_name(c=
), id);
>
> Maybe better to report "unknown subtype"?
>

Yes, the default should cover all unknown subtype.

> > +             return NULL;
> > +     }
> > +}
> > +
> > +static const char *timer_id_to_str(struct vcpu_config *c, __u64 id)
> > +{
> > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_TIMER);
> > +
> > +     /*
> > +      * reg_off is the offset into struct kvm_riscv_timer
> > +      */
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
> > +     TEST_FAIL("%s: Unknown timer reg id: 0x%llx", config_name(c), id)=
;
> > +     return NULL;
> > +}
> > +
> > +static const char *fp_f_id_to_str(struct vcpu_config *c, __u64 id)
> > +{
> > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_FP_F);
> > +
> > +     /*
> > +      * reg_off is the offset into struct __riscv_f_ext_state
> > +      */
> > +     switch (reg_off) {
> > +     case KVM_REG_RISCV_FP_F_REG(f[0]) ...
> > +          KVM_REG_RISCV_FP_F_REG(f[31]):
> > +             return str_with_index("KVM_REG_RISCV_FP_F_REG(f[##])", re=
g_off);
> > +     case KVM_REG_RISCV_FP_F_REG(fcsr):
> > +             return "KVM_REG_RISCV_FP_F_REG(fcsr)";
> > +     }
> > +
> > +     TEST_FAIL("%s: Unknown fp_f reg id: 0x%llx", config_name(c), id);
> > +     return NULL;
> > +}
> > +
> > +static const char *fp_d_id_to_str(struct vcpu_config *c, __u64 id)
> > +{
> > +     __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_FP_D);
> > +
> > +     /*
> > +      * reg_off is the offset into struct __riscv_d_ext_state
> > +      */
> > +     switch (reg_off) {
> > +     case KVM_REG_RISCV_FP_D_REG(f[0]) ...
> > +          KVM_REG_RISCV_FP_D_REG(f[31]):
> > +             return str_with_index("KVM_REG_RISCV_FP_D_REG(f[##])", re=
g_off);
> > +     case KVM_REG_RISCV_FP_D_REG(fcsr):
> > +             return "KVM_REG_RISCV_FP_D_REG(fcsr)";
> > +     }
> > +
> > +     TEST_FAIL("%s: Unknown fp_d reg id: 0x%llx", config_name(c), id);
> > +     return NULL;
> > +}
> > +
> > +static const char *isa_ext_id_to_str(struct vcpu_config *c, __u64 id)
> > +{
> > +     /*
> > +      * reg_off is the offset into unsigned long kvm_isa_ext_arr[]
> > +      */
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
> > +             /* isa_ext regs would grow regularly with new isa extensi=
on added, so
> > +              * just show "##UNKNOWN##" to indicate a new extension.
> > +              */
> > +             printf("%s: Unsupported isa ext reg id 0x%llx", config_na=
me(c), id);
> > +             return "##UNKNOWN##";
>
> This should be
>
>   return str_with_index("##", id);
>
> so it can compile.
>

Sure, thanks!

> > +     }
> > +
> > +     return kvm_isa_ext_reg_name[reg_off];
> > +}
> > +
> > +static const char *sbi_ext_single_id_to_str(__u64 reg_off)
> > +{
> > +     /*
> > +      * reg_off is KVM_RISCV_SBI_EXT_ID
> > +      */
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
> > +     if (reg_off >=3D KVM_RISCV_SBI_EXT_MAX) {
> > +             /* sbi_ext regs would grow regularly with new sbi extensi=
on added, so
> > +              * just show "##UNKNOWN##" to indicate a new extension.
> > +              */
> > +             printf("Unsupported sbi ext single reg 0x%llx", reg_off);
> > +             return "##UNKNOWN##";
>
>   return str_with_index("##", id);
>

Sure, thanks!

> > +     }
> > +
> > +     return kvm_sbi_ext_reg_name[reg_off];
> > +}
> > +
> > +static const char *sbi_ext_multi_id_to_str(__u64 reg_subtype, __u64 re=
g_off)
> > +{
> > +     if (reg_off > KVM_REG_RISCV_SBI_MULTI_REG_LAST) {
> > +             /* sbi_ext regs would grow regularly with new sbi extensi=
on added, so
> > +              * just show "##UNKNOWN##" to indicate a new extension.
>
> It'll only grow every 64 SBI extensions, so it won't be very regular.
>

Yes, just in case for any illegal value.

> > +              */
> > +             printf("Unsupported sbi ext multi reg: 0x%llx", reg_off);
> > +             return "##UNKNOWN##";
> > +     }
> > +
> > +     switch (reg_subtype) {
> > +     case KVM_REG_RISCV_SBI_MULTI_EN:
> > +             return str_with_index("KVM_RISCV_SBI_MULTI_EN[##]", reg_o=
ff);
>
> KVM_RISCV_SBI_MULTI_EN[] doesn't exist, so that won't compile. This shoul=
d
> be
>
>   str_with_index("KVM_REG_RISCV_SBI_MULTI_EN | ##", reg_off)
>
> > +     case KVM_REG_RISCV_SBI_MULTI_DIS:
> > +             return str_with_index("KVM_RISCV_SBI_MULTI_DIS[##]", reg_=
off);
>
>   str_with_index("KVM_REG_RISCV_SBI_MULTI_DIS | ##", reg_off)
>

Sure, thanks!

> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +static const char *sbi_ext_id_to_str(struct vcpu_config *c, __u64 id)
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
> > +     TEST_FAIL("%s: Unknown sbi ext reg id: 0x%llx", config_name(c), i=
d);
>
> Maybe better to report "unknown subtype"?
>

Sure, thanks!

> > +     return NULL;
> > +}
> > +
> > +static void print_reg(struct vcpu_config *c, __u64 id)
> > +{
> > +     const char *reg_size =3D NULL;
> > +
> > +     TEST_ASSERT((id & KVM_REG_ARCH_MASK) =3D=3D KVM_REG_RISCV,
> > +                 "%s: KVM_REG_RISCV missing in reg id: 0x%llx", config=
_name(c), id);
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
> > +                       config_name(c), (id & KVM_REG_SIZE_MASK) >> KVM=
_REG_SIZE_SHIFT, id);
> > +     }
> > +
> > +     switch (id & KVM_REG_RISCV_TYPE_MASK) {
> > +     case KVM_REG_RISCV_CONFIG:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CONFIG | %s,=
\n",
> > +                             reg_size, config_id_to_str(c, id));
> > +             break;
> > +     case KVM_REG_RISCV_CORE:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CORE | %s,\n=
",
> > +                             reg_size, core_id_to_str(c, id));
> > +             break;
> > +     case KVM_REG_RISCV_CSR:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CSR | %s,\n"=
,
> > +                             reg_size, csr_id_to_str(c, id));
> > +             break;
> > +     case KVM_REG_RISCV_TIMER:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_TIMER | %s,\=
n",
> > +                             reg_size, timer_id_to_str(c, id));
> > +             break;
> > +     case KVM_REG_RISCV_FP_F:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_F | %s,\n=
",
> > +                             reg_size, fp_f_id_to_str(c, id));
> > +             break;
> > +     case KVM_REG_RISCV_FP_D:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_D | %s,\n=
",
> > +                             reg_size, fp_d_id_to_str(c, id));
> > +             break;
> > +     case KVM_REG_RISCV_ISA_EXT:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_ISA_EXT | %s=
,\n",
> > +                             reg_size, isa_ext_id_to_str(c, id));
> > +             break;
> > +     case KVM_REG_RISCV_SBI_EXT:
> > +             printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_SBI_EXT | %s=
,\n",
> > +                             reg_size, sbi_ext_id_to_str(c, id));
> > +             break;
> > +     default:
> > +             TEST_FAIL("%s: Unexpected reg type: 0x%llx in reg id: 0x%=
llx", config_name(c),
> > +                             (id & KVM_REG_RISCV_TYPE_MASK) >> KVM_REG=
_RISCV_TYPE_SHIFT, id);
> > +     }
> > +}
> > +
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
> > +static void check_supported(struct kvm_vcpu *vcpu, struct vcpu_config =
*c)
> > +{
> > +     struct reg_sublist *s;
> > +
> > +     for_each_sublist(c, s) {
> > +             if (!s->capability)
> > +                     continue;
> > +
> > +             __TEST_REQUIRE(vcpu_has_ext(vcpu, s->capability),
> > +                            "%s: %s not available, skipping tests\n",
> > +                            config_name(c), s->name);
> > +     }
> > +}
> > +
> > +static bool print_list;
> > +
> > +static void run_test(struct vcpu_config *c)
> > +{
> > +     int new_regs =3D 0, missing_regs =3D 0, i, n;
> > +     int failed_get =3D 0, failed_set =3D 0;
> > +     struct kvm_vcpu *vcpu;
> > +     struct kvm_vm *vm;
> > +     struct reg_sublist *s;
> > +
> > +     vm =3D vm_create_barebones();
> > +     vcpu =3D __vm_vcpu_add(vm, 0);
> > +
> > +     check_supported(vcpu, c);
> > +
> > +     reg_list =3D vcpu_get_reg_list(vcpu);
> > +
> > +     if (print_list) {
> > +             putchar('\n');
> > +             for_each_reg(i) {
> > +                     __u64 id =3D reg_list->reg[i];
> > +
> > +                     if (print_list)
> > +                             print_reg(c, id);
> > +             }
> > +             putchar('\n');
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * We only test that we can get the register and then write back =
the
> > +      * same value.
> > +      */
> > +     for_each_reg(i) {
> > +             uint8_t addr[128 / 8];
> > +             struct kvm_one_reg reg =3D {
> > +                     .id =3D reg_list->reg[i],
> > +                     .addr =3D (__u64)&addr,
> > +             };
> > +             bool reject_reg =3D false;
> > +             int ret;
> > +
> > +             ret =3D __vcpu_get_reg(vcpu, reg_list->reg[i], &addr);
> > +             if (ret) {
> > +                     printf("%s: Failed to get ", config_name(c));
> > +                     print_reg(c, reg.id);
> > +                     putchar('\n');
> > +                     ++failed_get;
> > +             }
> > +
> > +             /* rejects_set registers are skipped for setting test */
> > +             for_each_sublist(c, s) {
> > +                     if (s->rejects_set && find_reg(s->rejects_set, s-=
>rejects_set_n, reg.id)) {
> > +                             reject_reg =3D true;
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             if (!reject_reg) {
> > +                     ret =3D __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg)=
;
> > +                     /* Registers that don't support set operation sho=
uld pass */
> > +                     if (ret && errno !=3D EOPNOTSUPP) {
> > +                             printf("%s: Failed to set ", config_name(=
c));
> > +                             print_reg(c, reg.id);
> > +                             putchar('\n');
> > +                             ++failed_set;
> > +                     }
> > +             }
> > +     }
> > +
> > +     for_each_sublist(c, s)
> > +             blessed_n +=3D s->regs_n;
> > +     blessed_reg =3D calloc(blessed_n, sizeof(__u64));
> > +
> > +     n =3D 0;
> > +     for_each_sublist(c, s) {
> > +             for (i =3D 0; i < s->regs_n; ++i)
> > +                     blessed_reg[n++] =3D s->regs[i];
> > +     }
> > +
> > +     for_each_new_reg(i)
> > +             ++new_regs;
> > +
> > +     for_each_missing_reg(i)
> > +             ++missing_regs;
> > +
> > +     if (new_regs || missing_regs) {
> > +             printf("%s: Number blessed registers: %5lld\n", config_na=
me(c), blessed_n);
> > +             printf("%s: Number registers:         %5lld\n", config_na=
me(c), reg_list->n);
> > +     }
> > +
> > +     if (new_regs) {
> > +             printf("\n%s: There are %d new registers.\n"
> > +                    "Consider adding them to the blessed reg "
> > +                    "list with the following lines:\n\n", config_name(=
c), new_regs);
> > +             for_each_new_reg(i)
> > +                     print_reg(c, reg_list->reg[i]);
> > +             putchar('\n');
> > +     }
> > +
> > +     if (missing_regs) {
> > +             printf("\n%s: There are %d missing registers.\n"
> > +                    "The following lines are missing registers:\n\n",
> > +                             config_name(c), missing_regs);
> > +             for_each_missing_reg(i)
> > +                     print_reg(c, blessed_reg[i]);
> > +             putchar('\n');
> > +     }
> > +
> > +     TEST_ASSERT(!missing_regs && !failed_get && !failed_set,
> > +                 "%s: There are %d missing registers; "
> > +                 "%d registers failed get; %d registers failed set.",
> > +                 config_name(c), missing_regs, failed_get, failed_set)=
;
> > +
> > +     pr_info("%s: PASS\n", config_name(c));
> > +     blessed_n =3D 0;
> > +     free(blessed_reg);
> > +     free(reg_list);
> > +     kvm_vm_free(vm);
> > +}
> > +
> > +static void help(void)
> > +{
> > +     struct vcpu_config *c;
> > +     int i;
> > +
> > +     printf(
> > +     "\n"
> > +     "usage: get-reg-list [--config=3D<selection>] [--list]\n\n"
> > +     " --config=3D<selection>        Used to select a specific vcpu co=
nfiguration for the test/listing\n"
> > +     "                             '<selection>' may be\n");
> > +
> > +     for (i =3D 0; i < vcpu_configs_n; ++i) {
> > +             c =3D vcpu_configs[i];
> > +             printf(
> > +     "                               '%s'\n", config_name(c));
> > +     }
> > +
> > +     printf(
> > +     "\n"
> > +     " --list                      Print the register list rather than=
 test it (requires --config)\n"
> > +     "\n"
> > +     );
> > +}
> > +
> > +static struct vcpu_config *parse_config(const char *config)
> > +{
> > +     struct vcpu_config *c;
> > +     int i;
> > +
> > +     if (config[8] !=3D '=3D')
> > +             help(), exit(1);
> > +
> > +     for (i =3D 0; i < vcpu_configs_n; ++i) {
> > +             c =3D vcpu_configs[i];
> > +             if (strcmp(config_name(c), &config[9]) =3D=3D 0)
> > +                     break;
> > +     }
> > +
> > +     if (i =3D=3D vcpu_configs_n)
> > +             help(), exit(1);
> > +
> > +     return c;
> > +}
> > +
> > +int main(int ac, char **av)
> > +{
> > +     struct vcpu_config *c, *sel =3D NULL;
> > +     int i, ret =3D 0;
> > +     pid_t pid;
> > +
> > +     for (i =3D 1; i < ac; ++i) {
> > +             if (strncmp(av[i], "--config", 8) =3D=3D 0)
> > +                     sel =3D parse_config(av[i]);
> > +             else if (strcmp(av[i], "--list") =3D=3D 0)
> > +                     print_list =3D true;
> > +             else if (strcmp(av[i], "--help") =3D=3D 0 || strcmp(av[1]=
, "-h") =3D=3D 0)
> > +                     help(), exit(0);
> > +             else
> > +                     help(), exit(1);
> > +     }
> > +
> > +     if (print_list) {
> > +             /*
> > +              * We only want to print the register list of a single co=
nfig.
> > +              */
> > +             if (!sel)
> > +                     help(), exit(1);
> > +     }
> > +
> > +     for (i =3D 0; i < vcpu_configs_n; ++i) {
> > +             c =3D vcpu_configs[i];
> > +             if (sel && c !=3D sel)
> > +                     continue;
> > +
> > +             pid =3D fork();
> > +
> > +             if (!pid) {
> > +                     run_test(c);
> > +                     exit(0);
> > +             } else {
> > +                     int wstatus;
> > +                     pid_t wpid =3D wait(&wstatus);
> > +
> > +                     TEST_ASSERT(wpid =3D=3D pid && WIFEXITED(wstatus)=
, "wait: Unexpected return");
> > +                     if (WEXITSTATUS(wstatus) && WEXITSTATUS(wstatus) =
!=3D KSFT_SKIP)
> > +                             ret =3D KSFT_FAIL;
> > +             }
> > +     }
> > +
> > +     return ret;
> > +}
>
> We should share all the code above, except print_reg(), with aarch64.
> I'll send a patch series that splits the arch-neutral code out of
> the aarch64 test that you can base this test on.
>

Good idea! I will rebase the patch based on your work.

> > +
> > +/*
> > + * The current blessed list was primed with the output of kernel versi=
on
> > + * v6.2 and then later updated with new registers.
> > + */
> > +static __u64 base_regs[] =3D {
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG | KVM_REG=
_RISCV_CONFIG_REG(isa),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG | KVM_REG=
_RISCV_CONFIG_REG(zicbom_block_size),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG | KVM_REG=
_RISCV_CONFIG_REG(mvendorid),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG | KVM_REG=
_RISCV_CONFIG_REG(marchid),
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG | KVM_REG=
_RISCV_CONFIG_REG(mimpid),
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
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_SVPBMT,
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_SSTC,
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_SVINVAL,
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_ZIHINTPAUSE,
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RI=
SCV_ISA_EXT_ZICBOM,
>
> Any register that depends on the host having the extension, like zicbom,
> means it shouldn't be in the base register set.
>

Yes, this kind of registers should not in the base register. Will
remove them latter.

> > +};
> > +
> > +/*
> > + * The rejects_set list registers that should skip set test.
> > + *  - KVM_REG_RISCV_TIMER_REG(state): set would fail if it was not ini=
tialized properly.
> > + */
> > +static __u64 base_rejects_set[] =3D {
> > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_=
RISCV_TIMER_REG(state),
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
.rejects_set =3D base_rejects_set, \
> > +             .rejects_set_n =3D ARRAY_SIZE(base_rejects_set),}
> > +#define FP_F_REGS_SUBLIST \
> > +     {"fp_f_regs", .capability =3D KVM_RISCV_ISA_EXT_F, .regs =3D fp_f=
_regs, \
> > +             .regs_n =3D ARRAY_SIZE(fp_f_regs),}
> > +#define FP_D_REGS_SUBLIST \
> > +     {"fp_d_regs", .capability =3D KVM_RISCV_ISA_EXT_D, .regs =3D fp_d=
_regs, \
> > +             .regs_n =3D ARRAY_SIZE(fp_d_regs),}
> > +
> > +static struct vcpu_config fp_f_d_config =3D {
> > +     .sublists =3D {
> > +     BASE_SUBLIST,
> > +     FP_F_REGS_SUBLIST,
> > +     FP_D_REGS_SUBLIST,
> > +     {0},
> > +     },
> > +};
> > +
> > +static struct vcpu_config *vcpu_configs[] =3D {
> > +     &fp_f_d_config,
> > +};
> > +static int vcpu_configs_n =3D ARRAY_SIZE(vcpu_configs);
> > --
> > 2.34.1
> >
>
> Thanks,
> drew
