Return-Path: <linux-kselftest+bounces-35779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A92EAE85DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 16:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 697F27A84F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDF4264A9C;
	Wed, 25 Jun 2025 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NhKuR0EE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8E265629;
	Wed, 25 Jun 2025 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860819; cv=none; b=klpjdCeMf8cpRV9ohUo/GEdbmtnmhJ1SU4m7QAFXoFjVshRW2l4YREFumkqDLpu6OR19Q77VwRanTdEtBGv6C19ysgJ74HVdvqpCjpKwhTnr3wOFKz7P3m61DfF5dU9t0p2B4JeqCIJ864w79TWNi26xXcXkcbAZziwS4of+f60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860819; c=relaxed/simple;
	bh=Xu+3guvzOiENbP4PGwXaQ6Dx/qzMgz+1EW/rhP7FAc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t73pB72sxtuppZON2jS1fIe41drxCDB6LFrkH1POHLXipRB/uQd8B+kcoKyNSCwUM0HTZyZLtB5OJSivI8Ii1R94iBaqfGp26sXSPw6u+voUzx3i+eX2QwPunriIk1MEnTq7ukbd6aZfc/WZtrJbz/nT8oegfML/9B/m/lG2GYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NhKuR0EE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750860807;
	bh=Xu+3guvzOiENbP4PGwXaQ6Dx/qzMgz+1EW/rhP7FAc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NhKuR0EEiMHXSjz5JQyzoq4n7Itq6ws4JFS371iOgmwAxwHlweqitPurrklqdy1pK
	 ugfqG9VVwZom2u4vJtyA9ACjhYhHy3tWuavX/l9vRO0l7/x1KYjTFUQ3VoN+a6NMYb
	 PeCNP9M5APn/w9i9vNSDGGW6xu2Xp97PplrbhTyw=
Date: Wed, 25 Jun 2025 16:13:26 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Rob Landley <rob@landley.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, linux-sh@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tools/nolibc: add support for SuperH
Message-ID: <ffeea73d-35e1-44b7-b90d-c1b45f85376b@t-8ch.de>
References: <20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net>
 <16f63653-c5c9-4b32-8e0c-0a4910a9fdb9@landley.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16f63653-c5c9-4b32-8e0c-0a4910a9fdb9@landley.net>

Hi Rob,

On 2025-06-24 21:41:14-0500, Rob Landley wrote:
> On 6/9/25 04:28, Thomas Weißschuh wrote:
> > Add support for SuperH/"sh" to nolibc.
> > Only sh4 is tested for now.
> > 
> > This is only tested on QEMU so far.
> > Additional testing would be very welcome.
> 
> I ran this by Jeff Dionne (the j-core architect) who said:
> 
> > Looks correct to me.  There are no endian assumptions that I can see.
> 
> So you can put
> 
> Acked-by: Rob Landley <rob@landley.net>
> Acked-by: D. Jeff Dionne <jeff@coresemi.io>

Thanks!

> But neither of us really have a build environment set up to do much with it.
> Is there a howto for this, or is just to run the kernel tests?

v2 of the series [0] has some test instructions.
These should also work with v1, except that "-f Makefile.nolibc" needs
to be removed.

$ cd tools/testings/selftests/nolibc/
$ make -f Makefile.nolibc ARCH=sh CROSS_COMPILE=sh4-linux- nolibc-test
$ file nolibc-test
nolibc-test: ELF 32-bit LSB executable, Renesas SH, version 1 (SYSV), statically linked, not stripped
$ ./nolibc-test
Running test 'startup'
0 argc = 1                                                        [OK]
...
Total number of errors: 0
Exiting with status 0

[0] https://lore.kernel.org/lkml/20250623-nolibc-sh-v2-0-0f5b4b303025@weissschuh.net/

