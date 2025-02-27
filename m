Return-Path: <linux-kselftest+bounces-27715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F170A4759C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 06:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAF71883601
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 05:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CE720B80D;
	Thu, 27 Feb 2025 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fvb1Ijpo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42C1C5D6E;
	Thu, 27 Feb 2025 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635765; cv=none; b=NekH+/TZlThwNhALCfabfWlV4kJCRZ15VyxtndmQL9cuVl2+v6+0Kd8Gj34KiDMVwePD2fKYtIJfxMM+GyNweX39lQNmdlAcssYrEfcMKUirquEODzakXarK44xbneY+46rvRqxiYT6j7F0t0eudlk122JplNWrwqWMsizyFxtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635765; c=relaxed/simple;
	bh=u8IgI8tRH0G1btZhh6wTH82DrPz4/Z28ROmlt+Cnl2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gp1huAWQT3ctaFA8dL1q23QEzU6pJkLaKRXJScnHU6P8875zR5tL7tq2KFhRZb3Jz1Ks1bGBDpYwNGnzJxIwhXMkqRE8ceu8747rfd379ZdptObAt7i+aHpBSTRkJkBBqxc8qNfQwEJo/KQRraAa5eYQX6P7NPmcX3ulrLL/0Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fvb1Ijpo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pjOMWKX5cZm5qqlTrleQLdM8yGGKiB75apGd9kxx0Nw=; b=Fvb1IjpooHryAvRO8frQnR/6Gw
	ckfc+d6l49fRoOn8jCyXQ3r748XmMOUpZ1gUL80kulKaV58IiwqKAHnVBDhWkf0TEakaODpvJ5rC0
	Mbhe+xnju3Pt+Nqu15PBSTDf88bdlpJPdpswwiKdMgKOPFQXMFAWX2Jc/Wuy9C9dmmciQZMsK0jTR
	eutzq8XFVm21VIoQnWvILTFLVHGqRD7wVBwNQT5zCXY88NjstC29Pdtwp3xzlm9r8B/hOekVxrgc8
	xLWn+aOGYsxuA7mjQr/6PVlXukhtlCby+2bmftgNzt4fudlxkwIEUAAMjWD3ErLBSQg9ofGoFTTZ3
	l/HVG+5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tnWs3-0000000H2JW-0sDF;
	Thu, 27 Feb 2025 05:55:43 +0000
Date: Thu, 27 Feb 2025 05:55:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Message-ID: <Z7_-XweaPpfdRz1h@casper.infradead.org>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226210032.2044041-3-ziy@nvidia.com>

On Wed, Feb 26, 2025 at 04:00:25PM -0500, Zi Yan wrote:
> +static int __split_unmapped_folio(struct folio *folio, int new_order,
> +		struct page *split_at, struct page *lock_at,
> +		struct list_head *list, pgoff_t end,
> +		struct xa_state *xas, struct address_space *mapping,
> +		bool uniform_split)
> +{
[...]
> +		/* complete memcg works before add pages to LRU */
> +		split_page_memcg(&folio->page, old_order, split_order);
> +		split_page_owner(&folio->page, old_order, split_order);
> +		pgalloc_tag_split(folio, old_order, split_order);

At least split_page_memcg() needs to become aware of 'uniform_split'.

        if (folio_memcg_kmem(folio))
                obj_cgroup_get_many(__folio_objcg(folio), old_nr / new_nr - 1);

If we're doing uniform_split, that calculation should be
	old_order - new_order - 1


