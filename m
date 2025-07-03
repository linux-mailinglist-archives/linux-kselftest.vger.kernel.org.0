Return-Path: <linux-kselftest+bounces-36429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20B4AF7675
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7383B1C812B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3183D2E7F16;
	Thu,  3 Jul 2025 14:00:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B50B2E9753;
	Thu,  3 Jul 2025 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551218; cv=none; b=YpI0PSV4ddNZMer0U86wDL4NwJ1oepbckReyVK5XuJjY2vrE1LmPARE0lLmuOWqIC9oaA9yw685y4y9zldRoodgSnq+yIimRItHjRPqYkMd3lP6oCdTZHqh6DoNZhpI1dOoeeOhiuzRzGLeNtgQljFEuubmA1O+Vp3WuCtmpQaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551218; c=relaxed/simple;
	bh=Q1zAbtzoHfc8f3iagLIrwIgcpj6jSRFJdUvSbwxZwpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQi7Lmu6nNLSHnwa06D9s/6d9kb+o5YL1iw8Oot0cy5D1CWBBrWsHMO1ih+gELDRyzs/KAwdLCzW8CFkAvdK3NukzIShvvbJLpZjXNzwRLd64+z/EaCxRH4nvtqLC9wNJtobWQhSvhUebfU/NAVe+GhxJG+bBBRl9XYyEVCI7oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.53.4)
	(envelope-from <n.schier@avm.de>)
	id 68668ced-037b-7f0000032729-7f000001be6a-1
	for <multiple-recipients>; Thu, 03 Jul 2025 16:00:13 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu,  3 Jul 2025 16:00:13 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 66FD880759;
	Thu,  3 Jul 2025 16:00:13 +0200 (CEST)
Received: from l-nschier-aarch64.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:6472::1])
	by buildd.core.avm.de (Postfix) with ESMTPS id 1F287180C1B;
	Thu,  3 Jul 2025 16:00:13 +0200 (CEST)
Date: Thu, 3 Jul 2025 16:00:12 +0200
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
Subject: Re: [PATCH v4 02/15] kbuild: userprogs: also inherit byte order and
 ABI from kernel
Message-ID: <20250703-angelfish-of-premium-abracadabra-5bd2cb@l-nschier-aarch64>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-2-48760534fef5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7/fbDo5/u/ed+dJg"
Content-Disposition: inline
In-Reply-To: <20250626-kunit-kselftests-v4-2-48760534fef5@linutronix.de>
Organization: AVM GmbH
X-purgate-ID: 149429::1751551213-AF7F4EE7-FA58F633/0/0
X-purgate-type: clean
X-purgate-size: 1624
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean


--7/fbDo5/u/ed+dJg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 08:10:10AM +0200, Thomas Wei=C3=9Fschuh wrote:
> Make sure the byte order and ABI of the userprogs matches the one of the
> kernel, similar to how the bit size is handled.
> Otherwise the userprogs may not be executable.
> This happens for example on powerpc little endian, or riscv32.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Nicolas Schier <n.schier@avm.de>

--7/fbDo5/u/ed+dJg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmhmjOcACgkQiMa8nIia
bbhOtg//ZKD56fFFKhS3VkvSEf+ykGldJAeK+xcr5bLTKq5aSlD6FcdGYNtMEYxu
MJOteT2bcQD9qDCyphMCeUTa8rbPleW6KwkI738j8/BdXG2O9Qou4XiDnHOrSVPw
FpszvUuGIUCNYmoLuGHfUX9IDchTNAxG83YtSBGlyoY82XIIZsO05vA1HhTzXL3a
wjSYhcRUbx+NquhjZieIHQ2wgOrJXv7zPt5zfj1g5fpzr764ss1JNT+m+5NF6zkk
uhjo6ecThXKPixtRGua72FKYvLHRAuyakMae4FYj8RFr7GpJo+Mo7uBy8BEuyGSB
otP9gNlEOncTCNFuttljE4u0CGtnhqB0oovYM/Ws7/68+c2mlMuF3PlCm/ss9CFU
jl5rqiaGI3SCjoCU7dxJl6RlPBdpvCV3GnzbRru6DDb/1nUKQZq9t2WVsMDQ3BfO
OzkWY75PbMwtXWV4LYa5COyPnHIG17+6dS2sFQWo547ZioHM/bZ8SotLwggltxaS
IFrkEOPQoiAY/p3RGDA+0IlPFBXYlyXMjeyxpr1BcvxqHXe4tLSBoi+2mNR7h2Vp
B3i3Cbq6I3XFhn2lE4mbG0eD9GuOqIlEsrvtP4rkoWt/SKKPs0iOhQ8O51HsY+r4
exBcSsGAsJOyQjrKfoAXR8XZTRMEQFJ4EqYzw9o/bm2Qn03rxeM=
=lAU5
-----END PGP SIGNATURE-----

--7/fbDo5/u/ed+dJg--

