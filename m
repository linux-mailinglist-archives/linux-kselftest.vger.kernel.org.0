Return-Path: <linux-kselftest+bounces-38954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14264B261CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 12:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345871BC1860
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBBC2F7441;
	Thu, 14 Aug 2025 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvnElCkH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F042F6595;
	Thu, 14 Aug 2025 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165511; cv=none; b=C0zQp6x+YDEq1c5P4uauehyADMEunKOT89NJ7n8DehFZcmXcbP9yue7ZxsFHBbpQkxM/quXzPH8bEf62Xa/zbKXXlKKtkYeAuQLsKpvfwfHxA7/B6WpOHD/78OMa0yOCVg4q/ddMHghrwvG5Gi1VsHVLCSYYJxuqMfKRHboW7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165511; c=relaxed/simple;
	bh=TQyR7FXuCKYETcWNVZ8PIU2nphVvP/m9P30vQmjTT0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEAxqVu7WW2T4pcg93SPzuASMazhJTOV/vT2zFAejuSKXDgN5wOmShI9QXYC2Lfin1Pb/zxFgoJ6D+xLGKZCP/uEN/2aDk4mo4tLWl0qDYwUp/dWy27j9Pv4sno3nmBJxmOn6XKz1IUr5LoPJ+l4QdX1RFQffRuRQT0y39Ubw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvnElCkH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755165510; x=1786701510;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TQyR7FXuCKYETcWNVZ8PIU2nphVvP/m9P30vQmjTT0s=;
  b=TvnElCkHrtKj+V68ihYs4TR8Mq+6dXUP8eMI9I1Zd6vhK+2anoGf+AJC
   H2zAY+6FE+dMAwj2EXZFpQFN4OVfYqv2uCYsmzNeap3kLd2FhJGKpWrHW
   gDA+BuCwQEHsrcn9TftXZiFcwJ/5ldkmjmOlcK9O1KQUapk7O6n55dFGc
   ae+eOxB4+l6mHUP+bRIPoGoN3F0KfE60+Nyn9AER6TWSnWhxgTFce96GC
   q91s4sVyugH+PaCd0atIe37FqCYJlo6YeedLE6VhbOT6yjyNQTQTtUsXH
   42I8uB2luKR7hSzdUmJnX+d83uoD9JZIDK9tIDrR6H6unfOZmWmsjdbXV
   g==;
X-CSE-ConnectionGUID: e8HH5AiyRCuDY3kh2MqinQ==
X-CSE-MsgGUID: PE8wlNMQRd6GTQYPE88glw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56685448"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="56685448"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 02:58:29 -0700
X-CSE-ConnectionGUID: ucPWRSpTSVO4bCGlCpVRsw==
X-CSE-MsgGUID: 1GNLvUZtSaSJcVASkakdJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="171954294"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 02:58:24 -0700
Message-ID: <12524aa3-006a-4fee-bd10-b83adf7a503a@linux.intel.com>
Date: Thu, 14 Aug 2025 17:58:22 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 18/30] KVM: selftests: TDX: Add TDX MMIO reads test
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny
 <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-19-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250807201628.1185915-19-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/2025 4:16 AM, Sagi Shahar wrote:
[...]
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> index 8c3b6802c37e..f92ddda2d1ac 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> @@ -31,6 +31,25 @@ void tdx_test_assert_io(struct kvm_vcpu *vcpu, uint16_t port, uint8_t size,
>   		    vcpu->run->io.direction);
>   }
>   
> +void tdx_test_assert_mmio(struct kvm_vcpu *vcpu, uint64_t phys_addr,
> +			  uint32_t size, uint8_t is_write)
> +{
> +	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_MMIO,
> +		    "Got exit_reason other than KVM_EXIT_MMIO: %u (%s)\n",
> +		    vcpu->run->exit_reason,
> +		    exit_reason_str(vcpu->run->exit_reason));
> +
> +	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_MMIO &&
It's already checked above.

