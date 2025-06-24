Return-Path: <linux-kselftest+bounces-35666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FDCAE5C61
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 08:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC857A42EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 06:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED32C23C8A0;
	Tue, 24 Jun 2025 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="gRorom1p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870923B607;
	Tue, 24 Jun 2025 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750745037; cv=none; b=pHCbu89l6qjlttXa782essfSLU8sNxPy3G/OzYXxFXQMcZqfV19UzhZGBs1jEzAzuIc8hxiawMziNM9Yh/iA+0D7IyHpbPBpdFFi6aMc+b4HizfUqhhlMKXzp0xLX+g4MPPQ+ff4QL2aY0wKLapQuaBdpLA8l8NCQXONvc6MhPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750745037; c=relaxed/simple;
	bh=Bey+sqy0I43ZBhxRAWMwGXtbSpKTSBtohICp/kXLMyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MenGjsEMHLmlJyL1dX8XZnzIBjGspQyvhzEpVnGMDDdUo52/X0l0TF3PoPk3XtgbnSA7iqUvy1v1QhmbTFaqj1eSgQJRl9aHs6J+3u1aaqfYMSMZ8IWrlaIEHSJB+NmsqhCG2WzujdMAUedGV5P+COxBeRbukIASwKIu+TfYlqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=gRorom1p; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MuyQ8ylvKOjJl+gcabXU70lvu56R8IxOFRGDpzFP41o=; t=1750745034; x=1751349834; 
	b=gRorom1puPLtQQhd/DeO3TNX8gyM69GeWXfrfiTN0UDAwVPfzn4vmqoeSFp6i83QS+5tMghOzdb
	khHxVudBAwAw8afTXRX2T/BpxSU78TIbAUi00MTH3HxmITIApaCJ5nJ/n5iXKlb5ucVKjsqt7o5Ur
	gpZdFXl+GOp7M7Qcze3bM3zCCasUg8NfmDdG86Eky5OyUJRYfIdrLi2wJxeS52cjg2Ufu34jnXur1
	4rG6gwJnqwdqpfrKCXLpCznhugobwhHXSKBTN2OjpqhDnBvOlRQrMJAfcdU+jwdPDgBc2088ldbS+
	CN8STvVBBq9jBhdJwGN+Mot4XzHUBYFQbMKQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uTwl2-00000003LuL-1kLN; Tue, 24 Jun 2025 08:03:48 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uTwl2-000000001i6-0nrW; Tue, 24 Jun 2025 08:03:48 +0200
Message-ID: <6d83088ebfeee7f7d3190872234f7b53ee758c65.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 0/3] tools/nolibc: add support for SuperH
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Willy
 Tarreau <w@1wt.eu>,  Shuah Khan <shuah@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 24 Jun 2025 08:03:47 +0200
In-Reply-To: <20250623-nolibc-sh-v2-0-0f5b4b303025@weissschuh.net>
References: <20250623-nolibc-sh-v2-0-0f5b4b303025@weissschuh.net>
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

On Mon, 2025-06-23 at 23:15 +0200, Thomas Wei=C3=9Fschuh wrote:
> Add support for SuperH/"sh" to nolibc.
> Only sh4 is tested for now.
>=20
> This is only tested on QEMU so far.
> Additional testing would be very welcome.
> Test instructions:
> $ cd tools/testings/selftests/nolibc/
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

Apologies, I haven't been able to test this yet as my board currently
doesn't want to boot kernels newer than v6.5.0 and I have not been able
to bisect the problem yet.

Can I test this on v6.5.0 as well?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

