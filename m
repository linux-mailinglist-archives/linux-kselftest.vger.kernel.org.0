Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E6971217A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 09:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbjEZHuq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 03:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbjEZHup (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 03:50:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4C6B6;
        Fri, 26 May 2023 00:50:44 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5341737d7aeso410881a12.2;
        Fri, 26 May 2023 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685087444; x=1687679444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DC31IUhv/KDwF/7LXlScDdxDoyQnFVByk+1cX0N3RaE=;
        b=Jhs5ewodbHYux8rWhVtQych048Jh1kydORvmCZBCk1d+cKOfGCAypgl5wP36OA6UPY
         iV2JB3nG+nkKnPEfCq/6JOGJ+BuIrM/MSAbgOJ0p3dOxlDiW5hfzk/rQnKvK0MZFZZmY
         LqWyiqzwdd8P8J06ueWglPKI4iG8HTQ35NWYE1Zz+rV438CWkHtoGq3E3q4ocLOP5T8C
         euSntHUIVUEBh3la/Yy5NtBfEcZBeniHggQeHvjGzwtmUrGsUA8pPjwiFDZqJwloc2H5
         yRpr2O/ZC0n2mgszGTzp1RfDh7Vg8zx5hGA8wOmNgzT9u5/icQUnuQWM3RMTu7N7NCDg
         VQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685087444; x=1687679444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC31IUhv/KDwF/7LXlScDdxDoyQnFVByk+1cX0N3RaE=;
        b=OpPQvcSy0O5optSX/GwaXXlU6lU4jwf19dIamUxC4aCJ1ooDb+GrtmqT0PfOfciO4G
         nnJ/2rd+oZG7SmqCEb22gw+t5FP64Edc3wLzPOZOgiB3U+qPzbBdBXBBXRUYOzmTlqoP
         wZ9lqxS1ReLNj3hPmfEupxKCmVsyXSlMdXjFlZ3tM1bQig90T9WusNSNVkz5De2N38v6
         HWEnYGAEQOaK38Fk6oWJwsmBa+gnTHuaeKUu50vU9+BKpbAH13OOVkmmQ9WzS1RI9n87
         oTOOe9kBjsj6x8mwp/iGzuY7h1Gm9uJXJDTmzdNbJJgd61l2m2IGy2hdkI+4bHNlYfNv
         jC6w==
X-Gm-Message-State: AC+VfDx6VKzJmHG7dHUGn1TlWTSrEWpTHCErZTi09TAqXj/qRhthZ0cB
        df8eaFoFjAnPgavm7PJ5rn7aB/KJmQ7OBnWUsNg=
X-Google-Smtp-Source: ACHHUZ58ZyNcl4smp7Jn1NrrTnovVntKOMAOSrPor/2jlNcaBY0cnT/p2f56wvJwy1y5P3rJncUZpbKm54trYcAP22Q=
X-Received: by 2002:a17:903:2345:b0:1af:f4f5:6fae with SMTP id
 c5-20020a170903234500b001aff4f56faemr1891458plh.54.1685087443821; Fri, 26 May
 2023 00:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684999824.git.haibo1.xu@intel.com> <26dea518fc5e8da51e61db279d175364bfecd009.1684999824.git.haibo1.xu@intel.com>
 <20230525-705ddcbcd43aa63e3fd356c8@orel>
In-Reply-To: <20230525-705ddcbcd43aa63e3fd356c8@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Fri, 26 May 2023 15:50:32 +0800
Message-ID: <CAJve8onF9MFuaVsThFnhjWr6ZomB0Lhr9WXGvMiJDt5vrjeKLg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] KVM: riscv: selftests: Make check_supported arch specific
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 26, 2023 at 12:40=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Thu, May 25, 2023 at 03:38:33PM +0800, Haibo Xu wrote:
> > check_supported() was used to verify whether a feature/extension was
> > supported in a guest in the get-reg-list test. Currently this info
> > can be retrieved through the KVM_CAP_ARM_* API in aarch64, but in
> > riscv, this info was only exposed through the KVM_GET_ONE_REG on
> > KVM_REG_RISCV_ISA_EXT pseudo registers.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/get-reg-list.c | 32 +++++++++++-----------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing=
/selftests/kvm/get-reg-list.c
> > index f6ad7991a812..f1fc113e9719 100644
> > --- a/tools/testing/selftests/kvm/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/get-reg-list.c
> > @@ -99,6 +99,20 @@ void __weak print_reg(const char *prefix, __u64 id)
> >  }
> >
> >  #ifdef __aarch64__
> > +static void check_supported(struct vcpu_reg_list *c)
> > +{
> > +     struct vcpu_reg_sublist *s;
> > +
> > +     for_each_sublist(c, s) {
> > +             if (!s->capability)
> > +                     continue;
>
> I was going to say that making this function aarch64 shouldn't be
> necessary, since riscv leaves capability set to zero and this function
> doesn't do anything, but then looking ahead I see riscv is abusing
> capability by putting isa extensions in it. IMO, capability should
> only be set to KVM_CAP_* values. Since riscv doesn't use it, then it
> should be left zero.
>
> If we're going to abuse something, then I'd rather abuse the 'feature'
> member, but since it's only an int (not an unsigned long), then let's
> just add an 'unsigned long extension' member.
>

Good idea!

For the new 'extension' member in riscv, I think its use case should be
identical to the 'feature' member in aarch64(KVM_RISCV_ISA_EXT_F
was similar to KVM_ARM_VCPU_SVE)? If so, I think we can just reuse
the 'feature' member since the data type was not a big deal.

> Then, the finalize_vcpu() call can be moved back to run_test(), from
> aarch64's vcpu_config_get_vcpu(). Both aarch64 and riscv will call it
> right after vcpu_config_get_vcpu() and the riscv version of it will
> do what your current riscv check_supported() is doing, using the
> new 'extension' member instead of 'capability'.
>
> And this patch gets dropped.
>
> Thanks,
> drew
>
> > +
> > +             __TEST_REQUIRE(kvm_has_cap(s->capability),
> > +                            "%s: %s not available, skipping tests\n",
> > +                            config_name(c), s->name);
> > +     }
> > +}
> > +
> >  static void prepare_vcpu_init(struct vcpu_reg_list *c, struct kvm_vcpu=
_init *init)
> >  {
> >       struct vcpu_reg_sublist *s;
> > @@ -126,6 +140,8 @@ static struct kvm_vcpu *vcpu_config_get_vcpu(struct=
 vcpu_reg_list *c, struct kvm
> >       struct kvm_vcpu_init init =3D { .target =3D -1, };
> >       struct kvm_vcpu *vcpu;
> >
> > +     check_supported(c);
> > +
> >       prepare_vcpu_init(c, &init);
> >       vcpu =3D __vm_vcpu_add(vm, 0);
> >       aarch64_vcpu_setup(vcpu, &init);
> > @@ -140,20 +156,6 @@ static struct kvm_vcpu *vcpu_config_get_vcpu(struc=
t vcpu_reg_list *c, struct kvm
> >  }
> >  #endif
> >
> > -static void check_supported(struct vcpu_reg_list *c)
> > -{
> > -     struct vcpu_reg_sublist *s;
> > -
> > -     for_each_sublist(c, s) {
> > -             if (!s->capability)
> > -                     continue;
> > -
> > -             __TEST_REQUIRE(kvm_has_cap(s->capability),
> > -                            "%s: %s not available, skipping tests\n",
> > -                            config_name(c), s->name);
> > -     }
> > -}
> > -
> >  static bool print_list;
> >  static bool print_filtered;
> >
> > @@ -165,8 +167,6 @@ static void run_test(struct vcpu_reg_list *c)
> >       struct kvm_vm *vm;
> >       struct vcpu_reg_sublist *s;
> >
> > -     check_supported(c);
> > -
> >       vm =3D vm_create_barebones();
> >       vcpu =3D vcpu_config_get_vcpu(c, vm);
> >
> > --
> > 2.34.1
> >
