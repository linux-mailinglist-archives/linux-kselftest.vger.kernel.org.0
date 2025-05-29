Return-Path: <linux-kselftest+bounces-33981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F4BAC7A9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 11:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23919A43CD2
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678EB21B9C3;
	Thu, 29 May 2025 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eMNB7fUo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11B21B8F8;
	Thu, 29 May 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748509368; cv=none; b=NZiMu3XnhOJotc3w3kxouZtSDb96brkbduG6q4c1qL3OJU95IulKivI54aO7FzvjDQtT5uCWsruSh+xAwapWcX1QVlbVa2yP1za0kFHCyqP/iGPa9A2JKJSC9vcraaB6T9ePccEt0KH/SkcgGJ4JB1n9+Endor2Bj5YDgPjP1EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748509368; c=relaxed/simple;
	bh=329oE9WCShRB/3QSD5347ZmJuUzW2AKy1kGxUA9l7Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjtOUrVmE5mpowlCWSZP2L8s4910TO9mOEETdGBqxCp1xpf+hhkmsaypIblOLR+SeT5lNkbLlMaBuRlLdpJNnUUDXzG8Bi4xLpxQL0VOA/A3rUc1GRSx18Q9Pm/EIQMWmdGvR5qlwc4ZZO2elvxXMrw/ng3qqGg0rI3xAb3UAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eMNB7fUo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HKJazYyVUxZwZjpx7rpY6/R5Vj8bS07F1odK3H9jHLg=; b=eMNB7fUo/1FgcxbOdQuF2r/kYX
	qV1xN+llHYjOp7B0PwNTJpfs7dzrSlOcVTibvnRFZ/qrogqn1MY4T3QsxTwblw3hoqHAeoD9hJ2qR
	Awih0ms4vbkG83lzrvofFOYNU4EblQ+qHfb5WfpW4wcjf1cVyBdODinakYxgaePnC79A6Xq16Sk/5
	4xll1VA2wdEKkEwFYNLcdn/n1x0fUTlZNjNN0kRrGQuv73cFpfoznp2yt7OpBCpcuVKmFXT9dSmPP
	fW+TlbJYnKz/F80qHoNIl7R2zmTzMpgr4AC3UYVhKIgYZFDlLsAjDNq7tMrT8/cyFMefKCVXZsjSy
	4Tch/ddA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKZ9Y-000000006vJ-3HJd;
	Thu, 29 May 2025 09:02:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DC66430057C; Thu, 29 May 2025 11:02:19 +0200 (CEST)
Date: Thu, 29 May 2025 11:02:19 +0200
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
Message-ID: <20250529090219.GA24938@noisy.programming.kicks-ass.net>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
 <202505281546.DB9D9029@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505281546.DB9D9029@keescook>

On Wed, May 28, 2025 at 03:47:42PM -0700, Kees Cook wrote:
> On Mon, May 26, 2025 at 01:27:51PM +0000, Alessandro Carminati wrote:
> > Some unit tests intentionally trigger warning backtraces by passing bad
> > parameters to kernel API functions. Such unit tests typically check the
> > return value from such calls, not the existence of the warning backtrace.
> > 
> > Such intentionally generated warning backtraces are neither desirable
> > nor useful for a number of reasons:
> > - They can result in overlooked real problems.
> > - A warning that suddenly starts to show up in unit tests needs to be
> >   investigated and has to be marked to be ignored, for example by
> >   adjusting filter scripts. Such filters are ad hoc because there is
> >   no real standard format for warnings. On top of that, such filter
> >   scripts would require constant maintenance.
> > 
> > Solve the problem by providing a means to identify and suppress specific
> > warning backtraces while executing test code. Support suppressing multiple
> > backtraces while at the same time limiting changes to generic code to the
> > absolute minimum.
> > 
> > Implementation details:
> > Check suppression directly in the `WARN()` Macros.
> > This avoids the need for function symbol resolution or ELF section
> > modification.
> > Suppression is implemented directly in the `WARN*()` macros.
> > 
> > A helper function, `__kunit_is_suppressed_warning()`, is used to determine
> > whether suppression applies. It is marked as `noinstr`, since some `WARN*()`
> > sites reside in non-instrumentable sections. As it uses `strcmp`, a
> > `noinstr` version of `strcmp` was introduced.
> > The implementation is deliberately simple and avoids architecture-specific
> > optimizations to preserve portability. Since this mechanism compares
> > function names and is intended for test usage only, performance is not a
> > primary concern.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> I like this -- it's very simple, it doesn't need to be fast-path, so
> a linear list walker with strcmp is fine. Nice!

But it is on the fast path! This is still bloating every UD2 site
instead of doing it on the other end.

