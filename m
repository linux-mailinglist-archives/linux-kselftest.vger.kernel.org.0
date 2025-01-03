Return-Path: <linux-kselftest+bounces-23859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAF2A00888
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 12:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD233A439F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA061F8F1C;
	Fri,  3 Jan 2025 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DaRgJ6Ze"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9401D1527AC;
	Fri,  3 Jan 2025 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903233; cv=none; b=L8/ASUXvVThDtkM6oxXVi+nCkpCF4pNOEC9SsyA+HaAPdiasimdHJlcwhGEmdplyvfER4eUxN/oGZ6OPpLlAKbMFezfohGn6Jj65ZIJOexJD4deXvjjk4gb3MTjJb17v6VB16ipjxbtLCdfaTS9lhwEsiZw3nQGxhPIo5A9u79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903233; c=relaxed/simple;
	bh=5MGbxOku246M5y/dHAEZXhGTv+90s60izXW9ASoKzic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTyQ1pFeJJ15pcwgKlHB4xSSWUEP/W0l1xwNLe5Wv4v2ESSY3ceH6WMojxYbg8Ya/Dj5aAe4Wjp8neDFZQRogl3iFrkPqfBCjAQ2Js2KU0l+XTrpG6CWZ2RBXIBqrnnmsExH728I1IxuuIZigwFynLinIia1w7xcBYI4mSPN0T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DaRgJ6Ze; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+e20JDJu3VwrmlmlVVpxrvFlU6CuxSxftw52pQXGnog=; b=DaRgJ6ZeouUFnjZ11up8spR4oW
	o3qngr9xYj85lxVEWvhjfekmFNWYSpBpnDXfgrnmBcXz21BVnbWSjwF7FJpVqC3515Zz7xoNghOSN
	DH+Y2PmIRLQ12UwBno8GZvcaEK1tyJyBcOeuOEqZZDyo61EUcCWq7+pFRb99cLZH0ChNWFaY8ue4g
	z8w5w37xbByYWZ1U79CbSnvZ1WHPtTWr6jtlQX4rjTXRfc9uIqBUMMP6yizCWyO7qbPQ54fvQbCrO
	XqWipiJzxMZluWZYjJQzRjkUSapDbZoOBeoCu74phuj0VrMCuywG6Sfo3qD6+BsfXkShHAV3onqo/
	yYIJfPJw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTfih-00000008NOv-2fvw;
	Fri, 03 Jan 2025 11:19:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3A6C93003AF; Fri,  3 Jan 2025 12:19:59 +0100 (CET)
Date: Fri, 3 Jan 2025 12:19:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	live-patching@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/8] x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
Message-ID: <20250103111959.GD22934@noisy.programming.kicks-ass.net>
References: <20241227072825.1288491-1-rppt@kernel.org>
 <20241227072825.1288491-2-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227072825.1288491-2-rppt@kernel.org>

On Fri, Dec 27, 2024 at 09:28:18AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> The CPA_ARRAY test always uses len[1] as numpages argument to
> change_page_attr_set() although the addresses array is different each
> iteration of the test loop.
> 
> Replace len[1] with len[i] to have numpages matching the addresses array.

D'oh..

