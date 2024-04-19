Return-Path: <linux-kselftest+bounces-8509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD348AB7F7
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77060281F68
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9D113E3E0;
	Fri, 19 Apr 2024 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIIIQnKG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD47813D88F;
	Fri, 19 Apr 2024 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570815; cv=none; b=Yn71VvVt2pAKcO81EAtPSocnDCVS49OoIG1G/JvhNfYVK5+9Glrmg4dyJ/AYcKAeUzJKXlFhwMZ1NdqV/7D3A8nyFIFjNgnO2QIklbJ7beLv4eOk1k1Xzcw13QXR2YCo4I9jjVusA8mh8xcWiOibM62nU9wfRK5aqceU3CcKiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570815; c=relaxed/simple;
	bh=3gbkhIO45mQhzKLsuGyPxbw/ZYuLJPO+82sN/qnNP8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bd7hBdbwo/UokWgIKe1k2F8loeu6HDwwkMV4cvNbQ4oC1Qk4CM61K2dWva9nWe+6WLIuMRH3MKCUgQxNCCRbX8+ThIMCuqmyTKzxj7UM7G7E1HIgD7FmsL4XZEfmjz/ApLNP/Y0gKclsEcv49KaFNk/RWDR23wvjdxKQpanWYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIIIQnKG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713570814; x=1745106814;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3gbkhIO45mQhzKLsuGyPxbw/ZYuLJPO+82sN/qnNP8Y=;
  b=GIIIQnKGbPDTOtSB+drjpBgnkEmAFUZFdBGwMfQpUkSNpBA/OlQOV/Bj
   NaBXbVhJJIvUPSCfmbWA5VfcXh2r1y2EFewZedDMQyUH8dGTzE+sMVopU
   vNYynFAZX6VvIBGjss1LL/QrnA6tcEiozTHc6vn0nYPBqiYz7xGGR3ewY
   KggamjN3X+3/wl6b4yXNcGSWENMErqCq+TMDfsw4AqF5L80jGGYG80wD1
   hIzd7jZK2emW2g+t9uJZfSoN7KGCSQdETAxOtf43k7359wQdiWsab2XWV
   YYK+1TNThbsCS4eqTWQ6wqooKFvkAVDCcVT+PwP+ijFA+VV8FERfjafY6
   g==;
X-CSE-ConnectionGUID: +z7XL0cMT9+5Kzy26LgolQ==
X-CSE-MsgGUID: 5X0FIlt9S1q1WE1BgtzIFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9051093"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="9051093"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 16:53:33 -0700
X-CSE-ConnectionGUID: 9EGboRl0SPWKp4IZ7WJR4A==
X-CSE-MsgGUID: jATii7gCRUWuBg06ojTolg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="23504137"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.31]) ([10.24.10.31])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 16:53:34 -0700
Message-ID: <2e908322-faa0-4db7-bc14-f87a9d71f577@intel.com>
Date: Fri, 19 Apr 2024 16:53:32 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: selftests: Add KVM/PV clock selftest to prove
 timer drift correction
To: David Woodhouse <dwmw2@infradead.org>, Jack Allister
 <jalliste@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>
Cc: Paul Durrant <paul@xen.org>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240408220705.7637-1-jalliste@amazon.com>
 <20240408220705.7637-3-jalliste@amazon.com>
 <3664e8ec-1fa1-48c0-a80d-546b7f6cd671@intel.com>
 <FABCFBD0-4B76-4662-9F7B-7E1A856BBBB6@infradead.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <FABCFBD0-4B76-4662-9F7B-7E1A856BBBB6@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/19/2024 12:34 PM, David Woodhouse wrote:
> On 19 April 2024 18:13:16 BST, "Chen, Zide" <zide.chen@intel.com> wrote:
>> I'm wondering what's the underling theory that we definitely can achieve
>> ±1ns accuracy? I tested it on a Sapphire Rapids @2100MHz TSC frequency,
>> and I can see delta_corrected=2 in ~2% cases.
> 
> Hm. Thanks for testing!
> 
> So the KVM clock is based on the guest TSC. Given a delta between the guest TSC T and some reference point in time R, the KVM clock is expressed as a(T-R)+r, where little r is the value of the KVM clock when the guest TSC was R, and (a) is the rate of the guest TSC.
> 
> When set the clock with KVM_SET_CLOCK_GUEST, we are changing the values of R and r to a new point in time. Call the new ones Q and q respectively.
> 
> But we calculate precisely (within 1ns at least) what the KVM clock would have been with the *old* formula, and adjust our new offset (q) so that at our new reference TSC value Q, the formulae give exactly the same result.
> 
> And because the *rates* are the same, they should continue to give the same results, ±1ns.
> 
> Or such *was* my theory, at least. 

Thanks for the explanation.

> 
> Would be interesting to see it disproven with actual numbers for the old+new pvclock structs, so I can understand where the logic goes wrong.
> 
> Were you using frequency scaling?

I can see similar ~2% failure ratio w/ or w/o commenting out
configure_scaled_tsc().

