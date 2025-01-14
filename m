Return-Path: <linux-kselftest+bounces-24441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889BAA104E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 12:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9327D162EA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DB11ADC98;
	Tue, 14 Jan 2025 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI/Onrdp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9035720F96B;
	Tue, 14 Jan 2025 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852492; cv=none; b=p+3cOoz7ClVfVDD9kS7x67aA6u1Usif06li0tVjrlFRStwT89Bc/xRKbViy5G/atDBOavFFjdpLtddNNsR2hoM0sTvFGcksCXhJP8d6iaPUxHSPKHH6CGlnt5PKIcTVmypKNhl+Qz/EdbWqXetLSoejka6bTBSgglZnkefPpkHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852492; c=relaxed/simple;
	bh=mbHS99/jEJpIbZomuQgs7L8z3N8P/BZq6eKT12MfMQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2LQQEwKtgq8Pee2KopNVvgd/DKY+X19GqmZEKcRAlTI1LMkENYU1T+CvM9ay8dGrD3qz0nxlbXCjoRVyOqNSc7oFKqdLTStsWBsvRCU/TdPblimoYHlmzjWsqjazmKuqXOTDZEBwp2Tgmg+H8TBSFLGsHZ48E6gvEJ+jslKIDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI/Onrdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165CBC4CEDD;
	Tue, 14 Jan 2025 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736852491;
	bh=mbHS99/jEJpIbZomuQgs7L8z3N8P/BZq6eKT12MfMQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MI/OnrdpyPjreb29TH1K7V92pcHREffE7EWvZPPD/CQnZx1Z2V//mN5/XO4rnjbEe
	 woLKU+r4vDndmePFt/UZIgxmh04ThYr+z9+zfQj21ZNN0sl7KCp2Vl8WVb5SvZllou
	 4etv5w5vUXrxnghs9U7tvjY3Mc+wDwzBs1zXG7Rvuizz8c5KbCSfqZS819UY64k+/Q
	 H31n0Pp7yvSpueyJuMPlw2CrvcLTpEOUxOjLbaOuXtftRTndUinQPNSWPDgB+/nHR9
	 1M3LhDFViqSxB+C7+9/3HG8tin4pDD8Gja9UlC/e1cGrVOu9nP1kn14oZvA5k7neLT
	 OIf9MZ4k/uWTA==
Date: Tue, 14 Jan 2025 13:01:09 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Gomez <da.gomez@samsung.com>,
	Daniel Thompson <danielt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Gow <davidgow@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Rae Moar <rmoar@google.com>, Richard Weinberger <richard@nod.at>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	live-patching@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/8] x86/mm/pat: Restore large pages after fragmentation
Message-ID: <Z4ZD9exBt-JQiuS6@kernel.org>
References: <20241227072825.1288491-1-rppt@kernel.org>
 <20241227072825.1288491-4-rppt@kernel.org>
 <jut35igb2kstpz24apqdeubv5rvyl3vmp2s43xtivpz54uiedj@wmd2onulv4xw>
 <Z4ODVmnC4fDnIUSN@kernel.org>
 <sivhweds7p5sst2jpxanrj6qc7wlonqkod64nsr5cgttma7ntp@bhqespo3jdqz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sivhweds7p5sst2jpxanrj6qc7wlonqkod64nsr5cgttma7ntp@bhqespo3jdqz>

On Mon, Jan 13, 2025 at 10:01:13AM +0200, Kirill A. Shutemov wrote:
> On Sun, Jan 12, 2025 at 10:54:46AM +0200, Mike Rapoport wrote:
> > Hi Kirill,
> > 
> > On Fri, Jan 10, 2025 at 12:36:59PM +0200, Kirill A. Shutemov wrote:
> > > On Fri, Dec 27, 2024 at 09:28:20AM +0200, Mike Rapoport wrote:
> > > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > > 
> > > > Change of attributes of the pages may lead to fragmentation of direct
> > > > mapping over time and performance degradation as result.
> > > > 
> > > > With current code it's one way road: kernel tries to avoid splitting
> > > > large pages, but it doesn't restore them back even if page attributes
> > > > got compatible again.
> > > > 
> > > > Any change to the mapping may potentially allow to restore large page.
> > > > 
> > > > Hook up into cpa_flush() path to check if there's any pages to be
> > > > recovered in PUD_SIZE range around pages we've just touched.
> > > > 
> > > > CPUs don't like[1] to have to have TLB entries of different size for the
> > > > same memory, but looks like it's okay as long as these entries have
> > > > matching attributes[2]. Therefore it's critical to flush TLB before any
> > > > following changes to the mapping.
> > > > 
> > > > Note that we already allow for multiple TLB entries of different sizes
> > > > for the same memory now in split_large_page() path. It's not a new
> > > > situation.
> > > > 
> > > > set_memory_4k() provides a way to use 4k pages on purpose. Kernel must
> > > > not remap such pages as large. Re-use one of software PTE bits to
> > > > indicate such pages.
> > > > 
> > > > [1] See Erratum 383 of AMD Family 10h Processors
> > > > [2] https://lore.kernel.org/linux-mm/1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com/
> > > > 
> > > > [rppt@kernel.org:
> > > >  * s/restore/collapse/
> > > >  * update formatting per peterz
> > > >  * use 'struct ptdesc' instead of 'struct page' for list of page tables to
> > > >    be freed
> > > >  * try to collapse PMD first and if it succeeds move on to PUD as peterz
> > > >    suggested
> > > >  * flush TLB twice: for changes done in the original CPA call and after
> > > >    collapsing of large pages
> > > > ]
> > > > 
> > > > Link: https://lore.kernel.org/all/20200416213229.19174-1-kirill.shutemov@linux.intel.com
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > 
> > > When I originally attempted this, the patch was dropped because of
> > > performance regressions. Was it addressed somehow?
> > 
> > I didn't realize the patch was dropped because of performance regressions,
> > so I didn't address it.
> > 
> > Do you remember where did the regressions show up?
> 
> https://github.com/zen-kernel/zen-kernel/issues/169
> 
> My understanding is if userspace somewhat frequently triggers set_memory_*
> codepath we will get a performance hit.

This version of the patch will cause smaller performance hit because it
does not scan an entire PUD every time collapse_large_pages() is called.

Still, when I tweaked cpa-test to take some time measurements I see about
60% increase in the time it takes to perform set_memory operations.

Since we only really care about restoring large pages for ROX mapping, I'm
going to update the patch so that we'll try to collapse large pages only
from set_memory_rox().
 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

-- 
Sincerely yours,
Mike.

