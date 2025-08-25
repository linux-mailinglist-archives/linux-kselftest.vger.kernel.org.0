Return-Path: <linux-kselftest+bounces-39862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3AB34736
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 18:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319E32A4D58
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A963002A9;
	Mon, 25 Aug 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuZQedcg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23111713;
	Mon, 25 Aug 2025 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139023; cv=none; b=fZeN5KU9FQHQdGtKQd4z+41HPsrzinnRfDZTP3aCJnoeIpcdAyXaAyijMfXtQwOwcMIJrxXcQgwU/0f6av5w/9AtlmBjmStRukJfkL+kWblRt0a2CkidDugW/FaxWQERujq1MjxJpSNQfXYS4n0N267ZbL8HW6n3p1cw8eA6nV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139023; c=relaxed/simple;
	bh=KgpIyi6RAg5MAXdti7zU0f2hj8RJXYvhBuIqG1e+0CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7qDhJcZIBfVPzXSu/dG60hK0wJ7SLrorqbmvcFiunQkGyNdyCB3EUCvsYvHiXydfj+hjbnhF02Wre3rZrWrWG6GIfZNmvmOwAHN17y1fehoZnYSmarbbKURxkHGm5xB9C4A+Kkflvr6d6eVzQ6/8nvO+THLwoefrQ/SBCVspNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuZQedcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09423C4CEED;
	Mon, 25 Aug 2025 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139022;
	bh=KgpIyi6RAg5MAXdti7zU0f2hj8RJXYvhBuIqG1e+0CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuZQedcg1Zp25ehlMzicSD+8IdnsfbE4M/4qDW+GBk9ac9z4eDU7QA6R5eTSxBxbe
	 IFjDzU/5VAjaY7v9KqbVmjsEbZWtdaSccRasiAxWh7JdLtkj+ykHU+0OaB9UTDfEgW
	 8v3PFGD7ukTKEdGiWSqbat61DdJsQ9rU/FEmZLPNkKxQDhf/heHdagLNykxupDCCSm
	 3lu7uf5m1eR2ji0UUJezLjeh0pDx9h8qfk1AU2OFNwyw+HTJPTewAnEGi434B1V6Br
	 p9w1zuysufJvFxZwXfaIKGYzFCI2xiznEsqSR8PVd5faWmyVnMEqXjwtewDrGZOMx5
	 kCya4XmM0eXwQ==
Date: Mon, 25 Aug 2025 17:23:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anup@brainfault.org, pbonzini@redhat.com,
	shuah@kernel.org, cyan.yang@sifive.com, cleger@rivosinc.com,
	charlie@rivosinc.com, cuiyunhui@bytedance.com,
	samuel.holland@sifive.com, namcao@linutronix.de, jesse@rivosinc.com,
	inochiama@gmail.com, yongxuan.wang@sifive.com,
	ajones@ventanamicro.com, parri.andrea@gmail.com,
	mikisabate@gmail.com, yikming2222@gmail.com,
	thomas.weissschuh@linutronix.de, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 RESEND 1/5] dt-bidings: riscv: add Zilsd and Zclsd
 extension descriptions
Message-ID: <20250825-clang-husband-bcb5defdb5f3@spud>
References: <20250821140131.225756-1-pincheng.plct@isrc.iscas.ac.cn>
 <20250821140131.225756-2-pincheng.plct@isrc.iscas.ac.cn>
 <20250822-purge-doubling-f38988284db1@spud>
 <a2cc4cbe-82ca-4a89-b623-73721a1f3baf@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="przAQh4lUz2Eomq/"
Content-Disposition: inline
In-Reply-To: <a2cc4cbe-82ca-4a89-b623-73721a1f3baf@isrc.iscas.ac.cn>


