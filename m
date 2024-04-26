Return-Path: <linux-kselftest+bounces-8911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C518B3540
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 12:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE223281C34
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 10:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A92143C4D;
	Fri, 26 Apr 2024 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="C26DT1qa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51D13D2B7
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714127209; cv=none; b=aGtl5ksz149oZtYOn8TeQ+HxwfaGZlqZPC48idnOSr5h4YECJRIq+8EX1xoFSadjdHBrVmY3+35odeEKWTjc5CnZbi4vML+psOvCBGsILAnOmRzW5zKyeseooKAQsvRP5hywR3WfngG4JV8jeWEtSQy/PTiJ/o18zfkDdXHbr1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714127209; c=relaxed/simple;
	bh=95jpOIPli1WIu5cGvwnymy7VK5FGC2+s4kiqhe8ON5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtFqwrx1UxNVIbGDYAhYrQuWwSedj5MK0RvR29j4gnEZuM/dUtFPRWTUFooEDVcgoMbD9BqBWFquN3DiDbEKFoprUekbjE6iYVcvzSxofH0XKlTjqZRh4hCQldAssveIDiVk0lFbB8ymqhk99H9ntAUWR+rHj0GHddN88YumnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=C26DT1qa; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51967f75763so2310461e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714127206; x=1714732006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=35hwEVOPG/bC6pctc3AhzuJxDmdNmW4+UySUA+22Dz8=;
        b=C26DT1qazpYsmB3i9/ufjmbpj7VJeK3yK8UmVnAYBjSZ75S7qCjxwEFAzQhQLy/sjl
         r3fHAv6TWjKQsgHLlfjcmu1A4C9sfBem6S91tLwPClbY33imufubf+HlT0sSYbAvVpC4
         hTzi4+W56qIsXa7292DOJQmMouu8VP+2WO9GDAdMyW6TbApPb29y8yTx7HWdaA/RzXAw
         4/uLRgX2GyD5rYZ2DMRFCnwTdk3oLt14bYsOhHsPlLmq/b8rvfmG0dEHKT85by0PdA/S
         NN2UjdEFVIkNntW31TfcoPeEfh83VYbfBZPQ2kgMltpaoMag+Qrbv04jUpjYRVeye6TY
         wiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714127206; x=1714732006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35hwEVOPG/bC6pctc3AhzuJxDmdNmW4+UySUA+22Dz8=;
        b=sH9Tujh28GjuaAGG1qZhubtJn2CgmgJnG0LPEGk6qEx+Q3kZx0WkuCFr9LJwIlxTjb
         fe2rpipwU5A8+OtCMF7MWIWbKrrRDFt6vBGVH6E2v5iPBtCm7ECfLwuIHTm3oNwRgyq4
         e313/1zR4YYeaEoze9yGlbPYIivxk/NDqsVn7/RrdmiC86kP8t/JBv59TWEBva/lHW/a
         yLrIzJDHkhtLqKaKolTp4NXN/jNNaF4uyKNADxhlSo5WsKPo0yB9VSTcrnUTqbJsKlEf
         l0csUpxFiHOvtoCfp0jIAXvd8+3NS4MAzM9MzAnGEwH7D/p0zHlEYS4DwOe7gH9wZ7Rh
         9thw==
X-Forwarded-Encrypted: i=1; AJvYcCVH6P4pwkSUspgXraf/v7UTtwoHGjsli49YyXLKyImUaNK+F5zJpKe4OIZpcTmM3SrGli6U09qaCx0pgWTpW+oHwahvG7Q78k5FIr7RTfNu
X-Gm-Message-State: AOJu0Yznz4+vCz4jQIJ8gzlkgn9pYa3vmS9h2Ta4WjT24pbsY//39Tw+
	ryigEiKKohJMFPn58jNTw/T73b5+7DtjcOX+TLLhX8fXIRPKF38YAwocpPE8QXL2winzKsMOklJ
	R4gE=
