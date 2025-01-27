Return-Path: <linux-kselftest+bounces-25224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F71CA1D539
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 12:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1B01663A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0288E1FE46D;
	Mon, 27 Jan 2025 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sj0xS/qv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466325A646;
	Mon, 27 Jan 2025 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737976787; cv=none; b=f2crmWLdhJqIrN7tQ1UrmPFxC2beBzROtGZPtKifdxpZ/7GglgA3BqymA+ibd/sE9Qm/KUM7waHIa4xbBRm6UYEdRrlBfw9/fqRXt5Ws3ARwT/bDVqj/Vttz2++eUoROQ5Ec5/gnU+JS0uEDRqNTsdCx4RVXZ9VmS4tegKlpAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737976787; c=relaxed/simple;
	bh=njpHzU4ZOBfDuJAtpeWd94IvXAzvnYtaRPAp5fLxI5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fi/tuTToCLI90ijU/TXSBT6Ye67VHCkrA2i3216R/yKFbsnyNRTql2iL4c7tNwFyyN7xQMiTQ9msdJFjQ/7bbrORa9H7dDg0MFR54ku/Kb38mdSFvm3qsXvoTrGQq9T85cP0nQ0DEWLqv4YaGN6UmToexzYA4NZY0olLvkm/Uqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Sj0xS/qv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2nxlZG0x9iQaYpsd+eadUudjrFnJ1cGtAfW/gj43tTw=; b=Sj0xS/qvr8H41QAKtpZRieE13Y
	aiVj8mHj3pZnEWKoAD3Wd6wuTFDoU6Be22SwXDNWbDzO3IM8T+gXHeZKhWxjNclBx0dQumSMS1C5Z
	V6PP/mamsBhXIVujfX/YgB1kEHLgPt9Ul42gqoJRUMafSAa5MwSWRLYQzlGsbBTTAdV72PxTu0OCk
	sjvgNjd0NtJmzEdGPfPV5twTvfTzqazcPs0SxNXf1kV+BZzGIS9BUgIVAO3P8AKnOWlRTL5HeRnt2
	6XCGhLzKQzQu31s8rh+jHRlsG4MmmtNripWGwIxe3Sb6e6uX4JNIerL4SqMtbLL+escsGkpuLAdEH
	oGUBpIuw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcN96-00000009K2m-3aM4;
	Mon, 27 Jan 2025 11:19:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6EF783004DE; Mon, 27 Jan 2025 12:19:12 +0100 (CET)
Date: Mon, 27 Jan 2025 12:19:12 +0100
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
Subject: Re: [PATCH v3 0/9] x86/module: rework ROX cache to avoid writable
 copy
Message-ID: <20250127111912.GF16742@noisy.programming.kicks-ass.net>
References: <20250126074733.1384926-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250126074733.1384926-1-rppt@kernel.org>

On Sun, Jan 26, 2025 at 09:47:24AM +0200, Mike Rapoport wrote:
> v3 changes:
> * instead of adding a new module state handle ROX restoration locally in
>   load_module() as Petr suggested

OK, updated the patches I have pending for post -rc1.

