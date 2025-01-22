Return-Path: <linux-kselftest+bounces-24920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E9BA18ED0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 10:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B917A1D62
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 09:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF18920FA8B;
	Wed, 22 Jan 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MKnkgi6h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD0D1F76B5;
	Wed, 22 Jan 2025 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737539488; cv=none; b=GqN0NlbJD3anDwS36KUiQbozCZ+Y0TF+MwPFBB1WLTkjNV/cqOMqmYTSKY8xsI1sMGlliK8McNSOeVNkvnrIOi/09OS41hiboW1J0vBWaOA8ds1GXSCmaRr2eUghny31u5JLunXdUGnZpgTJGt/Jyo63mD+rc7xRVqsDwG4Nz44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737539488; c=relaxed/simple;
	bh=hezJtK/d+zwrRIVfZtLHoCQtTdX9Yg1OWMiDDjqhfxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuwZcWStw+0+Ao6RCfFznDmMpNpBBZy9u9CDBeGU2qf1dxp/w6VWuSWHQoedzsHdgF+/rahEfjbI7g/qm7U8r5pGJeXWxp1ldseZDJZEhaqSD7w0Q1YrQbN9y/17seB9jCKxSPfPxPxtUB6Tv4Sj0U/KJvQcz2bHt75ygUmDqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MKnkgi6h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R2vVfjEoF0Ie9PHykSVzRRqFF+sOncqHqtvT5+6/DaM=; b=MKnkgi6hXTGhjN0zMurpz8SNpE
	ymCkZhFC61LwgD4TM+uvL9f94W7ieK+NlcINltXhi5P7zaThC8LDbygxQwYvl2vjqUbtLZxhyuCAy
	wG9Z+Ldin3RK5nfuM0GkwyoHYphh4xlIzb3ZwPqDqe/Md1bpCVSc/kEnmcmll20W+wRIsVeKhYXLu
	Icsm6CQIqin5i3mHwdxptDspOvpa/TLyj91bi3vFiZtukWqpolG9eXFgrM5se3DpV3tWyn1O5XwlG
	y7jf8tM3H0Aa42/D8J7lIspHZTlrky+YN4nvimy9DUKwuN39znXE18o2HcEui26BmtlwFsHg8i9X0
	ELdyxdQA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taXO2-000000011ZD-0WUk;
	Wed, 22 Jan 2025 09:51:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 46E9A300599; Wed, 22 Jan 2025 10:51:01 +0100 (CET)
Date: Wed, 22 Jan 2025 10:51:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
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
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
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
	live-patching@vger.kernel.org
Subject: Re: [PATCH v2 00/10] x86/module: rework ROX cache to avoid writable
 copy
Message-ID: <20250122095101.GK8385@noisy.programming.kicks-ass.net>
References: <20250121095739.986006-1-rppt@kernel.org>
 <20250121123646.GC7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121123646.GC7145@noisy.programming.kicks-ass.net>

On Tue, Jan 21, 2025 at 01:36:47PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2025 at 11:57:29AM +0200, Mike Rapoport wrote:
> 
> > Kirill A. Shutemov (1):
> >   x86/mm/pat: restore large ROX pages after fragmentation
> 
> The duplication between pmd and pud collapse is a bit annoying, but so
> be it.
> 
> > Mike Rapoport (Microsoft) (9):
> >   x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
> >   x86/mm/pat: drop duplicate variable in cpa_flush()
> >   execmem: don't remove ROX cache from the direct map
> >   execmem: add API for temporal remapping as RW and restoring ROX afterwards
> >   module: introduce MODULE_STATE_GONE
> >   module: switch to execmem API for remapping as RW and restoring ROX
> >   Revert "x86/module: prepare module loading for ROX allocations of text"
> >   module: drop unused module_writable_address()
> >   x86: re-enable EXECMEM_ROX support
> 
> All these look good on a first reading, let me go build and test the
> various options.

I've tested:

GCC:  ibt=off
      ibt=on
LLVM: ibt-off,cfi=off
      ibt=off,cfi=kcfi
      ibt=on,cfi=off
      ibt=on,cfi=kcfi
      ibt=on,cfi=fineibt

And all of them were able to load a module, so yay!

My plan is to merge these patches into tip/x86/mm once we have -rc1.


