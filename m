Return-Path: <linux-kselftest+bounces-34639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF72EAD4C13
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 08:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5D41787DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 06:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CF722ACFA;
	Wed, 11 Jun 2025 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qsvLbKLJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WarEaKmc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473114B07A;
	Wed, 11 Jun 2025 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749624807; cv=none; b=tpFldqvYn97mRZf66F4QUosoPUnRCsDWxy9bqUlr/O8jQAzKAAs6hXKaiJOqa2SibqUhZfWhIgA90uWKJXA1gpMhPfTZvJWiARJ7QJM+zNkSEFHDMdrHTDb1IVzviQHbdYPuHoTgXzoi46oV1gkb1Fo+HcjTw+4zO0vTC55KFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749624807; c=relaxed/simple;
	bh=2brzaQdI5K2BRfT9bqvgdFVDaKnfP2G7GR+inuAUFrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXNxmF1Ohtto4846YRI3HX8N4n+iP2ee6i+xPnUdEHtoQF7B4eE+sYkK7D5xmfrm0GdmpS6MwYSHV2mLYj3Sz2TpEEPcBtsUSxALspGTsTe6BsUJyBLaS4ufJ7FXSZxw0G9+kvwe67mJhuQK3Nktk0ZeDDMZT8YuefoNM7dr4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qsvLbKLJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WarEaKmc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 08:53:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749624804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y93XEFwBv7AiJZNlzn/5hdQGj+mu2itce8t1/fii/Kw=;
	b=qsvLbKLJ2GuF71ZMVepjRRclTjiuWvouRH3ObVQhMr1P+rntmHGpg8qiSKZbKe6NWP/edA
	cLwFTK+gxgyevL+MEKPOHIefD5KpJF42QfGjB9IAk4o4RqgMLZXDeV9t0xmHb60FYiPeeE
	9R0jlK0VX1Wuw65ITjqY4O9CX76BCtPXVDTfJKRkWzv2fiKhfI36sjIsDf/Ce4gnPIG0Um
	XkgrUsWLdwQGDCepozKq0V2hObekhxaDeMtFRwWoZG0Yv5FVZQzVQTvORF90pb1VhZIKTE
	+uutkSOE2Iiz2+e41Q28HY3+TsSzEZck595kyYpUsIE3ReHr/peCJaBO20T9JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749624804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y93XEFwBv7AiJZNlzn/5hdQGj+mu2itce8t1/fii/Kw=;
	b=WarEaKmcPCsakYLPxMnJQddxt0TBqAmGwqZZZ2S3/8oPKDzgZz0vxiflIHmopSZ0Hnr9Ui
	CCYGPiBdTXmKHsAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <20250611084548-a6bd87a7-6f35-490a-b613-5718250acf67@linutronix.de>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-9-ee4dd5257135@linutronix.de>
 <aEfVYQaid5uOHB+Y@nvidia.com>
 <20250610130817-253d2b2d-030a-4eda-91fc-3edb58a4f549@linutronix.de>
 <20250610120902.GB543171@nvidia.com>
 <aEh+DNmbZrqg6rHR@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEh+DNmbZrqg6rHR@nvidia.com>

On Tue, Jun 10, 2025 at 11:48:44AM -0700, Nicolin Chen wrote:
> On Tue, Jun 10, 2025 at 09:09:02AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 10, 2025 at 01:38:22PM +0200, Thomas Weißschuh wrote:
> > > > ------------------------------------------------------------------
> > > > #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty ...
> > > > # enforce_dirty: Test terminated unexpectedly by signal 11
> > 
> > Sig 11 is weird..
> 
> > > On another note, the selftest should use the kselftest_harness' ASSERT_*()
> > > macros instead of plain assert().
> > 
> > IIRC the kselftest stuff explodes if you try to use it's assert
> > functions within a fixture setup/teardown context.
> > 
> > I also wasn't able to reproduce this (x86 ubuntu 24 LTS OS) Maybe
> > it is ARM specific, I think Nicolin is running on ARM..
> 
> Yes. And I was running with 64KB page size. I just quickly retried
> with 4KB page size (matching x86), and all failed tests pass now.

That is very important to know. It should be mentioned in the report.

So I tried to reproduce it. To get even the mmap() in the test to succeed I
needed to also pass default_hugepagesz=2MiB.
Also 1GiB of memory was not enough. 30GiB was however.
But then the tests succeeds fine for me.

So I'll need reproduction steps.


Thomas

