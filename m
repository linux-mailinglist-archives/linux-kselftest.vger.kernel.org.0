Return-Path: <linux-kselftest+bounces-24204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6307AA08E23
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 11:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2873A61F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC3820ADFD;
	Fri, 10 Jan 2025 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="lF9l1Oxg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rD9VT4L+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36EB20A5F2;
	Fri, 10 Jan 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505441; cv=none; b=igxpbWAD4FF1jSKKLB6Z4Qrfa3tLo4QbFZE8TRfe8cxezfRqSCQ3lQ6Z7V2aEwuDOBlPy1M019UvBuHbaaFCWj1QFBA7yud5/1lTxQZLNm4BPXvLgK61y8jGRdwlXFyWUpkcbvYNTF7aW7DN7g4vm2AT1TQTh4Xywe7Bv3mlB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505441; c=relaxed/simple;
	bh=I1oVtbaOlFFHu0DmV8zdRMs9cNx4ils+QPsuoigo9rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRMKgE2lREn7KtrSz7ie9gu5bdCswunhVPZ/ZmV+ttpFmqNgKwtARNTRuI2S+vPL7C5SaWLWKcbaK33n0jaAXgpA1qswLDQWFbFz8X2BTIwPc+J47dchTDdmhTkZIgSijxZaK67dXD5Lx4rP1W26k6QgfeRm5P6ROm/6efPf60s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=lF9l1Oxg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rD9VT4L+; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id D91B32010D6;
	Fri, 10 Jan 2025 05:37:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 10 Jan 2025 05:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1736505437; x=
	1736512637; bh=Km4XzsnzHBTNNJzmGN8m2TrMMSFreEGVyXvVDroQ2DY=; b=l
	F9l1OxgwNCSVpVzHNp2jvRIgcZtfmBz/E4/CO27dbRnPpywlZHXNuQhSufjq09iR
	0Q1ceb1IRZSS/fN6814PVfVlDFZc/EVLYl2vi58mWFhJp18o89cYZreU1XtVLRmD
	19T4xnFzlXyyyMJOMNOqGvLHe6C60LN2xggK+JESVtgZPwAH5HJRI5xPshZSfrlZ
	GcMXvirGEd1tDeBMy5m8L171rno7Opv+KWlrx+H6cbu757OIulT2KyrYFRI4HfHI
	IeQFsKKAHooUKWsb04Ck1WkK+W3OgtdvrKfxU53JSObu8cpzKureitBsWxKiHuto
	y3zwRAmHw1P1k+RSkV1RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736505437; x=1736512637; bh=Km4XzsnzHBTNNJzmGN8m2TrMMSFreEGVyXv
	VDroQ2DY=; b=rD9VT4L+x6wScm0MmUZeIMvpHgMx8qAL83gowQ/aifn4QOfo3nw
	18acnJdLdQvErdaVPbYP4SqjyKSQJGLB3E5eZzuJ9Dtxvp3QeH2dP/hfVmiAoRmf
	GWim3pv96frkdHzWOHix2M5qmmBHHkE2E9qlP4U6LV/Ha5ZxKqk10JuNAvA27n30
	qdxMfQmD+i4hm5mNMNftbXsWI4fysYE9pymAWInDaeeeVJifSUXB3JzOL2PwBEE2
	azJQJpPCW1nC9N+YVplzgJm6rVTgPozOzsC1XEmejWeWoA3KkM4A98S8XvWF96jp
	o69S196+kqgvwK+y07aXY0dqMcuZxp6uqiQ==
X-ME-Sender: <xms:W_iAZ00nxgJw64svIet4IdZP3JkbK1OhjQjIlVOQzlhHOwiSX9jkow>
    <xme:W_iAZ_EFoH6iwh3lMqZ8MhM0WyE1LksqHeyql6hCcSzFXriLt6zgQj9KcqBOVeqFR
    14FSvtmUagZUhrYj1g>
