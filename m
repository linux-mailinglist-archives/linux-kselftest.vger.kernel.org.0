Return-Path: <linux-kselftest+bounces-25295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A270A20821
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 11:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7871C160E98
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 10:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1E91A2380;
	Tue, 28 Jan 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx7V38So"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288731917D8;
	Tue, 28 Jan 2025 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058480; cv=none; b=ai5HqsCAiosQxnd7ds5zdVG9BMW0I1hfzfaaJYgrRwBdoZu6Ka2UkDEeBFcSGzteaDUEs9KvS8EAZ/p69P+J7dA95scaP3YdwSijqPbIWKJ06eKHg4pRUK1OTRjr/fG+8kIXG/JZwHvTWw7Mzd4B/9tFoaV+6lQWrZETu12XIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058480; c=relaxed/simple;
	bh=H+G3TtSN5z2rPg9q7jaqw3zaBc0K+irN0EUiSSVdGVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rlgwr2ARlBlobOsv5SLGd2jxUdG2/h+I1Z5YhPaAIN1romAdEsXrbHHeYMo0+GM2HKdiRFxHaxKgULW6qfWstfTqAU+lsWbx3vdEsDt+LUlnXHPpcvTX1jzujp3gv8KYm03w3bwaH4o2oT660g05yJfomlb6oBQsjHDCWDnVFyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx7V38So; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0C8C4CED3;
	Tue, 28 Jan 2025 10:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738058478;
	bh=H+G3TtSN5z2rPg9q7jaqw3zaBc0K+irN0EUiSSVdGVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bx7V38SoAhETd9sc3qxV33PkV4fbZ9U+nWfMSuyj7aAE4t36vZLBolyqeF4nbGBta
	 XbN1Q+pDjEpEFtKJHmktZXdqMYusjeXUsBpMTU7b6k5chsugMb3GDVaN7OIdra9mNc
	 LgS+jr+iGKrULxB2qPNZHewWubD6EIpyvgyZNsdxQFtO0jyXH5V+jnnZUMM6ltJCFZ
	 S0bl1WgjGqJhnkUL6gVfjpKxam708lIRTpj76NinsW/OGobdYd4Lb21/LvZ8ubl/cT
	 FoOzOIdBgb8magf0NcV37KSZIgUUV04fADb6slWXhE+UMBFk+i/daHvsFfa4nWGW8m
	 oHJUjwuGUTj7g==
Date: Tue, 28 Jan 2025 12:00:56 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
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
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>, Rae Moar <rmoar@google.com>,
	Richard Weinberger <richard@nod.at>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 6/9] module: switch to execmem API for remapping as RW
 and restoring ROX
Message-ID: <Z5iq2GJKIdlB9APM@kernel.org>
References: <20250126074733.1384926-1-rppt@kernel.org>
 <20250126074733.1384926-7-rppt@kernel.org>
 <021665c5-b017-415f-ad2b-0131dcc81068@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021665c5-b017-415f-ad2b-0131dcc81068@suse.com>

On Mon, Jan 27, 2025 at 01:50:31PM +0100, Petr Pavlu wrote:
> On 1/26/25 08:47, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Instead of using writable copy for module text sections, temporarily remap
> > the memory allocated from execmem's ROX cache as writable and restore its
> > ROX permissions after the module is formed.
> > 
> > This will allow removing nasty games with writable copy in alternatives
> > patching on x86.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> [...]
> 
> > +static void module_memory_restore_rox(struct module *mod)
> > +{
> > +	for_class_mod_mem_type(type, text) {
> > +		struct module_memory *mem = &mod->mem[type];
> > +
> > +		if (mem->is_rox)
> > +			execmem_restore_rox(mem->base, mem->size);
> > +	}
> > +}
> > +
> 
> Can the execmem_restore_rox() call here fail? I realize that there isn't
> much that the module loader can do if that happens, but should it be
> perhaps logged as a warning?

It won't fail at this point. set_memory APIs may fail if they need to split
a large page and could not allocate a new page table, but here all the
splits were already done at module_memory_alloc() time.
 
> -- 
> Thanks,
> Petr

-- 
Sincerely yours,
Mike.

