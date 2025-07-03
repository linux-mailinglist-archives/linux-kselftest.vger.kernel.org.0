Return-Path: <linux-kselftest+bounces-36432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECFFAF76A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8346B545EF7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BDB2E6D26;
	Thu,  3 Jul 2025 14:05:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB0C19CC02;
	Thu,  3 Jul 2025 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551521; cv=none; b=rHSgG2C26Foi2ujjcgjmynZD7QOTpLPu8tWXiTMJMeo7ozsjF9q1xMdiOfrkqHPd8QxUHMwJXwguuRrUV8rFRsOGeSOegf4jd3FR82PjydjAglrTq3YHntQb+uj3np4nhakPv0hB7q2revxwOVIsX8vTSx/pB0oOAdqxjEpiNvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551521; c=relaxed/simple;
	bh=U4ubF4srjWWEZmfciFKdSrN8FMIJ8HJdc+JOZAcLcv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfCTSlsp4xEWOtjCo0kRFqZOyTtSfPKpZnPCjw+W+1WZdsbW9n/GRgz9wDicrfNcs12BmhYId9uJ00DGh/eC+ZC6BRTF8lSh7+h977+5vgfsDL4hE2B5C/gXrAaVy+oX4soPoRYAsK9OpYJdRCTsQ/Oe91bhv01EFcrdhgnnAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.53.4)
	(envelope-from <n.schier@avm.de>)
	id 68668cdb-bb09-7f0000032729-7f00000184c0-1
	for <multiple-recipients>; Thu, 03 Jul 2025 15:59:55 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu,  3 Jul 2025 15:59:55 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id F25BE808E1;
	Thu,  3 Jul 2025 15:59:54 +0200 (CEST)
Received: from l-nschier-aarch64.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:6472::1])
	by buildd.core.avm.de (Postfix) with ESMTPS id C8614189F02;
	Thu,  3 Jul 2025 15:59:54 +0200 (CEST)
Date: Thu, 3 Jul 2025 15:59:52 +0200
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
Subject: Re: [PATCH v4 01/15] kbuild: userprogs: avoid duplication of flags
 inherited from kernel
Message-ID: <20250703-fanatic-funky-jerboa-d8d82c@l-nschier-aarch64>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-1-48760534fef5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t5abbrXTdUbzxWZq"
Content-Disposition: inline
In-Reply-To: <20250626-kunit-kselftests-v4-1-48760534fef5@linutronix.de>
Organization: AVM GmbH
X-purgate-ID: 149429::1751551195-9E521740-0589DA78/0/0
X-purgate-type: clean
X-purgate-size: 1552
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean


--t5abbrXTdUbzxWZq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 08:10:09AM +0200, Thomas Wei=C3=9Fschuh wrote:
> The duplication makes maintenance harder. Changes need to be done in two
> places and the lines will grow overly long.
>=20
> Use an intermediary variable instead.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Nicolas Schier <n.schier@avm.de>

--t5abbrXTdUbzxWZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmhmjNAACgkQiMa8nIia
bbgZmw//bcwO/HfGc1WRkxirOFpym6UM5OMeFwy2HNnMeuYwMLndwLpxQj2aBTXw
1WRml22MebaAASoxoZ6riV3r4Kag9NkMPvulsmQJzB03Kchn/xb8Y10jihgIcNDV
LH9lmTS8bf70MArpID3Gv/aZIP987WoY5hqRU5SKzDG1YDHM3maYHahVlkqwWEg0
0HN686vS/WFmju0DgtN8tE/lDFM7ZpSNT7OsdN9j209Z7vQOhEl5SND5YJB0pNJO
X5uULV2EKBiWp1HYnwrxkL+nj8K0Tn57J7Wj5uTB+W+aoWhTEjZh8NszYkyxZ0aR
hwboouhODGk9gvaYPzMXaUpigYgB9m72zz+HqabFWPjHMO1xFFUapoLfR02eOzjv
6qeL8XI9ZA25RAYbkbv9NzbyJdlViDcAZuj0oszDolRsr51udM6Tf2qPlWYzm876
usYVeOTcQI8y6lvR8q5u7BVV0XXZb9iRdSB9pkWo8VqRcL5x50Dtkx1b9FghzlKv
JL0wm1h9yVUKhNROLaVpy7F1MO5+Nv7w/hlbIRCFGLbNO1FXqWiKlGiGYo6T31Z7
sqAUYKz9fNgLzauk5U5L1QhjJ6sen6TYmFLousvkSV5ITrxyuoJftuRSEfcpNTB+
0iQqp7a0kZ95r6+lexC72J3BRcl++lgfwKresIQ9tXDV5673MQE=
=4nvN
-----END PGP SIGNATURE-----

--t5abbrXTdUbzxWZq--

