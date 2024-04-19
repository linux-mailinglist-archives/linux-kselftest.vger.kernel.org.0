Return-Path: <linux-kselftest+bounces-8439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA8E8AB1B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600D21F215EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A102612FB21;
	Fri, 19 Apr 2024 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtnQxdlU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE5184E;
	Fri, 19 Apr 2024 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540297; cv=none; b=aQIE+R3Ag9ohDLHvgXQpNg6mioE6QV+9l1TUOY3v5V+3lMeOuLV+a3kGtdqkskskdZ2XFykXZKsdcP9YPreoz6Ma1qZB5cEOc1FEFkiPmGCB9CPi5Bm+8g1CIYwOqdrbi/YH6z/4s4dRX1p01oddeHHAkoUnloRo8lOobT8Xjwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540297; c=relaxed/simple;
	bh=vdYzPMrx1mL0pzbTIRpayXsUt9mVPOYYeTwr96fWnps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUI6O0YONtUr8damflhLy8T002XAtaapXrs0hS80NE4tMEkH+DA9g46sqg7L2vvenvGB2LqCMLG55rRYTM4/sqobgtXnxlt7prNySj8JaQtmsdQA4RfmeGWGSH8ujYykNjxxD+Nxjj3JKG8YiQZVGD2KMq8K6bjhuC02sMW0Agg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtnQxdlU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B962BC072AA;
	Fri, 19 Apr 2024 15:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713540297;
	bh=vdYzPMrx1mL0pzbTIRpayXsUt9mVPOYYeTwr96fWnps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CtnQxdlUEF3vKpQu1sx95LnMRlgV/aqKHQp0/csAwg1lJioNcOwmzSnvFtAvZyTUx
	 SSn6uRE4pJZ1NY55n+E5ORiQaYkV4svupYgE1k2LWMVBT9HczBGLkwN7GOKnvyflmU
	 giuHhxuXJwBDLp9qDYKLWKAGqUAB5AVrUjaRyK5HHiej7M1L48HLKnyNbxjPEFE0WA
	 s+H+uAzInE+/8T9KgJEE7pi5pGShvJfNTIDNImR9rYZboqDKpuRPnZLU4mVrdQs34u
	 n/Qn9X7edphCZfK8wfXC+VeDoo7etOF+QLJrKW1UvWYxVvEMthRHAKegjEq6MAvp4G
	 OsYgWYFAz49AQ==
Date: Fri, 19 Apr 2024 16:24:45 +0100
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
Subject: Re: [PATCH v2 01/12] dt-bindings: riscv: add Zca, Zcf, Zcd and Zcb
 ISA extension description
Message-ID: <20240419-aground-extradite-9557a5b90afe@spud>
References: <20240418124300.1387978-1-cleger@rivosinc.com>
 <20240418124300.1387978-2-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IbJ7nnYDSyrUMi3r"
Content-Disposition: inline
In-Reply-To: <20240418124300.1387978-2-cleger@rivosinc.com>


--IbJ7nnYDSyrUMi3r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 02:42:24PM +0200, Cl=E9ment L=E9ger wrote:
> Add description for Zca, Zcf, Zcd and Zcb extensions which are part the
> Zc* standard extensions for code size reduction. Additional validation
> rules are added since Zcb depends on Zca, Zcf, depends on Zca and F, Zcd
> depends on Zca and D and finally, Zcf can not be present on rv64.

> +allOf:
> +  # Zcf extension does not exists on rv64

If there's another version, "exist".
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--IbJ7nnYDSyrUMi3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiKMvQAKCRB4tDGHoIJi
0ip5AP9dWXDapMOiL35Gtl6YMVu8HpKNUc2H+iDTWD003piM/QD6AnztSi8/8umM
hU83nbsm7PdjtwFfBV7LErQIay+iZwE=
=Kdnw
-----END PGP SIGNATURE-----

--IbJ7nnYDSyrUMi3r--

