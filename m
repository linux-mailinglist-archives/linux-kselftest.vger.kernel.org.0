Return-Path: <linux-kselftest+bounces-48546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 056D0D04A45
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 18:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EFBA30500F9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 16:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0CB2D9EF9;
	Thu,  8 Jan 2026 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLvKHVYk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6B2D9ECD;
	Thu,  8 Jan 2026 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890561; cv=none; b=f9rsR1CWXRLQA/krCYXsJHxhg1NB1ToUuvkpygpAd9BLhIU08ko4234bIUcQhphEeoA6CavKmLlh70QEmNk4mYPIFyT3CRh0Gi7D9rf7/Nalsar56dHTHYZwsEOdr2IypvYYVc+wx8fciHWg0tnFUk+2Sc/Q0qDDt3HSLC7x4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890561; c=relaxed/simple;
	bh=2JTt6hDJvWzDTM0dUBCnhSTPgPA0XojNDbovadYlQYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGDftm3fYX36d/61RQd3b7DOLChqtpdiMSjrvbTYbM3NbpTWeJhp0tyawqfbqz5/GWOCp8hblLZ7kNOm/9lh359QrvFz/D8klXv3dYSzw+F7ULrMBaOhm3qkvseOeltB0jt6sXzA3++ylYMUZgkjBwRgMWLsDF7EZSLFveY7NyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLvKHVYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B89FC116C6;
	Thu,  8 Jan 2026 16:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767890560;
	bh=2JTt6hDJvWzDTM0dUBCnhSTPgPA0XojNDbovadYlQYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLvKHVYkzB2xrU3XqpRv+2aLl6pb+jRfwARYY9Gxguxdkn8r9y0YSpc9yAOQyawit
	 jBgZ5eOGLampXS8fNTGMK703bEQytzlTq802pMzoQzghCWEe7OXDUYVjBozH3DCnIj
	 vnxYhigbIOOxXNN+2OyB7mlFksiJ3lyfhYBbLCtW3jfHL+uBKYkAP7fVGURjrCVufF
	 Ug3dQE83ZJW7ZZEyzwCBVcURUF8xgKEjqODKKR1ibueNYt2Ydo/9eVTcWi5MVw8wiq
	 V2+DYtzMYtGiZtRJ5NLbsCmxMBVkXZ4A26Z7p9xzeU+H6hdXHZiecp/bHsFvpZElwX
	 LfyfkMgOlasPA==
Date: Thu, 8 Jan 2026 16:42:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v9 02/30] arm64/fpsimd: Update FA64 and ZT0 enables when
 loading SME state
Message-ID: <cb6372ea-b7f7-4e87-91b5-09378f2dd526@sirena.org.uk>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-2-8be3867cb883@kernel.org>
 <CA+EHjTxdSnpFHkm6o85EtjQjAWemBfcv9Oq6omWyrrMdkOuuVA@mail.gmail.com>
 <3c8b4a5e-89f4-47e0-9a5d-24399407db0c@sirena.org.uk>
 <CA+EHjTxLkLjPj=1vwDqROXOUXi2LhOQb90WP6dFaTiYG1nWovA@mail.gmail.com>
 <e50b4923-ee45-43de-9d4e-344546c635bb@sirena.org.uk>
 <CA+EHjTybF+aq2b2vhcEqi6U_sJjtt7ngzMZ9UcJ15G-Kqj=A9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IBbOtxmVdG86xy2i"
Content-Disposition: inline
In-Reply-To: <CA+EHjTybF+aq2b2vhcEqi6U_sJjtt7ngzMZ9UcJ15G-Kqj=A9A@mail.gmail.com>
X-Cookie: If you suspect a man, don't employ him.


--IBbOtxmVdG86xy2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2026 at 04:19:34PM +0000, Fuad Tabba wrote:

> Would it be worth adding a comment above the macro noting this
> difference from sve_cond_update_zcr_vq()? Something along the lines of
> 'Intentionally overwrites to ensure strict control of enable bits', to
> save future readers from getting confused...

Sure, makes sense.  Possibly also rename it, I'll have a think.

--IBbOtxmVdG86xy2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlf3nQACgkQJNaLcl1U
h9B9Tgf+IN7Byiwu2Z/BASg5BnKyxCB2XaDCnpzYIDqiBTAHcDa4uurE8parsO5u
9gSiFE/fGFAUTL0ApBcB3Q+eZ0CzXPzCri5Ao2rb19bWYj4OnhSmsrBiVvgjWc92
pyUPxBVcXfScjS/eFtDSjiBIjLWbvOjFRRSbc2W/CJzcwBH0Ch6A35vBv5plM4QJ
txTV72D3BnfnQFqt5cNi3UFVg+XpZQQ/i6+ickNqRBJKRy6Q9LKvoYegHabPvt8g
oOo8YpwCAqUYl8dAEFrHLU6t0JMmMnLMzUCBDDKcTwZbZd/zMyd9L8jGbtMMuim6
6FXHMUIcx+PFnhj4HinUO/IJYZX31A==
=FXRp
-----END PGP SIGNATURE-----

--IBbOtxmVdG86xy2i--

