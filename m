Return-Path: <linux-kselftest+bounces-39651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB1EB30D64
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 06:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A9C7B5ED7
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 04:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9941D28DB49;
	Fri, 22 Aug 2025 04:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekVL8Jce"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC6728504C
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 04:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835769; cv=none; b=Oil2qRNeY9w3yw9S6weqwfCG3dLBxwNdPiXYg6ExOrgud7NuAvh1GVfjGZs1t4UB4lCirgqPNCUgjvGYg0BSEM4ZP7LgGK+YsoOVbqabEuo1baj7aBLwGGBlAldTB65bynDBCUyKxVl6VHtoEET1q+gjGV5YV900zIgLZMPdAbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835769; c=relaxed/simple;
	bh=uvxGoPwpEkTnej/P9frRazHxG8UL+BClJE53WOAvyXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5domw/lg41PY1ZlhFGKxsUD5ONMtC/61qJozdVgnQVG5ojGRisj1NQs9VFQXwRLGVZBDEh5ac00r3spSYPgboAlnw+H/Nsv2LhGBQoxoQNCdAjdkPYB2QUkqXZMuKyCq4fKPnRCVPsCpnHcmJ7jzcWRsZXaatwL6hjh9gQreos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekVL8Jce; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755835765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wD6Kie9NmTYlBWSYITqg8VmPWCkzgpHh3Jn6J+e3AEM=;
	b=ekVL8Jcem6q4cF0HM2y6xOx21D/FJFLgh+Adi11GsoKh93+dTphRUEqvPEAbV1jsnGf0+j
	76vWlhnV/nsaTW5nDgWVAmPnyWUl0TtjWGi7aVu71PRBgkpV7KBux/J7eN3g1ihAEe3TSt
	6lo4Vg1aDMs7A8C7PTZdjARZhrto0Jk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-Gmj-ibcoOIWrqxtCGEXJaQ-1; Fri, 22 Aug 2025 00:09:23 -0400
X-MC-Unique: Gmj-ibcoOIWrqxtCGEXJaQ-1
X-Mimecast-MFC-AGG-ID: Gmj-ibcoOIWrqxtCGEXJaQ_1755835762
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-333f8ddf072so6799811fa.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 21:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835762; x=1756440562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wD6Kie9NmTYlBWSYITqg8VmPWCkzgpHh3Jn6J+e3AEM=;
        b=r7rEqr0yfwRXjaa9Gs+KiSxr0CRswU486yn4TFPRTDZY7YQC2jqfzq42+GNre/jMcD
         NVqJYLnQC+S+fhczfibrmGxDM0mvRc+kL8h80aHZKQXsygN79ELzuzPU+Mj8oA9NJcaw
         tVf5dkYOFqW1O2nvLnDlqNKsxwcYR2Q46wr2+ifLLrllrGFJO93N0BA9eIV4fFNWuvCa
         y4ZAyqOEqtPeRAehBmK+LKwkIsAmiuDSs7/SbKh26CRevX9MT2xLK4HABgYl/z5RJeh/
         W9D+MjykYGnFH+ii567B9abn78T1JdCprsWJGK1zKBk7xvMaDAkNm0Y7P0YMCmOWcc3z
         g63Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnWr41IYgcM0QD2V3QcuFg00k2cgTg+vpsq718UiZmmNHIdchm5YcPYuRuvBNIlWkiwdm0rciZX4NMFWHZ2Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWaUVbpR38a1gyZd6qnEnUJAwH2ianYxV/sAlqFc+JAM+p7YM
	UbENMAEkt1CVHfF3V01E5B8/S0lkKOT4k8CZB7NAVcy3O7Gur/y6+P3ytP0WpoLeVOuGdXVsgTR
	SMg2FY5YvnilQOiudjLnOCaniRzIiJguUHrNU1anWjqUwjj8oQdupthayXDEXtef8nGUa
X-Gm-Gg: ASbGnctCmT2+/f6eK5QfzLCrNJuJ43Yt1ePLUlbCeYSpM41ZmKqabwteQBTkB+hIn9Z
	fUu6KyR6lp4Rb43HoDUr4zrd993RfONrcpKSLPnSktUotTgLHIQr5M6hPzf7ZEgbUtLgmJYIJ6w
	X21wpELF/ZhebTgaFW3LeGl7DpxLRzXPg0jPB2D83XLA/zM6m9enBgujhjJrfXn0/FqID7Y4VIE
	ix2+Dt3QDG2s69q6MB1MBnYEQCywtV4lN/wV8nWlnQlF5vKWaLkFJ1QLyxmXXIGju0zs1s6rFhS
	uBzOKt3Kdphn3CmD0kIuRMIJ2ziB7y9AQchAa3INVvMYcoa46F0niS9p2z5wbIFkew==
