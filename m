Return-Path: <linux-kselftest+bounces-13017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D381791E4CA
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 18:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4D61C20F7F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 16:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D282716D31A;
	Mon,  1 Jul 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXK3nvxm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9151EB2A;
	Mon,  1 Jul 2024 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850052; cv=none; b=YPk/+cqorzs7t5de7bGSxLCu6WAFE7KfK0xwfQ5e/0rrHpimkCJWl2181vYn3PNT//41S9FDcsDt9dQpQKQEsbw+3ly9JOWKVoU+k/uXYeHLE+Acwd8ZiuwKyblFyeATi2iVpOrCuZmxooP1mDydcvbezJ+tRNchgLWtOu9UZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850052; c=relaxed/simple;
	bh=QmDYLMDzbFAVik/DkbW1mPXPNZZJPZCYP+cxE0Noy/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLfqKyluoLqGV4241lpPQ9PMRP5E5iYKeOB3X1Ik9j7DR8rfVEnsEGxK4ZFcsr0hTm40CPFX1pWzI8aYAUVeyDRVJ8VsjK+zNilJijZIWAoUu3M6cDxL+w7QQjRhmEBCM9ZSK5KGXzpiTFQKcVPipxizVDMaCqLdAJjVx0tjkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXK3nvxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741AAC116B1;
	Mon,  1 Jul 2024 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719850050;
	bh=QmDYLMDzbFAVik/DkbW1mPXPNZZJPZCYP+cxE0Noy/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uXK3nvxmKjdsvXXxrtAWaSHnZkAUlaUuJBPDy40HGmKXOTYz9qvAPCJ/VWkKuXzeC
	 9BK4oHFzZm7/Iv3j7kqGx0hxYpqDFXLLi0Kc71J2emXTqu+ldPODcayLA7sI6t8Wys
	 t27pi7dbWc11aw0WhjACbSc85SAa0kOKjo676X82j+pPaju7yudbTHQabykdScnMhW
	 stGPYShnDpxTDnTs9/jSJtnlVZm9x899zHEPNhoiox8yfQudEwc05S++FtV+fVaf9W
	 P+wYvJY+KEXuHltHCHrAA2srbDje5YHXtLXj/6FkqBgIKMRlBujmZ9YeuNBu1K8TAa
	 vJx2aVCLZ4YDw==
Date: Mon, 1 Jul 2024 17:07:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>, peterlin@andestech.com
Subject: Re: [PATCH v3 03/13] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
Message-ID: <20240701-prancing-outpost-3cbce791c554@spud>
References: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
 <20240619-xtheadvector-v3-3-bff39eb9668e@rivosinc.com>
 <0cc13581-5cc4-4a25-a943-7a896f42da4c@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2wEs3Y52yP3HfYxY"
Content-Disposition: inline
In-Reply-To: <0cc13581-5cc4-4a25-a943-7a896f42da4c@sifive.com>


--2wEs3Y52yP3HfYxY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 10:27:01AM -0500, Samuel Holland wrote:
> Hi Charlie,
>=20
> On 2024-06-19 6:57 PM, Charlie Jenkins wrote:
> > The D1/D1s SoCs support xtheadvector so it can be included in the
> > devicetree. Also include vlenb for the cpu.
> >=20
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
>=20
> The other C906/C910/C920-based SoCs need devicetree updates as well, alth=
ough
> they don't necessarily need to be part of this series:
>=20
>  - sophgo/cv18xx.dtsi
>  - sophgo/sg2042-cpus.dtsi
>  - thead/th1520.dtsi

Yeah, I think I pointed that out before with the same "escape hatch" of
it not needing to be in the same series.

>=20
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv=
/boot/dts/allwinner/sun20i-d1s.dtsi
> > index 64c3c2e6cbe0..6367112e614a 100644
> > --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > @@ -27,7 +27,8 @@ cpu0: cpu@0 {
> >  			riscv,isa =3D "rv64imafdc";
>=20
> The ISA string should be updated to keep it in sync with riscv,isa-extens=
ions.

This probably looks like this cos I said that the kernel shouldn't parse
vendor extensions from "riscv,isa". My rationale was that we have
basically no control of what a vendor extension means in riscv,isa so=20
we shouldn't parse them from it (so marginally worse than standard
extensions, where it means what the spec says except when it doesn't).

Given how we implement the parsing, it also meant we weren't implying
meanings for vendor extensions ACPI-land, where we also can't ensure the
meanings or that they remain stable. That change is in a different
series:
https://patchwork.kernel.org/project/linux-riscv/patch/20240609-support_ven=
dor_extensions-v2-1-9a43f1fdcbb9@rivosinc.com/

Although now that I think about it, this might break xandespmu... I
dunno if the Andes guys switched over to using the new property outside
of the single dts in the kernel tree using their SoC. We could
potentially special-case that extension if they haven't - but my
position on this mostly is that if you want to use vendor extensions you
should not be using riscv,isa (even if the regex doesn't complain if you
add them). I'd like to leave the code in the other patch as-is if we can
help it.

I added Yu Chien Peter Lin here, maybe they can let us know what they're
doing.

Thanks,
Conor.

--2wEs3Y52yP3HfYxY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoLUOwAKCRB4tDGHoIJi
0rw0AQCnXybJz50BMTgjwNiigJMGvS3LXS+gpH8vsiDf6bY5nQEA8gffrOCUKPqX
QYl/5hn3gmXORavNMM6uYbvMldYgpA8=
=cmG6
-----END PGP SIGNATURE-----

--2wEs3Y52yP3HfYxY--

