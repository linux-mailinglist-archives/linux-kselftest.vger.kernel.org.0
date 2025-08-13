Return-Path: <linux-kselftest+bounces-38819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4820B23F7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 06:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75174622C7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 04:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08F229C32F;
	Wed, 13 Aug 2025 04:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bi01UfkM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC3123D7D9;
	Wed, 13 Aug 2025 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755058967; cv=none; b=n7Cof4dQSIZ3uyJk6PAnP9GQdTs7H63CBaq3ajemE7qNqooOyo0x7ET+KhU0P0vLSVjCI5nX+AVt/gBo/i951XRLjmCBrcblC1a5RthQfjIE0u9TElN4FgIXAPPrOt7XoDo11BwB+TKg9tl2nvOMyaNW7lt+vnhk6rpmZQe+tc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755058967; c=relaxed/simple;
	bh=qeYIs4x9kxP+JA0FE0QJe7I4M9/ZKaMkE5E1zSV1Ow4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3qzn6KBpY5V6GWjnFXtg7qCThK43cjGZLOmAjWKH+abPPNqCAUh2IktSdjz54IroU1pzCqjoH2kX1AupfE7fQ4BDjZRvclu+oJ2X+YzheIKy1ZAKpAUNbdj5J8jEkXYKj5NzNEC2KIHsbv9lEArk+5ah+9ZjJJzziYaS01TZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bi01UfkM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755058966; x=1786594966;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qeYIs4x9kxP+JA0FE0QJe7I4M9/ZKaMkE5E1zSV1Ow4=;
  b=bi01UfkMYizAV39zqL+1SKLOxWN8hFy9rNpg5+xtg/4PNqPq5CaQ38J1
   uWJkRCgfLSGMEI7T4YqySXzvytkxSSJv+DWxy3TPGI3wkY5OAS1RLAjY5
   ViKPX/lN1nOFzNZS8Tn3d8jcGBABE0Tc7J2nKAWnRpm6RHKD5XbhFSe53
   S46a5qXHnPxca8yNnKjMM+QpuLm/SPeDXxdRVLA3PdwaZU2xe9FVxbzyZ
   mWGGX2UsX6XLWmzAi0sWCz32D/4dsgRGPFmB7OxWtYZlc8Ctd5gNfMtTo
   Vp/u8fyxtVr10VWxrt6erLVB9ZpvBRJUvqwve8zj1n2uw942oA8OGIOI4
   Q==;
X-CSE-ConnectionGUID: DJNTKHAnQwS9u2RQkiphRA==
X-CSE-MsgGUID: L57jDqWCTfmeI7CetvzBrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57463217"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57463217"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 21:22:45 -0700
X-CSE-ConnectionGUID: 5UDhGpTEQ0mmjdKDYHQ+OA==
X-CSE-MsgGUID: 9TIbkHqRQEy76pMq8GlzrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="167158624"
Received: from unknown (HELO [10.238.11.25]) ([10.238.11.25])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 21:22:41 -0700
Message-ID: <0c8d6d1c-d9e1-4ffd-bb26-a03fb87cde1f@linux.intel.com>
Date: Wed, 13 Aug 2025 12:22:39 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/30] KVM: selftests: Add helper functions to create
 TDX VMs
To: Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>,
 Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny
 <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-7-sagis@google.com> <aJpO_zN3buvaQoAW@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <aJpO_zN3buvaQoAW@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/2025 4:13 AM, Sean Christopherson wrote:
> On Thu, Aug 07, 2025, Sagi Shahar wrote:
[...]
>> +
>> +/*
>> + * Boot parameters for the TD.
>> + *
>> + * Unlike a regular VM, KVM cannot set registers such as esp, eip, etc
>> + * before boot, so to run selftests, these registers' values have to be
>> + * initialized by the TD.
>> + *
>> + * This struct is loaded in TD private memory at TD_BOOT_PARAMETERS_GPA.
>> + *
>> + * The TD boot code will read off parameters from this struct and set up the
>> + * vCPU for executing selftests.
>> + */
>> +struct __packed td_boot_parameters {
> None of these comments explain why these structures are __packed, and I suspect
> _that_ is the most interesting/relevant information for unfamiliar readers.
I guess because the fields defined in this structure are accessed by hard-coded
offsets in boot code.
But as you suggested below, replicating the functionality of the kernel's
OFFSET() could get rid of "__packed".

A side topic is when developers should provide comments for the uses of
"__packed". Is it always preferred a comment for it or a developer can save
the comment for obvious cases, e.g, the structure is defined according to
some hardware layout?

>
>> +	uint32_t cr0;
>> +	uint32_t cr3;
>> +	uint32_t cr4;
>> +	struct td_boot_parameters_dtr gdtr;
>> +	struct td_boot_parameters_dtr idtr;
>> +	struct td_per_vcpu_parameters per_vcpu[];
>> +};
>> +
...

>> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
>> new file mode 100644
>> index 000000000000..c8cbe214bba9
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
>> @@ -0,0 +1,100 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#include "tdx/td_boot_asm.h"
>> +
>> +/* Offsets for reading struct td_boot_parameters. */
>> +#define TD_BOOT_PARAMETERS_CR0         0
>> +#define TD_BOOT_PARAMETERS_CR3         4
>> +#define TD_BOOT_PARAMETERS_CR4         8
>> +#define TD_BOOT_PARAMETERS_GDT         12
>> +#define TD_BOOT_PARAMETERS_IDT         18
>> +#define TD_BOOT_PARAMETERS_PER_VCPU    24
>> +
>> +/* Offsets for reading struct td_per_vcpu_parameters. */
>> +#define TD_PER_VCPU_PARAMETERS_ESP_GVA     0
>> +#define TD_PER_VCPU_PARAMETERS_LJMP_TARGET 4
>> +
>> +#define SIZEOF_TD_PER_VCPU_PARAMETERS      10
> Please figure out how to replicate the functionality of the kernel's OFFSET()
> macro from  include/linux/kbuild.h, I have zero desire to maintain open coded
> offset values.
>

