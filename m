Return-Path: <linux-kselftest+bounces-11863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933A4907550
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 16:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88631C21C9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56D5145B26;
	Thu, 13 Jun 2024 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT5iNy5e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935AC145B10;
	Thu, 13 Jun 2024 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289522; cv=none; b=IQ622s/K0gimWTdmGtNllJxJSHj0RJQGtmBxr5fDK/mNETdagWNtMJwqUtP/cUc+NQqbEmAnbVbvDzmiUnKTj7A/W8mjK1EQr8MrpWC9wHW7K8PczrRgJWIqcUs4ZCRJGBjD9q95h8jY7RgBE7+lpFUjMqd2SeQ7T7Fh5aWSQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289522; c=relaxed/simple;
	bh=NAAlrhBw8905EbYOUOmpTvwtHyyaFTaE9nUl4deDWHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0cW9RSwwd69tY5zzXYXhmOrJ7CKIrSuKuyrbAlVUfuyr8h93yOqqrIZiN50Wkh0LIy+5HwfxMnl3qPQS3dGYF+DI8Vl3fWcxtX1sKdF/EWU78U26nGkWdZmXka2SIAzoYRaterwJyXSaa1EFLJr9wfy5g1exC1ASl0P+RuSwiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT5iNy5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA585C2BBFC;
	Thu, 13 Jun 2024 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289522;
	bh=NAAlrhBw8905EbYOUOmpTvwtHyyaFTaE9nUl4deDWHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WT5iNy5eziDZMHQYY5VkVW0WSf/ab41Vu/M/2Ps0gzFEgQ+w+QD6liVWUUSEz/qPp
	 gl7Y/x1kH2dcpDsLxtpyXnaup5D7Et20HSibtcQohhawFwHJaXMwxdEIAWQlxWabU9
	 eEa1UG/7KUP7wXkhc72AN/5mp2quzFtXGHEPuYr363BmeZIiW/Uk8NCoaoed7EYUpk
	 O7NP3rVRp8XJEPMUP2nZWeu590BkqE9LvubrQ2R3lLKdGzUf1kjyeQcZQsUWkZpx0v
	 G61ELzeYZOdui/dkN4Ewj6R+17+X9sOz3kANdEnlFgf1Kzc3xKwcPSPkEyiuYkn1v2
	 WZfecjyUpbH9w==
Date: Thu, 13 Jun 2024 15:38:35 +0100
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
	linux-kselftest@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 08/13] riscv: Add xtheadvector instruction definitions
Message-ID: <20240613-skipper-datebook-ac170f7a9ad5@spud>
References: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
 <20240610-xtheadvector-v2-8-97a48613ad64@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sqinyBkDFO4zELOw"
Content-Disposition: inline
In-Reply-To: <20240610-xtheadvector-v2-8-97a48613ad64@rivosinc.com>


--sqinyBkDFO4zELOw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 03:56:45PM -0700, Charlie Jenkins wrote:
> xtheadvector uses different encodings than standard vector for
> vsetvli and vector loads/stores. Write the instruction formats to be
> used in assembly code.
>=20
> Co-developed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Where did Heiko's signoff go?

--sqinyBkDFO4zELOw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmsEawAKCRB4tDGHoIJi
0p2LAQCpFlZN+A/TCImkor3h1aTtu5LXLeAEwNXlTj5csNSu4gD9GhkXiH2Q4/EJ
ItTvEGIUQODpFkCmvLkOB3rllIA5ewQ=
=OscO
-----END PGP SIGNATURE-----

--sqinyBkDFO4zELOw--

