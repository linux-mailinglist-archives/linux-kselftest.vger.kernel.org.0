Return-Path: <linux-kselftest+bounces-46628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1792BC8DF61
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 12:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8699A4E7779
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 11:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E3A32C336;
	Thu, 27 Nov 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnqFtZWD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D2D32B9B4;
	Thu, 27 Nov 2025 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242302; cv=none; b=BHWeVAb48jLTxJFL6ndwRhnBKYt3lsu8Z/vewDBtSBVZnWws2k6VSrA5iM9vaPG95TnVNByUwJCZacam2zpfGeHwiFwr6C4vQZi2VnSkOtBeiLQiIaWZ2T4nMVEa4kPQyZkVEo2+hr69ZTCcLYmYTcWn+VEsa1V5VQNIOEa5mps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242302; c=relaxed/simple;
	bh=LGIVtxajxKFoRcUUjJf+GTVcZh6OJXHRfbkkB9FrCW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrXyAmnunZ6jF/dEuiNDo5KX2sWrHduYCDVaFzVKII1UJ2MdzIH0DtHOc1fXOS/4Li9Khnqwn+IZGSMfBPuwGnvrSmgqbTPFqiiFGd04p3prYcULsek0/VdPh06YdpgruNpvqNtWWkZaM3aTimXV7IJeTC5JwlSWWnwcjYERY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnqFtZWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAA0C4CEF8;
	Thu, 27 Nov 2025 11:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764242301;
	bh=LGIVtxajxKFoRcUUjJf+GTVcZh6OJXHRfbkkB9FrCW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnqFtZWDotDk1h+8DKJczwnhvfeDRKlb5rj1/zSdBmYiKSz8nz78NxKpSyPtHeUdu
	 4n8L4Zd2gwlN/B7LPcFoZyS/zWBZXIv9OMpMIFYn71ZaER/U5xSNynksfK0sM/XxgB
	 YgehyVIJixQt0yYyutGkCdsw9Zd17a00okzKK4aj7IPBjRy0905NjNYpwyleZGqwYa
	 M4Dbkn+DHnFDyZ1VC9l2lWarWa6HrCoitN/w/rxXyKDjrYuxWaWBrZGdly1ctiDQMR
	 xF8qUP8fHzba9Df2M7ahFMZ3bMHUXoIpUZpDd3OPmk2ndqD0XUMvJBopJIapbLfyIE
	 BeUlxurO7d9Rw==
Date: Thu, 27 Nov 2025 13:18:10 +0200
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
Message-ID: <aSgzcpFP1qBda5ef@kernel.org>
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-4-rppt@kernel.org>
 <aSYBrH_xfMfs6yDW@x1.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSYBrH_xfMfs6yDW@x1.local>

On Tue, Nov 25, 2025 at 02:21:16PM -0500, Peter Xu wrote:
> Hi, Mike,
> 
> On Tue, Nov 25, 2025 at 08:38:38PM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > When a VMA is registered with userfaulfd in minor mode, its ->fault()
> > method should check if a folio exists in the page cache and if yes
> > ->fault() should call handle_userfault(VM_UFFD_MISSING).
> 
> s/MISSING/MINOR/

Thanks, fixed. 

> > new VM_FAULT_UFFD_MINOR there instead.
> 
> Personally I'd keep the fault path as simple as possible, because that's
> the more frequently used path (rather than when userfaultfd is armed). I
> also see it slightly a pity that even with flags introduced, it only solves
> the MINOR problem, not MISSING.

With David's suggestion the likely path remains unchanged.

As for MISSING, let's take it baby steps. We have enough space in
vm_fault_reason for UFFD_MISSING if we'd want to pull handle_userfault()
from shmem and hugetlb.
 
> If it's me, I'd simply export handle_userfault()..  I confess I still don't
> know why exporting it is a problem, but maybe I missed something.

It's not only about export, it's also about not requiring ->fault()
methods for pte-mapped memory call handle_userfault().

> Only my two cents.  Feel free to go with whatever way you prefer.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 

-- 
Sincerely yours,
Mike.

