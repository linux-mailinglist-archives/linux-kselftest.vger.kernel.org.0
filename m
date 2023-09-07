Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A33797C77
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 21:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbjIGTBS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 15:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjIGTBS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 15:01:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BAD90
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Sep 2023 12:01:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401f503b529so14516195e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Sep 2023 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694113272; x=1694718072; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eociOZShIIhf6uzSUtfcCoJa3P8brx2laWW2HO9Th3Y=;
        b=UtFwgFIJAYpE8b7JxW4fPjuOSxPcO1lLZULNmp1kswz0gfeYRxE5OhrrJhpCZEKvwa
         xwED1rVz9BcRgJ9cVGxdljos5vUT9FOS2bLnqptH8u11VhcfOgRVOQi2ICGVFNFOxTQg
         V6+Sp0kOrJ1ZG3SBlzGiz+f7pGCQAlduwrMwTcNK424SQXRiwyRV85J4m7bf3skugR6t
         zOXRlx5JVQiAo+3bJlEL/Z6/AjKSQj+J+uiY/K9Zz4Jv7UpCi6TqcfkziCk95MF81V0m
         CgvlSeI3Yqm7DVO4Aj2bizJokm7bFJDF9BA28y5ORthI9kPCDWILBzUd/M+pkUWf3huD
         KQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694113272; x=1694718072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eociOZShIIhf6uzSUtfcCoJa3P8brx2laWW2HO9Th3Y=;
        b=OJ/9RZ0ow58V3oeg+40TELDkgAetbWETRKnjYcSJamGmnSRRmX3hDX0Y8AfoTBRuaM
         zUPufQZx6MU51sXmwBCKbSO1VV4pGw3d14ox4RmfFBMrUvUjGnYmEtKSuIeew/78qcnb
         ijH/uV8OW+BlqCczFTtC4AQwb9xlN+XJsO9MMn2Stl7U/9ld3GVZgPVSfMwNhcpLvdjv
         He+14sYqIiQ9tpuexGPbAhJGt0RJ/Gf/XESoMJyE+SMnzI/HylcsY0x/edGtxsGsBO9q
         556aR/gBVm2fEDdcRVndCEdApt49hL617NRW5dgDeb7QEu4AB3Puqemqo83qTE50kUku
         cImA==
X-Gm-Message-State: AOJu0Yw1cW3xKjJ/+zlpjLpC/3rD35v+zwRLCvzGbbhnKIjJrYhm/5qL
        iAA8JCV5iX4TRj+gf/uvrNCthA==
X-Google-Smtp-Source: AGHT+IGhEgKQHBGkqLlsP4F/DGv1jyf9duZnERJIUkqYRa1UCO/fiKxyNhLBIfZMVQ0b4/1jnwd8TQ==
X-Received: by 2002:a05:600c:3b1f:b0:401:b204:3b85 with SMTP id m31-20020a05600c3b1f00b00401b2043b85mr392330wms.36.1694113272221;
        Thu, 07 Sep 2023 12:01:12 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id q10-20020adfea0a000000b0031ae2a7adb5sm109334wrm.85.2023.09.07.12.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 12:01:11 -0700 (PDT)
Date:   Thu, 7 Sep 2023 21:01:10 +0200
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
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Thomas Huth <thuth@redhat.com>, Like Xu <likexu@tencent.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>,
        zhang songyi <zhang.songyi@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 8/8] KVM: riscv: selftests: Add sstc timer test
Message-ID: <20230907-5d3da2b6dca23bedb31b33a0@orel>
References: <cover.1693659382.git.haibo1.xu@intel.com>
 <d2b3c53537fef3f0a2d27d8be663a64123d4bc3c.1693659382.git.haibo1.xu@intel.com>
 <20230904-a69c6a228bf4553cc58bca17@orel>
 <CAJve8ok03P-t7pTA9mH=5vvkUy4NtxHac_Z_NM88cs55YQZATg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="moqzehiniedyglk4"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8ok03P-t7pTA9mH=5vvkUy4NtxHac_Z_NM88cs55YQZATg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--moqzehiniedyglk4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Sep 07, 2023 at 12:20:29PM +0800, Haibo Xu wrote:
> On Mon, Sep 4, 2023 at 10:58 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Sat, Sep 02, 2023 at 08:59:30PM +0800, Haibo Xu wrote:
> > > Add a KVM selftest to validate the Sstc timer functionality.
> > > The test was ported from arm64 arch timer test.
> > >
> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > ---
> 
> > > diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
> > > new file mode 100644
> > > index 000000000000..c50a33c1e4f9
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> > > @@ -0,0 +1,130 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * arch_timer.c - Tests the riscv64 sstc timer IRQ functionality
> > > + *
> > > + * The test validates the sstc timer IRQs using vstimecmp registers.
> > > + * It's ported from the aarch64 arch_timer test.
> > > + *
> 
> > guest_run[_stage]() can be shared with aarch64, we just have a single
> > stage=0 for riscv.
> >
> 
> Yes, we can. But if we share the guest_run[_stage]() by moving it to
> kvm/arch_timer.c
> or kvm/include/timer_test.h, we need to declare extra sub-functions
> somewhere in a
> header file(etc. guest_configure_timer_action()).

