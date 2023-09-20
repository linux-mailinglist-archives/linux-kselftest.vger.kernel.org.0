Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB567A8FAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 01:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjITXCF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 19:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjITXCE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 19:02:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB62C1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 16:01:58 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-502defbb0c3so654213e87.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 16:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1695250917; x=1695855717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVI1kQAYY1H6Rup9yJAb3ULOmSiNWwKwDibucQ/HouI=;
        b=fwJo3UKZc0m5WSRUUzNViO6C1mzp2o2LOWkb4Me17MDKEx5NHEIHWuY3IhBpqNIGhe
         VMFbj53NcMmSC3xb7HKoKM1u4SU/PbYs4narHAVAgKPY0dPnvx2aYiec+Fpx1H58kcok
         6kbE0RckCEd8diItpYzfZMjJta0g7Uk9Z49Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695250917; x=1695855717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVI1kQAYY1H6Rup9yJAb3ULOmSiNWwKwDibucQ/HouI=;
        b=Xw9tBz6esfcOBhGi/bxxwVslDgrF4/qdFPgMfg+IH+Y/M6l5uOTy8Qu/LQlKJNMzx/
         OSwCtGg5J7+S/2o+wQup+T++WGvJ6IBx8JkyqNykROnQ+xQkeUHP3ENa6UOJAPHewvAS
         FoaFWgShQq9EyVoEb4ymOHhCLx/RAWbsviin0qAfnDu0o95/u+P+fUX4cBa7txwDLTwf
         v45q/aq9Sk6Gwa0e3jVn2xA0FP9f6XElbFwBHMVv4U5OeOUw1PG373fOctMAkTOFyo1f
         qsHUctBV2ja/uFS8QPCevxDIcw7csk3AwU3tOPuk0AjWzQNY5O+qVZ0qHcaavbhU+KJA
         wVJQ==
X-Gm-Message-State: AOJu0Yx2cYxxS9UsSg05ZSyrlAIpB37M6CZSJEY4JcahVja7rQAubxOt
        sUZq6sxRRJ7Vdmc7nnXpgbLD+a9wX6Pl80Z8eGCE
X-Google-Smtp-Source: AGHT+IFXnWGXW8cB93bXiMz9Jl+KdpDWFEF+9MqDskY1cIxpbbthxUKanZZmg166RPl3Bw0vao3h2/sb983B2DCTplM=
X-Received: by 2002:a05:6512:398a:b0:502:fff9:64da with SMTP id
 j10-20020a056512398a00b00502fff964damr4109727lfu.53.1695250916994; Wed, 20
 Sep 2023 16:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
 <20230918180646.1398384-4-apatel@ventanamicro.com> <CAOnJCUJYDHtbYS4js7PSAeLqT4sL5zi7DT5xeSww+5Nvs2UhcA@mail.gmail.com>
 <CAK9=C2UbjOGyxo8oP36Tinjhv1jRpCb+hVbZCOJ70G4-WiHw1g@mail.gmail.com>
In-Reply-To: <CAK9=C2UbjOGyxo8oP36Tinjhv1jRpCb+hVbZCOJ70G4-WiHw1g@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 20 Sep 2023 16:01:45 -0700
Message-ID: <CAOnJCULajHa6H6Rt75rNepYaT-3+Bo=1hQVb_oozPZK13N6yKQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: riscv: selftests: Fix ISA_EXT register handling
 in get-reg-list
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 6:56=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Wed, Sep 20, 2023 at 1:24=E2=80=AFAM Atish Patra <atishp@atishpatra.or=
g> wrote:
> >
> > On Mon, Sep 18, 2023 at 11:07=E2=80=AFAM Anup Patel <apatel@ventanamicr=
o.com> wrote:
> > >
> > > Same set of ISA_EXT registers are not present on all host because
> > > ISA_EXT registers are visible to the KVM user space based on the
> > > ISA extensions available on the host. Also, disabling an ISA
> > > extension using corresponding ISA_EXT register does not affect
> > > the visibility of the ISA_EXT register itself.
> > >
> > > Based on the above, we should filter-out all ISA_EXT registers.
> > >
> >
> > In that case, we don't need the switch case any more. Just a
> > conditional check with KVM_RISCV_ISA_EXT_MAX should be sufficient.
>
> If we compare against KVM_RISCV_ISA_EXT_MAX then we will forget
> adding test configs for newer ISA extensions.
>

I feel it just bloats the code as we may end up in hundreds of
extensions in the future
given the state of the extension scheme.

> >
> > > Fixes: 477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > ---
> > >  .../selftests/kvm/riscv/get-reg-list.c        | 35 +++++++++++------=
--
> > >  1 file changed, 21 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools=
/testing/selftests/kvm/riscv/get-reg-list.c
> > > index d8ecacd03ecf..76c0ad11e423 100644
> > > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > > @@ -14,17 +14,33 @@
> > >
> > >  bool filter_reg(__u64 reg)
> > >  {
> > > +       switch (reg & ~REG_MASK) {
> > >         /*
> > > -        * Some ISA extensions are optional and not present on all ho=
st,
> > > -        * but they can't be disabled through ISA_EXT registers when =
present.
> > > -        * So, to make life easy, just filtering out these kind of re=
gisters.
> > > +        * Same set of ISA_EXT registers are not present on all host =
because
> > > +        * ISA_EXT registers are visible to the KVM user space based =
on the
> > > +        * ISA extensions available on the host. Also, disabling an I=
SA
> > > +        * extension using corresponding ISA_EXT register does not af=
fect
> > > +        * the visibility of the ISA_EXT register itself.
> > > +        *
> > > +        * Based on above, we should filter-out all ISA_EXT registers=
.
> > >          */
> > > -       switch (reg & ~REG_MASK) {
> > > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_A:
> > > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_C:
> > > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_D:
> > > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_F:
> > > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_H:
> > > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_I:
> > > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_M:
> > > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVPBMT:
> > >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSTC:
> > >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVINVAL:
> > >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
> > > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
> > > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ:
> > >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBB:
> > >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSAIA:
> > > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_V:
> > > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVNAPOT:
> > >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBA:
> > >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
> > >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICNTR:
> > > @@ -50,12 +66,7 @@ static inline bool vcpu_has_ext(struct kvm_vcpu *v=
cpu, int ext)
> > >         unsigned long value;
> > >
> > >         ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> > > -       if (ret) {
> > > -               printf("Failed to get ext %d", ext);
> > > -               return false;
> > > -       }
> > > -
> > > -       return !!value;
> > > +       return (ret) ? false : !!value;
> > >  }
> > >
> > >  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
> > > @@ -506,10 +517,6 @@ static __u64 base_regs[] =3D {
> > >         KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_=
REG_RISCV_TIMER_REG(time),
> > >         KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_=
REG_RISCV_TIMER_REG(compare),
> > >         KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_=
REG_RISCV_TIMER_REG(state),
> > > -       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_A,
> > > -       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_C,
> > > -       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_I,
> > > -       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | =
KVM_RISCV_ISA_EXT_M,
> > >         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_V01,
> > >         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_TIME,
> > >         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | =
KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_IPI,
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > Regards,
> > Atish
>
> Regards,
> Anup



--=20
Regards,
Atish
