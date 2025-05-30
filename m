Return-Path: <linux-kselftest+bounces-34048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24712AC8C3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 12:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 145937A83C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 10:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7D9222570;
	Fri, 30 May 2025 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBOVtftm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E21EA7C8;
	Fri, 30 May 2025 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601553; cv=none; b=IwTCYAmsRtjnmHSKBYpb2IcHcnVVtdUPzsiBXUREDrcALawuigXnfp996kCoaRdQaVwgJwJVVlC0YNAEYnffG6agaiDNee6uwTXnusngHmgryhqZACUqJo5gBU0VYvtrgQNkQ3c5/VsNSr/FfJt2FcTYAPKB1CGLEc5ytOKXVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601553; c=relaxed/simple;
	bh=Cc2l0TKz5YaK8S3redSaC1apH9Fo0cyDOkhqfVmqyV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4n1lM1U59PHCwVx8g1XIFdIzh5pcTcFxQQ4dPS22y9WTdCqZMXcBxb52XsJpac0fzi/pc4ZuhSFqFrbD74JT0k0FqfQu600RdOQ3AGZQ8v6OZWHVWjwbZPsS2iop5LmcVr16tvphekjcQ29ZLX5vkR1ZRHZ3PEt18Cn4NYZMDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBOVtftm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23472C4CEE9;
	Fri, 30 May 2025 10:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748601552;
	bh=Cc2l0TKz5YaK8S3redSaC1apH9Fo0cyDOkhqfVmqyV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBOVtftmYoDSz8Bt5BjQ/uzq726rmBsv5MS2Nm1e5hA45gB8lpcf1jec5FbGK1KoE
	 b33TNaiQ5KuKgHbj2Wj+1lWNNr5AzT7M8Iv8SM6TuNl0kfxIHKiNcsgcnNg/avAPPq
	 ClSX2StLLgVvq9R4VOc5JSceZquAd4Y+ek3+FQ/Ikkl3dFAisnW+R1WP4b4ZbLD5Z3
	 3OQGXYnY/qfZ1XYdfM7oNbLigEu6iMcTvcHGVQJQkXaKEhnj73glkcscBAiqY54RRH
	 TaC3EYyGMuRwdsXzqjBhHQbQXFElCEp7KUMQ0705zEG735JsEuNcI+i+hwId0D0G15
	 0C2H5FgovOerw==
Date: Fri, 30 May 2025 11:39:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/filesystems: Fix build of anon_inode_test
Message-ID: <aDmKzSkIlOAkj_Bq@finisterre.sirena.org.uk>
References: <20250518-selftests-anon-inode-build-v1-1-71eff8183168@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DLuH41Ng1iRNSMtA"
Content-Disposition: inline
In-Reply-To: <20250518-selftests-anon-inode-build-v1-1-71eff8183168@kernel.org>
X-Cookie: Anger is momentary madness.


--DLuH41Ng1iRNSMtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 03:01:34PM +0100, Mark Brown wrote:
> The anon_inode_test test fails to build due to attempting to include
> a nonexisting overlayfs/wrapper.h:
>=20
> anon_inode_test.c:10:10: fatal error: overlayfs/wrappers.h: No such file =
or directory
>    10 | #include "overlayfs/wrappers.h"
>       |          ^~~~~~~~~~~~~~~~~~~~~~

This build failure, first reported against -next and which should be
fixed by this patch, is now present in mainline.

> This is due to 0bd92b9fe538 ("selftests/filesystems: move wrapper.h out
> of overlayfs subdir") which was added in the vfs-6.16.selftests branch
> which was based on -rc5 and does not contain the newly added test so
> once things were merged into vfs.all in the build started failing - both
> parent commits are fine.
>=20
> Fixes: feaa00dbff45a ("Merge branch 'vfs-6.16.selftests' into vfs.all")

I see that the two branches get sent separately to Linus so the merge
that triggers things is now:

   3e406741b19890 ("Merge tag 'vfs-6.16-rc1.selftests' of git://git.kernel.=
org/pub/scm/linux/kernel/git/vfs/vfs")

I'll resend with that updated.

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/filesystems/anon_inode_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tool=
s/testing/selftests/filesystems/anon_inode_test.c
> index e8e0ef1460d2..73e0a4d4fb2f 100644
> --- a/tools/testing/selftests/filesystems/anon_inode_test.c
> +++ b/tools/testing/selftests/filesystems/anon_inode_test.c
> @@ -7,7 +7,7 @@
>  #include <sys/stat.h>
> =20
>  #include "../kselftest_harness.h"
> -#include "overlayfs/wrappers.h"
> +#include "wrappers.h"
> =20
>  TEST(anon_inode_no_chown)
>  {
>=20
> ---
> base-commit: feaa00dbff45ad9a0dcd04a92f88c745bf880f55
> change-id: 20250516-selftests-anon-inode-build-007e206e8422
>=20
> Best regards,
> --=20
> Mark Brown <broonie@kernel.org>
>=20

--DLuH41Ng1iRNSMtA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg5iswACgkQJNaLcl1U
h9A0ngf/a9bipV7ZRWFfwG/WshIDaw6GGK5V72tmc3qGRudNpzCiAiJ/qrXXJ3k3
4CDmCgSmRRvNlIiX2JC+tk/0tZVFhLhri+RdUwOo1xx8KSHgJiW82JhZC4pdNk1O
1n9Fqhk40psqQnMBJX5P5eBgYA9JqyavrXbTDGbQ+N4E/Kg6r99f9ktvFamL06Gt
biRdnGJiB01Kime1zU3Q/PWz4YYRf291dwcoC+KxIKpG/NwWfUMQhHOfpPsOCSRx
Se0RNrB5TAScO1DEXjWFjx4fG7MPWf3XjIFu8r5Grv/nxwp2lDfZN1LZsARVl1i6
jDRAxTTwCxXrfBZw/PzO7SSBdvMovw==
=7Piu
-----END PGP SIGNATURE-----

--DLuH41Ng1iRNSMtA--

