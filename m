Return-Path: <linux-kselftest+bounces-39876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD47B34A6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 20:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408C817B70C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 18:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CCB30E821;
	Mon, 25 Aug 2025 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhYXThG3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534992798FB
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146759; cv=none; b=f4ius0PYgl5oYt348hxRvCOBnUdXfZYaPgDVSD/oP58rIMdSVT1PnfNKgoYvTsmxF882uz0QAH/haJK3JnhdktkjVs6IHQH+O8wJMewjhDEyAMFSaOZqa3zqB6iea6HMwujX0IVGlac/4SN8EiJFbPkjGrQu/ZAxTRiTHty5hPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146759; c=relaxed/simple;
	bh=5gSbG4LawMNJ/PWjEAWfSVGPawomJWAQkNEyrTBhXtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MU33Po6Ny0tNeAMCJdJ8IuRyZL6nqdoiTSmID7fcRhVAQPsn8nljHPzndUhDcO93YFdyBTiFz1r68yATL57iuNniZqXghYtqH+/dDB4Z11YTZLu+j95ARDQa9vt/kSHoB2UOMSdw1Ky9VpxVuCfSIDIZBA0HaQzScvnMCFRYUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhYXThG3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756146755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bluti57k39MttADONVHVsAxBvXyqb5R7ZWo2ok70EgM=;
	b=RhYXThG3+tIFnfqzLIr9RPKxUxwraFl7lO2IPNcEbTyPNdKbVpERSCLZuCs+WhDSSPQMox
	8AF8QwnYsxJ1QrHDYmS40C5kdt7ZdyEuAeCyVZfTk/DGGnAgMs5zVwdFTws8tKK4Jgeq82
	8aePnOuj3pRFAfo75YAYdTeDDGMLxcE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-3DPxp-hmNbKUItm3kKK_Qw-1; Mon, 25 Aug 2025 14:32:33 -0400
X-MC-Unique: 3DPxp-hmNbKUItm3kKK_Qw-1
X-Mimecast-MFC-AGG-ID: 3DPxp-hmNbKUItm3kKK_Qw_1756146752
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b6490ea91so2323185e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 11:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756146752; x=1756751552;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bluti57k39MttADONVHVsAxBvXyqb5R7ZWo2ok70EgM=;
        b=naQUCTmbT0t+Z9tM/R7fjFW6eNB1Q7ZwHq3A/siSAnUqWkpKsd21q6d19qEchiXI8j
         z6zzMHJ7XL1wWU7rTiTzpYgK8MbbIne8sw5kckTK6nxfckTVc+fq9NFrA2OEh7Xa+vjy
         n+sPBceZrMBi3J9UeSWToY2WoiKYNMU08vZ6b6LZnq86ccY1nx1vL3w+q4CFXbaC4Bke
         4AwAu7K7PzklZkIo1zg6cywTu4cq/aL88kYC4btwg2r5j16/7FbvCRxK5vwGIhik9cMN
         iDvDnOmv5NUe/xizA7dRaO3X/hXffUn3U3QlZMWwNmFGg4sFWd8GYP7hha0v/sgrs828
         zKFg==
X-Forwarded-Encrypted: i=1; AJvYcCV1ZDGxz5CFNHLl88oCY5izu5hTZ1HsTwYPhxBWR7ysRzDLA46rpBZrlnCNuHvqAhQpR0UZAbNMJaQJxumKnn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZcNaqfDoHK4L4N/y/pZ1QokMlJRfADbGsMWc9Kk22mUO6HM2l
	EbJrAJl531PO9uTg8d9109rKarilVXmQad5T2284d5JIn/H6aXY8l2huWR6ijE6vTAKrMikSP+3
	md0nH60KUKiFVf5SWOKIFkbSl2wAC3oi7NR5jX2uDIzeVZQhPMX5uxoFatvm5a4x6hvpLFg==
X-Gm-Gg: ASbGncttEdplNNB9AddOZDcEEQZpZ6ECnet23G+vqCZGB3fyzvngYfVn2Z2j7MDEtSb
	8UZwd5gWLuAAlaU5+9pyEZ2N10w+X5qNPIEdnUyiAXwh2K+vy3sdpnGBXErheKRI4TyhG7Z0XP6
	/XGQ3WlUzI8DN+a8PVTHBX/PVm6rC62E3D/ywYp/rkIbYB4fk/LGZ1GlRVoLeBBYIl3Sdzenl7s
	Kn6FynTWCAGSrdura1XZpAflAmdpJBH37By4JikFKZuKH5j9xZuZOkGr7C3omd2YprjR8Wzmcn6
	Wjn6g+dYCdF5HoYZR31GJb9srXgf7nQ8trlUkswk3yqyGDnpQ1DUV+14UIxLBhfYN/IzypEDTyF
	wSUyTz1zR9Q/7BRrpmIJz/YAIkbSxFskmfVEHvd9rUVtzGD7AeS0gkcD65AgDmqDVmAM=
