Return-Path: <linux-kselftest+bounces-39898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CACADB351CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 04:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6271889117
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 02:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF726A09F;
	Tue, 26 Aug 2025 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/hQ0mkv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447C26A08A;
	Tue, 26 Aug 2025 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175814; cv=none; b=m077HCCSGLOunlTdZyvpWxkZoba+TGtLwDhDHABA1lRmdyE7jyj1ke9Cl36KhB8dG7MXTiML9TmZ7R5K+oDg8uEWc75i+46VBe1COihwUAvL8KUq8lhvp7XfPdQXKXQDLZxah4CrjwWtOk13C+UHkK2Lo90I8XT/z2bcF2L3sEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175814; c=relaxed/simple;
	bh=Iy0mkiM7xhm80n82/XKBXpYNqioQjyoPd4xpnasICWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5kPCE0TF9kyeENxe9dVORK73Atg6K60Pq0DYPyXYX0iScRHkbefx7pGZTQ/SSLeXqaFmOqHf2xoJ9vLdCa/AdJCOIMo7peYHAwy5RQRepa1Ma9K/d0/WTqo5nsKrgFbXhPOYXyiO2wOClconTs7+CHTUCd4SoVgeMvNGoLHhXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/hQ0mkv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756175814; x=1787711814;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Iy0mkiM7xhm80n82/XKBXpYNqioQjyoPd4xpnasICWA=;
  b=U/hQ0mkvDhsdHFpqAURXPAR89A9O+yhjjXbl697cjD1pzak9J/zC6Xdz
   omWCaxrNVBwlRgXnyN7/QfMPyLv9vRBZMJyYCIvkrKSkakbi9Pwp1P2Ai
   tuFWhj7zkrWaObUQC+nzlH/LYxSFZh+BQ9hJYB8zAMBL+/F5Ti7mSySme
   iCmRhu/UuQPMs6cg5sbf0tFOv7JyPGN74xpzCzammZGzavdNNaraiTz4P
   Kpf5SMOjcpVqJlil4/5fYeQ+s3J26LMvynuO/zV/qqTa4QJQD6nBI814M
   axcEZ5DxvBRtDRHIuEh5SJzyE1X+d46Whu50vgyVD9GXvy70UnIidR9QV
   Q==;
X-CSE-ConnectionGUID: +4Hri1EySPSP0CdmWfYUFg==
X-CSE-MsgGUID: QTfZPg3YSIa4ENxhW4htng==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="75851400"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="75851400"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 19:36:53 -0700
X-CSE-ConnectionGUID: IxjBQORPQO2v3cj35hp8Dw==
X-CSE-MsgGUID: sowa/ZPQSWm4/jCTGRyQPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168662010"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 19:36:48 -0700
Message-ID: <30d7c24b-2747-47ad-885f-68b15adbaf8b@linux.intel.com>
Date: Tue, 26 Aug 2025 10:36:47 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/19] KVM: selftests: Allocate pgd in virt_map() as
 necessary
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
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-3-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250821042915.3712925-3-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/2025 12:28 PM, Sagi Shahar wrote:
> If virt_map() is called before any call to ____vm_vaddr_alloc() it
> will create the mapping using an invalid pgd.
>
> Add call to virt_pgd_alloc() as part of virt_map() before creating the
> mapping, similarly to ____vm_vaddr_alloc()
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>   tools/testing/selftests/kvm/lib/kvm_util.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index c3f5142b0a54..b4c8702ba4bd 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1609,6 +1609,7 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>   	TEST_ASSERT(vaddr + size > vaddr, "Vaddr overflow");
>   	TEST_ASSERT(paddr + size > paddr, "Paddr overflow");
>   
> +	virt_pgd_alloc(vm);
>   	while (npages--) {
>   		virt_pg_map(vm, vaddr, paddr);
>   		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);


