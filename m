Return-Path: <linux-kselftest+bounces-8358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF4A8AA1FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 20:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7101C21881
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 18:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D5517A938;
	Thu, 18 Apr 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wuv8of7i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFB9171092;
	Thu, 18 Apr 2024 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464767; cv=none; b=WR+26tJVh2klfiZ+qHF+XyMVMTWfhlZmO80FbiJj9CUP6YZwOh5LhJBHBwJINvokKxwvGOnRDKZXL0PF3/eYkpg/wS2acWqiB4OrtpzSVpWwj1Z1Yihi0dUTH/ewY2BniakdciueZEl6dnE1GRDRISfjTm9nscu3ihAX/hNVfYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464767; c=relaxed/simple;
	bh=jJSVqc94KHjHtGaldg9rA0X/nfqPSRhxkh48X+1JcN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkPR1qMJeGqzVdmHvUCXqQT/Kr12bmmy4+6qbyINpk3Q7fSkS0aIpNJbsL66Nka4KStx1lX1xZJMT9f1VubpHe6CGF7C2chVItSLFQNm6lSjCuRzAkN338aMSzVPYtPPb1XzL4cZu96FtnqtBhCB6F4ZH7UxSJIBqUN4W5sVoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wuv8of7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F750C113CC;
	Thu, 18 Apr 2024 18:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713464766;
	bh=jJSVqc94KHjHtGaldg9rA0X/nfqPSRhxkh48X+1JcN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wuv8of7iIe0+Hmunz7Xbtss0bJZ0kvQ3Wm1XGJOpHxmWpnCQ0JLCt1J9giFiBivIq
	 99Hapu4A4vyz2FvxAxoQJNRxc7Adf6Q465om7I55gKIm1M9HWR2/lTFub56GFFOOOP
	 7SFKIiE0nv8xQNLm/9o2eM9ei7bZE5PRINMuTXqk4O8QeyNDwPG/v7cZxPQWaSD2cv
	 ntaTY8i/YvhocJc0uwFUZaM6EhitzdKuNU7Zc3qnY1V4hayqN8ezFSNpUwwwUI5nwx
	 0qGaH0/NiTQdr/Qf52AsYU7wBqNUllROFa8zr4E9urbmBIf6aSwqlesVeyHqkKWGiL
	 QHWc3Mx24mF9w==
Date: Thu, 18 Apr 2024 19:26:00 +0100
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
Message-ID: <20240418-sterling-sanding-d59c3b0a2aaa@spud>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-7-e0c45bb6b253@sifive.com>
 <20240418-brook-chili-4d3e61d1a55c@wendy>
 <20240418155256.GA2410@sol.localdomain>
 <20240418-ultimatum-yam-11de4b063b83@spud>
 <20240418173203.GA1081@sol.localdomain>
 <20240418173946.GB1081@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tkJ/AWA0BSRPKKvd"
Content-Disposition: inline
In-Reply-To: <20240418173946.GB1081@sol.localdomain>


--tkJ/AWA0BSRPKKvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 10:39:46AM -0700, Eric Biggers wrote:
> On Thu, Apr 18, 2024 at 10:32:03AM -0700, Eric Biggers wrote:
> > On Thu, Apr 18, 2024 at 05:53:55PM +0100, Conor Dooley wrote:
> > > > If it would be useful to do so, we should be able to enable some of=
 the code
> > > > with a smaller VLEN and/or EEW once it has been tested in those con=
figurations.
> > > > Some of it should work, but some of it won't be able to work.  (For=
 example, the
> > > > SHA512 instructions require EEW=3D=3D64.)
> > > >=20
> > > > Also note that currently all the RISC-V vector crypto code only sup=
ports riscv64
> > > > (XLEN=3D64).  Similarly, that could be relaxed in the future if peo=
ple really need
> > > > the vector crypto acceleration on 32-bit CPUs...  But similarly, th=
e code would
> > > > need to be revised and tested in that configuration.
> > > >=20
> > > > > Eric/Jerry (although read the previous paragraph too):
> > > > > I noticed that the sha256 glue code calls crypto_simd_usable(), a=
nd in
> > > > > turn may_use_simd() before kernel_vector_begin(). The chacha20 gl=
ue code
> > > > > does not call either, which seems to violate the edict in
> > > > > kernel_vector_begin()'s kerneldoc:
> > > > > "Must not be called unless may_use_simd() returns true."
> > > >=20
> > > > skcipher algorithms can only be invoked in process and softirq cont=
ext.  This
> > > > differs from shash algorithms which can be invoked in any context.
> > > >=20
> > > > My understanding is that, like arm64, RISC-V always allows non-nest=
ed
> > > > kernel-mode vector to be used in process and softirq context -- and=
 in fact,
