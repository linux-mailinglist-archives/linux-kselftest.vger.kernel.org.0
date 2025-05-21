Return-Path: <linux-kselftest+bounces-33460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369CDABF58B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 15:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A3B7B51DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C53926A0EA;
	Wed, 21 May 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fKWFAuZu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0A268FCC;
	Wed, 21 May 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832890; cv=none; b=mU+d+5b3HEfqxV/nqY8Akj814WNw05E0tMbRf/g+uYf91z59AsRiXOxMZWaOL+aDP2wTli2EUJo5QW10xvrebVdo7SI/WySWVjEPewmUoEgORZWvzIvdPgjyBE2EkJn9jan6ts4IBAysRFHCtSkAr8j+Ybx+rE7Kd/ArI8yt+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832890; c=relaxed/simple;
	bh=fIFbvUE+7ShaGlMu0DT91/1t57RXRWhRtDdzNOlW1ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVQtXJ2xOXm0sMIAbFwsflLelSluwLwcwSGyQkGK5otklEJReUpvQ3+iG1INqLHuYV3ytXh2Z9dETsOdFByDkiuKrRU8+jV9CEMxU/0dbWaMLvDKegFWd3J3jp8fOL47Xvti68q9m5yk0IRMPPbHZ1ol9DcerG8It6hnH51Gzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fKWFAuZu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747832886;
	bh=fIFbvUE+7ShaGlMu0DT91/1t57RXRWhRtDdzNOlW1ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKWFAuZud8U/TnvvBXCVZp2W+fhs3Od4rVL+v40c54EmO4/C8qv9yjyQkbLXmRJEa
	 Du9E/NTGyA4JJvQt9Ieo5cSBtzNEfBmRW0uLuD4WtY0pwzpsJVmbVMF2EDAH7i4iXi
	 9cBhGsj69Ye3nviOl3IDfWg8J8HhWEQpjg5UtURU=
Date: Wed, 21 May 2025 15:08:05 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/9] tools/nolibc: move ioctl() to sys/ioctl.h
Message-ID: <89bb5a3e-dd6c-475d-9c5d-0bd1595be735@t-8ch.de>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
 <20250515-nolibc-sys-v1-1-74f82eea3b59@weissschuh.net>
 <eda3af4a-8dfe-4f82-a934-2d0256b754e2@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eda3af4a-8dfe-4f82-a934-2d0256b754e2@sirena.org.uk>

On 2025-05-21 14:03:37+0100, Mark Brown wrote:
> On Thu, May 15, 2025 at 09:57:47PM +0200, Thomas Weißschuh wrote:
> > This is the location regular userspace expects this definition.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> This is in -next as b8c436bbef0f2a and breaks the build of all the arm64
> selftests using nolibc: 
> 
> clang --target=aarch64-linux-gnu -fintegrated-as -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
> 	-static -include ../../../../include/nolibc/nolibc.h \
> 	-ffreestanding -Wall tpidr2.c -o /home/broonie/git/bisect/tools/testing/selftests/arm64/abi/tpidr2 -lgcc
> In file included from <built-in>:1:
> In file included from ./../../../../include/nolibc/nolibc.h:100:
> ./../../../../include/nolibc/sys/ioctl.h:8:10: fatal error: 'nolibc.h' file not found
>     8 | #include "nolibc.h"
>       |          ^~~~~~~~~~
> 1 error generated.
> 
> This happens because:
> 
> > +++ b/tools/include/nolibc/sys/ioctl.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> > +/*
> > + * Ioctl definitions for NOLIBC
> > + * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
> > + */
> > +
> > +/* make sure to include all global symbols */
> > +#include "nolibc.h"
> 
> assumes that the nolibc include directory is in the include path, or
> otherwise set up with a -I path, previously you just had to include
> nolibc.h with the includes that are there working due to being relative
> to nolibc.h.  I'll send a patch for the arm64 tests.

Thanks for the report.
Inside sys/ this should actually be #include "../nolibc.h".
I'll doublecheck all of sys/ and see why our new header checks didn't
catch this.

> It looks like the RISC-V selftests are also impacted, I didn't spot any
> other users that didn't already have an -I.

No changes to the selftests should be necessary.

