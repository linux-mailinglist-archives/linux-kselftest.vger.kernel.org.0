Return-Path: <linux-kselftest+bounces-35784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3172AE88D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 17:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2621188AE12
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7612C286D79;
	Wed, 25 Jun 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="P5H8jZOy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CF81F4615;
	Wed, 25 Jun 2025 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866758; cv=none; b=rhg8DDffAAvL90Fs2CIz7etdCvLLDcv1FqFCJZDhT699jvTNfRwSx110fixwXPJL1Gy90gZ0DEe7dflTLvq7cHiwQEgl4GeBA01WQRBNcSd5s031Ftg9+ipkumo7XtotsEo7fDypWtDC5nRypYoqJfybgKFjyOig5L2mC05n2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866758; c=relaxed/simple;
	bh=bH0kDF7BFilvEJbkRhhoIc8M6HQqocq19xYY3JaANok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uq84NDARQAYY0MEzHCd4R1OLVVbySURwaIgMLq/7V+JCfQH62I7zc4c4daO7M+ldxk6zOJapTQuynUAzES4VY0Xv2nmwIR+6iSw/J1j8LLtG9nSV4K8XZOa4Q4loZnl1QTnYkwf2RYSSYGR3ccQYHAr/pKSLt0MT6s/vDSkl4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=P5H8jZOy; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7YkoxpAiWf696r/i3mlzSQmtAmY4Lcnph464pjSmZw0=; t=1750866754; x=1751471554; 
	b=P5H8jZOyB59R7fyvywQ62iX9WCLGPgX0w/EdhArrUYqFx3P9kIGLWVF0+5B5vBMhpFi2Z2rHaEO
	HsP9a3m5qqR8vY5OMHvHdiRGXlYb8lJkkp9AcmdS38PLmmiot/3mNUABsHGBs1DrEOKSOYHwtJG2L
	NBepuuJHtHBeA4U1WpNNABOCDetmrTeQD1nb6DStilHYMeFustMKZUZVUaFN7tKl8ZPNtoltjYh0L
	8f0Uh4+l+aWq9I99gHp90vL1ttY5vRkXefFRLgMc/1cZt80LuxmEqwpdIXSR/B4Fah2TANonHC7Gz
	hUe5JjapfZB0rp9km7Wap1Aubf+8eLCZXUbg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uUSQG-00000002mOy-3bc2; Wed, 25 Jun 2025 17:52:28 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uUSQG-0000000334e-2XSK; Wed, 25 Jun 2025 17:52:28 +0200
Message-ID: <3a59b239b337aaa981195e5395eacc16b60be959.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/3] tools/nolibc: add support for SuperH
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Rob Landley
	 <rob@landley.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Willy Tarreau	 <w@1wt.eu>, Shuah Khan
 <shuah@kernel.org>, linux-sh@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 25 Jun 2025 17:52:27 +0200
In-Reply-To: <ffeea73d-35e1-44b7-b90d-c1b45f85376b@t-8ch.de>
References: <20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net>
	 <16f63653-c5c9-4b32-8e0c-0a4910a9fdb9@landley.net>
	 <ffeea73d-35e1-44b7-b90d-c1b45f85376b@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Thomas,

On Wed, 2025-06-25 at 16:13 +0200, Thomas Wei=C3=9Fschuh wrote:
> > But neither of us really have a build environment set up to do much wit=
h it.
> > Is there a howto for this, or is just to run the kernel tests?
>=20
> v2 of the series [0] has some test instructions.
> These should also work with v1, except that "-f Makefile.nolibc" needs
> to be removed.
>=20
> $ cd tools/testings/selftests/nolibc/

There is a typo here. It should be "testing". But I guess since this text d=
oesn't
end up in the commits anyway, it's nothing to worry about. Unless it's part=
 of
the documentation.

> $ make -f Makefile.nolibc ARCH=3Dsh CROSS_COMPILE=3Dsh4-linux- nolibc-tes=
t
> $ file nolibc-test
> nolibc-test: ELF 32-bit LSB executable, Renesas SH, version 1 (SYSV), sta=
tically linked, not stripped
> $ ./nolibc-test
> Running test 'startup'
> 0 argc =3D 1                                                        [OK]
> ...
> Total number of errors: 0
> Exiting with status 0

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

