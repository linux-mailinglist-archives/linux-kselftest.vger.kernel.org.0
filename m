Return-Path: <linux-kselftest+bounces-13008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAC391E1D8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 16:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043B8283BB9
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F64815FCF5;
	Mon,  1 Jul 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3kAHJ0+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A44D15F41E;
	Mon,  1 Jul 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842811; cv=none; b=IhSQqjKLqVHISDJz2a67o5Xv5HzeUenopDzy5JZZcZ/Mo4v/0Dt7DXpqn7o6AQePjP6e7d2lEk/wwmb9boXpaicaudlqLow/OzZ3VUF2XlbnYEbFpD8x3+jO9vBZ6CrnwKaQ5r36B8/qwoR95DzClYpTnYYqsHcC5FbQvRaOU88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842811; c=relaxed/simple;
	bh=pQIIGvTZUYi99XxRe0YcnEpYQcYwdZfuFQQL2fvkEHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MStFDwgjqPV0jY5/m8iybVA3FeZuoNuVbuGrsNqsBEDac4ry3pOqWMh8BI2jlzwM0bNgZGoxJ3L6LPxBs7MjKpMAeb5zeKbH5/PeGaFBChHnb1Z7zDcPcU75RPswHaA2L7iXj4yQw7NBIlMK7D/r8pB2yshrF25Hh6RqOmZOsmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3kAHJ0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A0DC2BD10;
	Mon,  1 Jul 2024 14:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719842811;
	bh=pQIIGvTZUYi99XxRe0YcnEpYQcYwdZfuFQQL2fvkEHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3kAHJ0+G9KnnnwtkBej5oeluZnuuPHiG/QzE5zXykCiPGWlWac9i8fppS4JJJbrp
	 nKCII4vGqtm1cm2BcgA0FMTfrKgDZxAE1amRMkFK3QsKeDirIP4a9oPf1Up9iHkX8N
	 39GnlQ60qejy4aKS51Jp4Rmf3V7kB9JZ6lFipLISScRugEpUwYwM0rNA8d8pbzQCax
	 lSUZAHzxtps7hTrTtg412zkZ1Aznhy1wYoBSr15veRsCJnDsFWN4IRMYym9o/H7raR
	 EPZHwQIYV19puDb/7KR1ZbKkAZSuULkxdW25gKsSdYN7mIKqU0XjS1OtPYWTRt26XD
	 T4D2XR/TRYB6A==
Date: Mon, 1 Jul 2024 15:06:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 05/13] riscv: vector: Use vlenb from DT for thead
Message-ID: <20240701-hybrid-kitchen-2051f8a8ee86@spud>
References: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
 <20240619-xtheadvector-v3-5-bff39eb9668e@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TK00VZtfKVU6+hsk"
Content-Disposition: inline
In-Reply-To: <20240619-xtheadvector-v3-5-bff39eb9668e@rivosinc.com>


--TK00VZtfKVU6+hsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 04:57:18PM -0700, Charlie Jenkins wrote:
> If thead,vlenb is provided in the device tree, prefer that over reading
> the vlenb csr.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--TK00VZtfKVU6+hsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoK39AAKCRB4tDGHoIJi
0oZ2AP9wLY8qWGouPJdOJukMSsLuFzcc2RXdh+CXIFhJZWObAwD8DnRG3q8GIDBV
lsqKFk1HciXkBCw2+musvfI7br12WAE=
=yHvA
-----END PGP SIGNATURE-----

--TK00VZtfKVU6+hsk--

