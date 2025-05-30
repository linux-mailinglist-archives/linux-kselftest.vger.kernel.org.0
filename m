Return-Path: <linux-kselftest+bounces-34047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EC7AC8AAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 11:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52403AFC55
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 09:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CDE21578F;
	Fri, 30 May 2025 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WpoQ9h57"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F028E7;
	Fri, 30 May 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597231; cv=none; b=JdnBE48od39KiDkS7NuPVX2o599/N9OAEGsWSOVEUlRN7KgoKIWMtfcvoHNhKqs7ikdaZTWaPxdlzQiDawAhEQ8r+Fxtx3bVvPwLh9H6gz8EI91crhi5SDspPpYMfO4QW84kzE19sR2wluG83x0SJ2oRa9Oczq2z8DTZWlsO/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597231; c=relaxed/simple;
	bh=S68uPq17WZaaig3YYau5FbjK8jVtSkT3sV5dlxTcvbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1F7IoKlkML4T3FBJhuBkTEs3NzWHPcaIbZ+kutgyiLCJQVSQNIFSEFGfJdefTDm1dR5pcCvO7n2YuCv5S+N5zMhv9fev/nWtDe9leO4ctBm+Dx06wUCdWDy15OylDrEAQoby6/B/ffUFpyoCnYdGMi2l28ZPGwnxEyEs7sGaIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WpoQ9h57; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S68uPq17WZaaig3YYau5FbjK8jVtSkT3sV5dlxTcvbw=; b=WpoQ9h57imN1XDky33PL1TodSv
	nU41lQXxPIhVXakg1H7t0QzxNN1TqmvTUP9oIsTFOezvvJ7yWTfQlz+t2QBBtYWk1SwdWZ0zw+T9T
	KQl22fYC4+NrFD8Bcu/5uAAWoCfOiu6dWRColJ+DrXI6zGBwCl/2x2rwObCx4gvnQD49x2sSQJxQJ
	0dTqxQfeVECwhY7qXBAksnDrfgJfw/h7JCaHdhvfp8jej/pVVDgKgt690wRa7OEjePfjyq/wglHyX
	27aHCMACf413OMjvmAHdCZ1XclrJ36nRWqdo5D8j36FpkrMi4J8WwMjdU4MT7tcxZDJK8/gtaNj/u
	lIqzCukA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKw0x-00000000EKE-3gbi;
	Fri, 30 May 2025 09:27:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 733FE30066A; Fri, 30 May 2025 11:26:59 +0200 (CEST)
Date: Fri, 30 May 2025 11:26:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: linux-kselftest@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
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
Message-ID: <20250530092659.GD21197@noisy.programming.kicks-ass.net>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526132755.166150-2-acarmina@redhat.com>

On Mon, May 26, 2025 at 01:27:51PM +0000, Alessandro Carminati wrote:
> A helper function, `__kunit_is_suppressed_warning()`, is used to determine
> whether suppression applies. It is marked as `noinstr`, since some `WARN*()`
> sites reside in non-instrumentable sections. As it uses `strcmp`, a
> `noinstr` version of `strcmp` was introduced.

That just sounds all sorts of wrong.