OK, whatever balances the reduction of duplicate code and avoidance of
exporting helper functions. BTW, riscv may not need/want all the same
helper functions as aarch64. Anyway, I guess I'll see how the next version
turns out.

> 
> > > +
> > > +static void guest_code(void)
> > > +{
> > > +     uint32_t cpu = guest_get_vcpuid();
> > > +     struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
> > > +
> > > +     local_irq_disable();
> > > +     timer_irq_disable();
> > > +     local_irq_enable();
> >
> > I don't think we need to disable all interrupts when disabling the timer
> > interrupt.
> >
> 
> There is no local_irq_disable() protection during the initial debug
> phase, but the test always
> fail with below error messages:
> 
> Guest assert failed,  vcpu 0; stage; 0; iter: 0
> ==== Test Assertion Failure ====
>   riscv/arch_timer.c:78: config_iter + 1 == irq_iter
>   pid=585 tid=586 errno=4 - Interrupted system call
>   (stack trace empty)
>   0x1 != 0x0 (config_iter + 1 != irq_iter)
> 
> To be frank, I am not quite sure why the local_irq_disable/enable() matters.
> One possible reason may be some timer irq was triggered before we set up the
> timecmp register.

We should ensure we know the exact, expected state of the vcpu before,
during, and after the test. If a state doesn't match expectations,
then the test should assert and we should go investigate the test code
to see if setup/checking is correct. If it is, then we've found a bug
in KVM that we need to go investigate.

For Sstc, a pending timer interrupt completely depends on stimecmp, so
we need to watch that closely. Take a look at the attached simple timer
test I pulled together to illustrate how stimecmp, timer interrupt enable,
and all interrupt enable interact. You may want to use it to help port
the arch_timer.

Thanks,
drew

--moqzehiniedyglk4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="simple-riscv-timer-test.c"

#include <stdio.h>

#define CONFIG_64BIT
#include "kvm_util.h"
#include "riscv/arch_timer.h"

static unsigned long timer_freq;
static unsigned int irq_fired;

void mdelay(unsigned long msecs)
{
	while (msecs--)
		udelay(1000);
}

static void guest_irq_handler(struct ex_regs *regs)
{
	GUEST_PRINTF("%s\n", __func__);

	GUEST_ASSERT_EQ(regs->cause & ~CAUSE_IRQ_FLAG, IRQ_S_TIMER);

	irq_fired = 1;

	csr_write(CSR_STIMECMP, -1);
	while (csr_read(CSR_SIP) & IE_TIE)
		cpu_relax();
}

static void guest_code(void)
{
	GUEST_PRINTF("stage 1\n");
	mdelay(1000);

	GUEST_ASSERT_EQ(irq_fired, 0);

	GUEST_PRINTF("stage 2\n");
	timer_set_next_cval_ms(500);
	mdelay(1000);

	GUEST_ASSERT_EQ(irq_fired, 1);
	irq_fired = 0;

	GUEST_PRINTF("stage 3\n");
	csr_clear(CSR_SIE, IE_TIE);
	timer_set_next_cval_ms(500);
	mdelay(1000);

	GUEST_ASSERT_EQ(irq_fired, 0);

	GUEST_PRINTF("stage 4\n");
	csr_set(CSR_SIE, IE_TIE);
	mdelay(1);

	GUEST_ASSERT_EQ(irq_fired, 1);
	irq_fired = 0;

	GUEST_PRINTF("stage 5\n");
	csr_clear(CSR_SSTATUS, SR_IE);
	timer_set_next_cval_ms(500);
	mdelay(1000);

	GUEST_ASSERT_EQ(irq_fired, 0);

	GUEST_PRINTF("stage 6\n");
	csr_set(CSR_SSTATUS, SR_IE);
	mdelay(1);

	GUEST_ASSERT_EQ(irq_fired, 1);
	irq_fired = 0;

	GUEST_PRINTF("guest done\n");
	GUEST_DONE();
}

int main(void)
{
	struct kvm_vcpu *vcpu;
	struct kvm_vm *vm;
	struct ucall uc;
	uint64_t val;
	int done = 0;

	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
	vm_init_vector_tables(vm);
	vm_install_interrupt_handler(vm, guest_irq_handler);
	vcpu_init_vector_tables(vcpu);
	vcpu_set_reg(vcpu, RISCV_CSR_REG(sstatus), SR_IE);
	vcpu_set_reg(vcpu, RISCV_CSR_REG(sie), IE_TIE);

	vcpu_get_reg(vcpu, RISCV_TIMER_REG(frequency), &timer_freq);
	sync_global_to_guest(vm, timer_freq);

	vcpu_get_reg(vcpu, RISCV_TIMER_REG(compare), &val);
	assert(val == -1);

	while (!done) {
		vcpu_run(vcpu);

		switch (get_ucall(vcpu, &uc)) {
		case UCALL_PRINTF:
			printf("%s", uc.buffer);
			break;
		case UCALL_DONE:
			printf("Done.\n");
			done = 1;
			break;
		}
	}
}

--moqzehiniedyglk4--
