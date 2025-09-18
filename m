Return-Path: <linux-kselftest+bounces-39832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF00B3443C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEAD17F5C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522262FE561;
	Mon, 25 Aug 2025 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7YZsnMU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05212FE581;
	Mon, 25 Aug 2025 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132362; cv=none; b=rvaKFmxPUXNMBH2MAesz5Qlpp/xkFerUU/SKfTXcIoOtlqi/YtFO9qUgSjde1sEIck4M0f9LjgFbLzGFxb5rEvRBuXjB6DUdWyWUBhPQ8m85JpvwgUQojiBmfA/49tA3flosM8W6RLpXW2O3I2NrUXZNy4Z0HyIncL44H02QLBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132362; c=relaxed/simple;
	bh=DU+1S4Dtf6BzIA9TMfJpqm5TRVwGVofXB+Dj9RHsm1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5U2W8teEHwEHSAEReWUSuboArGJz/KcccWbLgRYbbEqsTqBX7LtXHdcNag1oRJzbwFhEryM52hhe0TnA5ZWLQyqFZVJgJ3hsiVibG+jzAkGTNAQkhNYKhjeeNexmu3cbMcSiMUUWrzRocKGYTpXeRxqMADeLqRxW5OjwxAsRf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7YZsnMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28395C4CEED;
	Mon, 25 Aug 2025 14:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756132360;
	bh=DU+1S4Dtf6BzIA9TMfJpqm5TRVwGVofXB+Dj9RHsm1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7YZsnMUaPKieR6Aen8NXplrqXq649ng2cWds08Paw0ZE1V9/s04MYuzfMJunBPPM
	 e9q5l/4IYbHR+zLW6tZ3Ain+SM/EPsptEidQNiwcBG+gIXbD0MDb3NpuMIodH9q/bK
	 gfUkw7ZqtLUllteesZei9c9/9Nob4tERnp37xBWgOfA8ssretvfGAj7ddnS1nJ/eSw
	 gYK9m1P9+EEv6DvwLeTd0I1ynl3rIVfEsEIPpMbPhXNcaQgQQCdndA/xeV7DIotpxx
	 J60e7ZU1ZivKd3L40DdBa/CHbHS/SOS0E/lE/sJu2Rz1DevUCKw6IvTf/zpKfAvZXV
	 BIxp/l6R3haNQ==
Date: Mon, 25 Aug 2025 17:32:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
	linux-kernel@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, iommu@lists.linux.dev,
	io-uring@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com,
	kvm@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH RFC 10/35] mm/hugetlb: cleanup
 hugetlb_folio_init_tail_vmemmap()
Message-ID: <aKxz9HLQTflFNYEu@kernel.org>
References: <20250821200701.1329277-1-david@redhat.com>
 <20250821200701.1329277-11-david@redhat.com>
 <9156d191-9ec4-4422-bae9-2e8ce66f9d5e@redhat.com>
 <7077e09f-6ce9-43ba-8f87-47a290680141@redhat.com>
 <aKmDBobyvEX7ZUWL@kernel.org>
 <a90cf9a3-d662-4239-ad54-7ea917c802a5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a90cf9a3-d662-4239-ad54-7ea917c802a5@redhat.com>

On Mon, Aug 25, 2025 at 02:48:58PM +0200, David Hildenbrand wrote:
> On 23.08.25 10:59, Mike Rapoport wrote:
> > On Fri, Aug 22, 2025 at 08:24:31AM +0200, David Hildenbrand wrote:
> > > On 22.08.25 06:09, Mika Penttil� wrote:
> > > > 
> > > > On 8/21/25 23:06, David Hildenbrand wrote:
> > > > 
> > > > > All pages were already initialized and set to PageReserved() with a
> > > > > refcount of 1 by MM init code.
> > > > 
> > > > Just to be sure, how is this working with MEMBLOCK_RSRV_NOINIT, where MM is supposed not to
> > > > initialize struct pages?
> > > 
> > > Excellent point, I did not know about that one.
> > > 
> > > Spotting that we don't do the same for the head page made me assume that
> > > it's just a misuse of __init_single_page().
> > > 
> > > But the nasty thing is that we use memblock_reserved_mark_noinit() to only
> > > mark the tail pages ...
> > 
> > And even nastier thing is that when CONFIG_DEFERRED_STRUCT_PAGE_INIT is
> > disabled struct pages are initialized regardless of
> > memblock_reserved_mark_noinit().
> > 
> > I think this patch should go in before your updates:
> 
> Shouldn't we fix this in memblock code?
> 
> Hacking around that in the memblock_reserved_mark_noinit() user sound wrong
> -- and nothing in the doc of memblock_reserved_mark_noinit() spells that
> behavior out.

We can surely update the docs, but unfortunately I don't see how to avoid
hacking around it in hugetlb. 
Since it's used to optimise HVO even further to the point hugetlb open
codes memmap initialization, I think it's fair that it should deal with all
possible configurations.
 
> -- 
> Cheers
> 
> David / dhildenb
> 
> 

-- 
Sincerely yours,
Mike.

