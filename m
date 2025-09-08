Return-Path: <linux-kselftest+bounces-40946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE93B48EE8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 15:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9593716B5D7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6531730AD16;
	Mon,  8 Sep 2025 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAMTxYPe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C230AD0A
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Sep 2025 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336975; cv=none; b=oHZzxlWBqFXcYV8AlUuUZT70k4JkgFD3ZFMpjA/M0rYRLp82Cn4BWMxMK81ofVRWOd2lcf9BqD6EyUX/q7X4TK2YKUZtQgNeT/gub4qYTw9aezORKq23NYlKTh/+jdMnmGI6zn+my1fUXu9rzb4pdQLIk+Bnse+xfx1AC4Pi4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336975; c=relaxed/simple;
	bh=lN+RvLXAbPGvXM5vEXBiD2QX+YHcRkPkyl7mXXiqmQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5utafEsB+eMS9IkKTLOTP3VHYYxUrKOcv6ZhucmSOJzIFtZkH1O7eW7ZrLgdXpisnws/kxkasngWaV+EHDv8yR2SCL295PxCm4gS2SdtZXSYMV3YnSNKguTPYa3YW42kpqLQA6dTvlyYlrKCbv+UGSBjM+xBX5041Nfno37GKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAMTxYPe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757336971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eB7yatq5EqoBSnA27Lv1hI77502SZNq+gzJVQ8jsFR0=;
	b=JAMTxYPetuvBA7XAteQr9bDTq4nnFd+XpkqppXnWCSseADHwV8Vo3R9XGP96ZHz/QnEv9A
	DRanHVErFylqn4whdWMoS/J9RFs5STIKUhp077S9EfNcGdcb9+SEq/G6+iWjK4vgMruDgo
	VdxKm7EGBX2udoOQeSAVXltdaLewLrw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-SQO-7sAiNUiEqV2gsXsy8g-1; Mon, 08 Sep 2025 09:09:28 -0400
X-MC-Unique: SQO-7sAiNUiEqV2gsXsy8g-1
X-Mimecast-MFC-AGG-ID: SQO-7sAiNUiEqV2gsXsy8g_1757336967
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e2055ce94bso2608905f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Sep 2025 06:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336967; x=1757941767;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eB7yatq5EqoBSnA27Lv1hI77502SZNq+gzJVQ8jsFR0=;
        b=fH7K3hyPk1nrEi9+Q9YJGxFAomYqp6WoMO+neafP+yBiTBNdd+6NL9wpHKlUm1d4gq
         rSvIvNaZfYRdLIiClBQ8sINsxhlPTItO5eCv8cfcY8uRFtUQpWvHtQ6yab9sfDtr8/Bv
         XnzqxyUKN6w41QbmViL1ew2WLYmrEaSmz/0/lpVQdo6rZgbKieTpKUz6C2g60HbFf33L
         oXuSdjHmOYADPq+GLy/sR4g8yJ+ip8CRj1uK7k+MRo+AZJC7Epg/8t2RDp72l5O/LGT1
         +GX0rer+Cpp3HyBKT7aelFNUp3B3Yrqyt5hh0iCSF1W1IcdDr94Utg4A1AwfY8fxTPQp
         4kqQ==
X-Gm-Message-State: AOJu0YwliVClJFpMlKXbY6QW6EGJioFjKf9gW1F7WzLlUkDNtMkackw8
	OyHgiW0R4FhXkvKICp5lzC7DRPbTtYVSVxGYDjIhgJFjLM2/mC5UvMz9TBEyOUb0eChAbToTar2
	1CdrGsCkskrhNwrDDKQ06KcSfyB5Mkn1txem3HgdozE3jZda35+ySsxu9CicwVB13DDPHWVllJe
	kirw==
