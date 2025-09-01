Return-Path: <linux-kselftest+bounces-40415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D8EB3DE9E
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 11:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233AA16B183
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BEE2FB61A;
	Mon,  1 Sep 2025 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMTI5kSg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324A18E25
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719139; cv=none; b=vEuJWqg2O0Mn+WsSCpypxJvdvoCultB1+vi4b+9NfJwfYOZQXtRCvfw9vlRrmS2Xv39Rew6m2a9UgftWpcKUtvHn02LeSGI0brEp/SnevHoPu3rUY2TvDpopEYrG3nIxdNU5b/mKENyAR0SxmQrX6rCoUmS7zTrmQkrwBL7neLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719139; c=relaxed/simple;
	bh=t+1GdFwvmRUxJ9yFqapVz6n6pbc9RESsrLPzFhkBaUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIYeZgtBTd5s0l47jAcSURS6v93GRCz4nb/L/xIdf2qZpIjKInBGrs6Jhuc2DO3BMA3kfig/T1vXc7gSerc1zlUWNxlwtZnK+SVi/KAFx5MWEjHG/oKWJwUaozz4hv7HIGDGCuaW28qC4cFVJTSdle4Mu1k26NNpHSZOjx5/8Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMTI5kSg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756719137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0CyiHJMde4+JA7nIu8EIckcMpRgflKup3jCqjGGNXb8=;
	b=fMTI5kSgMQ74hroDK4EJnUlGtBjbufcND2trRyhDVRkmT24TZbQy4VCREEug+AGUY5jG3j
	3ZWuwTVwLsGmGAZgIczdgBApWREaDfo6vIoBnyMhqMCRTDYFjKAhPHqw8aIW/Bt5vChNwC
	w/bcUw7VyXcpH7zOqtWWat/oN2LzITM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-SkRyEWe6MGOEsOSd4HrHOA-1; Mon, 01 Sep 2025 05:32:16 -0400
X-MC-Unique: SkRyEWe6MGOEsOSd4HrHOA-1
X-Mimecast-MFC-AGG-ID: SkRyEWe6MGOEsOSd4HrHOA_1756719135
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3d2edf6af18so745680f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Sep 2025 02:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719135; x=1757323935;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CyiHJMde4+JA7nIu8EIckcMpRgflKup3jCqjGGNXb8=;
        b=C3TU7lt3ihC9P4lILA+Qcakw9ZMaHLwCP1Se4UeSfrFu3yMixLM2SBsHXnIkdA/sg+
         O99VGzteSaGbmbCfHla8ts2mFvLcMq97aQBEbSWGytVxEoIoH1CAd2b9mjsvjmWCUYqy
         qb5rYWVS2vE4+WOGEszr9H6VQL0+HWk2oBD454028mxULpu8SbVhHwiFiGNjD4Css/0J
         LbM5jsWIEKWCTHCa96IugVbJUxEfRVeB+G18nZ4nC0S1DnqvrnIj9IbM3TKjOZ8v3dpg
         lx/QejwMRppovWZRSPO5HfNHFyMji9g7I6dZXSbF0gZTYZqakyUAjBTlOmCx/4ho5SWp
         DvTw==
X-Forwarded-Encrypted: i=1; AJvYcCWr7TWxNdPa97YbOGXbCd782xYR6X03PlEYaQoVocFYm9b4ksLtLaSRptwTdWs06o/nouP8U4yLWs4IWyQVzQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQVXNSKxBmpH85NMfnxCH+doEul1wOWPUIwiFTlvcwd/XEYWsq
	YaYTIzVcwxL722DSAkbob/pgGrVM4Fu5GihdFVgJDs3Dwxorg18LIKYmuzMJO75DvvJfC0M4W+V
	58lc/lD5x2iYF7L7YOotseUwJghuUCWWpEp5S3s4XoGVbIhmKRGpdkVv9hKWDYG+l2HBvbQ==
X-Gm-Gg: ASbGncv6PAZKVhU9822CnYLtwQQEGJ+n2Txw62eHwQfSVc+RYwGN+E10Jj7rH5k5iIn
	mFUvq+139yxbXwBFf8DoxrsO23/1Uix4yc7XSMp3PTo9KhKgd2U41DjC3oGVTn6fmBTAI4IqyG8
	muZBw4SCXCX4ET9Nd59vifqXoTU7IFrr12JSmXUhcXINcmcYDDU0uqQvbz28xJUZ8Vhfc3mlEn2
	qgxS05g3qww8DX4O/Ic1IxUTIZ1vUV+IPss3qdrE2NqGHZ2XwSA4Ga6CH33eS8g+duzd5Vgx0tT
	Ze0ghq6Trk3njdntTQIHTN5yV7xc+JmXmfKbv84VJBCXxEZwpzRYRtSrpAUY/DOdxHAuHkhond1
	FjQXY4R1M5qlczOaxJBeogIX0ELpQOWLn+hMNr5QqtMKbXhAyqQ81n3aZ9dTjxwAzy30=
X-Received: by 2002:a05:6000:2408:b0:3d1:61f0:d264 with SMTP id ffacd0b85a97d-3d1e05b8de7mr5930696f8f.54.1756719134120;
        Mon, 01 Sep 2025 02:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbVWUoZyAg1JX17eUAf7Uwo+ahqZ4/AjwAvSEK935UzqpqzJwTEesLyNbMeD6Ijvs4WaOAOw==
X-Received: by 2002:a05:6000:2408:b0:3d1:61f0:d264 with SMTP id ffacd0b85a97d-3d1e05b8de7mr5930604f8f.54.1756719132526;
        Mon, 01 Sep 2025 02:32:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d60cf93cb2sm4808744f8f.12.2025.09.01.02.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:32:12 -0700 (PDT)
Message-ID: <c89a9096-716a-4bbb-a911-99096ff8f0a0@redhat.com>
Date: Mon, 1 Sep 2025 11:32:11 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: directly add pagesize instead of increase
 until page size
To: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20250830023102.14981-1-richard.weiyang@gmail.com>
 <E0C570E7-C4CD-4E41-9590-DDB64757CA2C@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <E0C570E7-C4CD-4E41-9590-DDB64757CA2C@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.08.25 03:32, Zi Yan wrote:
> On 29 Aug 2025, at 22:31, Wei Yang wrote:
> 
>> The check of is_backed_by_folio() is done on each page.
>>
>> Directly move pointer to next page instead of increase one and check if
>> it is page size aligned.
>>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>   tools/testing/selftests/mm/split_huge_page_test.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>> index 10ae65ea032f..7f7016ba4054 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -423,9 +423,8 @@ static void split_pte_mapped_thp(void)
>>
>>   	/* smap does not show THPs after mremap, use kpageflags instead */
>>   	thp_size = 0;
>> -	for (i = 0; i < pagesize * 4; i++)
>> -		if (i % pagesize == 0 &&
>> -		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>> +	for (i = 0; i < pagesize * 4; i += pagesize)
>> +		if (is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>>   			thp_size++;
>>
>>   	if (thp_size != 4)
> 
> It might be better to add
> 
> if (pte_mapped[i] != (char)i)
> 	ksft_exit_fail_msg("%ld byte corrupted\n", i);
> 
> instead to make sure mremap() does not change pte_mapped[] values.

We do have a corruption check later in that function, so I think we can 
just keep it simple here.

So this as is LGTM

Acked-by: David Hildenbrand <david@redhat.com>

As noted, we should just move from mremap() to mprotect() or sth like 
that which has clearer semantics.

-- 
Cheers

David / dhildenb


