Return-Path: <linux-kselftest+bounces-8351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D278AA06C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 18:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A401C21E9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C990171092;
	Thu, 18 Apr 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR5SOtA8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6C16F8F7;
	Thu, 18 Apr 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459243; cv=none; b=THaULIbiTWQqztUthBEq2bVhqLX+sfZPSVTagCu2t3ogajUGG+bG0INv/XX1fNFNxuscJkaKdiKdyfSpo8fNyCJ1XJBOW4LV/ehe6f2+O9+02Gi1bjm7/8eP4lOIPGOKD7Rv4RIRhZ8iEOqNUAm5Gu/nNkhJGt/fC+kcD/BU+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459243; c=relaxed/simple;
	bh=Td96Pr2RLxCmccrLCbz0GSBYtl2efgCYqTBO4CPC85Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etOstbJZuGlqIyr2vsSeJbrjOPeqVi0l4vNJGRSOrDpZ94wbxdqvAmfKfsqZMpIYvQptLtPpdmDrZEweyjUF0CYxs1uzUffLR/I5kHTX4buXdCybbKMBbWGuZjlPLi56W/iITqnZ1XMnOWogxneCGmpTfdXR+r3nN9ecZ1FGBHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR5SOtA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F01C113CC;
	Thu, 18 Apr 2024 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713459242;
	bh=Td96Pr2RLxCmccrLCbz0GSBYtl2efgCYqTBO4CPC85Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LR5SOtA8WsHMP6vVIvV29C88LXwY4oD+ef/jdGjbN3bb54kSGt4EoJHQg89DKFlRi
	 jJ5gOUQHX8QKRHrbQgrjvklqJroXZjGvGntVSvJ0JIClsi0k1C8TETJyXK1+EfQ9PR
	 639TjYZyOQswbawi0oVjBq77Ithr9GznM+wr4uIy93snA3jlvZ74ZbfhtOqrKLLXAi
	 42UUK6THGudljukfqbn7Tg0P1EtQCPLgssw+SO0QetYbyXIB7Q9vr862R7zLRENx88
	 TjbVtJkE5kioS84t+pzUqjwDnGciFsuX3e4akgNc6bzc/0+1lkF/jK0QX8ROzMNrae
	 oLckb+4wXzjVg==
Date: Thu, 18 Apr 2024 17:53:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Heiko Stuebner <heiko@sntech.de>,
	Guo Ren <guoren@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Jerry Shih <jerry.shih@sifive.com>
Subject: Re: [PATCH v4 7/9] riscv: vector: adjust minimum Vector requirement
 to ZVE32X
Message-ID: <20240418-ultimatum-yam-11de4b063b83@spud>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-7-e0c45bb6b253@sifive.com>
 <20240418-brook-chili-4d3e61d1a55c@wendy>
 <20240418155256.GA2410@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="caZE0P60wQJMi2ZH"
Content-Disposition: inline
In-Reply-To: <20240418155256.GA2410@sol.localdomain>


