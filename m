Return-Path: <linux-kselftest+bounces-8375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3A58AA399
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 22:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF811F25003
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 20:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74A31802C5;
	Thu, 18 Apr 2024 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY4rQTR0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C6F16D314;
	Thu, 18 Apr 2024 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713470408; cv=none; b=nqg9TR9hkFsjJ1+BZnpOjQBZEzBH6iZduhEFQiUSGi5D3vUw6rnvhAAh2UdD988pVp+/fTfS1K8/F2yRNE7U1lLMUUhULg8mxgqtlwj6JMjrhyu7aXPs3C0RbACJkgi8DrIFxFwtxNwhlJBBIg4oZD2wuOvdae3Z/7TVU9tq2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713470408; c=relaxed/simple;
	bh=HWefGnwQI2HwNz4Knpy1Fh114LZYu0wgCLBTdlxtmUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+tkgY+fvZtBuM+ENr0k0NIhjhFuMoia0wjM7de6oC5nPQLeab0L4kERid5AuOYxFghLc6FvsR7UuXlhG2JRnGtkBgVOAsgJuwGf3qWUdX0gx9wEJEgXFiV1H1m+81kO1UvcjGXRqMkGyy31QYL6ayZ+jySJyU7DNDAEbum0xuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY4rQTR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AAFC113CC;
	Thu, 18 Apr 2024 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713470408;
	bh=HWefGnwQI2HwNz4Knpy1Fh114LZYu0wgCLBTdlxtmUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eY4rQTR0vB3nF31du2IEDKNwwn+Arhad3fDAJYF8yZ1FJh3Dhu/OomZi51qGz0+xm
	 yra/nkWPz4cFawkghV0gdBKi6ECmIsqrPWj3/SQU3/50UuGZrAWlq2RS2efp5kTKhn
	 sEsyCi98quhg615KvU+4ANrTH8KbscCy6oiuVNXuib7kuD0Id9WX3lNppWvtA90Im5
	 0AKhCGhrvZTB2b9mhHgqt6RU8CbmlUzz8j1iWRciRpAczvqRefIU8Dz3FAeIcL/OOI
	 zD8tMN5uEBWYh68fDMPlqOQL0e7l0KYx5v22crgl35DzYqXvHmF+v+qdFjxzsYhJvr
	 6SFqrgLNKRXPw==
Date: Thu, 18 Apr 2024 21:00:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Heiko Stuebner <heiko@sntech.de>,
	Guo Ren <guoren@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Jerry Shih <jerry.shih@sifive.com>
Subject: Re: [PATCH v4 7/9] riscv: vector: adjust minimum Vector requirement
 to ZVE32X
Message-ID: <20240418-dolphin-epileptic-749c9628e5a9@spud>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-7-e0c45bb6b253@sifive.com>
 <20240418-brook-chili-4d3e61d1a55c@wendy>
 <20240418155256.GA2410@sol.localdomain>
 <20240418-ultimatum-yam-11de4b063b83@spud>
 <20240418173203.GA1081@sol.localdomain>
 <20240418173946.GB1081@sol.localdomain>
 <20240418-sterling-sanding-d59c3b0a2aaa@spud>
 <20240418184129.GA1071@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MEYWdzN/KoxvaYBs"
Content-Disposition: inline
In-Reply-To: <20240418184129.GA1071@sol.localdomain>


--MEYWdzN/KoxvaYBs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:41:29AM -0700, Eric Biggers wrote:

> If the RISC-V kernel ever disables V, then it should also disable everyth=
ing
> that depends on V.
>=20
> This would be similar to how on x86, if the kernel decides to disable AVX=
 to
> mitigate the Gather Data Sampling vulnerability, it also disables AVX2, A=
VX512,
> VAES, VPCLMULQDQ, etc.  See cpuid_deps[] in arch/x86/kernel/cpu/cpuid-dep=
s.c.
>=20
> Sometimes CPU features depend on other ones.  That's just the way things =
work.

=F0=9F=A4=A8

> Whenever possible that should be handled centrally, not pushed down to ev=
ery
> user both in-kernel and userspace.

FWIW, anything detected but rejected while probing the DT or ACPI tables
will cause riscv_isa_extension_available() (or other APIs) to return false.


--MEYWdzN/KoxvaYBs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiF7wQAKCRB4tDGHoIJi
0lrQAP0ZnhY2j8dAgcGtM2slb23/HOfAFrbbsZhuBfSx0uoWSAEAubVPWlDs59pJ
eFvw6AB3RzfrfggfMB1wA9nLHCZYzQs=
=Ogch
-----END PGP SIGNATURE-----

--MEYWdzN/KoxvaYBs--

