Return-Path: <linux-kselftest+bounces-41044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40818B4A8F6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 11:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE973A4FFD
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 09:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D42F2D1926;
	Tue,  9 Sep 2025 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="he7uv1AN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3E29B77E
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Sep 2025 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411759; cv=none; b=ACstOzRdtLFV22Gn7hBObwr9vAA+4pEPcs3UMfQwxfzWYoY0Dcie72tlyZGLYLZ9g9VivevNwVnnj2NkBUVAmhXOhrFc3mp4LMU2fFL9bv0u9U/O3EFs+ZyTgvDuUQGw2lZLbt7BYB0ryFgxvtLPBH1zXMhm616DNt2bCHbigTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411759; c=relaxed/simple;
	bh=VKk+DfPeoBviWHTSePPOcfSJ1Fx+ahLOMPVb2ffk1QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9n3QsfonW/KLsZzI0qSjx77B1QpEo8u1se6NKFKpaXIjB14w2UdHRjgxLICGCjzIIp2pKefCdPqiGgDnIiYWNM6UM7HTkfAZ+7ToBvtfjPL+OkiH6NZwbiFK9EuYtPwr8qVjubNKsWdoV2ANAwHahF/kCclBeE96dkdHQGfM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=he7uv1AN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757411757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uuhn5XZ+k/yXfBkz6uI/EJtHiraKm76UcsqU/6SM9xI=;
	b=he7uv1ANAW01eUnXD+VlJxKPV9Yg/8eHB0FFOy7vX9PsI3RMRddchVeInBeXBfCt+Njqsd
	mIZlrOJICr129i4mcdn8gv6Kn/R4KeBGOenSyIexiOOP5RkI5uCpfEj1ysuOuesGxJHpra
	tsdiZBstVMj0VcVmxEbVH6/XjqSqP6k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-awZkYcbPMTC14WdyuCU3RQ-1; Tue, 09 Sep 2025 05:55:55 -0400
X-MC-Unique: awZkYcbPMTC14WdyuCU3RQ-1
X-Mimecast-MFC-AGG-ID: awZkYcbPMTC14WdyuCU3RQ_1757411754
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b9912a07dso32781255e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Sep 2025 02:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757411754; x=1758016554;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuhn5XZ+k/yXfBkz6uI/EJtHiraKm76UcsqU/6SM9xI=;
        b=qInnIVIsvf4AJCmfJ/X43EBepS+oG3pElouMZFj3vTP6fjR74MP70uz809B6gYIRMj
         MDjXxJdUJ4SWFcBnwMYpitaAjRJTp4ORdqHD+D0QFMFPwE6MktWrAykTSQKau1+Ez0gH
         hZJ/7kktmHibLoaaegGljmgJQB4ZCul3ZOsRDY/UHzD730cI34atdWI0FPtn+sMDtTYv
         O99ESsEXzQoRfctfpBU8C4g4YXwg8eeIZL+Swu1RkXdtnrT8MR9KEYUPNZrMpV6BEO1h
         9b6ck9xRfd3qDE1445uUGJ64rf6r/AOzfuk0MwndInuTx3iZCLgHjJ/kc+F56aq4chVO
         Mycg==
X-Forwarded-Encrypted: i=1; AJvYcCX6uFZ9DD9R+L0R47C/cthBFoWBBkZB5Ftt30k1Loy7fhYYfRayLxZ6ykstr9BRI7UBpPgWCXwW3EDucj9Yyas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk5OsKZmhwbDEnXTSIwA9ASzg6+5Uu/BgIzjAscEFyEQYdYk16
	vWkvBixn0FM9mc1fd1T6qp0HREHPwTONX8IvgEjZzz3IPIILsh1B4DrbIpMoG0vqqHxfXNIfgNL
	8ihawuDUmBEPVpFh6b6wil6Z5Bwef7PkDOyMEfxxtbTF5eHJx1UOQkAmRmHI03pEpfTqt3Yz5Lt
	6hPg==
