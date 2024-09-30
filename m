Return-Path: <linux-kselftest+bounces-18564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D7F9899FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027791C20F97
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 05:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF486126C18;
	Mon, 30 Sep 2024 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SWqWfhBo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3439B5B05E;
	Mon, 30 Sep 2024 05:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727673827; cv=none; b=VNMQFO7gCsRgyhQuW+vfRiJrcC+8AwGELRXqv2EC4mVz7Bhmvm1sPd6vsAlOvpgoKoguhOxTvZYGfcUo66iiTpBcY0ao1lqbm2nDYZapuXHzJQVLh9xOIzEmAWIxj09CcS02y3hWvy6Wvzgk+3S+EY6tf1O2pOnRRMEjyu4y6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727673827; c=relaxed/simple;
	bh=1PeDEsITlfGpEyTKDtomgnXfFPtDuRy0oGtchmuHklY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFb2LOHamiJVWK+uEp+Gt04TqtHf6A9ruD6jyVqP/AA/SzLCL3CkbqSCGiKXk64jGC2z6dME1D0pmOtywLkdMhPmqKELhQC0tNwANut6CPE7OWhYblMKz6AEN3YBSdlrCJLQno8qQbTH1p2omLUosvub9abLpqoSSfSySf1RvSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=SWqWfhBo; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1727673819;
	bh=1PeDEsITlfGpEyTKDtomgnXfFPtDuRy0oGtchmuHklY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWqWfhBoa/PSXQp6dF2/KjaUipTpdhehUoNzPH3h7d1RZe3cFj0IpLTPoFm4bsMRT
	 sWz6fCyLmXoByF7zqUHV4obYBN17HAwCdlc2xUnYMT3BGhylpgZOioEajSUGrppzMr
	 E9As2+yc7YLpy59ZqI6N60femfckok1rUDqePUKs=
Date: Mon, 30 Sep 2024 07:23:39 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Guo Ren <guoren@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/5] tools/nolibc: add csky support
Message-ID: <2f4a244d-e88c-4378-8b1b-71204964dab6@t-8ch.de>
References: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
 <20240929-nolibc-csky-v1-4-bb28031a73b0@weissschuh.net>
 <20240930034946.GB13730@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930034946.GB13730@1wt.eu>

Hi Willy,

On 2024-09-30 05:49:46+0000, Willy Tarreau wrote:
> On Sun, Sep 29, 2024 at 11:47:39PM +0200, Thomas Weißschuh wrote:
> > Add support for the C-SKY architecture, which is very similar to
> > LoongArch.
> > Only v2 ABI is supported.
> > Optimizations are disabled as the compiler[0] seems to misoptimize the
> > code, especially the r4 register gets clobbered.
> > Compile the initramfs directly into the kernel, as qemu does not support
> > passing the initrd via OF.
> > 
> > There is no qemu mainline support for qemu.
> > Testing was done with commit 1f172a2c7cd5c2e7 of the downstream csky qemu [1].
> > Some tiny changes were necessary on top [2].
> > 
> > [0] gcc 13.2.0 and 14.2.0 from kernel.org crosstools
> > [1] https://github.com/XUANTIE-RV/qemu/
> > [2]
> 
> I think you wanted to place a link or something above for [2].

[2] was supposed to be inline patches for QEMU, I'll try to make that a
bit clearer.

> > diff --git a/target/csky/cpu-param.h b/target/csky/cpu-param.h
> > index 80554cc0fc03..9181b602a26f 100644
> > --- a/target/csky/cpu-param.h
> > +++ b/target/csky/cpu-param.h
> (...)
> > diff --git a/target/csky/op_vdsp2.c b/target/csky/op_vdsp2.c
> > index a9985a03be33..d953f5ea94fe 100644
> > --- a/target/csky/op_vdsp2.c
> > +++ b/target/csky/op_vdsp2.c
> 
> Also, the first two patches look like fixes for the arch itself, they
> should really go outside of the nolibc development tree, at least
> because they might have to be backported to some stable branches,
> or later fixed/reverted in case they wouldn't be optimal.

As mentioned above, these are patches for qemu, not Linux.
I don't know enough about QEMU or C-SKY to know if these are the
generally correct fixes. But they seem to work well enough for nolibc.

Guo, if these QEMU patches look reasonable to you I can also submit them.

> Aside this, it's been a long time since we last added an architecture
> and it's pleasant to see how easy it has become over time, even when
> requiring specific settings ;-)

Agreed!


Thomas

