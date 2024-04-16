Return-Path: <linux-kselftest+bounces-8164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3488A6F18
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBCDB22D8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FFD12F58A;
	Tue, 16 Apr 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEtD5pH9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60812DD95;
	Tue, 16 Apr 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279278; cv=none; b=cZr5f2QER4b0uU8/8C+UVRVMP+r/1VjKj0twBMLBrHw/IVTBoMMoYY6O+WUsK9I5lmRAChEwlFXKNjmMTSFAWEDk1eqsztmdNzgQckHiQhtb1H4Kw2fZVpD3GH209cKb3XBWRm4MwsWD6jyMvmXf7JTX6VY/aFe0qFy+ZyKdmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279278; c=relaxed/simple;
	bh=Ky37z6+ib9PoHukGJLoU7Q3WV2IiY+rxAfk1Wn5VtXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc/Bnd05bTi+qix6TpAXfrNOqFEVqmQ0cON4HupJ/f/lFtZI7ZiaXyHZyvKwQPKffET5AHI7uxknR9AjUBqg3J1N02yVZOPyd4xDvAEtn/jxit4oZvqSZhl9JV/7gKjHmPHZ9joJRYuZUgukzfCSwIuWTfZjcC1jM8nUac4K94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEtD5pH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32502C113CE;
	Tue, 16 Apr 2024 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713279277;
	bh=Ky37z6+ib9PoHukGJLoU7Q3WV2IiY+rxAfk1Wn5VtXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEtD5pH9wGVvkTiTrN/Zv2kB3piFiOp8GLYBuZ4Qvza0csKCqdYE+T3XNrOkZjcDc
	 xLdcPJG/CY+e52NYakI14kcCBLgoFt4AC7dD13hoHCIYKPPMgiadW7sCMUb2+3f51T
	 Uh5lw6yh263zVY9j1V2bdrYKM8Z3hsKoibYhJehcBQi5CVj2ortZ3LUbKSZyi+qPkh
	 fWP2aQd4lM7J9clMqP5DvtTkwtiOuHZ66G937Na1DSHjmW9tjeRkAT+T2hHadeJdVQ
	 m3vTMM9KI0jjLuhJMk74BB1SDedHpANEBwdIUJW+fw+awljjiGKv2V+RLXB1Q+23H2
	 KyWk2I4BCHAqA==
Date: Tue, 16 Apr 2024 15:54:32 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Deepak Gupta <debug@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 07/10] riscv: add ISA extension parsing for Zcmop
Message-ID: <20240416-gave-apron-3234098ce416@spud>
References: <20240410091106.749233-8-cleger@rivosinc.com>
 <ZhcFeVYUQJmBAKuv@debug.ba.rivosinc.com>
 <20240410-jawless-cavalry-a3eaf9c562a4@spud>
 <20240410-judgingly-appease-5df493852b70@spud>
 <ZhcTiakvfbjb2hon@debug.ba.rivosinc.com>
 <1287e6e9-cb8e-4a78-9195-ce29f1c4bace@rivosinc.com>
 <20240411-superglue-errant-b32e5118695f@wendy>
 <c86f9fa8-e273-4509-83fa-f21d3265d5c9@rivosinc.com>
 <20240411-backwater-opal-00c9aed2231e@wendy>
 <5eda3278-24bc-4c17-a741-523ad5ff79f7@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o4oWfyukzOIBXo40"
Content-Disposition: inline
In-Reply-To: <5eda3278-24bc-4c17-a741-523ad5ff79f7@rivosinc.com>


--o4oWfyukzOIBXo40
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:10:24AM +0200, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 11/04/2024 13:53, Conor Dooley wrote:
> > On Thu, Apr 11, 2024 at 11:08:21AM +0200, Cl=E9ment L=E9ger wrote:
> >>>> If we consider to have potentially broken isa string (ie extensions
> >>>> dependencies not correctly handled), then we'll need some way to
> >>>> validate this within the kernel.
> >>>
> >>> No, the DT passed to the kernel should be correct and we by and large=
 we
> >>> should not have to do validation of it. What I meant above was writing
> >>> the binding so that something invalid will not pass dtbs_check.
> >>
> >> Acked, I was mainly answering Deepak question about dependencies wrt to
> >> using __RISCV_ISA_EXT_SUPERSET() which does not seems to be relevant
> >> since we expect a correct isa string to be passed.
> >=20
> > Ahh, okay.
> >=20
> >> But as you stated, DT
> >> validation clearly make sense. I think a lot of extensions strings wou=
ld
> >> benefit such support (All the Zv* depends on V, etc).
> >=20
> > I think it is actually as simple something like this, which makes it
> > invalid to have "d" without "f":
> >=20
> > | diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml =
b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > | index 468c646247aa..594828700cbe 100644
> > | --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > | +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > | @@ -484,5 +484,20 @@ properties:
> > |              Registers in the AX45MP datasheet.
> > |              https://www.andestech.com/wp-content/uploads/AX45MP-1C-R=
ev.-5.0.0-Datasheet.pdf
> > | =20
> > | +allOf:
> > | +  - if:
> > | +      properties:
> > | +        riscv,isa-extensions:
> > | +          contains:
> > | +            const: "d"
> > | +          not:
> > | +            contains:
> > | +              const: "f"
> > | +    then:
> > | +      properties:
> > | +        riscv,isa-extensions:
> > | +          false
> > | +
> > | +
> > |  additionalProperties: true
> > |  ...
> >=20
> > If you do have d without f, the checker will say:
> > cpu@2: riscv,isa-extensions: False schema does not allow ['i', 'm', 'a'=
, 'd', 'c']
> >=20
> > At least that's readable, even though not clear about what to do. I wish
>=20
> That looks really readable indeed but the messages that result from
> errors are not so informative.
>=20
> It tried playing with various constructs and found this one to yield a
> comprehensive message:
>=20
> +allOf:
> +  - if:
> +      properties:
> +        riscv,isa-extensions:
> +          contains:
> +            const: zcf
> +          not:
> +            contains:
> +              const: zca
> +    then:
> +      properties:
> +        riscv,isa-extensions:
> +          items:
> +            anyOf:
> +              - const: zca
>=20
> arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dtb: cpu@0:
> riscv,isa-extensions:10: 'anyOf' conditional failed, one must be fixed:
>         'zca' was expected
>         from schema $id: http://devicetree.org/schemas/riscv/extensions.y=
aml
>=20
> Even though dt-bindings-check passed, not sure if this is totally a
> valid construct though...

I asked Rob about this yesterday, he suggested adding:
riscv,isa-extensions:
  if:
    contains:
      const: zcf
  then:
    contains:
      const: zca
to the existing property, not in an allOf. I think that is by far the
most readable version in terms of what goes into the binding. The output
would look like:
cpu@0: riscv,isa-extensions: ['i', 'm', 'a', 'd', 'c'] does not contain ite=
ms matching the given schema
(for d requiring f cos I am lazy)

Also, his comment about your one that gives the nice message was that it
would wrong as the anyOf was pointless and it says all items must be
"zca". I didn't try it, but I have a feeling your nice output will be
rather less nice if several different deps are unmet - but hey, probably
will still be better than having an undocumented extension!


--o4oWfyukzOIBXo40
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh6RJwAKCRB4tDGHoIJi
0gKiAPwO95yHRMreVZI1sGkG9R4vNU1EfJdXv3oNOqMEeB8Z7wEA/fI5rZ01fYH6
ZiMSKf0BThc7H4AEo7Lo2lqLwVoBngw=
=iSce
-----END PGP SIGNATURE-----

--o4oWfyukzOIBXo40--