> +		    vcpu->run->mmio.phys_addr == phys_addr &&
> +		    vcpu->run->mmio.len == size &&
> +		    vcpu->run->mmio.is_write == is_write,
> +		    "Got an unexpected MMIO exit values: %u (%s) %llu %u %u\n",
> +		    vcpu->run->exit_reason,
> +		    exit_reason_str(vcpu->run->exit_reason),
> +		    vcpu->run->mmio.phys_addr, vcpu->run->mmio.len,
> +		    vcpu->run->mmio.is_write);
> +}
> +
>   void tdx_run(struct kvm_vcpu *vcpu)
>   {
>   	td_vcpu_run(vcpu);
> diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> index 720ef5e87071..563f1025c8a3 100644
> --- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> +++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> @@ -719,6 +719,91 @@ void verify_guest_hlt(void)
>   	_verify_guest_hlt(0);
>   }
>   
> +/* Pick any address that was not mapped into the guest to test MMIO */
> +#define TDX_MMIO_TEST_ADDR 0x200000000
> +#define MMIO_SYNC_VALUE 0x42
> +
> +void guest_mmio_reads(void)
> +{
> +	uint64_t mmio_test_addr = TDX_MMIO_TEST_ADDR | tdx_s_bit;
> +	uint64_t data;
> +	uint64_t ret;
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_read(mmio_test_addr, 1, &data);
> +	tdx_assert_error(ret);
> +	if (data != 0x12)
> +		tdx_test_fatal(1);
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_read(mmio_test_addr, 2, &data);
> +	tdx_assert_error(ret);
> +	if (data != 0x1234)
> +		tdx_test_fatal(2);
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_read(mmio_test_addr, 4, &data);
> +	tdx_assert_error(ret);
> +	if (data != 0x12345678)
> +		tdx_test_fatal(4);
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_read(mmio_test_addr, 8, &data);
> +	tdx_assert_error(ret);
> +	if (data != 0x1234567890ABCDEF)
> +		tdx_test_fatal(8);
> +
> +	/* Make sure host and guest are synced to the same point of execution */
> +	tdx_test_report_to_user_space(MMIO_SYNC_VALUE);
Is this step necessary?


> +
> +	/* Read an invalid number of bytes. */
> +	ret = tdg_vp_vmcall_ve_request_mmio_read(mmio_test_addr, 10, &data);
> +	tdx_assert_error(ret);
> +
> +	tdx_test_success();
> +}
> +
> +/*
> + * Verifies guest MMIO reads.
> + */
> +void verify_mmio_reads(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_mmio_reads);
> +	td_finalize(vm);
> +
> +	printf("Verifying TD MMIO reads:\n");
> +
> +	tdx_run(vcpu);
> +	tdx_test_assert_mmio(vcpu, TDX_MMIO_TEST_ADDR, 1, MMIO_READ);
> +	*(uint8_t *)vcpu->run->mmio.data = 0x12;
> +
> +	tdx_run(vcpu);
> +	tdx_test_assert_mmio(vcpu, TDX_MMIO_TEST_ADDR, 2, MMIO_READ);
> +	*(uint16_t *)vcpu->run->mmio.data = 0x1234;
> +
> +	tdx_run(vcpu);
> +	tdx_test_assert_mmio(vcpu, TDX_MMIO_TEST_ADDR, 4, MMIO_READ);
> +	*(uint32_t *)vcpu->run->mmio.data = 0x12345678;
> +
> +	tdx_run(vcpu);
> +	tdx_test_assert_mmio(vcpu, TDX_MMIO_TEST_ADDR, 8, MMIO_READ);
> +	*(uint64_t *)vcpu->run->mmio.data = 0x1234567890ABCDEF;
> +
> +	tdx_run(vcpu);
> +	TEST_ASSERT_EQ(tdx_test_read_report_from_guest(vcpu), MMIO_SYNC_VALUE);
> +
> +	td_vcpu_run(vcpu);
> +	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.data[12], TDG_VP_VMCALL_INVALID_OPERAND);
> +
> +	tdx_run(vcpu);
> +	tdx_test_assert_success(vcpu);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	ksft_print_header();
> @@ -726,7 +811,7 @@ int main(int argc, char **argv)
>   	if (!is_tdx_enabled())
>   		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
>   
> -	ksft_set_plan(10);
> +	ksft_set_plan(11);
>   	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
>   			 "verify_td_lifecycle\n");
>   	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
> @@ -747,6 +832,8 @@ int main(int argc, char **argv)
>   			 "verify_guest_msr_reads\n");
>   	ksft_test_result(!run_in_new_process(&verify_guest_hlt),
>   			 "verify_guest_hlt\n");
> +	ksft_test_result(!run_in_new_process(&verify_mmio_reads),
> +			 "verify_mmio_reads\n");
>   
>   	ksft_finished();
>   	return 0;