X-Gm-Gg: ASbGnctr8ykhMBuCxwk4b1+svWyb1bzs0cdWc+020aPSbrc3pNcDo8WdFyuWAyqwDbT
	YDm7Q2IGPwabZwYF/lAd0IQKphvuTtg7k7IoyZxIuaC+NiPlkkC4nHac6cns3j4hAiniefGxu6P
	yHrUsU43ZqSdJuIg6YVyCYuCsu7OQAYwlfxT7tdiXaISWoD+4OYRYFdsKlsBVm5jth+f0IJ0OSl
	lsEPMLKOVvhqnspWD3ghE4QQI3I8tx5vN8PTF4EShkto8g7O+2QLZIJKhoKXyZjNQnpWqV+Bq0i
	3cQAg0AxHdnV5hAOhJ4hfOyA03XfqSPpbDBxylrJ4OckAFHF7FkyerbqCqMoxwwZ80LZfzlwC6P
	Rt4JKBbO7OqyELnMdcr8brC9+KSZR54T6lZeTg9pTNiqsl1PvZf2JyVENbBefgfjq
X-Received: by 2002:a5d:5d82:0:b0:3e3:5166:e098 with SMTP id ffacd0b85a97d-3e63736f7e7mr5576535f8f.17.1757336966935;
        Mon, 08 Sep 2025 06:09:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiYFgngxAXgT4Go5511IJKu0xHmBuhnWeb/Br+tBYfFuPdCYNIOJjBBUAXrdUS1YwoE0FAWA==
X-Received: by 2002:a5d:5d82:0:b0:3e3:5166:e098 with SMTP id ffacd0b85a97d-3e63736f7e7mr5576494f8f.17.1757336966470;
        Mon, 08 Sep 2025 06:09:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34494776sm41332226f8f.61.2025.09.08.06.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:09:26 -0700 (PDT)
Message-ID: <22a9dd3e-0755-4f7f-a59c-a79a52871f56@redhat.com>
Date: Mon, 8 Sep 2025 15:09:24 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/mm: fix va_high_addr_switch.sh failure
 on x86_64
To: Chunyu Hu <chuhu@redhat.com>, akpm@linux-foundation.org,
 shuah@kernel.org, linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
References: <20250908124740.2946005-1-chuhu@redhat.com>
 <20250908124740.2946005-2-chuhu@redhat.com>
 <20250908124740.2946005-3-chuhu@redhat.com>
 <20250908124740.2946005-4-chuhu@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250908124740.2946005-4-chuhu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 14:47, Chunyu Hu wrote:
