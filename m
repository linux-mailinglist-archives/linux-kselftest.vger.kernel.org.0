Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBAC796F92
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 06:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjIGEU4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 00:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjIGEUq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 00:20:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF14E5A;
        Wed,  6 Sep 2023 21:20:42 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bd6611873aso8785181fa.1;
        Wed, 06 Sep 2023 21:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694060440; x=1694665240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggNyFVV0uCZfL0MPihiu3QYZ5fZKGzQ4fJp4UHCFGEg=;
        b=HWBS0nUWsOsKvQ+VXFuldC4tQTAUV+5XT5KWF26mFXmxg4cP72eH5F8dzz4e44Hul7
         gr8dj6BkTYGhOqEaBNi3t1Ngv7agqGfjaMs84hZYKbSFmAjIfQkInuoaSp6AgLHJDE/q
         IeL52TG5u338zUzHeypJi0VexrOhcRlgPrKy9twg4gkGzUQGnRFGb+6gNs3vaCz8t+X+
         733KrODsDS3eAiShJaj8OconiakzJeO4kvjpX60XzP8Sjm+yULWo1HZ5pN+vhrtoDej0
         VguEBFOxGjbUJgNwmI+50ccok55eTEdEOSsR7pCsZRyiccnTUZ871TUACHk+jZuWdBHK
         Z8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694060440; x=1694665240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggNyFVV0uCZfL0MPihiu3QYZ5fZKGzQ4fJp4UHCFGEg=;
        b=WK14T/19jeAA2PDIDskctzRwl24ReZGRmwkcPcxrkIwx87dPZsuKyjH2kwUM5zda1/
         LCP4ArMiMHolkp15T/mi+C+AXbeL69sbMyZaoneWzH73GHwMbCMia5eGPCYUkcCdoB2s
         HHFKgSm20CdDLbi5POS8InzQNwRa9IvCACZBXKbJWS4PBCTRTIinft2Z7drFDLf44GRo
         f8j9rfF5KpwcIZoBKYZNJXmeGvXgCuCnMILxtsHk/FPi3I6z2ZUB+Qknpc9QFwbTe7Zd
         OtHLqp3FDpSGgYy5eFeQk9hFFeDt4s2EcytLhHECmb8vMI/rMTkoiJFl7k+rx2E6Ta+A
         4aiw==
X-Gm-Message-State: AOJu0YxoKzq6d00tyAPacHLhzo0+nlCRLrr5bkRZ5t2eGxWy9izJTXhk
        qzL47t1r2pnPQ4/LKSzrxFUNebUhsYTfsKNM/ZQ=
X-Google-Smtp-Source: AGHT+IEs3wMkr3Qdbzy7z2cdD2QQiWNG7Kmko0xSRTbnllA2oAUwbpm0j15v/Il5Cbh5yzHk8TJ3foGdBVTBUXfKPp0=
X-Received: by 2002:a2e:8708:0:b0:2bb:aaec:abad with SMTP id
 m8-20020a2e8708000000b002bbaaecabadmr3613921lji.30.1694060440378; Wed, 06 Sep
 2023 21:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693659382.git.haibo1.xu@intel.com> <d2b3c53537fef3f0a2d27d8be663a64123d4bc3c.1693659382.git.haibo1.xu@intel.com>
 <20230904-a69c6a228bf4553cc58bca17@orel>
In-Reply-To: <20230904-a69c6a228bf4553cc58bca17@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Thu, 7 Sep 2023 12:20:29 +0800
Message-ID: <CAJve8ok03P-t7pTA9mH=5vvkUy4NtxHac_Z_NM88cs55YQZATg@mail.gmail.com>
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

On Mon, Sep 4, 2023 at 10:58=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Sat, Sep 02, 2023 at 08:59:30PM +0800, Haibo Xu wrote:
> > Add a KVM selftest to validate the Sstc timer functionality.
> > The test was ported from arm64 arch timer test.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---

> > diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/tes=
ting/selftests/kvm/riscv/arch_timer.c
> > new file mode 100644
> > index 000000000000..c50a33c1e4f9
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> > @@ -0,0 +1,130 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * arch_timer.c - Tests the riscv64 sstc timer IRQ functionality
> > + *
> > + * The test validates the sstc timer IRQs using vstimecmp registers.
> > + * It's ported from the aarch64 arch_timer test.
> > + *

> guest_run[_stage]() can be shared with aarch64, we just have a single
> stage=3D0 for riscv.
>

Yes, we can. But if we share the guest_run[_stage]() by moving it to
kvm/arch_timer.c
or kvm/include/timer_test.h, we need to declare extra sub-functions
somewhere in a
header file(etc. guest_configure_timer_action()).

> > +
> > +static void guest_code(void)
> > +{
> > +     uint32_t cpu =3D guest_get_vcpuid();
> > +     struct test_vcpu_shared_data *shared_data =3D &vcpu_shared_data[c=
pu];
> > +
> > +     local_irq_disable();
> > +     timer_irq_disable();
> > +     local_irq_enable();
>
> I don't think we need to disable all interrupts when disabling the timer
> interrupt.
>

There is no local_irq_disable() protection during the initial debug
phase, but the test always
fail with below error messages:

Guest assert failed,  vcpu 0; stage; 0; iter: 0
=3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
  riscv/arch_timer.c:78: config_iter + 1 =3D=3D irq_iter
  pid=3D585 tid=3D586 errno=3D4 - Interrupted system call
  (stack trace empty)
  0x1 !=3D 0x0 (config_iter + 1 !=3D irq_iter)

To be frank, I am not quite sure why the local_irq_disable/enable() matters=
.
One possible reason may be some timer irq was triggered before we set up th=
e
timecmp register.

> > +
> > +     guest_run(shared_data);
> > +
> > +     GUEST_DONE();
> > +}
> > +
> > +void test_vm_cleanup(struct kvm_vm *vm)
> > +{
> > +     kvm_vm_free(vm);
> > +}
> > --
> > 2.34.1
> >
>
> Thanks,
> drew
