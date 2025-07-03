Return-Path: <linux-kselftest+bounces-36431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1CAAF7689
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09E8176913
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4CA2E7F03;
	Thu,  3 Jul 2025 14:01:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D081AF0B4;
	Thu,  3 Jul 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551275; cv=none; b=L0LWjlcZWo7E9s4KxYpupDWLlal/A0Pwi9WHPHqfnNWdnZKOJXeCO6QBkjizebMNGwRE6dQ2JnjosSjQSnf1o7qC1JFNoECijG52X7hVv6sSEqSZ+biDWuqhAHbRcYVCXGRfrNG9GrxGL0qYfxsyIDTxHt10lnoxMAAkqERQeNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551275; c=relaxed/simple;
	bh=8brsHwtSTaNLq6fMC0iUgwrP4mTJYfb9zKLAKdrhOnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/fLAtXti517oORE0fQKgy1CyXKhVEQaaWwYJ0LiILkovy3zgfB1i0IAhDqirTOMPr6m5m59ZhUQ/Fmro3bnMeWKeleXVL2VQrNoKmKm6o5nD1+L48w3rn+zpLZgwEkv63ldHnaQlDjNAnjpH6g5MZPMn1tmGfPSqOoBanBU7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.53.4)
	(envelope-from <n.schier@avm.de>)
	id 68668d27-962e-7f0000032729-7f000001b922-1
	for <multiple-recipients>; Thu, 03 Jul 2025 16:01:11 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu,  3 Jul 2025 16:01:11 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id C10D3806C8;
	Thu,  3 Jul 2025 16:01:11 +0200 (CEST)
Received: from l-nschier-aarch64.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:6472::1])
	by buildd.core.avm.de (Postfix) with ESMTPS id 6D933180C1B;
	Thu,  3 Jul 2025 16:01:11 +0200 (CEST)
Date: Thu, 3 Jul 2025 16:01:10 +0200
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [PATCH v4 05/15] init: add nolibc build support
Message-ID: <20250703-able-benevolent-gharial-ecbfd2@l-nschier-aarch64>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-5-48760534fef5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uRa5i4kMRLweURev"
Content-Disposition: inline
In-Reply-To: <20250626-kunit-kselftests-v4-5-48760534fef5@linutronix.de>
Organization: AVM GmbH
X-purgate-ID: 149429::1751551271-39CA0861-C9667BA0/0/0
X-purgate-type: clean
X-purgate-size: 1915
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean


--uRa5i4kMRLweURev
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 08:10:13AM +0200, Thomas Wei=C3=9Fschuh wrote:
> Building userspace applications through the kbuild "userprogs" framework
> requires a libc. Kernel toolchains often do not contain a libc.
> In this case it is useful to use the nolibc library from the kernel tree.
> Nolibc does not support all architectures and requires compiler flags.
>=20
> Add a kconfig option, so users can know where it is available and provide=
 a
> variable for common options.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  MAINTAINERS          |  2 ++
>  init/Kconfig         |  2 ++
>  init/Kconfig.nolibc  | 15 +++++++++++++++
>  init/Makefile.nolibc | 13 +++++++++++++
>  4 files changed, 32 insertions(+)

Reviewed-by: Nicolas Schier <n.schier@avm.de>

--uRa5i4kMRLweURev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmhmjSIACgkQiMa8nIia
bbgQvBAAhbd3BYyTpH1jAbERpaLT8y1+JRuWEpMgVrzf4Djuoe+7wlP8bRrB7LJ/
OqN5olbRO0+fdEueDlqKynurfMr5jgreGIKHuBw7PSsiEJNiG4VFIZ837ui96W8Y
pXZ6dtM7PveKEajuLyClQaSWlB3NudHYuYgTNt5iFdpUSdJEhvZ+OJ2dTsws7alz
59/O6jThF2OaL0xsIkyGZba5Ly+TBnIQ11oXZh+6fi1ITplaWz3syGinTLNScTG+
S8zaX53+qKaAf+taHUq99Xfy68LH3sXUFIu0IivsRFUmRYvYyc52Hxc/ZzAXlnSI
4vpj6Ha1utStwKqTyd7+3azqF1NmBtMsxF0CiKnO4ptWMW3qJBf3qTqmBPF6BmTX
d4QuKiLekGdFlxxu8o6O8TtCDyjxNnitZgfD4r8he1zoID4TcLGW6Wx8k9RRX+AS
eFc2Dxklb79R1RvKDduUV9Y2Np7BuAIKfc2xEjMHsvjXlN6DDda9Zbx7dV2clvSd
dVBbOG1arsyCHVprloS89n2oWdZsEow3ZIGUfNvhGGEYivdhD5qluB94X4zssOhA
j9BcEVnlpEaVxe7C7S5WjaJMTMhrpK69jW4mSn2PqilR5ulcwrDknrYSKlqAzU6j
O/snNwQjPpeyc44xgMra7eKUkCq4qALaPxCZSifhj9N28pJ6cdY=
=TLb6
-----END PGP SIGNATURE-----

--uRa5i4kMRLweURev--

