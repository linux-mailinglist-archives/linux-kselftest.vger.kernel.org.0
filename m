Return-Path: <linux-kselftest+bounces-48290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A16CF8295
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 12:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EC503083638
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296092E3387;
	Tue,  6 Jan 2026 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RZEf/L4m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D958533D6;
	Tue,  6 Jan 2026 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700081; cv=none; b=VFqUZ2PbBky3lN00VuDPN4of8me7WxvkrrYYtNul7DZkZUGmN5O+RefpX+Oa0fPaue8B1vXq5fqNi6xKWiIZY/OL9WlKniQbujvdt6xZ+LL9CoUcUBTbo17xXs+bdSZHCCVbHQxftEOL0+JhQ7erFK8ObVdHvkAkJKJ71yxwhiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700081; c=relaxed/simple;
	bh=XY36ClG9zTm+CzYc1uX17jgji2/+fwD8r11RaSnvAJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMZmWvhTK9UNaTp2kvgYR9AIdXOVsqeFLFuWMaBPN1izYCabNDolgNPs6djSo8Ypox2t5wW2NYdNEhkD9X6eDniwyhjLR8pMCgB3m5zu9kDVbhmKNWT9G53LlRmww2aPwh599mtRYHT7u3YAkQoDGKfH3aG/20MgYMLeH5RO+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RZEf/L4m; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1767700076;
	bh=XY36ClG9zTm+CzYc1uX17jgji2/+fwD8r11RaSnvAJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZEf/L4mnWB1mn19O1IfbqKMgWMnwiCUrgEvu6gwXfiA7NADZ52Lo3lu8QGnkh8Wn
	 hQ6QisiFGY4fOYy7gEHar/JCj4JBJT4dx1xq5rcct2K7zSjvGCUis9uQVEV5K+Ulqt
	 0BjtoWav7NErP2uqPx7hEkODALjAb8AYt66gUct8=
Date: Tue, 6 Jan 2026 12:47:56 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: fix sparc32 tests with -mcpu=v9
Message-ID: <18bb48f2-b5aa-42a6-bc09-4773e1907670@t-8ch.de>
References: <20260104-nolibc-sparc32-fix-v1-1-e341b06cbdb7@weissschuh.net>
 <CAMuHMdUHBm_oiyeUumRc=avp+QCiCLZAfi0BvLwToAM3TumGmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUHBm_oiyeUumRc=avp+QCiCLZAfi0BvLwToAM3TumGmQ@mail.gmail.com>

Hi Geert,

On 2026-01-06 12:40:12+0100, Geert Uytterhoeven wrote:
> On Sun, 4 Jan 2026 at 23:14, Thomas Weißschuh <linux@weissschuh.net> wrote:

(...)

> > --- a/tools/testing/selftests/nolibc/Makefile.nolibc
> > +++ b/tools/testing/selftests/nolibc/Makefile.nolibc
> > @@ -117,7 +117,7 @@ DEFCONFIG_riscv32    = rv32_defconfig
> >  DEFCONFIG_riscv64    = defconfig
> >  DEFCONFIG_s390x      = defconfig
> >  DEFCONFIG_loongarch  = defconfig
> > -DEFCONFIG_sparc32    = sparc32_defconfig
> > +DEFCONFIG_sparc32    = sparc64_defconfig
> 
> How can we test sparc32 using a 64-bit kernel?

CONFIG_COMPAT=y

Please note that this changed in (the now committed) v2 anyways:
https://lore.kernel.org/lkml/20260106-nolibc-sparc32-fix-v2-1-7c5cd6b175c2@weissschuh.net/

> >  DEFCONFIG_sparc64    = sparc64_defconfig
> >  DEFCONFIG_m68k       = virt_defconfig
> >  DEFCONFIG_sh4        = rts7751r2dplus_defconfig

(...)


Thomas

