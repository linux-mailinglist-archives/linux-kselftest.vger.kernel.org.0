Return-Path: <linux-kselftest+bounces-8762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B18B077F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 12:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52891C221EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30952159579;
	Wed, 24 Apr 2024 10:40:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B142A15921D;
	Wed, 24 Apr 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955213; cv=none; b=DiM7OK/nCoUyr/lXLyfr7UxWssrgZibq0C4UaTsMFNS2bJ/Z4Soa6K8VQ2gCA5kikCH4RNvcJV6HT4i+hw3fcCRxMur2P3CiBqbM0kriCbuC/3zKY5XuViNL6gNfqWn8rh3R4y9xvDe3rFcziaqVQHSCEkPvYP/ZP/reNJkjia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955213; c=relaxed/simple;
	bh=X4SRxIGKm5AoohF2nk+YEs1df8CVMox+kXQ7mvA7pNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oO0b/Q60eX/7HctyyDKGYoCja3mNBDjG8bVUPT76xX1rcF3D2kmKwwgBUz8+XA1SPZAGZUVhVgjNCePh5DoP/hFXW+D0ehNow0v74JDtLIqUPQjhC1/Z2BIDFLh4M+V74Xiy9xB9CxfqKYdDhSan1Z0WTyXMLYnSOBBuzQrJIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D54B2339;
	Wed, 24 Apr 2024 03:40:38 -0700 (PDT)
Received: from [10.1.25.156] (unknown [10.1.25.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 647B53F73F;
	Wed, 24 Apr 2024 03:40:09 -0700 (PDT)
Message-ID: <b05f9474-60a7-491c-a79f-752a3967ad0e@arm.com>
Date: Wed, 24 Apr 2024 11:40:08 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] selftests/mm: soft-dirty should fail if a testcase
 fails
Content-Language: en-GB
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Shivansh Vij <shivanshvij@outlook.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20240419074344.2643212-1-ryan.roberts@arm.com>
 <20240419074344.2643212-6-ryan.roberts@arm.com>
 <aaeb2611-e096-475c-9055-4e8dd9509b01@redhat.com>
 <6a08436e-c984-43aa-bbfa-05cfea34516a@arm.com>
 <e1d6b5ea-5816-433d-8c61-602c42ee204d@collabora.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e1d6b5ea-5816-433d-8c61-602c42ee204d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/04/2024 09:44, Muhammad Usama Anjum wrote:
> On 4/23/24 1:24 PM, Ryan Roberts wrote:
>> On 22/04/2024 10:33, David Hildenbrand wrote:
>>> On 19.04.24 09:43, Ryan Roberts wrote:
>>>> Previously soft-dirty was unconditionally exiting with success, even if
>>>> one of it's testcases failed. Let's fix that so that failure can be
>>>> reported to automated systems properly.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Thanks!

> 
>>>> ---
>>>>   tools/testing/selftests/mm/soft-dirty.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/soft-dirty.c
>>>> b/tools/testing/selftests/mm/soft-dirty.c
>>>> index 7dbfa53d93a0..bdfa5d085f00 100644
>>>> --- a/tools/testing/selftests/mm/soft-dirty.c
>>>> +++ b/tools/testing/selftests/mm/soft-dirty.c
>>>> @@ -209,5 +209,5 @@ int main(int argc, char **argv)
>>>>
>>>>       close(pagemap_fd);
>>>>
>>>> -    return ksft_exit_pass();
>>>> +    ksft_finished();
>>>>   }
>>>> -- 
>>>> 2.25.1
>>>>
>>>
>>> Guess that makes sense independent of all the other stuff?
>>
>> Yes definitely. What's the process here? Do I need to re-post as a stand-alone
>> patch? Or perhaps, Shuah, you could take this into your tree as is?
> She can. But if she misses it or you want to post v2 of this current
> series, you can just send this one separately. Usually I try to send
> separate patches for trivial and discussion required patches so that there
> isn't confusion of this kind.

Thanks - I'll do that.

> 
>>
>>>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>
>> Thanks!
>>
>>
>>
> 


