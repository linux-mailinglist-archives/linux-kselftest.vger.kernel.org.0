Return-Path: <linux-kselftest+bounces-24858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6306EA17DDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 13:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3141E1884C8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B63E1F1937;
	Tue, 21 Jan 2025 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FiKvPMin"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5FB7462;
	Tue, 21 Jan 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737463042; cv=none; b=GX2U5CGGZpT4dHpE1NlL6nFPN6zTlFE7IS5QM3nATTs3f4Dhu5BIBVcTGPknkYEq2sZrXeWV38R1Sppqt4dcPtTtyMCby6TCIqpQDCfrNTJavaFoj159lmrfZEeS9O2QN+4d6E0liqkz1Tp11gGh1EomWE0kFnC/wVqD7OkSYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737463042; c=relaxed/simple;
	bh=Dye0D6CZD8xIoO22fhiGdz2tOSdT7Pz1dasxwReFR64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfL3vjy7GsgdYasBTOLH27kUuFb433sI7U5CY+uvlTremsBgMEz+qGW+rkxlf/NLM+uRNIvBzwUdhlP2ccy9cceQ8lVK7+sEZGAitSCEcrh11hUHCSP6HnNsXw9eSCwo56PTEYsdmNZA6RxJQ3WhvnNafWjAYJwJEqDiOP42eSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FiKvPMin; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+S3XXHbN/oe6xKVYGSf9YZ3CRMWHxj1l3FkfZRty5tI=; b=FiKvPMinu66/G2JHsGRgnMbT5F
	rMCwmED4+IvlnlmUz8ASXQB1GnEDZq3CzcLFTzt/RVSSHIUCEDPvYaR/vpM6O1K7+ZPOaapQJPWi8
	gca1sxhPAW16+uYuk22hj7LI7nu4tDIkzL3A6KLSNh1mj956fKMeGTTg9KGoF+XnjymQh81ulQrlI
	CCL1agCm2m2GbwQWiEo5t3elu50no64PB+45UsbaAodphvLrkDFOhDpfNYqzLzLyJGT+DvKcMFIph
	zBK8tPp+ZXFGNxDquE/xKAwVWlD5DQAw2mJsd7DgAkH4dWm3RWoF9hgpd6mq3Ji/IulJ6M7qZucvU
	ddwVVUjg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taDUu-0000000AbnU-0YO0;
	Tue, 21 Jan 2025 12:36:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0BE8E300619; Tue, 21 Jan 2025 13:36:47 +0100 (CET)
Date: Tue, 21 Jan 2025 13:36:46 +0100
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
Message-ID: <20250121123646.GC7145@noisy.programming.kicks-ass.net>
References: <20250121095739.986006-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121095739.986006-1-rppt@kernel.org>

On Tue, Jan 21, 2025 at 11:57:29AM +0200, Mike Rapoport wrote:

> Kirill A. Shutemov (1):
>   x86/mm/pat: restore large ROX pages after fragmentation

The duplication between pmd and pud collapse is a bit annoying, but so
be it.

> Mike Rapoport (Microsoft) (9):
>   x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
>   x86/mm/pat: drop duplicate variable in cpa_flush()
>   execmem: don't remove ROX cache from the direct map
>   execmem: add API for temporal remapping as RW and restoring ROX afterwards
>   module: introduce MODULE_STATE_GONE
>   module: switch to execmem API for remapping as RW and restoring ROX
>   Revert "x86/module: prepare module loading for ROX allocations of text"
>   module: drop unused module_writable_address()
>   x86: re-enable EXECMEM_ROX support

All these look good on a first reading, let me go build and test the
various options.

