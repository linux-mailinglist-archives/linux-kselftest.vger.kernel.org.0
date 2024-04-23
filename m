Return-Path: <linux-kselftest+bounces-8664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2758ADFA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D180FB244F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 08:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F3C535A8;
	Tue, 23 Apr 2024 08:24:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9318F52F81;
	Tue, 23 Apr 2024 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860654; cv=none; b=jSZoSbexwXFF8U+Ins0H7A6oUqp8Vj0HdcCX5QwT09lZtMrKWHOiS6e8hgB5/hl8ZuLwSDuzvTIU/qcEA0Tg0h2ppSEuqfva02it3yuXDe6u/kNDJmlBkZh19CUHjg98/Ah6vIEqR+g4TBHf+vDWff3A5xZVZ4QiF/vXpQabLSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860654; c=relaxed/simple;
	bh=Jk8P2vOPHvPCTlKyKlyssSpn7FP34vOCJY4ibe+dYCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIJ+HiFtmIw0IFbRluU8qN0SyII8eisHWWWS535eh0cx19yClolxElymNbR+s3tHDwNRczcslMzL2PJWPQpsUZlWN54YaNogeR485s5pvPSvKKEd6KBUonRY8TrqvZboG5eb72AtEagv0YbL832OxvyyJcgGy5EZSFXvRwKfQVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 739BA339;
	Tue, 23 Apr 2024 01:24:34 -0700 (PDT)
Received: from [10.57.74.127] (unknown [10.57.74.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A872B3F64C;
	Tue, 23 Apr 2024 01:24:03 -0700 (PDT)
Message-ID: <6a08436e-c984-43aa-bbfa-05cfea34516a@arm.com>
Date: Tue, 23 Apr 2024 09:24:02 +0100
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
To: David Hildenbrand <david@redhat.com>,
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aaeb2611-e096-475c-9055-4e8dd9509b01@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/04/2024 10:33, David Hildenbrand wrote:
> On 19.04.24 09:43, Ryan Roberts wrote:
>> Previously soft-dirty was unconditionally exiting with success, even if
>> one of it's testcases failed. Let's fix that so that failure can be
>> reported to automated systems properly.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   tools/testing/selftests/mm/soft-dirty.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/soft-dirty.c
>> b/tools/testing/selftests/mm/soft-dirty.c
>> index 7dbfa53d93a0..bdfa5d085f00 100644
>> --- a/tools/testing/selftests/mm/soft-dirty.c
>> +++ b/tools/testing/selftests/mm/soft-dirty.c
>> @@ -209,5 +209,5 @@ int main(int argc, char **argv)
>>
>>       close(pagemap_fd);
>>
>> -    return ksft_exit_pass();
>> +    ksft_finished();
>>   }
>> -- 
>> 2.25.1
>>
> 
> Guess that makes sense independent of all the other stuff?

Yes definitely. What's the process here? Do I need to re-post as a stand-alone
patch? Or perhaps, Shuah, you could take this into your tree as is?

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!



