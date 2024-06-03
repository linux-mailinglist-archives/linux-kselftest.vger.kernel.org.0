Return-Path: <linux-kselftest+bounces-11111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B200D8D83FF
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 15:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E8F1F23CC3
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 13:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E7812D762;
	Mon,  3 Jun 2024 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgV79tYr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C412D1FA;
	Mon,  3 Jun 2024 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421524; cv=none; b=nnpDxLQLZH11+IxZgYtSKHU1V3GJRKxuGVBSapl8rG49Qj5O6YSNRuYiShboLGH6ab7NEU+fv1IjLBAxoyeHPnRNjQN/7wWWYzYlew9EtfbN+8wPkfAcDkmQSoxtkEf5pMWEDRnunSHFF6MomY3/FkwMHgDtC6l8M4q/V1Odkbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421524; c=relaxed/simple;
	bh=CfNFaBdw1xG9IssterEE6MbYhcLFzsxVaBM/TXav0lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJBxovQKb0IZPch9UGRQmJc+llhRW6ZJbVjzH4XMqJiNp9FNtc/QI9cZGg2DienjJrl5TLD2rFiCMRLBg+NW6yHHCpVeVTHL6g3hWY3/L54O5wWleMRBHwZZVuXcZvGN9ZRkcnhc8rhS6zEPRfydRUQkWAB4GeVJVtxvHwzjhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgV79tYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096B7C4AF08;
	Mon,  3 Jun 2024 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717421523;
	bh=CfNFaBdw1xG9IssterEE6MbYhcLFzsxVaBM/TXav0lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgV79tYrLH2VJm0N9fppEAqrahRKszmoTNV20ZAuJCegUzvjjEa2Y1xCYnRC586MK
	 u0J5rn7ekJt7hHrR0SP27q7Wr0qKQ74KW9+zdG6w70qrQHUuc3KFEVLEbQUuRdUmiu
	 ivL3VYIPytSu1htnCyBY9cyYQncuW7GqZ/c5WwkhBVmYi/Y6YN6Pv/zX0wjerjQQlo
	 iJ441XqzfB9PdXn9E0PcrDwzJQOw3FO33nmuN8FhmSjsWsw3CY0nlsy+gt9F/+gNuI
	 cV35Nra/hzqnACnBG7MDuywSjkvwh8sDPRNymaNDZhuGVTIEkuvjic/sxxtsVUqyMs
	 YjhwzYJBsWmTQ==
Date: Mon, 3 Jun 2024 14:31:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug Report] selftests: arm64: build errors
Message-ID: <7b7f4dd1-bc13-4827-84d6-20ebed7119b6@sirena.org.uk>
References: <5ec0f2f3-5259-41a9-a25d-5baf1680dd10@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JaJbRFCY2mj2cYSO"
Content-Disposition: inline
In-Reply-To: <5ec0f2f3-5259-41a9-a25d-5baf1680dd10@collabora.com>
X-Cookie: Don't let your status become too quo!


--JaJbRFCY2mj2cYSO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 06:28:16PM +0500, Muhammad Usama Anjum wrote:

> gcc pac.c /pauth/pac_corruptor.o /pauth/helper.o -o /pauth/pac -Wall -O2 =
-g
> -I/linux_mainline/tools/testing/selftests/  -I/linux_mainline/tools/inclu=
de
> -mbranch-protection=3Dpac-ret  -march=3Darmv8.2-a
> In file included from pac.c:13:
> ../../kselftest_harness.h: In function =E2=80=98clone3_vfork=E2=80=99:
> ../../kselftest_harness.h:88:9: error: variable =E2=80=98args=E2=80=99 ha=
s initializer but
> incomplete type
>    88 |  struct clone_args args =3D {

This is in the generic code.

>   CC       check_prctl
> check_prctl.c: In function =E2=80=98set_tagged_addr_ctrl=E2=80=99:
> check_prctl.c:19:14: error: =E2=80=98PR_SET_TAGGED_ADDR_CTRL=E2=80=99 und=
eclared (first use
> in this function)
>    19 |  ret =3D prctl(PR_SET_TAGGED_ADDR_CTRL, val, 0, 0, 0);
>=20
> gcc -mbranch-protection=3Dstandard -DBTI=3D1 -ffreestanding -Wall -Wextra=
 -Wall
> -O2 -g -I/linux_mainline/tools/testing/selftests/
> -I/linux_mainline/tools/include  -c -o /bti/test-bti.o test.c
> test.c: In function =E2=80=98handler=E2=80=99:
> test.c:85:50: error: =E2=80=98PSR_BTYPE_MASK=E2=80=99 undeclared (first u=
se in this
> function); did you mean =E2=80=98PSR_MODE_MASK=E2=80=99?
>    85 |  write(1, &"00011011"[((uc->uc_mcontext.pstate & PSR_BTYPE_MASK)

> I've GCC 8 installed. I'm not expecting the errors because of a little
> older compiler. Any more ideas about the failures?

You need to run headers_install IIRC.

--JaJbRFCY2mj2cYSO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZdxc4ACgkQJNaLcl1U
h9CX0Qf/Zvgw13gwuY/rn/A9JCGMEvZQENQvG2gs7AyeyVI1tJgGrnfQKXnC9Vte
L9E8XcfKTAVUag5e/xS4t5rDzfhZGvL7G8ytI64qnhhDZziOfC8HOYuQIaYruhv+
5ISO5+OxLWRH7LXtO82kif/ObWplhQrIf4Uq0f7TYPuDY33Jpmk/RuHdngTuDrpO
7QrR8DpZdQMna0f+AQghbXj4ngq89mqBdocktgBFDMf+2qRhnZHU2eJzkKUq88hS
+AnlPu18DHYYJsoiqE2ucE3r20r5FtXq0n6YIYcN4HkUMzc9Lo/aIibymG5k97Q1
Nx/7csNI46dhALHilBw1nU2FRJwDLw==
=pVuw
-----END PGP SIGNATURE-----

--JaJbRFCY2mj2cYSO--

