Return-Path: <linux-kselftest+bounces-14694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE83B9457B1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 07:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A952528681B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 05:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DB68F47;
	Fri,  2 Aug 2024 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s7i4EskD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0DE2C9D;
	Fri,  2 Aug 2024 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577244; cv=none; b=rbCY08BjGGE8WYLVJ4ixQIhhZAyQb2xoZLsGo/65keKQcZdXBy39ZCNrIx6po3r2LdlGRnnT6TQg37ivoSHZUPBZM4R9g4ljaTVba4PBhHrCS+sae4hVys9ufTlEWzSo3Mp48pS2zM7qC3ohbHxpYsA2WufzWmFL+O7EuufZdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577244; c=relaxed/simple;
	bh=8bF496HAElu6pUjYF0g6318j0lBL8D7rgHjsFK8Eaz0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HXx3PqT3aqr5FClNwowtQQMrFggHE5dxVjLkYFJ3NAn8Dd6PCQIRz+Tuhsa8bUVVmY7cf63yRp2DdtcQIi1902n3thmEWd3l3MFTswDJGqZbNPx+KgbFx2PpQjSxsnyWxovYeVzYet+yHwmkxbott6HBIPV1f4AaPDzC85VyKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s7i4EskD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722577241;
	bh=8bF496HAElu6pUjYF0g6318j0lBL8D7rgHjsFK8Eaz0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=s7i4EskDE5cq1CElDX8X2Gb9VQZNpsEyFkY3OjSBAb6mlQBbO1zT/yU/YHFgD4nWe
	 t9o+ZfQfD0EgPhQQK1ZvbfeSjya77kRJogsGJsIyQg5kqpd8GwmIErv+9/90PuFJnL
	 kqxWWipxg2RIOk9BylPyn1JXndAGHM7/ZR+EQcMieeHLKsCKgXUrMkfJdgvPzizi2C
	 G3H+qS21BAVWqqk7HyHTdb3lYAA3Rv9JEZe4b9mkC4cNXHuO8giPFw8nfFxbl1Wxfy
	 v1lDhQ+6CsGiVOFjFHGor7fx0CM5rHWf6D5DR3XCd+A5/NhvwM+Ouy47wFHzwLTDgn
	 Q9QRaoceeREhQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A510737821AD;
	Fri,  2 Aug 2024 05:40:34 +0000 (UTC)
Message-ID: <c66ab6ff-c9e1-4935-95a5-67e8b83962a3@collabora.com>
Date: Fri, 2 Aug 2024 10:40:01 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Aleksa Sarai <cyphar@cyphar.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: openat2: don't print total number of tests
 and then skip
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240731133951.404933-1-usama.anjum@collabora.com>
 <c1414d9d-61b1-4f92-bc8a-333679362283@linuxfoundation.org>
 <d30aa38c-5dbd-4c18-b20f-a6eb9e9e722b@collabora.com>
 <f560819b-3a3c-4999-ad63-422ca31e9b08@linuxfoundation.org>
 <2e1509f5-2a10-4876-8619-6a6b9c29d269@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <2e1509f5-2a10-4876-8619-6a6b9c29d269@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/1/24 10:27 PM, Shuah Khan wrote:
> On 8/1/24 10:27, Shuah Khan wrote:
>> On 8/1/24 02:42, Muhammad Usama Anjum wrote:
>>> On 7/31/24 9:57 PM, Shuah Khan wrote:
>>>> On 7/31/24 07:39, Muhammad Usama Anjum wrote:
>>>>> Don't print that 88 sub-tests are going to be executed, but then skip.
>>>>> This is against TAP compliance. Instead check pre-requisites first
>>>>> before printing total number of tests.
>>>>
>>>> Does TAP clearly mention this?
>>> Yes from https://testanything.org/tap-version-13-specification.html
>>>
>>> Skipping everything
>>> This listing shows that the entire listing is a skip. No tests were run.
>>>
>>> TAP version 13
>>> 1..0 # skip because English-to-French translator isn't installed
>>
> 
> One more thing on TAP compliance - we don't strive to be TAP compliant
> as it doesn't meet our special needs.
> 
> It is important to keep the how many tests could be run to improve testing
> coverage.
> 
> Refer to: https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
> 
> "The Linux Kernel largely uses TAP output for test results. However, Kernel
> testing frameworks have special needs for test results which don’t align with
> the original TAP specification. Thus, a “Kernel TAP” (KTAP) format is
> specified
> to extend and alter TAP to support these use-cases. This specification
> describes
> the generally accepted format of KTAP as it is currently used in the kernel."
> 
> I appreciate the effort you are putting into improving the reports. I request
> that you refer to the above document and also keep in mind what would help us
> improve our testing over focusing just on reports and compliance.
That makes sense. I'll work on improving the testing going forward.

> 
> thanks,
> -- Shuah
> 

-- 
BR,
Muhammad Usama Anjum