> The test will fail as below on x86_64 with cpu la57 support (will skip if
> no la57 support). Note, the test requries nr_hugepages to be set first.
> 
>    # running bash ./va_high_addr_switch.sh
>    # -------------------------------------
>    # mmap(addr_switch_hint - pagesize, pagesize): 0x7f55b60fa000 - OK
>    # mmap(addr_switch_hint - pagesize, (2 * pagesize)): 0x7f55b60f9000 - OK
>    # mmap(addr_switch_hint, pagesize): 0x800000000000 - OK
>    # mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0x800000000000 - OK
>    # mmap(NULL): 0x7f55b60f9000 - OK
>    # mmap(low_addr): 0x40000000 - OK
>    # mmap(high_addr): 0x1000000000000 - OK
>    # mmap(high_addr) again: 0xffff55b6136000 - OK
>    # mmap(high_addr, MAP_FIXED): 0x1000000000000 - OK
>    # mmap(-1): 0xffff55b6134000 - OK
>    # mmap(-1) again: 0xffff55b6132000 - OK
>    # mmap(addr_switch_hint - pagesize, pagesize): 0x7f55b60fa000 - OK
>    # mmap(addr_switch_hint - pagesize, 2 * pagesize): 0x7f55b60f9000 - OK
>    # mmap(addr_switch_hint - pagesize/2 , 2 * pagesize): 0x7f55b60f7000 - OK
>    # mmap(addr_switch_hint, pagesize): 0x800000000000 - OK
>    # mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0x800000000000 - OK
>    # mmap(NULL, MAP_HUGETLB): 0x7f55b5c00000 - OK
>    # mmap(low_addr, MAP_HUGETLB): 0x40000000 - OK
>    # mmap(high_addr, MAP_HUGETLB): 0x1000000000000 - OK
>    # mmap(high_addr, MAP_HUGETLB) again: 0xffff55b5e00000 - OK
>    # mmap(high_addr, MAP_FIXED | MAP_HUGETLB): 0x1000000000000 - OK
>    # mmap(-1, MAP_HUGETLB): 0x7f55b5c00000 - OK
>    # mmap(-1, MAP_HUGETLB) again: 0x7f55b5a00000 - OK
>    # mmap(addr_switch_hint - pagesize, 2*hugepagesize, MAP_HUGETLB): 0x800000000000 - FAILED
>    # mmap(addr_switch_hint , 2*hugepagesize, MAP_FIXED | MAP_HUGETLB): 0x800000000000 - OK
>    # [FAIL]
> 
> addr_switch_hint is defined as DFEFAULT_MAP_WINDOW in the failed test (for
> x86_64, DFEFAULT_MAP_WINDOW is defined as (1UL<<47) - pagesize) in 64 bit.
> 
> Before commit cc92882ee218 ("mm: drop hugetlb_get_unmapped_area{_*}
> functions"), for x86_64 hugetlb_get_unmapped_area() is handled in arch code
> arch/x86/mm/hugetlbpage.c and addr is checked with map_address_hint_valid()
> after align with 'addr &= huge_page_mask(h)' which is a round down way, and
> it will fail the check because the addr is within the DEFAULT_MAP_WINDOW but
> (addr + len) is above the DFEFAULT_MAP_WINDOW. So it wil go through the
> hugetlb_get_unmmaped_area_top_down() to find an area within the
> DFEFAULT_MAP_WINDOW.
> 
> After commit cc92882ee218 ("mm: drop hugetlb_get_unmapped_area{_*}
> functions").  The addr hint for hugetlb_get_unmmaped_area() will be rounded
> up and aligned to hugepage size with ALIGN() for all arches.  And after the
> align, the addr will be above the default MAP_DEFAULT_WINDOW, and the
> map_addresshint_valid() check will pass because both aligned addr (addr0)
> and (addr + len) are above the DEFAULT_MAP_WINDOW, and the aligned hint
> address (0x800000000000) is returned as an suitable gap is found there,
> in arch_get_unmapped_area_topdown().
> 
> To still cover the case that addr is within the DEFAULT_MAP_WINDOW, and
> addr + len is above the DFEFAULT_MAP_WINDOW, make the addr hint one
> hugepage lower, so that after the align it's still within DEFAULT_MAP_WINDOW,
> and the addr + len (2 hugepages) will be above DEFAULT_MAP_WINDOW.
> 
> Fixes: cc92882ee218 ("mm: drop hugetlb_get_unmapped_area{_*} functions")
> Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> ---
>   tools/testing/selftests/mm/va_high_addr_switch.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
> index 896b3f73fc53..bd96dc3b5931 100644
> --- a/tools/testing/selftests/mm/va_high_addr_switch.c
> +++ b/tools/testing/selftests/mm/va_high_addr_switch.c
> @@ -230,10 +230,10 @@ void testcases_init(void)
>   			.msg = "mmap(-1, MAP_HUGETLB) again",
>   		},
>   		{
> -			.addr = (void *)(addr_switch_hint - pagesize),
> +			.addr = (void *)(addr_switch_hint - pagesize - hugepagesize),

Wouldn't it be more deterministic to do the alignment/rounding ourselves?

(void *)(ALIGN_DOWN(addr_switch_hint - pagesize), hugepagesize)

Unfortunately we don't have an ALIGN_DOWN helper available yet.

We could just move the one in pkey-helpers.h into vm_util.h


But now I realize that, likely,

	.addr = (void *)(addr_switch_hint - hugepagesize),

would just work and be aligned?

-- 
Cheers

David / dhildenb


