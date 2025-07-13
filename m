Return-Path: <linux-kselftest+bounces-37206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C31FB031A7
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 17:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76F5178CF7
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6A6130E58;
	Sun, 13 Jul 2025 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dmMW/5vD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E265149DF0
	for <linux-kselftest@vger.kernel.org>; Sun, 13 Jul 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752418952; cv=none; b=gKxGgq4GYnYCggy9opX3hVsPOxSmIEoZLoIPpl6QRA4Ss0Je8vFLJlMzqd6BWMR9hjaXPfcraWkPxvuFcfH+1tq5iJFrIpYfG0HGd3yqF594ghrhBeJwFAg4F7oZFy4sSXYOulPfj6D8E3kdZMpwWCG9X06V4DFwKOLBbU8gxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752418952; c=relaxed/simple;
	bh=yW4YhpBRrcNKiC/TkAd6DSO8P5dD8GpAHkOs3Haf6zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE0qW2Lhgt9hkkiTkfULr0FlhNO2pc1j3L1rbFCIesrukFIGe+Ff181FdpKIXMGFX8RX7gpZ88GxFQ6Z7467uOib/VwxL7D/EG8tw4VPQlp6yac2V7mmUWkdmBh2EEATHjyWeOrVVcmHQrBzv/zr7WphdAzp6k7giInVwm3wnDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dmMW/5vD; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752418948;
	bh=yW4YhpBRrcNKiC/TkAd6DSO8P5dD8GpAHkOs3Haf6zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmMW/5vDOffRNMosUXRl4eGBAP4+r0h7F0f1fDf3/cWOMD+MV/luImvZsZyhKzLtD
	 ffNeaLsNQuSBs4RcWL3NX9fnboSkciiV79608aSuP6B1CNhQhAHnRgg5x53bD1LXY6
	 kC7RCPe6Ud/5vQ/9RfsoSwIK5/YKQ5B0+FMKZzAI=
Date: Sun, 13 Jul 2025 17:02:27 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tools/nolibc: add signal support
Message-ID: <3f901ecb-d6d1-4fb4-9159-a6b817b0dd39@t-8ch.de>
References: <20250710103950.1272379-1-benjamin@sipsolutions.net>
 <20250710103950.1272379-5-benjamin@sipsolutions.net>
 <f72ddf71-40e4-49d0-92b6-da219e33bd29@t-8ch.de>
 <b1c3684e1e299f787a88c58a063ab4d0485a59a7.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1c3684e1e299f787a88c58a063ab4d0485a59a7.camel@sipsolutions.net>

On 2025-07-11 09:25:26+0200, Benjamin Berg wrote:
> On Fri, 2025-07-11 at 07:40 +0200, Thomas Weißschuh wrote:
> > On 2025-07-10 12:39:50+0200, Benjamin Berg wrote:
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > 
> > > Add support for sigaction() and implement the normal sa_mask helpers.
> > > 
> > > On many architectures, linux/signal.h pulls in compatibility
> > > definitions
> > > for the old sigaction syscall instead of rt_sigaction. However, the
> > > kernel can be compiled without support for this compatibility
> > > syscall
> > > and it also results in sa_mask to be too small for realtime
> > > signals.
> > > 
> > > To work around this, the includes are handled separately for each
> > > architecture. This way either linux/signal.h or the asm-generic
> > > headers
> > > can be used to get the correct definition for the rt_sigaction
> > > syscall
> > > including sigset_t.
> > 
> > I checked this against my WIP alpha support and there this scheme
> > breaks. linux/signal.h provides the old compat types but
> > the asm-generic variant provides an incorrect SIGCHLD.
> > 
> > Any ideas?
> 
> I had a quick look, and I don't have a good idea really. For sparc
> there was at least a #define that permitted to get the correct version.
> But here, there is nothing.
> 
> Probably the best is to just copy in a modified version of signal.h
> with the correct definitions present. i.e. replace the "ifndef
> __KERNEL__" sections with something reasonable.

But then we can just have our own copy for every architecture, no?
To me that looks like the best solution right now.
These UAPI headers and APIs are a mess...


Thomas

