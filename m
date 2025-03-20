Return-Path: <linux-kselftest+bounces-29501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB029A6A70D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 14:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434D416EBC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B912B1E5B6A;
	Thu, 20 Mar 2025 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKwwNmxW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE02AE99;
	Thu, 20 Mar 2025 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477027; cv=none; b=ixrWt7z/+uHUFx7kO+v9nckr+Ccicfy/TfPhf4uGSPFyPF1R3GWuZ6k2oNlQe3Cxd7MzAt/Ln3R4dJiwsuh5+GtMSKNezyaFo6IHFS98hvmSfr71BDLKEx89qk2ln1dv/8sAwbvGXQ7NRqmDg6e+0oSws0aaAcQ9aNt+bLMclAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477027; c=relaxed/simple;
	bh=aTZFahf4PN4IZgjNl5guV/m19DIoILMH8u1Mo+hMKeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaG1ccdT4mGY1DS5K7W1u8819gXfx3YnbuobDIpg7gcfGxlMyYY8/jwtPraxTXP0GcRKV7I6+xqEcpdPVB+NQDHHlUPSb8nCnXw1GFNGWnRQjv7gKTgpTTaRiApa3H/o2bS7y+e5bEgsRTVzvlE5PPWVBG+chv+ja6eXpj/JB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKwwNmxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3F2C4CEDD;
	Thu, 20 Mar 2025 13:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742477027;
	bh=aTZFahf4PN4IZgjNl5guV/m19DIoILMH8u1Mo+hMKeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKwwNmxWvLJjuAg4oaKRxOPkDLQbBYVaEPcMjVyBu1gpELsqg66Es8Zq9tLPX/RJO
	 lk3yUlfqoWbFiR4l76r3wmGlqlHJiiBhJ+2UicYdr/Su9nms292nBho5352zjud0lJ
	 S3+R3KReLCqVTXaGNkiruFZ54svriBt2ee2aYYGrGld1cQGERQiQcwd36YKQexICvq
	 y+nHYOONhqf1x/4SgLEuJckXMFfFMfLvNvmVrqyrI4oFTKzdK+5LCBQ1AxuNjAp07C
	 Vg4xcS3E2dg9Ce1TadlC8+irftj1Bai8cMI4JzBcuUljT/lCkYp5z7p6tbQJYw/xzu
	 n3FBNP7aHpUxg==
Date: Thu, 20 Mar 2025 13:23:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 12/16] selftests: vDSO: parse_vdso: Use UAPI headers
 instead of libc headers
Message-ID: <af553c62-ca2f-4956-932c-dd6e3a126f58@sirena.org.uk>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
 <20250226-parse_vdso-nolibc-v2-12-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+yJ/axRur/qwWIeV"
Content-Disposition: inline
In-Reply-To: <20250226-parse_vdso-nolibc-v2-12-28e14e031ed8@linutronix.de>
X-Cookie: The early worm gets the bird.


--+yJ/axRur/qwWIeV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 12:44:51PM +0100, Thomas Wei=DFschuh wrote:
> To allow the usage of parse_vdso.c together with a limited libc like
> nolibc, use the kernels own elf.h and auxvec.h headers.

The vDSO selftests currently fail build for at least arm64 in -next:

  CC       vdso_test_gettimeofday
  CC       vdso_test_getcpu
  CC       vdso_test_abi
  CC       vdso_test_clock_getres
  CC       vdso_test_correctness
  CC       vdso_test_getrandom
  CC       vdso_test_chacha
/build/stage/linux/tools/include/uapi/linux/types.h: Assembler messages:
/build/stage/linux/tools/include/uapi/linux/types.h:9: Error: unknown mnemo=
nic `typedef' -- `typedef __u16 __le16'
/build/stage/linux/tools/include/uapi/linux/types.h:10: Error: unknown mnem=
onic `typedef' -- `typedef __u16 __be16'
/build/stage/linux/tools/include/uapi/linux/types.h:11: Error: unknown mnem=
onic `typedef' -- `typedef __u32 __le32'
/build/stage/linux/tools/include/uapi/linux/types.h:12: Error: unknown mnem=
onic `typedef' -- `typedef __u32 __be32'
/build/stage/linux/tools/include/uapi/linux/types.h:13: Error: unknown mnem=
onic `typedef' -- `typedef __u64 __le64'
/build/stage/linux/tools/include/uapi/linux/types.h:14: Error: unknown mnem=
onic `typedef' -- `typedef __u64 __be64'
/build/stage/linux/tools/include/uapi/linux/types.h:16: Error: unknown mnem=
onic `typedef' -- `typedef __u16 __sum16'
/build/stage/linux/tools/include/uapi/linux/types.h:17: Error: unknown mnem=
onic `typedef' -- `typedef __u32 __wsum'

a bisect points at this patch, it looks like that's due to the switch to
use TOOLS_INCLUDES but I didn't dig into the specifics.

--+yJ/axRur/qwWIeV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfcFtsACgkQJNaLcl1U
h9Afqwf/fQij3ulCqOiAa58owMpIiLlmmbjZFPAWbm2lGrM+xEnImfAvF+SelxzW
qsP9D70h2z9kaNsAF/0ZNhv2fm6JW3XWOt5oThqVMUubCMaQzdTgFZGFtQtXK5UV
+ZCViCiUZDKz2F9n8xuq5nmfhIq4gFoatIYHh4L+6A7rnkmleBBcGjM7P9cASwKu
uaF04HoB2x81IGpGkgmJp2codI1JDC3iBSkXJ+OkiDqAiXUU1Y20w5eW5rvdJu2T
amytpkiGii+PqfrEMtX5Z9S3vstO5bob4SUVYvJ9LmuJPlQjXo5JIExCyuHrHfqE
TJGL/l0Y/J7oAVVt6Dku09TTTTs85A==
=tFYT
-----END PGP SIGNATURE-----

--+yJ/axRur/qwWIeV--