X-Received: by 2002:a2e:be0c:0:b0:333:b6b0:e665 with SMTP id 38308e7fff4ca-33650fa8605mr4319261fa.30.1755835762097;
        Thu, 21 Aug 2025 21:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIfwy5viYQG7CiACnNo0XJ1QLrkAQo6vQi0t/AKYxGuojOFc+bxzH8Oeop0sL+wr/cDEqByA==
X-Received: by 2002:a2e:be0c:0:b0:333:b6b0:e665 with SMTP id 38308e7fff4ca-33650fa8605mr4319091fa.30.1755835761548;
        Thu, 21 Aug 2025 21:09:21 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a41e3cfsm35236551fa.6.2025.08.21.21.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:09:19 -0700 (PDT)
Message-ID: <9156d191-9ec4-4422-bae9-2e8ce66f9d5e@redhat.com>
Date: Fri, 22 Aug 2025 07:09:17 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/35] mm/hugetlb: cleanup
 hugetlb_folio_init_tail_vmemmap()
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>,
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
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Tejun Heo <tj@kernel.org>, virtualization@lists.linux.dev,
 Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, x86@kernel.org,
 Zi Yan <ziy@nvidia.com>
References: <20250821200701.1329277-1-david@redhat.com>
 <20250821200701.1329277-11-david@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250821200701.1329277-11-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/21/25 23:06, David Hildenbrand wrote:

> All pages were already initialized and set to PageReserved() with a
> refcount of 1 by MM init code.

Just to be sure, how is this working with MEMBLOCK_RSRV_NOINIT, where MM is supposed not to
initialize struct pages?

> In fact, by using __init_single_page(), we will be setting the refcount to
> 1 just to freeze it again immediately afterwards.
>
> So drop the __init_single_page() and use __ClearPageReserved() instead.
> Adjust the comments to highlight that we are dealing with an open-coded
> prep_compound_page() variant.
>
> Further, as we can now safely iterate over all pages in a folio, let's
> avoid the page-pfn dance and just iterate the pages directly.
>
> Note that the current code was likely problematic, but we never ran into
> it: prep_compound_tail() would have been called with an offset that might
> exceed a memory section, and prep_compound_tail() would have simply
> added that offset to the page pointer -- which would not have done the
> right thing on sparsemem without vmemmap.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/hugetlb.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d12a9d5146af4..ae82a845b14ad 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3235,17 +3235,14 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
>  					unsigned long start_page_number,
>  					unsigned long end_page_number)
>  {
> -	enum zone_type zone = zone_idx(folio_zone(folio));
> -	int nid = folio_nid(folio);
> -	unsigned long head_pfn = folio_pfn(folio);
> -	unsigned long pfn, end_pfn = head_pfn + end_page_number;
> +	struct page *head_page = folio_page(folio, 0);
> +	struct page *page = folio_page(folio, start_page_number);
> +	unsigned long i;
>  	int ret;
>  
> -	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
> -		struct page *page = pfn_to_page(pfn);
> -
> -		__init_single_page(page, pfn, zone, nid);
> -		prep_compound_tail((struct page *)folio, pfn - head_pfn);
> +	for (i = start_page_number; i < end_page_number; i++, page++) {
> +		__ClearPageReserved(page);
> +		prep_compound_tail(head_page, i);
>  		ret = page_ref_freeze(page, 1);
>  		VM_BUG_ON(!ret);
>  	}
> @@ -3257,12 +3254,14 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
>  {
>  	int ret;
>  
> -	/* Prepare folio head */
> +	/*
> +	 * This is an open-coded prep_compound_page() whereby we avoid
> +	 * walking pages twice by preparing+freezing them in the same go.
> +	 */
>  	__folio_clear_reserved(folio);
>  	__folio_set_head(folio);
>  	ret = folio_ref_freeze(folio, 1);
>  	VM_BUG_ON(!ret);
> -	/* Initialize the necessary tail struct pages */
>  	hugetlb_folio_init_tail_vmemmap(folio, 1, nr_pages);
>  	prep_compound_head((struct page *)folio, huge_page_order(h));
>  }

--Mika


