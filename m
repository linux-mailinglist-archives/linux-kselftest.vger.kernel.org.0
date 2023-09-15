Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCCF7A15EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 08:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjIOGOg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 02:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjIOGOf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 02:14:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198E42718;
        Thu, 14 Sep 2023 23:14:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-500c7796d8eso2956169e87.1;
        Thu, 14 Sep 2023 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694758467; x=1695363267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bl/6t9mcAclJ4xtGmBPz2BA7FLMNa6WCNrJXbkl0XGU=;
        b=gW9heNLweKuMlM9WxuQkoUQIdn26kA7bZ4ukaSf/Lekxo+NmGeUx0AWaRIW2be06Hc
         BruoWd9UdVPWxyETL3bMzZrk5EcuJty5F0O0+HkPrlPgDuQAPZJpoiSP/s9pqw9hQ/5M
         ch/Gh+G0dzooKjv7ppuuiLpuZ+uZ9ou43jcQe4orIU1JmRq47RT9UgxvK06+h9GSwche
         q/hwRvjwW12EUnLGwCd1HZq6COkK5B+IaZtqJ75p9HR5XcP4LeZNht9/AsJht3woheXH
         Pb6DAuABGnmdhJtfJ9MbBJB1BCVn18k8QdFB4dzeHwEXCqqppfILqA04e7ZEqy4UoZXz
         vNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694758467; x=1695363267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bl/6t9mcAclJ4xtGmBPz2BA7FLMNa6WCNrJXbkl0XGU=;
        b=f6SDi8N40wIE63eH3Ngg6z2+J/DIcsHbFNYpKv7BbUaxQiTiDbnn9nsHKzmWu2ePhy
         Bn4xBRDMFj/PpCVGe1UqPJkBJvwRoimuEjtUDvb9quv0QlfcfV16gHHZyklde68yKfKv
         wgiJGxbNJvou7HGlKEgp3edfVCVI+4fpULdRpia8cEOUIAeuK4jsD1L4SI+nxV2UqM7N
         rBbi4bwxzhpkVBvyXveyfdn97936oMGnm81WrNdrYLZ9s/wmZrYW8lEP4Vadjv1f6iDM
         DZ0uSLLCHvWx3i+eD2Jin0fgUfpPIaIEeJpk8pyiKlNNeWIiKcHeENSHNLvmiwW4Gryj
         7KoQ==
X-Gm-Message-State: AOJu0YxsZwnDBSAywJIjvwjSepUtnTD6SezZAHJpc0Cw7X8CK/ylshYJ
        fRg24IbqfUpz/cQWX/k6rXQRi8a3zHFnQ9FJFyE=
X-Google-Smtp-Source: AGHT+IGhJVx1DybM3iYFALHT+fRtR3Sb1TxgK5u1dydWHyG0LYewVIconr2UDCXmyWWs9uSdF346GuK7kKVFChhTmWE=
X-Received: by 2002:ac2:4831:0:b0:500:9dd4:2969 with SMTP id
 17-20020ac24831000000b005009dd42969mr572676lft.59.1694758466969; Thu, 14 Sep
 2023 23:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694421911.git.haibo1.xu@intel.com> <dd81ef2b87e4cc160cb0ee782010dcf3543e065a.1694421911.git.haibo1.xu@intel.com>
 <20230914-d6645bbc5ac80999674e9685@orel>
In-Reply-To: <20230914-d6645bbc5ac80999674e9685@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Fri, 15 Sep 2023 14:14:15 +0800
Message-ID: <CAJve8omvH67vBoh1tVpUad7sXxRXUgQxNZzqfXFmKj0NHqGDFQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] KVM: riscv: selftests: Change vcpu_has_ext to a
 common function
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
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Thomas Huth <thuth@redhat.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
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

On Thu, Sep 14, 2023 at 5:05=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Sep 14, 2023 at 09:37:02AM +0800, Haibo Xu wrote:
> > Move vcpu_has_ext to the processor.c and rename it to __vcpu_has_ext
> > so that other test cases can use it for vCPU extension check.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  .../selftests/kvm/include/riscv/processor.h      |  2 ++
> >  .../testing/selftests/kvm/lib/riscv/processor.c  |  9 +++++++++
> >  tools/testing/selftests/kvm/riscv/get-reg-list.c | 16 +---------------
> >  3 files changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/to=
ols/testing/selftests/kvm/include/riscv/processor.h
> > index 2c975d9cead2..7d5517648ea7 100644
> > --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > @@ -42,6 +42,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, ui=
nt64_t idx,
> >  #define RISCV_ISA_EXT_REG(idx)       __kvm_reg_id(KVM_REG_RISCV_ISA_EX=
T, \
> >                                            idx, KVM_REG_SIZE_ULONG)
> >
> > +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
> > +
> >  struct ex_regs {
> >       unsigned long ra;
> >       unsigned long sp;
> > diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/=
testing/selftests/kvm/lib/riscv/processor.c
> > index 39a1e9902dec..e527ad0abc30 100644
> > --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> > @@ -15,6 +15,15 @@
> >
> >  static vm_vaddr_t exception_handlers;
> >
> > +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > +{
> > +     unsigned long value =3D 0;
> > +
> > +     __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> > +
> > +     return !!value;
>
> I'd rather not assume that value will remain zero across a system call
> which fails. Let's write this as
>
>      unsigned long value =3D 0;
>      int ret;
>
>      ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
>
>      return !ret && !!value;
>

Sure. Thanks for the suggestion!

> > +}
> > +
> >  static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
> >  {
> >       return (v + vm->page_size) & ~(vm->page_size - 1);
> > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/t=
esting/selftests/kvm/riscv/get-reg-list.c
> > index d8ecacd03ecf..0dcff823f287 100644
> > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > @@ -44,20 +44,6 @@ bool check_reject_set(int err)
> >       return err =3D=3D EINVAL;
> >  }
> >
> > -static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > -{
> > -     int ret;
> > -     unsigned long value;
> > -
> > -     ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> > -     if (ret) {
> > -             printf("Failed to get ext %d", ext);
> > -             return false;
> > -     }
> > -
> > -     return !!value;
> > -}
> > -
> >  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
> >  {
> >       struct vcpu_reg_sublist *s;
> > @@ -77,7 +63,7 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu=
_reg_list *c)
> >               __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(s->feature), 1);
> >
> >               /* Double check whether the desired extension was enabled=
 */
> > -             __TEST_REQUIRE(vcpu_has_ext(vcpu, s->feature),
> > +             __TEST_REQUIRE(__vcpu_has_ext(vcpu, s->feature),
> >                              "%s not available, skipping tests\n", s->n=
ame);
> >       }
> >  }
> > --
> > 2.34.1
> >
>
> Otherwise,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Thanks,
> drew
