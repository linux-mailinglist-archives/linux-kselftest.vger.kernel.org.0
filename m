Return-Path: <linux-kselftest+bounces-10318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18E48C7DB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 22:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0071F222C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 20:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A355157468;
	Thu, 16 May 2024 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDAWhmUD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A27139F;
	Thu, 16 May 2024 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715891472; cv=none; b=C4WanZoJVEq0EZ/whcMMb0yHtlZBxzOacfRF1e9eDf2fzwLbfNi+5pmrs9xXsy+Ng8R5DmghgpWkiPeNWrpufNDZv10BHU6QNEl3VlNVUNPKj1Xelv4DPSUDSM3x00mjxtKMIavFHwN7oPTPiMm4N1OaDRzhAd1gRjAqfD5Mwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715891472; c=relaxed/simple;
	bh=vOAyXMvMO4/iJmPTXPfyexrttf8zBjbSgvoi5gnjzLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNLvogHrO0c2p570qXRzxGXHHuGBINs51B5/j+66FIsxhHVvE5evJwhrafD6i+wMXcN2+KEOqgc04iM+wlFzcBvo+/5HHjz3JCqCnvPz4JRAXU9gtkiWjLzs3sPFpZxvS6cnLdwsBMFyk9MuC1ZJcx4o/9LX2iCg7eDSMT6lQr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDAWhmUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EBAC113CC;
	Thu, 16 May 2024 20:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715891471;
	bh=vOAyXMvMO4/iJmPTXPfyexrttf8zBjbSgvoi5gnjzLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDAWhmUDmLUiJb54Uja30vFjFw9q6NBXP74EOnCuKC8gHyhMuGeRboksCf13pFIJQ
	 rUG5cbU3P18kx+EqmNzzOa9xJsYGNRBuXzKmlMFge9ZqMr6Wh9rJRQgUfPm5AMqGP0
	 GRqELF2/2r8X5G7YT1C0WY7xdp7oodx3Z47FIVS4O+uOLNKfohAPMByTt+u7Sz0LWS
	 WDd62ipGaHqfNN3abosA1QOOV7K+aYDI2KEZs1kaUQTGR9+CbXOZsgapkjBtIeuWri
	 AN9qyObaZ2Cv/3jMm51bZl3nI90Yvvna1Ko2XgxVzEJqsgvt0JZt/EiSMcYUoo+x0W
	 qk2FTzTBilR5g==
Date: Thu, 16 May 2024 21:31:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Andy Chiu <andy.chiu@sifive.com>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v6 03/17] riscv: vector: Use vlenb from DT
Message-ID: <20240516-sleek-wound-f835b3bf23cf@spud>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-3-cb7624e65d82@rivosinc.com>
 <CABgGipXg68VEGt=oZZSENmbqs4-g3PB=CBobNwgqQjLHfxo+VQ@mail.gmail.com>
 <20240516-grandkid-monday-86c698ca4aed@spud>
 <ZkZV3yxbxab4W6I4@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HJGHkHICZT5TWk2k"
Content-Disposition: inline
In-Reply-To: <ZkZV3yxbxab4W6I4@ghost>


--HJGHkHICZT5TWk2k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 01:28:45PM -0700, Charlie Jenkins wrote:
> On Thu, May 16, 2024 at 05:24:25PM +0100, Conor Dooley wrote:
> > On Thu, May 16, 2024 at 10:00:12PM +0800, Andy Chiu wrote:
> > > On Sat, May 4, 2024 at 2:21=E2=80=AFAM Charlie Jenkins <charlie@rivos=
inc.com> wrote:
> >=20
> > > > +               if (elf_hwcap & COMPAT_HWCAP_ISA_V && has_riscv_hom=
ogeneous_vlenb() < 0) {
> > > > +                       pr_warn("Unsupported heterogeneous vlen det=
ected, vector extension disabled.\
> > > > +                       elf_hwcap &=3D ~COMPAT_HWCAP_ISA_V;
> > > > +               }
> > >=20
> > > We only touch COMPAT_HWCAP_ISA_V and the failed case only turns off t=
he
> > > rectified V. So here we have nothing to do with the Xtheadvector.
> >=20
> > There's nothing t-head related in the tree at this point, so doing
> > anything with it would cause build issues.
> >=20
> > > However, I am still confused because I think Xtheadvector would also
> > > need to call into this check, so as to setup vlenb.
> >=20
> >=20
> > > Apart from that, it seems like some vendor stating Xtheadvector is
> > > actually vector-0.7.
> >=20
> > The T-Head implementation is 0.7.x, but I am not really sure what you
> > mean by this comment.
>=20
> Andy, the idea of this patch was to be able to support this binding on
> more than just xtheadvector.
>=20
> You are correct though Andy, this is a problem that a later patch in
> this series doesn't disable xtheadvector when vlenb is not homogeneous.
> I am going to wait to send out any more versions until after this merge
> window but I will fix this in the next version. Thank you!=20

Agreed on all counts :)

> > > Please correct me if I speak anything wrong. One
> > > thing I noticed is that Xtheadvector wouldn't trap on reading
> > > th.vlenb but vector-0.7 would. If that is the case, should we require
> > > Xtheadvector to specify `riscv,vlenb` on the device tree?
> >=20
> > In the world of Linux, "vector-0.7" isn't a thing. There's only 1.0, and
> > after this patchset, "xtheadvector". My understanding, from discussion
> > on earlier versions of this series the trap is actually accessing
> > th.vlenb register, despite the documentation stating that it is
> > unprivileged:
> > https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadv=
ector.adoc
> > I assume Charlie tried it but was trapping, as v1 had a comment:
> > +		 * Although xtheadvector states that th.vlenb exists and
> > +		 * overlaps with the vector 1.0 extension overlaps, an illegal
> > +		 * instruction is raised if read. These systems all currently
> > +		 * have a fixed vector length of 128, so hardcode that value.
>=20
> On my board with a c906 attempting to read th.vlenb (which is supposed
> to have the same encoding as vlenb) raises an illegal instruction
> exception from S-mode even though the documentation states that it
> shouldn't. Because the documentation states that vlenb is available, I
> haven't made it required for xtheadvector, I am not sure the proper
> solution for that.

Would you mind raising an issue on the T-Head extension spec repo about
this?

Thanks,
Conor.

--HJGHkHICZT5TWk2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkZtCAAKCRB4tDGHoIJi
0iqUAQDoE9mZU3cwwi2L0msRdNJfiKf3sHdTRqTyprp8fMkE0QEA+E4AIm1pM5DV
TplcpCK2uFfwFdtBhcs80nkZCt5chgo=
=Mu0n
-----END PGP SIGNATURE-----

--HJGHkHICZT5TWk2k--

