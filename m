Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301477369A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 12:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjFTKoP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 06:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjFTKoM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 06:44:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95181A5
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 03:44:07 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b45bc83f26so61005431fa.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 03:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687257843; x=1689849843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=faoJAf5HLjrBrs+IcgqfpLzetaGrKEXpSA60Yow7EsE=;
        b=OXFUWVLjaJd8V9KgupeF1CaurU0XOAFsMPzh9+id4S8/d8ji5GgCReuF9khP1ihvKd
         0KgLg1nz5tSh27tKR9fB1rjF/XSRcxxL1tmJs+CJo5nL8XUFi43p5PVOW9oXfzPy/9yC
         2hVdaH92UXlfjD8A/EVr0C7PMifQrez3wBrHbPfAHFg3wKuqcUngTOW++5kNPD2I0NqO
         r598tt/yFZhISYVLyyV39SZJzpz87uuYMxksCVkikmrBSfzjE8iN1FYpsNDQIapyxS2y
         vgEUu8QmDAKep7JUJK+MtpIShhSAlWybuPpJfJ5wW71E6sx6bKZoOir0VaHg9JjEIe44
         9GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687257843; x=1689849843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faoJAf5HLjrBrs+IcgqfpLzetaGrKEXpSA60Yow7EsE=;
        b=i0u3jt5Tfgxn5TBNPWqd44nmfYtjAPgt/ukXPW2CSYI9nrWKblQ3bDTyesTzOrfhAg
         m7F1ickVoQnYRvhBWtvvngF/KM0v+DF2LZnngvX8yogOhJ3NsSAUcg+4I89e6Gnu6ToW
         DEk9SXlMrhTAcnRaMdIFaE3XV/4RVGYmUnyfCsZT7md4zfH//+rtXRnnZZC1hneakA9l
         oCyhAp1Nf4wVKBbJ3st99v3Xf3dMWYcu1pXHbPiRm/H4JKSIdQKbGI+ksAY6RuPIZSaR
         nsIDnv2wHsH+D9wOgLYs+nzEtQWJAJHQbcMWFuB6jXbwFYbSXgm9JEyoK+sZ5Eo7Vicf
         jP4A==
X-Gm-Message-State: AC+VfDzd92pddmqh5/a8WBop/PWkHie0wSVLb8yku+sXkpor+ZrGb7wH
        mB+MlOXp4h3r0SICEpshDVYTog==
X-Google-Smtp-Source: ACHHUZ4P2ZMWloakXb40I06YdKtCNuGDp3Bvc4L3BXixlWUCHvujiSGB/uspgI/o6yV+CHWEQKCXyA==
X-Received: by 2002:a2e:9593:0:b0:2b1:be57:5c0c with SMTP id w19-20020a2e9593000000b002b1be575c0cmr7642708ljh.12.1687257842994;
        Tue, 20 Jun 2023 03:44:02 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id p16-20020a170906141000b0096f937b0d3esm1158226ejc.3.2023.06.20.03.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 03:44:02 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:44:01 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <xiaobo55x@gmail.com>
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
Subject: Re: [PATCH v3 10/10] KVM: riscv: selftests: Add get-reg-list test
Message-ID: <20230620-95ce8ab70956a72b9da3a31a@orel>
References: <cover.1686275310.git.haibo1.xu@intel.com>
 <8cd4ce50f5f4a639f4508085959aae222d4d4386.1686275310.git.haibo1.xu@intel.com>
 <20230609-fba04b424a4d46574e04e587@orel>
 <CAJve8okjRZEt6_6SB9EWm+6c7utpExzenfWo2T1N-J6G9w9czQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8okjRZEt6_6SB9EWm+6c7utpExzenfWo2T1N-J6G9w9czQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 20, 2023 at 06:05:59PM +0800, Haibo Xu wrote:
> On Fri, Jun 9, 2023 at 9:35 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Fri, Jun 09, 2023 at 10:12:18AM +0800, Haibo Xu wrote:
> > > +static struct vcpu_reg_list aia_config = {
> > > +     .sublists = {
> > > +     BASE_SUBLIST,
> > > +     AIA_REGS_SUBLIST,
> > > +     {0},
> > > +     },
> > > +};
> > > +
> > > +static struct vcpu_reg_list fp_f_d_config = {
> > > +     .sublists = {
> > > +     BASE_SUBLIST,
> > > +     FP_F_REGS_SUBLIST,
> > > +     FP_D_REGS_SUBLIST,
> > > +     {0},
> > > +     },
> > > +};
> > > +
> > > +struct vcpu_reg_list *vcpu_configs[] = {
> > > +     &zicbo_config,
> > > +     &aia_config,
> > > +     &fp_f_d_config,
> > > +};
> > > +int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
> > > --
> > > 2.34.1
> > >
> >
> > I see we have a bit of a problem with the configs for riscv. Since we
> > don't disable anything we're not testing, then for any test that is
> > missing, for example, the f and d registers, we'll get output like
> > "There are 66 new registers. Consider adding them to the blessed reg
> > list with the following lines:" and then a dump of all the f and d
> > registers. The test doesn't fail, but it's messy and confusing. Ideally
> > we'd disable all registers of all sublists not in the config, probably
> > by starting by disabling everything and then only reenabling the ones
> > in the config.
> >
> > Anything that can't be disabled is either a KVM bug, i.e. we should
> > be able to disable it, because we can't expect every host to have it,
> > or it needs to be in the base register sublist (meaning every host
> > will always have it).
> >
> 
> HI Andrew,
> 
> I found several multi-letters ISA EXT(AIA/SSTC etc) were not allowed
> to be disabled.
> Is it a bug? shall we fix it？

Extensions that a guest could use (regardless of whether or not the host
described it in the guest's isa string), because the instructions or CSR
accesses don't trap, can't truly be disabled. So, it's not a bug to
prohibit disabling them and indeed the test cases should actually ensure
disabling them fails.

Thanks,
drew
