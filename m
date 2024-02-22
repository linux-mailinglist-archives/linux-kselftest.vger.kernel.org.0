Return-Path: <linux-kselftest+bounces-5304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2D586038A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 21:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286681C24C01
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 20:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64D76E5E4;
	Thu, 22 Feb 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="MXbt9HCa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6779F6AFAD;
	Thu, 22 Feb 2024 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632828; cv=none; b=CAAclzQGJS1YIQ6REemuudY5j2uGjTIeQtcVVI8q1Sq24xpxfD9kRGxKaiBKqYbL3W8xVkGYuVVvr/dWCfAASbn9pemLCCuyqnTlsqKTWeh5qcotNaeIle2QFURO/0Bax0iLqWqkWRu9CdduLnfzeVrmH1NUO4NzcPlYcB5OOgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632828; c=relaxed/simple;
	bh=Bzqj9upov+YN4Xc3VOA9yLsfurtpG9SIO5Z5p/qAT5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VakwDWTLSRYCu5KG96bYwBE9xFgrJVptTKMVTz/P0qyT2j9k2hbiWFBpWNc+BvXBA3obMf3Q2+1drwSyjm04HjXDpBxnoa4YptAd1AHuJE7DKN1DqMk9FAC65S9+U6rKhH1uFzPPYCp5yvaLcYE3Y52UnLQEuUxfYUevGnk2ZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=MXbt9HCa; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=0g5teL/n5S+RyGZPCJuly52FIIN0RTxzUZ1PD1yiqLY=; b=MXbt9HCaHiADHguxB+2kjLzWwW
	/yriGZHNpCvyH0N7IonnVMBClFtzq7aizl3s8osISv3omVzAOPqgEoKlBg4hXR3g+xiIs7XcP4oWV
	5rf7Vt9YFMLxUNBHGPQqamWO0c1gJwoQgfSyrvI2rL/hX/RLDh06dOHtUvVK9lRjmtni3U/yZJt5a
	YBm4nRcOXSRmHpb80zqUbjjH5pPpRPJFqvjcdZqmwlFyVar08PTUsAKRKa71YE6QPfQDaOPt7vlw/
	tEap0uFHI+Z6+UZ117fK/UlaNWnaW46UxFIidN2bNTLWDmkTh2SB648ddAsA3IDvSEKsciiCpqbtl
	ZC7w9/qg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rdFRs-005oSw-1T;
	Thu, 22 Feb 2024 14:13:40 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>
Subject:
 Re: [PATCH v2 01/31] ntsync: Introduce the ntsync driver and character
 device.
Date: Thu, 22 Feb 2024 14:13:40 -0600
Message-ID: <7630697.EvYhyI6sBW@camazotz>
In-Reply-To:
 <CAMuHMdX=aXYmUbVNOH9osDFB+nv7N=xpE76w_Ds190tV1-D9=w@mail.gmail.com>
References:
 <20240219223833.95710-1-zfigura@codeweavers.com>
 <20240219223833.95710-2-zfigura@codeweavers.com>
 <CAMuHMdX=aXYmUbVNOH9osDFB+nv7N=xpE76w_Ds190tV1-D9=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 22 February 2024 04:56:21 CST Geert Uytterhoeven wrote:
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -506,6 +506,17 @@ config OPEN_DICE
> >
> >           If unsure, say N.
> >
> > +config NTSYNC
> > +       tristate "NT synchronization primitive emulation"
> > +       help
> > +         This module provides kernel support for emulation of Windows NT
> > +         synchronization primitives. It is not a hardware driver.
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called ntsync.
> > +
> > +         If unsure, say N.
> 
> Is it useful to have this feature on systems or architectures that
> are not supported by Windows NT?
> 
> If not, this should depend on <something> || COMPILE_TEST.

Hmm, that's an interesting question. Currently only Wine supports x86 and ARM, 
as the only architectures supported by modern Windows. On the other hand, that 
hasn't always been the case, and there's been some desire to use Wine (as a 
porting tool) on architectures that Windows doesn't support, and out-of-tree 
ports to e.g. PowerPC to that end.

Perhaps more saliently, there's no reason I'm aware of that this code *can't* 
run on any architecture, and Wine (or another NT emulator) may grow support 
for more architectures in the future. I (with my limited experience) don't see 
a reason to artificially limit ourselves, especially if the driver is disabled 
by default.

--Zeb



