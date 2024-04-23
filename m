Return-Path: <linux-kselftest+bounces-8722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A8C8AF621
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 20:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380171C23346
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE307144315;
	Tue, 23 Apr 2024 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIH3ZZDb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB87143891;
	Tue, 23 Apr 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895172; cv=none; b=VjUdEnxZN0hAiDLL411OEiyJ+T0uTkhr6OrSpF52o1iAU4i/07OBLxEq0ZmAX8OYkmapWOXwDFriYLhu526B4hO27ojEtKX0Rj483Cr99DW63h88hzo9AD0NkdetHDv76naiS4VPawLzGgNid7y3HbQ/9IzhkUBTGKzHj9mp9xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895172; c=relaxed/simple;
	bh=VBa5Uoa7nnDAfK4MeWFM8DIP6qDVEtvWS57pRdVdN+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lETkiAob8eUdzExJL2qYu1yFAX+DhitwG3OL1H75TpNI+wDqNCswCAn2fW/i1JtCogRo0XvwgLt0rN+UjQ8WqpCCC48ZnUeqP6TBgC7/oL86S49Io1g0WfP+zir7szuhlBp/8NMNGmiGNU0Q6v8trbqOtqw7R08/bZW0vTE9e/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIH3ZZDb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713895171; x=1745431171;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VBa5Uoa7nnDAfK4MeWFM8DIP6qDVEtvWS57pRdVdN+U=;
  b=YIH3ZZDbtUqDnTzkpGwzL2jScsL9pFgiXlTui11QQOnXS37gga7Z56D7
   vQUO3KOZ30ovzgpJejhlJ7nCmR9wND2w5GvXjiLNUjimAQerceqKpxYkT
   EMfv5vIQWEQBbnu1O+G81Rj+XwVCHJ4fTtM1y7mVjTGynMrRshwbFw44h
   gSvr56D6vXPcgWNxHqgAnJAZp9WXxwniQzv8z9iO3ENLO/+uCkMsHowMD
   ASrKfXjSvrNeQnHSTu+mD3JEJA1qk37CJbWc4LANAcAv0yuYHH2LkgeQy
   npT6bs05PmW8MIbXVcgecTtA1nKQYNHZm7sG+2R9QmCk7PFuq9jptD2Ee
   A==;
X-CSE-ConnectionGUID: ztWXMs/FRLS5/mSiksbcqg==
X-CSE-MsgGUID: /xIv8WtpRoWcM3LfuuKBeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9370605"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9370605"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:59:23 -0700
X-CSE-ConnectionGUID: 88MXJqjRTQSFVr9BMJbdpg==
X-CSE-MsgGUID: 771S65yCQu2CZpw3IpeGFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24895532"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.60]) ([10.24.10.60])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:59:22 -0700
Message-ID: <cdc6c880-c666-4ff2-99f3-56c6b4f7576d@intel.com>
Date: Tue, 23 Apr 2024 10:59:21 -0700
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
 <17F1A2E9-6BAD-40E7-ACDD-B110CFC124B3@infradead.org>
 <65FF4D51-05A8-42E0-9D07-6E42913CC75E@infradead.org>
 <6dca783b-6532-4fa7-9e04-1c0a382a00b0@intel.com>
 <c863ffcfd4edda9a1a46e3351766a655c5523f7d.camel@infradead.org>
 <71260288-3666-4419-8283-6565e91aaba4@intel.com>
 <06864883c53cc4042e1939c04ecbd5ef0f8acf3b.camel@infradead.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <06864883c53cc4042e1939c04ecbd5ef0f8acf3b.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/23/2024 12:49 AM, David Woodhouse wrote:
>> If I restored the KVM_REQ_GLOBAL_CLOCK_UPDATE request from
>> kvm_arch_vcpu_load(), the selftest works for me, and I ran the test for
>> 1000+ iterations, w/ or w/o TSC scaling, the TEST_ASSERT(delta_corrected
>>  <= ±1) never got hit. This is awesome!
>>
>> However, without KVM_REQ_GLOBAL_CLOCK_UPDATE, it still fails on creating
>> a VM. Maybe the init sequence sill needs some rework.
> 
> That one confuses me. The crash is actually in debugfs, as it's
> registering the per-vm or per-vcpu stats. I can't imagine *how* that's
> occurring. Or see why the availability of TSC scaling would cause it to
> show up for you and not me. Can I have your .config please?
> 
> First thought would be that there's some change in the KVM structures
> and you have some stale object files using the old struct, but then I
> realise I forgot to actually *remove* the now-unused
> kvmclock_update_work from x86's struct kvm_arch anyway.
> 
> I'll try to reproduce, as I think I want to *know* what's going on
> here, even if I am going to drop that patch as mentioned in 
> https://lore.kernel.org/kvm/a6723ac9e0169839cb33e8022a47c2de213866ac.camel@infradead.org
> 
> Are you able to load that vmlinux in gdb and
> (gdb) list *start_creating+0x80
> (gdb) list *kvm_create_vm_debugfs+0x28b
> 
> Thanks again.

My apologies, it turns out the KVM_REQ_GLOBAL_CLOCK_UPDATE is not
needed. Today I can't reproduce the issue after removing it.  Yesterday
I thought it may miss something related to pfncache.

To be clear, with the above mentioned change to
kvm_scale_tsc(master_tsc_scaling_ratio), the selftest runs reliably
regardless TSC scaling is enabled or not.

