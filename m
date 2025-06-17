Return-Path: <linux-kselftest+bounces-35193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B84ADC530
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FB916D8E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 08:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805F9290BB0;
	Tue, 17 Jun 2025 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ATAyRaXj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gAfgb4Xk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F1290BAB;
	Tue, 17 Jun 2025 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149591; cv=none; b=iiPeRurvHEMNfANIsetZmLOZs1OgMVs2Es0m7ry4+rEdXpsu0SDt1vwfa2ormqarFrFg+U4MpKzNmJAGhOwBiDt9+ZDzNyuVCjIUXTqmWeefnsvoKcLLhdmf6cf2ZNpvEwZyk999nkkT5rBd2c4Vw3sIO9IAAVUxDICypi1HIME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149591; c=relaxed/simple;
	bh=C7584Xx/Amk/69d+nH2rfTD7njdEQ/VaI5dVy4JbI5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LENULq0eiKB42r0mNO4sd+gy3nDcNW3nwET+V/eLoPGjb+QWtX/79Qo3AIsTlDdObzMqJbL1uau3/LGdBp3n3ikP4TrOKQH3IAmXIXRpKf4KTxmot8FNh2luDbscSkUCqYjUTxOvTCBpIGbspCdeIVjGhM5m2UQEa9xP5isCeoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATAyRaXj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gAfgb4Xk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Jun 2025 10:39:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750149587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LuNROY7fBURYzSkXn6+wAOOV6+xjlnawA4hPGIMRsIw=;
	b=ATAyRaXjCirZfNob2evS7Wuf8c0yTOEN8/vz6eHIPDlIXnicQ5DJPouGS4PPZB7x1ad0F7
	rtvOnyt8hpUObxIRMdaXkwpHfMG2d/syorOszG8mSTH8zKNKMJFkS7b0lXCvIY7y5H3YZu
	nmIdqwDkZ9labG0Uj3HdOxgVv0NNYLL8LNs9YMj4WKEsZmosiugKZoxaCjU2Ei9ot4Orfp
	6cL9MHWOfpXElG1a8yNsHmRMvTXLWPX8k7PtueA4LZGEvN4n0sJkTvlV+rpvJ0DGIG6ox5
	+ciE6tEokXrk4njF36MhXS/S4j+hP0yVA/4adPfa6EyAA8PvPqw9ViINWf5Xlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750149587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LuNROY7fBURYzSkXn6+wAOOV6+xjlnawA4hPGIMRsIw=;
	b=gAfgb4Xk1GokthqTc2b8ggyL6kBiq4QSNtbLX6zqF2T13yzqyRd+2xZcXQxEmKUC7qDcjO
	X5YbhDMMHHe79HCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Subject: Re: [PATCH 3/3] kunit: test: Drop CONFIG_MODULE ifdeffery
Message-ID: <20250617095936-50d985a4-ea18-49cf-9d16-dfd0dd0b627f@linutronix.de>
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-3-fdccd42dcff8@linutronix.de>
 <fb2a41b2-a872-4fcd-8a97-df3a946c6a81@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb2a41b2-a872-4fcd-8a97-df3a946c6a81@suse.com>

On Tue, Jun 17, 2025 at 09:44:49AM +0200, Petr Pavlu wrote:
> On 6/12/25 4:53 PM, Thomas Weiﬂschuh wrote:
> > The function stubs exposed by module.h allow the code to compile properly
> > without the ifdeffery. The generated object code stays the same, as the
> > compiler can optimize away all the dead code.
> > As the code is still typechecked developer errors can be detected faster.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> I'm worried that patches #2 and #3 make the code harder to understand
> because they hide what is compiled and when.
> 
> Normally, '#ifdef CONFIG_XYZ' or IS_ENABLED(CONFIG_XYZ) directly
> surrounds functionality that should be conditional. This makes it clear
> what is used and when.

#ifdef is discouraged in C files and IS_ENABLED(CONFIG_MODULES) does not work
(here) without patch #2.

> The patches obscure whether, for instance, kunit_module_notify() in
> lib/kunit/test.c is actually used and present in the resulting binary
> behind several steps. Understanding its usage requires tracing the code
> from kunit_module_notify() to the definition of kunit_mod_nb, then to
> the register_module_notifier() call, and finally depends on an ifdef in
> another file, include/linux/module.h.

I agree that it is not completely clear what will end up in the binary.
On the other hand we can program the happy path and the compiler will take care
of all the corner cases.
We could add an "if (IS_ENABLED(CONFIG_MODULES))" which does not really change
anything but would be clearer to read.

> Is this really better? Are there places where this pattern is already
> used? Does it actually help in practice, considering that CONFIG_MODULES
> is enabled in most cases?

This came up for me when refactoring some KUnit internal code.
I used "kunit.py run" (which uses CONFIG_MODULES=n) to test my changes.
But some callers of changed functions were not updated and this wasn't reported.

The stub functions are a standard pattern and already implemented by module.h.
I have not found a header which hides structure definitions.

Documentation/process/coding-style.rst:

	21) Conditional Compilation
	---------------------------

	Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
	files; doing so makes code harder to read and logic harder to follow.  Instead,
	use such conditionals in a header file defining functions for use in those .c
	files, providing no-op stub versions in the #else case, and then call those
	functions unconditionally from .c files.  The compiler will avoid generating
	any code for the stub calls, producing identical results, but the logic will
	remain easy to follow.

I should add the documentation reference to patch #2.

