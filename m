Return-Path: <linux-kselftest+bounces-6281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF528879A9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 18:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9703BB2212C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2CC1384A4;
	Tue, 12 Mar 2024 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NCikJTpz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790EA137C47;
	Tue, 12 Mar 2024 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264514; cv=none; b=YAZk55W5eUUhiCQ8+m7IK0CEHN/zWeXZqdB1ZXDuTordix+PBxfVb5Vh7IBlEMj+ilPhgt85fUIg4HKPeRHA3jsYIH8xzEO0lTwn2CMlGxDD5k/gWM8HQuK77lbiuh2egoaj8BB86b9cAGUtoH1HWawA+7lWaUiUmCEBFAJ0qfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264514; c=relaxed/simple;
	bh=VY8Z9b0yJZ4F5uQ55cm9ifujn/axpTeq3PPcZaMOhwc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X1rHMwFbFSfOoWURb2VlrB/CeWNMtvtXAP9h9WLo4EWO1TuQ74R8JCQjpkc+XjV9Gs4TEi7E6sFvfb3asmNb8oXZUw4O7ZgRooRxSYwGGZJkiLbNk1zlDKgrci+SeR3OjpRAPjAtY5GD5SeKQXk2ISL/dtwhydMovtx26Nyjh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NCikJTpz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710264509;
	bh=VY8Z9b0yJZ4F5uQ55cm9ifujn/axpTeq3PPcZaMOhwc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=NCikJTpzKiqKdXCicrRsLJD+jsiJSPOTOjyArAXIB3o7llCn8WFC/WC3xH3tapkIs
	 I/l7gDgJk8dnec8pzFSqXdE1VD2pebXttU0PVoHzZwhSgpmG4o4jHwZ/TLH+YfQSe4
	 qcb5MGNtvlKk+ylXmF5AdwTYsMLjomPVzuyqQz+mpI+NnOU4YbU59Ohu+NKwLHv5Do
	 wnRFRV2tyRbiciOl4DmfZrDUeTc5T2BEx9eUxpcWAPN7j6eD7I/CaS5MmWxTrrF930
	 JAI5SLnBNgxw0fdq2Mfe5fznlHvXyR+QBbduPQ+67EHhJ6Yq/L6af3BJWY/T8ah8UT
	 bEBTx/4itQxjg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4BF01378204B;
	Tue, 12 Mar 2024 17:28:26 +0000 (UTC)
Message-ID: <9bab8e19-962b-416f-b8d9-b113fc4813f7@collabora.com>
Date: Tue, 12 Mar 2024 22:28:56 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Weihong Zhang <weihong.zhang@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, angquan yu <angquan21@gmail.com>
Subject: Re: [PATCH] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
Content-Language: en-US
To: "Chang S. Bae" <chang.seok.bae@intel.com>
References: <20240307183730.2858264-1-usama.anjum@collabora.com>
 <dc8d122a-22b7-4d17-abd9-66262af0b058@intel.com>
 <c3362840-365e-40cb-80fe-895aa2d979ec@collabora.com>
 <1cacbd08-1131-4be4-b318-58c05afda2de@intel.com>
 <21f8dbe3-9de2-41ad-a8bd-61d66cb38e90@collabora.com>
 <ad272dc1-1b85-41ef-8454-4888a5ab95ee@intel.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ad272dc1-1b85-41ef-8454-4888a5ab95ee@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Chang,

On 3/12/24 9:07 PM, Chang S. Bae wrote:
> On 3/12/2024 2:26 AM, Muhammad Usama Anjum wrote:
>>
>> How can we check if AMX is available or not?
> 
> After a successful check_cpuid_xsave(), examining CPUID(eax=0xd, ecx=0)
> EDX: EAX, which reports the support bits of XCR0, can give assurance of AMX
> availability. Perhaps, this change is considerable on top of your patch:
> 
> static int check_cpuid_xtiledata(void)
> {
>         uint32_t eax, ebx, ecx, edx;
> +       uint64_t xfeatures;
> 
>         __cpuid_count(CPUID_LEAF_XSTATE, CPUID_SUBLEAF_XSTATE_USER,
>                       eax, ebx, ecx, edx);
> 
> +       xfeatures = eax + ((uint64_t)edx << 32);
> +       if ((xfeatures & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
> +               ksft_print_msg("no AMX support\n");
> +               return -1;
> +       }
Now I understand. I'll use this snippet to skip the test and fail the test
if eax and ebx are zero. Sorry, I've lesser knowledge on the x86's
extensions side. I'll build up the knowledge.

> 
> Nevertheless, I still believe that using arch_prctl(ARCH_GET_XCOMP_SUPP,
> ..) remains a simple and legitimate approach for directly checking dynamic
> feature support from the kernel: https://docs.kernel.org/arch/x86/xstate.html
I'll use arch_prtcl in another patch on top of the current patch in v2.

> 
> Thanks,
> Chang
> 

-- 
BR,
Muhammad Usama Anjum

