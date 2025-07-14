Return-Path: <linux-kselftest+bounces-37263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67754B04219
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 16:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09214A2F6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2640415B0EC;
	Mon, 14 Jul 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKHfk9Gj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE6EAD7
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504369; cv=none; b=Tn5ioKA3CysD+8eQGnvhDF4AULJ/l/pHlufLYXJWi0nt5Vthd+3zw8z3nsz5hKiDIE4atYj6aALRV+DNTrW+JWh5Suf0TSP1PMfaZdwZ45uuISyZ3a+vXCneFo1FBEHpX8o+TuutQe2DbOWIOShxGyIrxtMUVCeV4xW3kpRta1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504369; c=relaxed/simple;
	bh=He2uz5sBbuDQkUiB/RFIploS3A4kVN6JkXe5PzPkJh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9YPChasziNmE//n8oQYgYD0zURC6M84Be473smI2xTsLfiLfTkNp32bBDGeyHO4jxDeOHCOp1OJVkITJSSohhIOwmAZaOOz2VgfJG7xkNcIJUd8Pm7JrRgsy7hox/K4ZpXbIsLvTdcykE64kkVj8XP+hkKC268GmYML9Mkhp3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKHfk9Gj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752504366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFvWUbvYOMPAFeZVSRMsNONk4G4QFR5pZQmr1EAVpzU=;
	b=TKHfk9Gj9JQWmVvuT5xx3NNRTm2H61j3X7UgHgzeP8UyZS74jpKuYfjW7I1r3wYqrw09tU
	VGc0aLIsBNq4HZRmadNPDCIY/LNfEwpdGH3YqqNPWqXTi8noktfYG7h90c4fqpq9KzLzm2
	PoC3ZXE/zo9Hxtxx/SNrclKK9c2aPzM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-OGDmt1ohPpi-RaZkqH7EYw-1; Mon, 14 Jul 2025 10:46:02 -0400
X-MC-Unique: OGDmt1ohPpi-RaZkqH7EYw-1
X-Mimecast-MFC-AGG-ID: OGDmt1ohPpi-RaZkqH7EYw_1752504362
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455f7b86aeeso13585965e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 07:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504361; x=1753109161;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFvWUbvYOMPAFeZVSRMsNONk4G4QFR5pZQmr1EAVpzU=;
        b=BzjVGFDAfpL2bsiPWkKI6Zs9/GRKzUbA3wdqd4g/SdP7t3sLHQZxeWRU3GXQHf/48x
         9Uk5fbOE+9FqIUudwM1L0yjY7wLp/LNrHmE/YLMktE9qwuKh9Kr9EpGflz4W9limEhHl
         yW2MWF32cmc+8qNSV+31jcHCZUFcxSrBd5zXgT6WuU0D6bgN1pQ7hosifnzkBYUXlrou
         jvKWhDE7/sYsB6V6P35MVY5VIwMm0VF9uFCCNKNQRh5DAnP97TWmrVeBbe9b0uBoSGtD
         x5F+4yotctCzRVvrt68sKL84jFROC0jWdy8Ktu+JxaZ48rUTEcwAkwJqUuAH8EhufDul
         OsIw==
X-Forwarded-Encrypted: i=1; AJvYcCVclHWbd1C5Gawxo+fUm42n7u+44L0hN3/jYeWNmbONWrefF5EViqS8BBXsUPl/P1yvkdNG0yLiX8usiki38dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLrvjQauH8ZPmF+3cSzdbSEeEfxHX3RpcGS3j9qhVUgGN1XvfF
	EOjpwZ1LtolK+wm+A1T0DAHIHgK59qPpF+FBD0WcDFkg75SGlhSH16NiTjpbOnNWemZeVa9f/3r
	K4fs6EfH4YbwWe7Z4J9nNjoYdTHtr+/lKrifGmN+JZBe6KakxckDkSMiBy4+Q1Qk+Vxxrxg==
