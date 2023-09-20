Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8EE7A83EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 15:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbjITNwQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 09:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbjITNwQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 09:52:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC8C6
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 06:52:08 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-578af21ff50so1617169a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695217928; x=1695822728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzKUIkp2N4mFsPMBkGOtGZ83qroR9oeUcPf9C3+REGI=;
        b=Afz5XzDwptMY7dWBZQPXw2i0KdFVRR6oMLfCqIQ9e7jBl6L8qTcD5KYq5ZThPKHSv4
         t49sU10OIwYxFm0vm2HM9LJjDpPlhBxYQtQvW5PKAuFvf1h9nRVSFgW409JijUhfwDtk
         FM31hIqH8mmQ50yRJXCu4e28aNrpm2h6MKLutBcb6EgpzMsS3DP0DIkzK4rBBi30cJOR
         1+VWSEmGmvo6XyqtYLfIRrZyeojrpCbKjoiQi+7AZRzIAN8JcOYDrgfqOO2VwMvTTjku
         KbuRfhoEThYJGT1bSb8+FdOLSG3cX9hqSd18DLatbNq0Ewvilc62/H2UcUU/ftddgtn4
         sofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695217928; x=1695822728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzKUIkp2N4mFsPMBkGOtGZ83qroR9oeUcPf9C3+REGI=;
        b=xF98CulcvycWecHPzeE8BUNqCAA8qUIsQXuQGRqBPislrFc5HFnAbBOSCGEgQMrodm
         o2g+Eg4XiIgNR5dSmtJFKiF6w45FUr715iujjVrfe4n/DS0A5bo7VZ4iIvTW3dgACj8y
         bl7/o56A6nNXAebtWW6oT8PVktcH0WEw1yRE496U6Tu0KeUSDuBvnMDecRaztKH1VXQW
         dE2smSJI8iFwVd4lhz8j9Bcxwk38BBuEqHZ8NkPRd3mcilfDmZu9KpHDNNV6czaHDDla
         krnRsuryxaJpM6B+J5dvnZ5S0TMguFTmdPXWtlp2FpUP/aN622v6WRqypNNLI8CU4pzs
         5lbg==
X-Gm-Message-State: AOJu0YwWJuD/kCYo/3BU6ZjVNSDsY8uqGkHZq0urdXmGkqMjxy/PlHFd
        dCOSkmvyxwZH7VPswNbrsxr/eWvtMOALB9cqr6SJ1Q==
X-Google-Smtp-Source: AGHT+IGXSUP8486WAuGjNv3n0pBFc9g0bpvw4aa5VzPg+ObGcV35R+/p4WGbHUmzy1ayTCndxJcGUvNBRm3i9v1Kurw=
X-Received: by 2002:a17:90a:3d43:b0:26b:7d8e:edf9 with SMTP id
 o3-20020a17090a3d4300b0026b7d8eedf9mr2256888pjf.49.1695217928154; Wed, 20 Sep
 2023 06:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
 <20230918180646.1398384-5-apatel@ventanamicro.com> <CAOnJCU+h-Y_i=HkCf194SLWp-7bqzMhRLC31q0xxQDMuLppapA@mail.gmail.com>
In-Reply-To: <CAOnJCU+h-Y_i=HkCf194SLWp-7bqzMhRLC31q0xxQDMuLppapA@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 20 Sep 2023 19:21:56 +0530
Message-ID: <CAK9=C2XFGoZ-JZmMv4qmgzE+0Rt_pv+5k8UMJ0ivh=MaBoxxhA@mail.gmail.com>
Subject: Re: [PATCH 4/4] KVM: riscv: selftests: Selectively filter-out AIA registers
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 1:43=E2=80=AFAM Atish Patra <atishp@atishpatra.org>=
 wrote:
>
> On Mon, Sep 18, 2023 at 11:07=E2=80=AFAM Anup Patel <apatel@ventanamicro.=
com> wrote:
> >
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
> >         switch (reg & ~REG_MASK) {
> > @@ -48,6 +50,15 @@ bool filter_reg(__u64 reg)
> >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
> >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
> >                 return true;
> > +       /* AIA registers are always available when Ssaia can't be disab=
led */
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_=
CSR_AIA_REG(siselect):
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_=
CSR_AIA_REG(iprio1):
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_=
CSR_AIA_REG(iprio2):
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_=
CSR_AIA_REG(sieh):
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_=
CSR_AIA_REG(siph):
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_=
CSR_AIA_REG(iprio1h):
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_=
CSR_AIA_REG(iprio2h):
> > +               return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA] ? =
true : false;
>
> Ahh I guess. you do need the switch case for AIA CSRs but for ISA
> extensions can be avoided as it is contiguous.

Fow now, let's leave it as-is because this way get-reg-list will
complain if some new ONE_REG register is missed out.

>
> >         default:
> >                 break;
> >         }
> > @@ -71,14 +82,22 @@ static inline bool vcpu_has_ext(struct kvm_vcpu *vc=
pu, int ext)
> >
> >  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
> >  {
> > +       int rc;
> >         struct vcpu_reg_sublist *s;
> > +       unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] =3D { 0 };
> > +
> > +       for (int i =3D 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
> > +               __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(i), &isa_ext_sta=
te[i]);
> >
> >         /*
> >          * Disable all extensions which were enabled by default
> >          * if they were available in the risc-v host.
> >          */
> > -       for (int i =3D 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
> > -               __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
> > +       for (int i =3D 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
> > +               rc =3D __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
> > +               if (rc && isa_ext_state[i])
> > +                       isa_ext_cant_disable[i] =3D true;
> > +       }
> >
> >         for_each_sublist(c, s) {
> >                 if (!s->feature)
> > --
> > 2.34.1
> >
>
> Otherwise, LGTM.
>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
>
> --
> Regards,
> Atish

Regards,
Anup
