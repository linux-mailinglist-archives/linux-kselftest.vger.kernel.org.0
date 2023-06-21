Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E37378DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 03:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjFUBz3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 21:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFUBz2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 21:55:28 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4938D1989;
        Tue, 20 Jun 2023 18:55:27 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b44eddb52dso78037141fa.3;
        Tue, 20 Jun 2023 18:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687312525; x=1689904525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz+JcRD5iqUFNC0O0Ru60ZgS8tD+DjfgbMM6b7JgDDE=;
        b=I4Xks4H0f9hjuiTto0xGg2qYpfM1NZn0dyFE3RFSgjOTxwdHLkw2aJFM6SQ4UPOBl2
         dNK6TDWAZALS3CRzxzO+dpAo1U9mCItEUs562QTVmbmesDW2NSyCOoPgJOgoYQAz7I81
         HLw63JGcQ4kMncWwX/yetxeXc4t9tZnic1kQbgvD1AUCJKn28T1HFnucS8Q2s7Nx+DQZ
         f8U5MS+CPM3LZ1R10maFt1FXao1Rfu9UuLwRlmRiKcyG4Eu87O2mrDltGfJ0J9bBeZ4/
         piitDPizcx0RsJDQqHWespeaFg6I0iuKgvJ4MSz6hINYPHYT0FU7ayv5Ygm+4xicdr1J
         wVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687312525; x=1689904525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wz+JcRD5iqUFNC0O0Ru60ZgS8tD+DjfgbMM6b7JgDDE=;
        b=W129HB9FhH5JNVs2scLt/rhx90qKLPViGO6DBe41xDon9XwqS8mec8sPsB6uDq0hyg
         SRFM4Cw/gk/lVF2yrFCbuO4jod/A2WvJ9HZpCvsO+VsJGwa3ox4Qvmp2vHH2vcfWSuru
         oXw8xoBBRIpF4Af5sogZ2A1LCPnyMXO40R6Bu3e817SR8OIGORaiQc9QqQ5JsdZbXAt0
         edCKuUZRRzqYLxU/rjBfRhqNw73p8W0Zv+EVn+oamrloET8d34bPJ+9FO1U0jD92dEFU
         GlnPPApK6NIeQqi53/B6uLBA2X058FW0pdti1d04306KCKivqt4Eov3cqOIGWvZ52SjA
         vJ0g==
X-Gm-Message-State: AC+VfDzKfRRcYEh9t4LA5zxCJZ2boj+NtFSZdjRzcvY6k4/wuNU38Sr+
        pev1OvekFBHF+XbPkDZ1kLu/NsndCiVsFsSvYmA=
X-Google-Smtp-Source: ACHHUZ6wY9wkDAsQKF4/pJB6A70/338sp9DCerB/qo1fiLgVSLjXYq0d7uPy8bn+2oY5S0+fhyThzcL/uGhJOGcqvb4=
X-Received: by 2002:a05:6512:1cd:b0:4f9:573a:689d with SMTP id
 f13-20020a05651201cd00b004f9573a689dmr610014lfp.37.1687312525203; Tue, 20 Jun
 2023 18:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686275310.git.haibo1.xu@intel.com> <8cd4ce50f5f4a639f4508085959aae222d4d4386.1686275310.git.haibo1.xu@intel.com>
 <20230609-fba04b424a4d46574e04e587@orel> <CAJve8okjRZEt6_6SB9EWm+6c7utpExzenfWo2T1N-J6G9w9czQ@mail.gmail.com>
 <20230620-95ce8ab70956a72b9da3a31a@orel>
In-Reply-To: <20230620-95ce8ab70956a72b9da3a31a@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 21 Jun 2023 09:55:13 +0800
Message-ID: <CAJve8onNFfHFcvAGkbtnxjzqgfq4geL1zOwJEc8Xzc=NHVDrFg@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] KVM: riscv: selftests: Add get-reg-list test
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
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
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

On Tue, Jun 20, 2023 at 6:44=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Tue, Jun 20, 2023 at 06:05:59PM +0800, Haibo Xu wrote:
> > On Fri, Jun 9, 2023 at 9:35=E2=80=AFPM Andrew Jones <ajones@ventanamicr=
o.com> wrote:
> > >
> > > On Fri, Jun 09, 2023 at 10:12:18AM +0800, Haibo Xu wrote:
> > > > +static struct vcpu_reg_list aia_config =3D {
> > > > +     .sublists =3D {
> > > > +     BASE_SUBLIST,
> > > > +     AIA_REGS_SUBLIST,
> > > > +     {0},
> > > > +     },
> > > > +};
> > > > +
> > > > +static struct vcpu_reg_list fp_f_d_config =3D {
> > > > +     .sublists =3D {
> > > > +     BASE_SUBLIST,
> > > > +     FP_F_REGS_SUBLIST,
> > > > +     FP_D_REGS_SUBLIST,
> > > > +     {0},
> > > > +     },
> > > > +};
> > > > +
> > > > +struct vcpu_reg_list *vcpu_configs[] =3D {
> > > > +     &zicbo_config,
> > > > +     &aia_config,
> > > > +     &fp_f_d_config,
> > > > +};
> > > > +int vcpu_configs_n =3D ARRAY_SIZE(vcpu_configs);
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > I see we have a bit of a problem with the configs for riscv. Since we
> > > don't disable anything we're not testing, then for any test that is
> > > missing, for example, the f and d registers, we'll get output like
> > > "There are 66 new registers. Consider adding them to the blessed reg
> > > list with the following lines:" and then a dump of all the f and d
> > > registers. The test doesn't fail, but it's messy and confusing. Ideal=
ly
> > > we'd disable all registers of all sublists not in the config, probabl=
y
> > > by starting by disabling everything and then only reenabling the ones
> > > in the config.
> > >
> > > Anything that can't be disabled is either a KVM bug, i.e. we should
> > > be able to disable it, because we can't expect every host to have it,
> > > or it needs to be in the base register sublist (meaning every host
> > > will always have it).
> > >
> >
> > HI Andrew,
> >
> > I found several multi-letters ISA EXT(AIA/SSTC etc) were not allowed
> > to be disabled.
> > Is it a bug? shall we fix it=EF=BC=9F
>
> Extensions that a guest could use (regardless of whether or not the host
> described it in the guest's isa string), because the instructions or CSR
> accesses don't trap, can't truly be disabled. So, it's not a bug to
> prohibit disabling them and indeed the test cases should actually ensure
> disabling them fails.
>

So these kinds of ISA_EXT_* regs should be in the base reg list, right?

Thanks,
Haibo

> Thanks,
> drew
