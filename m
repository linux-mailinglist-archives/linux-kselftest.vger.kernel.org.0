Return-Path: <linux-kselftest+bounces-9129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F718B74C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 13:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C34281217
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84130132808;
	Tue, 30 Apr 2024 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A25zNcBP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4215AAA4;
	Tue, 30 Apr 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477526; cv=none; b=lCkTVzdahBfJus+cBsuFHubo10n0TtTHIJeHIZKumTaNaPPvTpgEST8kUSsspd6iW7Ebl32DwQMzrADlnzYXTQ+kJyvpHCqeGcCGbjKNZLnDD1InduSezKssHxhE5K+YwZcRExWJZB0JVmv0omK6KNLDAapSzdk22iXAPtdc/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477526; c=relaxed/simple;
	bh=fHd/tvgknZmDQ1B+dKw15+R47eqN73inFJLNupe/g1s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA/PFD3R8JoYdeASZQzBoBwSIjymw11vSZtgVu6dq26EmR9m371G+ekj/IEnXBgC2mwK6+SeXlQNnqGGgPHHm1f64PlfDjDIJPGa99zrVYO709hhgAFEhBOoSQLzHoYZTJ8jKKXBKN2mx6GbqN8Hy4RkXMk801OTZio0RNqVqjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A25zNcBP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714477524; x=1746013524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fHd/tvgknZmDQ1B+dKw15+R47eqN73inFJLNupe/g1s=;
  b=A25zNcBPz5slS+g+28gjb5qbg+h28Q5qBrTNou6vSMHIM+rsq9nPmLaN
   BDMceGe5qICILFvTb7eGU555TFRWpABws4BEXnyWFQA1S7yX5Ao000Pf6
   lRWquYf79ym7aj5Ewkzo1/DpsTOOZVeDeXxKTpbBjthxl0VcEXLzMW7e6
   eefnSYWtD/k9JgJdebKOUe4SMK3Wsn6IaHzq8Igb8cCYDj9H1gIHNmYp9
   7x5TQwYH8QAePViA7kCTKh8o0S2nDjwypczQ0zRuFzkj/beGsq8hkK7Ow
   mfG1TvbfnPmiwBhF+afQC8Yl9LOmtigQnAV/vyuLO3RCHVa45emsJlb8d
   w==;
X-CSE-ConnectionGUID: rJqdjKizQQ68Np9QZCjhLw==
X-CSE-MsgGUID: kyLwJnyCT2SNMFyBqjKUEg==
X-IronPort-AV: E=Sophos;i="6.07,242,1708412400"; 
   d="asc'?scan'208";a="190592988"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Apr 2024 04:45:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 04:44:50 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 30 Apr 2024 04:44:47 -0700
Date: Tue, 30 Apr 2024 12:44:30 +0100
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
Subject: Re: [PATCH v4 02/11] riscv: add ISA extensions validation
Message-ID: <20240430-payable-famished-6711765d5ca4@wendy>
References: <20240429150553.625165-1-cleger@rivosinc.com>
 <20240429150553.625165-3-cleger@rivosinc.com>
 <20240429-subtext-tabby-3a1532f058a5@spud>
 <5d5febd5-d113-4e8c-9535-9e75acf23398@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o3hC9HS35D3JsI9f"
Content-Disposition: inline
In-Reply-To: <5d5febd5-d113-4e8c-9535-9e75acf23398@rivosinc.com>

