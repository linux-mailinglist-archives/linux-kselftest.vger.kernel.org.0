Return-Path: <linux-kselftest+bounces-7608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3C68A0324
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8D5B223D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 22:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBCD184107;
	Wed, 10 Apr 2024 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9n8ET68"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2A184122;
	Wed, 10 Apr 2024 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787377; cv=none; b=n+RJxXtbYwyFwWuu7D8rW4LBswIBRNTtTIfj/7n1Sw+Ponta/m9n2HUHp2XdK2e1bqtC3Qh3rxKPwngwNNsqxoE4iPliSlAfegtl32GArquc4bkE+EgsNDFTXYKCMH5U4c0IKgIuM5yY31tPD381+jIwJ4ZgI9JcT3W+XJgyLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787377; c=relaxed/simple;
	bh=eSgO5pW5YMKLhnbQoXlFyr4GSxxlml3nI3ZwqFFRmh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oX+UWRk6TuOpjEoQqaJzFY2EZSWVsxoDfK7GCOgNm31KI6I1wZJgRBbw5Bt+Kofe4IEE7no/8R0bd8hy/tbU42xnrO7U22Xi13CIOf3AEK0z/xIcHfT7WjGMTjpthhsZ0S2S3ax6kEA3ICK4jdTxjQ8gdWc9ADfn2WB/pnmROYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9n8ET68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFE8C433F1;
	Wed, 10 Apr 2024 22:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712787377;
	bh=eSgO5pW5YMKLhnbQoXlFyr4GSxxlml3nI3ZwqFFRmh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9n8ET68D2ZFe/iSKlFkvb35l/MWCS9iIEfC5Ejo2JybPqCdX/Gl4U0OaQc+lSTEV
	 t3HyqvUBJBi7fybvhAaZrGJtgikm2g7kfT58aK5gt0ZvQMCoanJyiMNOxc79aZnNum
	 2BdjY3JuJB4rAtqJU6/AulLAX5jjmXTitatKhaV/gkYSeTn642ka4buGDYDnuGqXhb
	 v9MmIiHozPux3yibIUcOe/P12YDJY0G4GTDHZS0WniA/nN/tLQ03nK8KiuhArxrgVt
	 oAy5lBLEG4KQ4qpEI8qYpD4XnO4NFBybPaY86KamYElWChe/MAZwQN8SYkzj/z+VwA
	 9rvJIfDWdcoeA==
Date: Wed, 10 Apr 2024 23:16:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 07/10] riscv: add ISA extension parsing for Zcmop
Message-ID: <20240410-jawless-cavalry-a3eaf9c562a4@spud>
References: <20240410091106.749233-1-cleger@rivosinc.com>
 <20240410091106.749233-8-cleger@rivosinc.com>
 <ZhcFeVYUQJmBAKuv@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DLrdOXAHzOvEYfLu"
Content-Disposition: inline
In-Reply-To: <ZhcFeVYUQJmBAKuv@debug.ba.rivosinc.com>


--DLrdOXAHzOvEYfLu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 02:32:41PM -0700, Deepak Gupta wrote:
> On Wed, Apr 10, 2024 at 11:11:00AM +0200, Cl=E9ment L=E9ger wrote:
> > Add parsing for Zcmop ISA extension which was ratified in commit
> > b854a709c00 ("Zcmop is ratified/1.0") of the riscv-isa-manual.
> >=20
> > Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> > ---
> > arch/riscv/include/asm/hwcap.h | 1 +
> > arch/riscv/kernel/cpufeature.c | 1 +
> > 2 files changed, 2 insertions(+)
> >=20
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index b7551bad341b..cff7660de268 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -86,6 +86,7 @@
> > #define RISCV_ISA_EXT_ZCB		77
> > #define RISCV_ISA_EXT_ZCD		78
> > #define RISCV_ISA_EXT_ZCF		79
> > +#define RISCV_ISA_EXT_ZCMOP		80
> >=20
> > #define RISCV_ISA_EXT_XLINUXENVCFG	127
> >=20
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 09dee071274d..f1450cd7231e 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -265,6 +265,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> > 	__RISCV_ISA_EXT_DATA(zcb, RISCV_ISA_EXT_ZCB),
> > 	__RISCV_ISA_EXT_DATA(zcd, RISCV_ISA_EXT_ZCD),
> > 	__RISCV_ISA_EXT_DATA(zcf, RISCV_ISA_EXT_ZCF),
> > +	__RISCV_ISA_EXT_DATA(zcmop, RISCV_ISA_EXT_ZCMOP),
>=20
> As per spec zcmop is dependent on zca. So perhaps below ?
>=20
> __RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZCMOP, RISCV_ISA_EXT_ZCA)

What's zicboz got to do with it, copy-pasto I guess?
If we're gonna imply stuff like this though I think we need some
comments explaining why it's okay.

> > 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> > 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> > 	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> > --=20
> > 2.43.0
> >=20
> >=20

--DLrdOXAHzOvEYfLu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhcPqwAKCRB4tDGHoIJi
0re3AP9QmK68/uYxyQ3GXl/aO2Y4Z5DssohLEjC19dZXe0kZCAD9GGfqdzucBPRK
8Oq4p/rBx7aglYaFYqQkMvbeIZStjwU=
=a6wq
-----END PGP SIGNATURE-----

--DLrdOXAHzOvEYfLu--

