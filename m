Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB657A8446
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 15:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbjITN5E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 09:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbjITN4j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 09:56:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BB2ED
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 06:56:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-578e33b6fb7so466174a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 06:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695218193; x=1695822993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWvN1Bpbs1PF50qBbgm5YoDriWQXveHOdhR/Dx6i6jg=;
        b=jumE20PqqxAOG4i4XuVhj2Nh8I6uySmZUS93YfHY39qWcwjbLIRR5M+ck+mKp0NWXD
         uzeC4VI/6nKwqJwmoIyQ056PUqpI0++aifGvopEMs8T5eaLR3VVSL6DmsUZt0ddgXphm
         ySlNyon5TUygh10a/CidiQU9h5nt+LUG2TTFq7PH927GexnxrnMLUOw0x617/Q2LW3Is
         RykXdeC9AKumyTPXURHuJRExonlMn70okeL6/moqXpUiRjiHol1JZNre3vAt/oHq0+Hj
         FuRww++Vb5LYoff/watqnwLyHGPhJnGElUpjR1dVbXMFoI4rKFfqh7bi0o4Ane2Gq+Yv
         RQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695218193; x=1695822993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWvN1Bpbs1PF50qBbgm5YoDriWQXveHOdhR/Dx6i6jg=;
        b=M0U1D1JRHioLqClmOGecVPhbZthYwxod8yNz+r5AL//wJOZm45mIBdojcKM5uO0ARo
         1KV6cjDGpTWp/DQDXMyJCWywCz2YD/6lWjCx8WX/OJI/tuEJva4u3PKySFz2G8HcZuuE
         GqHptepzy8xi9rk47xZd2qy8g4Y09nrnG53cJTyWeTQh78fGLu1IZe7opISuJdu2pWuV
         AW5zhi73QrhQF6ugviJ1p30qVUlbLg8/q38PVK7WNkukITC1+1/VAArxEOYpq0CfRavL
         mtN8MX/BmaWR22Kdg9QZoIE1Nw3qU2j0aGCB+mfEprwwF0A+iBgl7KZV4YSjEOljQziF
         pvKg==
X-Gm-Message-State: AOJu0YwfF2lvHqISJ/drKcF2GStyIW3Y+a1Fr4kt7eKUofxpI7q9EusN
        YXc7E53v/Qtftw/WphqNEXPtAkhZfnGFr2FmlSo0qA==
X-Google-Smtp-Source: AGHT+IFb9PPNvdqtSUNwQS6mJlCIQK/y8XDdGfu9RdEx32Z3P7W7GzvDtIiLZCDP6pBGCTmuF0vbzKB6JetQRNt81ig=
X-Received: by 2002:a05:6a20:6a27:b0:14c:383b:294a with SMTP id
 p39-20020a056a206a2700b0014c383b294amr2839055pzk.5.1695218193018; Wed, 20 Sep
 2023 06:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
 <20230918180646.1398384-4-apatel@ventanamicro.com> <CAOnJCUJYDHtbYS4js7PSAeLqT4sL5zi7DT5xeSww+5Nvs2UhcA@mail.gmail.com>
In-Reply-To: <CAOnJCUJYDHtbYS4js7PSAeLqT4sL5zi7DT5xeSww+5Nvs2UhcA@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 20 Sep 2023 19:26:21 +0530
Message-ID: <CAK9=C2UbjOGyxo8oP36Tinjhv1jRpCb+hVbZCOJ70G4-WiHw1g@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: riscv: selftests: Fix ISA_EXT register handling
 in get-reg-list
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 1:24=E2=80=AFAM Atish Patra <atishp@atishpatra.org>=
 wrote:
>
> On Mon, Sep 18, 2023 at 11:07=E2=80=AFAM Anup Patel <apatel@ventanamicro.=
com> wrote:
> >
> > Same set of ISA_EXT registers are not present on all host because
> > ISA_EXT registers are visible to the KVM user space based on the
> > ISA extensions available on the host. Also, disabling an ISA
> > extension using corresponding ISA_EXT register does not affect
> > the visibility of the ISA_EXT register itself.
> >
> > Based on the above, we should filter-out all ISA_EXT registers.
> >
>
> In that case, we don't need the switch case any more. Just a
> conditional check with KVM_RISCV_ISA_EXT_MAX should be sufficient.

If we compare against KVM_RISCV_ISA_EXT_MAX then we will forget
adding test configs for newer ISA extensions.

>
> > Fixes: 477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../selftests/kvm/riscv/get-reg-list.c        | 35 +++++++++++--------
> >  1 file changed, 21 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/t=
esting/selftests/kvm/riscv/get-reg-list.c
> > index d8ecacd03ecf..76c0ad11e423 100644
> > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > @@ -14,17 +14,33 @@
> >
> >  bool filter_reg(__u64 reg)
> >  {
> > +       switch (reg & ~REG_MASK) {
> >         /*
> > -        * Some ISA extensions are optional and not present on all host=
,
> > -        * but they can't be disabled through ISA_EXT registers when pr=
esent.
> > -        * So, to make life easy, just filtering out these kind of regi=
sters.
> > +        * Same set of ISA_EXT registers are not present on all host be=
cause
> > +        * ISA_EXT registers are visible to the KVM user space based on=
 the
> > +        * ISA extensions available on the host. Also, disabling an ISA
> > +        * extension using corresponding ISA_EXT register does not affe=
ct
> > +        * the visibility of the ISA_EXT register itself.
> > +        *
> > +        * Based on above, we should filter-out all ISA_EXT registers.
> >          */
> > -       switch (reg & ~REG_MASK) {
> > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_A:
> > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_C:
> > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_D:
> > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_F:
> > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_H:
> > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_I:
> > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_M:
> > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVPBMT:
> >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSTC:
> >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVINVAL:
> >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
> > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
> > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ:
> >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBB:
> >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSAIA:
> > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_V:
> > +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVNAPOT:
> >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBA:
> >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
> >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICNTR:
> > @@ -50,12 +66,7 @@ static inline bool vcpu_has_ext(struct kvm_vcpu *vcp=
u, int ext)
> >         unsigned long value;
> >
> >         ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> > -       if (ret) {
> > -               printf("Failed to get ext %d", ext);
> > -               return false;
> > -       }
> > -
> > -       return !!value;
> > +       return (ret) ? false : !!value;
> >  }
> >
> >  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
> > @@ -506,10 +517,6 @@ static __u64 base_regs[] =3D {
> >         KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_RE=
G_RISCV_TIMER_REG(time),
> >         KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_RE=
G_RISCV_TIMER_REG(compare),
> >         KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_RE=
G_RISCV_TIMER_REG(state),
> > -       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KV=
M_RISCV_ISA_EXT_A,
> > -       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KV=
M_RISCV_ISA_EXT_C,
> > -       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KV=
M_RISCV_ISA_EXT_I,
> > -       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KV=
M_RISCV_ISA_EXT_M,
> >         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KV=
M_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_V01,
> >         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KV=
M_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_TIME,
> >         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KV=
M_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_IPI,
> > --
> > 2.34.1
> >
>
>
> --
> Regards,
> Atish

Regards,
Anup
