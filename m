Return-Path: <linux-kselftest+bounces-34553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 386D6AD3523
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF84218973D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 11:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C26828D846;
	Tue, 10 Jun 2025 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zengxAxP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bj7g6lja"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C1428C879;
	Tue, 10 Jun 2025 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555507; cv=none; b=P3zw26LFjFdBNfTE1EbZwr3hBpKqhMMsgpK3lo6bG5NEYgDVE5PfwepL/bePk3D3j0CswnW0D5y/4SVtDZYmMHsJEH6b6HC7Nn94FivoMqykChe12CwJlHkVYN+g+wh6ibUECbs4zeunM4AYxy4aBHOmaw2cZvkvJkfyRd3IbmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555507; c=relaxed/simple;
	bh=saQJgJ40zLRoImrcHIci/m7zB2SdX7s7xsnoOFJH5PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc6PFhC4jtyV/j/DZxndMOTV6Ikwuv3KfDl/VQkQT3R7dtPmxpqxov1TY9r5y0YT2Z9c26ETXiybxRZM3XGijwMoQaJ5DtfC4R9wk/Ja+U3+Ht6uYz4NWrXgOwWlBgJkRruaXPKNZME4uE6WJDN534ySRYkGtNUZgNehaZijJ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zengxAxP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bj7g6lja; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Jun 2025 13:38:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749555503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSw5S23Ns9NarGdtXYak9rgj9yiHWjbqtOM603pR3no=;
	b=zengxAxPVvAxiB1g1q764yX+paAVzxDfsnQPd3xTA79EUwjH0Qvcv2XticCYnqpiGfsB93
	0tw7epXCmtW3H61C9y8EV1ef+DqME0PoOTosMnOlekIYbuMk096qJqRy2B2q2iuMgqYs6C
	6HhtKqkKwgGDoqw1lb1CTFVbIGROCBzzVy0LOSNrdik7/vWjvks+fQPL6sqhE0X2kvMjFA
	vp8ujGADqMgofm3pnGEgCYNsCAfLn+tH4P0aePR3qZqCaVLWDNFUdjpOocMfvI058pIoDd
	k8jpwRIiYoEsbtCzCGBkTPoxPx062i4Xmc9stTp6uNtVPN8SxhVZ3f35ZYzbKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749555503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSw5S23Ns9NarGdtXYak9rgj9yiHWjbqtOM603pR3no=;
	b=bj7g6ljaoOIN1x0F9ruTZfTFzhKJ1xqTD4VxPFx3gYHPrDOfoD3u2vtutwmF1nYJeN5uzr
	ev9VahxLsc9+ACCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <20250610130817-253d2b2d-030a-4eda-91fc-3edb58a4f549@linutronix.de>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-9-ee4dd5257135@linutronix.de>
 <aEfVYQaid5uOHB+Y@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEfVYQaid5uOHB+Y@nvidia.com>

Hi Nicolin,

On Mon, Jun 09, 2025 at 11:49:05PM -0700, Nicolin Chen wrote:
> CC += Jason
> 
> On Mon, May 05, 2025 at 05:15:27PM +0200, Thomas Weiﬂschuh wrote:
> > To get rid of setjmp()/longjmp(), the teardown logic needs to be usable
> > from __bail(). To access the atomic teardown conditional from there,
> > move it into the test metadata.
> > This also allows the removal of "setup_completed".
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Certain hugepage tests in iommufd selftest (CONFIG_IOMMUFD_TEST)
> start to fail since v6.16-rc1, though the test functions weren't
> changed during last cycle:

Thanks for the report.

> ------------------------------------------------------------------
> #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty ...
> # enforce_dirty: Test terminated unexpectedly by signal 11
> #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
> not ok 193 iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
> #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.set_dirty_tracking ...
> # set_dirty_tracking: Test terminated unexpectedly by signal 11
> #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.set_dirty_tracking
> not ok 194 iommufd_dirty_tracking.domain_dirty128M_huge.set_dirty_tracking
> #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.device_dirty_capability ...
> # device_dirty_capability: Test terminated unexpectedly by signal 11
> #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.device_dirty_capability
> not ok 195 iommufd_dirty_tracking.domain_dirty128M_huge.device_dirty_capability
> #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap ...
> # get_dirty_bitmap: Test terminated unexpectedly by signal 11
> #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap
> not ok 196 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap
> #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear ...
> # get_dirty_bitmap_no_clear: Test terminated unexpectedly by signal 11
> #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear
> not ok 197 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear
> ------------------------------------------------------------------
> 
> Git bisect points to this patch, and reverting it and its following
> patches fixes these.
> 
> I haven't debugged it, hoping you might have a quick thought. Lemme
> know if you need some details to figure out what's going on.

I can't reproduce this report.
On my development machine or a virtme-ng VM I get the following failure:

	# ./iommufd -r iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
	TAP version 13
	1..1
	# Starting 1 tests from 1 test cases.
	#  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty ...
	iommufd: iommufd.c:2042: iommufd_dirty_tracking_setup: Assertion `vrc == self->buffer' failed.
	# enforce_dirty: Test terminated by assertion
	#          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
	not ok 1 iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
	# FAILED: 0 / 1 tests passed.
	# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

Specifically the mmap() fails with ENOMEM.

When booting the VM with "hugepages=100" the test succeeds.
The same result happens when running all the subtests.

Could you give more specific reproduction steps?

On another note, the selftest should use the kselftest_harness' ASSERT_*()
macros instead of plain assert().


Thomas

