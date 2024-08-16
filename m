Return-Path: <linux-kselftest+bounces-15536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D33954EBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 18:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BBC1F22D93
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAB31BE235;
	Fri, 16 Aug 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6gnS6Yl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD561BD511
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825482; cv=none; b=R3n9rZnY2hot5f3Jku97X2qNMtTzjuEcGAIbA213xU07+E2ZDsmPgHQ9jb/QenkpEz21CYnglyuUM0hxychS8WS+XwEC+vawXcQmw3C6I9fC8NqhkZOgC3td0OVQk/A+RwV+V0xEkfBxH1n2nKB+cWkAn6b+8ID4j1kSrLpNbZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825482; c=relaxed/simple;
	bh=dkRQ4T0PY1BEBpTJJW+IwhKr8sIZLcvlRCjvYODeWWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oxtz1ATvPKQmz9po9eny28GLCO0oowhNwfFnbNAF2Qctd9D+acFySa5SxRBjXoEi9j4TXCDjb/7fQTpw6FZ6ahIkNIqIemX1Dtss2UjyeYsmrV9GJu8CtBT+anbmGiF2+T8k5ebb/OO3vfvuEJ/QOFk15rA5bJ+g7Zqk5Be1ZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6gnS6Yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F95C4AF0C;
	Fri, 16 Aug 2024 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825482;
	bh=dkRQ4T0PY1BEBpTJJW+IwhKr8sIZLcvlRCjvYODeWWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6gnS6YlkCSiViZW4ZN7ewhFFeHRy9DVe+NkehGHQ1+YQNFpmy2r9HOI43bLqFDWG
	 HO1NqsslqYieQJdPS7RDjp48GtNG+oZOXda5OALRkjRs8m0Or6oMuTmn6sKFN8VSKH
	 8m0YExZTBEAwYrqbuc7CdW/5fYLYB2GDI4Qf/E5vwSA5R0tcmjJnAxQxizzDml8qTN
	 cKk51ms1is+8CGsJqIzIBl6XBcpFMg9yy/h9JZMEMUMRWuqX7vwaVBHIBAflr/Dlgh
	 vTHs0oo6Jzxj7q2J7CoXR+uooZZNwrn5ILJ6eGuJcnv1T+5jmYvtorWVdbgCzidw2X
	 O1cp7BvEvmIHg==
Date: Fri, 16 Aug 2024 17:24:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/8] kselftest/arm64: hwcap: fix f8dp2 cpuinfo name
Message-ID: <890d03f6-1bda-4c15-aea9-d0d9f4e12b2c@sirena.org.uk>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
 <20240816153251.2833702-3-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9TTVZkAQLfOSC1vW"
Content-Disposition: inline
In-Reply-To: <20240816153251.2833702-3-andre.przywara@arm.com>
X-Cookie: A Smith & Wesson beats four aces.


--9TTVZkAQLfOSC1vW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 04:32:45PM +0100, Andre Przywara wrote:
> The F8DP2 DPISA extension has a separate cpuinfo field, named
> accordingly.
> Change the erroneously placed name of "f8dp4" to "f8dp2".

Reviewed-by: Mark Brown <broonie@kernel.org>

--9TTVZkAQLfOSC1vW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/fUUACgkQJNaLcl1U
h9Cfzgf8CmMi6n9JMKlF0+QWHSgNMg5IxrqN1usNTignk2KPT+Pp0wG7C0P3DnBW
MGZr1qyU1XOeQZFaOr9EGDYj1/XQQi+61x8zzPJy1FlYhwyURIMyiCvNwWYLUEcI
341WniMiRsTkGU9ovppEpBW51RBGpwhhFdbejsJGWNUwUQUd07l7mc89RmSi32ry
FVHPRzBfkOZ6qIf1LPXuH/9iCqWqwq9zJ5+PgsOQ2Znmc27ljcti6oVb+XtLdpeK
dGntSkJxHHeJf+pj6/DwIuXBymQO0Blgi5kcqtPK97aqyv2yDzdkgcgPRzqL9jdx
kM465ycP3CL6hS/k5GUHV7R1rJjQbA==
=dsM9
-----END PGP SIGNATURE-----

--9TTVZkAQLfOSC1vW--

