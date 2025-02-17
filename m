Return-Path: <linux-kselftest+bounces-26788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75C6A3874F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 16:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F6F170E01
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50CD224AF3;
	Mon, 17 Feb 2025 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkwL6kx1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CE2224AE3;
	Mon, 17 Feb 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805239; cv=none; b=tZF8kC3eQQSo8PRtuw3uXgQlYLFuGxbBk8XN5Kw2t5UDdLXXLzFPD0Q/ikxqqzg962lsxC1OeOHKQJoEzDtyO5cAb/Jzxf5e8wScQ30acdPhkoE4EpMEbjipqudQZeQqcLceRnv8rDlHOM4zinFoBrNcp+imC3oFZ8XK4GG4XS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805239; c=relaxed/simple;
	bh=ceOi81mc70klegZOTYzDPgZqMYutc+or6PEzYL8DKVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtz+tvVWj4o4gC4gOZWeOfmnueF/QKfx+jEmguEcF4yClawCYEFf9zIXhLpKLwr3K8Lvx0f3HB1CFZot/xjHdtHzlpJdhJB7PqfZwVLVyEAN1stzBA7GwX06xiV9Ly5Iqx46qr4CX1LCemgI/E8A65vy7Gz1ByfJ4blIieYpg5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkwL6kx1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso8218837a12.3;
        Mon, 17 Feb 2025 07:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739805236; x=1740410036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoNbjmdbvjY/XVJJlaAAFeUh14svEzqtVgPXSMwNfBw=;
        b=SkwL6kx1ND6hdMiPF94lLRfNHuR6WWLOEouISvV8vZEFB0L6YGUuRIh6aq5Wa+a48C
         Aahb93S2xWePajLzxQ/9of42kaMRwHXAkobLi9wBB4ETinaY2xb+LgOgQVU+K6wyM2F9
         p2gqBC5bT9JmNjvqx9o0L40D3RIGAlFwZsRaARfgzFdK78uyB/HqZvqqoZ/O0ymcErkY
         yEkPLsRdpi2YNKVX8MVV2ehruoIHp9HVUSSaYueUQGnSzR7JKFfQEZZ7xta/54l7iupQ
         bCaa3X2pu4xdjKBtX12xRJL5m9bDfDN+PkMizuxoWN27YlxPourauh2wYKdfm7uaeHDH
         vr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739805236; x=1740410036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoNbjmdbvjY/XVJJlaAAFeUh14svEzqtVgPXSMwNfBw=;
        b=vVtJroN0HakNKnIMqwCPfRe1n3O2KIK6bK9fycYaTUOq9E5lhoolg5uTpZDiKuDyQD
         P8+p7tMPmAu24QeHYgs3OtCYtAP/XCkTT69YOeyuEwwOCWKd65XGY5ZoAVbP5YPzRg7z
         ofVKDGi4GVxR7aR5i2IHAvqgwTtNO/BcmxcObVwzsGZGA16Ag9VBYN8l7IWkPASGVBmh
         v3LVHW/FUyAqsz1q4y4Y+GKbUa4I6YqJKNUwtzpE6q4YcrunG8eki87kYNdaClvuMBuq
         4h9S/Lp5yQK+5xG0sZnsc9bWmLAYdHm9t8QF3oaSGMRj5IRiI7xdvitfZJcl61cKm7qV
         l9JA==
X-Forwarded-Encrypted: i=1; AJvYcCUGbwqfYR/bobOyaLfMET8Yo3N8WEBdNJ6AUG848x7m4G9uCJVTddOwecE4q8D6X7kTOZ3L91Do3nSfaWee@vger.kernel.org, AJvYcCVJQuHqelXiJCPb1VTOqf373XosGbNvDPKuCn26EknsGX6iVKXH9G0e6G6KNmorYj00IeNUhkGO6yo=@vger.kernel.org, AJvYcCXexEMPKrS16yhH8KawygrKu0aXh1AgCU6ojeMf3/J9ehgjoGDbTXlOIW+Y1nMlZd/WWx65s2n9/udHV2MCbsM2@vger.kernel.org
X-Gm-Message-State: AOJu0YyytWCQehPudjM+A6B/6UeykQpdCDbvvksf2xfPZzs4q6iiIYTB
	oh/zSC3T4MSRFtbBOZeuEdWVGY2ULo53eoJ9xMGYyGPt4lGe9kLW
X-Gm-Gg: ASbGncvvLqqfyZeXahVkG+hi26NbuBXbZJpnKeiI9stpihaiuWHb1LQ/SQYTA9RWQ7C
	9AFTpfjY4GUnYbU0ljK/YIC0RAMXcCSymkFtKIQ/jLYLhBCvZxfYXZFdiuOxROr1e/8nV4EbSPS
	brgAtrRoy9tA8WNfcJzEoDMjAIRaYlGAs38ohAfqcGPFWFkDbjZjs4K2JA59GdhhyokDiMcSRsQ
	vFoRBqiKtiV0N2m2WW4sg/qEiLeBxRujKtH7UppBWZZ8FlfqAAuHnXvaDYU2kK4fgK3a9TTj+mg
	Qsx0rxmcIZkkRjsphG76uqfWPZH45CrAatL3WC63szizOjScgzNu5OnpODsZmg==
