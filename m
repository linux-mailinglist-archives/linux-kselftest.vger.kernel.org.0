Return-Path: <linux-kselftest+bounces-34102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F1DAC99E0
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 09:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE7F4A30D2
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 07:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3D81E5215;
	Sat, 31 May 2025 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t1+DShEQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EBA143736;
	Sat, 31 May 2025 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748677600; cv=none; b=LWWZrVP22+0wTDI8aEsqdCwaAlgsgCD1Ig+aAoxb1lCF3cU3Z8/ScfVM9gS3mmgW9YQbuORg2EDMbflO8CoXMwwJpd27bL3swyC9HVMxW+KT2Tcs2AOpLdXx0+QN485rtTy7gEIFc5XzeXgRHnCvJ4xAiMC8FHWToRCKnXhKY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748677600; c=relaxed/simple;
	bh=PHXwHYatlzqnT0bA0XszBShyk4bieDVek0aNBqNmvIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJs7XCINXfTNhqOORWy+9wnvTjdQWS4AgkveJdaToTTlErVzsky8tRiPppf3CcPlkL91rsVAuS34Iko1B36jn82I0xuRCCSfOTAanuPwDHoasuzXyX4e2B/4dgfdCXQDo6NG4g1yOwUUbUV+UFYunDkg3+k8m97f/AgBoGgBsIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t1+DShEQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vHtJ0rUGHhX/CQdQbU6ZDVMIjLovSJXXeNJdF3gZOCs=; b=t1+DShEQzcDn5LQT0aspjXhRf/
	7RxT5oLc5jrneWc82F5Dr0LTy9I3aEPpiNWX6OuKSE7V6wdElpBM9sLNZO07JvGZ8xu3M40Aztr+g
	CdiSLVamsrgUoitOH+D6cqsxC5TFsyukFy41zbubp8nmarAGtLnLXy/eUJ8u/+JI6QIhDI9dBbNxK
	8SU8A//s9ARGQlqB8IHniHCMIntW60Jmt1CEgjep0QI/z5ooPeFd54sk+QO7hQsRwm5nO2M05MMGb
	TK9kIerCSNvF9Vm1IlYV+Yc7uIKodSbWa6akTkgN5bvH9zMXLs5j8Id5y2HtLRzABaHUzH4SaG5ou
	HEh/X2zQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLGv2-0000000Gb56-0pYT;
	Sat, 31 May 2025 07:46:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 90FE1300787; Sat, 31 May 2025 09:46:15 +0200 (CEST)
Date: Sat, 31 May 2025 09:46:15 +0200
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
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <20250531074615.GA19817@noisy.programming.kicks-ass.net>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
 <20250529090129.GZ24938@noisy.programming.kicks-ass.net>
 <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>
 <20250530140140.GE21197@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530140140.GE21197@noisy.programming.kicks-ass.net>

On Fri, May 30, 2025 at 04:01:40PM +0200, Peter Zijlstra wrote:

> I'm not really concerned with performance here, but more with the size
> of the code emitted by WARN_ONCE(). There are a *ton* of WARN sites,
> while only one report_bug() and printk().

We need a new and stronger unlikely(), resulting in the compiler being
forced to split a .cold sub-function/part which lives in .text.unlikely

At that point it becomes less of a concern I suppose. 

AFAIK the only means of achieving that with the current compilers is
doing a manual function split and marking the part __cold -- which is
unfortunate.

At some point GCC explored label attributes, and we were able to mark
labels with cold, but that never really worked / went anywhere.

