Return-Path: <linux-kselftest+bounces-8908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BD38B34E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 12:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D37C288CE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 10:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838D71422B4;
	Fri, 26 Apr 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V7O9TQ3c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0E13F42F;
	Fri, 26 Apr 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126041; cv=none; b=bPDaR2KrPh9jOih8/jlc1yziY/Y/dKAtSPRma/w6Gbrwk9vo4Aq4bi5uv9ITH9uIYHG3giFgLLNbfhar5wqkqklKbFpgqwSYvT13sdIpH/73rganw2gtNCqZ4EAcGQFjCPw6BTudncx2QPAz2VxI+3YLzSThkGGNLN6k6+2lMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126041; c=relaxed/simple;
	bh=TFB+DqJ0O72/lmKUerSCxOZChv+hpSK+WLOY6t363cY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rGMQEA728vD4jplcCn7T3mD0pqBYk2lDM9xDN1SI/rH475H/o4iEplPzk6Ga+OOMyLKl0UnN514rSJCJnRT8JKFA6Xk72Xiw0TENsqWHy6gYwUTyzi+txBZSUO6Wkv4QAal9aY8q1qMHpz/Ysb0qXQtkyb+GJfNTRepK5IILfI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V7O9TQ3c; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714126036;
	bh=TFB+DqJ0O72/lmKUerSCxOZChv+hpSK+WLOY6t363cY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=V7O9TQ3cmcZnFAfFjm5p2s6Rq5l9GZrz2xXJSJdl+AqotqRkT2YFC/9UBaEvDTLK4
	 +xDBPXlCJvJzDnc+f10AfN1LKHS74sr4FkVB+g9QFoMKpFn3sFkVEABzmKex4AUrxa
	 P/Wksn7d5iB+wWn30gXAMqyQt8xadg5OJg2iITF93jedHMPNmkDhPSWrRwnAlFevu0
	 bEttLU2IpvfuTb5p9042Rfy6QSgFKPrddseG9oR4SLk1yg/1Upk/DGT6x2Nc0CQP9w
	 sT6ikfHlxNcSRf53enJNkA7C1kNvykISmtvI8bIIQOtnuVdREo+iEgDNo74Y2Qo2my
	 hIbbgXYs2AlAw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E4ABA3780629;
	Fri, 26 Apr 2024 10:07:12 +0000 (UTC)
Message-ID: <26993de8-0e4f-4d08-9009-730d674b16c7@collabora.com>
Date: Fri, 26 Apr 2024 15:07:43 +0500
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
Subject: Re: [PATCH] KVM: selftests: Use TAP interface in the
 set_memory_region test
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
References: <20240426085556.619731-1-thuth@redhat.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240426085556.619731-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/24 1:55 PM, Thomas Huth wrote:
> Use the kselftest_harness.h interface in this test to get TAP
> output, so that it is easier for the user to see what the test
> is doing. (Note: We are not using the KVM_ONE_VCPU_TEST_SUITE()
> macro here since these tests are creating their VMs with the
> vm_create_barebones() function, not with vm_create_with_one_vcpu())
Thank you for the patch. I'm unable to apply the patch on next-20240426.

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

-- 
BR,
Muhammad Usama Anjum

