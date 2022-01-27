Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8416B49D98F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 05:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiA0ERE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 23:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiA0ERE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 23:17:04 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4485C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 20:17:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so1676885pja.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 20:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MlI851lUoHdmSjJoGiyp5I4kiqlKaCdV4NPdXhxRA+8=;
        b=C8VvuZFe4rCP2uCFSONmb99RN1LdQn529TOYmrpKoK7PYZcziPiAhrOW11oPx+kR43
         opz70CnPxzxoZTYSSVhdERYlJMV8TdO2QuyuvwmFnkgUYxlX3/+xpOKrqI+Z+SedE8V0
         b2zhdCzpSnUjJajZlBYXB+FSVxcFj2HkqHfh92IhUWwU9i3Q4biweQtzgZksk14c+YiH
         52bQWQ89Jcu87pb3B4VxHhWSQojQZDN4MzrgykfnIRP/6lSrZxJ1K92QfFOGFIVPjDYw
         3UM41Q/sdGDYKwy0SqhzCI9wShehVrMqDwPAZ1e+aIL1TRmW3bpwLdmcoEgNXDTVMahN
         1OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MlI851lUoHdmSjJoGiyp5I4kiqlKaCdV4NPdXhxRA+8=;
        b=bTikZCw2+9MHtkWZfEIZQxa3zE3dYOPP392pPeAV9ljmCKAs98VoX/s+Qj2o68QWoJ
         ioDz4kH2cPpW4S7G997/eziBLb0SNwqGIT5koJkoPHdkJk7CdAoUCJuyd8Y5sYEKHrmv
         655swbdkAZXez6Jo+QYKGO0IMYeFjvO7lj0jd5/aRZKCLOV1zyQHWuL1E6nV4BPSg74r
         2ZicC9F4pTP3gcmbndAPkA3p74Vn54VGQtWVXOe1wl7o82jieZzcfRmh02Sa5FE04Zux
         nqPNC2KmorcVvh5CbBGRb1HX/vsZge5WEnEP30gGfNH+qhgu15CgBKvUuAnj/3H9kKz1
         ejjQ==
X-Gm-Message-State: AOAM533R+g2KMPjYHGx0Pdkh1g53JqyrToCULwCs6QPdx5PJQHR8IMcL
        zYk92lldl9fj31yk310JSbsrcg==
X-Google-Smtp-Source: ABdhPJzz3u8vPsKiH9OPkvGE3abpQ/af8KLmu4FJ0c7+83/vDdWzlReCnpAVhOP8ndMIaORK9xGeGg==
X-Received: by 2002:a17:902:f083:: with SMTP id p3mr2247927pla.72.1643257023220;
        Wed, 26 Jan 2022 20:17:03 -0800 (PST)
Received: from google.com (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with ESMTPSA id z7sm3556746pfe.49.2022.01.26.20.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 20:17:02 -0800 (PST)
Date:   Wed, 26 Jan 2022 20:16:59 -0800
From:   Ricardo Koller <ricarkol@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
Message-ID: <YfIcu2DMi83eua8C@google.com>
References: <20220126145242.3473836-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126145242.3473836-1-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 26, 2022 at 02:52:42PM +0000, Mark Brown wrote:
> The arch_timer and vgic_irq kselftests assume that they can create a
> vgic-v3, using the library function vgic_v3_setup() which aborts with a
> test failure if it is not possible to do so. Since vgic-v3 can only be
> instantiated on systems where the host has GICv3 this leads to false
> positives on older systems where that is not the case.
> 
> Fix this by changing vgic_v3_setup() to return an error if the vgic can't
> be instantiated and have the callers skip if this happens. We could also
> exit flagging a skip in vgic_v3_setup() but this would prevent future test
> cases conditionally deciding which GIC to use or generally doing more
> complex output.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> 
> v3:
>  - Use custom print_skip() helper.
>  - Use internal version of _kvm_create_device.
> v2:
>  - The test for being able to create the GIC doesn't actually
>    instantiate it, add a call doing so in that case.
> 
>  tools/testing/selftests/kvm/aarch64/arch_timer.c | 7 ++++++-
>  tools/testing/selftests/kvm/aarch64/vgic_irq.c   | 4 ++++
>  tools/testing/selftests/kvm/lib/aarch64/vgic.c   | 4 +++-
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index 9ad38bd360a4..b08d30bf71c5 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -366,6 +366,7 @@ static struct kvm_vm *test_vm_create(void)
>  {
>  	struct kvm_vm *vm;
>  	unsigned int i;
> +	int ret;
>  	int nr_vcpus = test_args.nr_vcpus;
>  
>  	vm = vm_create_default_with_vcpus(nr_vcpus, 0, 0, guest_code, NULL);
> @@ -382,7 +383,11 @@ static struct kvm_vm *test_vm_create(void)
>  
>  	ucall_init(vm, NULL);
>  	test_init_timer_irq(vm);
> -	vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
> +	ret = vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
> +	if (ret < 0) {
> +		print_skip("Failed to create vgic-v3");
> +		exit(KSFT_SKIP);
> +	}
>  
>  	/* Make all the test's cmdline args visible to the guest */
>  	sync_global_to_guest(vm, test_args);
> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> index e6c7d7f8fbd1..7eca97799917 100644
> --- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> +++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> @@ -761,6 +761,10 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
>  
>  	gic_fd = vgic_v3_setup(vm, 1, nr_irqs,
>  			GICD_BASE_GPA, GICR_BASE_GPA);
> +	if (gic_fd < 0) {
> +		print_skip("Failed to create vgic-v3, skipping");
> +		exit(KSFT_SKIP);
> +	}
>  
>  	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT,
>  		guest_irq_handlers[args.eoi_split][args.level_sensitive]);
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> index b3a0fca0d780..f5cd0c536d85 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> @@ -52,7 +52,9 @@ int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs,
>  			nr_vcpus, nr_vcpus_created);
>  
>  	/* Distributor setup */
> -	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
> +	if (_kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3,
> +			       false, &gic_fd) != 0)
> +		return -1;
>  
>  	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
>  			0, &nr_irqs, true);
> -- 
> 2.30.2
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

Tried both gicv2 and v3 and the change works as expected.

Tested-by: Ricardo Koller <ricarkol@google.com>
