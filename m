Return-Path: <linux-kselftest+bounces-36430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3E6AF768D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8AE57BAF4F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222BF2DE6F3;
	Thu,  3 Jul 2025 14:00:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1182DE6E2;
	Thu,  3 Jul 2025 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551257; cv=none; b=ZuhIKbb5X32lgAy/k3UnGU396Yl0qq2kNnGkJ7z8m4lYa0VjRgIq/7pMDNGpJHfA1AY9XF7M1Wd+Iovw2fZlcKR0vKDN/EDCoCChrl//jErBvXDcuXdgtJKbgZihUIpFHQedpM8991qj4bNk3LjYhYfaYXJPglKefPC7Cdt3FZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551257; c=relaxed/simple;
	bh=dGMStcDb+HCi7LyiWWt3T2QINJfkHQaMOZXNO7r2wgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWRbeIgzLQ06OxqdfGJDjr1GXqvxSZpu7O74AP3JuPFdNDel8QZ5kztrrmW0zenkdLNK3aBpkNusZsGCO1ZJd62LHYN3s4Xd+q+qJuYF/EgXWqVoPAytpTL7EM5HP9sFjNb6Sx0gShWJ4QqVbT+NbYK5CZorqZA+O9wDBu4coz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.53.4)
	(envelope-from <n.schier@avm.de>)
	id 68668d15-962e-7f0000032729-7f000001b8f8-1
	for <multiple-recipients>; Thu, 03 Jul 2025 16:00:53 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu,  3 Jul 2025 16:00:53 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 575BD8075F;
	Thu,  3 Jul 2025 16:00:53 +0200 (CEST)
Received: from l-nschier-aarch64.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:6472::1])
	by buildd.core.avm.de (Postfix) with ESMTPS id A4865180C1B;
	Thu,  3 Jul 2025 16:00:52 +0200 (CEST)
Date: Thu, 3 Jul 2025 16:00:51 +0200
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
Subject: Re: [PATCH v4 04/15] init: re-add CONFIG_CC_CAN_LINK_STATIC
Message-ID: <20250703-ruddy-lilac-badger-7be969@l-nschier-aarch64>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-4-48760534fef5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vh/uHQVe278tGFn8"
Content-Disposition: inline
In-Reply-To: <20250626-kunit-kselftests-v4-4-48760534fef5@linutronix.de>
Organization: AVM GmbH
X-purgate-ID: 149429::1751551253-3E4DB861-1A94A2AE/0/0
X-purgate-type: clean
X-purgate-size: 1525
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean


--Vh/uHQVe278tGFn8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 08:10:12AM +0200, Thomas Wei=C3=9Fschuh wrote:
> For the kunit UAPI functionality this feature is needed.
>=20
> This reverts commit d1b99cdf22e0 ("init: remove unused CONFIG_CC_CAN_LINK=
_STATIC")
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  init/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Nicolas Schier <n.schier@avm.de>

--Vh/uHQVe278tGFn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmhmjQ8ACgkQiMa8nIia
bbjCwA/9Fjczgz1yiV0YXQdQ/8mxZXWjo8Ld2ye1cnpXwpZ/WjS4SYyh2HbOeBFd
TEb1PT/g5FmZVFkV4iarBC1FRYsYqPTsXTj8d7eJbgfKDGI0H4T7r/JmjiJ8/BlP
bPFqOOAyyG3PrJjdR8kiN2OSQfSl4KGHtELJAlAP1DWb6+1PWwMfI0LjSRAKsyK7
7y3m1x7j2k2is3E9Shv5STJXFZYERp2MMRIl7Wo7W9nlA0+z208SVBAjKVy2kNcG
CipzYXDcWfrJzbJNkTAYOZ2X4dTjG4iM02XeRxvFhGVmcf5gnLkJXZF0NqJwo2Vz
Kl3MXszl4AF2c1+TtGn3DeC5BsB041wLtY/mmMG6BxrCOqt6qdw3y5ZHq5G5k2Oa
StvFmEzmBYXXTAg+aZ1bV6bGbYIn+QeYzhd7a4InQ3v/is3EzfVKnU3m2i+wjjfp
hUmCy5nqSbGlaX+etTlz52dq073n2XVrAVf9zzK4OB7KpWjMbcpdB1FGH4OZnSCK
BgS+rChXp3Mxle2Fy/GPGJgBmlchW0E0wi0UicO2YzXOrn6aR5McpaxWuf4Z8t8x
AdRduLguyz76w0kydi0GZlAEyVgaz2aiL5BLFMLA9XtTc7Y30q0hQGJQE4l/RBeG
Nd9rVGXMsvmu9zM5DaGEMFnHbCcevFZa8OunCssq76sF4hWBWHA=
=+ai2
-----END PGP SIGNATURE-----

--Vh/uHQVe278tGFn8--

