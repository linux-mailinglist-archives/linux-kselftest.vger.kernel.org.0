Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2E879379C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 11:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjIFJBT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 05:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjIFJBT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 05:01:19 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C238E47;
        Wed,  6 Sep 2023 02:01:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso58103431fa.1;
        Wed, 06 Sep 2023 02:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693990872; x=1694595672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGBcwbFPU/bGY4zSYaJ1ifEXL5+F/gokQ5BwkUen+qA=;
        b=iI5Zx8SdjJeOWbbelquqp94upW5usvO+MVcmV0oJfjuP78uSgy2G5cQjzT6A1sOWZr
         2K+89cnS3vjSeedhw0EQl93KM3AKy/a5G3/+AKtY2Xc6ceg6FFdqOgZqDxfp9YALTIhh
         cChrPkvCBMTSltpGVkAAcIpJq4kb+nNsDAoVxg2lhaJ5130ZyM5vGe12+6ft5gBhgIsq
         1qdXc8lRux9aHDjOxkN9/xB5eFTnrOjbXMMzivbYOnixBAknmYRskvMH00tAUJkX1cpl
         RYS2KaiWpLm6nRNW0Af37Ua48+OavzJf2bo7kjkac+SyvWKrolUmrZs5bt8++OoQyfGC
         7z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693990872; x=1694595672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGBcwbFPU/bGY4zSYaJ1ifEXL5+F/gokQ5BwkUen+qA=;
        b=j99GDk0hsmQCnvZhnxHlboQ4Crftk5NPIFfB2jT3LZHqMpfCdDDL180Tbwb3V5xRJm
         z/ZkGereFJpSleTjpEYkJpl+bXZKI20DpM31K8GXYkQzGBYyWVe73voNKwWlW45HhSA+
         9QyJYczMInSgbk59vvgoEJpBT3n6PEg9KXzkT/v1ls0fTzTV3Ibf2NsnzpdVUnPnlKaY
         BwBRZYnkSpzZv7hHpfkXgW9y9fYosX6bm+uqmAxvqP+6kdlU1laPxZrPMEs/yq0xjn4n
         QGqkhlmUA99FukPQvF+mrg9FHNGbn0Ff+GhrWH2xIR0kfLc69eJTsQSGog1f6Hx9veRY
         azKw==
X-Gm-Message-State: AOJu0YzKcYRuaqqx2GBcrnr3chfLaOBbRxcEfegbeajLnJxKMu8O/E/t
        dZF2hHfsIVEt8DE0Gt69A3JSUjLQYihgNF2nG6Y=
X-Google-Smtp-Source: AGHT+IFEeFdFaGaTLQBI687uLLemZurhXtmM5YDshrwY9B8n6Jsr0TB3y/S2wMiOM3uqcoQPE8js1WezowOosvA6ZU4=
X-Received: by 2002:a2e:3603:0:b0:2b9:e53f:e201 with SMTP id
 d3-20020a2e3603000000b002b9e53fe201mr1722458lja.31.1693990872213; Wed, 06 Sep
 2023 02:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693659382.git.haibo1.xu@intel.com> <c87337cfd7fb135e2efed589360a78c26a402eac.1693659382.git.haibo1.xu@intel.com>
 <20230904-11e853ffe3d8e9cf9ec6079d@orel> <CAJve8onwjBQcbVy75qyOF3A51-T0WyBkmeCV_wOZvzaPcrBVFg@mail.gmail.com>
 <CAJve8ok-zZAG7T3t5XD-CtJn47tTE867Xaaw_YHYy1XmUL41rw@mail.gmail.com> <20230906-3f0318fa20365f9211998bae@orel>
In-Reply-To: <20230906-3f0318fa20365f9211998bae@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 6 Sep 2023 17:01:00 +0800
Message-ID: <CAJve8omsTQB04dZDCtK=0Fz3ExTuPFVQKvxz9Du5WyfqOwnuSg@mail.gmail.com>
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

On Wed, Sep 6, 2023 at 3:01=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Wed, Sep 06, 2023 at 11:44:26AM +0800, Haibo Xu wrote:
> > On Wed, Sep 6, 2023 at 10:14=E2=80=AFAM Haibo Xu <xiaobo55x@gmail.com> =
wrote:
> > >
> > > On Mon, Sep 4, 2023 at 9:24=E2=80=AFPM Andrew Jones <ajones@ventanami=
cro.com> wrote:
> ...
> > > > > +
> > > > > +enum guest_stage {
> > > > > +     GUEST_STAGE_VTIMER_CVAL=3D1,
> > > > > +     GUEST_STAGE_VTIMER_TVAL,
> > > > > +     GUEST_STAGE_PTIMER_CVAL,
> > > > > +     GUEST_STAGE_PTIMER_TVAL,
> > > > > +     GUEST_STAGE_MAX,
> > > > > +};
> > > >
> > > > This enum also belongs in aarch64/arch_timer.c
> > > >
> > >
> > > Yes, it should be in aarch64/arch_timer.c
> > >
> >
> > After moving the above enum definition to aarch64/arch_timer.c, the
> > below errors was reported
> > while compiling kvm/arch_timer.o
> >
> > include/timer_test.h:37:26: error: field =E2=80=98guest_stage=E2=80=99 =
has incomplete type
> >    37 |         enum guest_stage guest_stage;
> >         |                                        ^~~~~~~~~~~
> >
> > Since kvm/arch_timer.c was independent of kvm/aarch64/arch_timer.c
> > during OBJ compiling,
> > I think it may be not possible to move the enum definition to
> > aarch64/arch_timer.c
> >
> > If we keep the definition in this header file, we can enclose it with
> > #ifdef __aarch64__ for aarch64 only.
> >
>
> Let's change struct test_vcpu_shared_data to
>
>  struct test_vcpu_shared_data {
>         int nr_iter;
>         int guest_stage;
>         uint64_t xcnt;
>  };
>
> and then let the aarch64 code treat guest_stage as an enum and the riscv
> code can completely ignore it (no need to create an unused enum).
>

Good idea! Will fix it in v3.

> Thanks,
> drew
