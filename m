Return-Path: <linux-kselftest+bounces-10057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5948C2BEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 23:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F03E1F21602
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7A13BAE8;
	Fri, 10 May 2024 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW0loYjB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897613BAD8;
	Fri, 10 May 2024 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376747; cv=none; b=DmIn9xt0IszqhYShyfEdJcYWGkAI0f0FLnUimkOhl5V9X5w6a6dUCqWoExSfjN6qYDONhmvc8Shikhg+/QZr/fRtNNfcj0PUr7x2UN/kSnwV+pScFC0DxqU3ANq4eSSsQ4SHg9MsIXft85RwX5wb36Z7RGXO5VTlE+0pXk2g+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376747; c=relaxed/simple;
	bh=HaAF5YLZNnHFDlTcRRRh1aLznDIBDt54LRmZro1kBkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp+3ehmoTkn87EdalLDWPcTq7n6ySKF67kUaRLd2LvYWqJKBQSBVL2vyuj7Qog2EcOT5onvnONzXZEqyIiB8xah4Mky+o/COyefHpr07KbcrpeLRcS6fytUFCFyuRaoL2YQYuChDqL2XDZJsmxCLC6fJMUqi+HDuVSzcwN9L6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW0loYjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4010FC2BD11;
	Fri, 10 May 2024 21:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715376745;
	bh=HaAF5YLZNnHFDlTcRRRh1aLznDIBDt54LRmZro1kBkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PW0loYjBa6QcXh8gmikKKdFQ+JniYLnMAwVmZvGkjTJ0rDFzoJZbvYtI56baJyF+I
	 gc2m1x1XG5f/Df6pBje4TguN/vGK8UrmL+3rV64DotR+AG/+iwJMfgQx78wYWNpv6X
	 kb1gvVD0w4RjMFvfoE1zDAPMNGRkLXkcCJ6AcvZPHLmFJkW5zLMyZoTpIuQOf++BXu
	 5cqXNmgNIDj8OhwCxbZDyuQ34sZWdpai2kLZHn/qPXBqevODaevVM4e+5E8A8fWiYw
	 7ZqOFAvSOJLpZR1pveFlSDZhpQyySDjVqIbFXdbrunnUNYO+a9bnZBV0h32zvviK8d
	 T/Or0mgVLdhXQ==
Date: Fri, 10 May 2024 22:32:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v6 06/17] riscv: Add vendor extensions to /proc/cpuinfo
Message-ID: <20240510-unexposed-desecrate-e30674d4530b@spud>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-6-cb7624e65d82@rivosinc.com>
 <20240507-divisive-swoop-c2737a2d9a9f@spud>
 <20240510-childcare-outlook-d18e3cc5ccb3@spud>
 <Zj6QxisrBZSWq7ax@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a4gruBJ406lMx+Li"
Content-Disposition: inline
In-Reply-To: <Zj6QxisrBZSWq7ax@ghost>


--a4gruBJ406lMx+Li
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 02:25:26PM -0700, Charlie Jenkins wrote:
> On Fri, May 10, 2024 at 09:50:32PM +0100, Conor Dooley wrote:
> > On Tue, May 07, 2024 at 06:03:19PM +0100, Conor Dooley wrote:
> > > On Fri, May 03, 2024 at 11:18:21AM -0700, Charlie Jenkins wrote:
> > > > All of the supported vendor extensions that have been listed in
> > > > riscv_isa_vendor_ext_list can be exported through /proc/cpuinfo.
> > > >=20
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > >=20
> > > This seems fine, thanks for updating this interface :)
> > >=20
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Hmm, actually the automation on patchwork is complaining a bunch about
> > the series, but I think that's mostly false positives except for this
> > patch. The nommu defconfigs are prob the easiest way to reproduce this:
> >   /build/tmp.QPMRM3oUNu/arch/riscv/kernel/vendor_extensions.c:41:55: er=
ror: 'struct riscv_isa_vendor_ext_data_list' has no member named 'vendor_bi=
tmap'
> >   /build/tmp.QPMRM3oUNu/arch/riscv/kernel/vendor_extensions.c:42:60: er=
ror: 'struct riscv_isa_vendor_ext_data_list' has no member named 'per_hart_=
vendor_bitmap'; did you mean 'per_hart_isa_bitmap'?
> >   /build/tmp.QPMRM3oUNu/arch/riscv/kernel/vendor_extensions.c:43:60: er=
ror: 'struct riscv_isa_vendor_ext_data_list' has no member named 'bitmap_si=
ze'
> >=20
> > Cheers,
> > Conor.
>=20
> The false negatives always throw me off.

Aye, it's pretty frustrating for me trying to report anything. Any time
a bunch of headers change produces a bunch of file rebuilds and
therefore warnings. That should in theory be caught by the fact that we
apply the patch & build, jump back to HEAD~1, build that & grab the
"before" warning state and then jump forward, rebuild the patch and
gather the "after" state. The idea is that that is an apples:apples
comparison as the same files will need to be rebuilt for both but it is
falling over somewhere. Maybe I'll have time to look into that soonTM.

> The errors are also offset by
> one patch.

Ye, that's my bad I think. In a rush off to another patch before the
thought I had on it left my brain and just pressed reply on the wrong
email. Sorry bout that :)

> This was actually introduced in the following patch "riscv:
> Introduce vendor variants of extension helpers" because I accidentally
> fixed this issue in the patch "riscv: cpufeature: Extract common
> elements from extension checking" instead of the one it was introduced
> in.


--a4gruBJ406lMx+Li
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj6SYwAKCRB4tDGHoIJi
0qSAAP9DtyG6cFxATpySce/LDWJjuSKIYinHHmeKGVGjDvqZkAEAkXi4b5NHBscV
XEmApTynzq59bPinnFytkPxtGEnfKAw=
=Z9vu
-----END PGP SIGNATURE-----

--a4gruBJ406lMx+Li--

