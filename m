Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E43A79809D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 04:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbjIHCg1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 22:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjIHCg0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 22:36:26 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9232F19A6;
        Thu,  7 Sep 2023 19:36:22 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bcda0aaf47so32875601fa.1;
        Thu, 07 Sep 2023 19:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694140581; x=1694745381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SloDScCMx4oSLnsTG5Eji59Tx/5anpswbLezsyOC20=;
        b=IW+D63zaZFzzl8kf+IK0KaHGSv9Nh1OHROaW2n9tGQl+7YI5OYJ99dQwL0zEmM0D5n
         gLyZOc1zzg0OBb/qQssmahuEVB7D4a9ffccrGWBTkiml4v70keClCOPuuw1JKOXSJHvQ
         84qJZgDJINlxtsiMMqUSWyTAVhIWjE7mj+6RLvJE2Q3OLUOBdgJi+6CcwfbUg8vvrPpt
         4ORVno6UM6v05/TgA5tNoKgjI+sC+vY5BK7u7q99/BVhz5VgRNgURFIjs5xVDgeuCTyf
         Co6EX69PqpdzXnwdO2Nl9FaPxyAFA8EhCUmYyVRR39xa6YOzS2hmFS7hoioy6ujHlqir
         Iu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694140581; x=1694745381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SloDScCMx4oSLnsTG5Eji59Tx/5anpswbLezsyOC20=;
        b=R2fL09PdhXVsqzWBdeK/EjofBjIc/ein0vClAygfa3vGERy8kv/0uHjtIpyKF79mQe
         XmtNCGfO7bg7StftT3ZX1nzpDjTWpTmG53ja6WusIwEnD60SKh6Efuyb3QwqbqGYuNlL
         7CTxDEl5eNcpt5NFrqkuEGBGtQhpKdOmFP5FRhw9q9gWCKDSLcNJGmR0W1lEbWntI5fH
         lmn5BcW5cf0voilRF3+i7/8DGaJ4bexJvR8IGbCwVXGzvtVEKacDkZq2EdaBncE4+/am
         vd3ezOTaXTREznsmEBGdcnlQbZReQGkMfIAI4vrMF64lcEKky80ISy6Ou6MNONk7aggC
         Ejew==
X-Gm-Message-State: AOJu0YxrS9d/TV4Ab2/VNr5Bx72nglgl9/rrWrsPel5VfdfqJQQ/Nlyn
        Nk2OGPUyRJJpe246R917Yr7y1jCTOT4KvY6imJ4=
X-Google-Smtp-Source: AGHT+IGPnaH1hB1XaAWpoSpVu9fE6H6lAvlQx/cBu/gZNMgWAzXLEKoti/amvId+mp2eIUJ6sUeQ6zygE6V1VF/TXK8=
X-Received: by 2002:a2e:800f:0:b0:2b9:601d:2c0 with SMTP id
 j15-20020a2e800f000000b002b9601d02c0mr285241ljg.25.1694140580444; Thu, 07 Sep
 2023 19:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693659382.git.haibo1.xu@intel.com> <d2b3c53537fef3f0a2d27d8be663a64123d4bc3c.1693659382.git.haibo1.xu@intel.com>
 <20230904-a69c6a228bf4553cc58bca17@orel> <CAJve8ok03P-t7pTA9mH=5vvkUy4NtxHac_Z_NM88cs55YQZATg@mail.gmail.com>
 <20230907-5d3da2b6dca23bedb31b33a0@orel> <CAJve8om1VibbkHBuG4B+KbKY2eug42wGk9wiYtCYeF-WDY8EgQ@mail.gmail.com>
