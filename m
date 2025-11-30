Return-Path: <linux-kselftest+bounces-46751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB364C94EB8
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 12:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62C894E144E
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 11:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790E322B5AD;
	Sun, 30 Nov 2025 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTGISrlJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDA4A23;
	Sun, 30 Nov 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764500716; cv=none; b=ONr9fMMI3M6KBYpaDhRRQVkUANQZIZAkMoHS1Vsv9CZBy3DbPfiS2nI3hHt5JjGIU4a9yfg57UtYrNZLAgovBUD80i1heuRhxQsD1XwNr5mULFUe2Qb8M7+sL48/0mhFFMnI/XAZEA+koMKIUOwOBiPfg34op/tsXISdJ2HfylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764500716; c=relaxed/simple;
	bh=WgF209hVGnuhzCWEOErtx6btmHGTsEcP7tri0M2RCX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMKJVcmngJtyaZ6Oa/yhpD/lsCorDdm4Sqfzyeeet0yyfMPWH3csv5TwtsvKWMWcJp6RSr1ZnVwY7x4XK8XWiPHyCDkBR8E3DQPtDsOWz/VubrQgywaQbYHbbIcrElvifJnv5E3FFIbQ675jX9MKYNxFkaUQ/Kau8Vqx5Akkmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTGISrlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2718C4CEF8;
	Sun, 30 Nov 2025 11:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764500714;
	bh=WgF209hVGnuhzCWEOErtx6btmHGTsEcP7tri0M2RCX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTGISrlJ0lGzN7zs3GC7hlj8AU+zkROh5RBFD2dy9dKebTpAxzlGMxMFOPBSIaPc4
	 m1iH9EYA5JkkCr+RLJKhgtF0R8Ku+BHjMP8sEulJDHVGYL1IWaZLxmBl4zHvYOE+Rv
	 1l50sLIlMgdXYqaVooXB3EhlUMY8VgKqKzlXy/kgHjnMhBjSfy1QatN6CaF4c5FlVf
	 viwMzE7w1Wvyo38nJ3Djrc+BfCyX8sJvB1wmqREVXwUigN0CpHRsby7Am+hiAbJS+A
	 8SqzUXKncccjYNK7DYX/ZjnZAs+cd/6Q4Nr5P7HSa50WSyTg0RIxQMgX4q01fmIFos
	 l4Hz5zEDcRLGA==
Date: Sun, 30 Nov 2025 13:05:04 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: Re: [PATCH v2 3/5] mm: introduce VM_FAULT_UFFD_MINOR fault reason
Message-ID: <aSwk4IGY7zdb0cwd@kernel.org>
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-4-rppt@kernel.org>
 <aSYBrH_xfMfs6yDW@x1.local>
 <aSgzcpFP1qBda5ef@kernel.org>
 <aShb8J18BaRrsA-u@x1.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aShb8J18BaRrsA-u@x1.local>

On Thu, Nov 27, 2025 at 09:10:56AM -0500, Peter Xu wrote:
> On Thu, Nov 27, 2025 at 01:18:10PM +0200, Mike Rapoport wrote:
> > On Tue, Nov 25, 2025 at 02:21:16PM -0500, Peter Xu wrote:
> > > Hi, Mike,
> > > 
> > > On Tue, Nov 25, 2025 at 08:38:38PM +0200, Mike Rapoport wrote:
> > > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > > 
> > > > When a VMA is registered with userfaulfd in minor mode, its ->fault()
> > > > method should check if a folio exists in the page cache and if yes
> > > > ->fault() should call handle_userfault(VM_UFFD_MISSING).
> > > 
> > > s/MISSING/MINOR/
> > 
> > Thanks, fixed. 
> > 
> > > > new VM_FAULT_UFFD_MINOR there instead.
> > > 
> > > Personally I'd keep the fault path as simple as possible, because that's
> > > the more frequently used path (rather than when userfaultfd is armed). I
> > > also see it slightly a pity that even with flags introduced, it only solves
> > > the MINOR problem, not MISSING.
> > 
> > With David's suggestion the likely path remains unchanged.
> 
> It is not about the likely, it's about introducing flags into core path
> that makes the core path harder to follow, when it's not strictly required.
 
	ret = vma->vm_ops->fault(vmf);
	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
			    VM_FAULT_DONE_COW | VM_FAULT_UFFD_MINOR))) {
		if (ret & VM_FAULT_UFFD_MINOR)
			return handle_userfault(vmf, VM_UFFD_MINOR);
		return ret;
	}

isn't hard to follow and it's cleaner than adding EXPORT_SYMBOL that is not
strictly required.

> Meanwhile, personally I'm also not sure if we should have "unlikely" here..
> My gut feeling is in reality we will only have two major use cases:
> 
>   (a) when userfaultfd minor isn't in the picture
> 
>   (b) when userfaultfd minor registered and actively being used (e.g. in a
>       postcopy process)
> 
> Then without likely, IIUC the hardware should optimize path selected hence
> both a+b performs almost equally well.

unlikely() adds a branch that hardware will predict correctly if
UFFD_MINOR is actively used.

But even misspredicted branch is nothing compared to putting a task on a
wait queue and waiting for userspace to react to the fault notification
before handle_userfault() returns the control to the fault handler.
 
> Just to mention, if we want, I think we have at least one more option to do
> the same thing, but without even introducing a new flag to ->fault()
> retval.
> 
> That is, when we have get_folio() around, we can essentially do two faults
> in sequence, one lighter then the real one, only for minor vmas, something
> like (I didn't think deeper, so only a rough idea shown):
> 
> __do_fault():
>   if (uffd_minor(vma)) {
>     ...
>     folio = vma->get_folio(...);
>     if (folio)
>        return handle_userfault(vmf, VM_UFFD_MINOR);
>     // fallthrough, which imply a cache miss
>   }
>   ret = vma->vm_ops->fault(vmf);

That's something to consider for the future, especially if we'd be able to
pull out MISSING handling as well from ->fault() handlers.

> Thanks,
> -- 
> Peter Xu

-- 
Sincerely yours,
Mike.