--caZE0P60wQJMi2ZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 08:52:56AM -0700, Eric Biggers wrote:
> Hi Conor,
>=20
> On Thu, Apr 18, 2024 at 12:02:10PM +0100, Conor Dooley wrote:
> > +CC Eric, Jerry
> >=20
> > On Fri, Apr 12, 2024 at 02:49:03PM +0800, Andy Chiu wrote:
> > > Make has_vector take one argument. This argument represents the minim=
um
> > > Vector subextension that the following Vector actions assume.
> > >=20
> > > Also, change riscv_v_first_use_handler(), and boot code that calls
> > > riscv_v_setup_vsize() to accept the minimum Vector sub-extension,
> > > ZVE32X.
> > >=20
> > > Most kernel/user interfaces requires minimum of ZVE32X. Thus, programs
> > > compiled and run with ZVE32X should be supported by the kernel on most
> > > aspects. This includes context-switch, signal, ptrace, prctl, and
> > > hwprobe.
> > >=20
> > > One exception is that ELF_HWCAP returns 'V' only if full V is support=
ed
> > > on the platform. This means that the system without a full V must not
> > > rely on ELF_HWCAP to tell whether it is allowable to execute Vector
> > > without first invoking a prctl() check.
> > >=20
> > > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > > Acked-by: Joel Granados <j.granados@samsung.com>
> >=20
> > I'm not sure that I like this patch to be honest. As far as I can tell,
> > every user here of has_vector(ext) is ZVE32X, so why bother actually
> > having an argument?
> >=20
> > Could we just document that has_vector() is just a tyre kick of "is
> > there a vector unit and are we allowed to use it", and anything
> > requiring more than the bare-minimum (so zve32x?)must explicitly check
> > for that form of vector using riscv_has_extension_[un]likely()?
> >=20
> > Finally, the in-kernel crypto stuff or other things that use
> > can_use_simd() to check for vector support - do they all function corre=
ctly
> > with all of the vector flavours? I don't understand the vector
> > extensions well enough to evaluate that - I know that they do check for
> > the individual extensions like Zvkb during probe but don't have anything
> > for the vector version (at least in the chacha20 and sha256 glue code).
> > If they don't, then we need to make sure those drivers do not probe with
> > the cut-down variants.
>=20
> As far as I know, none of the RISC-V vector crypto code has been tested w=
ith
> Zve* yet.  Currently it always checks for VLEN >=3D 128, which should exc=
lude most
> Zve* implementations.
>=20
> Currently it doesn't check for EEW >=3D 64, even though it sometimes assu=
mes that.
> It looks like a check for EEW >=3D 64 needs to be added in order to exclu=
de Zve32x
> and Zve32f implementations that don't support EEW =3D=3D 64.

Cool, glad I asked then :)

> If it would be useful to do so, we should be able to enable some of the c=
ode
> with a smaller VLEN and/or EEW once it has been tested in those configura=
tions.
> Some of it should work, but some of it won't be able to work.  (For examp=
le, the
> SHA512 instructions require EEW=3D=3D64.)
>=20
> Also note that currently all the RISC-V vector crypto code only supports =
riscv64
> (XLEN=3D64).  Similarly, that could be relaxed in the future if people re=
ally need
> the vector crypto acceleration on 32-bit CPUs...  But similarly, the code=
 would
> need to be revised and tested in that configuration.
>=20
> > Eric/Jerry (although read the previous paragraph too):
> > I noticed that the sha256 glue code calls crypto_simd_usable(), and in
> > turn may_use_simd() before kernel_vector_begin(). The chacha20 glue code
> > does not call either, which seems to violate the edict in
> > kernel_vector_begin()'s kerneldoc:
> > "Must not be called unless may_use_simd() returns true."
>=20
> skcipher algorithms can only be invoked in process and softirq context.  =
This
> differs from shash algorithms which can be invoked in any context.
>=20
> My understanding is that, like arm64, RISC-V always allows non-nested
> kernel-mode vector to be used in process and softirq context -- and in fa=
ct,
> this was intentionally done in order to support use cases like this.  So =
that's
> why the RISC-V skcipher algorithms don't check for may_use_simd() before =
calling
> kernel_vector_begin().

I see, thanks for explaining that. I think you should probably check
somewhere if has_vector() returns true in that driver though before
using vector instructions. Only checking vlen seems to me like relying on
an implementation detail and if we set vlen for the T-Head/0.7.1 vector
it'd be fooled. That said, I don't think that any of the 0.7.1 vector
systems actually support Zvkb, but I hope you get my drift.

Thanks,
Conor.

--caZE0P60wQJMi2ZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiFQIwAKCRB4tDGHoIJi
0gl8AQCH5jcR0fwp68BBBcX8uk063UxUZdEjt7Yt3nU+80K6GgEA64+MkNFk/ns9
57UBSy8tcN6JCY0eSgoJEzI8o/6y4gY=
=d1id
-----END PGP SIGNATURE-----

--caZE0P60wQJMi2ZH--

