Return-Path: <linux-kselftest+bounces-8918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11C58B396D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 16:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F321C22FC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE84B1487FF;
	Fri, 26 Apr 2024 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0YHt8J0+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC27140389;
	Fri, 26 Apr 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140176; cv=none; b=R2TqwhQeyoG+hjKmhmc6/kxijheeEfaWZVRyWaznELYAxVacykzu86qtobHSQ4RwJyri38J6T2CKZ0oieH4XMTasczRMx9jUFm2FAciEhQ6nzakmbnYo78ydjpQwpumoU65egD37xQU8gwKCA9vGvgvac0DC4VAT6TpCO46pZzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140176; c=relaxed/simple;
	bh=eZLYFV1P7e0RZiUl4fmLeeENBDPeW09hanvBGCLaf/o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MuPiFzQ2+MQrPXSC3po7/9uCgJPQ9s5UZzrbNp+hDlbGTM+FknF8wln7FfvV717AcedEJB/28xNgIM4FSCFrHdwOoKEhoVw0lzajUtvRKcvV26onZd6J/7W8Y4jVAwsdzLMvrxvTN1fyLVZsW3YVX1pTTCCOfkxWO18Gqajyxw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0YHt8J0+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714140163;
	bh=eZLYFV1P7e0RZiUl4fmLeeENBDPeW09hanvBGCLaf/o=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=0YHt8J0+aOVIih2Y/HwA41SaQiuIzX37DtkeopB+08x8R7IH2AKAqG4iIyO9UvN07
	 I2GTEsOM7i8JIIfUc0bQ/tq3PnggvaKLKUEczH+DasM4GLPgb1wSEF5W9nGXrRuz/J
	 Hk33LQEOQD+lsoYaSCgqBGomEgStg6ZMjWvNN7ktRN801Mdpr+LGz5d4Qko0cSuRco
	 3Gg9ZWRww79fol77r2YvFW6tlEbKUxB776U8Kq6K6iYeYy2yYLdBY6DD44OsCQrEU8
	 usDZNQGyNM69TrWS7au7r+vL2bVz9NQ0ghqmMfzCcT1ozvtbXtAHqH+OfIdpQ5mKYv
	 TR43WkNF4r9/g==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 45B7437813A4;
	Fri, 26 Apr 2024 14:02:37 +0000 (UTC)
Message-ID: <ec789dfb-e447-4cc5-bd72-7ee8bf5a5daa@collabora.com>
Date: Fri, 26 Apr 2024 19:03:07 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2] KVM: selftests: Use TAP interface in the
 set_memory_region test
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
References: <20240426114552.667346-1-thuth@redhat.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240426114552.667346-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/24 4:45 PM, Thomas Huth wrote:
> Use the kselftest_harness.h interface in this test to get TAP
> output, so that it is easier for the user to see what the test
> is doing. (Note: We are not using the KVM_ONE_VCPU_TEST_SUITE()
> macro here since these tests are creating their VMs with the
> vm_create_barebones() function, not with vm_create_with_one_vcpu())
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
LGTM

Reviewed-by: Muhammad Usama Anjum <usama.anjum@colabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  v2:
>  - Rebase to linux-next branch
>  - Make "loops" variable static
>  - Added Andrew's Reviewed-by
> 
>  .../selftests/kvm/set_memory_region_test.c    | 86 +++++++++----------
>  1 file changed, 42 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index 68c899d27561..a5c9bee5235a 100644
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
> +static int loops;
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
>  	vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
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
>  	vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
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

-- 
BR,
Muhammad Usama Anjum

