Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2426D72A883
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 04:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjFJCkG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 22:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjFJCkF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 22:40:05 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959441BD6;
        Fri,  9 Jun 2023 19:40:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-52c30fa5271so908117a12.0;
        Fri, 09 Jun 2023 19:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686364804; x=1688956804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMfpDCLRI5dKyF0E3U+UoBzddcbMW1WQlUnfVbM4Nck=;
        b=VSuYniOmVJm4APmLKKeLvXMbE8TljXjUNMlgLVlYqWsuBrwnlWGOug6dLADTZoR5yA
         ephPwS8VQPss1j9EmzvIDKo9ZNOJbRFmv9sLV7BvT81ptJMdJ1Jsf6FY68mSy7Z/yT+w
         zPM8hWOQqosCzowr7LFwZWo/7kb3G0ygsv8PQKDeobDoEJvyEwakZAsJRFlJr3s09+LR
         peQnmNKTDneKDR7PuVNA4OwMT2KzLLl75sKBurccopF5L0tCZRpP3NWJk+wMJGaGWEnw
         +m5cvDgsfjKaJv8Zxh+y+jk/ey/C488Aqi8NbLPpK6egHx1lvb2dC5ffAgMbjTneiznw
         fY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686364804; x=1688956804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMfpDCLRI5dKyF0E3U+UoBzddcbMW1WQlUnfVbM4Nck=;
        b=KRxafi7UlNyC54K8Rr+qTffQm0Un7X4T2tgagMFQ9mbC1xuFEhXM0C2KhjK3v2GiZ6
         2BL6GhP8nkDMFj6Tag+ooeR9fp8uxVfTYL9cpErZx2APjrGHxb2/LSLDZzjMW5vatbgc
         BdiK2LPdELXLDx+twe4fA5fVhneu/x6iZ3zUt5W9yYkAhzipg47jLq72tfDDi4npd4rj
         Lszyc1PBkWPcntSI8AfkLWUHLcZQtQNA9b/UWc5PWlcPhW7ZXttoZDM+0mEP5+CXEgpN
         52S1diOXpdtdKxWi4lxz/RS8FVPyDFhzHSFBBePvNHpz3PaqOf8EbumJkkU2K2HgxJ6g
         YUNw==
X-Gm-Message-State: AC+VfDzg/Yg/ofGQSsEzuxECwwXmyNo4j2ZWiJ9e1MDPLLvQenGktdAo
        8joKHA1nOSgLbAw/esDB7CZXAEr8QUZWDESg8Lk=
X-Google-Smtp-Source: ACHHUZ6Ncw/ed/aBOi55gkdHjQX9HI8UMmlQmib8fd4hYlllg8RalvCIvinsLeBFbe5+qY0bpgqSSep+1aWI0UyuIEo=
X-Received: by 2002:a05:6a20:7f87:b0:118:5d5a:f26f with SMTP id
 d7-20020a056a207f8700b001185d5af26fmr2768582pzj.12.1686364803807; Fri, 09 Jun
 2023 19:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686275310.git.haibo1.xu@intel.com> <450cb59db52ebeaa68f3d77f1bd995618f3612b8.1686275310.git.haibo1.xu@intel.com>
 <20230609-b900162a66c26a004b751b1f@orel>
In-Reply-To: <20230609-b900162a66c26a004b751b1f@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Sat, 10 Jun 2023 10:39:52 +0800
Message-ID: <CAJve8ontMqvxyXWCY2DWziqti5umRuO+YOiWkXqLhyONWWsLKg@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] KVM: arm64: selftests: Finish generalizing get-reg-list
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

On Fri, Jun 9, 2023 at 8:30=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Fri, Jun 09, 2023 at 10:12:15AM +0800, Haibo Xu wrote:
> > From: Andrew Jones <ajones@ventanamicro.com>
> >
> > Add some unfortunate #ifdeffery to ensure the common get-reg-list.c
> > can be compiled and run with other architectures. The next
> > architecture to support get-reg-list should now only need to provide
> > $(ARCH_DIR)/get-reg-list.c where arch-specific print_reg() and
> > vcpu_configs[] get defined.
> >
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/get-reg-list.c | 24 ++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing=
/selftests/kvm/get-reg-list.c
> > index 69bb91087081..c4bd5a5259da 100644
> > --- a/tools/testing/selftests/kvm/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/get-reg-list.c
> > @@ -98,6 +98,7 @@ void __weak print_reg(const char *prefix, __u64 id)
> >       printf("\t0x%llx,\n", id);
> >  }
> >
> > +#ifdef __aarch64__
> >  static void prepare_vcpu_init(struct vcpu_reg_list *c, struct kvm_vcpu=
_init *init)
> >  {
> >       struct vcpu_reg_sublist *s;
> > @@ -120,6 +121,24 @@ static void finalize_vcpu(struct kvm_vcpu *vcpu, s=
truct vcpu_reg_list *c)
> >       }
> >  }
> >
> > +static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, =
struct kvm_vm *vm)
> > +{
> > +     struct kvm_vcpu_init init =3D { .target =3D -1, };
> > +     struct kvm_vcpu *vcpu;
> > +
> > +     prepare_vcpu_init(c, &init);
> > +     vcpu =3D __vm_vcpu_add(vm, 0);
> > +     aarch64_vcpu_setup(vcpu, &init);
> > +
> > +     return vcpu;
> > +}
> > +#else
> > +static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, =
struct kvm_vm *vm)
> > +{
> > +     return __vm_vcpu_add(vm, 0);
> > +}
> > +#endif
> > +
> >  static void check_supported(struct vcpu_reg_list *c)
> >  {
> >       struct vcpu_reg_sublist *s;
> > @@ -139,7 +158,6 @@ static bool print_filtered;
> >
> >  static void run_test(struct vcpu_reg_list *c)
> >  {
> > -     struct kvm_vcpu_init init =3D { .target =3D -1, };
> >       int new_regs =3D 0, missing_regs =3D 0, i, n;
> >       int failed_get =3D 0, failed_set =3D 0, failed_reject =3D 0;
> >       struct kvm_vcpu *vcpu;
> > @@ -149,9 +167,7 @@ static void run_test(struct vcpu_reg_list *c)
> >       check_supported(c);
> >
> >       vm =3D vm_create_barebones();
> > -     prepare_vcpu_init(c, &init);
> > -     vcpu =3D __vm_vcpu_add(vm, 0);
> > -     aarch64_vcpu_setup(vcpu, &init);
> > +     vcpu =3D vcpu_config_get_vcpu(c, vm);
> >       finalize_vcpu(vcpu, c);
>
> I just noticed that this has been modified from what I posted to leave
> the finalize_vcpu() call here, despite it now being inside the #ifdef
> __aarch64__. That breaks the purpose of the patch. Please make sure this
> file compiles for other architectures without requiring additional
> patches, which would keep the commit message honest. You can either
> revert this to what I posted, and then readd the finalize_vcpu() call in
> another patch, or you can add a finalize_vcpu() stub to the #else part
> of the ifdef in this patch.
>
> Also please don't modify patches authored by others without calling out
> the modifications somewhere, either the commit message or under the ---
> of the patch or in the cover letter.
>

Thanks for pointing it out! I will have a check about it.

> Thanks,
> drew
