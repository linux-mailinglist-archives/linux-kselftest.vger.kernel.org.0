Return-Path: <linux-kselftest+bounces-15235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093C695098E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 17:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB951C21F1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 15:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293EA1A08C4;
	Tue, 13 Aug 2024 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdDaa/og"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019D1A073C;
	Tue, 13 Aug 2024 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564535; cv=none; b=FEDzJLoLl5J4UaTWQ6lo4XJI0+ig5QZMZhmbEPlWbCV+frhla7s3FiJHY99nOFazJcVxvyszMy3ESDMNa0NCimQwhcubeKp/ZeEQZyU4fqraMVt1zUCxRvS52N5ODcSV37QWCjcaWBKlZhaV+5558hes0e/+iipYJnBmZANPmlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564535; c=relaxed/simple;
	bh=2qbznLVAWa/HOCkibpwEKuFx9BRG0jfLiyGPm/O5D0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrysTMLe8/lW4Ac9VRJvwngkcSIWbSRXJGhNcYxhEy9FCfbpQhDsehFYZW9P19vR8u/vCZWaDb7HQJ6WUf4mU2LtpUmB4R8laEoloNWTQL2ST8KIm+sSd2ev+NNZSZLf9f/TpYmSZXRIGiQxMrDllAsS5F5JHlv0Cok5LgPjG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdDaa/og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B120C4AF09;
	Tue, 13 Aug 2024 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723564534;
	bh=2qbznLVAWa/HOCkibpwEKuFx9BRG0jfLiyGPm/O5D0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TdDaa/og08j0LYWxMjIfmT62Kse6nlmDNAqFUWXRmeAOd4L8HUcdtoNGpFIKZ2ovK
	 Wo8eroMPA7ljNcvycCtAJoCPSOW0sL4ez8CU0njPbAl5s4w3e1pL1xt0z/5bkAsd3W
	 AyI8VSs3BZHOYosptDMzpeCBZYGxHn2H8y8LbYAnhcsMLr91GM20TL0ixceE9tPfzb
	 Vx1zlFj6nEUair4k8rdOYdoG4DTk8CIJwZHafLxB8o8P/RrW8+9bZFSBxfXNpqDFNr
	 VwMB5tfnO4Fx23eAhjULiqlqOWHy4r2C5DEKNZSBu0vrreLkayROtBxCfuvWvflTI4
	 xxXxYgEv0gapw==
Date: Tue, 13 Aug 2024 16:55:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v9 00/13] riscv: Add support for xtheadvector
Message-ID: <20240813-strode-revival-07b8556a8bfe@spud>
References: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
 <20240809-slapping-graph-461287bac506@spud>
 <ZrqsqsCtKwfG4Q5B@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wVALGEdsN5/GZu0E"
Content-Disposition: inline
In-Reply-To: <ZrqsqsCtKwfG4Q5B@ghost>


--wVALGEdsN5/GZu0E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 05:45:30PM -0700, Charlie Jenkins wrote:
> On Fri, Aug 09, 2024 at 11:31:15PM +0100, Conor Dooley wrote:
> > On Tue, Aug 06, 2024 at 05:31:36PM -0700, Charlie Jenkins wrote:
> > > xtheadvector is a custom extension that is based upon riscv vector
> > > version 0.7.1 [1]. All of the vector routines have been modified to
> > > support this alternative vector version based upon whether xtheadvect=
or
> > > was determined to be supported at boot.
> > >=20
> > > vlenb is not supported on the existing xtheadvector hardware, so a
> > > devicetree property thead,vlenb is added to provide the vlenb to Linu=
x.
> > >=20
> > > There is a new hwprobe key RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 that =
is
> > > used to request which thead vendor extensions are supported on the
> > > current platform. This allows future vendors to allocate hwprobe keys
> > > for their vendor.
> > >=20
> > > Support for xtheadvector is also added to the vector kselftests.
> >=20
> > So uh, since noone seems to have brought it up, in the light of the iss=
ues
> > with thead's vector implementation, (https://ghostwriteattack.com/) do =
we
> > want to enable it at all?
>=20
> I can make it clear in the kconfig that xtheadvector is succeptible to
> this attack and that it should be enabled with caution. I think we
> should let people that understand the risk to enable it.

I think the clearest way might be "depends on BROKEN"?

--wVALGEdsN5/GZu0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZruB7wAKCRB4tDGHoIJi
0tDJAQCrAAwyJAAGcGaB0lSjHQowc1+M+60A33xWLVpFubDEggD+PdA/5VviAMYd
FtjIx2BGIAbBB5DLVfsxw4duVA3eAQc=
=/cR1
-----END PGP SIGNATURE-----

--wVALGEdsN5/GZu0E--