--przAQh4lUz2Eomq/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:26:13PM +0800, Pincheng Wang wrote:
> On 2025/8/23 0:33, Conor Dooley wrote:
> > On Thu, Aug 21, 2025 at 10:01:27PM +0800, Pincheng Wang wrote:
> > > Add descriptions for the Zilsd (Load/Store pair instructions) and
> > > Zclsd (Compressed Load/Store pair instructions) ISA extensions
> > > which were ratified in commit f88abf1 ("Integrating load/store
> > > pair for RV32 with the main manual") of the riscv-isa-manual.
> > >=20
> > > Signed-off-by: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
> > > ---
> > >   .../devicetree/bindings/riscv/extensions.yaml | 39 ++++++++++++++++=
+++
> > >   1 file changed, 39 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml =
b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > index ede6a58ccf53..d72ffe8f6fa7 100644
> > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > @@ -366,6 +366,20 @@ properties:
> > >               guarantee on LR/SC sequences, as ratified in commit b1d=
806605f87
> > >               ("Updated to ratified state.") of the riscv profiles sp=
ecification.
> > > +        - const: zilsd
> > > +          description:
> > > +            The standard Zilsd extension which provides support for =
aligned
> > > +            register-pair load and store operations in 32-bit instru=
ction
> > > +            encodings, as ratified in commit f88abf1 ("Integrating
> > > +            load/store pair for RV32 with the main manual") of riscv=
-isa-manual.
> > > +
> > > +        - const: zclsd
> > > +          description:
> > > +            The Zclsd extension implements the compressed (16-bit) v=
ersion of the
> > > +            Load/Store Pair for RV32. As with Zilsd, this extension =
was ratified
> > > +            in commit f88abf1 ("Integrating load/store pair for RV32=
 with the
> > > +            main manual") of riscv-isa-manual.
> > > +
> > >           - const: zk
> > >             description:
> > >               The standard Zk Standard Scalar cryptography extension =
as ratified
> > > @@ -847,6 +861,16 @@ properties:
> > >               anyOf:
> > >                 - const: v
> > >                 - const: zve32x
> > > +      # Zclsd depends on Zilsd and Zca
> > > +      - if:
> > > +          contains:
> > > +            anyOf:
> > > +              - const: zclsd
> > > +        then:
> > > +          contains:
> > > +            anyOf:
> > > +              - const: zilsd
> > > +              - const: zca
> > >   allOf:
> > >     # Zcf extension does not exist on rv64
> > > @@ -864,6 +888,21 @@ allOf:
> > >             not:
> > >               contains:
> > >                 const: zcf
> > > +  # Zilsd extension does not exist on rv64
> > > +  - if:
> > > +      properties:
> >=20
> > > +        riscv,isa-extensions:
> > > +          contains:
> > > +            const: zilsd
> >=20
> > This syntax is odd, it shouldn't be required to have zilsd in here and
> > in the then. Did you copy this from Zcf or come up with it yourself
> > because it didn't work otherwise?
> >=20
>=20
> Yes, I did model this after the existing Zcf constraint in the same file.
> The structure is nearly identical: cheking for presence of the extension =
and
> rv64i, then forbidding it in the "then" branch.
>=20
> I've tested confirmed that removing the "contains: const: zilsd" from the
> "if" condition still correctly enforces that zilsd must not appear when
> rv64i is present. The "then" clause with "not: contains" is sufficient.
>=20
> Given that the validation behavior is equivalent, but the logic is cleaner
> and less redundant without the extra "contains", would you recommend
> updating it to the simpler form:
>=20
>     - if:
>         properties:
>           riscv,isa-base:
>             contains:
>               const: rv64i
>       then:
>         properties:
>           riscv,isa-extensions:
>             not:
>               contains:
>                 const: zilsd
>=20
> If so, I'll update it in the next revision.

Yeah, please reduce it to this form.

--przAQh4lUz2Eomq/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKyOBgAKCRB4tDGHoIJi
0tBmAPwITOW6B962WAfPzymCU4z9xZ51B5BtYVuDFIxypRRcogD/bJcgHnZ/rI15
6Mdyko1A6Tb+pZvgrrtqkICniCrQogc=
=3Dwx
-----END PGP SIGNATURE-----

--przAQh4lUz2Eomq/--

