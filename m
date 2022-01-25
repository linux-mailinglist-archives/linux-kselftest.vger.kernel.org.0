Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA6849BC74
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 20:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiAYTsF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 14:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiAYTsD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 14:48:03 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE75FC061744
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 11:48:03 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id h23so24936403iol.11
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 11:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UhLIm0K4haH8bYFhDCpqtBWqTKC3e3dD5n20TDHCsEU=;
        b=LQmFhxo97JuO3uJKyBgLhODQfyiRm33Fa7nwDLgCR6dbQVF8VzDu7zZhzHJ29NKlYt
         C76zQtUnK+Xr9cHfdRMIJJDI6G+vSQPym8ss7dguvlhs0rQpyenT1aGH+73QKh1St/6h
         g41sB7aSWHA/vmmWVnJqcR9hT9FwXGtTrFmjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UhLIm0K4haH8bYFhDCpqtBWqTKC3e3dD5n20TDHCsEU=;
        b=oU4n1XQEUzeFJVVs3jexdC1KSJj4Y0OFkyziLR7ni/LFCXx3sW3R638CprhgafwHNo
         YATQ5Ep3ICrjerQDO7O3wT7tTN2eQyNECCwx5c6jfrdVZp07MZevmEdrXxZpjfLj4sdj
         d+TjpbnOSV9R5Tyr98xXRp35v0rVps30DPtf9nc/wSHb7rUIxytoSfSP+i1pp4w3JpVa
         Ok+9b3W6u1JRSkCMkOOlY+VKfb74PqZC/bJExd/nul+zMGlv+a5p2rukcFzR2mQKX79P
         cwNdnwXkioHzAwlTJK9Nl5EnLMtAPmbH6q/mtP9fgFH5X/OtfRkm9O4E0GEyHDWKTmbV
         EgTA==
X-Gm-Message-State: AOAM531a0bivNx7K89X22h9OSy17P8r0a4SlEbybdSK2VSqdqFxOrNtQ
        S7ka2QGn43v1Mh7wG0u+mQz4jA==
X-Google-Smtp-Source: ABdhPJzKaByjZS2TCv+LDaZM1ersKACGdc0hYfosLk3drvVpzlg/TCFdUx7usK/mXeitxXxhamL43g==
X-Received: by 2002:a5e:9b07:: with SMTP id j7mr11438878iok.136.1643140082829;
        Tue, 25 Jan 2022 11:48:02 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4ef8:d404:554b:9671? ([2601:282:8200:4c:4ef8:d404:554b:9671])
        by smtp.gmail.com with ESMTPSA id l7sm9486227ilv.75.2022.01.25.11.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 11:48:02 -0800 (PST)
Subject: Re: [PATCH] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
To:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220125192851.3907611-1-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a7215f00-2ffd-d3ec-eb02-e7fc8e527715@linuxfoundation.org>
Date:   Tue, 25 Jan 2022 12:48:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220125192851.3907611-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/25/22 12:28 PM, Mark Brown wrote:
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
>   tools/testing/selftests/kvm/aarch64/arch_timer.c | 7 ++++++-
>   tools/testing/selftests/kvm/aarch64/vgic_irq.c   | 5 +++++
>   tools/testing/selftests/kvm/lib/aarch64/vgic.c   | 4 +++-
>   3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index 9ad38bd360a4..791d38404652 100644
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
> +		pr_info("Failed to create vgic-v3, skipping\n");
> +		exit(KSFT_SKIP);
> +	}
>   
>   	/* Make all the test's cmdline args visible to the guest */
>   	sync_global_to_guest(vm, test_args);
> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> index e6c7d7f8fbd1..8c6b61b8e6aa 100644
> --- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> +++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> @@ -761,6 +761,11 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
>   
>   	gic_fd = vgic_v3_setup(vm, 1, nr_irqs,
>   			GICD_BASE_GPA, GICR_BASE_GPA);
> +	if (gic_fd < 0) {
> +		pr_info("Failed to create vgic-v3, skipping\n");
> +		exit(KSFT_SKIP);
> +	}
> +
>   
>   	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT,
>   		guest_irq_handlers[args.eoi_split][args.level_sensitive]);
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> index b3a0fca0d780..647c18733e1b 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> @@ -52,7 +52,9 @@ int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs,
>   			nr_vcpus, nr_vcpus_created);
>   
>   	/* Distributor setup */
> -	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
> +	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, true);

Assume the flag change is intentional. The reason isn't obvious in the
change log
  
> +	if (gic_fd == -1)
> +		return -1;
>   
>   	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
>   			0, &nr_irqs, true);
> 

Looks good to me otherwise - thanks for adding the skips

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
