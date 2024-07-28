Return-Path: <linux-kselftest+bounces-14343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7436C93E4B5
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED27328122A
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 11:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A433986;
	Sun, 28 Jul 2024 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boH6xZrx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C378472;
	Sun, 28 Jul 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722165416; cv=none; b=g7b5DP1LNuxk2TdUuHSrN+qQC2X93e5cnDpLDHLhIn9FqB+2oyVN8d7RJZNDWRYhwJnHQtBOIVRwRrvJ/6Ll7wVLwyd2q1QcHqomy50Cg1+EPgH+rwbMk1f2L2CzWQaDC2hEed5wJb1nm+8dXSdSF8ampp1a6L8dtcWYFPLv6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722165416; c=relaxed/simple;
	bh=1JKGz+l/9tFKb3tLci1KBK86LYVt9Ga7B8yR/DX71fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOWDHCrdiv5Zwodd0uda5+uyQOnZhDbWOnKlvvzC6E4r2xOHYrU+b0j8edsqn5+c/5oqo95ycyJ5NjSHZduznHDjoZIte86PU0BAwLf0LwB7xcnKw3Du8BBIr6k8sFfFfJEtmK4S8UDxLkPehM2wFDkqJ5EMoAWAvBzIGMCSj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boH6xZrx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722165414; x=1753701414;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1JKGz+l/9tFKb3tLci1KBK86LYVt9Ga7B8yR/DX71fU=;
  b=boH6xZrxboRbLq7VvEqB1ZdotbCgZZC5DZa6bhwxoy+XkyIZsF9etzyZ
   XuCP5QNWaWFe3Q2WLF68gFZiW38dgARC0lT3sGXoc7jzqqpN2o2fhwO51
   7Iv8jiWZ/33dNarxdDEQd9YwVcLiVwcusQTthOi7i2LJMut7fbXpnAbj3
   uQthj5yCxp/J6tVDY/spdL9SBM6i7j6cog7/zGJrW3Nhc14oi1WxlJ65s
   MpwbS7Gq1MCZmyk9b//9sjp3pT/f/hSiRDTDWbyfVAjFRX7nQ8rCF1VHW
   A4ll1eHi8WRBu1fjGyxNiquczGC9dY1cmFC7w7tqBTJMYnhXmvopqgDZH
   Q==;
X-CSE-ConnectionGUID: ih42jCNUTb+7Uw2JNjLfvA==
X-CSE-MsgGUID: pMShbKcdTOOsFyAZPrlcxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="37416188"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="37416188"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 04:16:53 -0700
X-CSE-ConnectionGUID: oOIPNndLQUKUQA0YxAVaVQ==
X-CSE-MsgGUID: 4O7e87TSTiqCnO1mXOsPWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="58476523"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.241.187]) ([10.124.241.187])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 04:16:47 -0700
Message-ID: <18729cf6-bf3a-4a11-a9fc-a35792cd1736@linux.intel.com>
Date: Sun, 28 Jul 2024 19:16:44 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 09/29] KVM: selftests: TDX: Add report_fatal_error
 test
To: Sean Christopherson <seanjc@google.com>, Yan Zhao <yan.y.zhao@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, sagis@google.com,
 linux-kselftest@vger.kernel.org, afranji@google.com, erdemaktas@google.com,
 isaku.yamahata@intel.com, pbonzini@redhat.com, shuah@kernel.org,
 pgonda@google.com, haibo1.xu@intel.com, chao.p.peng@linux.intel.com,
 vannapurve@google.com, runanwang@google.com, vipinsh@google.com,
 jmattson@google.com, dmatlack@google.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org
References: <ZhkhvtijbhxKKAEk@yzhao56-desk.sh.intel.com>
 <diqzr0f7jbj6.fsf@ctop-sg.c.googlers.com>
 <Zhz8xNpQoi0wCQgL@yzhao56-desk.sh.intel.com> <Zh7Iay40VQgNvsFW@google.com>
 <ZiBP/j6Ic7hGrbxN@yzhao56-desk.sh.intel.com> <ZibVbYawGJFcJqd1@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <ZibVbYawGJFcJqd1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/23/2024 5:23 AM, Sean Christopherson wrote:
> On Thu, Apr 18, 2024, Yan Zhao wrote:
>> On Tue, Apr 16, 2024 at 11:50:19AM -0700, Sean Christopherson wrote:
>>> On Mon, Apr 15, 2024, Yan Zhao wrote:
>>>> On Mon, Apr 15, 2024 at 08:05:49AM +0000, Ackerley Tng wrote:
>>>>>>> The Intel GHCI Spec says in R12, bit 63 is set if the GPA is valid. As a
>>>>>> But above "__LINE__" is obviously not a valid GPA.
>>>>>>
>>>>>> Do you think it's better to check "data_gpa" is with shared bit on and
>>>>>> aligned in 4K before setting bit 63?
>>>>>>
>>>>> I read "valid" in the spec to mean that the value in R13 "should be
>>>>> considered as useful" or "should be passed on to the host VMM via the
>>>>> TDX module", and not so much as in "validated".
>>>>>
>>>>> We could validate the data_gpa as you suggested to check alignment and
>>>>> shared bit, but perhaps that could be a higher-level function that calls
>>>>> tdg_vp_vmcall_report_fatal_error()?
>>>>>
>>>>> If it helps, shall we rename "data_gpa" to "data" for this lower-level,
>>>>> generic helper function and remove these two lines
>>>>>
>>>>> if (data_gpa)
>>>>> 	error_code |= 0x8000000000000000;
>>>>>
>>>>> A higher-level function could perhaps do the validation as you suggested
>>>>> and then set bit 63.
>>>> This could be all right. But I'm not sure if it would be a burden for
>>>> higher-level function to set bit 63 which is of GHCI details.
>>>>
>>>> What about adding another "data_gpa_valid" parameter and then test
>>>> "data_gpa_valid" rather than test "data_gpa" to set bit 63?
>>> Who cares what the GHCI says about validity?  The GHCI is a spec for getting
>>> random guests to play nice with random hosts.  Selftests own both, and the goal
>>> of selftests is to test that KVM (and KVM's dependencies) adhere to their relevant
>>> specs.  And more importantly, KVM is NOT inheriting the GHCI ABI verbatim[*].
>>>
>>> So except for the bits and bobs that *KVM* (or the TDX module) gets involved in,
>>> just ignore the GHCI (or even deliberately abuse it).  To put it differently, use
>>> selftests verify *KVM's* ABI and functionality.
>>>
>>> As it pertains to this thread, while I haven't looked at any of this in detail,
>>> I'm guessing that whether or not bit 63 is set is a complete "don't care", i.e.
>>> KVM and the TDX Module should pass it through as-is.
>>>
>>> [*] https://lore.kernel.org/all/Zg18ul8Q4PGQMWam@google.com
>> Ok. It makes sense to KVM_EXIT_TDX.
>> But what if the TDVMCALL is handled in TDX specific code in kernel in future?
>> (not possible?)
> KVM will "handle" ReportFatalError, and will do so before this code lands[*], but
> I *highly* doubt KVM will ever do anything but forward the information to userspace,
> e.g. as KVM_SYSTEM_EVENT_CRASH with data[] filled in with the raw register information.
>
>> Should guest set bits correctly according to GHCI?
> No.  Selftests exist first and foremost to verify KVM behavior, not to verify
> firmware behavior.  We can and should use selftests to verify that *KVM* doesn't
> *violate* the GHCI, but that doesn't mean that selftests themselves can't ignore
> and/or abuse the GCHI, especially since the GHCI definition for ReportFatalError
> is frankly awful.
>
> E.g. the GHCI prescibes actual behavior for R13, but then doesn't say *anything*
> about what's in the data page.  Why!?!?!  If the format in the data page is
> completely undefined, what's the point of restricting R13 to only be allowed to
> hold a GPA?

The description of R13 in GHCI:
   4KB-aligned GPA where additional error data is shared by the TD. The
   VMM must validate that this GPA has the Shared bit set. In other words,
   that a shared-mapping is used, and that this is a valid mapping for the
   TD. This shared memory region is expected to hold a zero-terminated
   string.

IIUC, according the GHCI, R13 is a 4K aligned shared buffer provided by
the TDX guest to pass additional error message to VMM, i.e., it needs to
be a shared GPA.  And the content in the buffer is expected to hold a
zero-terminated string.

Do you think "a zero-terminated string" describes the format in the data
page?


>
> And the wording is just as awful:
>
>    The VMM must validate that this GPA has the Shared bit set. In other words,
>    that a shared-mapping is used, and that this is a valid mapping for the TD.
>
> I'm pretty sure it's just saying that the TDX module isn't going to verify the
> operate, i.e. that the VMM needs to protect itself, but it would be so much
> better to simply state "The TDX Module does not verify this GPA", because saying
> the VMM "must" do something leads to pointless discussions like this one, where
> we're debating over whether or *our* VMM should inject an error into *our* guest.
>
> Anyways, we should do what makes sense for selftests and ignore the stupidity of
> the GHCI when doing so yields better code.  If that means abusing R13, go for it.
> If it's a sticking point for anyone, just use one of the "optional" registers.
>
> Whatever we do, bury the host and guest side of selftests behind #defines or helpers
> so that there are at most two pieces of code that care which register holds which
> piece of information.
>
> [*] https://lore.kernel.org/all/20240404230247.GU2444378@ls.amr.corp.intel.com
>