X-Google-Smtp-Source: AGHT+IHRM7WhsDa01WxTSTAJaaAn4EoHFCGYt67g/vnMa9+qelfLxljO1XqXWUjmG9/BCCuDTmWlIg==
X-Received: by 2002:a05:6512:3ca0:b0:51b:98ea:c83e with SMTP id h32-20020a0565123ca000b0051b98eac83emr1693061lfv.50.1714127205724;
        Fri, 26 Apr 2024 03:26:45 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id h15-20020a056000000f00b003434c764f01sm22017342wrx.107.2024.04.26.03.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:26:45 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:26:44 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] KVM: selftests: Use TAP interface in the
 set_memory_region test
Message-ID: <20240426-c84db250c7691d82bf51689d@orel>
References: <20240426085556.619731-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426085556.619731-1-thuth@redhat.com>

On Fri, Apr 26, 2024 at 10:55:56AM GMT, Thomas Huth wrote:
> Use the kselftest_harness.h interface in this test to get TAP
> output, so that it is easier for the user to see what the test
> is doing. (Note: We are not using the KVM_ONE_VCPU_TEST_SUITE()
> macro here since these tests are creating their VMs with the
> vm_create_barebones() function, not with vm_create_with_one_vcpu())
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .../selftests/kvm/set_memory_region_test.c    | 86 +++++++++----------
>  1 file changed, 42 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index bd57d991e27d..4db6a66a3001 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -16,6 +16,7 @@
>  #include <test_util.h>
>  #include <kvm_util.h>
>  #include <processor.h>
> +#include "kselftest_harness.h"
>  
>  /*
>   * s390x needs at least 1MB alignment, and the x86_64 MOVE/DELETE tests need a
> @@ -38,6 +39,8 @@ extern const uint64_t final_rip_end;
>  
>  static sem_t vcpu_ready;
>  
> +int loops;

nit: static

> +
>  static inline uint64_t guest_spin_on_val(uint64_t spin_val)
>  {
>  	uint64_t val;
> @@ -219,6 +222,13 @@ static void test_move_memory_region(void)
>  	kvm_vm_free(vm);
>  }
>  
> +TEST(move_in_use_region)
> +{
> +	ksft_print_msg("Testing MOVE of in-use region, %d loops\n", loops);
> +	for (int i = 0; i < loops; i++)
> +		test_move_memory_region();
> +}
> +
>  static void guest_code_delete_memory_region(void)
>  {
>  	uint64_t val;
> @@ -308,12 +318,19 @@ static void test_delete_memory_region(void)
>  	kvm_vm_free(vm);
>  }
>  
> -static void test_zero_memory_regions(void)
> +TEST(delete_in_use_region)
> +{
> +	ksft_print_msg("Testing DELETE of in-use region, %d loops\n", loops);
> +	for (int i = 0; i < loops; i++)
> +		test_delete_memory_region();
> +}
> +
> +TEST(zero_memory_regions)
>  {
>  	struct kvm_vcpu *vcpu;
>  	struct kvm_vm *vm;
>  
> -	pr_info("Testing KVM_RUN with zero added memory regions\n");
> +	ksft_print_msg("Testing KVM_RUN with zero added memory regions\n");
>  
>  	vm = vm_create_barebones();
>  	vcpu = __vm_vcpu_add(vm, 0);
> @@ -326,7 +343,7 @@ static void test_zero_memory_regions(void)
>  }
>  #endif /* __x86_64__ */
>  
> -static void test_invalid_memory_region_flags(void)
> +TEST(invalid_memory_region_flags)
>  {
>  	uint32_t supported_flags = KVM_MEM_LOG_DIRTY_PAGES;
>  	const uint32_t v2_only_flags = KVM_MEM_GUEST_MEMFD;
> @@ -389,7 +406,7 @@ static void test_invalid_memory_region_flags(void)
>   * Test it can be added memory slots up to KVM_CAP_NR_MEMSLOTS, then any
>   * tentative to add further slots should fail.
>   */
> -static void test_add_max_memory_regions(void)
> +TEST(add_max_memory_regions)
>  {
>  	int ret;
>  	struct kvm_vm *vm;
> @@ -408,13 +425,13 @@ static void test_add_max_memory_regions(void)
>  	max_mem_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
>  	TEST_ASSERT(max_mem_slots > 0,
>  		    "KVM_CAP_NR_MEMSLOTS should be greater than 0");
> -	pr_info("Allowed number of memory slots: %i\n", max_mem_slots);
> +	ksft_print_msg("Allowed number of memory slots: %i\n", max_mem_slots);
>  
>  	vm = vm_create_barebones();
>  
>  	/* Check it can be added memory slots up to the maximum allowed */
> -	pr_info("Adding slots 0..%i, each memory region with %dK size\n",
> -		(max_mem_slots - 1), MEM_REGION_SIZE >> 10);
> +	ksft_print_msg("Adding slots 0..%i, each memory region with %dK size\n",
> +		       (max_mem_slots - 1), MEM_REGION_SIZE >> 10);
>  
>  	mem = mmap(NULL, (size_t)max_mem_slots * MEM_REGION_SIZE + alignment,
>  		   PROT_READ | PROT_WRITE,
> @@ -455,12 +472,21 @@ static void test_invalid_guest_memfd(struct kvm_vm *vm, int memfd,
>  	TEST_ASSERT(r == -1 && errno == EINVAL, "%s", msg);
>  }
>  
> -static void test_add_private_memory_region(void)
> +static bool has_cap_guest_memfd(void)
> +{
> +	return kvm_has_cap(KVM_CAP_GUEST_MEMFD) &&
> +	       (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
> +}
> +
> +TEST(add_private_memory_region)
>  {
>  	struct kvm_vm *vm, *vm2;
>  	int memfd, i;
>  
> -	pr_info("Testing ADD of KVM_MEM_GUEST_MEMFD memory regions\n");
> +	if (!has_cap_guest_memfd())
> +		SKIP(return, "Missing KVM_MEM_GUEST_MEMFD / KVM_X86_SW_PROTECTED_VM");
> +
> +	ksft_print_msg("Testing ADD of KVM_MEM_GUEST_MEMFD memory regions\n");
>  
>  	vm = vm_create_barebones_protected_vm();
>  
> @@ -491,13 +517,16 @@ static void test_add_private_memory_region(void)
>  	kvm_vm_free(vm);
>  }
>  
> -static void test_add_overlapping_private_memory_regions(void)
> +TEST(add_overlapping_private_memory_regions)
>  {
>  	struct kvm_vm *vm;
>  	int memfd;
>  	int r;
>  
> -	pr_info("Testing ADD of overlapping KVM_MEM_GUEST_MEMFD memory regions\n");
> +	if (!has_cap_guest_memfd())
> +		SKIP(return, "Missing KVM_MEM_GUEST_MEMFD / KVM_X86_SW_PROTECTED_VM");
> +
> +	ksft_print_msg("Testing ADD of overlapping KVM_MEM_GUEST_MEMFD memory regions\n");
>  
>  	vm = vm_create_barebones_protected_vm();
>  
> @@ -536,46 +565,15 @@ static void test_add_overlapping_private_memory_regions(void)
>  	close(memfd);
>  	kvm_vm_free(vm);
>  }
> +
>  #endif
>  
>  int main(int argc, char *argv[])
>  {
> -#ifdef __x86_64__
> -	int i, loops;
> -
> -	/*
> -	 * FIXME: the zero-memslot test fails on aarch64 and s390x because
> -	 * KVM_RUN fails with ENOEXEC or EFAULT.
> -	 */
> -	test_zero_memory_regions();
> -#endif
> -
> -	test_invalid_memory_region_flags();
> -
> -	test_add_max_memory_regions();
> -
> -#ifdef __x86_64__
> -	if (kvm_has_cap(KVM_CAP_GUEST_MEMFD) &&
> -	    (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))) {
> -		test_add_private_memory_region();
> -		test_add_overlapping_private_memory_regions();
> -	} else {
> -		pr_info("Skipping tests for KVM_MEM_GUEST_MEMFD memory regions\n");
> -	}
> -
>  	if (argc > 1)
>  		loops = atoi_positive("Number of iterations", argv[1]);
>  	else
>  		loops = 10;
>  
> -	pr_info("Testing MOVE of in-use region, %d loops\n", loops);
> -	for (i = 0; i < loops; i++)
> -		test_move_memory_region();
> -
> -	pr_info("Testing DELETE of in-use region, %d loops\n", loops);
> -	for (i = 0; i < loops; i++)
> -		test_delete_memory_region();
> -#endif
> -
> -	return 0;
> +	return test_harness_run(argc, argv);
>  }
> -- 
> 2.44.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

