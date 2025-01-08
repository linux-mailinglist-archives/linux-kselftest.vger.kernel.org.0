Return-Path: <linux-kselftest+bounces-24065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F560A06070
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 16:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FA31887B02
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0866B1FECCC;
	Wed,  8 Jan 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPJm0Ekh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2A1FECB0;
	Wed,  8 Jan 2025 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351039; cv=none; b=nsJwqVmJaQ0nbVg0QJfbnFXlbVzVvrOP0dzHfNWVR1DHIiFWAe4duIc83YeeyLyGgRkrvMdJloxOtEo2aJjWwDztqFJ+tHMnSkw2oWgsNwi5tpeuEv75vCAVEbT/aRlQv/lpND+Tjb8tGVbBzdHsBmI4p8xmljr14aXDrDq/MUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351039; c=relaxed/simple;
	bh=iAQ4x0/oizKfpSM1ZOfEKhrwcrgnRVCuoCpheJdwODk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI3W3eYENF+u8wj8PdcPuCB2DujFGq7VXxKAGbR3qQx9aZftFzSc86dyjUN/IZBkgTCC1Uso8UgAOM5mdFnKY1RwnTloS9bLKdr3j1D1cgSe5YG33eWvDW8FMCP1MmHoNw79j2Mp0BAXRq0hh+QXDlCexkwfoXX/9CJc5aNYbdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPJm0Ekh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0593C4CED3;
	Wed,  8 Jan 2025 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736351039;
	bh=iAQ4x0/oizKfpSM1ZOfEKhrwcrgnRVCuoCpheJdwODk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPJm0EkhpbVJZIRwKv38+KZr4RI6JAKZRMgSJAUilwa/dgEkob3GpPO+TLNtRiZCT
	 DEWJDBRDzGsOiVUJ+Ljb7+Zn631cx7upT+JgUKWUOxWPdyfc0Rv/VXd92XMheafcRO
	 HwTLae87NP1aV9jSsgjH8i80uyHv2fYQqRxRTS+9d/osRLJHpv7Z+BDIRhOLlXadBp
	 ZyTfw0YbeI9/Tk1NMDXKp+ISKT72FLunUeqjvZM2LA81L2wBEkbl0Wz1SR/Zrf3sG0
	 DbpdPhUNKkmhlmzyHl1UUxz72wsi01z2Ht4x5xPDXSJRrWhFFXhn0nULlTfoL308Ir
	 jxj7j8IS15+bA==
Date: Wed, 8 Jan 2025 15:43:48 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Gomez <da.gomez@samsung.com>,
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
Subject: Re: [PATCH 5/8] module: introduce MODULE_STATE_GONE
Message-ID: <Z36dNC2ROdNsaEyR@aspen.lan>
References: <20241227072825.1288491-1-rppt@kernel.org>
 <20241227072825.1288491-6-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227072825.1288491-6-rppt@kernel.org>

On Fri, Dec 27, 2024 at 09:28:22AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> In order to use execmem's API for temporal remapping of the memory
> allocated from ROX cache as writable, there is a need to distinguish
> between the state when the module is being formed and the state when it is
> deconstructed and freed so that when module_memory_free() is called from
> error paths during module loading it could restore ROX mappings.
>
> Replace open coded checks for MODULE_STATE_UNFORMED with a helper
> function module_is_formed() and add a new MODULE_STATE_GONE that will be
> set when the module is deconstructed and freed.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

I've seen the rest of the discussion about this patch... but in case I
forget, and from an extremely myopic kgdb/kdb point of view:
Acked-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