X-ME-Received: <xmr:W_iAZ85lBR8fS3KVrpwwP-tcfcdKyK7KrEupA9vygKO6KEH9a87CckaGqhGuGKt21qAemA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeltedugedtgfehuddu
    hfetleeiuedvtdehieejjedufeejfeegteetuddtgefgudenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhope
    egfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhht
    ohhnrdhivhgrnhhovhestggrmhgsrhhiughgvghgrhgvhihsrdgtohhmpdhrtghpthhtoh
    epsghpsegrlhhivghnkedruggvpdhrtghpthhtohepsghrvghnuggrnhdrhhhighhgihhn
    sheslhhinhhugidruggvvhdprhgtphhtthhopegurgdrghhomhgviiesshgrmhhsuhhngh
    drtghomhdprhgtphhtthhopegurghnihgvlhhtsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:W_iAZ93YjtGqyQ_KhyMe78rNVusaOBrYpJoPXwMLehTvKhN1WUbxyg>
    <xmx:W_iAZ3GoqF6B8L2mTflFziY9ijfyGAomHfUPxnFZQ_ui45RQ_ik4tw>
    <xmx:W_iAZ2_aN5wdvfhDfYaCp4mM9S-7Ff2DFoYQYHii7uiepbjsstVyLA>
    <xmx:W_iAZ8lM-cSB7BXqi74IqSxpaazEX5g3lCuiI9gwh0GEiOvb_BC0bg>
    <xmx:XfiAZ17mYS2-77H8F-lcSSO9soujJP_-GYVn8onu-R3c3sOdSsV828s5>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 05:37:03 -0500 (EST)
Date: Fri, 10 Jan 2025 12:36:59 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
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
 Jiri Kosina <jikos@kernel.org>, 	Joe Lawrence <joe.lawrence@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 	Josh Poimboeuf <jpoimboe@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 	Luis Chamberlain <mcgrof@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 	Masami Hiramatsu <mhiramat@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 	Petr Mladek <pmladek@suse.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Rae Moar <rmoar@google.com>, 	Richard Weinberger <richard@nod.at>,
 Sami Tolvanen <samitolvanen@google.com>, 	Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 	Thomas Gleixner <tglx@linutronix.de>,
 kgdb-bugreport@lists.sourceforge.net, kunit-dev@googlegroups.com,
 	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, 	linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 	live-patching@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/8] x86/mm/pat: Restore large pages after fragmentation
Message-ID: <jut35igb2kstpz24apqdeubv5rvyl3vmp2s43xtivpz54uiedj@wmd2onulv4xw>
References: <20241227072825.1288491-1-rppt@kernel.org>
 <20241227072825.1288491-4-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227072825.1288491-4-rppt@kernel.org>

On Fri, Dec 27, 2024 at 09:28:20AM +0200, Mike Rapoport wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Change of attributes of the pages may lead to fragmentation of direct
> mapping over time and performance degradation as result.
> 
> With current code it's one way road: kernel tries to avoid splitting
> large pages, but it doesn't restore them back even if page attributes
> got compatible again.
> 
> Any change to the mapping may potentially allow to restore large page.
> 
> Hook up into cpa_flush() path to check if there's any pages to be
> recovered in PUD_SIZE range around pages we've just touched.
> 
> CPUs don't like[1] to have to have TLB entries of different size for the
> same memory, but looks like it's okay as long as these entries have
> matching attributes[2]. Therefore it's critical to flush TLB before any
> following changes to the mapping.
> 
> Note that we already allow for multiple TLB entries of different sizes
> for the same memory now in split_large_page() path. It's not a new
> situation.
> 
> set_memory_4k() provides a way to use 4k pages on purpose. Kernel must
> not remap such pages as large. Re-use one of software PTE bits to
> indicate such pages.
> 
> [1] See Erratum 383 of AMD Family 10h Processors
> [2] https://lore.kernel.org/linux-mm/1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com/
> 
> [rppt@kernel.org:
>  * s/restore/collapse/
>  * update formatting per peterz
>  * use 'struct ptdesc' instead of 'struct page' for list of page tables to
>    be freed
>  * try to collapse PMD first and if it succeeds move on to PUD as peterz
>    suggested
>  * flush TLB twice: for changes done in the original CPA call and after
>    collapsing of large pages
> ]
> 
> Link: https://lore.kernel.org/all/20200416213229.19174-1-kirill.shutemov@linux.intel.com
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

When I originally attempted this, the patch was dropped because of
performance regressions. Was it addressed somehow?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