X-Gm-Gg: ASbGnctgaCZC2dExdJh7lEam8Ll+FLVaK1B/No9Ib1YIFcGJNP0KhZ7q0MNZldLAd6m
	1jaJpGCL/1BRbKYvPO5HWUY0LuIGZ0dfciFosPiWP83j7Tua7XZBUK4K8u7Jacn2dLbitulqZF6
	uv81JDKWK2xg5fY+y+3e1PeFEySX17COoBiaHijtH2YKnyG6sDPfJvZf3WJy/Uhctbdslrj1yLc
	x6tdl17ShuCAgZkPFbi2sQK2vjWGQcb5IGu/bfVcSfLct4M19DGLDG5UM1n+aa5FmZ4wl+4UNjx
	13nzlL7j/ALNPaOvPUz0N2X32siN494tL/evjGs8Ypd/c1WDk2toVzUacghbG0uBBvjvsv5RuJS
	A52UBXkX3HWkcpvSMOPHgV6ID7AQ3viWLZFUOLTc7uewSez8b7dcAV/duNcovpUtK
X-Received: by 2002:a05:6000:2088:b0:3b3:a6e1:135c with SMTP id ffacd0b85a97d-3b5f2e32f4fmr9267473f8f.42.1752504361432;
        Mon, 14 Jul 2025 07:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGenZg7oquFIg2YohZBIDiWhyyzgKEdWWdgmEJ/zEzda7h5UoZedqpmDLCPCuVQ4P+Ykj5sWw==
X-Received: by 2002:a05:6000:2088:b0:3b3:a6e1:135c with SMTP id ffacd0b85a97d-3b5f2e32f4fmr9267458f8f.42.1752504361042;
        Mon, 14 Jul 2025 07:46:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a54sm12812499f8f.39.2025.07.14.07.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:46:00 -0700 (PDT)
Message-ID: <fe12384b-4410-4bac-afee-77523b7957ff@redhat.com>
Date: Mon, 14 Jul 2025 16:45:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Patch 2/2] selftests/mm: assert rmap behave as expected
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250604082145.13800-1-richard.weiyang@gmail.com>
 <20250604082145.13800-3-richard.weiyang@gmail.com>
 <20250604083441.hilkdzlxmxygivvt@master>
 <2ee1d2ca-94c5-4c27-b2dc-bcea2b710dcf@redhat.com>
 <20250714144248.54d4rhboeq2wn6x4@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250714144248.54d4rhboeq2wn6x4@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 16:42, Wei Yang wrote:
> On Fri, Jul 11, 2025 at 05:39:39PM +0200, David Hildenbrand wrote:
>> On 04.06.25 10:34, Wei Yang wrote:
>>> On Wed, Jun 04, 2025 at 08:21:45AM +0000, Wei Yang wrote:
>>> [...]
>>>> +int try_to_move_page(char *region)
>>>> +{
>>>> +	int ret;
>>>> +	int node;
>>>> +	int status = 0;
>>>> +
>>>> +	ksft_print_msg("worker %d move_pages of content: %.15s\n", getpid(), region);
>>>
>>> One thing confused me here.
>>>
>>> If I don't access region here, the following move_pages() would report
>>> -ENOENT occationally. The reason is do_pages_stat_array() ->
>>> folio_walk_start() returns NULL.
>>
>> Right, the pages were not faulted in. The man page mentions that as
>>
>> "-ENOENT: The page is not present."
>>
> 
> Thanks I see the man page, but from the code point of view, I don't follow it.
> 
> The move_pages() return -ENOENT in a child process, and the child duplicate it
> memory space during fork().
> 
> dup_mmap()
>      for_each_vma()
>          copy_page_range()
> 	...
>              copy_pte_range() -> copy_present_ptes()
>                  __copy_present_ptes()
>                      set_ptes()
> 
> Even we map the range by MAP_SHARED, we don't need to wrprotect it.
> But we still set_ptes() in the child process page table.
> 
> 
> So it looks the child has prepared the page table and not need to fault in to
> setup it.
> 
> Do I miss something?

See copy_page_range() -> vma_needs_copy(), where we essentially 
optimize-out copying of page tables for most MAP_SHARED mappings (or 
MAP_PRIVATE mappings when we never placed private pages).

-- 
Cheers,

David / dhildenb


