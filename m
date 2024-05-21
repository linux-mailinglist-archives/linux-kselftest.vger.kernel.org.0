Return-Path: <linux-kselftest+bounces-10484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77B28CB476
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 21:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642BE1F235EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2515149C68;
	Tue, 21 May 2024 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKAcwqxM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652E149C58;
	Tue, 21 May 2024 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320965; cv=none; b=D0qSjb7CAYQGGOAoyxmmsIchK6/NRNqwCPtEd2I/gvwEXv0IHEddz56pKPSgGHj8jMMX4coZAjiWh0Ogzfeovhb2j0l1L9GnuE3XFsI/+I2tCzWL49FK0Hu3n8xxoSAKn9xhbLTtO2emaPvBhnkdZESIf0v6kFsSYFnFO33x7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320965; c=relaxed/simple;
	bh=5VxfSyKHqzOTEZZXzZT0aLiSoKTpopx0vsuhYEVZU44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hwzbzb+96TJdTjoH5+0zfitPjW3uXA6HSvaHE/NC1zIm3FTV1Hxh8fidbhFw8w5QIZV7E0OUNjd7OJinTdHuiKM48jiBdBlAUCLpUHgt+dbM3NYqgFWQguw5VXwZyIy1MO2ndW/JCZJgJblIJIdmP5OjkNEY1XEt4H3jQfB7iU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKAcwqxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBDAC32782;
	Tue, 21 May 2024 19:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716320965;
	bh=5VxfSyKHqzOTEZZXzZT0aLiSoKTpopx0vsuhYEVZU44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKAcwqxMdvphissksxBIPo4FGq5KPKX5AEWVVQ7lfMWYqInRJAiv62MhaLPG8X/CJ
	 LPy2sNv63Ns1zkEtgNV5LYXsdZZxw2z9bmmmUBOV3XvxhyUmm4NLiRft4/a/9tvmAd
	 JgFA+/vxMLqr18xEdz4O8WjbWSLTvY6QSkQxiJ6Ch2Kk63BOeNCBoMoSppWHHAC6T4
	 u73/wl8C6JEKK1Dbz+0RbvlfAn/zKENyT8qj2OlRC6J9rtupS9o2Okfe8K2dsqSxoE
	 zSHmCE6ARjH+EqqoV+acJDZTEK2z5xBLiavm3H8wzLBpW9uDz+1021dqaMh7HmU4Ld
	 opUY8g2tiYyLA==
Date: Tue, 21 May 2024 20:49:19 +0100
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
Subject: Re: [PATCH v5 08/16] riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
Message-ID: <20240521-spiny-undergrad-efa1a391ad3d@spud>
References: <20240517145302.971019-1-cleger@rivosinc.com>
 <20240517145302.971019-9-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZUPGMxJHsaJik2Qb"
Content-Disposition: inline
In-Reply-To: <20240517145302.971019-9-cleger@rivosinc.com>


--ZUPGMxJHsaJik2Qb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 04:52:48PM +0200, Cl=E9ment L=E9ger wrote:

> +static int riscv_ext_zca_depends(const struct riscv_isa_ext_data *data,
> +				 const unsigned long *isa_bitmap)
> +{
> +	return __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) ?=
 0 : -EPROBE_DEFER;
> +}
> +static int riscv_ext_zcd_validate(const struct riscv_isa_ext_data *data,
> +				  const unsigned long *isa_bitmap)
> +{
> +	return __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) &&
> +	       __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d) ? 0=
 : -EPROBE_DEFER;
> +}

Could you write the logic in these out normally please? I think they'd
be more understandable (particular this second one) broken down and with
early return.

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--ZUPGMxJHsaJik2Qb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkz6vwAKCRB4tDGHoIJi
0kLvAQCE6VdTKzQsLhuTCAot4T9V9f4Lr+mwFH/JYa+PN4XSawEA4Bpid+JyrYkM
5yKjg6DZQIn95XuoTjrLNnKL0qkRvw0=
=XDFW
-----END PGP SIGNATURE-----

--ZUPGMxJHsaJik2Qb--

