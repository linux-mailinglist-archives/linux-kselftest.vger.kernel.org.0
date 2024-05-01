Return-Path: <linux-kselftest+bounces-9234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A80D8B8F68
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 20:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02E41F210CE
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 18:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED648147C74;
	Wed,  1 May 2024 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJfy5onH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A41474D9;
	Wed,  1 May 2024 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586975; cv=none; b=RpQ2tBDJO/WGuDZQ9kkTUxbzwNwVPQ/aXZ5cJXnB9rZsxD7lBT38l7u2c3MgwI18IMi9TolBozCzXQ9olYBoUs5XVIVh/rPkaaL2leyVEww1i8vR0No9oyzljQZtN+4x4gtQd36YjnW2f1uYoOHJvbbY0Fk7huC6+GgNfwd3Uw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586975; c=relaxed/simple;
	bh=GUrIh8yHkkjlZaW0ktFu8P9XlYLMGXvdBwQsqt4psgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiK2ODSJHbpACYOZHxL7uROKkzCngd75Ka8tQfXnC/C4bZWSYwSnPeNQ/jCD+PyP0bTLgiKBuPfv/BgjZHD1TzyTpUxBhkyzD/4arf8XAQtSGw2ypKA2J8jwscHUAGAfTHIvtNTUm22ivqmYo7rLnc0hsMHkXEPfttM68EKoRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJfy5onH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDBDC072AA;
	Wed,  1 May 2024 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714586975;
	bh=GUrIh8yHkkjlZaW0ktFu8P9XlYLMGXvdBwQsqt4psgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJfy5onHBA+Zu1aUXMBi8sapeke4esXCAUWp5juWXi/8n05Rz+T2GKXlpuVUu+jBZ
	 bKxuby08Bzoblsk+ckGyQOU+0nTrIPPwTUSk34LPpqqKDlO1cAoYbdNuFXavu1AXpE
	 5/KA643kPVn1GLgV03XYS+pEgxXoPNxxpy6dKIL3o+jwR8LE31mDecnTA+VuS5dEAK
	 29Q+NccXCflx8gXcd7GXSSSn8pSxdqnAIFm9+AWOs3kd6aChniYKKNxyTm2uyPNUcV
	 cqra5dfmJOx5ys95/whQYG8wntuyTx2c7sNMFRm9Xk1n2AWaPhyY0Y0AlCqMOcMJu1
	 uNT8H3oBxBYPw==
Date: Wed, 1 May 2024 19:09:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Evan Green <evan@rivosinc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 05/16] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <20240501-moneyless-shifter-a54bbaecc4e7@spud>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
 <CALs-HstM64Hy_=XVz=0sWQt=8j1u+bq6RhthUuD3P0E4=HyvcA@mail.gmail.com>
 <ZjKBKg5zzikR5ngl@ghost>
 <20240501-banner-sniff-4c5958eb15ef@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yAv19tBoV/9fOzJc"
Content-Disposition: inline
In-Reply-To: <20240501-banner-sniff-4c5958eb15ef@spud>


--yAv19tBoV/9fOzJc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 07:03:46PM +0100, Conor Dooley wrote:
> On Wed, May 01, 2024 at 10:51:38AM -0700, Charlie Jenkins wrote:
> > On Wed, May 01, 2024 at 09:44:15AM -0700, Evan Green wrote:
> > > On Fri, Apr 26, 2024 at 2:29=E2=80=AFPM Charlie Jenkins <charlie@rivo=
sinc.com> wrote:
> > > > +       for (int i =3D 0; i < riscv_isa_vendor_ext_list_size; i++) {
> > > > +               const struct riscv_isa_vendor_ext_data_list *ext_li=
st =3D riscv_isa_vendor_ext_list[i];
> > > > +
> > > > +               if (bitmap_empty(ext_list->vendor_bitmap, ext_list-=
>bitmap_size))
> > > > +                       bitmap_copy(ext_list->vendor_bitmap,
> > > > +                                   ext_list->per_hart_vendor_bitma=
p[cpu].isa,
> > > > +                                   ext_list->bitmap_size);
> > >=20
> > > Could you get into trouble here if the set of vendor extensions
> > > reduces to zero, and then becomes non-zero? To illustrate, consider
> > > these masks:
> > > cpu 0: 0x0000C000
> > > cpu 1: 0x00000003 <<< vendor_bitmap ANDs out to 0
> > > cpu 2: 0x00000010 <<< oops, we end up copying this into vendor_bitmap
> > >=20
> >=20
> > Huh that's a good point. The standard extensions have that same bug too?
> >=20
> > 	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
> > 		bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
> > 	else
> > 		bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
>=20
> I suppose it could in theory, but the boot hart needs ima to even get
> this far. I think you'd only end up with this happening if there were
> enabled harts that supported rvXXe, but I don't think we even add those
> to the possible set of CPUs. I'll have to check.

Ye, you don't get marked possible if you don't have ima, so I don't
think this is possible to have happen. Maybe a comment here is
sufficient, explaining why this cannot reduce to zeros?



--yAv19tBoV/9fOzJc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjKFWAAKCRB4tDGHoIJi
0kU9AP4s89glK6UnykI5g5cj0b710rlhFt08mdDjYgdqVE4BzwD+Pa0gATqWhdOe
sO8sV3u9SVcK+K5gu/2K3mQMzB+OYQE=
=r/pQ
-----END PGP SIGNATURE-----

--yAv19tBoV/9fOzJc--

