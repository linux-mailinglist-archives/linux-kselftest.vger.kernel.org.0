Return-Path: <linux-kselftest+bounces-10308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005B38C7A4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 18:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1661F21EBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7065214E2D6;
	Thu, 16 May 2024 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckTBUbeU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029C2421A;
	Thu, 16 May 2024 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876672; cv=none; b=AGQ4QSbJzZNuJUjaI7qO4TDjRiB85Cax7aSh5HXr3l1L55u7LIRY2rWQBZ5Ghc9U8TYfcIGYOqwQhE39Pidq5hDwtDdzjeBI1XpEorIg+ms268c+Arkunr8ShhY4g0UBYz0lfxW1TY9Qz4SDmTpcY5GhcT2rOMK2wcOlOI//qxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876672; c=relaxed/simple;
	bh=YPQd9Pwq5Y5I0Bij2ansbmtYi61hje5cM4D0fSaH4v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diAcRdWbPrmEFmxVwEK16Ew48amhIX8WXWUAxZuFt85ECVWESz4W3x/kG51PK312Iq6iWL4T5DlpkkZzxd9q2L5zfufUZhDpCXnM3tuAP0VZzSHwLbFCyXgs7xemtQ7KmE+YgpmkhSVGVpo6WF8sZ1iPWJF8pjrp7c4FPiJVV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckTBUbeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F557C113CC;
	Thu, 16 May 2024 16:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715876672;
	bh=YPQd9Pwq5Y5I0Bij2ansbmtYi61hje5cM4D0fSaH4v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckTBUbeU+U4d8pK30I5KoZpbLoTF1F3+e6xfJWjXJ4EJQyFcHH8LKaim31594OV8N
	 mLeuX/YVDzdBjW8zJiShYpRnbVPc9rQznt1jj3VJ7+lyGmQU9EzEUWQp4cCxD2urfV
	 vMlxsjpdY4l9sInSsA0QnW2dCTO258v55LpfqzLuFxP4QXecHPkpPW0MG3lFZ6xH4m
	 UAtqVq37k3D3kP9GRlXGON/IS+3TCIn9S7HqoBAPo44+HK9rT90qyAo6ZIykI2epHX
	 j6l3mUoL4XBcQpMJOXoE9B88N7CTanz7fRCGviNd7CG7INHguA1X2uMTnfFsvvzL24
	 dCPsaC40p8iQg==
Date: Thu, 16 May 2024 17:24:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20240516-grandkid-monday-86c698ca4aed@spud>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-3-cb7624e65d82@rivosinc.com>
 <CABgGipXg68VEGt=oZZSENmbqs4-g3PB=CBobNwgqQjLHfxo+VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="54mb6NLQMPiDuRTG"
Content-Disposition: inline
In-Reply-To: <CABgGipXg68VEGt=oZZSENmbqs4-g3PB=CBobNwgqQjLHfxo+VQ@mail.gmail.com>


--54mb6NLQMPiDuRTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 10:00:12PM +0800, Andy Chiu wrote:
> On Sat, May 4, 2024 at 2:21=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.=
com> wrote:

> > +               if (elf_hwcap & COMPAT_HWCAP_ISA_V && has_riscv_homogen=
eous_vlenb() < 0) {
> > +                       pr_warn("Unsupported heterogeneous vlen detecte=
d, vector extension disabled.\
> > +                       elf_hwcap &=3D ~COMPAT_HWCAP_ISA_V;
> > +               }
>=20
> We only touch COMPAT_HWCAP_ISA_V and the failed case only turns off the
> rectified V. So here we have nothing to do with the Xtheadvector.

There's nothing t-head related in the tree at this point, so doing
anything with it would cause build issues.

> However, I am still confused because I think Xtheadvector would also
> need to call into this check, so as to setup vlenb.


> Apart from that, it seems like some vendor stating Xtheadvector is
> actually vector-0.7.

The T-Head implementation is 0.7.x, but I am not really sure what you
mean by this comment.

> Please correct me if I speak anything wrong. One
> thing I noticed is that Xtheadvector wouldn't trap on reading
> th.vlenb but vector-0.7 would. If that is the case, should we require
> Xtheadvector to specify `riscv,vlenb` on the device tree?

In the world of Linux, "vector-0.7" isn't a thing. There's only 1.0, and
after this patchset, "xtheadvector". My understanding, from discussion
on earlier versions of this series the trap is actually accessing
th.vlenb register, despite the documentation stating that it is
unprivileged:
https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadvecto=
r.adoc
I assume Charlie tried it but was trapping, as v1 had a comment:
+		 * Although xtheadvector states that th.vlenb exists and
+		 * overlaps with the vector 1.0 extension overlaps, an illegal
+		 * instruction is raised if read. These systems all currently
+		 * have a fixed vector length of 128, so hardcode that value.

Cheers,
Conor.

--54mb6NLQMPiDuRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkYzOQAKCRB4tDGHoIJi
0rSDAQDYSejV6VHTrL2jnxNTvkydaJkpuoNoUR0KH7Woyb0A7wEAoRBty/hTiap0
kvVFRs7XwEEn0QBitKVO7a6zx8YNQA4=
=DNuY
-----END PGP SIGNATURE-----

--54mb6NLQMPiDuRTG--

