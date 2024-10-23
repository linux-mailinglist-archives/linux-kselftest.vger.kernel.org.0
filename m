Return-Path: <linux-kselftest+bounces-20500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28949AD39D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 20:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97702285041
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3481D0420;
	Wed, 23 Oct 2024 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3yF+k+u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E821CBE9A;
	Wed, 23 Oct 2024 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706994; cv=none; b=Dh6t99zDyY5oGNIz69sMWWSgtsj+He6Uj4lMEJ9iCYEVMwbxEZriql8F0HiwqEeVS58n9WlNvz0lc3qc03reBxfWeJXUGGJliIwj2K9LGFvDUyR9WvN/siDF0HuYG9bObIxcJqUiHjZNGtxkgedxMkZajpmOkLQMFk7mTmipVAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706994; c=relaxed/simple;
	bh=2rCl2EkGUq3eQaPQ784zJRGPXTj72TQkCboL00ZG36c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bstZYxNlhub0U+UpFmyYCMJWhm5K5Ty4WDq+8OL2ptBnOd+dBPm1f1uLI/nX88xNUFKSljVDhpUSM/GxABWwRDuNGLMcst64FBqa2h+VdZkZymuYrBz59IGGyg3U53SaxqM9UhdgdndwOtBsPI7S9hyC6HKNTscEJvGl7Ik83/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3yF+k+u; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729706992; x=1761242992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2rCl2EkGUq3eQaPQ784zJRGPXTj72TQkCboL00ZG36c=;
  b=i3yF+k+uBOQmRdjZpBYCL3ImSOEtGsM6G3k3ZWGqlkdlDXgdVlxRW7jj
   MvLA56tLukS58a1y9qj0Gfv4l7ONA4etzChTyZn6emryLwV3ts5z9GLu8
   r9NrQ1jY57vjmlz+VsLbi5I8RsWkj3UiyObfUExZWJzcKEhTaQbKvjuOK
   MhJjfKyEoDGHLer+EmogVNiUINbXTeJX7g9YS/GWE1Piq0ajj5kHXglVM
   VRcjXN5xEKMBQVIO39Jj+qtBCikTMEhIfoGogReQC8OeZrPDhpywrMsWI
   EOAlTyfVHcmXaZ719FvHTsiFZFLsHsfPAiYgZNtcVRgF41RBBhHsWsCBv
   w==;
X-CSE-ConnectionGUID: FcFXP+wOR9GDtlCDjCCprQ==
X-CSE-MsgGUID: 0TTX3j1rQQCxuhTFhJQkwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="32166881"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="32166881"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 11:09:52 -0700
X-CSE-ConnectionGUID: Zinfi+i6Sa6zRiLFIJWmzA==
X-CSE-MsgGUID: C/7rh0eMSamHvy3oTBNjfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80497846"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 11:09:41 -0700
Message-ID: <175dc21f-a4e6-484f-8ee0-ec64c6dfc392@intel.com>
Date: Wed, 23 Oct 2024 21:09:35 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 03/14] KVM: x86: Fix Intel PT Host/Guest mode when
 host tracing also
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 H Peter Anvin <hpa@zytor.com>, Kan Liang <kan.liang@linux.intel.com>,
 Zhenyu Wang <zhenyuw@linux.intel.com>, mizhang@google.com,
 kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20241014105124.24473-1-adrian.hunter@intel.com>
 <20241014105124.24473-4-adrian.hunter@intel.com>
 <Zw1iCMNSI4Lc0mSG@google.com>
 <b29e8ba4-5893-4ca0-b2cc-55d95f2fc968@intel.com>
 <ZxfTOQzcXTBEiXMG@google.com>
 <2a8e6f2c-4284-4218-9b91-af6a4d65e982@intel.com>
 <ZxgnoTKt2IBnBBJ2@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZxgnoTKt2IBnBBJ2@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/10/24 01:30, Sean Christopherson wrote:
> On Tue, Oct 22, 2024, Adrian Hunter wrote:
>> On 22/10/24 19:30, Sean Christopherson wrote:
>>>>> LOL, yeah, this needs to be burned with fire.  It's wildly broken.  So for stable@,
>>>>
>>>> It doesn't seem wildly broken.  Just the VMM passing invalid CPUID
>>>> and KVM not validating it.
>>>
>>> Heh, I agree with "just", but unfortunately "just ... not validating" a large
>>> swath of userspace inputs is pretty widly broken.  More importantly, it's not
>>> easy to fix.  E.g. KVM could require the inputs to exactly match hardware, but
>>> that creates an ABI that I'm not entirely sure is desirable in the long term.
>>
>> Although the CPUID ABI does not really change.  KVM does not support
>> emulating Intel PT, so accepting CPUID that the hardware cannot support
>> seems like a bit of a lie.
> 
> But it's not all or nothing, e.g. KVM should support exposing fewer address ranges
> than are supported by hardware, so that the same virtual CPU model can be run on
> different generations of hardware.
> 
>> Aren't there other features that KVM does not support if the hardware support
>> is not there?
> 
> Many.  But either features are one-off things without configurable properties,
> or KVM does the right thing (usually).  E.g. nested virtualization heavily relies
> on hardware, and has a plethora of knobs, but KVM (usually) honors and validates
> the configuration provided by userspace.
> 
>> To some degree, a testing and debugging feature does not have to be
>> available in 100% of cases because it can still be useful when it is
>> available.
> 
> I don't disagree, but "works on my machine" is how KVM has gotten into so many
> messes with such features.  I also don't necessarily disagree with supporting a
> very limited subset of use cases, but I want such support to come as well-defined
> package with proper guard rails, docs, and ideally tests.

Ok, so how about: leave VMM to choose CPUID, but then map it to what the
hardware actually supports for what is possible.  So the guest user might
not get trace data exactly as expected, or perhaps not at all, but at least
KVM doesn't die.  Then add documentation to explain how it all works.

Note, the number of address ranges is not that much of an issue because
currently all processors that support Intel PT virtualization have 2.

I have a feeling QEMU was targeting compatibility with IceLake, which
would probably work for all processors that support Intel PT virtualization
except for one feature - the maximum number of cycle thresholds (dropped
from 2048 to 16)


