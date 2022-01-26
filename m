Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBC949C0B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 02:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbiAZBXG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 20:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbiAZBXF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 20:23:05 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B05C06161C
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 17:23:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h12so21762831pjq.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 17:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qp4BntvRZm9hTr6l3zGlLo/U2BcJeqsTUdhiP4SKrfc=;
        b=rnMb5VODVOzw+bv9bS2Xh/FWWtA0ngwR5DIt+Eo6WtS6Vq3bu0jdGnsnzLxJOCMDSF
         3sZYL4sHTlkLgSt07lNK6NTk7Ohc91R982WORpBXrfy32BHbh8apbLZbEq6iNcHcYE+6
         kLRZgGsIB7vAQDROpGqNVavQ2hWrbh94yAxs9+jhALNKxRMiMVBmQ/5l18fGqc33aSYk
         /6WzA0JspTrE0U6yjgA+l7V89fh84lGmtLjC23lM723iKZHGvqaXzXWp+uG8Pe8sAMDL
         c1pei8gFnnxoRhaxF2kRSdqzGHqGs4tQ+EwGyMmp5h+d/AElW0VuAJMeiwXS0gQBPigP
         aOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qp4BntvRZm9hTr6l3zGlLo/U2BcJeqsTUdhiP4SKrfc=;
        b=sBnLZ/y0gaIuxCk/urYJ5Yvn51M0MnNzUnVAiyztE2yAbCKHfzkgjrHmjRhFiK0WRU
         FH0OT18bDOdCO9D/o3mI5BIv4d3cprWmcIfpbjJbNVEjkPFBgmVFGhsrF6Ju2xw6Ky6J
         +USG8/pajKL0cNXfW34uoeU2i/Y2fXb/crpQ3moct91xuINhOuteVAzl4r1Par54pU8x
         gxbfj2FhYrjuTqHxizHeenBmxSlp8fqgMPqhzX1wLMW9uD1aBZyktb2f2aaUdfuY+rLu
         5mtbi4PCD7c48VV/lF0NgWaVN+tRabWSvcALaBZFy9eI9zMkD1nzPl0pfyh2XSLoUuja
         +GOA==
X-Gm-Message-State: AOAM530rtsLsA/Hk058stUFXjeIhVMuB52Li2j9Rnqmsi8sei8HOLsgE
        EspMdSAy8GgK/tAFNwV89EKN3w==
X-Google-Smtp-Source: ABdhPJy6cZxhtYaWpqQmPdBWff89FNYeHqo7ViO8layI33gz7tVSxvOa9Wo7gfzqkIxzBwDanL5/MA==
X-Received: by 2002:a17:90a:e38d:: with SMTP id b13mr6198622pjz.205.1643160184936;
        Tue, 25 Jan 2022 17:23:04 -0800 (PST)
Received: from google.com (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with ESMTPSA id u16sm220313pfg.192.2022.01.25.17.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 17:23:04 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:23:00 -0800
From:   Ricardo Koller <ricarkol@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
Message-ID: <YfCidIboLDMb/Hy3@google.com>
References: <20220125192851.3907611-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125192851.3907611-1-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 25, 2022 at 07:28:51PM +0000, Mark Brown wrote:
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
>  tools/testing/selftests/kvm/aarch64/arch_timer.c | 7 ++++++-
>  tools/testing/selftests/kvm/aarch64/vgic_irq.c   | 5 +++++
>  tools/testing/selftests/kvm/lib/aarch64/vgic.c   | 4 +++-
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
> +		exit(KSFT_SKIP);
> +	}
>  
>  	/* Make all the test's cmdline args visible to the guest */
>  	sync_global_to_guest(vm, test_args);
> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> index e6c7d7f8fbd1..8c6b61b8e6aa 100644
> --- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> +++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> @@ -761,6 +761,11 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
>  
>  	gic_fd = vgic_v3_setup(vm, 1, nr_irqs,
>  			GICD_BASE_GPA, GICR_BASE_GPA);
> +	if (gic_fd < 0) {
> +		pr_info("Failed to create vgic-v3, skipping\n");
> +		exit(KSFT_SKIP);
> +	}
> +
>  
>  	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT,
>  		guest_irq_handlers[args.eoi_split][args.level_sensitive]);
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> index b3a0fca0d780..647c18733e1b 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> @@ -52,7 +52,9 @@ int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs,
>  			nr_vcpus, nr_vcpus_created);
>  
>  	/* Distributor setup */
> -	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
> +	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, true);
> +	if (gic_fd == -1)
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

Reviewed-by: Ricardo Koller <ricarkol@google.com>
