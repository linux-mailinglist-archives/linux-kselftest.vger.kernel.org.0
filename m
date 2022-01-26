Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA42749CC1F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 15:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbiAZORr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 09:17:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235570AbiAZORq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 09:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643206666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pBsc1hWd3oxs011RR96KjS1IY2+oHS5R8Wd9986U2nM=;
        b=H2EPqIcOZn83jzuVsrPWJQWYQ/pBtxKHIWsnGg1hg9i1quFal4IWB4D6UyLty3uk9hs7pX
        AQkU8fM1NMCYmFCA2AOmMaah46jUoUAqIr729M/4jMrsGetzRCSZriSsEwJMUo2KEHubjE
        3F0Z9s6lCILBZ+4riJ6/RKdfsQ0Z55c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-utZkSHkNOrirDsvgINO4NQ-1; Wed, 26 Jan 2022 09:17:44 -0500
X-MC-Unique: utZkSHkNOrirDsvgINO4NQ-1
Received: by mail-ej1-f72.google.com with SMTP id m21-20020a1709061ed500b006b3003ec50dso4943443ejj.17
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 06:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pBsc1hWd3oxs011RR96KjS1IY2+oHS5R8Wd9986U2nM=;
        b=qk8OyHMo2T2ryteTYR7O2jIL/Bw37RettK9y7PdkSMVa5tOz/xSxFpScnTFB0rBGjo
         YPx3spXODDcJl9T/s46yU0nTj7i9w8zgt1H3RXW2Z5Ko4TSWOJQzcbLf+20be6Azu8Pi
         uqgXzFVovSExFQ3SXCRPY3M4dCqINQrPuzVieb7E9KaHxZDQ4TrT/c7/nvNf3j1JC2ly
         tZTK75h745dp82KCwYwEdhoOAN1qkTN2k8Rj9K3uYVL70nz0o71qjtNM/Hju9+xh5n8d
         TAaZPjqe5as45qXxJ5GxRjxHeIZx08sd0pN91TUHM8SMcTRaKR3DdmGhj+JywLb9Sz0B
         84bw==
X-Gm-Message-State: AOAM5303XMBn4qmfCDPIXx80S/ll/ak24yLINQqhinTycJ1X60TYYfop
        iJU6qRzoLPSHBs53guUwtoaIZ4D9Ev7OZFsz5Clx8pvvBTViOLtPeFNLvWCMc1Q7c2nzsbnmv9g
        U3dYfHZ9jF0C9507M+c6OzFuPcvBs
X-Received: by 2002:a17:906:4347:: with SMTP id z7mr21046210ejm.671.1643206663604;
        Wed, 26 Jan 2022 06:17:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzjw+1AXpd7hzxxgJS9LZv/KCQ4BAHMGkrSijf7nugItNU7ldGtWLdTM8SkChNzJwfiV99uQ==
X-Received: by 2002:a17:906:4347:: with SMTP id z7mr21046190ejm.671.1643206663327;
        Wed, 26 Jan 2022 06:17:43 -0800 (PST)
Received: from gator (cst2-173-70.cust.vodafone.cz. [31.30.173.70])
        by smtp.gmail.com with ESMTPSA id k23sm7491029ejr.65.2022.01.26.06.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 06:17:42 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:17:41 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
Message-ID: <20220126141741.zxxltis5zdtjzz33@gator>
References: <20220126135319.1918802-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126135319.1918802-1-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 26, 2022 at 01:53:19PM +0000, Mark Brown wrote:
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
> v2:
>  - The test for being able to create the GIC doesn't actually
>    instantiate it, add a call doing so in that case.
> 
>  tools/testing/selftests/kvm/aarch64/arch_timer.c | 7 ++++++-
>  tools/testing/selftests/kvm/aarch64/vgic_irq.c   | 4 ++++
>  tools/testing/selftests/kvm/lib/aarch64/vgic.c   | 5 ++++-
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index 9ad38bd360a4..791d38404652 100644
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
> +		pr_info("Failed to create vgic-v3, skipping\n");

Please use 'print_skip', which appends ", skipping test" to keep the skip
messages consistent. Also, print_skip can't be disabled with -DQUIET like
pr_info.

> +		exit(KSFT_SKIP);
> +	}
>  
>  	/* Make all the test's cmdline args visible to the guest */
>  	sync_global_to_guest(vm, test_args);
> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> index e6c7d7f8fbd1..b127a261fd29 100644
> --- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> +++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> @@ -761,6 +761,10 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
>  
>  	gic_fd = vgic_v3_setup(vm, 1, nr_irqs,
>  			GICD_BASE_GPA, GICR_BASE_GPA);
> +	if (gic_fd < 0) {
> +		pr_info("Failed to create vgic-v3, skipping\n");

print_skip

> +		exit(KSFT_SKIP);
> +	}
>  
>  	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT,
>  		guest_irq_handlers[args.eoi_split][args.level_sensitive]);
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> index b3a0fca0d780..4ea65e119bdd 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> @@ -51,7 +51,10 @@ int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs,
>  			"Number of vCPUs requested (%u) doesn't match with the ones created for the VM (%u)\n",
>  			nr_vcpus, nr_vcpus_created);
>  
> -	/* Distributor setup */
> +	/* Distributor setup - test if it's possible then actually do it */
> +	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, true);
> +	if (gic_fd != 0)
> +		return -1;
>  	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);

kvm selftests generally asserts on failure with the nonunderscore
prefixed KVM ioctl wrapper functions, which is why you appear to
be forced to do this nasty dance. However, kvm selftests usually
always also offers an underscore prefixed version of the KVM ioctl
wrapper function too for cases like these. So we can just do

  if (_kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false, &gic_fd) != 0)
          return -1;


Thanks,
drew

>  
>  	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
> -- 
> 2.30.2
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 

