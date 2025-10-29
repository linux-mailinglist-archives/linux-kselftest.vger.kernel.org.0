Return-Path: <linux-kselftest+bounces-44276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F98C1951F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 10:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C366585805
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54364328B4C;
	Wed, 29 Oct 2025 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPB/SkcY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6C328B41;
	Wed, 29 Oct 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727951; cv=none; b=U5yR0ZiDfK8oO6bDlE/xRjzElGoBH/7SmH5XnX8qzo1H+djvCooVUcz6AXdZLFYZaBxYUDOPgoJzDMbMl6ihbt05KYdVipGdsU8txNlhGyFcyKZMeeIrmWvGRhp0YVBFnb6KoPzKWxi+6weEHT2I4LhwY6HnNY0bzWPf+LBCPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727951; c=relaxed/simple;
	bh=b+vH4TPLsjMlSc4jKLKZuG97OYGHj3aFTo9Q2fN/cQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkVkfAG/3ERTJ+QfAtfBdjTOzwjUyMq+pL9H5goj+9kSwR9UU9nYWwF6DvdiguBf9Tc7/Y1dbv6lQB1SQHzORt6mFsdXz40sRUG6VVrrx0Bjs0wor8Kt6LHtAdeQdUmYqi/nN5iWTiyzVAoKb0JdLiT1dYOMIfPLfE6u7GkfXGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPB/SkcY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761727949; x=1793263949;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b+vH4TPLsjMlSc4jKLKZuG97OYGHj3aFTo9Q2fN/cQI=;
  b=EPB/SkcYbVUJyeK/nEbT1/AS9FyxyNnvd18N4ZHi6mIRfOStzngKOAXp
   XZokmy+FuGVa5ZaEPx/byQI5+v19SHEe3x1/auX9/+HotyVJYgG1SqXJ5
   tKKwz9xMKJIFpqqnb01f1T5a2jNNkZ4FBLedP0vCdEJHkDO7wRZmtqKvL
   iohAip3eG8IoOdS0Tpt8x3r0nAmlZgXxyv9a7iU3BM9zqZ1tXHwsGrNYY
   IetfGgWEjO9O+VvtKYiOiHQq2i6nrm9Wc79/MsJAO6E0kMf+g4iUTwENC
   F4Vo5WRWkdEmPD+8VaEhkkZlauvvNu3UVsf1HOkZrulgjie2wP7hYRmFV
   g==;
X-CSE-ConnectionGUID: zt34xR9FQdGsPu20+p2ufQ==
X-CSE-MsgGUID: IDTQAGcgR4u3Xd6auzixCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67484477"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="67484477"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 01:52:29 -0700
X-CSE-ConnectionGUID: tzvfsyAfQ7e6LquTSO71SQ==
X-CSE-MsgGUID: A2LrplNxTxqAPHAY8EG0PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="190729293"
Received: from yinghaoj-desk.ccr.corp.intel.com (HELO [10.238.1.225]) ([10.238.1.225])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 01:52:24 -0700
Message-ID: <f3ef6575-0907-4549-9573-48407f13a45b@linux.intel.com>
Date: Wed, 29 Oct 2025 16:52:21 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 11/23] KVM: selftests: Set up TDX boot parameters
 region
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
 <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-12-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20251028212052.200523-12-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/2025 5:20 AM, Sagi Shahar wrote:

[...]
> +
> +void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm)
> +{
> +	struct td_boot_parameters *params =
> +		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
> +	uint32_t cr4;
> +
> +	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
> +
> +	cr4 = kvm_get_default_cr4();
> +
> +	/* TDX spec 11.6.2: CR4 bit MCE is fixed to 1 */
> +	cr4 |= X86_CR4_MCE;
> +
> +	/* TDX spec 11.6.2: CR4 bit VMXE and SMXE are fixed to 0 */
> +	cr4 &= ~(X86_CR4_VMXE | X86_CR4_SMXE);
> +
> +	/* Set parameters! */
> +	params->cr0 = kvm_get_default_cr0();
> +	params->cr3 = vm->pgd;
Since TDX guest code starts from 32-bit, is it better to check that vm->pgd is
not beyond 32-bit?


> +	params->cr4 = cr4;
> +	params->idtr.base = vm->arch.idt;
> +	params->idtr.limit = kvm_get_default_idt_limit();
> +	params->gdtr.base = vm->arch.gdt;
> +	params->gdtr.limit = kvm_get_default_gdt_limit();
> +
> +	TEST_ASSERT(params->cr0 != 0, "cr0 should not be 0");
> +	TEST_ASSERT(params->cr3 != 0, "cr3 should not be 0");
> +	TEST_ASSERT(params->cr4 != 0, "cr4 should not be 0");
> +	TEST_ASSERT(params->gdtr.base != 0, "gdt base address should not be 0");
> +	TEST_ASSERT(params->idtr.base != 0, "idt base address should not be 0");
> +}
> +
[...]

