Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2E449D273
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 20:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244435AbiAZTWs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 14:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244436AbiAZTWp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 14:22:45 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C1C061747
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 11:22:45 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id s18so802025ioa.12
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 11:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n9wWO2kF4rFaljRmemUKUUwcl0pD1c9sVZULop7qOg0=;
        b=T3vyHziaToGv/jTvQ8gtXQni9vPZRAE+hFYHOT48z3CIDJYOmh5jobc1XdoEV1opZA
         4liTl0zTfDT41yyLD6hYTTKZM2T8dQTdCqBuUbgvVlnQ5ukm+PZ2k+mXOyHfautMlFNT
         An/W+h/uRDUoL79mrVx/OoUq/ppAdHDv8DkqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n9wWO2kF4rFaljRmemUKUUwcl0pD1c9sVZULop7qOg0=;
        b=cwJ7I0NXm9D7RG9T3DU2c3JSfTkNbRiP758UkHtRiIa6mU+OW1CjIBGe1klu7p0zmZ
         0yIqlb7ODNAUwXx8eXIJPcFgdDnW69kVGlF8TKH/ejsQV0srlciM07koBov8R6fS0dbN
         v1Y1ga516Qo0F+tEzSB94Xn14j9aX806oF9JKQ4qKG9oPBSvJ4hB1Gjuvci1lcX18Ax2
         4K2hi/FjcCAoMuzM3kg2e43AEziJJliVvyAwn8XaTlp8faWX9N6Js2zlBDOE9UNJDqP6
         VxTvKq8WeKDNn1+U7bKP5HKEMSyc13hJRG1k49WI+YmKjAqetpOWGwITfVIsqggPOKTm
         s2Rg==
X-Gm-Message-State: AOAM532Mcu52luxcZ5PBzvUHL7lzECcrT5bPBnW8jCBA1AOtB6cEFOnb
        LZW0QdQ3fBb4zhBkCquWpiyyaw==
X-Google-Smtp-Source: ABdhPJwCblxPTMhz5uV/5mImMlyinQgVdSuG+SpZApm13O6P9XQysEdwJNkXJcFFMW5ikGL+WP8yog==
X-Received: by 2002:a05:6638:1186:: with SMTP id f6mr75676jas.52.1643224964734;
        Wed, 26 Jan 2022 11:22:44 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y6sm2489246iow.48.2022.01.26.11.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 11:22:44 -0800 (PST)
Subject: Re: [PATCH v3] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
To:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126145242.3473836-1-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4424dd30-f74b-006f-b540-dbaf02e45e28@linuxfoundation.org>
Date:   Wed, 26 Jan 2022 12:22:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220126145242.3473836-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/26/22 7:52 AM, Mark Brown wrote:
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
>   - Use custom print_skip() helper.
>   - Use internal version of _kvm_create_device.
> v2:
>   - The test for being able to create the GIC doesn't actually
>     instantiate it, add a call doing so in that case.
> 
>   tools/testing/selftests/kvm/aarch64/arch_timer.c | 7 ++++++-
>   tools/testing/selftests/kvm/aarch64/vgic_irq.c   | 4 ++++
>   tools/testing/selftests/kvm/lib/aarch64/vgic.c   | 4 +++-
>   3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index 9ad38bd360a4..b08d30bf71c5 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -366,6 +366,7 @@ static struct kvm_vm *test_vm_create(void)
>   {
>   	struct kvm_vm *vm;
>   	unsigned int i;
> +	int ret;
>   	int nr_vcpus = test_args.nr_vcpus;
>   
>   	vm = vm_create_default_with_vcpus(nr_vcpus, 0, 0, guest_code, NULL);
> @@ -382,7 +383,11 @@ static struct kvm_vm *test_vm_create(void)
>   
>   	ucall_init(vm, NULL);
>   	test_init_timer_irq(vm);
> -	vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
> +	ret = vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
> +	if (ret < 0) {
> +		print_skip("Failed to create vgic-v3");

Printing the negative error code returned by vgic_v3_setup will be useful.

> +		exit(KSFT_SKIP);
> +	}
>   
>   	/* Make all the test's cmdline args visible to the guest */
>   	sync_global_to_guest(vm, test_args);
> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> index e6c7d7f8fbd1..7eca97799917 100644
> --- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> +++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> @@ -761,6 +761,10 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
>   
>   	gic_fd = vgic_v3_setup(vm, 1, nr_irqs,
>   			GICD_BASE_GPA, GICR_BASE_GPA);
> +	if (gic_fd < 0) {
> +		print_skip("Failed to create vgic-v3, skipping");

Same here.

> +		exit(KSFT_SKIP);
> +	}
>   
>   	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT,
>   		guest_irq_handlers[args.eoi_split][args.level_sensitive]);
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> index b3a0fca0d780..f5cd0c536d85 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> @@ -52,7 +52,9 @@ int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs,
>   			nr_vcpus, nr_vcpus_created);
>   
>   	/* Distributor setup */
> -	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
> +	if (_kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3,
> +			       false, &gic_fd) != 0)
> +		return -1;
>   
>   	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
>   			0, &nr_irqs, true);
> 

With these fixed:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
