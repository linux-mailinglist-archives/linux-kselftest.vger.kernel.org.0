Return-Path: <linux-kselftest+bounces-28654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2DA59B19
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 17:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1165A188A65D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE5122FAE2;
	Mon, 10 Mar 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ISmtK6gV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C853F22FF2D;
	Mon, 10 Mar 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624435; cv=none; b=SyTJgnleC1cceJ8c7BCBnYmZd9v47/LOeBqOi8bJgaSUfNmqC3amwWrIuKLu3zIK0Bn63Lw4zIFU3UYTfF8L689Sq4c/bUXNrVXgJmNBANAvfjlsoKHNjpzLhar+c8yhZjPYcQJ7aJ2rmNRZDeZNDeXTNvfOvjD+qg0/Y7ugnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624435; c=relaxed/simple;
	bh=3MbpoHwz4gL4UycC9nI0SxkvREtLTRj8DTNv2BjlwqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKH8VUPAMsk96r4BWMrnt2/MgaKu9aDXJvM/rxr/5c6wPV5EH7TXNm+xqIpPckb4Ta5UoKVzq89+VLnwMHJVzEfy+kLZwPFwEMaY1Ea1NZHgv3Uqs1KTLoOIfuFL09QH9Z/W3bfrnReDdTMPkTdvCZ2s7CRzYxZ0yJ/CHmXat1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ISmtK6gV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LHayvruvcLdCRNT9x1CRWeT1ZbcCZUlRZK8ttqKJaZ0=; b=ISmtK6gVZ0PMNKDMM1+WUDosMa
	NgaJwAcb5eeWZN0VQi3410hQRQOt9x2U2ekqd5YtLYA3wgJDe2p/3jneWwO376G22fyPiWvA0Q9PL
	1uWsFTcIoGmsXmcLoptrfxCt86S0K4kOnhg3BFS3BwotM810y70VUWYjP1jgEWMg+vaIhCxdXFfpQ
	9Bk+mI4lX01nrjswysWszI08rSNsK3FdXT0pI0PVx5O1bxpL8cH5cIjRZtmzeHuVnMhaXRZpRa//T
	KrcfC8Ue4zgBgMmHKyutqSrQBC6qLpXX26LUaUi7Ah9nmJnuNClRWZIRvzaClDditArLlfi8qVZq7
	lsE3vcqA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1trg1L-00000007uwg-1OoT;
	Mon, 10 Mar 2025 16:30:49 +0000
Date: Mon, 10 Mar 2025 16:30:26 +0000
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
Message-ID: <Z88ToirSWa_meevw@casper.infradead.org>
References: <20250307174001.242794-1-ziy@nvidia.com>
 <20250307174001.242794-3-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307174001.242794-3-ziy@nvidia.com>

On Fri, Mar 07, 2025 at 12:39:55PM -0500, Zi Yan wrote:
> +	for (index = new_nr_pages; index < nr_pages; index += new_nr_pages) {
> +		struct page *head = &folio->page;
> +		struct page *new_head = head + index;
> +
> +		/*
> +		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
> +		 * Don't pass it around before clear_compound_head().
> +		 */
> +		struct folio *new_folio = (struct folio *)new_head;
[...]
> +		/* ->mapping in first and second tail page is replaced by other uses */
> +		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping != TAIL_MAPPING,
> +			       new_head);
> +		new_head->mapping = head->mapping;
> +		new_head->index = head->index + index;

Why are you using new_head->mapping and ->index instead of new_folio?


