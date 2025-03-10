Return-Path: <linux-kselftest+bounces-28657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78AA59BE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 18:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5483C188D79D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B92309A6;
	Mon, 10 Mar 2025 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s1w14gMk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB21E519;
	Mon, 10 Mar 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626056; cv=none; b=PApyR14XsgRcjbCDftYcX0S5ehb4Gj+TYHcvDP1lsJbwZ1DBgnkBw4ij7YS3F3zDOYXU3ybhFmRtM1GmJ6XL8M3x5Ha30VbKemtcAzRFHCcrxb6lH0bDnH8m7+ozSPruwp2WkMvt29HQEwZ4OQL47WdepN81B5EBQK2Ebooddwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626056; c=relaxed/simple;
	bh=MeG1VCik5Ze8Q6an3AFip2HUlayeAdN3z/xG111Hfxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeiZRKPG81x/O6awK3ipYUEpeMDuKJjuWYbpGae5UsmaHyJ+zpjx37xrthHEyZPehmG215V5Y8i+WzTBsdZQJ5/5pXThpVJws2RU+yPuHwgukA2sWGahOhvBCVwEiQHlwn7SHYc6vUSRr64IEboGQg7K6BVcEeC+ZAYqaa35HKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s1w14gMk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=owMofiDXpcMMHo+/HgqyyJABYuI5qKBiRMXRGlcf8l4=; b=s1w14gMkAYfFDIL9YOPASgbOwx
	1az5TYCE3Iop3ZjuWP2hMZHc43uhYwtz5t7FlF858GhQVCseu/YIf4c22DkYuRMnqk1hIL35OuVeK
	a4OD0/z6Wcw9NLx0GUo6uvZO4d3b9LUdnwzgs5xQ13u1WpWMdK6M874QTs8kWKOJf6o8OhIZoPcx/
	Ro7cyoNQl02p3o07+Rg+Tu5oODc1mDtEjn5oyDd1bpRATMvwcbbGVOV7VFvu1oPLipbVL/Pm3nlBs
	PNJl+C5UjweOwUlE5arqj9dDswrg62muLoeiuCzqOM5IzKqqIB5wBR5O3U3u0kS8L+wLGYdnMX4Ky
	l39qbUYg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1trgUR-00000008IkT-240a;
	Mon, 10 Mar 2025 17:00:38 +0000
Date: Mon, 10 Mar 2025 17:00:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v10 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Message-ID: <Z88ar5YS99HsIRYo@casper.infradead.org>
References: <20250307174001.242794-1-ziy@nvidia.com>
 <20250307174001.242794-3-ziy@nvidia.com>
 <Z88ToirSWa_meevw@casper.infradead.org>
 <A10312E5-F4CE-4CBA-B7CB-D435DFEA496F@nvidia.com>
 <D94BB56F-4BA0-4376-B5C4-7E38D2D92624@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D94BB56F-4BA0-4376-B5C4-7E38D2D92624@nvidia.com>

On Mon, Mar 10, 2025 at 12:42:06PM -0400, Zi Yan wrote:
> > Because of the “Careful” comment. But new_folio->* should be fine,
> > since it is the same as new_head. So I probably can replace all
> > new_head with new_folio except those VM_BUG_ON_PAGE checks?

Why not also the VM_BUG_ON_PAGE check?  I mean:

> @@ -3364,8 +3364,8 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  		/* ->mapping in first and second tail page is replaced by other uses */
>  		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping != TAIL_MAPPING,
>  			       new_head);

		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_folio->mapping != TAIL_MAPPING, new_head);

(or we could just ditch the assert entirely; it's not all that useful)

> -		new_head->mapping = head->mapping;
> -		new_head->index = head->index + index;
> +		new_folio->mapping = head->mapping;
> +		new_folio->index = head->index + index;

	new_folio->mapping = folio->mapping
	new_folio->index = folio->index +index;

(um, and that index + index looks weird; better name might be just 'i')