X-Gm-Gg: ASbGncuKwps9SolRllCuWCOsZCv8eTug4DhuRE9UQkjISGlgmTVNl2YLFmnQDaSY6or
	Rsx20MyuueP7UN79vDDbg35uyeoCqEetAX4K8UmbIUldVNnrZ5phFVy2BOaoPK0jUSpvXtDaJGl
	2ZZX9sRYZDezMTwf5gnmd6KY1ySQmJWM8nhUiQMgJv5lluENfCDpHBzzCEfmVfnBGdUoE4DGqoQ
	aztLwBxMJ0vgA6k6JFH1cW6ONWK/Gq+HoAhGXMAB5WQkZNabCkBPXV65x/6ZDmNn69e8j7YIzQx
	IY8rjZQwayPOX3tMSPFC6LPWWaBCTSfXc4WDJ2MDAaUHfqQgtCHA8i7oZRnzzc8eEb544lQHJQl
	Uk+956Urvj8SRL4D2Pq0bfxiZWNObVKIozTVhRRs8TCdJOJJqCwyZbDYQdREAp5cGVEg=
X-Received: by 2002:a05:600c:3510:b0:45b:8366:2a1a with SMTP id 5b1f17b1804b1-45ddde829ebmr106120115e9.11.1757411754398;
        Tue, 09 Sep 2025 02:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFywLrR0DszeWqgd9Y5zxb2+w3HhCmkVKXj/s/GXP5Ci/2ssUudLpQTkEWfsIqoDp37rN0MYw==
X-Received: by 2002:a05:600c:3510:b0:45b:8366:2a1a with SMTP id 5b1f17b1804b1-45ddde829ebmr106119935e9.11.1757411753943;
        Tue, 09 Sep 2025 02:55:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34? (p200300d82f239c00d1f6f7fe8f147e34.dip0.t-ipconnect.de. [2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd296ed51sm228257165e9.3.2025.09.09.02.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:55:53 -0700 (PDT)
Message-ID: <6ec933b1-b3f7-41c0-95d8-e518bb87375e@redhat.com>
Date: Tue, 9 Sep 2025 11:55:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/37] mm/cma: refuse handing out non-contiguous page
 ranges
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linuxfoundation.org>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alexander Potapenko <glider@google.com>,
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
 linux-scsi@vger.kernel.org, Marco Elver <elver@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
References: <20250901150359.867252-1-david@redhat.com>
 <20250901150359.867252-23-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901150359.867252-23-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 17:03, David Hildenbrand wrote:
> Let's disallow handing out PFN ranges with non-contiguous pages, so we
> can remove the nth-page usage in __cma_alloc(), and so any callers don't
> have to worry about that either when wanting to blindly iterate pages.
> 
> This is really only a problem in configs with SPARSEMEM but without
> SPARSEMEM_VMEMMAP, and only when we would cross memory sections in some
> cases.
> 
> Will this cause harm? Probably not, because it's mostly 32bit that does
> not support SPARSEMEM_VMEMMAP. If this ever becomes a problem we could
> look into allocating the memmap for the memory sections spanned by a
> single CMA region in one go from memblock.
> 
> Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

@Andrew, the following fixup on top. I'm still cross-compiling it, but
at the time you read this mail my cross compiles should have been done.


 From cbfa2763e1820b917ce3430f45e5f3a55eb2970f Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 9 Sep 2025 05:50:13 -0400
Subject: [PATCH] fixup: mm/cma: refuse handing out non-contiguous page ranges

Apparently we can have NUMMU configs with SPARSEMEM enabled.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/util.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 248f877f629b6..6c1d64ed02211 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1306,6 +1306,7 @@ unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
  {
  	return folio_pte_batch_flags(folio, NULL, ptep, &pte, max_nr, 0);
  }
+#endif /* CONFIG_MMU */
  
  #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
  /**
@@ -1342,4 +1343,3 @@ bool page_range_contiguous(const struct page *page, unsigned long nr_pages)
  }
  EXPORT_SYMBOL(page_range_contiguous);
  #endif
-#endif /* CONFIG_MMU */
-- 
2.50.1


-- 
Cheers

David / dhildenb


