Return-Path: <linux-kselftest+bounces-8225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3098A761E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 23:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FD21F22452
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 21:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF4A5A4D8;
	Tue, 16 Apr 2024 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b37s1TWz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C391C10;
	Tue, 16 Apr 2024 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713301846; cv=none; b=bzorw/xnj1tHtv8FGU3/LfzHy0As2mZc1a6eG7BKAdrSSFau3+MMTeNICICRpt822YP3jYMB7Mrcav+wu427/oml5mIsEfLm0lX9X88HsVD9xJaY4RQZ1mWrIT9Bu8aFi2zL7S5i4UDsFBrYzUKe1fKN0zYfglqSGpbJ6gTsyuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713301846; c=relaxed/simple;
	bh=6SKY8bqj53o+GZYyijFSxu3zJnsN2yU7FXXH7uzjaJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/qnNF1wYp4dmjzht0L2c7bj/esRIWliTP3L4gPPzONOtvsrgBB1VgE7+M26mrkYQcPrsK+vWf8pBe+fF7Cgv/WgKXD9jJyxel91tBX1e+d1NEEPRfI0NqakBjKFeIuzXfXZdTbBux5yINm4lqW604FXxEUeFkkus1liqquNj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b37s1TWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B04AC113CE;
	Tue, 16 Apr 2024 21:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713301845;
	bh=6SKY8bqj53o+GZYyijFSxu3zJnsN2yU7FXXH7uzjaJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b37s1TWztoEP1XtKjvnrYhTztn6FEZSBRfS0CB5E/U2BBjp0zO04UvRS5kEmszB8L
	 2ZSzdsdQuVvsFeKpVdqg8pBTpg/B/DuOCBe4UGtZTDtsUoTVS53u6IEeCTU/9X/btu
	 gVT1MTAal9in/KAKNRctjS4hF7PK3Gn3VXjqow1RSmhAuKZMhKsJJhxDHnjJASdGFK
	 velt7R45/pMbac6a2dg8Pk+zO7MuKRdtuo8813r7UOcMGTKClRdEXACNsm1mLQwLKh
	 AoUclerCfq7D68JiZg/fJswcJi6GyHh5ghp4zX7el4+4XH2Jp9DLmI+v5ptUZmy5G8
	 oZlcN1+GPeUCg==
Date: Tue, 16 Apr 2024 22:10:39 +0100
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
Subject: Re: [PATCH v2 02/17] dt-bindings: riscv: Add xtheadvector ISA
 extension description
Message-ID: <20240416-budget-cause-c4002a9cc05b@spud>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
 <20240415-dev-charlie-support_thead_vector_6_9-v2-2-c7d68c603268@rivosinc.com>
 <20240416-underwire-bright-b2ab0fa991ec@spud>
 <Zh7i2pir0j6tXfPD@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N+EO9PqJ6paNtHI3"
Content-Disposition: inline
In-Reply-To: <Zh7i2pir0j6tXfPD@ghost>


--N+EO9PqJ6paNtHI3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 01:43:06PM -0700, Charlie Jenkins wrote:
> On Tue, Apr 16, 2024 at 04:16:30PM +0100, Conor Dooley wrote:
> > On Mon, Apr 15, 2024 at 09:11:59PM -0700, Charlie Jenkins wrote:
> > > The xtheadvector ISA extension is described on the T-Head extension s=
pec
> > > Github page [1] at commit 95358cb2cca9.
> > >=20
> > > Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358c=
b2cca9489361c61d3
> > > 35e03d3134b14133f/xtheadvector.adoc [1]
> >=20
> > This should not be wrapped btw.
> > Otherwise,
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> I don't believe it is wrapped? It appears wrapped in your response but
> it appears on lore correctly:
>=20
> https://lore.kernel.org/lkml/20240415-dev-charlie-support_thead_vector_6_=
9-v2-2-c7d68c603268@rivosinc.com/

IDK man, looks wrapped on lore too. The other copy of the same link
isn't wrapped & I've never had mutt wrap stuff like this before.

--N+EO9PqJ6paNtHI3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh7pTwAKCRB4tDGHoIJi
0oe3AQDQG/kHZeAldrMoBtsuQPLTNJ0Epz1UV1aUIpGum4LtuQEAogQ6sgpTP4rw
9y6K4GRRCRzQDtYDNsq3qY/MEznY0As=
=fCu9
-----END PGP SIGNATURE-----

--N+EO9PqJ6paNtHI3--

