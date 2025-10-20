Return-Path: <linux-kselftest+bounces-43572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D4EBF2E2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E01E34F7D04
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 18:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23D2C2363;
	Mon, 20 Oct 2025 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZtyQQ3n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9E1C3C11;
	Mon, 20 Oct 2025 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983987; cv=none; b=W0NKZAvxFBc9xV8gUWEtdS5CdnGidsXL2xeEMsy43Jgmurlo4FkDx5jzSbKUErnPHUrzZeknivT2JwJ/iy0Ki1BhMYzU5h5jH7xGKLPyZuMV6tAW241LerLazY4DSEM0EVrpW2oA660DqIxq3GtDBtY/6B3bYqe4H4ZPAPcGMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983987; c=relaxed/simple;
	bh=j7luj4XAb4ynLV8eONK0lTkWrRoe+RhoyCODmNv+y1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2nMWGn89uU5OkZfMYLPfNJKgOpg3uG3IkD1jE0MLe2RWvtfhafQUqleiqGKZ53d/35fyKQC2E4l0ycYf8FpEtlhM+e4vF4e0B1+WtcqbkTf6aFQliAfRZuKos1eJoSo3w91dMfKPsMzYwk33fovLTBzWDq90j/HOpQBbZEwDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZtyQQ3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2739BC4CEF9;
	Mon, 20 Oct 2025 18:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760983986;
	bh=j7luj4XAb4ynLV8eONK0lTkWrRoe+RhoyCODmNv+y1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZtyQQ3nD5oN+qtaEmIPfZybDgLjmIo0NNlWUgDn+gwy+1fGDCazcDPtuxajmmLkJ
	 mFrSnihA0DIRn10GaytskPJlK+7+zvVcGmuHYAtAaAYUZ6tey/ddGIBFa9iy5HNjW9
	 8vsPUSfR6nh7clRy41g/MnzRjtRLPowuK0xwRiyBG2zVm7IYEi8/+OxbtTbmffk9QJ
	 LLc598HBkww2ZlDBkDm0skDd6DClFK6Ojpt9ZUuPnNptCWLrQ9e4On5ab08izr5svZ
	 9LEHOZueUJzBtluHXKXOAm0irIbra43PmnuEurT8vYGAEFSRRthrKKb40WstS0jmod
	 aC77Vz9N3UQSg==
Date: Mon, 20 Oct 2025 21:12:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, jasonmiu@google.com,
	dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH v6 00/10] liveupdate: Rework KHO for in-kernel users &
 Fix memory corruption
Message-ID: <aPZ7qa-Gs4OPLhsT@kernel.org>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
 <aPXz-IPDRniMHN0u@kernel.org>
 <CA+CK2bDMc8RdcNq_qmmW02DNzLePxQNWBgdOuwrfJ=jmr0YK8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDMc8RdcNq_qmmW02DNzLePxQNWBgdOuwrfJ=jmr0YK8w@mail.gmail.com>

On Mon, Oct 20, 2025 at 09:46:17AM -0400, Pasha Tatashin wrote:
> On Mon, Oct 20, 2025 at 4:34 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Sat, Oct 18, 2025 at 01:17:46PM -0400, Pasha Tatashin wrote:
> > > This series addresses comments and combines into one the two
> > > series [1] and [2], and adds review-bys.
> > >
> > > This series refactors the KHO framework to better support in-kernel
> > > users like the upcoming LUO. The current design, which relies on a
> > > notifier chain and debugfs for control, is too restrictive for direct
> > > programmatic use.
> > >
> > > The core of this rework is the removal of the notifier chain in favor of
> > > a direct registration API. This decouples clients from the shutdown-time
> > > finalization sequence, allowing them to manage their preserved state
> > > more flexibly and at any time.
> > >
> > > Also, this series fixes a memory corruption bug in KHO that occurs when
> > > KFENCE is enabled.
> > >
> > > The root cause is that KHO metadata, allocated via kzalloc(), can be
> > > randomly serviced by kfence_alloc(). When a kernel boots via KHO, the
> > > early memblock allocator is restricted to a "scratch area". This forces
> > > the KFENCE pool to be allocated within this scratch area, creating a
> > > conflict. If KHO metadata is subsequently placed in this pool, it gets
> > > corrupted during the next kexec operation.
> > >
> > > [1] https://lore.kernel.org/all/20251007033100.836886-1-pasha.tatashin@soleen.com
> > > [2] https://lore.kernel.org/all/20251015053121.3978358-1-pasha.tatashin@soleen.com
> > >
> > > Mike Rapoport (Microsoft) (1):
> > >   kho: drop notifiers
> > >
> > > Pasha Tatashin (9):
> > >   kho: allow to drive kho from within kernel
> > >   kho: make debugfs interface optional
> > >   kho: add interfaces to unpreserve folios and page ranes
> > >   kho: don't unpreserve memory during abort
> > >   liveupdate: kho: move to kernel/liveupdate
> > >   kho: move kho debugfs directory to liveupdate
> > >   liveupdate: kho: warn and fail on metadata or preserved memory in scratch area
> > >   liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
> > >   liveupdate: kho: allocate metadata directly from the buddy allocator
> >
> > The fixes should go before the preparation for LUO or even better as a
> > separate series.
> >
> > I've reread the LUO preparation patches and I don't think they are useful
> > on their own. They introduce a couple of unused interfaces and I think it's
> > better to have them along with the rest of LUO patches.
> 
> Pulling them out to apply fixes separately feels counterproductive,
> especially since we agreed to add the new kexec_handover_debug.c file.
> The most straightforward path is to build on what's already in -next.
> Let's stick with the current approach.

The fixes are 6.18 material, the LUO preparation is 6.19 material.
 
> Thanks,
> Pasha
> 
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.

