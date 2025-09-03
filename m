Return-Path: <linux-kselftest+bounces-40675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD1B411A6
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 03:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794805E6F15
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 01:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2941C6FF5;
	Wed,  3 Sep 2025 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEBUmV9h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2818F40;
	Wed,  3 Sep 2025 01:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756861687; cv=none; b=juxLKWQy2rujoLyXOgfC2dF58UVofWP4Olyyg6n6wWwlSOXClsbCyic27pJ4TH8Uu/tZQnbR2J5veCitMFz+5KtXSER3eXI6x1nc+rYHvvo40DxJ9TvLdqNOu+ONSogY7o0ww+b70DuZcRL6vlyNJNZyRQm/Vsr4cYolgrzzukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756861687; c=relaxed/simple;
	bh=eFwtTOp488H2WYY50S1vuvKjFHgMVxD7w3AAU+mpx2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyVaMMYpeUiMZmn1OfL7020oDY5sUFglNaLzgfxLlWBoQs0Wvkgt6hcdd5vkJAi1PW+G3mDqYaqjJm1nhZc5hZNu9TLiEDwJv1Gp0IONxEXeQuOJnVehMCduKepJXQpgCkS1podUlEqAL8whOL8hU/Pt5l8s25hcz9NWrVcWz8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEBUmV9h; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756861686; x=1788397686;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eFwtTOp488H2WYY50S1vuvKjFHgMVxD7w3AAU+mpx2o=;
  b=CEBUmV9hFyHIFSkbBc+CXhpJtBHZrMuSJR6p6OrN4qSb3KXj1ljGQbq9
   rKeuIEfpWEcuyJFqvrgmCG15ancwaEcdUfFYIF5neFJLTsfMGihXene0V
   OEmTJcJU0VxXCKe9Blok8MTSAnmF4i+juJd6yqWALO5gvyPSUoRgO5901
   u32y7K8x3f180SWWYDs5OMqgN+tsTuvg0hfzn5f2kngoFao4acFmGYX2C
   IbffK7vSrpItPJYwa/Z2eUUqcO5O/NyuDIfwdcLIjR+ZQdYXGqV/Jm+h1
   kKjflOQvjFpkkJx+pv9ZgyS0inefuYkncuWFzZEoz78DwCDg9tlnBv37R
   A==;
X-CSE-ConnectionGUID: Fjyj9cSpQpC1RJQ2kBUxYA==
X-CSE-MsgGUID: XECOiO2hQWW8sQgzJPsIAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58860694"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="58860694"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 18:08:05 -0700
X-CSE-ConnectionGUID: ClgcoAYWQ2WAA3Y7LiceAw==
X-CSE-MsgGUID: wD1frc0nRta6PPFFK9ba6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="170994387"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 18:08:00 -0700
Message-ID: <23effdc0-1fbe-430d-b570-bc927b10fcf2@linux.intel.com>
Date: Wed, 3 Sep 2025 09:07:57 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/19] KVM: selftests: Add ucall support for TDX
To: Sean Christopherson <seanjc@google.com>
Cc: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
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
 <20250821042915.3712925-19-sagis@google.com>
 <18bf858c-e135-4a9b-bda8-a70be3b3720e@linux.intel.com>
 <aLcRIn8ryB2kXWcD@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <aLcRIn8ryB2kXWcD@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/2025 11:45 PM, Sean Christopherson wrote:
> On Wed, Aug 27, 2025, Binbin Wu wrote:
>> On 8/21/2025 12:29 PM, Sagi Shahar wrote:
>>> @@ -46,11 +69,23 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
>>>    {
>>>    	struct kvm_run *run = vcpu->run;
>>> -	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
>>> -		struct kvm_regs regs;
>>> +	switch (vm_type) {
>>> +	case KVM_X86_TDX_VM:
>>> +		if (vcpu->run->exit_reason == KVM_EXIT_MMIO &&
>>> +		    vcpu->run->mmio.phys_addr == host_ucall_mmio_gpa &&
>>> +		    vcpu->run->mmio.len == 8 && vcpu->run->mmio.is_write) {
>>> +			uint64_t data = *(uint64_t *)vcpu->run->mmio.data;
>>> +
>>> +			return (void *)data;
>>> +		}
>>> +		return NULL;
>> My first thought was how did SEV_ES or SNP work for this since they are not
>> able to get RDI neither.
>> Then I had a check in sev_smoke_test.c, both guest_sev_es_code() and
>> guest_snp_code() call GUEST_ASSERT(), which finally calls ucall_assert(), but
>> in test_sev(), the code doesn't handle ucall for SEV_ES or SNP.
>> Does it mean GUEST_ASSERT() is currently not working and ignored for SEV_ES
>> and SNP? Or did I miss anything?
> GUEST_ASSERT() "works" for -ES and -SNP in the sense that it generates as test
> failure due to the #VC not being handled (leads to SHUTDOWN).  But you're correct
> that ucall isn't functional yet.  x86/sev_smoke_test.c fudges around lack of ucall
> by using the GHCB MSR protocol to signal "done".
>
>          /*
>           * TODO: Add GHCB and ucall support for SEV-ES guests.  For now, simply
>           * force "termination" to signal "done" via the GHCB MSR protocol.
>           */
>          wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
>          vmgexit();
>
OK, thanks for the explanation!


