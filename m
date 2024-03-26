Return-Path: <linux-kselftest+bounces-6611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B4688BDF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 10:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8F2B27C02
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 09:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9594679E5;
	Tue, 26 Mar 2024 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V8Cimmlx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF29482FE;
	Tue, 26 Mar 2024 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445038; cv=none; b=nmIfS/rotu6LlzRwLr3hYicbaeXLEonEbMVwobuMuo6yfn6uWISEWA4aqC3yERMMbnPoEojt2GiJdeL5JGTh0yhk9cP4gSPrD0lfkxmDcCxhEB7bNwdKxwIwVl5C/HwzeTyZ0STQbN+UMyWCs9gdR9LexiXDgjfyGK4YWlfOiNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445038; c=relaxed/simple;
	bh=T4wnvnOffzTLpIPRwQQWSDDDt431HpMY8RhCicsc/Mo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TjuLsKOs+w3zHL2jqUL3zbd8xfW5rbWf0jA9BsdwUaNBZQOG02xu+FOtdZipuXbbHc5gUrBZ8biYHmdqvhkRB7E+NgxUcLqjbdQ8Dt8Hs1pUJW7VbYoFBlz8qXslGo6pcO+SdQk38X0mybwcjEaQImbteBm0/WsbPitUKprb0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V8Cimmlx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711445034;
	bh=T4wnvnOffzTLpIPRwQQWSDDDt431HpMY8RhCicsc/Mo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=V8CimmlxEYx6zepbCze4CZSx4oilJpLz+AVX00iN65uOwMjul0jnBdiK3UPhuvwLn
	 XHcrZ2UeISLsYBxa4UzM02s9K/SDnEVhtNUaWCzGmngRndn7M2vMG+o30FFcu3F6vn
	 OCh5s1Lc/0FDO/R/l5hkNQWTeHKYwUEpHpyu/bQHf+ro7flockyIr6CVcnIlntHz7N
	 H45AfcQLVtLPUynJyjVYPFFROugi4eddJ0YfW/+Vkr90/QUgTIlikXh5INZ0Dp8O/o
	 yicLSzO0SY3VEeZcKeIfIoAkryh4cHBKkmAKDz87VT5Iv+IhvKcQtrb2yUZ7NRwmZA
	 TnQ/WhNoMzb/w==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AD5B037813E4;
	Tue, 26 Mar 2024 09:23:52 +0000 (UTC)
Message-ID: <2099346e-c657-4781-97e1-7dcb41f66c43@collabora.com>
Date: Tue, 26 Mar 2024 14:24:22 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Use TAP in the steal_time test
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
References: <20231019095900.450467-1-thuth@redhat.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231019095900.450467-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/23 2:59 PM, Thomas Huth wrote:
> For easier use of the tests in automation and for having some
> status information for the user while the test is running, let's
> provide some TAP output in this test.
LGTM. I was thinking why kselftest.h hasn't been included. I found out that
test_util.h includes kselftest.h.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  NB: This patch does not use the interface from kselftest_harness.h
>      since it is not very suitable for the for-loop in this patch.
> 
>  tools/testing/selftests/kvm/steal_time.c | 46 ++++++++++++------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
> index 171adfb2a6cb..aa6149eb9ea1 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -81,20 +81,18 @@ static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
>  static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
>  {
>  	struct kvm_steal_time *st = addr_gva2hva(vm, (ulong)st_gva[vcpu_idx]);
> -	int i;
>  
> -	pr_info("VCPU%d:\n", vcpu_idx);
> -	pr_info("    steal:     %lld\n", st->steal);
> -	pr_info("    version:   %d\n", st->version);
> -	pr_info("    flags:     %d\n", st->flags);
> -	pr_info("    preempted: %d\n", st->preempted);
> -	pr_info("    u8_pad:    ");
> -	for (i = 0; i < 3; ++i)
> -		pr_info("%d", st->u8_pad[i]);
> -	pr_info("\n    pad:       ");
> -	for (i = 0; i < 11; ++i)
> -		pr_info("%d", st->pad[i]);
> -	pr_info("\n");
> +	ksft_print_msg("VCPU%d:\n", vcpu_idx);
> +	ksft_print_msg("    steal:     %lld\n", st->steal);
> +	ksft_print_msg("    version:   %d\n", st->version);
> +	ksft_print_msg("    flags:     %d\n", st->flags);
> +	ksft_print_msg("    preempted: %d\n", st->preempted);
> +	ksft_print_msg("    u8_pad:    %d %d %d\n",
> +			st->u8_pad[0], st->u8_pad[1], st->u8_pad[2]);
> +	ksft_print_msg("    pad:       %d %d %d %d %d %d %d %d %d %d %d\n",
> +			st->pad[0], st->pad[1], st->pad[2], st->pad[3],
> +			st->pad[4], st->pad[5], st->pad[6], st->pad[7],
> +			st->pad[8], st->pad[9], st->pad[10]);
>  }
>  
>  #elif defined(__aarch64__)
> @@ -197,10 +195,10 @@ static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
>  {
>  	struct st_time *st = addr_gva2hva(vm, (ulong)st_gva[vcpu_idx]);
>  
> -	pr_info("VCPU%d:\n", vcpu_idx);
> -	pr_info("    rev:     %d\n", st->rev);
> -	pr_info("    attr:    %d\n", st->attr);
> -	pr_info("    st_time: %ld\n", st->st_time);
> +	ksft_print_msg("VCPU%d:\n", vcpu_idx);
> +	ksft_print_msg("    rev:     %d\n", st->rev);
> +	ksft_print_msg("    attr:    %d\n", st->attr);
> +	ksft_print_msg("    st_time: %ld\n", st->st_time);
>  }
>  
>  #endif
> @@ -267,7 +265,9 @@ int main(int ac, char **av)
>  	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, gpages, 0);
>  	virt_map(vm, ST_GPA_BASE, ST_GPA_BASE, gpages);
>  
> +	ksft_print_header();
>  	TEST_REQUIRE(is_steal_time_supported(vcpus[0]));
> +	ksft_set_plan(NR_VCPUS);
>  
>  	/* Run test on each VCPU */
>  	for (i = 0; i < NR_VCPUS; ++i) {
> @@ -308,14 +308,14 @@ int main(int ac, char **av)
>  			    run_delay, stolen_time);
>  
>  		if (verbose) {
> -			pr_info("VCPU%d: total-stolen-time=%ld test-stolen-time=%ld", i,
> -				guest_stolen_time[i], stolen_time);
> -			if (stolen_time == run_delay)
> -				pr_info(" (BONUS: guest test-stolen-time even exactly matches test-run_delay)");
> -			pr_info("\n");
> +			ksft_print_msg("VCPU%d: total-stolen-time=%ld test-stolen-time=%ld%s\n",
> +				       i, guest_stolen_time[i], stolen_time,
> +				       stolen_time == run_delay ?
> +				       " (BONUS: guest test-stolen-time even exactly matches test-run_delay)" : "");
>  			steal_time_dump(vm, i);
>  		}
> +		ksft_test_result_pass("vcpu%d\n", i);
>  	}
>  
> -	return 0;
> +	ksft_finished();        /* Print results and exit() accordingly */
>  }

-- 
BR,
Muhammad Usama Anjum

