Return-Path: <linux-kselftest+bounces-40925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4BFB48663
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 10:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583F87A7636
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 08:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6561D63EF;
	Mon,  8 Sep 2025 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjEy5dTz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106711712;
	Mon,  8 Sep 2025 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318841; cv=none; b=aY73Sb/HWL/qNDfPtfqZA4SPze+HwA+10QiQNzWmNdWcxrUXNYCvTWyPMGv7iDY+BX5Zem5Srx2HKSfPvW0fQavDr+T3V7+vasFs9dkZOPa/sGVCsC+ujai2jlrblSBgkQJcnapRb1DyKlkcHMhy4nq/OErw30Y6cKAvPAZIg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318841; c=relaxed/simple;
	bh=sKGWBxutld7BDKkMoKF7Czft044gDLW37+VVeAroiKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYQ90zBd76iH9+i3nDAxnPJgdqmDTVQBD+7nqeEplbEcOQWkWjdJ8SujWmRCOUcWE66LVbCyzC0Lp27d04sQGzfSCZfEmGVmEvmkm/aPVVtFxM9S5VriUkA/H/keFmYEsNohd6+2KsKS/bxYJaUM73u3vebXwtmJG33py5Yv3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjEy5dTz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757318840; x=1788854840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sKGWBxutld7BDKkMoKF7Czft044gDLW37+VVeAroiKk=;
  b=jjEy5dTzf8xEDLW28yEjXpQPPQttoPAYs7a9nEExrriY0tiRT4qa5eCh
   g/bOHME1J1cKcb65zO5bR7UWKiyn6KMa7CQpwp1GsYOl64wfcjBycLKRd
   ocxX0ZhpH8alrqt2D9Xqeb9W43H82nXZMG6whBx9VzIBZTVyRZweGoAwZ
   5ZrqNkIiUok8fdBcIRf2HKhuIcB9NnqSrs/tbvzXc9p4tcZ9vgaTC3GOd
   +is7R3Xji5e8RM/jrmXeq/H0TyKKcesUBxeNNXRfvVvrB63L/dktOMqHv
   IO4rDIpAnv6M5R9lI26QTdJB+092E0Ha4VDFq52DvEYtsQ2fEmCgBSKZt
   g==;
X-CSE-ConnectionGUID: Mg4kaz61S0yjdkxkNPij2g==
X-CSE-MsgGUID: F9JbG94vSD2zXBWL2YbXzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="59266802"
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="59266802"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 01:07:19 -0700
X-CSE-ConnectionGUID: oe03nUxhRmWNq3aZ+eyHrA==
X-CSE-MsgGUID: EYVIQ85yR8Sx3Ozc+jp8qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="171993492"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 01:07:14 -0700
Message-ID: <0e8a2035-caeb-4c75-9620-b65df07be1a0@linux.intel.com>
Date: Mon, 8 Sep 2025 16:07:12 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/21] KVM: selftests: Set up TDX boot parameters
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
References: <20250904065453.639610-1-sagis@google.com>
 <20250904065453.639610-11-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250904065453.639610-11-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/2025 2:54 PM, Sagi Shahar wrote:
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
> +	/* Set this because UEFI also sets this up, to handle XMM exceptions */

I don't get it.
Could you elaborate it a bit?

> +	cr4 |= X86_CR4_OSXMMEXCPT;
> +
> +	/* TDX spec 11.6.2: CR4 bit VMXE and SMXE are fixed to 0 */
> +	cr4 &= ~(X86_CR4_VMXE | X86_CR4_SMXE);
> +
> +	/* Set parameters! */
> +	params->cr0 = kvm_get_default_cr0();
> +	params->cr3 = vm->pgd;
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

