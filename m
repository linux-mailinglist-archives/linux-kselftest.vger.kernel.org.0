Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B768E7A83D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 15:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjITNuC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 09:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjITNuB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 09:50:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07DEC9
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 06:49:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27499bb759cso3838194a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695217794; x=1695822594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyKrFqZ6pe873R1m/St9homGtI5DVB4Bs4vDfySSmyA=;
        b=ov3W+Y1h5haJhja/3rDUZDGJozRUmn71LF7tPrGTrzStr9/tMJHuqigqWG3EO3ygvo
         czFTEHZ6DPHB0hcXysYSBP1hULo6L4ovpB/K0mAJruNhTSyltm0ShmiiDL+MKPTFqJ/Q
         +Ox0xcSgWAKc5Zk5K9yrkhsn1Ghkl8TTZFkSCoVgIxgwCFDwfjlk7kIHIWgRntTLBYvH
         bhP4lduvHqoCeJsWdJ7t9bI+zPmrcWu9its1jJXlqNGHDXm6BBY4OJhW3aF/sl3/1uXp
         sKS6Z7ZuzejaKlgn65GYAqpLWmkodak7o65pQDxAMXF5TH+ewzrtaXaGx34Xz+uF1jHS
         VrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695217794; x=1695822594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyKrFqZ6pe873R1m/St9homGtI5DVB4Bs4vDfySSmyA=;
        b=v2j0bSe19NAqEDLzgtdzdmXQdA9RXnlW3skvaDXh2pDxktfbVy5fmbWYxYIj6ucPOb
         xdsR5njcuKyiC/ueNxnuH4+ZOM2JNWV2PbnZ30mNyZaNrarGUNxt7q4DV5gwvETsZTEN
         4nCsqmjEw2cRndmtWCFa6Bg4t/Wu1DNlc5z2pEZSp3a2By/K4VtPkq3GaXIvRuVyv3pI
         CtzXPzNEtW1KMsL8gPYx/PtsuoY1hLo8gFrg5FWbyXReCQj0RmIriFfNAKBa4c88RKmB
         AeEKGb+A9EWikdQFt6lYucI/KQTwTfC9lBMAxgvUbmL3NrcKPtl95hTpt0DvBtDGyrAo
         i75w==
X-Gm-Message-State: AOJu0YyhUcNJ4rjshFsjCUH+SnsdubyWNIogCJB4YV0HhUrbWD5L4R1D
        vLBAhR4PgTyRvTD0vwqQK2lM/doPLcO7iVwvrJ+olw==
X-Google-Smtp-Source: AGHT+IGgvZvXWV6O+m42o/WLo0Z7TC1OAA74vrGK11yPNbc2oxi+bWkJM6MYqS+QjE0clefOThdvmutuQ8u628EY1RM=
X-Received: by 2002:a17:90a:7c01:b0:274:b4ce:7049 with SMTP id
 v1-20020a17090a7c0100b00274b4ce7049mr2566829pjf.34.1695217793948; Wed, 20 Sep
 2023 06:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
 <20230918180646.1398384-5-apatel@ventanamicro.com> <20230920-d524c40b616536d0ad8213c3@orel>
In-Reply-To: <20230920-d524c40b616536d0ad8213c3@orel>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 20 Sep 2023 19:19:42 +0530
Message-ID: <CAK9=C2V-9s1ErSCLcaPwNTrGAWTP69vVmAV0kSsuRn841aofhg@mail.gmail.com>
Subject: Re: [PATCH 4/4] KVM: riscv: selftests: Selectively filter-out AIA registers
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shuah Khan <shuah@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 10:54=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Mon, Sep 18, 2023 at 11:36:46PM +0530, Anup Patel wrote:
> > Currently the AIA ONE_REG registers are reported by get-reg-list
> > as new registers for various vcpu_reg_list configs whenever Ssaia
> > is available on the host because Ssaia extension can only be
> > disabled by Smstateen extension which is not always available.
> >
> > To tackle this, we should filter-out AIA ONE_REG registers only
> > when Ssaia can't be disabled for a VCPU.
> >
> > Fixes: 477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../selftests/kvm/riscv/get-reg-list.c        | 23 +++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/t=
esting/selftests/kvm/riscv/get-reg-list.c
> > index 76c0ad11e423..85907c86b835 100644
> > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > @@ -12,6 +12,8 @@
> >
> >  #define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK)
> >
> > +static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
> > +
> >  bool filter_reg(__u64 reg)
> >  {
> >       switch (reg & ~REG_MASK) {
> > @@ -48,6 +50,15 @@ bool filter_reg(__u64 reg)
> >       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
> >       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
> >               return true;
> > +     /* AIA registers are always available when Ssaia can't be disable=
d */
> > +     case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(siselect):
> > +     case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(iprio1):
> > +     case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(iprio2):
> > +     case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(sieh):
> > +     case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(siph):
> > +     case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(iprio1h):
> > +     case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(iprio2h):
> > +             return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA] ? tr=
ue : false;
>
> No need for the '? true : false'

Okay, I will update.

>
> >       default:
> >               break;
> >       }
> > @@ -71,14 +82,22 @@ static inline bool vcpu_has_ext(struct kvm_vcpu *vc=
pu, int ext)
> >
> >  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
> >  {
> > +     int rc;
> >       struct vcpu_reg_sublist *s;
> > +     unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] =3D { 0 };
>
> nit: I think we prefer reverse xmas tree in kselftests, but whatever.

Okay, I will update.

>
> > +
> > +     for (int i =3D 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
> > +             __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(i), &isa_ext_state=
[i]);
> >
> >       /*
> >        * Disable all extensions which were enabled by default
> >        * if they were available in the risc-v host.
> >        */
> > -     for (int i =3D 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
> > -             __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
> > +     for (int i =3D 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
> > +             rc =3D __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
> > +             if (rc && isa_ext_state[i])
>
> How helpful is it to check that isa_ext_state[i] isn't zero? The value of
> the register could be zero, right? Shouldn't we instead capture the retur=
n
> values from __vcpu_get_reg and if the return value is zero for a get,
> but nonzero for a set, then we know we have it, but can't disable it.

The intent is to find-out the ISA_EXT registers which are enabled but
we are not able to disable it.

>
> > +                     isa_ext_cant_disable[i] =3D true;
> > +     }
> >
> >       for_each_sublist(c, s) {
> >               if (!s->feature)
> > --
> > 2.34.1
> >
>
> Thanks,
> drew

Regards,
Anup
