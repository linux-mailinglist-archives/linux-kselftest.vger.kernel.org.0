Return-Path: <linux-kselftest+bounces-21695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2309C2084
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFDC2862C6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82E021B42D;
	Fri,  8 Nov 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Erv8jNC0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46B1E5708;
	Fri,  8 Nov 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080083; cv=none; b=D/Q72nv3s+cu7xRa9WagTJAc3b2+8HvWpYGx9Hpbpgfo4uYPt5eQmfZCftmWsEwAIjm00myofBGZFKy2vyW8avhcgpqvmg8MGMoTNszqBvZEcKZ+SkU0eCsQolG8Bi9X5yg0fTfr+mAKq94FY+c/O2CtJz1x5O9DQkb069SpnOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080083; c=relaxed/simple;
	bh=GCQa4PPGbaD33AeLle0wGhetHoAHZy7KNkJViY9XTLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAlTUrJ9Imw1BCz0SXrSiSPqoL6L7Mu1wZ/a19N+FvuHBj5c+WZV/bW9OWFlXDJhaGjlUSalRnu/cocnSmnV9sLTw+z2CHPbRGy6aZK6t7PPe17UYA7mZi6VCFAqWyA4xSYfQvnvf7cZdd6+ZJe0pp8CA/Y5+uu8/dNKgA/Ff7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Erv8jNC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CCAC4CECF;
	Fri,  8 Nov 2024 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731080083;
	bh=GCQa4PPGbaD33AeLle0wGhetHoAHZy7KNkJViY9XTLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Erv8jNC0c1fLICoqsHyGPHbwsa9IwEn8oMEcsl0XQ7leQRdmpWbpbyGIGStphaXhK
	 WYSJ+Duxm+Ev6mv3WnP+XPPM5N07wBIiprj7k3TBsTOqvvFGz/kVWGv43EASeG9EED
	 LkK6Amq588c10JA/qepc4IH0cOpE5YosJrIMRF76OQOn//uJMaJ9w21EAm5Qpx6Fz4
	 IHyM5Bx4KprnoRa8Q6BwG+Jm+wGta+Cal5S309NN6SIIOna7DUio5laZ68xM+u+VxS
	 aBPITxkeH41OGhJJDMgCWu/XdrFc3aNbTbAgPTtXmcvlfL7/f8ZycpxKNsVk5GIhrK
	 JZ7+2PD31wAtg==
Date: Fri, 8 Nov 2024 15:34:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fix build with stricter assemblers
Message-ID: <fcc92dc9-9a03-4db7-964b-0f7cd1490a7d@sirena.org.uk>
References: <20241108-arm64-selftest-asm-error-v1-1-7ce27b42a677@kernel.org>
 <Zy4t-tHV18D6BrXJ@arm.com>
 <Zy4uYZVkIR8ntUIV@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Slt0mEnOe0d1jC9h"
Content-Disposition: inline
In-Reply-To: <Zy4uYZVkIR8ntUIV@arm.com>
X-Cookie: Do not overtax your powers.


--Slt0mEnOe0d1jC9h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2024 at 03:29:37PM +0000, Catalin Marinas wrote:
> On Fri, Nov 08, 2024 at 03:27:58PM +0000, Catalin Marinas wrote:

> > > -	smstart
> > > +	smstart_za

> > And is smstop ok for assemblers? I think I got the error first on
> > smstop with my toolchain.

> Ah, we already have a macro for that. Let me check the error I got,
> maybe I got confused (with the multitude of other warnings ;)).

Yeah, smstop is already used in those programs (in 'barf') so they
should never have complied if the macro wasn't working.

--Slt0mEnOe0d1jC9h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcuL44ACgkQJNaLcl1U
h9DwzggAg5fR25wb0nUopVb11f6h02UcUTbvx3YR0dlmet6ISqQRRe/nCU5WonzV
yr7Dmclrbjf/GUnaoSfW7SxgXCuQWnMQC2n64BxF5/7wM/Q4qA0u8+Sr1/rlaO/s
E+Geni575s2S/vUcszZQfYptcwBM1/0yeCHXRau1LOssXt2/Ih0FoyQrtca1CRDg
26SIW5St4If5NY3L5o57j4ZfDeY1Ur8fqg7K1Hv/TgQkpugJuIEKmGfSICeZ5dVo
azZJ6VT3eR/BI4ucDSYb9wtCO3nKBu6UshsiJJNboPwZTV07mDiQ3MPI554J+Ht5
r6TyQH+ZwmdPDBxpT2frX/2gc/fRGQ==
=qoye
-----END PGP SIGNATURE-----

--Slt0mEnOe0d1jC9h--

