Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F079A796F6D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 05:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjIGD5X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 23:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjIGD5S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 23:57:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C908E41;
        Wed,  6 Sep 2023 20:57:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b974031aeaso9504891fa.0;
        Wed, 06 Sep 2023 20:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694059032; x=1694663832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UQs6noN/LuXhMaxtbcJru+m5+v+IlSKIcqynK+aM9Y=;
        b=fDxrT+lGMq39XKjj0KXPz9tLGKvx+OLZzhBNbX/fCD3TCPiNk+uJWvOCAy1aLhnjRS
         H0O3gkiCnj0RSPsKFJedJYK/cxirktn8hnfb84y8HrEEMtIhrzea95j9iHfEErY3mJIU
         CTSeh+4K4anxvtQBxbKCFfWRIbta3FYCr5/6Rz2l+5N6EBNAxvjxuIB8kRW6ELHAyF+P
         /fh9cRJMzSSOinvTY4lAZD4WudDIWB5dC6Iqe4t5YHDflfHPN8ZPYmqgz6f20+oiQwo2
         40gx0Urv2OqthbO5PO1Y6tQ0gLQQ3huvrgfpSszuyl8OBr5eLavDcAPyim+mLUibNxZb
         540g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694059032; x=1694663832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UQs6noN/LuXhMaxtbcJru+m5+v+IlSKIcqynK+aM9Y=;
        b=BRN0aV9DOQHNiRqpP7U0Dlt7yCI7BlOhpT38eZ8Yy2810rQ4LoMHXcgrxoZi2dP+VT
         pxGnBxh0XgMqNJKiNMzuPlk5uU7tEW5VFgctB0rKuj0Z9NICNCh0NlQifbd6LQRTdcJo
         DtVjm+jsxYfJARbJGaTW/vIUha/5eENrE7Ii+q0Feq8kK+jCgBVMVTKnOBmy7sqf+yq1
         hJ5wiyJMxD+PjpyA18nl8fphk1cO/FerqxeUdZAeV4abbZkI8V/99o67kHwyuYKLUMTc
         WUNI98nTQuPjfjHQS7SY0wF6gPwsOzDEZ0U461nU2GeGrCVnzVtucD5wngcKDBJaydzC
         dW6w==
X-Gm-Message-State: AOJu0YwkIxJePRs3I604lQFJHAfVsZaxvK8OGPBISxBITfcIAnvF9+Cb
        Y/jYQGf+GOOa58pmJaLusZqu+VUw6gjocbsYAKo=
X-Google-Smtp-Source: AGHT+IGI6qgIYSsAicMI6I+r6ioP3/2vp5QnhFlwnPmei3QJDcCP4J/D9Z4FZEYYhTF0QZ1jr8qCxHSm6ZraniakZgA=
X-Received: by 2002:a2e:9c10:0:b0:2bc:b70d:9cb5 with SMTP id
 s16-20020a2e9c10000000b002bcb70d9cb5mr3530939lji.33.1694059032084; Wed, 06
 Sep 2023 20:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693659382.git.haibo1.xu@intel.com> <b6ef1b031e3a581f481cf19a26623388163444b4.1693659382.git.haibo1.xu@intel.com>
 <20230904-aa8b0d8d23d391586686038a@orel> <CAJve8ok5cU+h1K+WJ+aDpB+u+PBo8XosUyyVbMGy-xR0XiWFdw@mail.gmail.com>
In-Reply-To: <CAJve8ok5cU+h1K+WJ+aDpB+u+PBo8XosUyyVbMGy-xR0XiWFdw@mail.gmail.com>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Thu, 7 Sep 2023 11:57:00 +0800
Message-ID: <CAJve8om+dLcG+4trDfG1yx8vhj52RhPZrJoF-emWDX+OPM088A@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] KVM: riscv: selftest: Change vcpu_has_ext to a
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
        Guo Ren <guoren@kernel.org>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        wchen <waylingii@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        David Matlack <dmatlack@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Lei Wang <lei4.wang@intel.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Like Xu <likexu@tencent.com>, Peter Gonda <pgonda@google.com>,
        Thomas Huth <thuth@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, Paul Durrant <paul@xen.org>,
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

On Wed, Sep 6, 2023 at 6:10=E2=80=AFPM Haibo Xu <xiaobo55x@gmail.com> wrote=
:
>
> On Mon, Sep 4, 2023 at 10:04=E2=80=AFPM Andrew Jones <ajones@ventanamicro=
.com> wrote:
> >
> > On Sat, Sep 02, 2023 at 08:59:29PM +0800, Haibo Xu wrote:
> > > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools=
/testing/selftests/kvm/riscv/get-reg-list.c
> > > index d8ecacd03ecf..c4028bf32e3f 100644
> > > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > > @@ -44,20 +44,6 @@ bool check_reject_set(int err)
> > >       return err =3D=3D EINVAL;
> > >  }
> > >
> > > -static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > > -{
> > > -     int ret;
> > > -     unsigned long value;
> > > -
> > > -     ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> > > -     if (ret) {
> > > -             printf("Failed to get ext %d", ext);
> > > -             return false;
> > > -     }
> > > -
> > > -     return !!value;
> >
> > get-reg-list will now assert on get-reg when an extension isn't present=
,
> > rather than failing the __TEST_REQUIRE(), which would do a skip instead=
.
> > We need both the return false version and the assert version.
> >
>
> Ok, Will keep this one for get-reg-list and add another one for
> arch-timer specific usage.
>

Just thought about it again, maybe we only need the "return false"
version for both get-reg-list
and arch-timer tests since if an extension was not available, the test
can be skipped with a message.

bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
{
       unsigned long value =3D 0;

       __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);

       return !!value;
}

> > > -}
> > > -
> > >  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
> > >  {
> > >       struct vcpu_reg_sublist *s;
> > > --
> > > 2.34.1
> > >
> >
> > Thanks,
> > drew
