Return-Path: <linux-kselftest+bounces-33801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 994A0AC41C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECB2189B079
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74E520FA9C;
	Mon, 26 May 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lDnKj95H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zm8REmFi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4674E202F83;
	Mon, 26 May 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271024; cv=none; b=NsobHpoFdE4P6bOYYoAs+wm8MZ75NM4hf1ZTy3VF/SJddYJgJMHoPYMdL1C8o+4g7A8ntOQd1XvwyyxrPFu+CLmWzCSZMJPqAebVTU+VIUfu+mFMEZCFl3hWEnTlxj+tzv/VlgeMFsKQD51obIB8M7iOKXO/J0G6IRQtXCd9A4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271024; c=relaxed/simple;
	bh=6aKzDgGB/ZUmFcoUldyOCp1+E10okRiX8GJYWNpjka0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWmCzNoqBwN02WSz6hgmJHG0s/9dA4EU499/UJj2MxoWghB4HhxsSPED3e8swXS/dZVYObRnL277Kia7M32KzwHcu1hpFbd/8u+jDNEam164alH3fLew8jgXZqNfReXy/6Xt866mQJ9JJNUgkf3vgb/lvKg8AUdBxLRWu39EEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lDnKj95H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zm8REmFi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 May 2025 16:50:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748271020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNlsAOL7ZgwI2HEsBSEBPxt6J5Za4EdYqqyFjUCPx+s=;
	b=lDnKj95HzNnLs+kNUe+FsdhY6xmb8zMvOyt3YglhAP4AMP1McZ0Q0WRq30XvZ1dD8AHl96
	EKaEYdE7+Ref10HJ7RgivJBYUoIUsl2/HFxLcm/jABo+S75ibkApABSHxCIJbFfnVBjWDY
	+w1UuaI2jAV8MB58wsgr0q+Mz7ZsylyNpQx2A9VtnD3ifETfyqdJ2GaMyyH+bddcsTmG/R
	tudzmruX3Dvk2rH3i+WuyqbrckCRdcT6XcuilC50BwB3QudmW8NcyzbMoEPnrTKXwyajek
	8yUA+jn8dg70ny23F9a/XWbZYGT0vfmdXtz6XoTRslHHkwyOniU90HnYGL5o8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748271020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNlsAOL7ZgwI2HEsBSEBPxt6J5Za4EdYqqyFjUCPx+s=;
	b=zm8REmFiKPwOTZ24+PZoOb7jWmzgaIsmL406pqgMB9q9a/Alo73hYSk10LJpi6Wb0fJKVA
	9XxmVxesYvMMHIAQ==
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
Message-ID: <20250526164038-12259c68-586f-4a24-a814-8ffed5778742@linutronix.de>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
 <20250407-kunit-kselftests-v2-9-454114e287fd@linutronix.de>
 <20250526-marvellous-abstract-koala-317cb4@l-nschier-aarch64>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250526-marvellous-abstract-koala-317cb4@l-nschier-aarch64>

On Mon, May 26, 2025 at 04:22:02PM +0200, Nicolas Schier wrote:
> On Mon, Apr 07, 2025 at 09:42:46AM +0200, Thomas Weiﬂschuh wrote:
> > Extend the example to show how to run a userspace executable.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  lib/kunit/.kunitconfig         |  2 ++
> >  lib/kunit/Makefile             |  9 ++++++++-
> >  lib/kunit/kunit-example-test.c | 15 +++++++++++++++
> >  lib/kunit/kunit-example-uapi.c | 22 ++++++++++++++++++++++
> >  4 files changed, 47 insertions(+), 1 deletion(-)
> 
> 
> Adding this diff allows 'make clean' to clean up the UAPI test binary:
> 
> 
> diff --git a/lib/Makefile b/lib/Makefile
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -112,8 +112,6 @@ CFLAGS_REMOVE_test_fpu_impl.o += $(CC_FLAGS_NO_FPU)
>  # Some KUnit files (hooks.o) need to be built-in even when KUnit is a module,
>  # so we can't just use obj-$(CONFIG_KUNIT).
> -ifdef CONFIG_KUNIT
> -obj-y += kunit/
> -endif
> +obj-$(if $(CONFIG_KUNIT),y) += kunit/

Wouldn't the following be sufficient?

obj-y += kunit/

The the kunit Makefile doesn't do anything if CONFIG_KUNIT=y and AFAIK for
directories obj-m and obj-y should do the same.

>  
>  ifeq ($(CONFIG_DEBUG_KOBJECT),y)
>  CFLAGS_kobject.o += -DDEBUG
> 
> 
> 
> plus the 'clean-files' addition below.

<snip>

> > diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> > index 989933dab9ad2267f376db470b876ce2a88711b4..1b6be12676f89cafa34f0093d8136b36f4cf5532 100644
> > --- a/lib/kunit/Makefile
> > +++ b/lib/kunit/Makefile
> > @@ -30,4 +30,11 @@ obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
> >  obj-$(CONFIG_KUNIT_TEST) +=		assert_test.o
> >  endif
> >  
> > -obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
> > +userprogs +=				kunit-example-uapi
> 
> clean-files +=				kunit-example-uapi

This shouldn't be necessary as $(userprogs) is automatically added to
__clean-files in scripts/Makefile.clean.

> > +kunit-example-uapi-userccflags :=	-static
> > +kunit-example-uapi-nolibc :=		$(CONFIG_ARCH_HAS_NOLIBC)
> > +blobs +=				kunit-example-uapi.blob.o
> > +
> > +obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-mod.o
> > +kunit-example-mod-y +=			kunit-example-test.o
> > +kunit-example-mod-$(CONFIG_KUNIT_UAPI) += kunit-example-uapi.blob.o
> 
> -- 
> Nicolas Schier

