Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF7C7935D5
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 09:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjIFHCB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 03:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjIFHCA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 03:02:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B808E45
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Sep 2023 00:01:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31ad9155414so2598696f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Sep 2023 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693983713; x=1694588513; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7a/rYlLL01jELhspFfU/LX4lJTwK+IpYr9KpIjgxodg=;
        b=CXDgB5fIUUXU9JDvrWiRksAZXazJ3wpi4PixjFkGD0V3IKnzrS3y4qCs+Cguox/kXB
         0qlKVtEtVxeAIP5AXbtx7AB3rjY3iFEJRcFuaFLugqGOj24qHF/gRMsVIE8Oj0+b1PT8
         v62168zbbc8DzKFNEXPd9soU3UyjMAmpr3c+gbai7SFGkgjrkxENgGsIs0DZFtZDE1u4
         mJqW1MmqA5N7HvpJ10n8iSMUy5ZDnOMFklWbDIi4h73lizQLD0NvLNGoTdVzCXHS1INe
         EMPG3GzTp1Ja0+z8OF5W6FCegJqKdHOIc7S2oZgMp62/9tNTszzhUt9rXc03xeHhWL7a
         Rf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693983713; x=1694588513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7a/rYlLL01jELhspFfU/LX4lJTwK+IpYr9KpIjgxodg=;
        b=CaeeEkpohhdvoY01YbfuCA6VWYGtCbF/CHWSF6UOnqGEdbZE2v1NeyfkPrOADEXOOq
         8taSXExGffbFHxqGQW0+Ea9uxcegvk4P6Md86isLBDrv9L6l8Yib2ygBGdr81x6ZBIgy
         NIMAlHv52PSCjJBvdIFZs/e9bLRLf8NrSvc4N6uDpaW4B6YHMbSeXBXmrZxtgND+1Snj
         pat8eBn+e96SiJPtctTRMDyEyiySIJhISX/07BaIUQYnm6sbV2Ao1HOeIMN35lXD7smC
         dx5p4MA+9xoTDNe5DqDBWp5QTHGK4Hxsvoi7VgQlDFOl6LuH5mJQfv7z4MImcaOv84x3
         lsuw==
X-Gm-Message-State: AOJu0Yyh3oc5vLR2DEv17jHciNXe0z/fRAQsxbrKYkfkWZJ8RlVxPX6K
        Tv1CtV0WQ7G5thVHtb2AMbjWxw==
X-Google-Smtp-Source: AGHT+IH5D+U+nZV7Ok6E7RGjtfz50olmDnpckxh8umsRSqUfH3ZIM1q14NQMvG0C714ykQWhmjyeJw==
X-Received: by 2002:adf:e7d0:0:b0:31c:8151:86a9 with SMTP id e16-20020adfe7d0000000b0031c815186a9mr1273125wrn.67.1693983713483;
        Wed, 06 Sep 2023 00:01:53 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id l5-20020a5d4805000000b003197c7d08ddsm19530729wrq.71.2023.09.06.00.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 00:01:52 -0700 (PDT)
Date:   Wed, 6 Sep 2023 09:01:51 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <xiaobo55x@gmail.com>
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
        Conor Dooley <conor.dooley@microchip.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Lei Wang <lei4.wang@intel.com>, Like Xu <likexu@tencent.com>,
        Peter Gonda <pgonda@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/8] KVM: arm64: selftest: Split arch_timer test code
Message-ID: <20230906-3f0318fa20365f9211998bae@orel>
References: <cover.1693659382.git.haibo1.xu@intel.com>
 <c87337cfd7fb135e2efed589360a78c26a402eac.1693659382.git.haibo1.xu@intel.com>
 <20230904-11e853ffe3d8e9cf9ec6079d@orel>
 <CAJve8onwjBQcbVy75qyOF3A51-T0WyBkmeCV_wOZvzaPcrBVFg@mail.gmail.com>
 <CAJve8ok-zZAG7T3t5XD-CtJn47tTE867Xaaw_YHYy1XmUL41rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8ok-zZAG7T3t5XD-CtJn47tTE867Xaaw_YHYy1XmUL41rw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 06, 2023 at 11:44:26AM +0800, Haibo Xu wrote:
> On Wed, Sep 6, 2023 at 10:14 AM Haibo Xu <xiaobo55x@gmail.com> wrote:
> >
> > On Mon, Sep 4, 2023 at 9:24 PM Andrew Jones <ajones@ventanamicro.com> wrote:
...
> > > > +
> > > > +enum guest_stage {
> > > > +     GUEST_STAGE_VTIMER_CVAL=1,
> > > > +     GUEST_STAGE_VTIMER_TVAL,
> > > > +     GUEST_STAGE_PTIMER_CVAL,
> > > > +     GUEST_STAGE_PTIMER_TVAL,
> > > > +     GUEST_STAGE_MAX,
> > > > +};
> > >
> > > This enum also belongs in aarch64/arch_timer.c
> > >
> >
> > Yes, it should be in aarch64/arch_timer.c
> >
> 
> After moving the above enum definition to aarch64/arch_timer.c, the
> below errors was reported
> while compiling kvm/arch_timer.o
> 
> include/timer_test.h:37:26: error: field ‘guest_stage’ has incomplete type
>    37 |         enum guest_stage guest_stage;
>         |                                        ^~~~~~~~~~~
> 
> Since kvm/arch_timer.c was independent of kvm/aarch64/arch_timer.c
> during OBJ compiling,
> I think it may be not possible to move the enum definition to
> aarch64/arch_timer.c
> 
> If we keep the definition in this header file, we can enclose it with
> #ifdef __aarch64__ for aarch64 only.
>

Let's change struct test_vcpu_shared_data to

 struct test_vcpu_shared_data {
        int nr_iter;
        int guest_stage;
        uint64_t xcnt;
 };

and then let the aarch64 code treat guest_stage as an enum and the riscv
code can completely ignore it (no need to create an unused enum).

Thanks,
drew
