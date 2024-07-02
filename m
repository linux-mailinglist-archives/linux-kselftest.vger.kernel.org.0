Return-Path: <linux-kselftest+bounces-13051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6206E923B37
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 12:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206C4282134
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BD4157493;
	Tue,  2 Jul 2024 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GNR+DIhe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06E12CD8B;
	Tue,  2 Jul 2024 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915496; cv=none; b=uYH7QIUDZlz+Sn4uz2b2655pC6fa1OEhI1gdVyH9HSdN997PItIt05PJbp+tRZKr1BYXeYf6kM2lg2jRrdFp11Ove9Gjtj9LjFCiXrjPku3udQvrZeyB0EL93iFo9I9h5Oa8SlUj4+UAyU0jzxh/HYPQJmT/zA0mPmNGlU0FmvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915496; c=relaxed/simple;
	bh=BkT4rWQ3OfnksBriWFGbdeSNo8U96033Ydeq12RMW2A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E9CBV8yS6v4rxnqXVeUs+DSXNpszEwiRamT+HH7FgNievBa9I4mfHsZ+Hz7z/RofI2r99QFmIj3xpNJ8j6c0Gku/ODu58CM7G1/6/RJfMv/6hxOasGDB+DND702HgCnDzTKSyN1RwR5/W8BqvNWzj5hnrptQ42C/cQzsrBISWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GNR+DIhe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719915493;
	bh=BkT4rWQ3OfnksBriWFGbdeSNo8U96033Ydeq12RMW2A=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=GNR+DIhea/jWN8FskA19elRIHHjiMWmoKv2chfAkQ9LtF8SzDMI8Fl4vefnD8Gsne
	 loNCWJ/+iLjARnyOuR0eIGjJqgaWOWk/qS5cTpIzjjdIRj2XuE9KbUPFM31HCEn+H9
	 uKYXGnhTQrJYjtGwYXOgXhf6mSry5Ktg+N+SU4b1Cwc9vx6qf/YbmIFdoDQvpfyUqJ
	 khor/Iz2XJG0FbfoZ8Hc179ikdashKh80XAUhgTInWt17STlyqgvZdnJsMrxS5DsWC
	 OyDn/4Qy3YX0SoM/MRAwMKBVGBOHiUGVqm7KrRbG3HKd7PcinFGtMFXBl0UPGkZzt4
	 Y5vKb8o9pe45A==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C379C3782194;
	Tue,  2 Jul 2024 10:18:04 +0000 (UTC)
Message-ID: <23db41bb-1f3b-4b7b-95ac-960b8775a062@collabora.com>
Date: Tue, 2 Jul 2024 15:17:59 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 0/4] selftest: x86: conform tests to TAP format output
To: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20240414131807.2253344-1-usama.anjum@collabora.com>
 <dd277b6b-b28e-4860-b285-e89fd5fd3d41@collabora.com>
 <90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org>
 <386da8e3-1559-4ec2-9a66-f5f3f6405a2b@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <386da8e3-1559-4ec2-9a66-f5f3f6405a2b@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/10/24 10:19 AM, Muhammad Usama Anjum wrote:
> Adding Borislav, Dave and x86 mailing list:
> 	Please review the series.
Kind reminder

> 
> On 6/8/24 1:52 AM, Shuah Khan wrote:
>> On 5/27/24 23:04, Muhammad Usama Anjum wrote:
>>> Kind reminder
>>>
>>> On 4/14/24 6:18 PM, Muhammad Usama Anjum wrote:
>>>> In this series, 4 tests are being conformed to TAP.
>>>>
>>>> Muhammad Usama Anjum (4):
>>>>    selftests: x86: check_initial_reg_state: conform test to TAP format
>>>>      output
>>>>    selftests: x86: corrupt_xstate_header: conform test to TAP format
>>>>      output
>>>>    selftests: fsgsbase_restore: conform test to TAP format output
>>>>    selftests: entry_from_vm86: conform test to TAP format output
>>>>
>>>>   .../selftests/x86/check_initial_reg_state.c   |  24 ++--
>>>>   .../selftests/x86/corrupt_xstate_header.c     |  30 +++--
>>>>   tools/testing/selftests/x86/entry_from_vm86.c | 109 ++++++++--------
>>>>   .../testing/selftests/x86/fsgsbase_restore.c  | 117 +++++++++---------
>>>>   4 files changed, 139 insertions(+), 141 deletions(-)
>>>>
>>>
>>
>> These patches usually go through x86 repo to avoid merge conflicts.
>>
>> I need ack from x86 maintainers to take these. I don't see x86 list
>> cc'ed.
>>
>> Please make sure to include everybody on these threads to get quicker
>> response.
> It seems like selftests/x86 path is missing from Maintainers file and it
> causes these issues. I'll look at fixing it.
> 
>>
>> thanks,
>> -- Shuah
>>
>>
> 

-- 
BR,
Muhammad Usama Anjum

