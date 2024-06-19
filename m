Return-Path: <linux-kselftest+bounces-12260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C1690F51D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 19:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC5E1F21FEB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F42155882;
	Wed, 19 Jun 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQM5QXIt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEACB2139D1;
	Wed, 19 Jun 2024 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818320; cv=none; b=H39ZFhWcH6xH+IXXN6ZGz8Vwm74snQ+S5IKrxSI6YUaZTXUoRd6ehQMgF5zl0WucFw2jlBnIh7xP30xrW7Givh3tPvSdvA3VpuB2ILCToIDwhZYRZycejkuBphb2skLshW70nkKvmwxKIBeDZbPgli28mTdXXlkJaurdSBK/3EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818320; c=relaxed/simple;
	bh=Mw7LIUiugtdZZuHFybQbmbix1eukq5dcFpQhjX9nH/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1pOBAb/Su/2A0y2VdbHAQFf5iT85u4CwxX2bljvTOXMETTEnPOZU5D+Vf/+cm/YgAJSPMVqWfF4KWxHNCtV4zIqZ392y6WSpUpu/lbob1CEclfkt7p+Y8XLGijZRYuFEujjztWF6ie3F3n7Tr7RRSiYymx9YUTTJJ8eXX7y6gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQM5QXIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C857C32786;
	Wed, 19 Jun 2024 17:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818320;
	bh=Mw7LIUiugtdZZuHFybQbmbix1eukq5dcFpQhjX9nH/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQM5QXItO5CQmXw6l/M0J8VfPMifngGLU6Fibd7nXVnfDg7dHOK8GjJKktiT2i0mF
	 MNr1+IlItwJJEE6T1SQjTXZEemi048HB/w4osBkDQzU344pOkgttSJeB6uU95qYXxD
	 XGEgNMauemZ6e2UWJkKLRRbV6bRTJWecKsErpQMuSxc+asRAIGVzAVrW8IEOyLQBjC
	 GT+qfR1QPB+BC7cnR0A2ruyJcjcb8klh4v4RDUK9MN7W3GRsYG9M+E5zDJc3FLY9yl
	 tSknn25Bca/Lxf+tI+UEIXICOjg9UdZznuRFPhIWOQv9Ycx4kyWtZavgSHCgoqTDR2
	 ESHshqPBbqdKg==
Date: Wed, 19 Jun 2024 18:31:55 +0100
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
Subject: Re: [PATCH 1/5] dt-bindings: riscv: add Zaamo and Zalrsc ISA
 extension description
Message-ID: <20240619-unknowing-matrimony-84e1e16efeef@spud>
References: <20240619153913.867263-1-cleger@rivosinc.com>
 <20240619153913.867263-2-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WElrE+kfa4QQLVIV"
Content-Disposition: inline
In-Reply-To: <20240619153913.867263-2-cleger@rivosinc.com>


--WElrE+kfa4QQLVIV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 05:39:08PM +0200, Cl=E9ment L=E9ger wrote:
> Add description for the Zaamo and Zalrsc ISA extension[1].
>=20
> Link: https://github.com/riscv/riscv-zaamo-zalrsc [1]
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--WElrE+kfa4QQLVIV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnMWCwAKCRB4tDGHoIJi
0o10AQD+YJeDB9kDq+cmYMtglAAQi08gU/ZdO6csF0EgoJE9RgEA3vqPEx9kf8/3
FHxUErBZs27ZSQXpY2OxrNHoYQsUrwc=
=d4WG
-----END PGP SIGNATURE-----

--WElrE+kfa4QQLVIV--

