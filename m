Return-Path: <linux-kselftest+bounces-37253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19928B0402E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C420D17622C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED735242D67;
	Mon, 14 Jul 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AgVfpKfl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4921D001
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500050; cv=none; b=sSYjZUKjTbU1QL0D9+KyjjbwPcTZEjcUPDQsxygceMzALAmQxYBz5xZ+Mrvd1sF+CwAOGXBeNdzrRMmQuwzG1sVigXt7y/wEdamnGOBw3lUqZgHHEdLxyO5Ouy1R3dSkP2eUtUvEEaivha1CzhmECi8o4Yq9vHMWsCp2cD2Fyic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500050; c=relaxed/simple;
	bh=nmhsXBmrnsSFUmroFoD+RRyd/s6TYTxjVHhNOs9ZowY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPiDwtxrKp2uAB9KLcN8Te/OXCYrAmh+Aa7Iwmqpuf2od3bo+MrhjjuUSH2ImJV+9M31oV/M/rVYtqhPwT8a+sobScDkGlWtLMcq0I/wYFH66toZoDmCZuKHMUQ60elh+cZ0G7BLeOnV+IRHzDUZsJK3IB2KlfEMX3rs+Pohgx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AgVfpKfl; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752500040;
	bh=nmhsXBmrnsSFUmroFoD+RRyd/s6TYTxjVHhNOs9ZowY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgVfpKflArSVvgLMYyO7eUlwl/u5AKNa36lM/39OLMrQuOQsLpzC8Oam40FZMKKHT
	 PC187XYSV6HB7xdcKNf1Gyrc6o/DhJSDccRCGcZmOtLF+a/M8YvYaOTQC1rYDi1w1N
	 y+04jPc5nN7dGMJTEVcX2YsOgYgFblx0ToI3O5Jo=
Date: Mon, 14 Jul 2025 15:33:59 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tools/nolibc: add signal support
Message-ID: <2bcf913f-aafa-42a8-9f8d-615d8b5500fb@t-8ch.de>
References: <20250710103950.1272379-1-benjamin@sipsolutions.net>
 <20250710103950.1272379-5-benjamin@sipsolutions.net>
 <f72ddf71-40e4-49d0-92b6-da219e33bd29@t-8ch.de>
 <b1c3684e1e299f787a88c58a063ab4d0485a59a7.camel@sipsolutions.net>
 <3f901ecb-d6d1-4fb4-9159-a6b817b0dd39@t-8ch.de>
 <20250713155002.GA25876@1wt.eu>
 <e4dd8d10c8d27fa9b939a3381df86a82a4d791f0.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4dd8d10c8d27fa9b939a3381df86a82a4d791f0.camel@sipsolutions.net>

On 2025-07-14 14:52:23+0200, Benjamin Berg wrote:
> On Sun, 2025-07-13 at 17:50 +0200, Willy Tarreau wrote:
> > On Sun, Jul 13, 2025 at 05:02:27PM +0200, Thomas Weißschuh wrote:
> > > On 2025-07-11 09:25:26+0200, Benjamin Berg wrote:
> > > > On Fri, 2025-07-11 at 07:40 +0200, Thomas Weißschuh wrote:
> > > > > On 2025-07-10 12:39:50+0200, Benjamin Berg wrote:
> > > > > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > > > > 
> > > > > > Add support for sigaction() and implement the normal sa_mask helpers.
> > > > > > 
> > > > > > On many architectures, linux/signal.h pulls in compatibility
> > > > > > definitions
> > > > > > for the old sigaction syscall instead of rt_sigaction. However, the
> > > > > > kernel can be compiled without support for this compatibility
> > > > > > syscall
> > > > > > and it also results in sa_mask to be too small for realtime
> > > > > > signals.
> > > > > > 
> > > > > > To work around this, the includes are handled separately for each
> > > > > > architecture. This way either linux/signal.h or the asm-generic
> > > > > > headers
> > > > > > can be used to get the correct definition for the rt_sigaction
> > > > > > syscall
> > > > > > including sigset_t.
> > > > > 
> > > > > I checked this against my WIP alpha support and there this scheme
> > > > > breaks. linux/signal.h provides the old compat types but
> > > > > the asm-generic variant provides an incorrect SIGCHLD.
> > > > > 
> > > > > Any ideas?
> > > > 
> > > > I had a quick look, and I don't have a good idea really. For sparc
> > > > there was at least a #define that permitted to get the correct version.
> > > > But here, there is nothing.
> > > > 
> > > > Probably the best is to just copy in a modified version of signal.h
> > > > with the correct definitions present. i.e. replace the "ifndef
> > > > __KERNEL__" sections with something reasonable.
> > > 
> > > But then we can just have our own copy for every architecture, no?
> > > To me that looks like the best solution right now.
> > 
> > I generally agree. Originally in nolibc, lots of stuff was copied and
> > we only used very little of UAPI. As new architectures were supported,
> > we took this opportunity for cleaning this up and relying more on UAPI,
> > but that doesn't mean we need to get rid of our local definitions all
> > the time, so if that helps, yeah clearly we can have our local copies
> > and definitions.
> 
> Not sure our own copy for every architecture is the best solution. Many
> of them work fine with the asm-generic headers, and using those where
> they apply seems pretty reasonable to me.

I meant *one shared* copy for all architectures.
It would essentially be the asm-generic definitions with some ifdeffery.

> So, maybe that would be a good compromise? i.e. use asm-generic where
> possible and copy in a file otherwise. That seems slightly less
> convoluted and still avoids having to actually fix the architecture
> headers.

Does my proposal from above satisfy this?


Thomas

