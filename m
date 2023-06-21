Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD2C737C16
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 09:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjFUHaJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 03:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFUHaI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 03:30:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6301704
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 00:30:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-519b771f23aso7283742a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687332604; x=1689924604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZmyDfnK9tJh8eswYvjmWTei7tQJVIfXBxXoVL4SG7R8=;
        b=AErp9BkT1HOnQXLDaZG2ZhhgiFqoujRXuDRZ6mNMc66uo4iADPH8ND6vVT11LgrTTL
         AylPEuDYLAbzHcWd6s9RIjOsgstMtxC5b9BLtSsAOyK2HGqgHC3fff3Y4oZ7Y6VrxRlb
         xSE2jauM8NDE34EUg1l7tNFFj85RKWqV6X4jlUmegTW9fKm1MGIzqBLlvT7Dk2psnP4Y
         8HbScXfthtVm8E5V+taPq0gF55iLE02AnUSQSRYRIhOz37xoTjciAU4olKLgmAwzKjUw
         VAxO82NHkTCDWNCuSI/RyrXR9+cfwhF5scfDxoKd+zT2dCML+89Tp+fKPi19rwUbwudh
         B7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687332604; x=1689924604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmyDfnK9tJh8eswYvjmWTei7tQJVIfXBxXoVL4SG7R8=;
        b=Z0xif05e7b+CgU1rKspfKDzudkDqJEN7/uALC17GW3paa3nQrG47tTeQwMcVYTpk4A
         vjyecLUMa0JUM94Rz3D8bPi8DwNtkupTo9QYQvP8ayEFMZ2Wcfh0t7y2q9m6UauOkEVn
         TbsdMgZuboL7fBOzrSJGJV0zCQtLjcALV+2Pu9EvGHc1LHuvGnSpfXoNWAGqjcL911G1
         +jx80dPTxzmKymvJk37DSEKLdgOuq3PreW9XV20FUuprnIVKcGORH8EdwOD3UTsmn0XU
         C9sML4IB5U9PaCRvYXEcnoDX3F96/J7JthNRVJiaVfgsS2lZEN8824TxGRuXbBtrTJub
         lVDg==
X-Gm-Message-State: AC+VfDwK8zn+aL4QD48qStpBPUAo5qMk1EeVkNZAiBeSGRNeBFQf4emz
        Qz91RfDOm9ClBxmfoYuyskrRhw==
X-Google-Smtp-Source: ACHHUZ71iRvfbRckg3Spoocjgf5Ljr6HcH7QnRCM6WqfLPyHhFnJWAR3zMooBAb60KO2iMTWfdWlMw==
X-Received: by 2002:a17:906:9b88:b0:988:8fed:8ae9 with SMTP id dd8-20020a1709069b8800b009888fed8ae9mr7743704ejc.37.1687332604526;
        Wed, 21 Jun 2023 00:30:04 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id n17-20020a17090625d100b00988c6ac6b86sm2631710ejb.186.2023.06.21.00.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 00:30:03 -0700 (PDT)
Date:   Wed, 21 Jun 2023 09:30:02 +0200
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
Message-ID: <20230621-37ea9461250036cc2ec8c544@orel>
References: <cover.1686275310.git.haibo1.xu@intel.com>
 <8cd4ce50f5f4a639f4508085959aae222d4d4386.1686275310.git.haibo1.xu@intel.com>
 <20230609-fba04b424a4d46574e04e587@orel>
 <CAJve8okjRZEt6_6SB9EWm+6c7utpExzenfWo2T1N-J6G9w9czQ@mail.gmail.com>
 <20230620-95ce8ab70956a72b9da3a31a@orel>
 <CAJve8onNFfHFcvAGkbtnxjzqgfq4geL1zOwJEc8Xzc=NHVDrFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8onNFfHFcvAGkbtnxjzqgfq4geL1zOwJEc8Xzc=NHVDrFg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 21, 2023 at 09:55:13AM +0800, Haibo Xu wrote:
> On Tue, Jun 20, 2023 at 6:44 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Tue, Jun 20, 2023 at 06:05:59PM +0800, Haibo Xu wrote:
> > > On Fri, Jun 9, 2023 at 9:35 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> > > >
> > > > On Fri, Jun 09, 2023 at 10:12:18AM +0800, Haibo Xu wrote:
> > > > > +static struct vcpu_reg_list aia_config = {
> > > > > +     .sublists = {
> > > > > +     BASE_SUBLIST,
> > > > > +     AIA_REGS_SUBLIST,
> > > > > +     {0},
> > > > > +     },
> > > > > +};
> > > > > +
> > > > > +static struct vcpu_reg_list fp_f_d_config = {
> > > > > +     .sublists = {
> > > > > +     BASE_SUBLIST,
> > > > > +     FP_F_REGS_SUBLIST,
> > > > > +     FP_D_REGS_SUBLIST,
> > > > > +     {0},
> > > > > +     },
> > > > > +};
> > > > > +
> > > > > +struct vcpu_reg_list *vcpu_configs[] = {
> > > > > +     &zicbo_config,
> > > > > +     &aia_config,
> > > > > +     &fp_f_d_config,
> > > > > +};
> > > > > +int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
> > > > > --
> > > > > 2.34.1
> > > > >
> > > >
> > > > I see we have a bit of a problem with the configs for riscv. Since we
> > > > don't disable anything we're not testing, then for any test that is
> > > > missing, for example, the f and d registers, we'll get output like
> > > > "There are 66 new registers. Consider adding them to the blessed reg
> > > > list with the following lines:" and then a dump of all the f and d
> > > > registers. The test doesn't fail, but it's messy and confusing. Ideally
> > > > we'd disable all registers of all sublists not in the config, probably
> > > > by starting by disabling everything and then only reenabling the ones
> > > > in the config.
> > > >
> > > > Anything that can't be disabled is either a KVM bug, i.e. we should
> > > > be able to disable it, because we can't expect every host to have it,
> > > > or it needs to be in the base register sublist (meaning every host
> > > > will always have it).
> > > >
> > >
> > > HI Andrew,
> > >
> > > I found several multi-letters ISA EXT(AIA/SSTC etc) were not allowed
> > > to be disabled.
> > > Is it a bug? shall we fix it？
> >
> > Extensions that a guest could use (regardless of whether or not the host
> > described it in the guest's isa string), because the instructions or CSR
> > accesses don't trap, can't truly be disabled. So, it's not a bug to
> > prohibit disabling them and indeed the test cases should actually ensure
> > disabling them fails.
> >
> 
> So these kinds of ISA_EXT_* regs should be in the base reg list, right?
>

Ah, this is getting a bit messy. We don't want all these extensions in a
"base", which represents extensions for all possible hosts, because the
extensions are optional, but, we can't remove them from get-reg-list
output by disabling them, since they can't be disabled. It seems we
need the concept of "base", which is the common set expected on all hosts,
and also the concept of "this host's base". I'm struggling to think of
a nice way to deal with that. A first thought is to both add these types
of registers to their own extension-specific sublists and to filter_reg().
I think that will keep them from being reported as new registers in every
test, but also allow detection of them going missing when they're
extension is present.

Thanks,
drew