> > > > this was intentionally done in order to support use cases like this=
=2E  So that's
> > > > why the RISC-V skcipher algorithms don't check for may_use_simd() b=
efore calling
> > > > kernel_vector_begin().
> > >=20
> > > I see, thanks for explaining that. I think you should probably check
> > > somewhere if has_vector() returns true in that driver though before
> > > using vector instructions. Only checking vlen seems to me like relyin=
g on
> > > an implementation detail and if we set vlen for the T-Head/0.7.1 vect=
or
> > > it'd be fooled. That said, I don't think that any of the 0.7.1 vector
> > > systems actually support Zvkb, but I hope you get my drift.
> >=20
> > All the algorithms check for at least one of the vector crypto extensio=
ns being
> > supported, for example Zvkb.  'if (riscv_isa_extension_available(NULL, =
ZVKB))'
> > should return whether the ratified version of Zvkb is supported, and li=
kewise
> > for the other vector crypto extensions.  The ratified version of the ve=
ctor
> > crypto extensions depends on the ratified version of the vector extensi=
on.

That's great if it does require that the version of the vector extension
must be standard. Higher quality spec than most if it does. But
"supported" in the context of riscv_isa_extension_available() means that
the hardware supports it (or set of harts), not that the currently
running kernel does. The Kconfig deps that must be met for the code to be
built at least mean the kernel is built with vector support, leaving only
"the kernel was built with vector support and the hardware supports vector
but for $reason the kernel refused to enable it".

I'm not sure if that final condition is actually possible with the system
ending up in a broken state, however - I'm not sure that we ever do turn
off access to the VPU at present (after we mark it usable), and if we do
it doesn't get reflected in has_vector() so the kernel and userspace would
both break, with what a crypto driver does probably being the least of
your worries.

> > So
> > there should be no issue.  If there is, the RISC-V core architecture co=
de needs
> > to be fixed to not declare that extensions are supported when they are =
actually
> > incompatible non-standard versions of those extensions.  Incompatible
> > non-standard extensions should be represented as separate extensions.
> >=20
>=20
> It probably makes sense to check has_vector() to exclude Zve* for now, th=
ough.

I think you might actually be better served at present, given the code can
only be built if the core vector code is, by using
riscv_isa_extension_available(NULL, v). That way you know for sure that
you're getting the ratified extension and nothing else.

Prior to this conversation I thought that has_vector() should return true
if there's a standard compliant vector unit available - given all users
Andy added only need Zve32x.

> I am just concerned about how you're suggesting that non-standard extensi=
ons
> might be pretending to be standard ones and individual users of kernel-mo=
de
> vector would need to work around that.

I am absolutely not suggesting that non-standard extensions should
masquerade as standard ones, I don't know where you got that from. What
I said was that a non-standard vector extension could reuse riscv_v_vlen
(and should IMO for simplicity reasons), not that any of the APIs we have
for checking extension availability would lie and say it was standard.
riscv_v_vlen having a value greater than 128 is not one of those APIs ;)

> I think that neither has_vector() nor
> 'if (riscv_isa_extension_available(NULL, ZVKB))' should return true if th=
e CPU's
> vector extension is non-standard.

riscv_isa_extension_available(NULL, ZVKB) only checks whether the extension
was present in DT or ACPI for all harts. It doesn't check whether or not
the required config option for vector has been set or anything related
to dependencies. has_vector() at least checks that the vector core has
been enabled (and uses the alternative-patched version of the check
given it is used in some hotter paths). That's kinda moot for code
that's only built if the vector core stuff is enabled as I said above
though.

We could of course make riscv_isa_extension_available() check
extension dependencies, but I'd rather leave dt validation to the dt
tooling (apparently ACPI tables are never wrong...). Either would allow
you to rely on the crypto extensions present only when the standard vector
extensions unless someone's DT/ACPI stuff is shite, but then they keep the
pieces IMO :)

Hope that makes sense?
Conor.

--tkJ/AWA0BSRPKKvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiFltwAKCRB4tDGHoIJi
0k9hAPwKt4EVSg6SaOTnlI7TceZN+Z+n3i3qZFvsiIU+lIrRFAD9F+aMoAw8/znh
tvOTi6cCOtKaUz/zNyE81e7QV1nC+AY=
=NmBX
-----END PGP SIGNATURE-----

--tkJ/AWA0BSRPKKvd--

