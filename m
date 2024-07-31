Return-Path: <linux-kselftest+bounces-14507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F349425A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 07:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194121F24DD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 05:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2994A4962C;
	Wed, 31 Jul 2024 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R21wB9dA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C5C8FF;
	Wed, 31 Jul 2024 05:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722402804; cv=none; b=jTiyQ6KsQxJfycDicyKvadIXXJG528DJuAvKmwKVCgboAAlLnT2qas9Ez4BFqvWDPZq7Me5KFt1upnZtQGrZfri4T0cTggdWRp6olf58S1hxckL2skQkzmTi6wQPK0nYH326L24rPtC6ruWkS9R0odcMArP5x4RXrU7vV7q6F4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722402804; c=relaxed/simple;
	bh=SHDWdRlyx+naaM2C48GIB7oHgMnCI1Mn7m4TvH8h5+I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CfdOTc3gtm+KV69A0KdxEl/iSyL+hIq8UI5yyMrIgAl6Qt2fjc0UNe5KfBGXPMdvsjlmzEOo0NedrE7anI+DIHXwZl/fFRAJaiIxzdPT9qakfYdQTLX+RHMiIL7phByM3U0VYVzw/i+DRs1u0y8H5vNfT6Xx6zZT9hP17u1sizI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R21wB9dA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722402800;
	bh=SHDWdRlyx+naaM2C48GIB7oHgMnCI1Mn7m4TvH8h5+I=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=R21wB9dAXqg9a3mvgMWvaUJ4sIMr1F6WnhetN5y5vRy5ofsvb5P8rqbSIiR5X0YrL
	 BWCsKyfGtDx7V0iGFbpkbWloPrRnzc8+B7KDRMldIiJDex1wphqvf1qHjiKepfIQ2V
	 7eUHxbRg1WgSWmp2fJAh/g7D0/O3wdLHGbMK1aacRDh+DzL/N2VBUPvUXZWAfstpy2
	 Eb/JhEPsj2zLz2QdfO3jzmyHcE3b6kJyxlrhjKlvVVJTtC0fyb3W/eUNBnRee+IaGC
	 LZs/ujoFN5oFOdDkrKAaT3Wj/f8qNo+dM31QYYE+JZBO9gMahY+F7bCIm8VILaYhgr
	 lJsQuVlXr6jSg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1A85337811F4;
	Wed, 31 Jul 2024 05:13:17 +0000 (UTC)
Message-ID: <6d903772-2186-4d52-8391-df5ac2682b84@collabora.com>
Date: Wed, 31 Jul 2024 10:13:13 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>,
 Vitor Massaru Iha <vitor@massaru.org>
Subject: Re: [PATCH] selftests: user: remove user suite
To: Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725110817.659099-1-usama.anjum@collabora.com>
 <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
 <16f14d1a-56f2-4c2c-8180-74ad9bee0182@linuxfoundation.org>
 <5B0BBE86-C3F3-4CA3-87F5-49F0DB1B28EE@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <5B0BBE86-C3F3-4CA3-87F5-49F0DB1B28EE@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/24 7:33 AM, Kees Cook wrote:
> 
> 
> On July 30, 2024 3:36:11 PM PDT, Shuah Khan <skhan@linuxfoundation.org> wrote:
>> On 7/25/24 08:44, Shuah Khan wrote:
>>> On 7/25/24 05:08, Muhammad Usama Anjum wrote:
>>>> The user test suite has only one test, test_user_copy which loads
>>>> test_user_copy module for testing. But test_user_copy module has already
>>>> been converted to kunit (see fixes). Hence remove the entire suite.
>>>>
>>>> Fixes: cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")
>>>
>>> Remove fixes tag - this isn't a fix and we don't want this propagating
>>> to stable releases without kunit test for this.
>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>
>>> Thanks,
>>> -- Shuah
>>>
>>
>> As mentioned in other threads on this conversion to kunit and removal
>> of kselfttest - NACK on this patch.
>>
>> Please don't send me any more of these conversion and removal patches.
>>
> 
> I think there is a misunderstanding about these particular patches (for string and usercopy selftests). Those were already converted, as desired, by the maintainer (me) to KUnit. These associated patches are cleaning up the dangling kselftest part of them, and should land (with the Fixes tag, which is aimed at the commit that did the conversion).
Yes, this is misunderstanding and these patches should be taken to remove
dead tests in kselftests as their corresponding test modules have been
moved already. So these patches are fixes.

> 
> -Kees
> 
> 

-- 
BR,
Muhammad Usama Anjum

