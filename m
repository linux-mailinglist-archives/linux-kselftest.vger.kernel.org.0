Return-Path: <linux-kselftest+bounces-8253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C758A8508
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 15:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C406282E32
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415FF13F443;
	Wed, 17 Apr 2024 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxe+qeP1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63213F42D;
	Wed, 17 Apr 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361369; cv=none; b=s1eVofJMpRFwv78YN4aOgmSyuOFrjRBvhNoo5F5G1BWtV6Q53aSkh5tr1KXr7ZDBk+8a/BiJ0W73yNLjOoqIGEo1OEoeFXy1XsM83vpKuM1NHUDzY5ms/kwIs5yIX3YaabiSibKrN7132JDB/0GEecku8ArOkijM4k1BgZbRrc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361369; c=relaxed/simple;
	bh=exPu4RcMsk/1+QRfafTnptMZ6ljl6Uz5WGS7JHUbSG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egP+pxChIbjkio5fh0Qp70ri3zC5f3//VplYa1aSJgOCWj2DWBFR0V4gP2y/nt/eEcVygegi7zFbvENH/T4mukcWaAUOYL172cD8mRcwcBi4h2zxWm9jcM3XPvqVLCbMfESFY+YEAUEkVsXXa2wYK+prjJadzekarrEkDHPlH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxe+qeP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D799C3277B;
	Wed, 17 Apr 2024 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713361368;
	bh=exPu4RcMsk/1+QRfafTnptMZ6ljl6Uz5WGS7JHUbSG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxe+qeP1yFDPT1hD9RgNKZpz03zbMYoYMhxqPRwisGF9SsPrzxEkUxX75wQv3zBhA
	 BRx4qPfoMxWPdmJwOIK9wFA+qQYzEG1dHt/VODsEgTHspeEyo2FRzPdK/fhuAus2Q8
	 ylR0jMTstUpWiASwRHCg56D+AUdM2rw88Zawp5HQxNXB+vJajPhhiKr+NK9Y/hMrkH
	 P5SN9ZALpHHXlYBftOidVumzDmLewTgO400T9jwqyCuXvtQ/odwwW1dahLq0xrtTMx
	 KE+MFqbTrbccApemLfMPMIb0sr3ngW/lgmXlnzVM1lPk7ua6IcTNR3De9KsJ29aUhp
	 8KxeJSNxWvmBQ==
Date: Wed, 17 Apr 2024 14:42:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 06/17] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <20240417-automaker-baton-bd816e1bd975@spud>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
 <20240415-dev-charlie-support_thead_vector_6_9-v2-6-c7d68c603268@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p0QSKblu8bR1+Anb"
Content-Disposition: inline
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-6-c7d68c603268@rivosinc.com>


--p0QSKblu8bR1+Anb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 09:12:03PM -0700, Charlie Jenkins wrote:

> @@ -351,6 +343,14 @@ static void __init riscv_parse_isa_string(unsigned l=
ong *this_hwcap, struct risc
>  		bool ext_long =3D false, ext_err =3D false;
> =20
>  		switch (*ext) {
> +		case 'x':
> +		case 'X':
> +			pr_warn("Vendor extensions are ignored in riscv,isa. Use riscv,isa-ex=
tensions instead.");

Was looking for something and noticed this - pr_warn_once() I think.

> +			/*
> +			 * In canonical order, the remaining extensions in the
> +			 * isa string will be vendor extensions so exit.
> +			 */
> +			break;
>  		case 's':
>  			/*
>  			 * Workaround for invalid single-letter 's' & 'u' (QEMU).

--p0QSKblu8bR1+Anb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh/R0QAKCRB4tDGHoIJi
0vzZAQCEhpBLtL/EDT9fUbss6os6B1Bq+MiUtQnftDZaXWVoyAD+LTrtP2tTsvuJ
r6qruyvOjKVA6j/gDB5rHH3TKzICzwk=
=MO+X
-----END PGP SIGNATURE-----

--p0QSKblu8bR1+Anb--

