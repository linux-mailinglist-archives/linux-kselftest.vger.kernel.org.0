Return-Path: <linux-kselftest+bounces-34460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F932AD1B12
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 11:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969B23AEB0E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 09:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB6A24DD15;
	Mon,  9 Jun 2025 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="fxhSPA8t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2A1F03FB;
	Mon,  9 Jun 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749462819; cv=none; b=p45yr9NGhQSSJeflq+x/K1MvQq5UPs4Da9gWpBNiYMDE4izYZkMA36dN8HhsLXdWeytnPYoA6cSdsPp4zAKS/YY0SRdOiGTOJggdQNLrOd43Pn/iabUyiYq7L2dk8qddfiV3EOWbUTPzlnOvVjA2Dih5jZi3f/KCO2a8hqlWiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749462819; c=relaxed/simple;
	bh=AWzWNSUFgRaySVq7Pm1vA4G7nz/RO3QGro1rjeIzf2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z1MUs1liBI9K4tPAkkcoH2CR2zkUwRF3xMRedVZth89UvKu8u5TMg/fwOxOdqJ7exRYB7yP3NYWnpeN1E4tw19FGj+csmn3hxChwub0va22E58lbpauFuoNanjJNIAOZm0lK0kVcjkkkei7DFDzWzM6K/6s0Taxh1yKQdDqMHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=fxhSPA8t; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M/A30/CRAS/dzq7un5vICURXhBPHhgBx4UVc1K27aP0=; t=1749462815; x=1750067615; 
	b=fxhSPA8tNpaLzKsdkEvduoUici/c5ldz1RFJlt0rAaUw2YwyVBQyAKbHvPWI4Yn2xZcJzGhx8j+
	xniWGLKSmoqVxtpTIRYe4JrCUxpkCTc4e/xf1mKQQPmQc4648u71CYdhg2Gy6vB/9wvxK8blCUKMr
	e4GVOnAIAmZt9T6QFUmbVPb/s0KidMZVXZU3gBOdR7H2OVCrGu3pNFLi6DjRI7oT04/9QTxKnHfyz
	CcUVJaJFFOPefvu86mlSzfJzT01bm8+1/FvMHzYMu/lOAHN7tW5RTLaE+yqoDykGM4XOeyzvuYtJO
	IT3WtLXral7W76f8JxfzV6Dukp/BHveoVPsg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uOZC2-00000000pE4-13Xz; Mon, 09 Jun 2025 11:53:26 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uOZC2-000000018oh-04yS; Mon, 09 Jun 2025 11:53:26 +0200
Message-ID: <0bd3da32be2d82f8ee6f6a544d9d8f8b48b02cd0.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/3] tools/nolibc: add support for SuperH
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Willy
 Tarreau <w@1wt.eu>,  Shuah Khan <shuah@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 09 Jun 2025 11:53:25 +0200
In-Reply-To: <20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net>
References: <20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net>
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

On Mon, 2025-06-09 at 11:28 +0200, Thomas Wei=C3=9Fschuh wrote:
> Add support for SuperH/"sh" to nolibc.
> Only sh4 is tested for now.
>=20
> This is only tested on QEMU so far.
> Additional testing would be very welcome.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Thomas Wei=C3=9Fschuh (3):
>       selftests/nolibc: fix EXTRACONFIG variables ordering
>       selftests/nolibc: use file driver for QEMU serial
>       tools/nolibc: add support for SuperH
>=20
>  tools/include/nolibc/arch-sh.h              | 162 ++++++++++++++++++++++=
++++++
>  tools/include/nolibc/arch.h                 |   2 +
>  tools/testing/selftests/nolibc/Makefile     |  15 ++-
>  tools/testing/selftests/nolibc/run-tests.sh |   3 +-
>  4 files changed, 177 insertions(+), 5 deletions(-)
> ---
> base-commit: 6275a61db2f0586b8a5d651dfc7b4aacf9d0b2d6
> change-id: 20250528-nolibc-sh-8b4e3bb8efcb

I have no experience with the selftest code but I can definitely test
on real hardware if you can point me to some instructions on how to
run the tests.

CC Geert.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