In-Reply-To: <CAJve8om1VibbkHBuG4B+KbKY2eug42wGk9wiYtCYeF-WDY8EgQ@mail.gmail.com>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Fri, 8 Sep 2023 10:36:09 +0800
Message-ID: <CAJve8o=_09khYSEapJfb2xiqzCLdM6FbR=Q9gAawZ6nhHDUZCQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] KVM: riscv: selftests: Add sstc timer test
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
        Greentime Hu <greentime.hu@sifive.com>,
        wchen <waylingii@gmail.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        David Matlack <dmatlack@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Thomas Huth <thuth@redhat.com>, Like Xu <likexu@tencent.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>,
        zhang songyi <zhang.songyi@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
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

On Fri, Sep 8, 2023 at 9:19=E2=80=AFAM Haibo Xu <xiaobo55x@gmail.com> wrote=
:
>
> On Fri, Sep 8, 2023 at 3:01=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
> >
> > On Thu, Sep 07, 2023 at 12:20:29PM +0800, Haibo Xu wrote:
> > > On Mon, Sep 4, 2023 at 10:58=E2=80=AFPM Andrew Jones <ajones@ventanam=
icro.com> wrote:
> > > >
> > > > On Sat, Sep 02, 2023 at 08:59:30PM +0800, Haibo Xu wrote:
> > > > > Add a KVM selftest to validate the Sstc timer functionality.
> > > > > The test was ported from arm64 arch timer test.
> > > > >
> > > > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > > > ---
> > >
> > > > > diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/too=
ls/testing/selftests/kvm/riscv/arch_timer.c
> > > > > new file mode 100644
> > > > > index 000000000000..c50a33c1e4f9
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> > > > > @@ -0,0 +1,130 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * arch_timer.c - Tests the riscv64 sstc timer IRQ functionality
> > > > > + *
> > > > > + * The test validates the sstc timer IRQs using vstimecmp regist=
ers.
> > > > > + * It's ported from the aarch64 arch_timer test.

> > >
> > > > > +
> > > > > +static void guest_code(void)
> > > > > +{
> > > > > +     uint32_t cpu =3D guest_get_vcpuid();
> > > > > +     struct test_vcpu_shared_data *shared_data =3D &vcpu_shared_=
data[cpu];
> > > > > +
> > > > > +     local_irq_disable();
> > > > > +     timer_irq_disable();
> > > > > +     local_irq_enable();
> > > >
> > > > I don't think we need to disable all interrupts when disabling the =
timer
> > > > interrupt.
> > > >
> > >
> > > There is no local_irq_disable() protection during the initial debug
> > > phase, but the test always
> > > fail with below error messages:
> > >
> > > Guest assert failed,  vcpu 0; stage; 0; iter: 0
> > > =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
> > >   riscv/arch_timer.c:78: config_iter + 1 =3D=3D irq_iter
> > >   pid=3D585 tid=3D586 errno=3D4 - Interrupted system call
> > >   (stack trace empty)
> > >   0x1 !=3D 0x0 (config_iter + 1 !=3D irq_iter)
> > >
> > > To be frank, I am not quite sure why the local_irq_disable/enable() m=
atters.
> > > One possible reason may be some timer irq was triggered before we set=
 up the
> > > timecmp register.
> >
> > We should ensure we know the exact, expected state of the vcpu before,
> > during, and after the test. If a state doesn't match expectations,
> > then the test should assert and we should go investigate the test code
> > to see if setup/checking is correct. If it is, then we've found a bug
> > in KVM that we need to go investigate.
> >
> > For Sstc, a pending timer interrupt completely depends on stimecmp, so
> > we need to watch that closely. Take a look at the attached simple timer
> > test I pulled together to illustrate how stimecmp, timer interrupt enab=
le,
> > and all interrupt enable interact. You may want to use it to help port
> > the arch_timer.
> >
>
> Thanks for sharing the test codes. Will have an investigation on it.
>

Hi Andrew,

You are right. The local_irq_disable() was not needed here.
It's my fault that I also removed the local_irq_enable() when trying
your suggestion.

Thanks for your review and help on this patch set!

Regards,
Haibo

> > Thanks,
> > drew
