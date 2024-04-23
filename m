Return-Path: <linux-kselftest+bounces-8666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC31E8AE02B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FA51C2270E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A8C56B95;
	Tue, 23 Apr 2024 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nrXmo/ZS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F7656B6C;
	Tue, 23 Apr 2024 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861874; cv=none; b=OydYdb5KQuq3vnQ3VVrAvoZgqgVczJqk2PC86cFd14G9FqrYDFUHE7DyBcD6FwMiYKXwGu9xA/jRXTOYgH5VULLjBye5+L/wuGUWJPFOOk2dtgS0tQphZRH3JZ8KNt035f4RebK5K3fijv22ZsLG1zm17/43KBHYCWFCIru6JX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861874; c=relaxed/simple;
	bh=jdsWPAe/3j9MrIf+j6Di+jr1djPe2ZWvG4ZRKncHSZw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J+IyhE2sCnYB7A3vBN6ox1wsVfx3muZZ4TtoYr28JJHUZiwMfq1KMJwowK4qlNpxzG0er2gONa+q3jqsyvqKn0HAiZ/9JedoSyXMQ542Jtfw6b1c1nGNBHHh8DNZRW/uhS73OUu96mAvFkBxIR5XnUP5/hHKf9vFW9vwfD2jt10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nrXmo/ZS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713861870;
	bh=jdsWPAe/3j9MrIf+j6Di+jr1djPe2ZWvG4ZRKncHSZw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=nrXmo/ZS8hSxgaHZp775l+2tsr1u0AKR1FBzyAeNOAHkxniKvx4afpIYlmCKRCzNS
	 gif67zp9wHteIi/soXRfikZnU754o+FdB2N/T48RDzpEtNb4V58afnB5DWvsN/26sK
	 a3HFSKNAMvX5Kq/+Uyn4r5Ypwqd6kHFkwD+k6Yvchrnk6+BC0SN/bQisu52M+4AChF
	 cba/VP+MBV6PdWD6rmPdfC6TiTL/LPuORWQOy3us320eNpf1Kxn9o6bTTl6MJ3EEiF
	 SzkAzumMb56+fLrvXRSnDoJ7t8zm/TO0J4OqCKaH0JAn8VE463+2DyXesr3R8IkDpB
	 9HFSp7bWGcTGQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 705E337820AB;
	Tue, 23 Apr 2024 08:44:26 +0000 (UTC)
Message-ID: <e1d6b5ea-5816-433d-8c61-602c42ee204d@collabora.com>
Date: Tue, 23 Apr 2024 13:44:54 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 5/5] selftests/mm: soft-dirty should fail if a testcase
 fails
To: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand
 <david@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Shivansh Vij <shivanshvij@outlook.com>
References: <20240419074344.2643212-1-ryan.roberts@arm.com>
 <20240419074344.2643212-6-ryan.roberts@arm.com>
 <aaeb2611-e096-475c-9055-4e8dd9509b01@redhat.com>
 <6a08436e-c984-43aa-bbfa-05cfea34516a@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <6a08436e-c984-43aa-bbfa-05cfea34516a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/23/24 1:24 PM, Ryan Roberts wrote:
> On 22/04/2024 10:33, David Hildenbrand wrote:
>> On 19.04.24 09:43, Ryan Roberts wrote:
>>> Previously soft-dirty was unconditionally exiting with success, even if
>>> one of it's testcases failed. Let's fix that so that failure can be
>>> reported to automated systems properly.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

>>> ---
>>>   tools/testing/selftests/mm/soft-dirty.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/soft-dirty.c
>>> b/tools/testing/selftests/mm/soft-dirty.c
>>> index 7dbfa53d93a0..bdfa5d085f00 100644
>>> --- a/tools/testing/selftests/mm/soft-dirty.c
>>> +++ b/tools/testing/selftests/mm/soft-dirty.c
>>> @@ -209,5 +209,5 @@ int main(int argc, char **argv)
>>>
>>>       close(pagemap_fd);
>>>
>>> -    return ksft_exit_pass();
>>> +    ksft_finished();
>>>   }
>>> -- 
>>> 2.25.1
>>>
>>
>> Guess that makes sense independent of all the other stuff?
> 
> Yes definitely. What's the process here? Do I need to re-post as a stand-alone
> patch? Or perhaps, Shuah, you could take this into your tree as is?
She can. But if she misses it or you want to post v2 of this current
series, you can just send this one separately. Usually I try to send
separate patches for trivial and discussion required patches so that there
isn't confusion of this kind.

> 
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> Thanks!
> 
> 
> 

-- 
BR,
Muhammad Usama Anjum

