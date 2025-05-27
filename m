Return-Path: <linux-kselftest+bounces-33866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA39BAC5150
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 16:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709B818920A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECB92798E6;
	Tue, 27 May 2025 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wdY3kauB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1iMWerTV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4591276050;
	Tue, 27 May 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357516; cv=none; b=S9PimCnmnGcA7JXVKQ5/B7K7s4sw7MyZw2j+vX23X/ggeFY3kNnxCNFFBNyKKpv3m00otwY/iHirzXaGwDrnN7U2WwQbLwi++YBzKs2zGwo+lcZqA5yJJpymn0AwlcpvRtfB438ke8Ufqd1h4FVBcryU91/PJSqy0+I/UY0XpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357516; c=relaxed/simple;
	bh=cmWVBXyCnDhgtaqPxFZD0Z5OdQ75nRbRM5ot30LJH88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob48WrOcEKxzQjDlwaBq+oNL6Ve+QwvxDCepAiMlvJ17ptQqbY0mqH0tbaGnS/YTk8yuf9GufwuwEBkik+CEO1ymUomApVQO57AXnaiQjKVoraHJQOMuYlZHYGR3SFea77MGR3H4cfmKunJoHtfLzeqVSPOucWUPrdJHN+xQjpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wdY3kauB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1iMWerTV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 May 2025 16:51:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748357510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLLddXy0LKyaYi11oTN10X4v2tluFuR5tW4jJF8R+Xo=;
	b=wdY3kauBDESuhaepipwXdJdgLTkWmkFa9CQ/5nbSYokghUU/PYCjiw4zc2k9p4cgDT7bqQ
	YWCSK5Xeq74PvsjJpif9AstmIaS0d6DvW89DIIfBG9wBrnboG6p5jC5Jae8WStSAkoqXsi
	NyRl5qMujotsvzQ/YwFabxxxDaavmHa2XIkLcDhjosta+FX5hWwza8Rw9ugUm0hmrdphIw
	Rzk1K/Fs9+UrTMLiEpGXx13X7iLnRwh6EwgvQQSvtHGypCkXQMvJQDbU/S2ReB1s8x+8/x
	s8TXCKqTsDxvM+3I6ZqTxLciCikNlqiATIjXyQGB2y6UTDSTF708GHfSfr/0sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748357510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLLddXy0LKyaYi11oTN10X4v2tluFuR5tW4jJF8R+Xo=;
	b=1iMWerTV4u9O+OZ2CvRWA5izDulQijwZXuRVry3Qbczp+j+ZeBmhTjEm+guXnYhJ2C1PPl
	h4TW8EVhEb+wZTBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Nicolas Schier <nicolas.schier@linux.dev>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 09/11] kunit: uapi: Add example for UAPI tests
Message-ID: <20250527164906-a0121867-5b6d-43ae-9263-ca2bebf44d99@linutronix.de>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
 <20250407-kunit-kselftests-v2-9-454114e287fd@linutronix.de>
 <20250526-marvellous-abstract-koala-317cb4@l-nschier-aarch64>
 <20250526164038-12259c68-586f-4a24-a814-8ffed5778742@linutronix.de>
 <20250527-dark-uakari-from-pluto-fbc8ae@l-nschier-aarch64>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250527-dark-uakari-from-pluto-fbc8ae@l-nschier-aarch64>

On Tue, May 27, 2025 at 03:56:17PM +0200, Nicolas Schier wrote:
> On Mon, May 26, 2025 at 04:50:19PM +0200, Thomas Weiﬂschuh wrote:
> > On Mon, May 26, 2025 at 04:22:02PM +0200, Nicolas Schier wrote:
> > > On Mon, Apr 07, 2025 at 09:42:46AM +0200, Thomas Weiﬂschuh wrote:
> > > > Extend the example to show how to run a userspace executable.
> > > > 
> > > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > > ---
> > > >  lib/kunit/.kunitconfig         |  2 ++
> > > >  lib/kunit/Makefile             |  9 ++++++++-
> > > >  lib/kunit/kunit-example-test.c | 15 +++++++++++++++
> > > >  lib/kunit/kunit-example-uapi.c | 22 ++++++++++++++++++++++
> > > >  4 files changed, 47 insertions(+), 1 deletion(-)
> > > 
> > > 
> > > Adding this diff allows 'make clean' to clean up the UAPI test binary:
> > > 
> > > 
> > > diff --git a/lib/Makefile b/lib/Makefile
> > > --- a/lib/Makefile
> > > +++ b/lib/Makefile
> > > @@ -112,8 +112,6 @@ CFLAGS_REMOVE_test_fpu_impl.o += $(CC_FLAGS_NO_FPU)
> > >  # Some KUnit files (hooks.o) need to be built-in even when KUnit is a module,
> > >  # so we can't just use obj-$(CONFIG_KUNIT).
> > > -ifdef CONFIG_KUNIT
> > > -obj-y += kunit/
> > > -endif
> > > +obj-$(if $(CONFIG_KUNIT),y) += kunit/
> > 
> > Wouldn't the following be sufficient?
> > 
> > obj-y += kunit/
> > 
> > The the kunit Makefile doesn't do anything if CONFIG_KUNIT=y and AFAIK for
> > directories obj-m and obj-y should do the same.
> 
> that's wrong.  In lib/kunit/Makefile there is
> 
>     obj-y += hooks.o
> 
> thus, lib/kunit/hooks.o would then be built unconditionally (even w/o 
> CONFIG_KUNIT).

Indeed, thanks for the hint.

> Iff we would add 'obj-y += kunit/' in lib/Makefile we'd have to adjust the 
> hooks.o line in lib/kunit/Makefile appropriately.

I'll go with the 'obj-y += kunit/' solution for now.
It keeps the special logic for hook.o in a single place, gets rid of a
duplicate comment and is easier to understand.

<snip>

