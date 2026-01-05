Return-Path: <linux-kselftest+bounces-48176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2006CF26C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 09:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C1B03001BDA
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B739433343F;
	Mon,  5 Jan 2026 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="Kdi701aT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33CC33343E;
	Mon,  5 Jan 2026 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601884; cv=none; b=gOSegYnu4GbX0NYsQi+QsE7A0VNHDojnHoxiHpdI7QLyytqD1j7PH6qQjP5lLzEjUVYtExBD2kQGEOJQ6JugNTSYHqySfyzsvmEHjI50op/zvi91HzbGPIMY/EYycjv7/VEp0E31qCDf8BftioviEYUEqHi5giDb18hB/HIqmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601884; c=relaxed/simple;
	bh=gv6KdDFJISABMjgCEf5Xsb/e5mJpBEAPd8hEpew9Ppo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sK3mJ3JD5k5v2WC7PFUG8te8d0GXaiSCMdypZaQPSjBU2vv+gwLtWeAV3b+1pmiZXwDJRF3xfwAG7Ouq6hmm+ImjWevlqqd//D+zQegTBXBqEwtR+lGc0o85ZBZcDwm4j5k/nmh5x9aewRCFgMaAGVZbnXw4WaBphTxdV/zl4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=Kdi701aT; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1767601880; bh=Q37A0rzxuWw+vP0tLyMFa4Ua62rbIstKj/79C6auIec=;
	h=From:Message-ID:From;
	b=Kdi701aTAPjACorCt4yLVj177twQpFX7ZMjEFcFlpJZGtnUCDQXprwnRF43mH4FYx
	 3hRBWFAN54WSmC0BHdm+MV4H2Ljve4+GohFAGoXYxIcCNn5Gq2zI520i1/d7ABH97a
	 e61rFYfSKdbhR9W/ll7eg07QC9dbKs2R8foZ1vWc=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id EE821C0943;
	Mon, 05 Jan 2026 09:31:19 +0100 (CET)
Date: Mon, 5 Jan 2026 09:31:19 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: fix sparc32 tests with -mcpu=v9
Message-ID: <aVt2181zh7Ypj0mc@1wt.eu>
References: <20260104-nolibc-sparc32-fix-v1-1-e341b06cbdb7@weissschuh.net>
 <aVtr8vJd_683mqUO@1wt.eu>
 <a1bfcb7c-7fe8-4206-ba17-4ed68493de7c@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1bfcb7c-7fe8-4206-ba17-4ed68493de7c@t-8ch.de>

On Mon, Jan 05, 2026 at 09:19:16AM +0100, Thomas Weißschuh wrote:
> On 2026-01-05 08:44:50+0100, Willy Tarreau wrote:
> > Hi Thomas,
> > 
> > On Sun, Jan 04, 2026 at 11:14:13PM +0100, Thomas Weißschuh wrote:
> > > Since LLVM commit 39e30508a7f6 ("[Driver][Sparc] Default to -mcpu=v9 for
> > > 32-bit Linux/sparc64 (#109278)"), clang defaults to -mcpu=v9 for 32-bit
> > > SPARC builds. -mcpu=v9 generates instructions which are not recognized
> > > by qemu-sparc and qemu-system-sparc. Instead qemu-sparc32plus and
> > > qemu-system-sparc64 with a 64-bit kernel and CONFIG_COMPAT are needed.
> > >
> > > Rework the test setup so that -mcpu=v9 also works correctly.
> > 
> > Hmmm doesn't this mean that we're now unable to emit proper sparc32
> > instructions with this compiler ?
> 
> That depends on the definition of "proper" sparc32 :-)

For sure!

> Jokes aside, that compiler still supports -mcpu=v8 just fine,
> only the default has changed.
> 
> > I don't know which CPUs the kernel
> > still supports, but if it still supports these old SS-5, maybe we
> > should instead pass the correct -mcpu to clang so that it emits the
> > expected instructions, otherwise we're just hiding the regressing by
> > upgrading the test machine beyond what the kernel supports ?
> 
> The 32-bit kernel also runs just fine on QEMU SS-5.

OK!

> My reasoning was more that we now test both the v8 and v9 code paths in
> nolibc. But in the end it doesn't really matter, as it is the same
> kernel interface for v8 and v9. We can also just specify -mcpu=v8.
> I'll do that for v2.

OK thank you for checking and explaining!

Willy