X-Google-Smtp-Source: AGHT+IEP10eXUY8i3oDDDg3lF4ilHQydvyQYUQww7NrtLLL+sTgv656S34fPOBxn2U+5a6BaYbbw3A==
X-Received: by 2002:a17:907:72cf:b0:aa6:96ad:f903 with SMTP id a640c23a62f3a-abb70db0230mr684578266b.31.1739805235904;
        Mon, 17 Feb 2025 07:13:55 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:fb:39c9:9a24:d181? ([2620:10d:c092:500::7:6466])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb904a4ae5sm303112766b.29.2025.02.17.07.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 07:13:55 -0800 (PST)
Message-ID: <3ef9a5f3-2d63-46db-b0b5-d6f7e78c7888@gmail.com>
Date: Mon, 17 Feb 2025 15:13:54 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 5/5] mm: document mTHP defer setting
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, david@redhat.com, aarcange@redhat.com,
 raquini@redhat.com, dev.jain@arm.com, sunnanyong@huawei.com,
 audra@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, tiwai@suse.de,
 baolin.wang@linux.alibaba.com, corbet@lwn.net, shuah@kernel.org
References: <20250211004054.222931-1-npache@redhat.com>
 <20250211004054.222931-6-npache@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250211004054.222931-6-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/02/2025 00:40, Nico Pache wrote:
> Now that we have mTHP support in khugepaged, lets add it to the
> transhuge admin guide to provide proper guidance.
> 

I think you should move this patch to the mTHP khugepaged series, and just send
THP=defer separately from mTHP khguepaged.

> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index b3b18573bbb4..99ba3763c1c4 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -63,7 +63,7 @@ often.
>  THP can be enabled system wide or restricted to certain tasks or even
>  memory ranges inside task's address space. Unless THP is completely
>  disabled, there is ``khugepaged`` daemon that scans memory and
> -collapses sequences of basic pages into PMD-sized huge pages.
> +collapses sequences of basic pages into huge pages.
>  
>  The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
>  interface and using madvise(2) and prctl(2) system calls.
> @@ -103,8 +103,8 @@ madvise(MADV_HUGEPAGE) on their critical mmapped regions.
>  Applications that would like to benefit from THPs but would still like a
>  more memory conservative approach can choose 'defer'. This avoids
>  inserting THPs at the page fault handler unless they are MADV_HUGEPAGE.
> -Khugepaged will then scan the mappings for potential collapses into PMD
> -sized pages. Admins using this the 'defer' setting should consider
> +Khugepaged will then scan the mappings for potential collapses into (m)THP
> +pages. Admins using this the 'defer' setting should consider
>  tweaking khugepaged/max_ptes_none. The current default of 511 may
>  aggressively collapse your PTEs into PMDs. Lower this value to conserve
>  more memory (ie. max_ptes_none=64).
> @@ -119,11 +119,14 @@ Global THP controls
>  
>  Transparent Hugepage Support for anonymous memory can be entirely disabled
>  (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
> -regions (to avoid the risk of consuming more memory resources) or enabled
> -system wide. This can be achieved per-supported-THP-size with one of::
> +regions (to avoid the risk of consuming more memory resources), defered to
> +khugepaged, or enabled system wide.
> +
> +This can be achieved per-supported-THP-size with one of::
>  
>  	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>  	echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
> +	echo defer >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>  	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>  
>  where <size> is the hugepage size being addressed, the available sizes
> @@ -155,6 +158,13 @@ hugepage sizes have enabled="never". If enabling multiple hugepage
>  sizes, the kernel will select the most appropriate enabled size for a
>  given allocation.
>  
> +khugepaged use max_ptes_none scaled to the order of the enabled mTHP size to
> +determine collapses. When using mTHPs its recommended to set max_ptes_none low.
> +Ideally less than HPAGE_PMD_NR / 2 (255 on 4k page size). This will prevent
> +undesired "creep" behavior that leads to continously collapsing to a larger
> +mTHP size. max_ptes_shared and max_ptes_swap have no effect when collapsing to a
> +mTHP, and mTHP collapse will fail on shared or swapped out pages.
> +

This paragraph definitely belongs in the khugepaged series, as it doesn't have anything
to do with THP=defer.

re "Ideally less than HPAGE_PMD_NR / 2",
what if you are running on amd, and using 16K and 2M THP=always only as, thats where
the most TLB benefit is. Than this recommendation doesnt make sense?

Also even if you have all mTHP sizes as always, shouldnt you start by collapsing to
the largest THP size first? (I haven't reviewed the khugepaged series yet, so might
be have been discussed there, I will try and review it).

Did you see the creep behavior you mentioned in your experiments?


>  It's also possible to limit defrag efforts in the VM to generate
>  anonymous hugepages in case they're not immediately free to madvise
>  regions or to never try to defrag memory and simply fallback to regular
> @@ -318,7 +328,7 @@ Alternatively, each supported anonymous THP size can be controlled by
>  passing ``thp_anon=<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size>[KMG]:<state>``,
>  where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE and
>  supported anonymous THP)  and ``<state>`` is one of ``always``, ``madvise``,
> -``never`` or ``inherit``.
> +``defer``, ``never`` or ``inherit``.
>  
>  For example, the following will set 16K, 32K, 64K THP to ``always``,
>  set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M


