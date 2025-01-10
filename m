Return-Path: <linux-kselftest+bounces-24234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CC6A09BB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 20:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F030F188BF39
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 19:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532FE2135A8;
	Fri, 10 Jan 2025 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVSbNBfB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2AA24B248;
	Fri, 10 Jan 2025 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536715; cv=none; b=CtK0z6iKeVRdQVCFrA7wQeWIEphwWEFLAbkSTvTEwBPqqmwukLQjHI3lYudgrVWvquAqjc9Eu8yjPPJnPlkAUqroKj9N5l759VZT29uq2ie7cgR0eupNsqeH7R21a1EmpmUwNPRm3LxqYkSYSt3ZHszNxhIMT7ewFGChCzGJJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536715; c=relaxed/simple;
	bh=2qtn/yN8KGnvKM4Be6ymIMRepfChNk260BsIzmavFNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcOx9WM7MED90MDfxMUQ/dAwQs8WXGn23K5YOIhd3gQPtA3x1TlfMPguVxVqdgdc9GF2d//U2dbZI+YrTb6Wqk8cYxFTico3veMUares8+ZcZMMDz2GoHv0GWopwOirMNijPAAjxhX837+s4OpU8HtgqKG5A5LZ9wegR3WNb9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVSbNBfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2BDC4CED6;
	Fri, 10 Jan 2025 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736536714;
	bh=2qtn/yN8KGnvKM4Be6ymIMRepfChNk260BsIzmavFNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVSbNBfBgiPxfs3j9J4+Q/Mm+va0HnyJJvJ511BIZPHoPIheFgi517TCooWsbBMUd
	 WSTmKdJWe1UfTSlATsW95ACeJ+2Ll0h4BtuuaSFwVIFk0Wv0zZu3LZGeJRFeQJn0qe
	 lg2p9xQs3O5V2HOaVWmRlOJx02Yzw7s7vpvz4fokLmZ7ey61g0GQZuRvribH6nHyqr
	 xDH3Wpe0L5t74rdpA5UINqI4Hxxsp6lB+b5KVRB/rten4cAybUcKdl/88Oc2pCe2TE
	 6b7kfjQEJbS5HJyWvsAtyyHoKwfXfP3N4KXgVgUwkJm645MDTdxDa3wPAeEVyf6U26
	 meOgl0uiogQDw==
Date: Fri, 10 Jan 2025 11:18:32 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Mike Rapoport <rppt@kernel.org>,
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Message-ID: <Z4FyiALKwX-AIWtF@bombadil.infradead.org>
References: <20241227072825.1288491-1-rppt@kernel.org>
 <20241227072825.1288491-4-rppt@kernel.org>
 <jut35igb2kstpz24apqdeubv5rvyl3vmp2s43xtivpz54uiedj@wmd2onulv4xw>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jut35igb2kstpz24apqdeubv5rvyl3vmp2s43xtivpz54uiedj@wmd2onulv4xw>

On Fri, Jan 10, 2025 at 12:36:59PM +0200, Kirill A. Shutemov wrote:
> On Fri, Dec 27, 2024 at 09:28:20AM +0200, Mike Rapoport wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > Change of attributes of the pages may lead to fragmentation of direct
> > mapping over time and performance degradation as result.
> > 
> > With current code it's one way road: kernel tries to avoid splitting
> > large pages, but it doesn't restore them back even if page attributes
> > got compatible again.
> > 
> > Any change to the mapping may potentially allow to restore large page.
> > 
> > Hook up into cpa_flush() path to check if there's any pages to be
> > recovered in PUD_SIZE range around pages we've just touched.
> > 
> > CPUs don't like[1] to have to have TLB entries of different size for the
> > same memory, but looks like it's okay as long as these entries have
> > matching attributes[2]. Therefore it's critical to flush TLB before any
> > following changes to the mapping.
> > 
> > Note that we already allow for multiple TLB entries of different sizes
> > for the same memory now in split_large_page() path. It's not a new
> > situation.
> > 
> > set_memory_4k() provides a way to use 4k pages on purpose. Kernel must
> > not remap such pages as large. Re-use one of software PTE bits to
> > indicate such pages.
> > 
> > [1] See Erratum 383 of AMD Family 10h Processors
> > [2] https://lore.kernel.org/linux-mm/1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com/
> > 
> > [rppt@kernel.org:
> >  * s/restore/collapse/
> >  * update formatting per peterz
> >  * use 'struct ptdesc' instead of 'struct page' for list of page tables to
> >    be freed
> >  * try to collapse PMD first and if it succeeds move on to PUD as peterz
> >    suggested
> >  * flush TLB twice: for changes done in the original CPA call and after
> >    collapsing of large pages
> > ]
> > 
> > Link: https://lore.kernel.org/all/20200416213229.19174-1-kirill.shutemov@linux.intel.com
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> When I originally attempted this, the patch was dropped because of
> performance regressions. Was it addressed somehow?
> 

Also, the statement:

"Change of attributes of the pages may lead to fragmentation of
direct mapping over time and performance degradation as result.  "

Seems to contradict the findings reported at LSFMM by Mike before
that direct map fragmentation does not incur performance penalty,
so I don't see a point in contradicing those findings and confusing
people further.

  Luis

