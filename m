Return-Path: <linux-kselftest+bounces-7490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF9689DBF4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 16:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03C21C20D3F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8F11304AA;
	Tue,  9 Apr 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPcB3SmW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C412FB03;
	Tue,  9 Apr 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672129; cv=none; b=diblR4aPClJjpElXYSH5k7IvPuHkmKtAuCjkrhUvbfVQXeCc99C+NMqyiFYp2ITwoY+vVLRqExPd6OUil6e5S/fMyLkt20sDkE7GvzzeBGxtBC5tLcv2phm6ELppe9kTCmL9AjLn5gM02Vq9mNMtsxebZocv7owv1ObjjBuKgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672129; c=relaxed/simple;
	bh=k430QK7uR0afWm5iLxyZ0H+bkw6eRZQHyWK7YRup3qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qW2f2H0uyw8pXYyct5ohUDVexYC2/r/F5jC2mOmVgZo1AzREV5z1QeCy7xmVhxwpG/LQDAGbXz2u30o0YwpX1fDe04EU0HjJgIoh4MV2m0kIMd809mhUU6w0b52TsOJqNpuksruH0BjtxXTiosjThi+5qbkV0tuCZVWnOHiSdX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPcB3SmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E60C433C7;
	Tue,  9 Apr 2024 14:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712672128;
	bh=k430QK7uR0afWm5iLxyZ0H+bkw6eRZQHyWK7YRup3qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPcB3SmWXdeEnUbHOsA/wrs2nSX3lSS69f6IVk9/NSkY25s3cnMNpw0fkW2aQZdMn
	 k6eOHyMTFwCXWqH+SOFvuJq1qfDMKu0tIPfOygAOGeOOKYGwq7TnyifWDLdN3Drr+K
	 rYztZW2ot2BRQq2pzr520CrnGiLYfIBOowwWzk4+BSTtmb+m0ucPk1ZOspX8500nvg
	 DdpRoVxNzdz3G1fVTDBSRhGTrkpslqZwquPr2uSmGdmznUKePxWBEKEDC3qAeaCCOq
	 aoiK5hrEmw6pHNtoXgJUBj5tYbTOjO+GfYD6g3Z+iXjsAWXggI0FogzFcmeeSE0koZ
	 nQwLTKhHv8qYg==
Date: Tue, 9 Apr 2024 15:15:23 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: riscv: add Zimop ISA extension
 description
Message-ID: <20240409-dorsal-bullwhip-d4c59bc4975c@spud>
References: <20240404103254.1752834-1-cleger@rivosinc.com>
 <20240404103254.1752834-2-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+LHcW8rxlKd0RZZo"
Content-Disposition: inline
In-Reply-To: <20240404103254.1752834-2-cleger@rivosinc.com>


--+LHcW8rxlKd0RZZo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 12:32:47PM +0200, Cl=E9ment L=E9ger wrote:
> Add description for the Zimop (May-Be-Operations) ISA extension which
> was ratified in commit 58220614a5f of the riscv-isa-manual.
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--+LHcW8rxlKd0RZZo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhVNewAKCRB4tDGHoIJi
0n8eAP9G5NnKVLgQMb1lC5BZ3jPuQhdNqtENnurmzVKeuoB++wEAq+L+bZ9N0ZB3
+NWu0wLgJxehhQ4lxyYWfVXAcV19WQg=
=pnap
-----END PGP SIGNATURE-----

--+LHcW8rxlKd0RZZo--

