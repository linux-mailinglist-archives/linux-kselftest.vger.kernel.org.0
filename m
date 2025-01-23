Return-Path: <linux-kselftest+bounces-25026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFF6A1A90F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 18:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132353A581C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE0F14883C;
	Thu, 23 Jan 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XciGOaTD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71376147C96
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654046; cv=none; b=WuvGd5RUc6TUwDFFoBRuap6GXEbVHE+zazq//OmxDfbI0PY+oZexbME3kvuzSTcp6xLLujjlLmfWex6GKGVK+HygRR60qiWy2mxCr6YZ0ucixv8uMWLNjVT0pa22QWI7xksd0TSU+X1P66+dbtM0FsUDI9I5Lz0ZCivYR8SZXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654046; c=relaxed/simple;
	bh=7cjd1Yc0hl2CQdFqJ9Y9P/NXJ/ttmM66Cy4jphvpv58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1ZL16qgiROKgjSxhwrMvCCmLksUdI8OHluzAok9bd7pMfceosdpNVA8B1SwKPU0P3CmstN2UeXaxZCWMVzurCaF7GQrXAtMb3C7P0jH/VArB6/UpzzgreQfTRSEMA+XkyI0lLFGNALDk2pPiezRaDJ+/Qb5iPH1srop4Tw0WJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XciGOaTD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737654042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3XAX29t0p8K//ChrZkKS09FKeW39YxcTgnGMJjcmuk=;
	b=XciGOaTDlOwzTclb/t3tFZOs0joBn8FsLe1O6m+bx3pdushLCKgqAUfiYAHkc83VswZL3g
	If94zPydMq+N0NGxQkfzItfze1s+ztWAYK0sAmDlo0BlumyGh1D8aMTAr40vRwid3roe89
	jz7zth7LQaYMpqj9OAnW9x2rnu1udOs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-lnhA9jYfPmiWXaeFUjz_BA-1; Thu, 23 Jan 2025 12:40:40 -0500
X-MC-Unique: lnhA9jYfPmiWXaeFUjz_BA-1
X-Mimecast-MFC-AGG-ID: lnhA9jYfPmiWXaeFUjz_BA
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46909701869so26870571cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 09:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737654040; x=1738258840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3XAX29t0p8K//ChrZkKS09FKeW39YxcTgnGMJjcmuk=;
        b=QcIUJe85ToU6L9eIC1SU4R+loaPx9k+yiKrHjeboS2K2wan8K0pup+H2mnOwl/8sXj
         dgXhiziVA4KldbcvpOYYbQ4NiZuWGgJZO6QL9wZMOxB2I/4Z9dT5t7dJ9QI6ogyYLo39
         tyEm26U0BaFuSIvJwgdTRQ9UWMu1bE+DbzX3HVkNt79AAu4mCHTPh/DAVZAcx6brv2md
         0v+ie3wn2jNGLn47MZEbtFDD6WXTe2wCyRQiRfpfeAYPSnRqucQ6ENp9tWHmvRcOhhCZ
         B934RFj2CZBqVk+mXeIbA1G/KFu+dlduApVjzZn3WfTZZp/T3efCnyIPvx/Ov8yUk+op
         vZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVCEHPBwnbRv6MwkVM+YUMT/N5mk9jyNDoMxqJCu0zUdg21LExv5rXQnbrsZalBgNPkBapCssZ7UBz3A6GE2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCGnjO4I0cPBU50w3EIjXvRGSYeYqonCrx9VIbuazeBrMEAjP
	1L1Y0DWOUy3hO9aE1dyTp2sA/ZyFaNaXueso+PJgW1YIgLz+rroxIyHfzbIJq7s9ZwQtqLldxrZ
	OLANWlyH7VzprBC3s31XcfdnCxMa+vieADltVwSOOuj56fAdo4YN4wSaLy4xXpvwbAw==
X-Gm-Gg: ASbGncsrgp4yvJazr5DQTlKw7LCkREPr4wY4ZT2oneWYH5EB8B0dSGOXlcBcG9MiACP
	ERglED6bnyV10YttjvVFz8kppH5aDyQGkMFLvIEQKI04XmcjmHzytztS3ZuiTX5BrcgAGc5IWRo
	214c8XHD3VJtGpjJJQbVIP3KWz3wmZ2RYQPDQfa+wXJSGqP1VZVCSr7ShflQA1pgZwXwZ7P1iQG
	1ltNR3j7GjyrJMlQ2KCJWKpbon+fN1/HkFzk9XRP9zWV0sgl7iro7wmxWU/kI7O5axtWYjYtv+K
	Pj4Y+GrXrPh9iNIBsqypr4ASJ8fTBqE=
X-Received: by 2002:a05:6214:1310:b0:6d8:9bbe:392d with SMTP id 6a1803df08f44-6e1b217141amr290342876d6.6.1737654040279;
        Thu, 23 Jan 2025 09:40:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp4As9pxJYPHqbJe7dQDEW7PkmFEro8NdCnUdEyw6JKRvfiOBNyNiaILOnexjjY4E1VYRsDQ==
X-Received: by 2002:a05:6214:1310:b0:6d8:9bbe:392d with SMTP id 6a1803df08f44-6e1b217141amr290342656d6.6.1737654039996;
        Thu, 23 Jan 2025 09:40:39 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e20514ee9bsm694376d6.30.2025.01.23.09.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:40:39 -0800 (PST)
Date: Thu, 23 Jan 2025 12:40:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm: Clear uffd-wp PTE/PMD state on mremap()
Message-ID: <Z5J_FLry1C2d3BKv@x1n>
References: <20250107144755.1871363-1-ryan.roberts@arm.com>
 <20250107144755.1871363-2-ryan.roberts@arm.com>
 <850479be-000a-45a7-9669-491d4200a988@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <850479be-000a-45a7-9669-491d4200a988@arm.com>

On Thu, Jan 23, 2025 at 02:38:46PM +0000, Ryan Roberts wrote:
> > @@ -5470,7 +5471,18 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
> >  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> >  
> >  	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
> > -	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
> > +
> > +	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
> > +		huge_pte_clear(mm, new_addr, dst_pte, sz);
> 
> This is checking if the source huge_pte is a uffd-wp marker and clearing the
> destination if so. The destination could have previously held arbitrary valid
> mappings, I guess?

I think it should be all cleared.  I didn't check all mremap paths, but for
MREMAP_FIXED at least there should be:

	if (flags & MREMAP_FIXED) {
		/*
		 * In mremap_to().
		 * VMA is moved to dst address, and munmap dst first.
		 * do_munmap will check if dst is sealed.
		 */
		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
		if (ret)
			goto out;
	}

It also doesn't sound right to leave anything in dest range, e.g. if there
can be any leftover dest ptes in move_page_tables(), then it means
HPAGE_P[MU]D won't work, as they install huge entries directly.  For that I
do see a hint in the comment too in that path:

move_normal_pud():
	/*
	 * The destination pud shouldn't be established, free_pgtables()
	 * should have released it.
	 */
	if (WARN_ON_ONCE(!pud_none(*new_pud)))
		return false;

PMD path has similar implications.

Thanks,

-- 
Peter Xu


