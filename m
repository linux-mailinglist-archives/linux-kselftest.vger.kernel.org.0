Return-Path: <linux-kselftest+bounces-8097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5406C8A6541
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 09:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBF7284171
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 07:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30E17FBC6;
	Tue, 16 Apr 2024 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ffkhviKU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72A71B50;
	Tue, 16 Apr 2024 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253097; cv=none; b=pZl+zZ4AQugq6FEXohn4b7fICuKCHk9vPL9YOyQhpA3B9AOQHybefA6u99amlk3GCuqK4iZGYqyiAGrTtFdFwTM5hWQlFfMnZmcOVCe8xXGB8SYzYTOrMF6U8rV05JJoZZJokLjwPGBh0BouPdrw7DGI40APvmyghit8YqOI9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253097; c=relaxed/simple;
	bh=x5lugkkuTzZRflrDEuf9ADF8MPGbuJ8c7gc3ccW/M98=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrqWVHaOiGPO7fqcVZAeItq5wHWRaNmHwD5BMctGozvtjHPxJNj7QrzprPONpvoQ3iedQoKK1SHariu8e/RfxEKNxfXrQ1rWk88ufwlGXiVBX8M8HqM23yEyfYSln0GYraCQnAA63vmi4eo0unM1CCdpOdo3Zsqg8GDOg+kGicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ffkhviKU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713253095; x=1744789095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x5lugkkuTzZRflrDEuf9ADF8MPGbuJ8c7gc3ccW/M98=;
  b=ffkhviKUAXUiuThSZ/tx29uQArlrjZFAD6ATYNjVEoxvac3g+66r9l7T
   oUrR5m3pyB58wq5a+tUEXqrdtvxw2ntFN7B1lx7owY9qXwd2YvZzQKYub
   M7TVs1DPW9EBFDoeO8ns02UiPHUocA+nRschigTr9ReBRIzRQ51A2N182
   2iMNF+KAe0Cb3yIKVILn5yKBBlnH7OtHE8oWxgfYfe0znRuhLflaQkzHa
   6yOBXWvCl1U6OmGJkcRXGZ3TPK0NseMZkhe5HQvOOsyv2SwvRMrH7yZQE
   N6Nn2NLhCTtJJAfLWNVvI17PtTD1/TxNopz9zaTnt2VnYwJvA1A4iAB/v
   g==;
X-CSE-ConnectionGUID: 61Rrqh/nSVOeoxSPEgjDLA==
X-CSE-MsgGUID: Y9MCszL3RR+vu36uIQGM/A==
X-IronPort-AV: E=Sophos;i="6.07,205,1708412400"; 
   d="asc'?scan'208";a="21182016"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 00:38:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 00:37:29 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Apr 2024 00:37:25 -0700
Date: Tue, 16 Apr 2024 08:36:33 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Evan Green
	<evan@rivosinc.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?=
	<cleger@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<shuah@kernel.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Palmer Dabbelt
	<palmer@rivosinc.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 02/19] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <20240416-husband-flavored-96c1dad58b6e@wendy>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-2-4af9815ec746@rivosinc.com>
 <20240412-tuesday-resident-d9d07e75463c@wendy>
 <ZhlrdGXfSushUNTp@ghost>
 <20240412-eastcoast-disparity-9c9e7d178df5@spud>
 <ZhmeLoPS+tsfqv1T@ghost>
 <20240412-chemist-haunt-0a30a8f280ca@spud>
 <ZhmoPuoR00aS6qZp@ghost>
 <20240413-sharper-unlivable-5a65660b19e2@spud>
 <Zh3xrTfjjk3b4GHb@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S0aAJ0pL4KXiXwbM"
Content-Disposition: inline
In-Reply-To: <Zh3xrTfjjk3b4GHb@ghost>

--S0aAJ0pL4KXiXwbM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 08:34:05PM -0700, Charlie Jenkins wrote:
> On Sat, Apr 13, 2024 at 12:40:26AM +0100, Conor Dooley wrote:
> > On Fri, Apr 12, 2024 at 02:31:42PM -0700, Charlie Jenkins wrote:
> > > On Fri, Apr 12, 2024 at 10:27:47PM +0100, Conor Dooley wrote:
> > > > On Fri, Apr 12, 2024 at 01:48:46PM -0700, Charlie Jenkins wrote:
> > > > > On Fri, Apr 12, 2024 at 07:47:48PM +0100, Conor Dooley wrote:
> > > > > > On Fri, Apr 12, 2024 at 10:12:20AM -0700, Charlie Jenkins wrote:
> >=20
> > > > > > > This is already falling back on the boot CPU, but that is not=
 a solution
