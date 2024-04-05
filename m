Return-Path: <linux-kselftest+bounces-7317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDCB89A5B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 22:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD5BB22650
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 20:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EFA16D32B;
	Fri,  5 Apr 2024 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qVNO4XF2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C426ACF;
	Fri,  5 Apr 2024 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349470; cv=none; b=JlcdWqtfRLYOe0gPTLMulcc0TyJaRLmohzfKp5lRY9C56dETKE6tqaTrh5yBTQD/nmBfprS5jQdcOX3MMMxRPK3hdNZC/ryD0V759evioJ8KTCyqiOmDZwI2CNxwMW9GFEvXxapwqxpWg98b+gniECIa4iUWG5tUTBI7gkLcqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349470; c=relaxed/simple;
	bh=TlGlGuV5AlXVHNKNLj1rE35qkDjG+kSQ0iD+td99z/Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m2PeX0d+SsJs3Px5uofaHCHCKj1G1GQCAPPTBSymlFLouCdZPzxf4sg+mf1ncyRV0SoHp8s6LF53O5ZxYnippOEDG3mITisuvjz7+kuS1fyDqffT2RxlL4uMXf6lnIo/u+NGsh6pX0YSX/5xR3fZkvxvgXkRd0Z4A4aKiYwppxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qVNO4XF2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712349466;
	bh=TlGlGuV5AlXVHNKNLj1rE35qkDjG+kSQ0iD+td99z/Q=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qVNO4XF2L9KqxAGJJaGvGBGCKEVV3bFO4bcRdlwURbu4byJU4Pr+5fIb1uh70Icv0
	 TBHcro1iPw3pXn5WAwTKwHhbPykPnwrmzqlN/EsL1DosoOD/4KQAUhSFMfWPZfJ16n
	 TzNCWuwkaUPd7Nht+4qFZTD4rSsYQMbTNQXCg/ku8xWZcc+62VzI2Lo/ZHXpEbz9f1
	 V3nd16CQCdMDTKlfc1bgWS03OQOaVKaFHxCFXm8AiK8OKOAyGheKPqg2zKYXQ1v3Nk
	 q2HXHtes5qzm1SQYyaxnFgL3aMIWYaO7bC23qm/3E++nvrqMKt5xy3KotiYUWNEYVw
	 Pot7kax3OiiBg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1ACC737813DC;
	Fri,  5 Apr 2024 20:37:35 +0000 (UTC)
Message-ID: <d103fdc2-e7a1-4658-88ab-22929ae48a06@collabora.com>
Date: Sat, 6 Apr 2024 01:38:06 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "kernel@collabora.com" <kernel@collabora.com>, Shuah Khan
 <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 0/2] selftests: Replace "Bail out" with "Error" in
 ksft_exit_fail_msg()
To: "Bird, Tim" <Tim.Bird@sony.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Kees Cook <keescook@chromium.org>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
 <2a77adeb-ed22-4a9b-a1d9-ac5d29ae696d@linuxfoundation.org>
 <SA3PR13MB6372E672EA40B403EBE588EDFD032@SA3PR13MB6372.namprd13.prod.outlook.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <SA3PR13MB6372E672EA40B403EBE588EDFD032@SA3PR13MB6372.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Tim,

On 4/6/24 12:36 AM, Bird, Tim wrote:
> Sorry I didn't catch this on the original submission.
> 
>> -----Original Message-----
>> From: Shuah Khan <skhan@linuxfoundation.org>
>>
>> On 4/5/24 07: 17, Muhammad Usama Anjum wrote: > "Bail out! " is not descriptive. It rather should be: "Failed: " and > then this added prefix
>> doesn't need to be added everywhere. Usually in > the logs, we are searching for "Failed"
>> ZjQcmQRYFpfptBannerStart
>> Caution : This email originated from outside of Sony.
>> Do not click links or open any attachments unless you recognize the sender and know the content is safe. Please report phishing if unsure.
>>
>> ZjQcmQRYFpfptBannerEnd
>> On 4/5/24 07:17, Muhammad Usama Anjum wrote:
>>> "Bail out! " is not descriptive. It rather should be: "Failed: " and
>>> then this added prefix doesn't need to be added everywhere. Usually in
>>> the logs, we are searching for "Failed" or "Error" instead of "Bail
>>> out" so it must be replace.
> 
> Bail out! is the wording in the original TAP spec.  We should not change
> it unless we plan to abandon compatibility with that spec. (which I
> would advise against).
> 
> See https://testanything.org/tap-specification.html
I didn't know that exact words are coming from TAP. Thank you for catching
it. We don't intend to move away from the spec.

> 
> The reason "Bail out!" is preferred (IMO) is that it is less likely to be emitted
> in other test output, and is more 'grepable'.
Makes sense.

> 
> This would get a NAK from me.
Let's drop this series.

>  -- Tim
> 
>>>
>>> Remove Error/Failed prefixes from all usages as well.
>>>
>>> Muhammad Usama Anjum (2):
>>>    selftests: Replace "Bail out" with "Error"
>>>    selftests: Remove Error/Failed prefix from ksft_exit_fail*() usages
>>>
>>>   tools/testing/selftests/exec/load_address.c   |   8 +-
>>>   .../testing/selftests/exec/recursion-depth.c  |  10 +-
>>>   tools/testing/selftests/kselftest.h           |   2 +-
>>>   .../selftests/mm/map_fixed_noreplace.c        |  24 +--
>>>   tools/testing/selftests/mm/map_populate.c     |   2 +-
>>>   tools/testing/selftests/mm/mremap_dontunmap.c |   2 +-
>>>   tools/testing/selftests/mm/pagemap_ioctl.c    | 166 +++++++++---------
>>>   .../selftests/mm/split_huge_page_test.c       |   2 +-
>>>   8 files changed, 108 insertions(+), 108 deletions(-)
>>>
>>
>> Andrew, Kees,
>>
>> I will apply these to linux-kselftest next as a series since these
>> changes depend on change to tools/testing/selftests/kselftest.h
>> and need to go together.
>>
>> Are you okay with that?
>>
>> thanks,
>> -- Shuah
>>
> 

-- 
BR,
Muhammad Usama Anjum

