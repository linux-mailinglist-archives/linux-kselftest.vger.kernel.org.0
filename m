Return-Path: <linux-kselftest+bounces-13020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF0491E560
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 18:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61572811B3
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 16:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C7E16D9C9;
	Mon,  1 Jul 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4F+tGQB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0D16CD1E;
	Mon,  1 Jul 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851468; cv=none; b=QuihPWW1Oy0TnAvXr9rpz8weKlBHpptILsrPFoCq2Ayt88Tt547pWoGkjDhnNRsmkCM5L1om6pBQ30431cMqm7ORqnWgULGSER7UAEcyZpVpAwqf1DYTPctZi53IRGpfa09BM9bI7aWmBIyI+z9sEW9wBK3xIEcndG5Q4fj2KOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851468; c=relaxed/simple;
	bh=3+N9mukdDXyzFCGLQCqPnIa6llv8dipDxdiIJdfI2BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzlSOUdp+qNaEdXVXIkrAo9vM8+jbMF2MzEDQxwViZS6MXqrHQckO6UrftH2QV3gmNyjwzkwcJtc9rYcQAI8npJcvZqsyTtODlAiOcszSKFrxZdrJE5e3u9QvJNAwVt2WdB0HpaDgIl/mvRr92LqmLOt3puBxN6zMt+jqzj3SoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4F+tGQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C198C116B1;
	Mon,  1 Jul 2024 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719851467;
	bh=3+N9mukdDXyzFCGLQCqPnIa6llv8dipDxdiIJdfI2BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4F+tGQB8Hcw87QnKmezQg520Gcp5L4jM+vlgj/UvG/nEhKg/o+U8avYMj889kQ8g
	 KIg7e1oHvlgRbaS0lVEGaX9Dpcz62o8QoQUDwCx2FMMYNUGNk2F2Tq9mvcLntsK7nb
	 L1h+t+YpXW+ATKfe9HihuqDHd0V1dYx8Bjb1Ts6ySXWD40NBsiWcQrrkbWjtHMmfjt
	 ON1nAkADPcHpVd8atehi1jgeZRXwizYT/9NejhyxvEpEF85JaxML+n6m0C/V0Mapwp
	 NQoMb123Zw2J4sno25BdiU2/gmzOht3CR7t0U44mQEqALZpCB30da2WDJ7T4qkEij6
	 SKBaTMmQ3lbhQ==
Date: Mon, 1 Jul 2024 17:31:01 +0100
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
Message-ID: <20240701-pyromania-spinster-709a6c8cc460@spud>
References: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
 <20240619-xtheadvector-v3-3-bff39eb9668e@rivosinc.com>
 <0cc13581-5cc4-4a25-a943-7a896f42da4c@sifive.com>
 <20240701-prancing-outpost-3cbce791c554@spud>
 <7ab7d629-6993-4cad-b5b7-62bddfc74a49@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MRFAVKKck9xRQIr9"
Content-Disposition: inline
In-Reply-To: <7ab7d629-6993-4cad-b5b7-62bddfc74a49@sifive.com>


--MRFAVKKck9xRQIr9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 11:11:55AM -0500, Samuel Holland wrote:
> Hi Conor, Charlie,
>=20
> On 2024-07-01 11:07 AM, Conor Dooley wrote:
> > On Mon, Jul 01, 2024 at 10:27:01AM -0500, Samuel Holland wrote:
> >> On 2024-06-19 6:57 PM, Charlie Jenkins wrote:
> >>> The D1/D1s SoCs support xtheadvector so it can be included in the
> >>> devicetree. Also include vlenb for the cpu.
> >>>
> >>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> >>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >>> ---
> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
> >>
> >> The other C906/C910/C920-based SoCs need devicetree updates as well, a=
lthough
> >> they don't necessarily need to be part of this series:
> >>
> >>  - sophgo/cv18xx.dtsi
> >>  - sophgo/sg2042-cpus.dtsi
> >>  - thead/th1520.dtsi
> >=20
> > Yeah, I think I pointed that out before with the same "escape hatch" of
> > it not needing to be in the same series.
> >=20
> >>
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/ris=
cv/boot/dts/allwinner/sun20i-d1s.dtsi
> >>> index 64c3c2e6cbe0..6367112e614a 100644
> >>> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> >>> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> >>> @@ -27,7 +27,8 @@ cpu0: cpu@0 {
> >>>  			riscv,isa =3D "rv64imafdc";
> >>
> >> The ISA string should be updated to keep it in sync with riscv,isa-ext=
ensions.
> >=20
> > This probably looks like this cos I said that the kernel shouldn't parse
> > vendor extensions from "riscv,isa". My rationale was that we have
> > basically no control of what a vendor extension means in riscv,isa so=
=20
> > we shouldn't parse them from it (so marginally worse than standard
> > extensions, where it means what the spec says except when it doesn't).
> >=20
> > Given how we implement the parsing, it also meant we weren't implying
> > meanings for vendor extensions ACPI-land, where we also can't ensure the
> > meanings or that they remain stable. That change is in a different
> > series:
> > https://patchwork.kernel.org/project/linux-riscv/patch/20240609-support=
_vendor_extensions-v2-1-9a43f1fdcbb9@rivosinc.com/
> >=20
> > Although now that I think about it, this might break xandespmu... I
> > dunno if the Andes guys switched over to using the new property outside
> > of the single dts in the kernel tree using their SoC. We could
> > potentially special-case that extension if they haven't - but my
> > position on this mostly is that if you want to use vendor extensions you
> > should not be using riscv,isa (even if the regex doesn't complain if you
> > add them). I'd like to leave the code in the other patch as-is if we can
> > help it.
> >=20
> > I added Yu Chien Peter Lin here, maybe they can let us know what they're
> > doing.
>=20
> OK, that makes sense to me. Then please ignore my original comment.

Should the xandespmu thing be an issue, I'd suggest we just do something
like the following, in place of the new switch arm added by Charlie:

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index ec4bff7a827c..bb99b4055ec2 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -628,6 +628,17 @@ static void __init riscv_parse_isa_string(const char *=
isa, unsigned long *bitmap
 		if (unlikely(ext_err))
 			continue;
=20
+		if (*ext =3D=3D 'x' && acpi_disabled) {
+			/*
+			 * xandespmu predates this "rule", so special case it for
+			 * hysterical raisins
+			 */
+			if (strncasecmp(ext, "xandespmu", ext_end - ext)) {
+				pr_warn_once("Vendor extensions are ignored in riscv,isa. Use riscv,is=
a-extensions instead.");
+				break;
+			}
+		}
+
 		match_isa_ext(ext, ext_end, bitmap);
 	}
 }


--MRFAVKKck9xRQIr9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoLZxAAKCRB4tDGHoIJi
0vx9AP9TcSJwtzFrkZkNIG3vs0nSWuu1I+CFqCZfZtrYfWH8RQEAxGeKP2P/oodO
cyCHRd/9NqDoz5j8eiXpnwlmjUtaKAk=
=AA89
-----END PGP SIGNATURE-----

--MRFAVKKck9xRQIr9--

