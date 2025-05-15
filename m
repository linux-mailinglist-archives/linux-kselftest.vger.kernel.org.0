Return-Path: <linux-kselftest+bounces-33006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE73AB7B70
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 04:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB907ABEED
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 02:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFF42868AF;
	Thu, 15 May 2025 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ye5kJwou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1A01A2391;
	Thu, 15 May 2025 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747275052; cv=none; b=rFlwjlQONsJ2MInR4RVOU79RJHobBs9dvqJsCdQefsuMvX8XpyNj/sAN18QyCsiRQIvzmSnYf0bwjtpFwlOBTZeKdA5ufrQgXMPR3Jm98bc4FbypdN/5KR/5aTDb8DfWVFK7/qIW4bdnQ/Hh39+nwpLK2InTgryF74Nxfy8OMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747275052; c=relaxed/simple;
	bh=q5cjI7xerfFkG/7nI9gsuCw4hY0So9s9zAigg13F+Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akNItv9YELdiswmXI2kx0q71hQyPVJxBzqg2SJImbqPv9p+zHNvF7JkPkct6FjiIszHhsUd9EW1wyhbDJHExzLzWoHeN8xxmONWLkbR6co24s1Lr01gEqv5eZT0zE67zDPn0PGcI9sGghTNUwZxXlCD2w8Ghc+3dihzu3JfkIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ye5kJwou; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747275051; x=1778811051;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q5cjI7xerfFkG/7nI9gsuCw4hY0So9s9zAigg13F+Wg=;
  b=Ye5kJwouHqE4Sh69VTIN1X9ji5MT1Cqs9XKzzHCbFIVCcrupb+HRUZKu
   yHUp7Xi8c0Z3KNKzSUNptupwzzAfFQs0xFtou67bzHNOBlCuXqHSYKDO4
   xrkpVtQhMI74YFbDiWtyMMYqs/EoS04NE87aTgGhXaTIxj5nE0fOmt5Pa
   ZpFh3WXAZwFepxY1OCLFXSMBBSmuxxAE7srEqnzpR1cxrxyf+LNCDup9E
   +EUMm0DFjBMnA/226ViblXBPc9gIZnCydkFgsUF3LgIHePkE75y3iLOD6
   mVuLd52gzv5lOQzY6fmFN4Uri5KzYqhR4K+qj06QdMPN49iJaXkVkoGM+
   g==;
X-CSE-ConnectionGUID: 50/WRPnLRZimtXoy9MrJ4Q==
X-CSE-MsgGUID: eCnxJ143Qcm5gIeCFiJAUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59424278"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="59424278"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 19:10:50 -0700
X-CSE-ConnectionGUID: /gaxGn5vSPaE4QGAvQCg3A==
X-CSE-MsgGUID: PXQm5kYZRzKkSQkjnS2XpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="138093463"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 19:10:43 -0700
Message-ID: <434055d7-e7ec-48ad-9ef5-2d80bb824a63@linux.intel.com>
Date: Thu, 15 May 2025 10:10:40 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/38] x86/irq: Factor out common code for installing
 kvm irq handler
To: Sean Christopherson <seanjc@google.com>,
 Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
 Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>,
 Xiong Zhang <xiong.y.zhang@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>,
 Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>,
 Shukla Manali <Manali.Shukla@amd.com>,
 Nikunj Dadhania <nikunj.dadhania@amd.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-7-mizhang@google.com> <aCUlbDNoxQ-65mc0@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCUlbDNoxQ-65mc0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 7:21 AM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
>> index 385e3a5fc304..18cd418fe106 100644
>> --- a/arch/x86/kernel/irq.c
>> +++ b/arch/x86/kernel/irq.c
>> @@ -312,16 +312,22 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_x86_platform_ipi)
>>  static void dummy_handler(void) {}
>>  static void (*kvm_posted_intr_wakeup_handler)(void) = dummy_handler;
>>  
>> -void kvm_set_posted_intr_wakeup_handler(void (*handler)(void))
>> +void x86_set_kvm_irq_handler(u8 vector, void (*handler)(void))
>>  {
>> -	if (handler)
>> +	if (!handler)
>> +		handler = dummy_handler;
>> +
>> +	if (vector == POSTED_INTR_WAKEUP_VECTOR &&
>> +	    (handler == dummy_handler ||
>> +	     kvm_posted_intr_wakeup_handler == dummy_handler))
>>  		kvm_posted_intr_wakeup_handler = handler;
>> -	else {
>> -		kvm_posted_intr_wakeup_handler = dummy_handler;
>> +	else
>> +		WARN_ON_ONCE(1);
>> +
>> +	if (handler == dummy_handler)
> Eww.  Aside from the fact that the dummy_handler implementation is pointless
> overhead, I don't think KVM should own the IRQ vector.  Given that perf owns the
> LVTPC, i.e. responsible for switching between NMI and the medited PMI IRQ, I
> think perf should also own the vector.  KVM can then use the existing perf guest
> callbacks to wire up its PMI handler.

Hmm, yes, make sense.


>
> And with that, this patch can be dropped.
>

