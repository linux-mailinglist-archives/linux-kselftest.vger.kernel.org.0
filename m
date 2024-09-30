Return-Path: <linux-kselftest+bounces-18653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1416398A7DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B388E281D69
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFFB194C6A;
	Mon, 30 Sep 2024 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYrk5QmY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C35194ACB;
	Mon, 30 Sep 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708017; cv=none; b=Txv1CMPJ76WYiSTrL9X+TUzSFaq1N604l8alLJ7TV1y78Jn+efvW3jip0g86AAmmX4yyqjNkOhmVpp820Frc4dadrXHxIEXk1VQa4BqtxtRyn+8oZblEwEb2jBMcfbdbR1jWiKs3z6Fskx458PO0zmRbK3GcQV/1lxu4uz23y9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708017; c=relaxed/simple;
	bh=H5EV1RRodrsbm5ea8UJTy16lJkA2S9iZk7mZhOSIW6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eS1/hgtJZkrKRHGziEqpWTsfkdpjFz39X0qEQzQTGMOJnESNXvbA9p7KBHC0l+PvNlNudgBY1lMWl1LcsAWIV6ESng+q1u+Pj1F8Nza3OEgH9qI+4n4KawsKg+IPlyxWRtuRyPhMTMKh/wm4fYfMVxIBB/L13BJ/yEGeDAoxSt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYrk5QmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6125DC4CEC7;
	Mon, 30 Sep 2024 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727708016;
	bh=H5EV1RRodrsbm5ea8UJTy16lJkA2S9iZk7mZhOSIW6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYrk5QmYKX+nqa2DOTziaQLHU1l3FYbC+Gm6UhuDJc2L/qbKfCagYtQCo1nvqnCIW
	 HYb7iCyDTwGSHQlhehyoUClmn4xYvkFVQvWndELKO8Qq+DLn5g0cKGD0SbVvnzDNdH
	 zjhjFHhty2JNVl5PXDQnSX5QjB4PxjjJ3fuJtB0Evn7njpZfEYX1TqJizIpR2cp8dX
	 6gwkYuV1bn84Rg7RgiSBibektX8xbfWyAfSN0J5n7hjvkRpJ1sN/4rgmVSA5dpcwYk
	 bUmFeDjHugx51UhhkxPdGo+h5/NC5h/t8v5OBef7ABGcLad9vS5AJHiibwBsphpZdp
	 fnrah/znakWnw==
Date: Mon, 30 Sep 2024 15:53:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Aoba K <nExp_0x17@outlook.com>
Cc: "charlie@rivosinc.com" <charlie@rivosinc.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"andy.chiu@sifive.com" <andy.chiu@sifive.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"evan@rivosinc.com" <evan@rivosinc.com>,
	"guoren@kernel.org" <guoren@kernel.org>,
	"heiko@sntech.de" <heiko@sntech.de>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"jrtc27@jrtc27.com" <jrtc27@jrtc27.com>,
	"jszhang@kernel.org" <jszhang@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"samuel.holland@sifive.com" <samuel.holland@sifive.com>,
	"samuel@sholland.org" <samuel@sholland.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"wens@csie.org" <wens@csie.org>
Subject: Re: [PATCH v10 00/14] riscv: Add support for xtheadvector
Message-ID: <20240930-reenact-stratus-9d42d7439df4@spud>
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
 <a1f41f92-6bd0-48b6-a931-e7ad7aba18cc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hamb1NyozR0uOSVn"
Content-Disposition: inline
In-Reply-To: <a1f41f92-6bd0-48b6-a931-e7ad7aba18cc@outlook.com>


--Hamb1NyozR0uOSVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 12:44:07PM +0000, Aoba K wrote:
> Hello Charlie,
>=20
> I've been working on bringing up the Sipeed Lichee RV Dock
> (which also uses the D1 SoC) with the kernel patches you provided.
> The patches applied cleanly to Palmer's for-next branch,
> but I've encountered a couple of issues:
>=20
> 1. Skiffos Compilation Error during the compilation process of `cgo`:
> `unknown relocation type 17; compiled without -fpic?`
> Unfortunately, I closed the terminal before saving the full log,
> so I don't have the complete details, but the result should be reproducib=
le.
> While this should be a SkiffOS issue, mention it in case SkiffOS is the m=
ethod
> that you mentioned for bringing up the device.
>=20
> 2. Image Building with sehraf/riscv-arch-image-builder:
> After building the image, the device failed to start at an early stage.
> I suspect this may be related to incorrect RAM size detection,
> as the board only has 512MB of RAM.
> Interestingly, the vendor image reports 1GB, and the Sipeed website also =
states
> that the Dock has 1GB, despite there being no extra memory bank present.
>=20
> You can find the boot log here: https://fars.ee/bdYk.log
>=20
> Any help would be appreciated, and big thanks to your work
> to make the efficient part of this board to work (again)!

The log you posted at https://fars.ee/XFzR appears to be using the
devicetree of a Nezha not the Lichee RV Dock. Why are you doing that,
when the Lichee RV Dock is supported in the kernel already?

Cheers,
Conor.

--Hamb1NyozR0uOSVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvq7aQAKCRB4tDGHoIJi
0iYzAP42CtXDZpcWhRrFXf/pP66arAHe2Q5uoLqijR0QtCN9HQEApur4oRSzITjL
SgCrOuckDuHJRCTBo9J9wNnIVrJC/AQ=
=iwxp
-----END PGP SIGNATURE-----

--Hamb1NyozR0uOSVn--

