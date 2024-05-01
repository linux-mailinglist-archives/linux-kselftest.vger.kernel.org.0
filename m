Return-Path: <linux-kselftest+bounces-9189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5188B88BC
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 12:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF951C22304
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB045490E;
	Wed,  1 May 2024 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOQlLWew"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6D4F881;
	Wed,  1 May 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714560375; cv=none; b=Gvisb6XiMoKeAoE+tw5ZfUYcbOvfgLHKGGzlcMcV52c3P8xFWpxVrSMEZJgp88b46QQlDkMI/Ju7D166EzFDG+N3Xg0fB8rBepSYclIjHmRiCEW7jeOCNQ0jyGwgXXt1ZqvVfiIH/EohKEbZRjS51VQRolXC6R0nqYk2RgvY9Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714560375; c=relaxed/simple;
	bh=bX0yFlagqPxL0dHVhtKj3sAKB8RRba8ErDXH4L/dIlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+9uhF1g+0yudSRBI+ornw9hxYdFOxq2LXSSz7nQkErHGBZqrQSAg8NuRrJg2nXPIogiB2XQ6OKblL7OTSH0IQDCMgXhuct994hQMuBFDSN66GXfluBEObe3Eh5N4BujFyImGJVPgUCt9utZkYZb+VoKnFuXYYxdQ+k84L7x23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOQlLWew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D304BC113CC;
	Wed,  1 May 2024 10:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714560374;
	bh=bX0yFlagqPxL0dHVhtKj3sAKB8RRba8ErDXH4L/dIlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOQlLWewBQhULLcVzVr3hASRrCE4wgGiJ7futMijuDRrO24JY+JBhielx22xMrfiM
	 CXxWH8VktaCHkkyQgueekYdahaGDIr0L80H30Vt+7pU7vIRz5inSaRuaiDeZsgE8Ik
	 OfVh2Bsf/0eH4c2Fr5PFjPe4IW0+r3+YG0a97ectlPzyVsDTzMoMDq1nZVQXWL0Y3O
	 BCvWFWfZGIjFVI1u9XGgt1QQKEEAN+KkH6V3zaG6Wf/khOzkt0V8HcwdVQ/CW+9lRn
	 qXhbbK8qmKKaOG7Iw+pIqQXv3c0JBG5JvPpPhm2ZTVHRTsURmoQ4aSYFh9Jr0xfeOZ
	 sjzdEnGxpkUrg==
Date: Wed, 1 May 2024 11:46:07 +0100
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
Message-ID: <20240501-chastise-gecko-342f2c35cfc1@spud>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IU1h/zA/fxPmJmrU"
Content-Disposition: inline
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>


--IU1h/zA/fxPmJmrU
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

This mostly looks good to me, thanks for the updates. There's one thing
that I think is wrong, but I need to test and will get back to you on...

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
>  10 files changed, 200 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index be09c8836d56..fec86fba3acd 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -759,6 +759,8 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
> =20
>  endchoice
> =20
> +source "arch/riscv/Kconfig.vendor"
> +
>  endmenu # "Platform type"
> =20
>  menu "Kernel features"
> diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> new file mode 100644
> index 000000000000..4fc86810af1d
> --- /dev/null
> +++ b/arch/riscv/Kconfig.vendor
> @@ -0,0 +1,19 @@
> +menu "Vendor extensions"
> +
> +config RISCV_ISA_VENDOR_EXT
> +	bool
> +
> +menu "T-Head"
> +config RISCV_ISA_VENDOR_EXT_THEAD
> +	bool "T-Head vendor extension support"
> +	select RISCV_ISA_VENDOR_EXT
> +	default y
> +	help
> +	  Say N here if you want to disable all T-Head vendor extension
> +	  support. This will cause any T-Head vendor extensions that are
> +	  requested to be ignored.

What does "requested to be ignored" mean to a punter configuring a
kernel? I'd expect this to be something like:

"Say N here to disable detection of and support for all T-Head vendor
extensions. Without this option enabled, T-Head vendor extensions will
not be detected at boot and their presence not reported to userspace."

In general, I'd expect something that needs some support in the kernel
(like vector) to function to have a dedicated option, but the likes of
their Zba variant could be detected and reported via hwprobe et al
once RISCV_ISA_VENDOR_EXT_THEAD is enabled.

Cheers,
Conor.

--IU1h/zA/fxPmJmrU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjIdbwAKCRB4tDGHoIJi
0h/4AQDbSwC+zSd2L4oMXZ62nZMJrbPWx5JE9S7nb98blCe6XwEAgXMzwjjp4Aq0
0/Nm2H/CfihseOibQXFgeXh59NryOgo=
=g7p2
-----END PGP SIGNATURE-----

--IU1h/zA/fxPmJmrU--

