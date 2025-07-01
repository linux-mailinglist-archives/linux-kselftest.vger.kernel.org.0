Return-Path: <linux-kselftest+bounces-36176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4723DAEF82E
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 14:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B5A188CD81
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 12:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE0C273D76;
	Tue,  1 Jul 2025 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoUQMvg8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348227381E;
	Tue,  1 Jul 2025 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372418; cv=none; b=lD+i0uvlSrRgTpYtsC4WErYKymTvZRf8X47Pm04Lxgj33jGjlBD0JkSz3GMfprkWVoueoXXLPZ+B8nTtAsdIXEqFsDwGdu3m1eNyKXKh8xOTMjv9Q+CUq4A7I4nLbT1rds7f2TMLqXazsbkGORmSM1NLhDuAaoeNck9xD6Dc+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372418; c=relaxed/simple;
	bh=0WOvPMu1XqES/onds8PjGHDXOKh6epjdI3Hxbgaf7X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OH+wKVw6cDnomnCXxDvcQ4bYkjGcsPAfvMPHaF/zeN3+iMmzl2Ul7dQbvmtvv08bGVhW4SfPeLd+/+4AJlU7o8MkokoDJOjyXPJn9Byo7PJ55L6wLgUW2cXYGcNf8U6vwu6Qo2A2zKtPz9T53YGBpEZlT7diOHyXRAF0R7FxLZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoUQMvg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948E6C4CEF1;
	Tue,  1 Jul 2025 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751372417;
	bh=0WOvPMu1XqES/onds8PjGHDXOKh6epjdI3Hxbgaf7X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoUQMvg8bm2iNTnLq8GecvcuKJPvNhlMucnbAWYE7rOlhbgsf1I+ZI1apgCDa62Tm
	 uFkjw7i+WoI61+nVEe49o99umhCKxGI1lIjJnTTUTO+jqeXhKu5NpPbu605u6HreGk
	 0NY62NuiRkg7MDiNu37e22Eg/SQ1iD1xAWAF0ZqFeO6GIY35AQJSkXwmn+2riIu5xb
	 ehOEtRK1EYw23vgWyMkWwvx/0CA7qotRIWQNeh0Ha0nzUkq/ioQhn7Is7Xera3jBPM
	 08a1OyzHZhC/3q3msCHWws70R3Wtd+RxwzszkHHqvlQgYr2p+ZiNRwq+npcT1KP0Z3
	 YGU/C4lr3r83A==
Date: Tue, 1 Jul 2025 12:20:13 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Daniel Latypov <dlatypov@google.com>
Cc: bleung@chromium.org, brendan.higgins@linux.dev, davidgow@google.com,
	rmoar@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
	naveen@kernel.org, anil.s.keshavamurthy@intel.com,
	davem@davemloft.net, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] platform/chrome: Add Kunit tests for protocol
 device drivers
Message-ID: <aGPSfaC1AohSV3_H@google.com>
References: <20250520082435.2255639-1-tzungbi@kernel.org>
 <CAGS_qxrcH0+mJTO4nJqXnk2Bh7oO_PEur=ytcxL8wxJNCu20Tw@mail.gmail.com>
 <aGIvjrrSRPJQpNy7@google.com>
 <CAGS_qxpqQ1Z5QOxmXoXQyFBygdfW+1R=g9f=bbJo54Ex8LA7Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGS_qxpqQ1Z5QOxmXoXQyFBygdfW+1R=g9f=bbJo54Ex8LA7Kw@mail.gmail.com>

On Tue, Jul 01, 2025 at 02:22:40PM +0900, Daniel Latypov wrote:
> On Mon, Jun 30, 2025 at 3:32 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > On Tue, May 20, 2025 at 09:04:53AM -0700, Daniel Latypov wrote:
> > > You mention you don't like how static stubs requires modifying the
> > > code-under-test.
> > > Since it gets eliminated by the preprocessor unless you're compiling
> > > for KUnit, is the concern more so about how it conceptually feels
> > > wrong to do so?
> > > For the Android GKI kernel, they have (or had) KUnit enabled so there
> > > is potentially concern about real runtime cost there, not sure if you
> > > have something similar in mind.
> >
> > Not exactly. Ideally, I think we shouldn't modify the CUT. I'm wondering
> > if there is a way to not change the CUT but also break the external
> > dependencies.
> >
> > > But stepping back, ftrace_stubs technically require modifying the code
> > > to make sure funcs are marked as `noinline`, which this patch series
> > > does not do.
> ...
> > They could be partially inlined even though they are exported symbols.
> 
> So to summarize, right now we're stuck with having to modify the code.
> (Unless someone can come up with something really clever, but not too clever)
> 
> To make it concrete, the current approach would look like:
> 
> int func(char* arg1, int arg2) {
>   KUNIT_STATIC_STUB_REDIRECT(func, arg1, arg2);
>   ... // unchanged
> }
> 
> vs an ftrace/kprobe approach that needs a conditional `noinline`
> 
> KUNIT_STUBBABLE int func(char* arg1, int arg2) {
>   ... // unchanged
> }
> 
> The latter is definitely simpler and less burdensome.
> But I don't know if it's simpler enough to warrant a second
> implementation existing for me personally.

Instead of KUNIT_STUBBABLE macros, I was thinking of:

diff --git a/Makefile b/Makefile
index 35e6e5240c61..40319083f58b 100644
--- a/Makefile
+++ b/Makefile
@@ -979,6 +979,10 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
 KBUILD_CFLAGS += -fno-inline-functions-called-once
 endif
 
+ifdef CONFIG_KUNIT_KPROBE_STUBS
+KBUILD_CFLAGS += -fno-inline
+endif
+
 # `rustc`'s `-Zfunction-sections` applies to data too (as of 1.59.0).
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections


I don't know what are most people's usages. I always run KUnit tests in qemu
or at least in some real devices that I less care about the performance.
Thus, turning inline off globally in such environments is totally acceptable.

