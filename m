Return-Path: <linux-kselftest+bounces-4809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A95F856D50
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 20:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8870E1C23E93
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F119139562;
	Thu, 15 Feb 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="rg0Hdjtb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B496E12D75F;
	Thu, 15 Feb 2024 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023860; cv=none; b=L75HLaHAQc4Q4n5G0rFZUIcIHkyGcQy/GjiCCzHgZ1aTMEx9u9JEqcbDsDv2dH+Ggc5xKcbgJnLt7xlqdgn+tMbTy2F2XigNwAzluWd4cJWqTGriQT92puAAqnNT8pX1CTxSHvBCMzP9KSapqy+4lTbKpsRerr530id7IfIOTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023860; c=relaxed/simple;
	bh=HYmJH9FlFar2LSJS4Rf0ZwmqXkUarTQN1CFW8NL4Nds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBwR6J/zybMzTPDQfek+aX8iy3WvutXxAZQcY1I6eSAsEXGkPXJqOFSEZTU8NRJaqBoiW8sa/mCIqmyvDzVszitWgCL3GSoQ3xRwSc220UOJ9f3M/8L0VEnpqTZl3oROLypQL6/v8UwZvRM0qyAzNklUns8z0ShfxJu/RQDW4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=rg0Hdjtb; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=pIfAYq4N+gqGnpM/2pjkFTmquDU3bWf7IeLw/ovzE98=; b=rg0Hdjtbip4Ksba0pqUURE4fP9
	GEGUhSU0N5X+FnuzqLGh2LjcSFAsjQpPJA7jMoQ2PYX3FdHNgjPL7QxNw3GDhmA6cQIJO8mCXahwd
	TdyL+Mrj6o7J5uloSt4dYrI3WbLfeUr5PKmzDS6bolMORjmDf+zqgB583E/w/Bp1L5P7TdaMyBCng
	ehhke1Kcr0SJW3qgw+FUDJYTE4u2CgRdxmt/S5UdkPmvd8tpd4gTaOEaumpq/hgoRrv07H17k6ds2
	+6hoIFrJHD+5TIQp7veZFY0D1VZzBPu3kztUOYC2LZJM8lJX7s7Hxw8kaqeXXnOG4xNrqzqca1Ll4
	K1+zg0/g==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rah1c-00HJp9-2j;
	Thu, 15 Feb 2024 13:04:00 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject:
 Re: [PATCH 01/31] ntsync: Introduce the ntsync driver and character device.
Date: Thu, 15 Feb 2024 13:04:00 -0600
Message-ID: <4897444.31r3eYUQgx@camazotz>
In-Reply-To: <51a442ec-3835-4282-982b-734c0962141c@infradead.org>
References:
 <20240214233645.9273-1-zfigura@codeweavers.com>
 <20240214233645.9273-2-zfigura@codeweavers.com>
 <51a442ec-3835-4282-982b-734c0962141c@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 14 February 2024 19:57:23 CST Randy Dunlap wrote:
> Hi,
> 
> On 2/14/24 15:36, Elizabeth Figura wrote:
> > ntsync uses a misc device as the simplest and least intrusive uAPI interface.
> > 
> > Each file description on the device represents an isolated NT instance, intended
> > to correspond to a single NT virtual machine.
> > 
> > Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> > ---
> >  drivers/misc/Kconfig  |  9 ++++++++
> >  drivers/misc/Makefile |  1 +
> >  drivers/misc/ntsync.c | 52 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 62 insertions(+)
> >  create mode 100644 drivers/misc/ntsync.c
> > 
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 4fb291f0bf7c..bdd8a71bd853 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -504,6 +504,15 @@ config OPEN_DICE
> >  	  measured boot flow. Userspace can use CDIs for remote attestation
> >  	  and sealing.
> >  
> > +config NTSYNC
> > +	tristate "NT synchronization primitive emulation"
> > +	help
> > +	  This module provides kernel support for emulation of Windows NT
> > +	  synchronization primitives. It is not a hardware driver.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ntsync.
> > +
> >  	  If unsure, say N.
> 
> It looks like the "If unsure" line belongs to the OPEN_DICE kconfig entry
> above here. If you want one for NTSYNC, please add one.

Oops, looks like that was a bad rebase :-(

> 
> >  
> >  config VCPU_STALL_DETECTOR
> 
> 
> > diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> > new file mode 100644
> > index 000000000000..e4969ef90722
> > --- /dev/null
> > +++ b/drivers/misc/ntsync.c
> > @@ -0,0 +1,52 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ntsync.c - Kernel driver for NT synchronization primitives
> > + *
> > + * Copyright (C) 2024 Elizabeth Figura
> 
> It would be nice to have your email address above...
> 
> > + */
> > +
> 
> > +
> > +MODULE_AUTHOR("Elizabeth Figura");
> 
> but at least please add it in MODULE_AUTHOR(). Yes it's optional, but
> roughly 7900 of 10400 entries do include it (according to my rough
> grepping).
> 
> Yes, I know that it's in MAINTAINERS.

Will add, thanks. As you guessed I did just pick an arbitrary module to copy.



