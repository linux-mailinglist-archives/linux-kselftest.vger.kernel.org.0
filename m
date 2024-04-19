Return-Path: <linux-kselftest+bounces-8449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C88AB25C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939B31C21F9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82423130A4C;
	Fri, 19 Apr 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iam3SZGh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA2112FF6E;
	Fri, 19 Apr 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541812; cv=none; b=F7GZr0ruXtWWDmmMKs+b+PED85begEal3BIF/gfBv8blPyRz9ZZJV0db5Uz8n45lfWLy5kv+5xOC7Fiagk9e/Yw+q+ewWbBvCM2gIY9XgOvfpqTVE7PShbhO/PepYqTuKbXb/JMXoHrhhBxifkRCnCfPj6SW0aXOFHuJPH5fM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541812; c=relaxed/simple;
	bh=jvlGgpkF/Oc6sdS8Ym3wS79QaEfTCeYHkiQivnn6tCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1TWbLKWWVhFy6ZTbHt9v2OiGmTO/sEddAOZTd6eIfDgCLdoqHVtYb7KBPaBhWi0lB3jc/YZOO18CaDGqsKbHv+fPLn9tT1LHnv2HkPRTo/TwfDjYOqe82mhm1T5UnyEtIQtZkzcxgGuYQzCBCxhquk8fCtxriKmmxcbwMCiGRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iam3SZGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F03C072AA;
	Fri, 19 Apr 2024 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541811;
	bh=jvlGgpkF/Oc6sdS8Ym3wS79QaEfTCeYHkiQivnn6tCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iam3SZGhTHYGjyhPIqc6jp79nf8yZ1hY2eNXix0OK8rGy89GH2t5M+qaX3NMsVTy+
	 1JsmqG9KCdZyLjnLCJa+LQtrmCUF/X+AZbv2vBiGWreXnxTLSDAEvJjTzb5rUUd33o
	 lB5gDX6Wd5EraCkOyV7N38Rs3Ke2p1nun5CjvE612FU67POYlUGPtsJdbP0B4YHQ29
	 0iwGfNudOU0ROjkbrvzCmqGauJEsew7gMU5e/eo8XbWQjLqcbyvt1UK4P6fQrkrHqv
	 VuFagmjQ8S4BcLrJCf+U4KIwAuLGhEg2XtTOLgmsata4QtDWGf0PWAt/Xb9DqTgKpJ
	 jJ/nEOBA7q7kA==
Date: Fri, 19 Apr 2024 16:50:00 +0100
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
Subject: Re: [PATCH v2 08/12] dt-bindings: riscv: add Zcmop ISA extension
 description
Message-ID: <20240419-lumpish-synapse-db19786b15cd@spud>
References: <20240418124300.1387978-1-cleger@rivosinc.com>
 <20240418124300.1387978-9-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GUO42IRTVVtzYpmy"
Content-Disposition: inline
In-Reply-To: <20240418124300.1387978-9-cleger@rivosinc.com>


--GUO42IRTVVtzYpmy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 02:42:31PM +0200, Cl=E9ment L=E9ger wrote:
> Add description for the Zcmop (Compressed May-Be-Operations) ISA
> extension which was ratified in commit c732a4f39a4 ("Zcmop is
> ratified/1.0") of the riscv-isa-manual.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--GUO42IRTVVtzYpmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiKSqAAKCRB4tDGHoIJi
0m3+APsG28OMlzctPcsp9V+PWZH+VVar6PGgqnHMgv4RxiPxAwEA/dAxomnDRjLs
fCfTTVZKzD353yb1BT0EmnILnVijyww=
=FnpG
-----END PGP SIGNATURE-----

--GUO42IRTVVtzYpmy--

