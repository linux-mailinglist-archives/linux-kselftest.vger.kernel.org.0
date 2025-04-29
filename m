Return-Path: <linux-kselftest+bounces-31929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBC0AA1B53
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 21:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E253A0FB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 19:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA84D25E47A;
	Tue, 29 Apr 2025 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KGeLjiu4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2022A7ED;
	Tue, 29 Apr 2025 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745954756; cv=none; b=GSCjrMT2BPtYVJ8XIXXSMKWxSHuBozkmxBOmkAVPXilCgoS6GnaRaLmdjMcC/8SoWn0i0A4PmaOEhpNfiDlYCQEAHZWVjGyaGBJXwcRtTIbEVKmaLVaK6/39YIK9ZzrRwgbDYoglqVS1NzaSr5v+9xBUgTlLIIxswpydKZqsku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745954756; c=relaxed/simple;
	bh=7k94BIZ8kZxo4oJB5l757V3p1rBa7gEdjstcK8HBF6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSLz7JAnCbzRLZNUgPgISQFXT5b7dbgyNnJf8n4/8jmmvMcWRSkDX2tniw0MyNKnlkX9xBwHTw0bfSgIvpC8YQydHLUVxxmOYmcIEc7BnnvnEK7Bi2vkud7T/sUnC230kd9j8hmm30O6KcyLFTko9XPTLD66N5s6zBGqtIPWNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KGeLjiu4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745954752;
	bh=7k94BIZ8kZxo4oJB5l757V3p1rBa7gEdjstcK8HBF6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KGeLjiu4APzhmj+P9ioce1Mg9af6nqNKGYpZBGjW/eNjkAIwA/nnuz4lZJg1aS5sC
	 o0vQmiLYN2+ldD8IYh4zm1VVQqOra9CGFxTkrArs2ZsCcvcA6gkUCesIDHbGbt4n8T
	 dEk9/0Qk1TGj/8B/ihRIVCMrtYQbhmQMAzd7I9lI=
Date: Tue, 29 Apr 2025 21:25:51 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Willy Tarreau <w@1wt.eu>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 00/32] kselftest harness and nolibc compatibility
Message-ID: <9c7f5d7a-75b2-40e6-a13a-00b57f2ad5d3@t-8ch.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
 <20250422103612-64ea71dd-d51d-487e-b387-508c372af07c@linutronix.de>
 <20250422085145.GB14589@1wt.eu>
 <7bb64160-103c-4882-a69b-9bc054e62db8@linuxfoundation.org>
 <329e186d-50e9-46b6-b0ea-ee22ad6e88cb@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <329e186d-50e9-46b6-b0ea-ee22ad6e88cb@linuxfoundation.org>

On 2025-04-29 12:52:56-0600, Shuah Khan wrote:
> On 4/24/25 14:06, Shuah Khan wrote:
> > On 4/22/25 02:51, Willy Tarreau wrote:
> > > Hi Thomas,
> > > 
> > > On Tue, Apr 22, 2025 at 10:48:28AM +0200, Thomas Weißschuh wrote:
> > > > Hi,
> > > > 
> > > > On Fri, Apr 11, 2025 at 11:00:24AM +0200, Thomas Weißschuh wrote:
> > > > > Nolibc is useful for selftests as the test programs can be very small,
> > > > > and compiled with just a kernel crosscompiler, without userspace support.
> > > > > Currently nolibc is only usable with kselftest.h, not the more
> > > > > convenient to use kselftest_harness.h
> > > > > This series provides this compatibility by adding new features to nolibc
> > > > > and removing the usage of problematic features from the harness.
> > > > > 
> > > > > The first half of the series are changes to the harness, the second one
> > > > > are for nolibc. Both parts are very independent and should go through
> > > > > different trees.
> > > > 
> > > > I need a few nolibc bits of this series (snprintf() and prep patches) to base
> > > > further patches on. For that I'd like to pick up all the nolibc patches from
> > > > this series through the nolibc tree. They got Acks from Willy.
> > > > 
> > > > Any objections?
> > > 
> > > No objection on my side!
> > > 
> > 
> > Thanks.
> > 
> > Kees, do you have any comments on this series? If you are okay
> > with it, I would like to apply this for next.
> > 
> 
> Thomas,
> 
> Can this be part of no libc pull request for 6.16-rc1 which I will
> be fielding this time around?

Sure, I'll pick it up.

> If so here is my Ack
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks,
Thomas

