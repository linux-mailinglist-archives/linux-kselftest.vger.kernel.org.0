Return-Path: <linux-kselftest+bounces-9227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9A38B8EEF
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 19:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A3E1C21228
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8DD18039;
	Wed,  1 May 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMSpGVhI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E842FDDAB;
	Wed,  1 May 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583982; cv=none; b=Y1hiCtw+VXiUPgU6Qu+S6vjMqMHHeAUWeV0tbj3EiEOLwjJHBK4cYKvdnDHRhZ4ODTOaPPvC7GOYzksnahUv1senflII4xVrc/orKH1pEpcijJfMgmSLLcgz4rXC6U+iHa7zHO9ycIN287OyIJiFRgjwIAG2HuknW8I5J8Cs07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583982; c=relaxed/simple;
	bh=mJpQKEtcJ3c2v8AHUID+6FduoqIlPGmY7MH+0xeYgrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVy/shA78FbIgIrTO0k/VH+JcuOVb2nuHdluATBXTfUVb6UyEYW6mc2/Sj5MOl5B3mTRDtHdW6ZH41PbXn6dNFo6njIJtEoiyftTi+mckeuyPH7WCN0tc8N33d7jwISN6b2wt2OZG44amj92sjWjcBMtijyp4EGbGDdDysZOxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMSpGVhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A04C072AA;
	Wed,  1 May 2024 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714583981;
	bh=mJpQKEtcJ3c2v8AHUID+6FduoqIlPGmY7MH+0xeYgrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMSpGVhI8L8uDLsSJJEyFBTgsakjDAs1is1XCNC2hQxzL/c3hmNjyHKnYw9L7pnNm
	 3VrCgUo1asZ5RBoNv4kM5h9lNXbDcn//XWfzXfR8sj3XMhA6M1MgMq8QH4Gi+wWaJ5
	 0l2lDkdkGXWlXMWPo4BAyk0qBvpH9mWWcG2UvJeygxKc85jiZz0wukD31Ex0OU/5s2
	 gg6jbKOb2F7NJjqav6GG3wo7ox9dAtoBhAVqLdD5ZgpQImiveSIsKvm6tUjj1me2Xj
	 npHYon9go63e2dhegSbafdb4RQwnnOedglZqjxDB5gNnJW+9JfXd8t44tI5kKN+1dT
	 QOkkuGbs4LPzg==
Date: Wed, 1 May 2024 18:19:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Evan Green <evan@rivosinc.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20240501-flagstone-zealous-2fc722bfad39@spud>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
 <CALs-HstM64Hy_=XVz=0sWQt=8j1u+bq6RhthUuD3P0E4=HyvcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mVgGewDsv8YXPdzq"
Content-Disposition: inline
In-Reply-To: <CALs-HstM64Hy_=XVz=0sWQt=8j1u+bq6RhthUuD3P0E4=HyvcA@mail.gmail.com>


--mVgGewDsv8YXPdzq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 09:44:15AM -0700, Evan Green wrote:
> On Fri, Apr 26, 2024 at 2:29=E2=80=AFPM Charlie Jenkins <charlie@rivosinc=
=2Ecom> wrote:

> > +struct riscv_isa_vendor_ext_data_list {
> > +       const struct riscv_isa_ext_data *ext_data;
> > +       struct riscv_isainfo *per_hart_vendor_bitmap;
> > +       unsigned long *vendor_bitmap;
>=20
> It took a lot of digging for me to understand this was the set of
> vendor extensions supported on all harts. Can we add that to the name,
> maybe something like isa_bitmap_all_harts? (I wonder if we could drop
> the vendor part of the name since we already know we're in a
> vendor_ext_data_list structure).

Reading this made me wonder, why is the all-hart bitmap an unsigned long
when the per hart one is a riscv_isainfo struct?

--mVgGewDsv8YXPdzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjJ5pgAKCRB4tDGHoIJi
0mvKAQDZ/PuqkdmAAHeDEhcfzV4GeMOwujPT7ib0jWzVFEvmMAEAhdzNdXJHw+cT
qfdruwRE1FLdK0IBpLEhnxWwE/OVvgc=
=uVOz
-----END PGP SIGNATURE-----

--mVgGewDsv8YXPdzq--

