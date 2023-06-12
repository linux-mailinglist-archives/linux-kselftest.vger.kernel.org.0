Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F159172BB76
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 11:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjFLJBb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 05:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjFLJAy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 05:00:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D913A97
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 01:57:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98220bb31c6so71767166b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 01:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686560232; x=1689152232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vq/s2M0H1YpBEWwWc84/BK1dGfh4JEMbe1jCjTxpQG8=;
        b=Zvx3pTxmhOCcdamy0jWfgspLI2c3P25QDH2fEU6KcaeNBB6wCOvuCsH1DfCXlY2rix
         GrwNavx2wp06jiwkRSKkY0N5B2CJfz55RsHEgCIsDB3+MxNeZjdXEhFet1Xw+Y67EmwQ
         K3Zab7ithsSmsFQ+z/qGmc+xLIZJmCPFrejmURK9QPWLkpm2U8CoXlxYW7BO4TnXyqEr
         XoE1E14eGPqZvGCegno53VJkXOqjTQwLAyadxhZGk1AWPRKR0WnMFXAa7tXgdbgq2A5W
         Aqanwi7bsKdI/iUh2wwfo7IuP5Dq+f8i+kydMxd2M2oShZ+176nddxHBzoxVQGr2esz6
         VdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686560232; x=1689152232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq/s2M0H1YpBEWwWc84/BK1dGfh4JEMbe1jCjTxpQG8=;
        b=dBSIXgJ7PaPdxVr+ZlEW4H386lDr/Cf4TYLi0HO3As0wpTcVjFruG3+iwpsSMxhkhl
         H4W9Pi6MHqoS8vw0FkLBqxaGaH4Ob9IVydi8vd7Nbqg5lIvanNqJ+Lbe1NomM7zmCkV+
         lZ3Fok88TeOtVtBRTht933sI0nd0cG+2c+rS89JYLPhTOD4stisQ9vt5iWE6k+EweIAg
         I4ox9wVACGF9j653f0/X7V1vAYy9ie3sjOn2UiwGkZdR0vYuQRZjD2u5OM7ZOKTkkvOO
         T7zE5hPtjrVpe6vLJbERTIi5g2UhUh1egmaqqomVoAMzRLnOaPhFZm+Q6Dy2FGcryNoU
         V/Mg==
X-Gm-Message-State: AC+VfDz3ymanFkwv/ocfz+SuWzkgdwleYy88huC5fx5f2AAYvLLeXnzn
        7Vay7TUqUt0RM6+CDLKuBlAYhA==
X-Google-Smtp-Source: ACHHUZ4FOO/LVl8AgQkKecgccHHS4sYRKVgWaVzPYmir3ayy2BYmRbvmSwzE3ppomAG9QgpBstEahg==
X-Received: by 2002:a17:906:7945:b0:978:8e58:e1b9 with SMTP id l5-20020a170906794500b009788e58e1b9mr9960520ejo.74.1686560231841;
        Mon, 12 Jun 2023 01:57:11 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm4849967ejd.221.2023.06.12.01.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 01:57:11 -0700 (PDT)
Date:   Mon, 12 Jun 2023 10:57:10 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <xiaobo55x@gmail.com>
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
Subject: Re: [PATCH v3 09/10] KVM: riscv: selftests: Skip some registers set
 operation
Message-ID: <20230612-05314de3b73277af1ee729b0@orel>
References: <cover.1686275310.git.haibo1.xu@intel.com>
 <73045958d9ab71d5266d012f1e13061afa8c5331.1686275310.git.haibo1.xu@intel.com>
 <20230609-05521f954b0485c69612f00b@orel>
 <CAJve8omPV_XgCSvw8POZwisb6uTOFMJU4FyAKArryui2SAsqtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8omPV_XgCSvw8POZwisb6uTOFMJU4FyAKArryui2SAsqtw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 10, 2023 at 10:35:24AM +0800, Haibo Xu wrote:
