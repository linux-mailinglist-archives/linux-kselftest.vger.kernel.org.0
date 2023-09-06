Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C707935C8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 08:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbjIFG64 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 02:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjIFG64 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 02:58:56 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725D5CC3;
        Tue,  5 Sep 2023 23:58:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so49773581fa.3;
        Tue, 05 Sep 2023 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693983531; x=1694588331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj5YAk9nW64JbldMW8YdC1sTTtqvjYgtps2lTsCHpYo=;
        b=LPu84lZmxgvrveLbNL7nDjLSJYFr5gP9ZMJngET9VkWnbaIFKyiIWk0CIgT9my0cHN
         s011Yy9Vq/jAcYcK73TyBP9oKxtLBXGumWNjM6tWZzUwGjUYo6ExXh2upQ4EExDN1CNM
         lD75/+KYJC5GIhbjS69guKgq3RARge8nD9Bi1G3ZGtA73Y10WOLLOawhDjqg7oH7SEEX
         RJ8QTgZLPlALlv/kd6puHe9i1sz3Kc+wz7kubyyVNWQfQ7mCmgTvYcd/11J3IeyArR/r
         1/x9lSXpc6q9r9k9+pmw+CEgfe+SFLK8bo/wcDsL69KCgpoDrPcB3XCdafUXHwoxg0vj
         CVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693983531; x=1694588331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj5YAk9nW64JbldMW8YdC1sTTtqvjYgtps2lTsCHpYo=;
        b=EiIAiMgve75cpXmRbXL1cRpC70QG6750dbEH/TdMr06ygPOxf9Bw2+HYXlKgvBEcYk
         iSqG5x2NKc7RhNps4E4DoiYdarGnNNJyp+JZxZkfOmJJewc/SHDfB/00gmQ4RxF/Mjcz
         nVHCBD76NAiOJXeraVrMMUCfW8m1CoVc6JuxQhQE1uLl033QcXIfpBY7M0yxhc/qSawh
         K8E4JoqpYUjgHujeIBSw5uEmwYAoHQNzKZ2zVRtHRDrwu/dwRId8t/mz8Nclibuj3BJW
         uzmi3bZ1e/9PdT75orgREIR+Ij+3jlcNaXr9waUXVaT8/uTOfBtxaQVOlSlkIITq2YcY
         jdGw==
X-Gm-Message-State: AOJu0YwqnTI+hS71D93kJLI74CjjyhfiVIcnwPhol2H752GuG5rFACmR
        iRBeEOxkQnxOFItYJO3iF3nEK7KigB342MugkCQ=
X-Google-Smtp-Source: AGHT+IE5k4BkYJLpWFCfNUOmKLfmxEPqFdxQE/tVIpYXTE4NnniGY9MqScwe9jg+eEiCfVTG2Yf6yKtZBBdMlQhXqo0=
X-Received: by 2002:a2e:a16f:0:b0:2b9:36d5:729c with SMTP id
 u15-20020a2ea16f000000b002b936d5729cmr1600017ljl.47.1693983530484; Tue, 05
 Sep 2023 23:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693659382.git.haibo1.xu@intel.com> <c87337cfd7fb135e2efed589360a78c26a402eac.1693659382.git.haibo1.xu@intel.com>
 <20230904-11e853ffe3d8e9cf9ec6079d@orel> <CAJve8onwjBQcbVy75qyOF3A51-T0WyBkmeCV_wOZvzaPcrBVFg@mail.gmail.com>
 <20230906-6996fca9840e6de7b75692ec@orel>
In-Reply-To: <20230906-6996fca9840e6de7b75692ec@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 6 Sep 2023 14:58:39 +0800
Message-ID: <CAJve8okKAMp5dG-=rwmP+8ndk_jzOvAz5s8uhU8JdMer5WbEng@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] KVM: arm64: selftest: Split arch_timer test code
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
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 6, 2023 at 2:41=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Wed, Sep 06, 2023 at 10:14:52AM +0800, Haibo Xu wrote:
> > On Mon, Sep 4, 2023 at 9:24=E2=80=AFPM Andrew Jones <ajones@ventanamicr=
o.com> wrote:
> > >
> > > On Sat, Sep 02, 2023 at 08:59:24PM +0800, Haibo Xu wrote:
> ...
> > > > +
> > > > +#include "kvm_util.h"
> > > > +
> > > > +#define NR_VCPUS_DEF            4
> > > > +#define NR_TEST_ITERS_DEF       5
> > > > +#define TIMER_TEST_PERIOD_MS_DEF    10
> > > > +#define TIMER_TEST_ERR_MARGIN_US    100
> > > > +#define TIMER_TEST_MIGRATION_FREQ_MS    2
> > > > +
> > > > +#define msecs_to_usecs(msec)    ((msec) * 1000LL)
> > >
> > > I'd move the above to include/test_util.h
> > >
> >
> > Yes, msecs_to_usecs() macro should be a common API for all the tests.
> >
> > > > +
> > > > +#define GICD_BASE_GPA    0x8000000ULL
> > > > +#define GICR_BASE_GPA    0x80A0000ULL
> > >
> > > These defines belong in aarch64/arch_timer.c
> > >
> >
> > These 2 defines were also defined in other test cases, shall we move th=
em
> > to an aarch64 specific header file? Maybe
> > tools/testing/selftests/kvm/include/aarch64/gic.h?
>
> Even though currently all the aarch64 tests that use the gic are using
> these defines for the base addresses, each test is free to choose whateve=
r
> base addresses it likes. I'd just move them back to aarch64/arch_timer.c
> for now. Consolidating them into shared, default base addresses, if done
> at all, is work for another series.
>

Ok, will move them to aarch64/arch_timer.c for this test.

> Thanks,
> drew
