Return-Path: <linux-kselftest+bounces-40811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF2AB44D7A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 07:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9739F7BE528
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 05:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB2126C3B3;
	Fri,  5 Sep 2025 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mY36iWyT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52BD10942;
	Fri,  5 Sep 2025 05:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049859; cv=none; b=iAFDDJsVHEekLNUsIJDO3EOoEhHlrUIYz73dk4uPwiqI92V5I97h3YcJv7AoUHFTqdDnZX1WkwYk/xfdWjGSNiMzxhSy9gvETJAGvvhlNandonG7vugmSNqSBlC//DlNvSqaVH5gvWZ7hLX4DN8smWqxc7262vgYqQXlSq/ztOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049859; c=relaxed/simple;
	bh=H55g4kcERvNIDx1O7G1HQJWI8S4+ev9RwwNDcVQDI4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEutBBh1NS1mebmc4TdT/LLHz3TF0Jphe+sd1ei0YPhGowpx5WwNZiF14b5M+n4qRov4yQD5VyMERUsk5z//HazSHe1X8n/BHnyVPLj1TWzhSvIbP9gb/pNdgnp/LZ3C/JYWr26u6ROA633cm/0iV8Kl/3E5eCXXZR/tiletZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mY36iWyT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757049858; x=1788585858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H55g4kcERvNIDx1O7G1HQJWI8S4+ev9RwwNDcVQDI4Q=;
  b=mY36iWyTIzQICcPWcEbh+ny2tFRVUc8gFv2K5tTaba+FzADZNFgm/RJb
   L0W0k3kUhbRzeskE2mdhWxqaMQ0JbND6UdaPkFcvZuP3sNdeBwHrfjcN7
   O6MbMZUxqYLPLRZuE8EMu7NMJ6Um8iTwaX2/WawivIYRdCPpwpAotwGPq
   pgmp43KSjhHYIh6UASGy/SQ6ndTRrspBjZaiMh5hmLNLu9Cze61+qdgL5
   rCUFHLkUEvHUQygT0DwHYzzoOq0uwr7+y1b60ftzv0pbyS8LRW98p/e5x
   9dqdci2Ivz88NSvDoZ09/UjRh9vaQ/sXwlVo4bwnHWf7c283sIYMgRwce
   Q==;
X-CSE-ConnectionGUID: kSks9azKSVCUYGTCrEqhIw==
X-CSE-MsgGUID: Bgak3UBlSPuP3CH0D2shBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59508681"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="59508681"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 22:24:15 -0700
X-CSE-ConnectionGUID: QX3PLvbxTu2Cn0Ln9lemHA==
X-CSE-MsgGUID: C99e9a0PQ3OIYIwd+ObXjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="176411892"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 22:24:11 -0700
Message-ID: <c8f85609-aae2-4d5e-b983-e2703bb874c0@linux.intel.com>
Date: Fri, 5 Sep 2025 13:24:08 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/21] KVM: selftests: Expose segment definitons to
 assembly files
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
 <20250904065453.639610-6-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250904065453.639610-6-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/2025 2:54 PM, Sagi Shahar wrote:
> Move kernel segment definitions to a separate file which can be included
> from assembly files.
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>   .../selftests/kvm/include/x86/processor_asm.h        | 12 ++++++++++++
>   tools/testing/selftests/kvm/lib/x86/processor.c      |  5 +----
>   2 files changed, 13 insertions(+), 4 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/include/x86/processor_asm.h
>
> diff --git a/tools/testing/selftests/kvm/include/x86/processor_asm.h b/tools/testing/selftests/kvm/include/x86/processor_asm.h
> new file mode 100644
> index 000000000000..7e5386a85ca8
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/processor_asm.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Used for storing defines used by both processor.c and assembly code.
> + */
> +#ifndef SELFTEST_KVM_PROCESSOR_ASM_H
> +#define SELFTEST_KVM_PROCESSOR_ASM_H
> +
> +#define KERNEL_CS	0x8
> +#define KERNEL_DS	0x10
> +#define KERNEL_TSS	0x18
> +
> +#endif  // SELFTEST_KVM_PROCESSOR_ASM_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 2a44831e0cc9..623168ea9a44 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -7,6 +7,7 @@
>   #include "test_util.h"
>   #include "kvm_util.h"
>   #include "processor.h"
> +#include "processor_asm.h"
>   #include "sev.h"
>   #include "tdx/tdx_util.h"
>   
> @@ -14,10 +15,6 @@
>   #define NUM_INTERRUPTS 256
>   #endif
>   
> -#define KERNEL_CS	0x8
> -#define KERNEL_DS	0x10
> -#define KERNEL_TSS	0x18
> -
>   vm_vaddr_t exception_handlers;
>   bool host_cpu_is_amd;
>   bool host_cpu_is_intel;