> On Fri, Jun 9, 2023 at 5:24 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Fri, Jun 09, 2023 at 10:12:17AM +0800, Haibo Xu wrote:
> > > Set operation on some riscv registers(mostly pesudo ones) was not
> > > supported and should be skipped in the get-reg-list test. Just
> > > reuse the rejects_set utilities to handle it in riscv.
> > >
> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > ---
> > >  tools/testing/selftests/kvm/get-reg-list.c | 20 +++++++++++++-------
> > >  1 file changed, 13 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
> > > index c4bd5a5259da..abacb95c21c6 100644
> > > --- a/tools/testing/selftests/kvm/get-reg-list.c
> > > +++ b/tools/testing/selftests/kvm/get-reg-list.c
> > > @@ -211,16 +211,22 @@ static void run_test(struct vcpu_reg_list *c)
> > >                       ++failed_get;
> > >               }
> > >
> > > -             /* rejects_set registers are rejected after KVM_ARM_VCPU_FINALIZE */
> > > +             /*
> > > +              * rejects_set registers are rejected after KVM_ARM_VCPU_FINALIZE on aarch64,
> > > +              * or registers that should skip set operation on riscv.
> > > +              */
> > >               for_each_sublist(c, s) {
> > >                       if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
> > >                               reject_reg = true;
> > > -                             ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
> > > -                             if (ret != -1 || errno != EPERM) {
> > > -                                     printf("%s: Failed to reject (ret=%d, errno=%d) ", config_name(c), ret, errno);
> > > -                                     print_reg(config_name(c), reg.id);
> > > -                                     putchar('\n');
> > > -                                     ++failed_reject;
> > > +                             if ((reg.id & KVM_REG_ARCH_MASK) == KVM_REG_ARM64) {
> > > +                                     ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
> > > +                                     if (ret != -1 || errno != EPERM) {
> > > +                                             printf("%s: Failed to reject (ret=%d, errno=%d) ",
> > > +                                                             config_name(c), ret, errno);
> > > +                                             print_reg(config_name(c), reg.id);
> > > +                                             putchar('\n');
> > > +                                             ++failed_reject;
> > > +                                     }
> >
> > Thinking about this some more, shouldn't we attempt the set ioctl for
> > riscv reject registers as well, but look for different error numbers?
> >
> 
> Yes, we can. Currently, 2 different errno(EOPNOTSUPP/EINVAL) would be
> reported for the rejected registers in risc-v.
> These 2 errnos can be handled specially like below:
> 
> diff --git a/tools/testing/selftests/kvm/get-reg-list.c
> b/tools/testing/selftests/kvm/get-reg-list.c
> index 73f40e0842b8..f3f2c4519318 100644
> --- a/tools/testing/selftests/kvm/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/get-reg-list.c
> @@ -255,6 +255,15 @@ static void run_test(struct vcpu_reg_list *c)
>                                                 putchar('\n');
>                                                 ++failed_reject;
>                                         }
> +                } else {
> +                                       ret = __vcpu_ioctl(vcpu,
> KVM_SET_ONE_REG, &reg);
> +                                       if (ret != -1 || (errno !=
> EINVAL && errno != EOPNOTSUPP)) {
> +                                               printf("%s: Failed to
> reject (ret=%d, errno=%d) ",
> +
> config_name(c), ret, errno);
> +
> print_reg(config_name(c), reg.id);
> +                                               putchar('\n');
> +                                               ++failed_reject;
> +                                       }

Instead of duplicating the code Arm uses, we just need an errno check
function, preferably one that takes the register as an input, so we
can check for specific errnos for specific registers.

> 
> One possible issue for the above change is that when new registers
> that don't support sets were added, we need
> to add them to the reject registers list, or the test would fail.
> 
> Initially, in the v1 patch, the design was to just skip the EOPNOTSUPP
> errno in set operations for all registers
> since it's a known errno for registers that don't support sets. This
> change cover all the registers even for future
> new ones.
> 
> What's your opinion?

I think we should only do the get/set tests on present, blessed list
registers, since if it's a new register we don't know its capabilities.

So, instead of

  for_each_reg(i) {
     /* get/set tests */
  }

we do
  
  for_each_present_blessed_reg(i) {
     /* get/set tests */
  }

where we have

 #define for_each_present_blessed_reg(i) \
     for ((i) = 0; (i) < blessed_n; ++(i)) \
         if (find_reg(reg_list->reg, reg_list->n, blessed_reg[i]))


Changing run_test() to work this way should be a separate patch.

Thanks,
drew
