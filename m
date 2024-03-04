Return-Path: <linux-kselftest+bounces-5822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 370DD86FE19
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 10:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB78BB22767
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 09:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692D522099;
	Mon,  4 Mar 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3w6x+ni"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9D21A0A;
	Mon,  4 Mar 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546156; cv=none; b=oUUZiXT3ITF7tMvecvFZMQ9fcrAEYJiS/yc39S39L3xzi7a+cPQ0nDkqQQ1jTIH+4a73heLO2SKanaxv2hTongvyX683nw3rDAJ7UfWe0khBr7XFY138/2eZLzuMhQpd0yRCke8I1Cifkrv/70RpEnIoeBTNdObQOsu/OhC14hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546156; c=relaxed/simple;
	bh=FNurAoSIJM5iqfJTeKCtzPgTaSyy2bsh6qtFhnt9DPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B45C6f8mHQycV1l2l/9nCMZSYXmFH/2ZSpi8XdAvhhTub4kzH8xaCyQMwBnJjO/I3dJBDs3L/T3t5BSEWtP1e8WqdMrbNJEz8Nf/hBWfLb4CuTWEhM2fDqkOosB1nkVvSUuDpMhZlX+hXeRYrvRtXOGH0HCCCPODfItN+3OYnSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3w6x+ni; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709546154; x=1741082154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FNurAoSIJM5iqfJTeKCtzPgTaSyy2bsh6qtFhnt9DPM=;
  b=Q3w6x+niEQk/Ju8Ut1sXqbPswVVsv7bDPJmLMk9oijxbI/q2J3+cbLpJ
   2s/wg1vX9unak1ApkCFVUzcNPi628Qb9idfrvbb/GxxKeiL2kJFudGMoT
   LhRiJh12Pgnrxa+aURCJrjy7AEY6hdpyM6aSGXlpJBSYeV6ISfO4afl0j
   8PQ0fnPdGBuP6WvHj/Cf2XdKHDqDzuXkGjZSLt5wkE1Jf9clNcXm4r1E5
   ZNU65Md+20qBErRbSfeqlzT2Me5sCJ7iEGy5Wkc82/xOK75dPTWbjHrOP
   XFppLdL4UehKdnbneUG31cN8QcPk9L6h3KQ2SeC52y5AJbvyXqpprchhY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="6980716"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="6980716"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:55:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="32105342"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.8.218]) ([10.238.8.218])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:55:49 -0800
Message-ID: <30c3bcb8-3bb1-4c88-bbca-909a02903f0c@linux.intel.com>
Date: Mon, 4 Mar 2024 17:55:46 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 24/29] KVM: selftests: Expose _vm_vaddr_alloc
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>,
 Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>,
 Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-25-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-25-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> vm_vaddr_alloc always allocates memory in memslot 0. This allows users
> of this function to choose which memslot to allocate virtual memory
> in.

Nit: The patch exposes ____vm_vaddr_alloc() instead of _vm_vaddr_alloc().

> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   tools/testing/selftests/kvm/include/kvm_util_base.h | 3 +++
>   tools/testing/selftests/kvm/lib/kvm_util.c          | 6 +++---
>   2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index efd7ae8abb20..5dbebf5cfd07 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -561,6 +561,9 @@ void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
>   struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
>   void vm_populate_vaddr_bitmap(struct kvm_vm *vm);
>   vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
> +vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
> +			      vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
> +			      uint32_t data_memslot, bool encrypt);
>   vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
>   vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
>   			    enum kvm_mem_region_type type);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 28780fa1f0f2..d024abc5379c 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1410,9 +1410,9 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
>    * a unique set of pages, with the minimum real allocation being at least
>    * a page.
>    */
> -static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
> -				     vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
> -				     uint32_t data_memslot, bool encrypt)
> +vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
> +			      vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
> +			      uint32_t data_memslot, bool encrypt)
>   {
>   	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
>   


