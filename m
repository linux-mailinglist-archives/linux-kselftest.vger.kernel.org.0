Return-Path: <linux-kselftest+bounces-24314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A53BA0B070
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F9A165FAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DF2231A4D;
	Mon, 13 Jan 2025 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCKFoq/v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A80136A;
	Mon, 13 Jan 2025 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755287; cv=none; b=OcwI8en3LSAJZe0sdTPB1tZZzQTx5mdogerk8yQZvbD8r6pym/0PE07oHSCWfy+qd/T8qZbu1vxjmi6n7Hrb5wBqbIzlrCh8Tui4djP5zvo1NxELCzzN4PDhAisPOiyKDILffN94seetlEh8imc2IfaC/+tocq7nLX+F2sNmtyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755287; c=relaxed/simple;
	bh=PQUlUvfhCWekOuCl5QttmQTgLYBws5TIBjoR0vGiG7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTC49rq7CTqGr4AF7N4oW+tyiamrRZExqGXUr9Kz0+L95iWbzdYnUM0VepMf1nWCBQcYcSkuRsxr2tLvfJ0RcV9cyVn3axnA5PceI5CUxRWjFnaBxuDWFvQkWbzUz7dzD6W/G+bPgg5Ogz2EXjT1B0+dX/0V/CR+b7RAvvUVloM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCKFoq/v; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736755286; x=1768291286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PQUlUvfhCWekOuCl5QttmQTgLYBws5TIBjoR0vGiG7Q=;
  b=VCKFoq/v1aI55CGoiLQvGy7rIHAoSgbY6VjP08LCjDNAiShpkwP2GPyT
   5IuBw9mvVW9HQera6711B0rZgadw6Gr/oAv/StmTKnh9j6qWqXgNQszSW
   Q1COYXru2e6pVgPDqAqdW7NrMJXZSYlXcKoLJFuK9euJbPdXOVmiuI4s7
   nM9jAZpGkVCC/pN+yG4dPtZdUTAb0Of1RvI5n4hlx1cbLp0tdmQiskm5A
   GyO0GV8+IU2uEHngxCcN1mN6C1CKlbMzNXZIVHmNejqUxp6VGwa2gak9C
   JIqB4siKpwDBwd47l8b7KKPJpeN62BQss/mFSi286RndGqm/mOJZQQEoZ
   w==;
X-CSE-ConnectionGUID: w0dPs1Y+RmWvrqfdOBGR0g==
X-CSE-MsgGUID: QxWmOXOYQzKjY36PhKXLLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="37162330"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37162330"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:01:25 -0800
X-CSE-ConnectionGUID: errEg64YRjm1IP+ivSWOEA==
X-CSE-MsgGUID: JLLGpe/CSLWefE+dqKfu3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109517553"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 13 Jan 2025 00:01:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4C363331; Mon, 13 Jan 2025 10:01:13 +0200 (EET)
Date: Mon, 13 Jan 2025 10:01:13 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Borislav Petkov <bp@alien8.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Daniel Gomez <da.gomez@samsung.com>, 
	Daniel Thompson <danielt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Gow <davidgow@google.com>, Douglas Anderson <dianders@chromium.org>, 
	Ingo Molnar <mingo@redhat.com>, Jason Wessel <jason.wessel@windriver.com>, 
	Jiri Kosina <jikos@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Petr Mladek <pmladek@suse.com>, Petr Pavlu <petr.pavlu@suse.com>, Rae Moar <rmoar@google.com>, 
	Richard Weinberger <richard@nod.at>, Sami Tolvanen <samitolvanen@google.com>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, kgdb-bugreport@lists.sourceforge.net, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	live-patching@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/8] x86/mm/pat: Restore large pages after fragmentation
Message-ID: <sivhweds7p5sst2jpxanrj6qc7wlonqkod64nsr5cgttma7ntp@bhqespo3jdqz>
References: <20241227072825.1288491-1-rppt@kernel.org>
 <20241227072825.1288491-4-rppt@kernel.org>
 <jut35igb2kstpz24apqdeubv5rvyl3vmp2s43xtivpz54uiedj@wmd2onulv4xw>
 <Z4ODVmnC4fDnIUSN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4ODVmnC4fDnIUSN@kernel.org>

On Sun, Jan 12, 2025 at 10:54:46AM +0200, Mike Rapoport wrote:
> Hi Kirill,
> 
> On Fri, Jan 10, 2025 at 12:36:59PM +0200, Kirill A. Shutemov wrote:
> > On Fri, Dec 27, 2024 at 09:28:20AM +0200, Mike Rapoport wrote:
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > 
> > > Change of attributes of the pages may lead to fragmentation of direct
> > > mapping over time and performance degradation as result.
> > > 
> > > With current code it's one way road: kernel tries to avoid splitting
> > > large pages, but it doesn't restore them back even if page attributes
> > > got compatible again.
> > > 
> > > Any change to the mapping may potentially allow to restore large page.
> > > 
> > > Hook up into cpa_flush() path to check if there's any pages to be
> > > recovered in PUD_SIZE range around pages we've just touched.
> > > 
> > > CPUs don't like[1] to have to have TLB entries of different size for the
> > > same memory, but looks like it's okay as long as these entries have
> > > matching attributes[2]. Therefore it's critical to flush TLB before any
> > > following changes to the mapping.
> > > 
> > > Note that we already allow for multiple TLB entries of different sizes
> > > for the same memory now in split_large_page() path. It's not a new
> > > situation.
> > > 
> > > set_memory_4k() provides a way to use 4k pages on purpose. Kernel must
> > > not remap such pages as large. Re-use one of software PTE bits to
> > > indicate such pages.
> > > 
> > > [1] See Erratum 383 of AMD Family 10h Processors
> > > [2] https://lore.kernel.org/linux-mm/1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com/
> > > 
> > > [rppt@kernel.org:
> > >  * s/restore/collapse/
> > >  * update formatting per peterz
> > >  * use 'struct ptdesc' instead of 'struct page' for list of page tables to
> > >    be freed
> > >  * try to collapse PMD first and if it succeeds move on to PUD as peterz
> > >    suggested
> > >  * flush TLB twice: for changes done in the original CPA call and after
> > >    collapsing of large pages
> > > ]
> > > 
> > > Link: https://lore.kernel.org/all/20200416213229.19174-1-kirill.shutemov@linux.intel.com
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > 
> > When I originally attempted this, the patch was dropped because of
> > performance regressions. Was it addressed somehow?
> 
> I didn't realize the patch was dropped because of performance regressions,
> so I didn't address it.
> 
> Do you remember where did the regressions show up?

https://github.com/zen-kernel/zen-kernel/issues/169

My understanding is if userspace somewhat frequently triggers set_memory_*
codepath we will get a performance hit.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

