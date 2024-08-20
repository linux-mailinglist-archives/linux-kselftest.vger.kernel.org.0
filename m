Return-Path: <linux-kselftest+bounces-15780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15185958C80
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 18:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BB82822E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBD41B86FC;
	Tue, 20 Aug 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJt0DoJy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E018C92C;
	Tue, 20 Aug 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724172141; cv=none; b=ZRP+7T7adBmoeZfP1CzdyDLbsWGLTRLPMMR6LHvrMJcp2jIFStR9EUaX+nawHz/+I7BcnzK5jNWGZM3uWBGvUB3GCBUh/Iw3MDuAqJV7yu3iWqoq+2CdfJOX3xScoWrQbVZGXhwW0f+u5vPcd3A/BT3yvs1o0uWNAVmGAPiNWdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724172141; c=relaxed/simple;
	bh=sdAcQwOaXWXKLtRmNTbqfHXhoFfXI/j3eIOc/WaewSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8js26F/pMsbuygwswZOBcfj58vT4e1ysNEPMAYjcz74UWFs9nCRBTxHlSOQAu2cOZp+o7FIz+TJM5UPklWUUSR9PMivfxFpS5GWst1HCqQij4/YG4tCgLVzGiB9nfvNx4qdEuOlWH7Fi4+z3HM32ZCappysKf/vlHN2yNMwXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJt0DoJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDD9C4AF60;
	Tue, 20 Aug 2024 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724172139;
	bh=sdAcQwOaXWXKLtRmNTbqfHXhoFfXI/j3eIOc/WaewSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJt0DoJyvzXw780huXW00DpsfVtjUmG4t0IyBqCD6PLjg4hifTkikh1R6+7NrJBhR
	 T64DDjPlw+P97zLarW882gu1krW29tGBNvBP/PWPmKUP8RN+fxCg7BkXFBzp9hyKV/
	 BSrvNn5wmGF4uR8AUjT9xjgqrOQWKtt7hMb+I/6M6psreBJuPOjY6WC2KWueXjL4YE
	 SrLOpDpx9ZM6bNwbJdQTrCPQxXC+gsEzLhiXHpaY49wVxbs4KQOOfKfr3ApXXJwaf0
	 sQ9hzGEnPcXHlg6+dFla6w5CBBD32h63XVR1W/2TYDoZTYXAAR0y2IdvL12ITRr7bk
	 iXthrwpi4hUYw==
Date: Tue, 20 Aug 2024 17:42:12 +0100
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
Message-ID: <20240820-computer-viewable-eef06bef1bea@spud>
References: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
 <20240809-slapping-graph-461287bac506@spud>
 <ZrqsqsCtKwfG4Q5B@ghost>
 <20240813-strode-revival-07b8556a8bfe@spud>
 <ZsPP4GMwPVBfq+fL@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t0GCzoRN/+6zEXXN"
Content-Disposition: inline
In-Reply-To: <ZsPP4GMwPVBfq+fL@ghost>


--t0GCzoRN/+6zEXXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 04:06:08PM -0700, Charlie Jenkins wrote:
> On Tue, Aug 13, 2024 at 04:55:27PM +0100, Conor Dooley wrote:
> > On Mon, Aug 12, 2024 at 05:45:30PM -0700, Charlie Jenkins wrote:
> > > On Fri, Aug 09, 2024 at 11:31:15PM +0100, Conor Dooley wrote:
> > > > On Tue, Aug 06, 2024 at 05:31:36PM -0700, Charlie Jenkins wrote:
> > > > > xtheadvector is a custom extension that is based upon riscv vector
> > > > > version 0.7.1 [1]. All of the vector routines have been modified =
to
> > > > > support this alternative vector version based upon whether xthead=
vector
> > > > > was determined to be supported at boot.
> > > > >=20
> > > > > vlenb is not supported on the existing xtheadvector hardware, so a
> > > > > devicetree property thead,vlenb is added to provide the vlenb to =
Linux.
> > > > >=20
> > > > > There is a new hwprobe key RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 t=
hat is
> > > > > used to request which thead vendor extensions are supported on the
> > > > > current platform. This allows future vendors to allocate hwprobe =
keys
> > > > > for their vendor.
> > > > >=20
> > > > > Support for xtheadvector is also added to the vector kselftests.
> > > >=20
> > > > So uh, since noone seems to have brought it up, in the light of the=
 issues
> > > > with thead's vector implementation, (https://ghostwriteattack.com/)=
 do we
> > > > want to enable it at all?
> > >=20
> > > I can make it clear in the kconfig that xtheadvector is succeptible to
> > > this attack and that it should be enabled with caution. I think we
> > > should let people that understand the risk to enable it.
> >=20
> > I think the clearest way might be "depends on BROKEN"?
>=20
> Sorry for the delay, I am not sure if BROKEN is the best way of doing
> this. There is the generic CPU_MITIGATIONS config that I think we should
> use to handle this at boot time. This would allow generic kernels to be
> used on the platform, but a kernel config of "mitigations=3Doff" would
> allow xtheadvector to be enabled. I'll look into this a bit more and
> send out a patch. Palmer merged a patch into for-next to enable
> GENERIC_CPU_VULNERABILITIES for riscv so I will add ghostwrite there
> as well.

Palmer also pointed out to me last week that not all implementations of
xtheadvector actually have the flaw, so it makes sense to not depend on
BROKEN. We should figure out exactly which CPUs are and are not
vulnerable (Guo Ren hopefully will know) and permit enabling it without
"mitagations=3Doff" on the CPUs that are not vulnerable.

Thanks,
Conor.

--t0GCzoRN/+6zEXXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsTHZAAKCRB4tDGHoIJi
0iQaAQCwGmipLGnRD4s+x/LBC6nmlI/0+Dt9WrwL3fRDmnQB0gD/W6WolEvdmFdM
5PFKmr6VraPXpNU9m8waceXzejLcRgs=
=gadf
-----END PGP SIGNATURE-----

--t0GCzoRN/+6zEXXN--

