Return-Path: <linux-kselftest+bounces-40411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5883B3DCD8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 10:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E26188C664
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 08:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A642FB62E;
	Mon,  1 Sep 2025 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGaqpaOt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888032F39C5
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716234; cv=none; b=YA7iFHnzghOs9Yrm53KJS5t6DZOdOnSB6zpABIFhLySomQ3IAzz73Dt4gImB13yc4BsaVbDe4azgk/x09YPDNiaREfIaLFYZKxufOOLPehl4UZreG55Tyr/esAk28ZmBUSYDY+/k3M4JodIhtdHbJD/X63O5yxM9sEwzp8uVoSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716234; c=relaxed/simple;
	bh=Hfqup09ovTUZM5TjUGZo5jcnt/0pJuQ3+lhOSuPNZFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffiCqeDWxhy33uR/Zr/uOdtd9KWN/LeHWHflS9IIsLAxDry3l1e3VJ6DRUPISLL/zWWoQPA7+/njimGPKRWhIcYHE0yECq73SMVgsXaD0FwJVuGMUDLbJfg7yocGTPFM5QdK44V2Jf4xIrd9DvusQZSYajLL3rB2/BpTasqRnnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGaqpaOt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-affc2eb83c5so307023866b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Sep 2025 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756716231; x=1757321031; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyqYxxTqFKLIwYU2In9gt4rvnXEtC8gE8PpkkaZ0VEo=;
        b=eGaqpaOtmqdoBtZdD0lA0qizQiKw03pF6LlKZb/PD5K2AmR5/9aj/IeAAM6mkwONUx
         mVNAlTlcFgKj+ApQQFXDDfikil/i58hsgc2s01KNY3NXS47LgX+aZgJW5TxZNwFRah6a
         7d8oJAEHqvxj2OC6zGakyiolFnaeAYODZValQScC8woGfC3z1utuL2UM1LauOCjtWz9l
         +xM3t+AkSRDW8ASg4iWrCuAeVlZrgtnj15E6dG1OMUh7mccb+VcFZVS0qqnyZhBJs+8B
         LYyIZ99biafuflzVaBDw46KpsPH45DS6y4FSsTl3EFmSS0u9RXbkd3op3PgduvYVwYqf
         ijZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756716231; x=1757321031;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fyqYxxTqFKLIwYU2In9gt4rvnXEtC8gE8PpkkaZ0VEo=;
        b=ap2XDsGxvs4pG2cizMbDSUY7xmHzaQ0w1sTLd08Yk6HYBIohGNCBi/6gCJfc6+N+rB
         EPUCnHVkzPa5rlHcEpH9t4EYW3KlDALzkohKOlCaniP54PRIV8HRG+NmsSHbH55vCTYU
         HjtHwuaLF71s+vwzI5q1TroXsZHHN/DCSYwqcLXV4pee3Zy4tbe21+CyYKe9VMwL5OUe
         jB+h6QfBy8h9cIf82+Iov3+zxMxlVkNrRt+8LjUrLwhIr8cpLMiOy34/7xAmIO4Bo+Fu
         O/pc7ZoTorZ8nQEIJkTDEsM6ml2CXvPYboTyFCH6kTAhJAG7saZO5nGDoIIN4JAaZKMP
         BRbA==
X-Forwarded-Encrypted: i=1; AJvYcCXPwCO7n92H+CKcb03x7buINA3TB//fFAr9cP/t523IAFQ54IDcz4G3qLpIbrr7XhqMGWPo3Qa/E9m1ygcDCWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDnoZ+gVXSvvyrMdpDBtA0AaXy7s3YB/ypLOeFMnRsJ7ODIta
	+0lUxmTXLHtieFv6MNa0RIHMMeFHIjBgqTNqq3eeRMZirDAniSFj3xP5
X-Gm-Gg: ASbGnctQrZ+I3YEy1WuqEgD6tuo20l8ZD2gZX9Zj/j11KmErNpZ9tPk44EbN9zugfjk
	iLHP2hd092o8svdSghVnQEoYld2DDa4LuU+x0+pqUNmqV0aUmeudE0MHG6/K6Vc0EoxDHgDJSAE
	CRu896SMsqKWS9sSvUp4g7JhnlLVrcBFlDmEaFBKc6+u0H8tPmek0S8l2YKTibKNYAxODbEHpr2
	CcSWysdIaw2mjoyz1PFq7snNoxLYZZw740eP4AnjLbwRzGydhMTSahrjyqLVYOmdV7jZww+tVG2
	CQ9oPkSgT7sPB92WVcGzEhwMDwvLHS4nDs7X7qJD9e+Wwzw3IsRnpYL/oFxtVOzHq85DLrdNueE
	GNjJX0gIKbFRNcsQ8Nhje1Gr5d1LT6avKsaFm
X-Google-Smtp-Source: AGHT+IG0dZrINPTvKzcQ808Q1XKK68eFAZ8vAoHXzUBGuo9ws+d6KBK6iPjT9erGsPmK2Vj9TjrUmA==
X-Received: by 2002:a17:907:3da1:b0:afe:e745:c3b with SMTP id a640c23a62f3a-b01d8a33b6bmr593546366b.12.1756716230617;
        Mon, 01 Sep 2025 01:43:50 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0425ce98f1sm234739466b.67.2025.09.01.01.43.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Sep 2025 01:43:50 -0700 (PDT)
Date: Mon, 1 Sep 2025 08:43:49 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
Message-ID: <20250901084349.imkxldwebqzgq3wd@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
 <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Sep 01, 2025 at 09:22:44AM +0200, David Hildenbrand wrote:
>On 31.08.25 04:27, Wei Yang wrote:
>
>Subject: "selftests/mm: verify page content after remapping PMD through PTEs"
>
>> After mremap(), add a check on content to see whether mremap corrupt
>> data.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> 
>> ---
>> v2: add check on content instead of just test backed folio
>
>I'm confused, don't we have that exact check later in the function?
>
>Your v1 might have been better, unless I am missing something.
>

Maybe I should insist a little.

>> ---
>>   tools/testing/selftests/mm/split_huge_page_test.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>> index 10ae65ea032f..229b6dcabece 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -423,10 +423,14 @@ static void split_pte_mapped_thp(void)
>>   	/* smap does not show THPs after mremap, use kpageflags instead */
>>   	thp_size = 0;
>> -	for (i = 0; i < pagesize * 4; i++)
>> +	for (i = 0; i < pagesize * 4; i++) {
>> +		if (pte_mapped[i] != (char)i)
>> +			ksft_exit_fail_msg("%ld byte corrupted\n", i);
>> +
>>   		if (i % pagesize == 0 &&
>>   		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>>   			thp_size++;
>> +	}
>>   	if (thp_size != 4)
>>   		ksft_exit_fail_msg("Some THPs are missing during mremap\n");
>
>I'm a bit confused with this test in general.
>
>We do a
>
>pte_mapped = mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
>
>which I read as a "NOP".
>
>Questions
>
>(a) Will this actually do anything? Also, maybe it does now, but can't the
>kernel just optimize that out in the future?
>
>(b) Is it even guaranteed that we can access > pagesize afterwards? I mean,
>we specify MREMAP_MAYMOVE.
>

To be honest, I am not fully understand the operations here.

>
>I would suggest to just use mprotect/madvise to pte-map a PMD-THP.
>
>This is, of course, independent of this patch.
>
>-- 
>Cheers
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