--o3hC9HS35D3JsI9f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 09:18:47AM +0200, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 30/04/2024 00:15, Conor Dooley wrote:
> > On Mon, Apr 29, 2024 at 05:04:55PM +0200, Cl=E9ment L=E9ger wrote:
> >> Since a few extensions (Zicbom/Zicboz) already needs validation and
> >> future ones will need it as well (Zc*) add a validate() callback to
> >> struct riscv_isa_ext_data. This require to rework the way extensions a=
re
> >> parsed and split it in two phases. First phase is isa string or isa
> >> extension list parsing and consists in enabling all the extensions in a
> >> temporary bitmask without any validation. The second step "resolves" t=
he
> >> final isa bitmap, handling potential missing dependencies. The mechani=
sm
> >> is quite simple and simply validate each extension described in the
> >> temporary bitmap before enabling it in the final isa bitmap. validate()
> >> callbacks can return either 0 for success, -EPROBEDEFER if extension
> >> needs to be validated again at next loop. A previous ISA bitmap is kept
> >> to avoid looping mutliple times if an extension dependencies are never
> >> satisfied until we reach a stable state. In order to avoid any potenti=
al
> >> infinite looping, allow looping a maximum of the number of extension we
> >> handle. Zicboz and Zicbom extensions are modified to use this validati=
on
> >> mechanism.
> >=20
> > Your reply to my last review only talked about part of my comments,
> > which is usually what you do when you're gonna implement the rest, but
> > you haven't.
> > I like the change you've made to shorten looping, but I'd at least like
> > a response to why a split is not worth doing :)
>=20
> Hi Conor,
>=20
> Missed that point since I was feeling that my solution actually
> addresses your concerns. Your argument was that there is no reason to
> loop for Zicbom/Zicboz but that would also apply to Zcf in case we are
> on RV64 as well (since zcf is not supported on RV64). So for Zcf, that
> would lead to using both mecanism or additional ifdefery with little to
> no added value since the current solution actually solves both cases:
>=20
> - We don't have any extra looping if all validation callback returns 0
> (except the initial one on riscv_isa_ext, which is kind of unavoidable).
> - Zicbom, Zicboz callbacks will be called only once (which was one of
> your concern).
>=20
> Adding a second kind of callback for after loop validation would only
> lead to a bunch of additional macros/ifdefery for extensions with
> validate() callback, with validate_end() or with both (ie Zcf)). For
> these reasons, I do not think there is a need for a separate mechanism
> nor additional callback for such extensions except adding extra code
> with no real added functionality.
>=20
> AFAIK, the platform driver probing mechanism works the same, the probe()
> callback is actually called even if for some reason properties are
> missing from nodes for platform devices and thus the probe() returns
> -EINVAL or whatever.
>=20
> Hope this answers your question,

Yeah, pretty much I am happy with just an "it's not worth doing it"
response. Given it wasn't your first choice, I doubt you're overly happy
with it either, but I really would like to avoid looping to closure to
sort out dependencies - particularly on the boot CPU before we bring
anyone else up, but if the code is now more proactive about breaking
out, I suppose that'll have to do :)
I kinda wish we didn't do this at all, but I think we've brought this
upon ourselves via hwprobe. I'm still on the fence as to whether things
that are implied need to be handled in this way. I think I'll bring this
up tomorrow at the weekly call, because so far it's only been you and I
discussing this really and it's a policy decision that hwprobe-ists
should be involved in I think.

Implied extensions aside, I think we will eventually need this stuff
anyway, for extensions that make no sense to consider if a config option
for a dependency is disabled.
=46rom talking to Eric Biggers the other week about
riscv_isa_extension_available() I'm of the opinion that we need to do
better with that interface w.r.t. extension and config dependencies,
and what seems like a good idea to me at the moment is putting tests for
IS_ENABLED(RISCV_ISA_FOO) into these validate hooks.

I'll try to look at the actual implementation here tomorrow.

Cheers,
Conor.

--o3hC9HS35D3JsI9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjDZngAKCRB4tDGHoIJi
0jaXAQDZLEWybBZ6OTc/u2wI/xhLxITFoBF1IWTZ2CPcg9nOugD/e972YLWSGflR
ZM//z1//gOap3OewaAJgMnP4nvYeEA4=
=U5u8
-----END PGP SIGNATURE-----

--o3hC9HS35D3JsI9f--

