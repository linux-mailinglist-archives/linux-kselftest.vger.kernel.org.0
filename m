Return-Path: <linux-kselftest+bounces-34046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B78AC8AA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 11:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C957AC770
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75696212B3D;
	Fri, 30 May 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jV0apYW3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A178F1E2607;
	Fri, 30 May 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597129; cv=none; b=Vzf+lhhcDRixN4weTg4nDdSXxOZf4mVszmNjExDup9xu9dAUuYkyxwDofSW97GenoFRpbGGlkjkho0jyKL3tUCyJ+JTtFng+1rcLFNGHWWGojy6ciqVpXvWF5q7Fm9aubr1qq1ZGfDFafkO3h1JTfNauuXc+UYh4xvVBm5gMkv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597129; c=relaxed/simple;
	bh=VQGmwyM6dLX+gLYISfq5UOreX82SGJdDBvUZapXWo04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnamftOTNKbg4g9KKO3yQmb9IHGmG8noOzIXeZRae6nGdoZB7oyRTADdg4o3LxGcBevxQqwHIEwoI6eP9ZrM5/0IF8/GENSmjHMvykkAWctH1LmPnzrLJVlbo/kESKDJe0YTLXBNbq5Q5N32dBV2vfIPJ1sP1FHguyHZbHDx70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jV0apYW3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gR91zQSzqCbc3p6LvARTFu1cbopw2P782WLK55P4y9w=; b=jV0apYW3ub6N06ZD9T9v3FuV5K
	8OCyuhQR5SUnrJzr922AI1qgToxXFgO6EzLmuCrDcA/SAGntoV2dm5WIgeh03WDK7kBzT1wX8R5t6
	bkw5aawChHySMdH/PAEr65qjbXWItpI1HhRp+G7EG9yqA7dJKsP+mPNGqnKBXVklbZLjojJ17Pm+F
	9F7RLHZ8ySEobL386mYcnQHYD+DdNM+V8SbXXa0fk4RyzIclP0yJuqJME0Idb/NGKNZgONhF/3fuL
	RRTe6GPIIVatAgaezKjvjGVe0khmr6MN/kUZHdkBUmmUOGeMaQ5WSdeWRT7gkRXHBcvQkSyDC8K2m
	fPb95lpw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKvzA-00000000EJS-2hvT;
	Fri, 30 May 2025 09:25:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1C03B30066A; Fri, 30 May 2025 11:25:08 +0200 (CEST)
Date: Fri, 30 May 2025 11:25:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Alessandro Carminati <acarmina@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <20250530092507.GC21197@noisy.programming.kicks-ass.net>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
 <202505281546.DB9D9029@keescook>
 <20250529090219.GA24938@noisy.programming.kicks-ass.net>
 <202505291033.E7E3E6C@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505291033.E7E3E6C@keescook>

On Thu, May 29, 2025 at 10:46:15AM -0700, Kees Cook wrote:

> Doing it on the other end doesn't look great (see the other reply).  I was
> suggesting it's not on fast path because the added code is a dependant
> conditional following an "unlikley" conditional. But if you wanted to
> push it totally out of line, we'd likely need to pass __func__ into
> warn_slowpath_fmt() and __warn_printk(), and then have __warn_printk()

warn_slowpath_fmt() already uses buildin_return_address(0), and then it
can use kallsyms to find the symbol name. No need to pass __func__ as a
string.

> return bool to make the call to __WARN_FLAGS() conditional. e.g.:
> 
> -		warn_slowpath_fmt(__FILE__, __LINE__, taint, arg); \
> +		warn_slowpath_fmt(__FILE__, __LINE__, __func__, taint, arg); \
> 
> and:
> 
> -		__warn_printk(arg);					\
> -		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
> +		if (__warn_printk(__func__, arg))			\
> +			__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
> 
> But it still leaves bare __WARN unhandled...

Nah, don't propagate, just eat the __WARN and handle things in
__report_bug(), which is where they all end up.

But the real purpose here seems to be to supress printk output, so why
not use 'suppress_printk' ?