X-Received: by 2002:a05:600c:4e90:b0:458:a559:a693 with SMTP id 5b1f17b1804b1-45b517b957emr126710535e9.18.1756146752226;
        Mon, 25 Aug 2025 11:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxuQzAylX90vNEmmjxyPSaWFpv8tCbOTWCm8WazHqaDOnMAPM4HK8CKvM3oYkR/BEIZaOMIA==
X-Received: by 2002:a05:600c:4e90:b0:458:a559:a693 with SMTP id 5b1f17b1804b1-45b517b957emr126710235e9.18.1756146751795;
        Mon, 25 Aug 2025 11:32:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76? (p200300d82f4f130042f198e5ddf83a76.dip0.t-ipconnect.de. [2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7119c4200sm12481975f8f.53.2025.08.25.11.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 11:32:31 -0700 (PDT)
Message-ID: <7ffd0abd-27a1-40a8-b538-9a01e21abb29@redhat.com>
Date: Mon, 25 Aug 2025 20:32:27 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: update kernel-doc for MEMBLOCK_RSRV_NOINIT
To: Mike Rapoport <rppt@kernel.org>
Cc: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
References: <9156d191-9ec4-4422-bae9-2e8ce66f9d5e@redhat.com>
 <7077e09f-6ce9-43ba-8f87-47a290680141@redhat.com>
 <aKmDBobyvEX7ZUWL@kernel.org>
 <a90cf9a3-d662-4239-ad54-7ea917c802a5@redhat.com>
 <aKxz9HLQTflFNYEu@kernel.org>
 <a72080b4-5156-4add-ac7c-1160b44e0dfe@redhat.com>
 <aKx6SlYrj_hiPXBB@kernel.org>
 <f8140a17-c4ec-489b-b314-d45abe48bf36@redhat.com>
 <aKyMfvWe8JetkbRL@kernel.org>
 <dbd2ec55-0e7f-407a-a8bd-e1ac83ac2a0a@redhat.com>
 <aKyWIriZ1bmnIrBW@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aKyWIriZ1bmnIrBW@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.08.25 18:58, Mike Rapoport wrote:
> On Mon, Aug 25, 2025 at 06:23:48PM +0200, David Hildenbrand wrote:
>>
>> I don't quite understand the interaction with PG_Reserved and why anybody
>> using this function should care.
>>
>> So maybe you can rephrase in a way that is easier to digest, and rather
>> focuses on what callers of this function are supposed to do vs. have the
>> liberty of not doing?
> 
> How about
>   
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index b96746376e17..fcda8481de9a 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -40,8 +40,9 @@ extern unsigned long long max_possible_pfn;
>    * via a driver, and never indicated in the firmware-provided memory map as
>    * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
>    * kernel resource tree.
> - * @MEMBLOCK_RSRV_NOINIT: memory region for which struct pages are
> - * not initialized (only for reserved regions).
> + * @MEMBLOCK_RSRV_NOINIT: reserved memory region for which struct pages are not
> + * fully initialized. Users of this flag are responsible to properly initialize
> + * struct pages of this region
>    * @MEMBLOCK_RSRV_KERN: memory region that is reserved for kernel use,
>    * either explictitly with memblock_reserve_kern() or via memblock
>    * allocation APIs. All memblock allocations set this flag.
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 154f1d73b61f..46b411fb3630 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1091,13 +1091,20 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
>   
>   /**
>    * memblock_reserved_mark_noinit - Mark a reserved memory region with flag
> - * MEMBLOCK_RSRV_NOINIT which results in the struct pages not being initialized
> - * for this region.
> + * MEMBLOCK_RSRV_NOINIT
> + *
>    * @base: the base phys addr of the region
>    * @size: the size of the region
>    *
> - * struct pages will not be initialized for reserved memory regions marked with
> - * %MEMBLOCK_RSRV_NOINIT.
> + * The struct pages for the reserved regions marked %MEMBLOCK_RSRV_NOINIT will
> + * not be fully initialized to allow the caller optimize their initialization.
> + *
> + * When %CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, setting this flag
> + * completely bypasses the initialization of struct pages for such region.
> + *
> + * When %CONFIG_DEFERRED_STRUCT_PAGE_INIT is disabled, struct pages in this
> + * region will be initialized with default values but won't be marked as
> + * reserved.

Sounds good.

I am surprised regarding "reserved", but I guess that's because we don't 
end up calling "reserve_bootmem_region()" on these regions in 
memmap_init_reserved_pages().


-- 
Cheers

David / dhildenb


