Return-Path: <linux-kselftest+bounces-46664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CEEC8FFBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 20:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62C73345C20
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 19:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE37D285C9F;
	Thu, 27 Nov 2025 19:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIycxaNB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13CC23EABB;
	Thu, 27 Nov 2025 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270290; cv=none; b=edPIHBizE9M8RtG2mq0nRaKyaNRiFpXSica7fxY63+8+Tg4AKKLNGhWGtoClry75ThsJllWH+IEVrSShuKl1obcuMfHEFBENEGGoaUXr8whWZ3bAcbeWK1WKBviWzrrrGfkVntDSiutSXU1j+2WZ+tFLtHNYt67NWeYdrvJia/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270290; c=relaxed/simple;
	bh=DKQJFcgXS2cAkuVWuUAaSZGMToD5A3+53/sdzCkk5ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hrihs7atAUtrnzmVS/12IL3CUxJB1baTljJIVUbWwRMXYesjNXaPxiShX4wONcWJy9+80bibj5AVAjXFkncdo9sbL8P1nCYDHvq0KL/ip6Pg+va/9ZjBul8nIesyZXOsWE8szBAJmso6SuNNzU2It8JP8eEJu3KU6iQklJSUARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIycxaNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FE1C4CEF8;
	Thu, 27 Nov 2025 19:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764270289;
	bh=DKQJFcgXS2cAkuVWuUAaSZGMToD5A3+53/sdzCkk5ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIycxaNBmymUyYVPRVNpQfUciz6q+rLYzWJyLq+mNWaoVMAJTeg61TF8etU7tV6QY
	 sN0S0gBrAIJAlMdFdc78LUM48Wwy9qh70KqEcftBiR3FUbeSfBtye8DaQckUxi+SuD
	 qCdNyHiq5JiHjgSuOLpp5ECN1Ze3VIN+OmvaCLf6vd6nglkyyB2I3a6KhRuBBqPuKJ
	 vUnnFJKmPU0FNaAIlXFL+V3KGahD/iK8WsCI9JxKWVugqJVnDk+1N5Erm5ah3Rijtd
	 F3d9D/FtSTcQVWJkNax1JqCAC8hTJrqfS/cpz5elx84W7z2kHgbU2tPkJcxJ44jBUI
	 HpuljhS5Pe+hw==
Date: Thu, 27 Nov 2025 21:04:40 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/5] guest_memfd: add support for userfaultfd minor
 mode
Message-ID: <aSigyHj01snbfii7@kernel.org>
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-5-rppt@kernel.org>
 <bafb0c9e-9ce6-4294-b1d6-e32c41635add@amazon.com>
 <aSgpo1_ZSmxf84-p@kernel.org>
 <13d3a7a4-5cf8-4fbe-8dba-d565525a71c6@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13d3a7a4-5cf8-4fbe-8dba-d565525a71c6@amazon.com>

On Thu, Nov 27, 2025 at 11:19:35AM +0000, Nikita Kalyazin wrote:
> 
> 
> On 27/11/2025 10:36, Mike Rapoport wrote:
> > On Wed, Nov 26, 2025 at 04:49:31PM +0000, Nikita Kalyazin wrote:
> > > On 25/11/2025 18:38, Mike Rapoport wrote:
> > > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > > 
> > > > +#ifdef CONFIG_USERFAULTFD
> > > > +static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t pgoff)
> > > 
> > > We have to name it differently, otherwise it clashes with the existing one
> > > in this file.
> > 
> > It's all David's fault! ;-P
> > How about kvm_gmem_get_prepared_folio() ?
> 
> I'm afraid it may not be ideal due to preparedness tracking being removed
> from guest_memfd at some point [1].  Would it be too bad to add an
> indication to userfaultfd in the name somehow given that it's already
> guarded by the config?

Hmm, shmem also has this clash. There I picked shmem_get_folio_noalloc()
because that describes well what it does: lookup folio in the page cache,
grab it if it's there or return -ENOENT if it's missing.
That's also what hugetlb does for uffd minor fault.

The guest_memfd implementation I copied from one of the older postings
allocates the folio if it's not in the page cache and it seems to me that
it also should only look up existing folios to keep uffd minor semantics
uniform.
 
Then it makes sense also to name the vm_ops method get_folio_noalloc().

-- 
Sincerely yours,
Mike.

