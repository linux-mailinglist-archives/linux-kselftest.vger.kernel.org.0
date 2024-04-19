Return-Path: <linux-kselftest+bounces-8454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA6B8AB28B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F328D2866D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1846130A49;
	Fri, 19 Apr 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDYZx22T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC812FB01;
	Fri, 19 Apr 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542150; cv=none; b=Wq2n1FYKex9IR7MYcOjvV8l6R+EIJGdXeQxDZ8IjE9O/oZmVa+xH8QWM000pznvqi0+0eVLYj7E61DxNoHu9Z0TMvE6BTj7D6p3Sg1CZwE7zW9bfkDIg0w5Q1KskJOSqMcLFT9ZmKFWvv3g4oX58UAWZLJFwWdm8LUXnQCY9ayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542150; c=relaxed/simple;
	bh=t0ezDygYkpWs9JEW5VNerbSZsCl0SbRmsZXwpFQWFCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jbvs4NlITj4eUYpoWyAXUbclJrA1N5KIYhySoAYHsI+biFDOiZmiB1VId/YJmE4PhXZdpsbIrPZUxzQ2Xqim47MeAN++tE/uXzNaJnbGaH1Y6GLv5gIdP8ebTixjBIyxRkE+ikqSfLm8nyx8TEU/zwhNCm94SC+s3mi5tVIrxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDYZx22T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49DFC072AA;
	Fri, 19 Apr 2024 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713542150;
	bh=t0ezDygYkpWs9JEW5VNerbSZsCl0SbRmsZXwpFQWFCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDYZx22TtepHpV34SQibjr0VMG22uhlazIAJIYBo10sw8R7w6/8Fz4Bgo2spOMACr
	 lGMYtpplI5T9TYNL0lt8rmSUJhN8T+c4h2PUuOJ8Srszf61pHAgeap4uGlJ8TUePXm
	 NBKqEpX/hTLvqpZTR/nqIlwIJdI98ZV3CXdz8FHnpaQ1HAw3fu2uhpvfsY9Pdsd1cn
	 n+0YOOXMhlYZVbxNVNu4UbDjCWkwhuG5Optu8AmxiRUyHUQ4lS/hopTHZd9mx5Owr3
	 psv70cTalU+vEc5DVcYFL6lsbYWg/cIzLjMhLy5+spfFMxHqAftiOxdlUYHsDIOnGA
	 Zvg4dcGE8iClA==
Date: Fri, 19 Apr 2024 16:55:38 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 02/12] riscv: dts: enable Zc* extensions when needed
Message-ID: <20240419-pentagon-sabbath-c068399895b3@spud>
References: <20240418124300.1387978-1-cleger@rivosinc.com>
 <20240418124300.1387978-3-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZKamfHGLUNRKj+R7"
Content-Disposition: inline
In-Reply-To: <20240418124300.1387978-3-cleger@rivosinc.com>


--ZKamfHGLUNRKj+R7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 02:42:25PM +0200, Cl=E9ment L=E9ger wrote:
> The Zc* spec states that:
>=20
> "The C extension is the superset of the following extensions:
>  - Zca
>  - Zcf if F is specified (RV32 only)
>  - Zcd if D is specified
>  As C defines the same instructions as Zca, Zcf and Zcd, the rule is that:
>  - C always implies Zca
>  - C+F implies Zcf (RV32 only)"
>=20
> Add these extensions to existing device-trees that contains "c"
> extension in "riscv,isa-extensions".
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>

I don't wanna advocate this sort of churn whenever we add extensions
that are implied by some other existing extension, and I certainly don't
want to /have/ to do it because there'll be dbts_check warnings otherwise.
New subsets being defined do not invalidate the old descriptions and
they should remain valid.

>  arch/riscv/boot/dts/microchip/mpfs.dtsi       |  20 +-
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  20 +-
>  arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |  20 +-
>  arch/riscv/boot/dts/starfive/jh7100.dtsi      |   8 +-
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  20 +-
>  arch/riscv/boot/dts/thead/th1520.dtsi         |  16 +-

NAK for doing it to these 4 subdirs, even if the bindings are changed to
not warn about it anymore.

>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |   4 +-

>  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |   4 +-

>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   4 +-
>  arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 256 +++++++++---------

These go to other trees, so up to their maintainers what they want :)

Thanks,
Conor.

