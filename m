Return-Path: <linux-kselftest+bounces-41375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BB0B54E45
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2467AC034
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9229E301471;
	Fri, 12 Sep 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYa0B9SA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CCE15E5D4
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680966; cv=none; b=Cgoyhp3fwNFif0Zzjig9ju8VO3XUBesMZKQj3isAQzfuE1zcFP7Z1UVDB6b2q06VzIrrrnujMqqDgVGZgt5ryF1k7lEgtZfzK0Yf3P53QtQRcc5eYeew5I9r4f4VeALMD4JKz1NqQTIAKmXMjptAGdwQH3NR9s78nS+r3qvdivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680966; c=relaxed/simple;
	bh=Sbr9UcuBSA1fnqSKyTmP6EE6X8W00T3WjaDqgVB3kyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGe0liQviblKIll53AVdbCzlw/kuksHWmppQ3xyusl9w9znHL4u4SS77oKJ0BMhzNGl8xLaxw8qnIZIGwexhdXdyYk7OIQF1ID1lie9ReF5Kyn9RKjcp0bydiOToXYTBavR7Pva8OGvZBrc2/3snjbjEbvRDF7k5wBhWSfu0zjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYa0B9SA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757680963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G68/Vcl30gBKrC2/x62wn4zQW5Fw8/QtQkhUplaCLsc=;
	b=CYa0B9SAJEf+q/mdrEbhQENhNCuSLZpzSAr8wclrz/p01KaKhs7vgVszIhrRYFrXMocb3M
	hwHw+uMVIV0ghKaE5O1JjNalaGMidM5JCbOKPM8RVEHpUuV2WtxlZZib8Z+qFktQEY5w4v
	7TYrYnPXAhyNnnJgvVMVL5w1jikbOOM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-pVWxNbhrO5SI95pnj9dwow-1; Fri, 12 Sep 2025 08:42:42 -0400
X-MC-Unique: pVWxNbhrO5SI95pnj9dwow-1
X-Mimecast-MFC-AGG-ID: pVWxNbhrO5SI95pnj9dwow_1757680961
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso11624655e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 05:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680961; x=1758285761;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G68/Vcl30gBKrC2/x62wn4zQW5Fw8/QtQkhUplaCLsc=;
        b=qGKMSYAQGOUEx2y1d217OxIaeAAiRu51m5U43AVRUAJaiBkUAoAzwkhB3JolVEq2C+
         LEugig+UFYpiWwYC4yBO8erh64r/Rgc/xaVUkEIqdUVWXXL5FFOdKW5un1EKTzsGgADB
         2u15y/r2LBgprnO29N6yMn+lUI4AVYKoKzOa4YH/9yPl7aJpvMLjEW7eytGiNZMX5Nso
         qzSJGodceudLnZemDbxtXGNZVpEyX5gX8MlsqQ9BP8riCNb4Fqd4mZV3MY9XlImwrRPL
         ryDhzntQRc8zlJbqAL8mBry1nw9PQ3Scm2/trTMk1keW3T9I9v/BdWs0kziy5gc4q/88
         /U2w==
X-Gm-Message-State: AOJu0Yw/i1vqEcuWhzuYMCrJ/8VFs7Up2tAkAOscmYjaJhezlLl3ketG
	wMdmnpSjnu/qLdkI3ykGxWya1wf49QkFfcuF87ALlJ3qgldJD8WuaXUoJgO5AmSPIOquvqYJ6Du
	Z11BNPxWPOJ9PbYb2CfrO4INjLz5vQQr4ub8uF21CAd9IjB/R3j5gWCUyAiCuDXbuBCqq8XGTHM
	VD0Q==
X-Gm-Gg: ASbGncsy1apgSTiXGaWFp8N5KfIgSp2kZjSHX8MYisa13azJfy7e+x+xvfUhFoNeVIR
	niDURtEHubxNrsZlBkisUaO4potwHIsoqJPjY6gZV9/T+rIA5+9eh2MEBnyhYF5o0XYPaRIEXKD
	CaHHWm9VtkfmZ9zqRJzbY52zXTfumbvL1SNIKo3Z6iP4exySioNjiPTb0FcyipdrOAOtCNRI2Pe
	GuUHqub9mRCfso6h98ETxLn3aTelhTPF0EvT6MGhPvBkVsqmm+KFpr9uBuKPpqUoNfITfBdR6f1
	7kbJcTkyg9xPLUYBMG5ZBtBK3WZmIhEGyXV3oHzmGb4rqn2AaAQSNWKsyWwR6/Cl2Hi6LN48Bx4
	4GHqTcBCgLBlPlHg+iMgXCMgKAo8Mnb77knw2nxp6ZUfEb9u+dQGZuZbrIkaqM3b9z84=
X-Received: by 2002:a05:600c:3328:b0:45d:e728:ce6 with SMTP id 5b1f17b1804b1-45dfd7e75a1mr44551995e9.18.1757680960990;
        Fri, 12 Sep 2025 05:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8FYlxUSGpt9qV5IWzAmbChJ51bMVMip/23iOY5R9qJCjX4HDDSwisLFfp9Dft+/PJESOvyQ==
X-Received: by 2002:a05:600c:3328:b0:45d:e728:ce6 with SMTP id 5b1f17b1804b1-45dfd7e75a1mr44551765e9.18.1757680960540;
        Fri, 12 Sep 2025 05:42:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b3137sm66439175e9.19.2025.09.12.05.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:42:40 -0700 (PDT)
Message-ID: <302d47a7-4f20-4c74-ad3e-b8574970bce5@redhat.com>
Date: Fri, 12 Sep 2025 14:42:38 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests/mm: fix va_high_addr_switch.sh failure
 on x86_64
To: Chunyu Hu <chuhu@redhat.com>, akpm@linux-foundation.org,
 shuah@kernel.org, linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
References: <20250912013711.3002969-1-chuhu@redhat.com>
 <20250912013711.3002969-2-chuhu@redhat.com>
 <20250912013711.3002969-3-chuhu@redhat.com>
 <20250912013711.3002969-4-chuhu@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250912013711.3002969-4-chuhu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 03:37, Chunyu Hu wrote:
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
> addr + len is above the DFEFAULT_MAP_WINDOW, change to choose the last
> hugepage aligned address within the DEFAULT_MAP_WINDOW as the hint addr,
> and the addr + len (2 hugepages) will be one hugepage above the
> DEFAULT_MAP_WINDOW.  An aligned address won't be affected by the page
> round up or round down from kernel, so it's determistic.
> 
> Fixes: cc92882ee218 ("mm: drop hugetlb_get_unmapped_area{_*} functions")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


