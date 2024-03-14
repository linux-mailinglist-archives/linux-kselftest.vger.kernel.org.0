Return-Path: <linux-kselftest+bounces-6336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0957F87C4D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 22:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B25D1C217B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C817641B;
	Thu, 14 Mar 2024 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6/0zVer"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471E76412;
	Thu, 14 Mar 2024 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710452802; cv=none; b=K8XZ31k4tz+XZXOXmSt5Hf4KJeX8j2GGyq6pcCrOvXer2sWeCXUqtLv1xTf0ePwJThGSDJT9ch5ZYrL0dnVVEODQYvI2n5F+9Xn7Jn4v+oFx8dJatlTWYm4AcxkLkgOSqQ1P/PztYND1oJE3jhEWAW2viSA87cexfEPCjD+GgP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710452802; c=relaxed/simple;
	bh=024QBEVLTI+6kcoD7J49NoiaMMt3w6GMzvKHMg9E6rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=EBOnSP75E5MnPtqOLJj4642d0e9+4DqXSq+gJkn5dq9/WvNXTqCU1W8GSRqRo7IHFtYpbt+f6i5A/mY2IBzbRg4+/8c0NmoBwteVvwLsM4CBrzBQhGvU3+S7fx6NNQIUTzueRJ+TrxHqe1A9Odgq/kOXQx5nEUfUeUuuE2khpDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6/0zVer; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710452800; x=1741988800;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=024QBEVLTI+6kcoD7J49NoiaMMt3w6GMzvKHMg9E6rg=;
  b=B6/0zVerh3uONZl4KPvBZ/l6fRcW//g/96B5cRs7iKJKwXbRmZqE/FN2
   hARNnv3w6oZO5Kk8FZkgE/Fm4LBlN+WZBq/XWTAOkoS2Ud0k+QcDH3tSW
   sW37fl2/2mza2TtYRAO+oc6/gnNpCxmepyDfoc5fznVIt9vYp6T6PeQVF
   um7WxmQ19QPd9q+LQClnTH1QLf/IjokgFxmODGNpYflc35uG68aHbge3A
   m0ARCqjA5HvEfMk13aKnF/ab9DtAjCtOFPykUcl5PpKN4kjSC/tFJoTxX
   0SAMZdZH+FHJO0NTvriENhwB247ud9dfTEhfQq5QoUR2HoQ729kOM64q5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="15853634"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="15853634"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 14:46:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="16918258"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.77]) ([10.24.10.77])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 14:46:39 -0700
Message-ID: <03592298-4390-4111-870b-129b6be98d3a@intel.com>
Date: Thu, 14 Mar 2024 14:46:38 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 27/29] KVM: selftests: Propagate
 KVM_EXIT_MEMORY_FAULT to userspace
Content-Language: en-US
To: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org,
 Ackerley Tng <ackerleytng@google.com>, "Afranji, Ryan" <afranji@google.com>,
 "Aktas, Erdem" <erdemaktas@google.com>, Sagi Shahar <sagis@google.com>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-28-sagis@google.com>
 <DS7PR11MB78860170A5FD77253573BC09F6292@DS7PR11MB7886.namprd11.prod.outlook.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, "Xu, Haibo1" <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 "Annapurve, Vishal" <vannapurve@google.com>,
 Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>,
 jmattson@google.com, dmatlack@google.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <DS7PR11MB78860170A5FD77253573BC09F6292@DS7PR11MB7886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/2023 12:47 PM, Shashar, Sagi wrote:
> 
> 
> -----Original Message-----
> From: Sagi Shahar <sagis@google.com> 
> Sent: Tuesday, December 12, 2023 12:47 PM
> To: linux-kselftest@vger.kernel.org; Ackerley Tng <ackerleytng@google.com>; Afranji, Ryan <afranji@google.com>; Aktas, Erdem <erdemaktas@google.com>; Sagi Shahar <sagis@google.com>; Yamahata, Isaku <isaku.yamahata@intel.com>
> Cc: Sean Christopherson <seanjc@google.com>; Paolo Bonzini <pbonzini@redhat.com>; Shuah Khan <shuah@kernel.org>; Peter Gonda <pgonda@google.com>; Xu, Haibo1 <haibo1.xu@intel.com>; Chao Peng <chao.p.peng@linux.intel.com>; Annapurve, Vishal <vannapurve@google.com>; Roger Wang <runanwang@google.com>; Vipin Sharma <vipinsh@google.com>; jmattson@google.com; dmatlack@google.com; linux-kernel@vger.kernel.org; kvm@vger.kernel.org; linux-mm@kvack.org
> Subject: [RFC PATCH v5 27/29] KVM: selftests: Propagate KVM_EXIT_MEMORY_FAULT to userspace
> 
> Allow userspace to handle KVM_EXIT_MEMORY_FAULT instead of triggering TEST_ASSERT.
> 
> From the KVM_EXIT_MEMORY_FAULT documentation:
> Note!  KVM_EXIT_MEMORY_FAULT is unique among all KVM exit reasons in that it accompanies a return code of '-1', not '0'!  errno will always be set to EFAULT or EHWPOISON when KVM exits with KVM_EXIT_MEMORY_FAULT, userspace should assume kvm_run.exit_reason is stale/undefined for all other error numbers.

If KVM exits to userspace with KVM_EXIT_MEMORY_FAULT, most likely it's because the guest attempts to access the gfn in a way that is different from what the KVM is configured, in terms of private/shared property. I'd suggest to drop this patch and work on the selftests code to eliminate this exit.

If we need a testcase to catch this exit intentionally, we may call _vcpu_run() directly from the testcase and keep the common API vcpu_run() intact.

> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index d024abc5379c..8fb041e51484 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1742,6 +1742,10 @@ void vcpu_run(struct kvm_vcpu *vcpu)  {
>  	int ret = _vcpu_run(vcpu);
>  
> +	// Allow this scenario to be handled by the caller.
> +	if (ret == -1 && errno == EFAULT)
> +		return;
> +
>  	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_RUN, ret));  }
>  
> --
> 2.43.0.472.g3155946c3a-goog
> 

