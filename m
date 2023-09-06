Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADFD793577
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 08:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjIFGlx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 02:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241906AbjIFGlv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 02:41:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4810E58
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Sep 2023 23:41:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31c3df710bdso2584693f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Sep 2023 23:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693982493; x=1694587293; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CDrXgceSRA6nWxSqvxXedEAqqqoYTPyIJVyrWo9VKf8=;
        b=Lu+UYlga9SneyBsf/voQWHNOp476n6uzhXTP1EYiM5sCPq620kG69QXpZRE98j5Wrm
         TN8fM/ocUylv4qjKC9AdZhBJkAT/pcL5TtlZb7liB5Np1mQaMUygeFCz3S0oq/rPjy/3
         e5z6I6YrQEc06svLucP5y8i26FHIKUm0n+Xtwdq8715DB7Vp8AlJLRiBCLU3K71kFvno
         B5Q63+AqILSNim4lIHxEiqbtImtlB/FNdSB7m9hRU/DS01sDZgJxgthVBuuFKrNPPyTs
         g4TQCifUnlErVh5xWmKsdyHlhmEnRTu6Q+QDxxWGg/RfJkmV7QmGqgFMStQJAllAIZs5
         IC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693982493; x=1694587293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDrXgceSRA6nWxSqvxXedEAqqqoYTPyIJVyrWo9VKf8=;
        b=SJidWsJvMtqVYltTWZ+6p0nfRRGYbF6Ndw8iFl1wInqs4PfByLdWe6tbJz8YTfz/oQ
         oT/dWiXSmRwlHyYGTOJnA2H1eCWoPpdavyN8JV6lP19IAZAoelLqAIOI1pM8hoeLZ24s
         4NSdoWYWzwGS+/HYsx1L3E752N2ZXAkfVEU5GbmO14cihyTicILf5ip8rV149meJPh51
         49IuvPh3wC1Kvwa1SIlJWn3aA/akA6MDVlRXORCnZn9pchX712Hmd94ABKdsyFqXBsO+
         fX+Nts9gegs+YxXshqXmvUlxN/gWP0ihSi6jpNBvtgbj86heCw91At016+VvuS1AsPIy
         U2RQ==
X-Gm-Message-State: AOJu0YxI+G3YUU+qbhaeNnAjCs+tb5OiF75WECk04J+P1SDDOutLgudA
        uJVxrsMqcvz9/KF9232uCg3qTg==
X-Google-Smtp-Source: AGHT+IGX0i5tAkcMDPeTKOwlfoH2ZHWjyq3skD2KqOfwczWV54QzQ/+ExzzCATYleUpKxouAAc9edA==
X-Received: by 2002:a5d:6b49:0:b0:31a:ed75:75d6 with SMTP id x9-20020a5d6b49000000b0031aed7575d6mr1639449wrw.15.1693982493183;
        Tue, 05 Sep 2023 23:41:33 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id m14-20020a056000174e00b0031f3b04e7cdsm11905338wrf.109.2023.09.05.23.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 23:41:32 -0700 (PDT)
Date:   Wed, 6 Sep 2023 08:41:31 +0200
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
Message-ID: <20230906-6996fca9840e6de7b75692ec@orel>
References: <cover.1693659382.git.haibo1.xu@intel.com>
 <c87337cfd7fb135e2efed589360a78c26a402eac.1693659382.git.haibo1.xu@intel.com>
 <20230904-11e853ffe3d8e9cf9ec6079d@orel>
 <CAJve8onwjBQcbVy75qyOF3A51-T0WyBkmeCV_wOZvzaPcrBVFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8onwjBQcbVy75qyOF3A51-T0WyBkmeCV_wOZvzaPcrBVFg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 06, 2023 at 10:14:52AM +0800, Haibo Xu wrote:
> On Mon, Sep 4, 2023 at 9:24 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Sat, Sep 02, 2023 at 08:59:24PM +0800, Haibo Xu wrote:
...
> > > +
> > > +#include "kvm_util.h"
> > > +
> > > +#define NR_VCPUS_DEF            4
> > > +#define NR_TEST_ITERS_DEF       5
> > > +#define TIMER_TEST_PERIOD_MS_DEF    10
> > > +#define TIMER_TEST_ERR_MARGIN_US    100
> > > +#define TIMER_TEST_MIGRATION_FREQ_MS    2
> > > +
> > > +#define msecs_to_usecs(msec)    ((msec) * 1000LL)
> >
> > I'd move the above to include/test_util.h
> >
> 
> Yes, msecs_to_usecs() macro should be a common API for all the tests.
> 
> > > +
> > > +#define GICD_BASE_GPA    0x8000000ULL
> > > +#define GICR_BASE_GPA    0x80A0000ULL
> >
> > These defines belong in aarch64/arch_timer.c
> >
> 
> These 2 defines were also defined in other test cases, shall we move them
> to an aarch64 specific header file? Maybe
> tools/testing/selftests/kvm/include/aarch64/gic.h?

Even though currently all the aarch64 tests that use the gic are using
these defines for the base addresses, each test is free to choose whatever
base addresses it likes. I'd just move them back to aarch64/arch_timer.c
for now. Consolidating them into shared, default base addresses, if done
at all, is work for another series.

Thanks,
drew
