Return-Path: <linux-kselftest+bounces-36433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109B9AF76AD
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25733A4E0E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EADC19CC02;
	Thu,  3 Jul 2025 14:06:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530F1F16B;
	Thu,  3 Jul 2025 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551577; cv=none; b=GZQqVYbHqAsLMAELsp5Zt9eVhyg8ZSVHCi3ndY+ywJfIEnu1GdjTUztHGPIJy3HB3/5xK+9IXam/AstWSHeEJsp2/uSCBxRD78Hqw3OJSWNxkYcmbfNBz5+FEZh94JfH9h3qnh4NrBq8g5T9ejbn8MFQRxeLZcCQzX00CYONxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551577; c=relaxed/simple;
	bh=hPA9x8NNlWJiCpo6xor8EkbTDBwgj8jn3gsK3LqjBMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQMenKPZRWIFhLEfIzRcCaYZFLz78kZPeOw0xW0IK44Iglan7nPx0CtwwDYYLTdiilIZBILYelTtgMEocyOWhWNQffKIMtjDjx9hUfe0HsJNJsv9FsgM15dgj9cJnxTw90wLq2mNfDah7w8pucHuLLHaJldBDgMMJ05x3X3Waa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.53.4)
	(envelope-from <n.schier@avm.de>)
	id 68668cff-962e-7f0000032729-7f000001cb18-1
	for <multiple-recipients>; Thu, 03 Jul 2025 16:00:31 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu,  3 Jul 2025 16:00:31 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id D153F80427;
	Thu,  3 Jul 2025 16:00:31 +0200 (CEST)
Received: from l-nschier-aarch64.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:6472::1])
	by buildd.core.avm.de (Postfix) with ESMTPS id 87C86180C1B;
	Thu,  3 Jul 2025 16:00:31 +0200 (CEST)
Date: Thu, 3 Jul 2025 16:00:30 +0200
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
Subject: Re: [PATCH v4 03/15] kbuild: doc: add label for userprogs section
Message-ID: <20250703-quaint-chicken-of-renovation-c2e7f8@l-nschier-aarch64>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-3-48760534fef5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wwZeCQBlz6JQcjce"
Content-Disposition: inline
In-Reply-To: <20250626-kunit-kselftests-v4-3-48760534fef5@linutronix.de>
Organization: AVM GmbH
X-purgate-ID: 149429::1751551231-414D1861-4156EE6E/0/0
X-purgate-type: clean
X-purgate-size: 1535
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean


--wwZeCQBlz6JQcjce
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 08:10:11AM +0200, Thomas Wei=C3=9Fschuh wrote:
> Some upcoming new documentation should link directly to the userprogs sec=
tion.
>=20
> Add a label to the section so it can be referenced.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  Documentation/kbuild/makefiles.rst | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Nicolas Schier <n.schier@avm.de>

--wwZeCQBlz6JQcjce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmhmjPgACgkQiMa8nIia
bbhpVA//U1WeoDRSXQN4iAYbGGa55EJ8bBM8ZrevgIw8WuXLcp4TquzjVxfGvA6F
MymiyKV06wcVZHBvXHS9j32gt7m5pn1yQUDyL73UB7TpgX+5TkSPCZW9i1CM43iX
d3fv4NfwI5Xry2Xyg5FF98Mp37KoY3pT8yGQ20HvEbRI2Jvm0Ud5ouIUprP+aJnS
vR4acVvNEDCtgDX6GxmDIrUlzde+4VYQCKyNdMUuKPrNBS0EOoLNdd0Cv0OX9luT
gNVd8nufntvy2Wk0YJ6gN2+qmm5Fx0h5ahGK747fpdfWSzXeakk4wMXvN5b8bNIk
NsuvcBY9Fmw1fu3zWDAEiReD5aegmvJsE+u8K1avHTQU6eVoub0rcKgicuwA/uhk
Ia/yuoykObQq/zupYA9aaLFfCEU1ASUfUc1zj9KTcKecWvNQa8tKCyhwnEa8FLys
7wdpvGyk9R9NosG1G167Bfr9H/fjiz3Kf/CD+P/2QvkwL7gSpOC8WiFTbaHw584q
0D1SqF3P40n5yBq6PyChf6/nI4/tWWy/PitHRRQh0u9GuC1Wyyvq6Sh0c89Zmn17
mfDJqGznLKtuTY9un73KLOkXmYWMX4JBJ4Qn5wsUIkybkGRqPbd0AKgtZYBdW0F/
sWqi/eJGqsUYwiobXkfupbGepfQ7xQvGqHneJ0ZWsFvFLaHYvdY=
=JyXf
-----END PGP SIGNATURE-----

--wwZeCQBlz6JQcjce--