>  10 files changed, 186 insertions(+), 186 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/b=
oot/dts/allwinner/sun20i-d1s.dtsi
> index 64c3c2e6cbe0..05e0e5f0eed7 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -26,8 +26,8 @@ cpu0: cpu@0 {
>  			operating-points-v2 =3D <&opp_table_cpu>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			#cooling-cells =3D <2>;
> =20
>  			cpu0_intc: interrupt-controller {
> diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dt=
s/microchip/mpfs.dtsi
> index 9883ca3554c5..82ac84afdda7 100644
> --- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
> @@ -24,8 +24,8 @@ cpu0: cpu@0 {
>  			reg =3D <0>;
>  			riscv,isa =3D "rv64imac";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "c", "zicntr", "zicsr", "zife=
ncei",
> -					       "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "c", "zca", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			clocks =3D <&clkcfg CLK_CPU>;
>  			status =3D "disabled";
> =20
> @@ -53,8 +53,8 @@ cpu1: cpu@1 {
>  			reg =3D <1>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			clocks =3D <&clkcfg CLK_CPU>;
>  			tlb-split;
>  			next-level-cache =3D <&cctrllr>;
> @@ -84,8 +84,8 @@ cpu2: cpu@2 {
>  			reg =3D <2>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			clocks =3D <&clkcfg CLK_CPU>;
>  			tlb-split;
>  			next-level-cache =3D <&cctrllr>;
> @@ -115,8 +115,8 @@ cpu3: cpu@3 {
>  			reg =3D <3>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			clocks =3D <&clkcfg CLK_CPU>;
>  			tlb-split;
>  			next-level-cache =3D <&cctrllr>;
> @@ -146,8 +146,8 @@ cpu4: cpu@4 {
>  			reg =3D <4>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			clocks =3D <&clkcfg CLK_CPU>;
>  			tlb-split;
>  			next-level-cache =3D <&cctrllr>;
> diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boo=
t/dts/renesas/r9a07g043f.dtsi
> index f35324b9173c..b5e06fbfdf65 100644
> --- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> @@ -26,8 +26,8 @@ cpu0: cpu@0 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xandespmu";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm", "xandespmu";
>  			mmu-type =3D "riscv,sv39";
>  			i-cache-size =3D <0x8000>;
>  			i-cache-line-size =3D <0x40>;
> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot=
/dts/sifive/fu540-c000.dtsi
> index 156330a9bbf3..2872515dab17 100644
> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> @@ -31,8 +31,8 @@ cpu0: cpu@0 {
>  			reg =3D <0>;
>  			riscv,isa =3D "rv64imac";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "c", "zicntr", "zicsr", "zife=
ncei",
> -					       "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "c", "zca", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			status =3D "disabled";
>  			cpu0_intc: interrupt-controller {
>  				#interrupt-cells =3D <1>;
> @@ -57,8 +57,8 @@ cpu1: cpu@1 {
>  			reg =3D <1>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			tlb-split;
>  			next-level-cache =3D <&l2cache>;
>  			cpu1_intc: interrupt-controller {
> @@ -84,8 +84,8 @@ cpu2: cpu@2 {
>  			reg =3D <2>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			tlb-split;
>  			next-level-cache =3D <&l2cache>;
>  			cpu2_intc: interrupt-controller {
> @@ -111,8 +111,8 @@ cpu3: cpu@3 {
>  			reg =3D <3>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			tlb-split;
>  			next-level-cache =3D <&l2cache>;
>  			cpu3_intc: interrupt-controller {
> @@ -138,8 +138,8 @@ cpu4: cpu@4 {
>  			reg =3D <4>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			tlb-split;
>  			next-level-cache =3D <&l2cache>;
>  			cpu4_intc: interrupt-controller {
> diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot=
/dts/sifive/fu740-c000.dtsi
> index 6150f3397bff..4336ed11db9a 100644
> --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> @@ -32,8 +32,8 @@ cpu0: cpu@0 {
>  			reg =3D <0x0>;
>  			riscv,isa =3D "rv64imac";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "c", "zicntr", "zicsr", "zife=
ncei",
> -					       "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "c", "zca", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			status =3D "disabled";
>  			cpu0_intc: interrupt-controller {
>  				#interrupt-cells =3D <1>;
> @@ -59,8 +59,8 @@ cpu1: cpu@1 {
>  			reg =3D <0x1>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			tlb-split;
>  			cpu1_intc: interrupt-controller {
>  				#interrupt-cells =3D <1>;
> @@ -86,8 +86,8 @@ cpu2: cpu@2 {
>  			reg =3D <0x2>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			tlb-split;
>  			cpu2_intc: interrupt-controller {
>  				#interrupt-cells =3D <1>;
> @@ -113,8 +113,8 @@ cpu3: cpu@3 {
>  			reg =3D <0x3>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			tlb-split;
>  			cpu3_intc: interrupt-controller {
>  				#interrupt-cells =3D <1>;
> @@ -140,8 +140,8 @@ cpu4: cpu@4 {
>  			reg =3D <0x4>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			tlb-split;
>  			cpu4_intc: interrupt-controller {
>  				#interrupt-cells =3D <1>;
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts=
/sophgo/cv18xx.dtsi
> index 2d6f4a4b1e58..1fa5c57acf48 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -28,8 +28,8 @@ cpu0: cpu@0 {
>  			mmu-type =3D "riscv,sv39";
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
> =20
>  			cpu0_intc: interrupt-controller {
>  				compatible =3D "riscv,cpu-intc";
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi b/arch/riscv/boo=
t/dts/sophgo/sg2042-cpus.dtsi
> index b136b6c4128c..6d03076314aa 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> @@ -259,8 +259,8 @@ cpu0: cpu@0 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <0>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -284,8 +284,8 @@ cpu1: cpu@1 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <1>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -309,8 +309,8 @@ cpu2: cpu@2 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <2>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -334,8 +334,8 @@ cpu3: cpu@3 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <3>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -359,8 +359,8 @@ cpu4: cpu@4 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <4>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -384,8 +384,8 @@ cpu5: cpu@5 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <5>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -409,8 +409,8 @@ cpu6: cpu@6 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <6>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -434,8 +434,8 @@ cpu7: cpu@7 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <7>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -459,8 +459,8 @@ cpu8: cpu@8 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <8>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -484,8 +484,8 @@ cpu9: cpu@9 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <9>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -509,8 +509,8 @@ cpu10: cpu@10 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <10>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -534,8 +534,8 @@ cpu11: cpu@11 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <11>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -559,8 +559,8 @@ cpu12: cpu@12 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <12>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -584,8 +584,8 @@ cpu13: cpu@13 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <13>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -609,8 +609,8 @@ cpu14: cpu@14 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <14>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -634,8 +634,8 @@ cpu15: cpu@15 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <15>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -659,8 +659,8 @@ cpu16: cpu@16 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <16>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -684,8 +684,8 @@ cpu17: cpu@17 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <17>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -709,8 +709,8 @@ cpu18: cpu@18 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <18>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -734,8 +734,8 @@ cpu19: cpu@19 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <19>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -759,8 +759,8 @@ cpu20: cpu@20 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <20>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -784,8 +784,8 @@ cpu21: cpu@21 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <21>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -809,8 +809,8 @@ cpu22: cpu@22 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <22>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -834,8 +834,8 @@ cpu23: cpu@23 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <23>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -859,8 +859,8 @@ cpu24: cpu@24 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <24>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -884,8 +884,8 @@ cpu25: cpu@25 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <25>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -909,8 +909,8 @@ cpu26: cpu@26 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <26>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -934,8 +934,8 @@ cpu27: cpu@27 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <27>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -959,8 +959,8 @@ cpu28: cpu@28 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <28>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -984,8 +984,8 @@ cpu29: cpu@29 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <29>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1009,8 +1009,8 @@ cpu30: cpu@30 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <30>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1034,8 +1034,8 @@ cpu31: cpu@31 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <31>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1059,8 +1059,8 @@ cpu32: cpu@32 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <32>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1084,8 +1084,8 @@ cpu33: cpu@33 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <33>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1109,8 +1109,8 @@ cpu34: cpu@34 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <34>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1134,8 +1134,8 @@ cpu35: cpu@35 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <35>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1159,8 +1159,8 @@ cpu36: cpu@36 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <36>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1184,8 +1184,8 @@ cpu37: cpu@37 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <37>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1209,8 +1209,8 @@ cpu38: cpu@38 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <38>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1234,8 +1234,8 @@ cpu39: cpu@39 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <39>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1259,8 +1259,8 @@ cpu40: cpu@40 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <40>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1284,8 +1284,8 @@ cpu41: cpu@41 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <41>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1309,8 +1309,8 @@ cpu42: cpu@42 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <42>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1334,8 +1334,8 @@ cpu43: cpu@43 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <43>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1359,8 +1359,8 @@ cpu44: cpu@44 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <44>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1384,8 +1384,8 @@ cpu45: cpu@45 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <45>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1409,8 +1409,8 @@ cpu46: cpu@46 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <46>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1434,8 +1434,8 @@ cpu47: cpu@47 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <47>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1459,8 +1459,8 @@ cpu48: cpu@48 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <48>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1484,8 +1484,8 @@ cpu49: cpu@49 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <49>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1509,8 +1509,8 @@ cpu50: cpu@50 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <50>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1534,8 +1534,8 @@ cpu51: cpu@51 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <51>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1559,8 +1559,8 @@ cpu52: cpu@52 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <52>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1584,8 +1584,8 @@ cpu53: cpu@53 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <53>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1609,8 +1609,8 @@ cpu54: cpu@54 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <54>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1634,8 +1634,8 @@ cpu55: cpu@55 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <55>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1659,8 +1659,8 @@ cpu56: cpu@56 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <56>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1684,8 +1684,8 @@ cpu57: cpu@57 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <57>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1709,8 +1709,8 @@ cpu58: cpu@58 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <58>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1734,8 +1734,8 @@ cpu59: cpu@59 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <59>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1759,8 +1759,8 @@ cpu60: cpu@60 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <60>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1784,8 +1784,8 @@ cpu61: cpu@61 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <61>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1809,8 +1809,8 @@ cpu62: cpu@62 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <62>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -1834,8 +1834,8 @@ cpu63: cpu@63 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zca", "zcd", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
>  			reg =3D <63>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7100.dtsi
> index 9a2e9583af88..7e53c539c871 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> @@ -35,8 +35,8 @@ U74_0: cpu@0 {
>  			next-level-cache =3D <&ccache>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			tlb-split;
> =20
>  			cpu0_intc: interrupt-controller {
> @@ -64,8 +64,8 @@ U74_1: cpu@1 {
>  			next-level-cache =3D <&ccache>;
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			tlb-split;
> =20
>  			cpu1_intc: interrupt-controller {
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 4a5708f7fcf7..f01024f50561 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -29,8 +29,8 @@ S7_0: cpu@0 {
>  			next-level-cache =3D <&ccache>;
>  			riscv,isa =3D "rv64imac_zba_zbb";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "c", "zba", "zbb", "zicntr", =
"zicsr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "c", "zba", "zbb", "zca", "zi=
cntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			status =3D "disabled";
> =20
>  			cpu0_intc: interrupt-controller {
> @@ -58,8 +58,8 @@ U74_1: cpu@1 {
>  			next-level-cache =3D <&ccache>;
>  			riscv,isa =3D "rv64imafdc_zba_zbb";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zbb", =
"zicntr",
> -					       "zicsr", "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zbb", =
"zca",
> +					       "zcd", "zicntr", "zicsr", "zifencei", "zihpm";
>  			tlb-split;
>  			operating-points-v2 =3D <&cpu_opp>;
>  			clocks =3D <&syscrg JH7110_SYSCLK_CPU_CORE>;
> @@ -91,8 +91,8 @@ U74_2: cpu@2 {
>  			next-level-cache =3D <&ccache>;
>  			riscv,isa =3D "rv64imafdc_zba_zbb";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zbb", =
"zicntr",
> -					       "zicsr", "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zbb", =
"zca",
> +					       "zcd", "zicntr", "zicsr", "zifencei", "zihpm";
>  			tlb-split;
>  			operating-points-v2 =3D <&cpu_opp>;
>  			clocks =3D <&syscrg JH7110_SYSCLK_CPU_CORE>;
> @@ -124,8 +124,8 @@ U74_3: cpu@3 {
>  			next-level-cache =3D <&ccache>;
>  			riscv,isa =3D "rv64imafdc_zba_zbb";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zbb", =
"zicntr",
> -					       "zicsr", "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zbb", =
"zca",
> +					       "zcd", "zicntr", "zicsr", "zifencei", "zihpm";
>  			tlb-split;
>  			operating-points-v2 =3D <&cpu_opp>;
>  			clocks =3D <&syscrg JH7110_SYSCLK_CPU_CORE>;
> @@ -157,8 +157,8 @@ U74_4: cpu@4 {
>  			next-level-cache =3D <&ccache>;
>  			riscv,isa =3D "rv64imafdc_zba_zbb";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zbb", =
"zicntr",
> -					       "zicsr", "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zbb", =
"zca",
> +					       "zcd", "zicntr", "zicsr", "zifencei", "zihpm";
>  			tlb-split;
>  			operating-points-v2 =3D <&cpu_opp>;
>  			clocks =3D <&syscrg JH7110_SYSCLK_CPU_CORE>;
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
> index 8b915e206f3a..530355bda7c1 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -21,8 +21,8 @@ c910_0: cpu@0 {
>  			device_type =3D "cpu";
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			reg =3D <0>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -45,8 +45,8 @@ c910_1: cpu@1 {
>  			device_type =3D "cpu";
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			reg =3D <1>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -69,8 +69,8 @@ c910_2: cpu@2 {
>  			device_type =3D "cpu";
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			reg =3D <2>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -93,8 +93,8 @@ c910_3: cpu@3 {
>  			device_type =3D "cpu";
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zca", "zcd", =
"zicntr",
> +					       "zicsr", "zifencei", "zihpm";
>  			reg =3D <3>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> --=20
> 2.43.0
>=20

--ZKamfHGLUNRKj+R7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiKT+gAKCRB4tDGHoIJi
0kO7AQDL6r9OOow0IqXvoej/ToEt1qsrNQfaCkpKyrSXL5tIGAEAoC66g41faCv0
/9zOAzKXx4PXHaZW4JtHGhGiAZB9FQg=
=hTWK
-----END PGP SIGNATURE-----

--ZKamfHGLUNRKj+R7--

