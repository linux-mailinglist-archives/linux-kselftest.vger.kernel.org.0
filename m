Return-Path: <linux-kselftest+bounces-34107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47CBAC9A89
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 12:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6BE9E7C5A
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 10:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEA5238C25;
	Sat, 31 May 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kh4TyDc1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B1041760;
	Sat, 31 May 2025 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748687157; cv=none; b=u6CImK4oVPBbSJflmsm78G4NqIktkYjYzptdC+ZD7GnG+KeDRWeCFjEDP3OV48eEGuBqqx8cc377eNKZ9oRoQ2CKLlQXOIYEKfJtFGbne6K3quhFGDqlCyi8O2PSCfsS2Je0wUVVmHcjjFP/iaqIiA66Zhh3fsl2fgWNvRTjwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748687157; c=relaxed/simple;
	bh=+gmjqDolMU/6cNi6kpQuNUUonuQoBi05ZwkqfJ4iIao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHxCAvmOyqwy2G29mqzIMJ8uuybu2yrSrGwNgM2l/e0eZ8v1k5gzVphwImHR3iNQ8G0obYn7qxwWYC9Qkd31vsmPXWUBQw/IOHixTH2s4qXBL5DWXr19Im6c/CSIT7MgMKjFLl7wKQ1zQHDfT5OUL/Wo6fVPdFy+5tvEv3nJmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kh4TyDc1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+gmjqDolMU/6cNi6kpQuNUUonuQoBi05ZwkqfJ4iIao=; b=kh4TyDc1EKRiFok397uA0uqi7j
	CKseQl1q4Z20SDvCCTgSS8SJLnyba8wYht/a5sPDV3x0mrCVicMDDXVwxq77K1ZZNlZPzw7pv++Yt
	yChJoaBxkdXbLtqqFgqYvvExW7p3L8BdSuH6a2YulPeg7smpt9KvRpl6s4mYW5hwDLlkXv4FAX1Ol
	qcWY5183QrVr8G+s0e+M6HD5GOjA3QiiEmGh4bBpNOG2nANRtOSqAU1MmZpBQOjhVszI2wgi8nArR
	w6yJUaJMnzY72enu8dvz+kS1CVrelWkgqKNP9sOmQRw2J7qEJR/7PKfTdJc2tKgb24hlIOXLaAaxY
	hWpwzLAg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLJPH-0000000GhJM-1MCd;
	Sat, 31 May 2025 10:25:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 92D3F300787; Sat, 31 May 2025 12:25:38 +0200 (CEST)
Date: Sat, 31 May 2025 12:25:38 +0200
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
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <20250531102538.GG21197@noisy.programming.kicks-ass.net>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
 <20250529090129.GZ24938@noisy.programming.kicks-ass.net>
 <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>
 <20250530140140.GE21197@noisy.programming.kicks-ass.net>
 <202505301037.D816A49@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505301037.D816A49@keescook>

On Fri, May 30, 2025 at 10:48:47AM -0700, Kees Cook wrote:

> This needs docs too. I think this is collapsing 1 and 2 argument WARNs
> into the ud1, and anything larger is explicitly calling __warn_printk +
> __WARN_FLAGS? If only 1 and 2 args can be collapsed, why reserve 0xfe00
> through 0xfeff? I feel like I'm missing something here...

I did something really evil in that first version, I encoded the
registers into the bug type. I've fixed that and have decode_bug emit a
ud_regs thingy now.


