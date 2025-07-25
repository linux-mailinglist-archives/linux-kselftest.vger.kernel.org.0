Return-Path: <linux-kselftest+bounces-37983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95047B11B78
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 12:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA677BC93D
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9752D9487;
	Fri, 25 Jul 2025 10:01:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1241E2D46DF;
	Fri, 25 Jul 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437688; cv=none; b=YQNkBtKO1ZyF0+d0CtcqdhwFq4XMCfi8C4kUer6YRauCCjbgc41Tva38++/RfjSDl8yDpuGMMEcYaIppINcYVzL2NfYPPKgGikUCHyi9DJLsJCQBk5vxU4RUjJ7iwbdL0F3cLwVdBOuOJg50UnRQ63HW4PAcXFHMqX0Pmxcl0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437688; c=relaxed/simple;
	bh=lKLrzCdnI8SoLPBCXEq2qmm2fjjI5TLH0MX9m08dmyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDLAgJz65/yAaD66pjRoPG5748aCcfBMWv+nm5Wrap4N2Gny3iRa95aEzPybKyCepIreLmgeulWqdB6WVEuYqqfgiQ3SPEpO0ckgxNHkShM6dkSnIfg1NfXj2I2VIgiW9rGnYBvPNWRboSfJmuKo5WvdG+Xx2aFhR+OriyC0z20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 3D9975F760;
	Fri, 25 Jul 2025 11:51:58 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
 Shannon Nelson <shannon.nelson@amd.com>,
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 sparclinux@vger.kernel.org,
 Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Subject:
 Re: [PATCH RFC 08/14] sparc64: vdso: Move syscall fallbacks into header
Date: Fri, 25 Jul 2025 11:51:51 +0200
Message-ID: <2376810.ElGaqSPkdT@devpool92.emlix.com>
Organization: emlix GmbH
In-Reply-To: <20250724-vdso-sparc64-generic-2-v1-8-e376a3bd24d1@linutronix.de>
References:
 <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
 <20250724-vdso-sparc64-generic-2-v1-8-e376a3bd24d1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4999642.GXAFRqVoOG";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4999642.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
Date: Fri, 25 Jul 2025 11:51:51 +0200
Message-ID: <2376810.ElGaqSPkdT@devpool92.emlix.com>
Organization: emlix GmbH
MIME-Version: 1.0

Thomas Wei=C3=9Fschuh wrote:
> The generic vDSO libraries expected the syscall fallbacks

"in" missing?

> asm/vdso/gettimeofday.h. To prepare the adoption of the generic library,
> move the existing functions there.

Regards,

Eike
=2D-=20
Rolf Eike Beer

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner
--nextPart4999642.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCaINTtwAKCRCr5FH7Xu2t
/MbPA/0dlCLsBzjM6FN8qagJQNydE/tBZ+VyT4fkbivBpk22EBBU/fUMv1cRMBS4
IHjJZcXzzYjF/INn4F3ER3KmLKU2R2VaSCvqusFVsc2x9aMWFOlyqOPz+usm9up7
zMndffsEMsHWu9SCiM85zbErgtoGHcu7R52wDWws9wH6W17qhg==
=gvab
-----END PGP SIGNATURE-----

--nextPart4999642.GXAFRqVoOG--




