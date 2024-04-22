Return-Path: <linux-kselftest+bounces-8608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A1C8ACBE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 13:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB231F24FE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 11:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22009146D63;
	Mon, 22 Apr 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mQfEvkLr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95794146A67;
	Mon, 22 Apr 2024 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784821; cv=none; b=s4nigzF3pXf2t8XyX83TRndXvcPoRzIp5C/zDMVgyW89wtAEcJsVBbHep9N8SDqcjBiD3b6s7Zol2RuYov+JYdnikNfE8/X78X2ScLIL6S/X7GwqT5YZHHI/+BSrCKPsI2ztLG/ueWPFHnVPOYARCqofOqvP0uzKk9J/UaqiFp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784821; c=relaxed/simple;
	bh=XRSUgOnTV4XErsz5ecolHV/4A/hQBybGq5GAfiFEyPU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z22DhJ7PbHmFvYqkYxMwcgGXqn/RXFyvKIbirv9XyFeWDpmU/5yeEsaMdA6VLqC1QJHeKNiOoFmqYLK6LeosyIe4dEMfsZcl5WIphSN1NoI2x5JJ9voF4DmKto6Le3l74+PsoyfJtmcU3z0U7bGvhDVEpJJR72fhMM49E+gcoDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mQfEvkLr; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713784818; x=1745320818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XRSUgOnTV4XErsz5ecolHV/4A/hQBybGq5GAfiFEyPU=;
  b=mQfEvkLrzi65g25hLMnQZ5MfSMj887CCw48xfc/wKNVKYoG0NH5pdrYj
   aPVVFt/EAZPCWsRT5WlR/zuQHpW3gpHydtpWyfRsq560h14HcAFvcpqzj
   lRH/iqnzLYWL7gOEnwX2Dm3czQijm5uCbS+7++vSomdaiSvlR+bNIIm6f
   imzAKxMizDDSUrPM5b7L+LUV5P1UkhkljsYyKwd5wHX4yQNpGXq79OcyF
   3rjD6ZiTIwV4fOPFiO2RZccHh8HPbnxwpNEEqh6ztwRZQA+kR8K0QFJuF
   yBvq5S5JT5dTk/C8stt1j4eNtomfYQeFQvrCZAmvadvpG/sFfWWvR8PSF
   w==;
X-CSE-ConnectionGUID: EwlQHltERQKVoL1uwoRBeA==
X-CSE-MsgGUID: nEu1AlljSHG4Ko1fQpekdA==
X-IronPort-AV: E=Sophos;i="6.07,220,1708412400"; 
   d="asc'?scan'208";a="22052345"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2024 04:20:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 04:19:55 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 22 Apr 2024 04:19:52 -0700
Date: Mon, 22 Apr 2024 12:19:36 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
CC: Conor Dooley <conor@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Anup Patel
	<anup@brainfault.org>, Shuah Khan <shuah@kernel.org>, Atish Patra
	<atishp@atishpatra.org>, <linux-doc@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <kvm@vger.kernel.org>,
	<kvm-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 03/12] dt-bindings: riscv: add Zc* extension rules
 implied by C extension
Message-ID: <20240422-stumbling-aliens-b408eebe1f32@wendy>
References: <20240418124300.1387978-1-cleger@rivosinc.com>
 <20240418124300.1387978-4-cleger@rivosinc.com>
 <20240419-blinked-timid-da722ec6ddc4@spud>
 <f89c79f7-a09e-4fcf-8e16-0875202ade4a@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="poViDq5TvQtnA831"
Content-Disposition: inline
In-Reply-To: <f89c79f7-a09e-4fcf-8e16-0875202ade4a@rivosinc.com>

--poViDq5TvQtnA831
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 10:53:04AM +0200, Cl=E9ment L=E9ger wrote:
> On 19/04/2024 17:49, Conor Dooley wrote:
> > On Thu, Apr 18, 2024 at 02:42:26PM +0200, Cl=E9ment L=E9ger wrote:
> >> As stated by Zc* spec:
> >>
> >> "As C defines the same instructions as Zca, Zcf and Zcd, the rule is t=
hat:
> >>  - C always implies Zca
> >>  - C+F implies Zcf (RV32 only)
> >>  - C+D implies Zcd"
> >>
> >> Add additionnal validation rules to enforce this in dts.
> >=20
> > I'll get it out of the way: NAK, and the dts patch is the perfect
> > example of why. I don't want us to have to continually update
> > devicetrees. If these are implied due to being subsets of other
> > extensions, then software should be able to enable them when that
> > other extension is present.
>=20
> Acked.
>=20
> >=20
> > My fear is that, and a quick look at the "add probing" commit seemed to
> > confirm it, new subsets would require updates to the dts, even though
> > the existing extension is perfectly sufficient to determine presence.
> >=20
> > I definitely want to avoid continual updates to the devicetree for churn
> > reasons whenever subsets are added, but not turning on the likes of Zca
> > when C is present because "the bindings were updated to enforce this"
> > is a complete blocker. I do concede that having two parents makes that
> > more difficult and will likely require some changes to how we probe - do
> > we need to have a "second round" type thing?
>=20
> Yeah, I understand. At first, I actually did the modifications in the
> ISA probing loop with some dependency probing (ie loop while we don't
> have a stable extension state). But I thought that it was not actually
> our problem but rather the ISA string provider. For instance, Qemu
> provides them.


A newer version of QEMU might, but not all do, so I'm not sure that using
it is a good example. My expectations is that a devicetree will be written
to the standards of the day and not be updated as subsets are released.

If this were the first instance of a superset/bundle I'd be prepared to
accept an argument that we should not infer anything - but it's not and
we'd be introducing inconsistency with the crypto stuff. I know that both
scenarios are different in terms of extension history given that this is
splitting things into a subset and that was a superset/bundle created at
the same time, but they're not really that different in terms of the
DT/ACPI to user "interface".

> > Taking Zcf as an example, maybe something like making both of C and F i=
nto
> > "standard" supersets and adding a case to riscv_isa_extension_check()
> > that would mandate that Zca and F are enabled before enabling it, and we
> > would ensure that C implies Zca before it implies Zcf?
>=20
> I'm afraid that riscv_isa_extension_check() will become a rat nest so
> rather than going that way, I would be in favor of adding a validation
> callback for the extensions if needed.

IOW, extension check split out per extension moving to be a callback?

> > Given we'd be relying on ordering, we have to perform the same implicat=
ion
> > for both F and C and make sure that the "implies" struct has Zca before=
 Zcf.
> > I don't really like that suggestion, hopefully there's a nicer way of d=
oing
> > that, but I don't like the dt stuff here.
>=20
> I guess the "cleanest" way would be to have some "defered-like"
> mechanism in ISA probing which would allow to handle ordering as well as
> dependencies/implies for extensions. For Zca, Zcf, we actually do not
> have ordering problems but I think it would be a bit broken not to
> support that as well.

We could, I suppose, enable all detected extensions on a CPU and run the
aforemention callback, disabling them if conditions are not met?

Is that something like what you're suggesting?

--poViDq5TvQtnA831
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiZHyAAKCRB4tDGHoIJi
0rO4AP0QdAfLNIEXKBuCIoQC9LRKn1TSnfbXrn8RTgLezI5EdwD/T7Y7u53/krkw
V1xB2TSmkQhvtE4QZxoxvt3Mk5aKWwA=
=Pef2
-----END PGP SIGNATURE-----

--poViDq5TvQtnA831--

