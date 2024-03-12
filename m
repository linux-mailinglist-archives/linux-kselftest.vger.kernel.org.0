Return-Path: <linux-kselftest+bounces-6255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BE08790ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 10:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82CE28747A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A177F25;
	Tue, 12 Mar 2024 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="anD0IdeB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86E77F1F;
	Tue, 12 Mar 2024 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235567; cv=none; b=lbXOkyrNptdNZYfAHyENtJVFf1qotS1/no3qUT2e9U0bgp7Abve2vVbEynJ35lwYP5paeBbt/Mthzkj1DtGJyt2c4VxBoOAxH0pRuiRn2nZqss3CSzy45N3iWbTWdwi8dh1yFz6QHr5h8vk6m7KHgjBEb9wI2vQbcziy6piN3is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235567; c=relaxed/simple;
	bh=VOtzu6pnO41S5DBKsXuajblcmv55uls1zQ2De8lxwX0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ro7r5aOLVss8kC01GMnDUGnEJcnxQYes3VVQMWrBjvAtiynlCr/M8M3HbF32oWoV49XUlCqg9F2oGfKs154rjqsrneH0x998htu2w/qNzEe99e6+PukMfZOYhJyGLptOfAwCCDlCCgrW2pMHkFGpQvdlCAceVyUJOppU8vd5x0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=anD0IdeB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710235561;
	bh=VOtzu6pnO41S5DBKsXuajblcmv55uls1zQ2De8lxwX0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=anD0IdeBLPsxG57xpu6JZ4TNAnII+7jyzSn6jWmHbUnQeReMUfAjI22pIngvwTqGy
	 o/mSmGfeEVMt4u8k8gE4Z/HPzAJ1vhaOOqZ6A8fEONkBj7ebhf+mHJwzOzmI1GTzVk
	 P5lC/zpJckI8YnbmAn7bRgyYDHVufx7z/xO3F0wPl4vWyw8YtVHultlWqEkQwAn7T6
	 gYWiWQKOcp3c5A+MCfxPwdgmvfksT1knCjWrO9gqWbWTAqFefIRVggXF78IyNt2KoV
	 NzOWOoekI/eQIbABuPTLuWWzzfM3oqX53Q22AUgYaoft7cd7C1dVpEYL9cHF+ZfTUs
	 j2PVZ+N7w/2Rg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1016B37813E5;
	Tue, 12 Mar 2024 09:25:57 +0000 (UTC)
Message-ID: <21f8dbe3-9de2-41ad-a8bd-61d66cb38e90@collabora.com>
Date: Tue, 12 Mar 2024 14:26:28 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
To: "Chang S. Bae" <chang.seok.bae@intel.com>, Shuah Khan <shuah@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Weihong Zhang <weihong.zhang@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, angquan yu <angquan21@gmail.com>
References: <20240307183730.2858264-1-usama.anjum@collabora.com>
 <dc8d122a-22b7-4d17-abd9-66262af0b058@intel.com>
 <c3362840-365e-40cb-80fe-895aa2d979ec@collabora.com>
 <1cacbd08-1131-4be4-b318-58c05afda2de@intel.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <1cacbd08-1131-4be4-b318-58c05afda2de@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/11/24 10:39 PM, Chang S. Bae wrote:
> On 3/11/2024 10:02 AM, Muhammad Usama Anjum wrote:
>> On 3/9/24 6:06 AM, Chang S. Bae wrote:
>>> On 3/7/2024 10:37 AM, Muhammad Usama Anjum wrote:
>>>
>>>> -static void check_cpuid_xtiledata(void)
>>>> +static int check_cpuid_xtiledata(void)
>>>>    {
>>>>        uint32_t eax, ebx, ecx, edx;
>>>>    @@ -153,12 +160,16 @@ static void check_cpuid_xtiledata(void)
>>>>         * eax: XTILEDATA state component size
>>>>         * ebx: XTILEDATA state component offset in user buffer
>>>>         */
>>>> -    if (!eax || !ebx)
>>>> -        fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
>>>> -                eax, ebx);
>>>> +    if (!eax || !ebx) {
>>>> +        ksft_print_msg("xstate cpuid: invalid tile data size/offset:
>>>> %d/%d\n",
>>>> +                   eax, ebx);
>>>> +        return -1;
>>>> +    }
>>>>          xtiledata.size          = eax;
>>>>        xtiledata.xbuf_offset = ebx;
>>>> +
>>>> +    return 0;
>>>>    }
>>>
>>> I don't think it is okay to silently skip the test here. If the feature is
>>> available, the tile data size and offset should not be zero.
>> We are logging that data size/offset are invalid if either eax or ebx are
>> invalid and then we are skipping. Not sure what you are asking me to change.
> 
> You intention seems to skip the test when AMX is not available. 
Yes,

> But this
> function should only be invoked when AMX is actually available, not as part
> of the feature availability check. 
How can we check if AMX is available or not?

> Therefore, I think this change is not
> relevant. Also, if we encounter invalid TILEDATA CPUID, it should be a
> reason to *fail* the test, rather than calling out a skip, right?
I see. But once we check if AMX is available.

> 
> Thanks,
> Chang
> 

-- 
BR,
Muhammad Usama Anjum

