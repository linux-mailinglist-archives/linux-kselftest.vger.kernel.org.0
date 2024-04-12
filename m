Return-Path: <linux-kselftest+bounces-7893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77F88A38F7
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D392D1C21D50
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 23:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECEE152534;
	Fri, 12 Apr 2024 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPXBUvTS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D910F4;
	Fri, 12 Apr 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712965233; cv=none; b=th+v11f8vTPsopDz1/Aah+7DjWy46BvzMlwZwnd/f/2+Bux4om4EcPS3EqcGa+cpeZtLuyUrObRB/j/Znttd/oF8F1s3AxnejTl3QWyXsiGyNEna9rr/elBEF/tNnBI93micq5AZXUlMLQU3SYnfh59zpvRq6xrSdGnHemy7tZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712965233; c=relaxed/simple;
	bh=9fTY4WZx/alT8Sa+UXHnrqhnRrKl/iF6TU4j2OrIj/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khIr6mALESvWFhk9B8AIIKClNZ5iW9IpugBAgYbTaX548rVA7teD+RbhVFLpBu0g403yMhRX+jUERaVbwOkOfvrhlH+dm1mfRVqIxoEZ2cEB4wIR+fmX+vlhftIs/R224HJ2B5c2kYOmTgu9kgeYZNx+dIUem29xocPGjHpJ88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPXBUvTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDC9C113CC;
	Fri, 12 Apr 2024 23:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712965232;
	bh=9fTY4WZx/alT8Sa+UXHnrqhnRrKl/iF6TU4j2OrIj/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPXBUvTSeM9fF+xXpA07Gpnzgo9A4roMQAV8BMU8Tsh9iCbQaED1Slw64mRvBxR+l
	 xpT/q0xlzSKtEP7HbPN96NZ3fSnEHd6VmNwbNSSTBjT1QsvogDycYZNb5G8ytc9y3Z
	 l63WmrYLwUYiRLttqEDcTiRZKaQJS+5b8J59T+FLhWOZ5ajzoO7HjID3hecqtoSZ73
	 8rWb3Byn3SqU8X0Mg3+d4S7Ugxc4cnRJtRDPzTk2wUey0Iob5bmb0ek6FurxeJggvg
	 du6yiPVNMMZwsya5CHQHtdtjM8X0fY/3Hn+Hf1/ZB+wOxZpIaMyUvwXxHbQCo5vnML
	 NXNVXjT7x52IA==
Date: Sat, 13 Apr 2024 00:40:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/19] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <20240413-sharper-unlivable-5a65660b19e2@spud>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-2-4af9815ec746@rivosinc.com>
 <20240412-tuesday-resident-d9d07e75463c@wendy>
 <ZhlrdGXfSushUNTp@ghost>
 <20240412-eastcoast-disparity-9c9e7d178df5@spud>
 <ZhmeLoPS+tsfqv1T@ghost>
 <20240412-chemist-haunt-0a30a8f280ca@spud>
 <ZhmoPuoR00aS6qZp@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fiOPUQP1XJPUpApw"
Content-Disposition: inline
In-Reply-To: <ZhmoPuoR00aS6qZp@ghost>


--fiOPUQP1XJPUpApw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 02:31:42PM -0700, Charlie Jenkins wrote:
> On Fri, Apr 12, 2024 at 10:27:47PM +0100, Conor Dooley wrote:
> > On Fri, Apr 12, 2024 at 01:48:46PM -0700, Charlie Jenkins wrote:
> > > On Fri, Apr 12, 2024 at 07:47:48PM +0100, Conor Dooley wrote:
> > > > On Fri, Apr 12, 2024 at 10:12:20AM -0700, Charlie Jenkins wrote:

> > > > > This is already falling back on the boot CPU, but that is not a s=
olution
> > > > > that scales. Even though all systems currently have homogenous
> > > > > marchid/mvendorid I am hesitant to assert that all systems are
> > > > > homogenous without providing an option to override this.
> > > >=20
> > > > There are already is an option. Use the non-deprecated property in =
your
> > > > new system for describing what extesions you support. We don't need=
 to
> > > > add any more properties (for now at least).
> > >=20
> > > The issue is that it is not possible to know which vendor extensions =
are
> > > associated with a vendor. That requires a global namespace where each
> > > extension can be looked up in a table. I have opted to have a
> > > vendor-specific namespace so that vendors don't have to worry about
> > > stepping on other vendor's toes (or the other way around). In order to
> > > support that, the vendorid of the hart needs to be known prior.
> >=20
> > Nah, I think you're mixing up something like hwprobe and having
> > namespaces there with needing namespacing on the devicetree probing side
> > too. You don't need any vendor namespacing, it's perfectly fine (IMO)
> > for a vendor to implement someone else's extension and I think we should
> > allow probing any vendors extension on any CPU.
>=20
> I am not mixing it up. Sure a vendor can implement somebody else's
> extension, they just need to add it to their namespace too.

I didn't mean that you were mixing up how your implementation worked, my
point was that you're mixing up the hwprobe stuff which may need
namespacing for $a{b,p}i_reason and probing from DT which does not.
I don't think that the kernel should need to be changed at all if
someone shows up and implements another vendor's extension - we already
have far too many kernel changes required to display support for
extensions and I don't welcome potential for more.

Another thing I just thought of was systems where the SoC vendor
implements some extension that gets communicated in the ISA string but
is not the vendor in mvendorid in their various CPUs. I wouldn't want to
see several different entries in structs (or several different hwprobe
keys, but that's another story) for this situation because you're only
allowing probing what's in the struct matching the vendorid.

--fiOPUQP1XJPUpApw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhnGaQAKCRB4tDGHoIJi
0sbXAQDqwcw8csQEWGYwvW1DEpXXN05Grqo2xpuKvGADPYkWUgEAtM5EfnQLdtX7
xI9bLNJaIswXp9N/DvHPHd37C0Uo1wY=
=7ovm
-----END PGP SIGNATURE-----

--fiOPUQP1XJPUpApw--

