Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661F97976B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 18:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbjIGQOy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 12:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbjIGQOb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 12:14:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DFD1FE8;
        Thu,  7 Sep 2023 09:10:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52c88a03f99so1467246a12.2;
        Thu, 07 Sep 2023 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694102993; x=1694707793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBBEzL7qY3uq6+ZqigJzuGuvME9kRMD/negQGQFd1kU=;
        b=SVZ3HxdXmiXzCR3Sg4YkbUiQK5WHwETv3O3BrTFQ+jw5sKWGBZM6Hag0a7249Uogof
         wSEz0ad57FX0XyHKFUSS0OsMHVwclj6u2mnqyNBkikj07KP0KPREzy6M5zZYh68eU8yo
         ONg6MZfg949Er1TgPsYZRWEibT1sQpXGkg5KBcCsVQCs9ocsQyxcwYSWFL1etUPTNDg6
         E0mUxI4/E0M0t6arTvkEoP2ZH0S3b824Lx6OJVknSr5nrsaXyYBaYdH9dxfltVCszhE6
         apK4S0ZTozlj/xr+clcCGc9QPg70gERbhJ/eFCRc3mk1pJovU7uzQIS/pjfvn5M8JcPr
         HL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102993; x=1694707793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBBEzL7qY3uq6+ZqigJzuGuvME9kRMD/negQGQFd1kU=;
        b=kXjMsZ79g/QSnre9deS0wouUz0mQiiUQfDIc97dqKYnPkI2Jf5rnbyRsE7iZQ7FOwJ
         zBSFF3hKb0PBepgqvxyrTixzf38tQ1cMCoY3jzz/PMFhYMrNuglv2mtCuma+l/epaZy8
         t9th/jd/aLK4yIV0EZOLbgGu/H946K08IJicBZ0NVTCoUoviWOwTDyCZYEnhM/neJTk9
         ZtU0sEUdgZc6ZOktQx7knsp32KDeBy3gmGXzIsFZkjmUtht50GQTOQUgryDxOqc439S0
         +/7t9J9YJxqyspyMlVuM+IszxMAzhtH+2AClPxTPUp8+Wt5cHnQw2O0jc9UARb/AXRDr
         kGSw==
X-Gm-Message-State: AOJu0YzkuZaO5kygphD4AF86Si5fHxv7D7nJszdsZ0JNiiN33hN35BWF
        4yCxKdk3ylOeMLYVziYegSbKFcrXeLcXxkds+Hi0vQFj
X-Google-Smtp-Source: AGHT+IF10+wenAf/r4lgyEOBY89UZGCOdwUC3J+LpxGhdoe1wYTW/cIeqheprklSo2IBVjz46fa7sLxs5xkSY5w4zLI=
X-Received: by 2002:a2e:804c:0:b0:2bc:c830:4cbb with SMTP id
 p12-20020a2e804c000000b002bcc8304cbbmr3729686ljg.45.1694078317171; Thu, 07
 Sep 2023 02:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693659382.git.haibo1.xu@intel.com> <b6ef1b031e3a581f481cf19a26623388163444b4.1693659382.git.haibo1.xu@intel.com>
 <20230904-aa8b0d8d23d391586686038a@orel> <CAJve8ok5cU+h1K+WJ+aDpB+u+PBo8XosUyyVbMGy-xR0XiWFdw@mail.gmail.com>
 <CAJve8om+dLcG+4trDfG1yx8vhj52RhPZrJoF-emWDX+OPM088A@mail.gmail.com> <20230907-bde62d037a3aaeedfe31f964@orel>
In-Reply-To: <20230907-bde62d037a3aaeedfe31f964@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Thu, 7 Sep 2023 17:18:25 +0800
Message-ID: <CAJve8okJOHofRK=0VRG8QPetOgk_WexEui_3UtEKk+4x1iPwMA@mail.gmail.com>
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
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 7, 2023 at 5:01=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Thu, Sep 07, 2023 at 11:57:00AM +0800, Haibo Xu wrote:
> > On Wed, Sep 6, 2023 at 6:10=E2=80=AFPM Haibo Xu <xiaobo55x@gmail.com> w=
rote:
> > >
> > > On Mon, Sep 4, 2023 at 10:04=E2=80=AFPM Andrew Jones <ajones@ventanam=
icro.com> wrote:
> > > >
> > > > On Sat, Sep 02, 2023 at 08:59:29PM +0800, Haibo Xu wrote:
> > > > > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/t=
ools/testing/selftests/kvm/riscv/get-reg-list.c
> > > > > index d8ecacd03ecf..c4028bf32e3f 100644
> > > > > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > > > > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > > > > @@ -44,20 +44,6 @@ bool check_reject_set(int err)
> > > > >       return err =3D=3D EINVAL;
> > > > >  }
> > > > >
> > > > > -static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > > > > -{
> > > > > -     int ret;
> > > > > -     unsigned long value;
> > > > > -
> > > > > -     ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value=
);
> > > > > -     if (ret) {
> > > > > -             printf("Failed to get ext %d", ext);
> > > > > -             return false;
> > > > > -     }
> > > > > -
> > > > > -     return !!value;
> > > >
> > > > get-reg-list will now assert on get-reg when an extension isn't pre=
sent,
> > > > rather than failing the __TEST_REQUIRE(), which would do a skip ins=
tead.
> > > > We need both the return false version and the assert version.
> > > >
> > >
> > > Ok, Will keep this one for get-reg-list and add another one for
> > > arch-timer specific usage.
> > >
> >
> > Just thought about it again, maybe we only need the "return false"
> > version for both get-reg-list
> > and arch-timer tests since if an extension was not available, the test
> > can be skipped with a message.
> >
> > bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > {
> >        unsigned long value =3D 0;
> >
> >        __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> >
> >        return !!value;
> > }
>
> Yup, I had actually seen that when reviewing a later patch in this series=
,
> but I wasn't concerned if we added the assert type anyway, since we
> frequently end up with the two function types for KVM queries. If we don'=
t
> have a need for an assert type yet, then we don't need to introduce it.
> However, we should introduce the non-assert type as __vcpu_has_ext(),
> reserving the vcpu_has_ext() name for the assert type, per the kvm
> selftests naming convention.
>

Sure, thanks!

> Thanks,
> drew
