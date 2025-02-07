Return-Path: <linux-kselftest+bounces-25999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F37BA2C52A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 15:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E1D162600
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DA223ED51;
	Fri,  7 Feb 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rMcoJToQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164D2206A0;
	Fri,  7 Feb 2025 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938348; cv=none; b=f6JDX/9irg6m684YcVFe6rwX5DvTIUkBwPtYTWOsvfHxxUJLeYGtbqHGGzQSNL+PCOW5B40pgcnRsZk2cW0zbmpqJa1l110+JOfdUezz3FfICjxFUZkMSnwODusijRT6CLVypmVGLaXORisTQKgj2ADsqD7CMZZzpZC7ox0PsKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938348; c=relaxed/simple;
	bh=lYLFGBWIHjf50mEl4tQ0Kf+suDLeghiTpv96c18Z6UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWRXVUHOUYILFJsekwxikDPMm9bAJ3ATHp8xbRfTKSZTm2txlVVg7bz9TxhK+umahU3fRplDIqKROAzFpimFeRPgr1ICVBBwTZPCwKVkoIYGAehIZ5Hwo3C0lcQZpVwNb81Z1rpjNgl3WkkCjJI1F7A7nYL8fSBJMvTTW7pM2xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rMcoJToQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yMVdJszBaJdWZfMzBrdhAbDbfib9SbTXaAtSt2p0jvA=; b=rMcoJToQeFy2UP+/3OdmTSurWq
	61Ai1zOjD8PuYuT7Sm2uHn4y7NjxDjg4VyI1gJnjul/40si7h50+iAaqCbxHb/EDyG4+pEpooDsxZ
	jt4tiyrKhyvATVcsFtPXZAQ5b1/2hQSdXL2V9YJ16x+OyAk1Qzc/igbyIayLW5oMxj5uwnMwSTcSE
	HXA56gRV0Ygxhcs1oboCqBy6zZdfL8pKs0DduY3SD6g0cFAlMUayMvxi0atuu7zJlYwJir17wAvj3
	dVmNwihsONhWCAkivxFgYeDYjXdn6X6dYf7A0wDk4kSBohYrfjFQskqLSBY0TJX5IRJHZn6Fv0Mz8
	5D4X3ypQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgPIT-00000007wru-2G8d;
	Fri, 07 Feb 2025 14:25:33 +0000
Date: Fri, 7 Feb 2025 14:25:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Buddy allocator like (or non-uniform) folio split
Message-ID: <Z6YX3RznGLUD07Ao@casper.infradead.org>
References: <20250205031417.1771278-1-ziy@nvidia.com>
 <20250206000111.6c54e67d1933f8bbc01a46cd@linux-foundation.org>
 <019EB6CA-0F4B-496A-B2AE-A3A553585281@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <019EB6CA-0F4B-496A-B2AE-A3A553585281@nvidia.com>

On Fri, Feb 07, 2025 at 09:11:39AM -0500, Zi Yan wrote:
> Existing uniform split requires 2^(order % XA_CHUNK_SHIFT) xa_node allocations
> during split, when the folio needs to be split to order-0. But non-uniform split
> only requires at most 1 xa_node allocation. For example, to split an order-9
> folio, 8 xa_nodes are needed for uniform split, since the folio takes 8
> multi-index slots in the xarray. But for non-uniform split, only the slot
> containing the given struct page needs a xa_node after the split. There will be
> a 7 xa_node saving.
> 
> Hi Matthew,
> 
> Do you mind checking my statement above on xarray memory saving? And correct me
> if I miss anything. Thanks.

We currently have a bug where we can't split order-12 (or above) to order-0 (or anything in the range 0-5) as we'd need to allocate two layers of nodes, and
the preallocation can't do that.

As part of your series, I'd like to remove that limitation, so we'd need
to allocate log_64(n - m) [ok, more complex than that, but ykwim].  So
it's not quite "only allocate one node", but it's allocate O(log(current
number of nodes needed to be allocated)).

Makes sense?

