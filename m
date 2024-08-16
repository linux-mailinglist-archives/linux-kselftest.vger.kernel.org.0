Return-Path: <linux-kselftest+bounces-15537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57283954EBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 18:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E542822E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAEE1BD508;
	Fri, 16 Aug 2024 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGkfZsSo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C0817
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825514; cv=none; b=IlH6quJ8iEmiPwj9d/JVnFcfFhq9ig5Xdr5DD+svUzGPCXlhrDhJa5UNCz5C9RTQ4eQyCzGj+tXs+cG/RdLJqTAilv6jxJrxIRhlhb+C0zlMXbF4J4K4ZcE/ETdBTJMkqsRgiMKDn1DYWhXoXsr6DMaRPiwf7hKS9nkPKJdXE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825514; c=relaxed/simple;
	bh=eX/4iLBC8hhsl0IxOPfd7V5GCOg257tD/ZEc7/27UtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YycTJypeQARuMtU44mf3fta7iCYofWBPBoO6RmiaooFcnZPgiTYDt/xBS7D7E2fEjhm784Amh3XmAo4lykTPluvrtjzfix9THy7n951JmSWtHFfYpmo0h6ew9tytHSUJhbWGQP0bmA0tgopUfB6JPhI8T3qT7tV9qyrDZ6Kffxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGkfZsSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B15EC32782;
	Fri, 16 Aug 2024 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825513;
	bh=eX/4iLBC8hhsl0IxOPfd7V5GCOg257tD/ZEc7/27UtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGkfZsSosif4hZroAg7x9FuRQyvnMrd0Y8V8E4ZzcXap+P135J9K9Rz1HnkHS/XVl
	 FlCGQZxCBztNLJ52LjY91vQ8Bx/vO54GK2CbGrS4RXJOpPTRG0Y6HPqtaJDmc/q3bJ
	 QbozJZW5x7GsgjJxMCe1T1LPsCvKU+fFRONt2QqiH4BP/xKkQ/GTKuhrJbob6Yn2oi
	 NRHXU6Vrph/KuIbzIrE087mywewbiF+2teE/mL/rPuKIMYie8/FofGq+YSp/5P+C2+
	 XeAafCsi4eGGUtQqSjCtWVKBfpr5YnSJ40tw1v+v0KhiY0kk655eJLx9WVcHZDaXwL
	 Cqnt2Buljxd7w==
Date: Fri, 16 Aug 2024 17:25:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/8] kselftest/arm64: mte: use proper SKIP syntax
Message-ID: <c6fca24c-3142-4985-84bc-08185e572717@sirena.org.uk>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
 <20240816153251.2833702-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HbI5UMu0JRhrIL3r"
Content-Disposition: inline
In-Reply-To: <20240816153251.2833702-4-andre.przywara@arm.com>
X-Cookie: A Smith & Wesson beats four aces.


--HbI5UMu0JRhrIL3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 04:32:46PM +0100, Andre Przywara wrote:
> If MTE is not available on a system, we detect this early and skip all
> the MTE selftests. However this happens before we print the TAP plan, so
> tools parsing the TAP output get confused and report an error.

Reviewed-by: Mark Brown <broonie@kernel.org>

--HbI5UMu0JRhrIL3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/fWQACgkQJNaLcl1U
h9ABRQf/clKI2/tMX07eZsP7OA3UwEALU+JoO54IamJzI8QeLd1VU+Y/4lj+bTa+
tG9CQj2Rbml+Gf5RvyksVPQJeppQUd6vKsVUvoEqblpJuWQt2e9hqa+/MBUlaXio
aP9oXHp4PnXOo7aZjmcLlbYhXPsVDltDriATedLoWPLSY+Tzfmnp+h7tHAkVkbbt
aTPTwD/o5csYUz5Sgam57lanDnGVMwQ7KTSTIGEaV3BgfAbKWrwBkT8VpThR6mG4
XySR3GYzl+L/bKSAufIQjfKYd09X4neZCZSCgfRlo4xMyVSd5MpEM+nzOqkNktJy
p9qKCfDjIJrYZMRQ1QnFHU1r3VwTcg==
=mFtC
-----END PGP SIGNATURE-----

--HbI5UMu0JRhrIL3r--

