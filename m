Return-Path: <linux-kselftest+bounces-9196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1909B8B8966
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 13:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40571F22F4D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E8A7CF3A;
	Wed,  1 May 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWQrVZmR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A9E1758D;
	Wed,  1 May 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563645; cv=none; b=JqPe2XeeRF9CbcH64RmW2+g84LRJnsBbbVgXY2OIUvCjfvpS5cbtGGeULs0At+njahcwu+mekpKzW2YAUVkn0yo2nNAYrWHL+aDNBmy+yd41qIIynFYSbIgAmacJoPZQ6jDUxdgim35QIcwo7XRH6JTtCTFJ5Q23aE61uvSNsiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563645; c=relaxed/simple;
	bh=wjSpgVBA1AYrZcgC5XCgSh0SYSTObA/R2PwB5ny4N2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPUo0vlq1bRygDAvNp7OANUViRtR4QCcgjTiZtZWu+wcsBj1Sj8QAJ/rYtIO85iijH6ukoLQAiqp5NG8iTXQuDLUle/LDYJ+GBzyu2VOQKYsdnZGdAGUhuJQsbxUNzHsmXuXbtyMPPfhuU3ilgK1jw98Faeg1mP1BVUWtW5LQd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWQrVZmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9A8C113CC;
	Wed,  1 May 2024 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714563645;
	bh=wjSpgVBA1AYrZcgC5XCgSh0SYSTObA/R2PwB5ny4N2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWQrVZmRHD6t4l4m9y9InSm/dWTF32vdD7aRGjavVGSSVvdot/XLB32fC9noC9XwH
	 w+J/4Oat23aTb9B82vofQ22DNvfGaXGWViI6IIKyx8XzeYYtNxaSnfKTrdoEUmDrat
	 aprayiD8//hPgwZ/HgwXG+GzMNQw2c5vb09Dv8FSJApGEjrF/azhi3sA3j0aZXZT4g
	 xix/psYZtkm/Ityc67DQeYgmE9DFcLFuUCkvONgQr7nyNUlKXaZsYg/MKmn7EH2J5t
	 03lQH24dwjGHhRp0t/Jji6+ljB1m1kZeJCXabufwTJmoyHFPw643kpW3V6IOc5CvNW
	 3+fd64QGmZvLA==
Date: Wed, 1 May 2024 12:40:38 +0100
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
Subject: Re: [PATCH v4 05/16] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <20240501-drivable-deviation-0a493511770c@spud>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xHWLnBdUePAybcBR"
Content-Disposition: inline
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>


--xHWLnBdUePAybcBR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 02:29:19PM -0700, Charlie Jenkins wrote:
> Separate vendor extensions out into one struct per vendor
> instead of adding vendor extensions onto riscv_isa_ext.
>=20
> Add a hidden config RISCV_ISA_VENDOR_EXT to conditionally include this
> code.
>=20
> The xtheadvector vendor extension is added using these changes.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig                               |  2 +
>  arch/riscv/Kconfig.vendor                        | 19 ++++++
>  arch/riscv/include/asm/cpufeature.h              | 18 ++++++
>  arch/riscv/include/asm/vendor_extensions.h       | 26 ++++++++
>  arch/riscv/include/asm/vendor_extensions/thead.h | 19 ++++++
>  arch/riscv/kernel/Makefile                       |  2 +
>  arch/riscv/kernel/cpufeature.c                   | 77 ++++++++++++++++++=
------
>  arch/riscv/kernel/vendor_extensions.c            | 18 ++++++
>  arch/riscv/kernel/vendor_extensions/Makefile     |  3 +
>  arch/riscv/kernel/vendor_extensions/thead.c      | 36 +++++++++++

I see no modifications to cpu.c here, is it intentional that vendor
stuff isn't gonna show up in /proc/cpuinfo?

--xHWLnBdUePAybcBR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjIqNgAKCRB4tDGHoIJi
0tFmAP9+0phfGvQLL4gYc5HwlKNHCFOZaYtAbKHBrc9NrXK7HQEAqAyjuARwXzQt
BVcKUnRCSkMAcAMLHfb0vHWJR0NQ7QA=
=qPWD
-----END PGP SIGNATURE-----

--xHWLnBdUePAybcBR--

