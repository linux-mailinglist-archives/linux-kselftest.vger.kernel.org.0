Return-Path: <linux-kselftest+bounces-14350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A8693EE53
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7190E1C211C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 07:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28748002A;
	Mon, 29 Jul 2024 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zO/PJJfK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698E6A8DB;
	Mon, 29 Jul 2024 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237533; cv=none; b=CZWoNYXS2UdOXJ/zPvQaDzkblAGVkOI9eyh8cKSnCH8rduQIJPlKMGlUNwa/AjiHOAgs1oIM6CdPYvcYMen+H8uZKyBEgxi9UbkE1ggkEpzytfGCoINn2h7GwpQffKsf7MWxFWHPE8K5KX/03mtflMJfxmt2a29/iQSVnCuWyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237533; c=relaxed/simple;
	bh=z6KHZK1xSxvXcOyG2UkjvdCIgxXb9wTAErDgrylYw+0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fckj72aaT7HsjbBh8BpDsv5ZEzj01nacXRXjW4aeJff1vSO3Do7CihIOiRnYUFiNaiqm8EGXkvGtZ/JOvlWVRpsVmfSwE7zNJNQJ6G1cl2IbFD/XmAf2XUsyGv3mugyhzvF04KTkSr4ZdUc7hVbVov0ge0ylu742FPpL3MF2zAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zO/PJJfK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722237530;
	bh=z6KHZK1xSxvXcOyG2UkjvdCIgxXb9wTAErDgrylYw+0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=zO/PJJfKXuvoUn6t7QG53vXVDj5Y9+4Trfbn8LxK5qNHb3JEqecWo27a65zGI8GBa
	 g/T+AOJNVtjGsOAWmQ93XhnaqMOPnOeujLT++Hhrib2EMkqS47n7RknrozApCUVwTv
	 7j1JILaN8QxohbXO6dKmoPgEnD3Mcs7lMAzhGvlOOmqH3Yj5TnlfeLE39i1T1m+Xw+
	 4z2RvUmdN2Bi8khEm6RB5u2d3AYwQFxuNq4/N3Oq5uO3wE91BjAyKJUvMuNI3zbtE9
	 PV4msL8MtJgylFxSply9swegAPmDuhgCofteIUA6OG9AukJttBxvJN/2d5PcQ1c0Hr
	 sImH4IUgxy9Xw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4D0CF3781480;
	Mon, 29 Jul 2024 07:18:48 +0000 (UTC)
Message-ID: <e5472489-f430-46f2-b9ef-bc625242e8d6@collabora.com>
Date: Mon, 29 Jul 2024 12:18:44 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: user: remove user suite
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Kees Cook <kees@kernel.org>, David Gow <davidgow@google.com>,
 Vitor Massaru Iha <vitor@massaru.org>
References: <20240725110817.659099-1-usama.anjum@collabora.com>
 <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
 <01d804a2-3370-44ec-af99-c21af5df0bde@collabora.com>
 <cd028a09-c6e2-4c54-82ac-04fe1aa2d20c@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <cd028a09-c6e2-4c54-82ac-04fe1aa2d20c@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/24 10:19 PM, Shuah Khan wrote:
> On 7/26/24 02:16, Muhammad Usama Anjum wrote:
>> On 7/25/24 7:44 PM, Shuah Khan wrote:
>>> On 7/25/24 05:08, Muhammad Usama Anjum wrote:
>>>> The user test suite has only one test, test_user_copy which loads
>>>> test_user_copy module for testing. But test_user_copy module has already
>>>> been converted to kunit (see fixes). Hence remove the entire suite.
>>>>
>>>> Fixes: cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")
>>>
>>> Remove fixes tag - this isn't a fix and we don't want this propagating
>>> to stable releases without kunit test for this.
>> The user test suite has been failing since cf6219ee889f as the test module
>> wasn't found. So this is fixing the failure of kselftest. It just causes
>> noise and may mask other failures. If you still think that fixes isn't
>> needed, I can send a new version by removing the fixes tag.
>>
> 
> In which case this information should have been part of the change log to
> make it clear this is a fix.
Sorry, I should have mentioned explicitly. Please let me know if I should
send another version for this and the other patch for acceptance [1]?

> Fixes tag should also mention the releases
> this is applicable to so this patch doesn't make it to stables releases
> without cf6219ee889f - so this test still runs.
Release tag is unnecessary as the fix can be applied easily to fixes
commit. From stable-kernel-rules:

  Note, such tagging is unnecessary if the stable team can derive the
  appropriate versions from Fixes: tags.

> 
> If you are adding Fixes tag it should mention the releases this is
> applicable to. Can you get me that information?
> 
> thanks,
> -- Shuah
> 
> 

[1]
https://lore.kernel.org/all/20240725121212.808206-1-usama.anjum@collabora.com

-- 
BR,
Muhammad Usama Anjum