> > > > > > > that scales. Even though all systems currently have homogenous
> > > > > > > marchid/mvendorid I am hesitant to assert that all systems are
> > > > > > > homogenous without providing an option to override this.
> > > > > >=20
> > > > > > There are already is an option. Use the non-deprecated property=
 in your
> > > > > > new system for describing what extesions you support. We don't =
need to
> > > > > > add any more properties (for now at least).
> > > > >=20
> > > > > The issue is that it is not possible to know which vendor extensi=
ons are
> > > > > associated with a vendor. That requires a global namespace where =
each
> > > > > extension can be looked up in a table. I have opted to have a
> > > > > vendor-specific namespace so that vendors don't have to worry abo=
ut
> > > > > stepping on other vendor's toes (or the other way around). In ord=
er to
> > > > > support that, the vendorid of the hart needs to be known prior.
> > > >=20
> > > > Nah, I think you're mixing up something like hwprobe and having
> > > > namespaces there with needing namespacing on the devicetree probing=
 side
> > > > too. You don't need any vendor namespacing, it's perfectly fine (IM=
O)
> > > > for a vendor to implement someone else's extension and I think we s=
hould
> > > > allow probing any vendors extension on any CPU.
> > >=20
> > > I am not mixing it up. Sure a vendor can implement somebody else's
> > > extension, they just need to add it to their namespace too.
> >=20
> > I didn't mean that you were mixing up how your implementation worked, my
> > point was that you're mixing up the hwprobe stuff which may need
> > namespacing for $a{b,p}i_reason and probing from DT which does not.
> > I don't think that the kernel should need to be changed at all if
> > someone shows up and implements another vendor's extension - we already
> > have far too many kernel changes required to display support for
> > extensions and I don't welcome potential for more.
>=20
> Yes I understand where you are coming from. We do not want it to require
> very many changes to add an extension. With this framework, there are
> the same number of changes to add a vendor extension as there is to add
> a standard extension.=20

No, it is actually subtly different. Even if the kernel already supports
the extension, it needs to be patched for each vendor

> There is the upfront cost of creating the struct
> for the first vendor extension from a vendor, but after that the
> extension only needs to be added to the associated vendor's file (I am
> extracting this out to a vendor file in the next version). This is also
> a very easy task since the fields from a different vendor can be copied
> and adapted.
>=20
> > Another thing I just thought of was systems where the SoC vendor
> > implements some extension that gets communicated in the ISA string but
> > is not the vendor in mvendorid in their various CPUs. I wouldn't want to
> > see several different entries in structs (or several different hwprobe
> > keys, but that's another story) for this situation because you're only
> > allowing probing what's in the struct matching the vendorid.
>=20
> Since the isa string is a per-hart field, the vendor associated with the
> hart will be used.

I don't know if you just didn't really read what I said or didn't
understand it, but this response doesn't address my comment.
Consider SoC vendor S buys CPUs from vendors A & B and asks both of them
to implement Xsjam. The CPUs are have the vendorid of either A or B,
depending on who made it. This scenario should not result in two
different hwprobe keys nor two different in-kernel riscv_has_vendor_ext()
checks to see if the extension is supported. *If* the extension is vendor
namespaced, it should be to the SoC vendor whose extension it is, not
the individual CPU vendors that implemented it.

Additionally, consider that CPUs from both vendors are in the same SoC
and all CPUs support Xsjam. Linux only supports homogeneous extensions
so we should be able to detect that all CPUs support the extension and
use it in a driver etc, but that's either not going to work (or be
difficult to orchestrate) with different mappings per CPU vendor. I saw
your v2 cover letter, in which you said:
  Only patch vendor extension if all harts are associated with the same
  vendor. This is the best chance the kernel has for working properly if
  there are multiple vendors.
I don't think that level of paranoia is required: if firmware tells us
that an extension is supported, then we can trust that those extensions
have been implemented correctly. If the fear of implementation bugs is
what is driving the namespacing that you've gone for, I don't think that
it is required and we can simplify things, with the per-vendor structs
being the vendor of the extension (so SoC vendor S in my example), not
A and B who are the vendors of the CPU IP.

Thanks,
Conor.


--S0aAJ0pL4KXiXwbM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh4qgQAKCRB4tDGHoIJi
0jJZAQDQmcK4nj841UhHcb8WvWbPC7o7TCt9g7AQS757vS0CSwD/XR1svOyQ4sAV
a2VdMwg8xaojsbGnITddWN30iDLuywA=
=fr0c
-----END PGP SIGNATURE-----

--S0aAJ0pL4KXiXwbM--

