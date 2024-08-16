Return-Path: <linux-kselftest+bounces-15541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E65954EE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 18:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B853B231C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B74E1C233C;
	Fri, 16 Aug 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUys+CjT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DC81C231C
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825964; cv=none; b=rTgot8KzKk5388/OVSlbPBbcTXY7R2Zg65sWvksyUcSUMJ+OMjB7xXWOHE79JENjNxLWH08z8ia4PsQITTFqm67gomoGcNtrJArQmnsDlqrsxk43hZUXv2O8QtFmW7izGOctRyd+7ptE9leIB0/ONHeRdIWXyES1dF0X74B1ZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825964; c=relaxed/simple;
	bh=VRcfnazMa4RL06vHxhsF1P+q6juiC4zpPVLbOOnfcQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNaUf3x3P2FCApkhqClAFgtzyX7jPxf2RRNF6zSwyIGO7xwUjTL7Fl4aHWruM0OY1w525Y8I1Vmhg7m0DKVHJDllnFDAsokP4Stz5xfhqFh+o4/wCgWEYxZZT80STtRL6fjDNJEnC1h7OPn8Gy8c6iegRUkk/A2nAFWgMjPZ44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUys+CjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A11C4AF10;
	Fri, 16 Aug 2024 16:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825964;
	bh=VRcfnazMa4RL06vHxhsF1P+q6juiC4zpPVLbOOnfcQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUys+CjTkIS+Mq4obHGsPDdCxmp8mk4xZyq9ldO0z7DJexqyLDcwqx8qR6OTQXWKU
	 LTlEwH19bkryoqdeCH24USLykVMIOZjv8amVrrszhfI42SyJnU2OKknRn9mZ7a3+ou
	 vhq4PuZyx8Dz9tUUpjnjfzMuucOzkv3jObBED7co58udTwRC6CRNU7CEMnJsoGZStH
	 cTi4vgm/A1tpLtwJ8fKYUKx67ldfDENC3d0S2LXbgU1Ii3HBCOExQa9QBa5Q2KcNil
	 LR+un8YESur9cqFMlu8G+1cg+Em5iz1MejylbjcYqwzzlESTR0CRSeBZ/0xS/O63iu
	 c1BtPrcMw1u8g==
Date: Fri, 16 Aug 2024 17:32:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 7/8] kselftest/arm64: mte: fix printf type warnings about
 pointers
Message-ID: <f7d77597-cba6-42ee-9b50-ac4b7984aff8@sirena.org.uk>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
 <20240816153251.2833702-8-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tfyue51kgDGwV8Y5"
Content-Disposition: inline
In-Reply-To: <20240816153251.2833702-8-andre.przywara@arm.com>
X-Cookie: A Smith & Wesson beats four aces.


--tfyue51kgDGwV8Y5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 04:32:50PM +0100, Andre Przywara wrote:
> When printing the value of a pointer, we should not use an integer
> format specifier, but the dedicated "%p" instead.
>=20
> Fixes: e9b60476bea0 ("kselftest/arm64: Add utilities and a test to valida=
te mte memory")

This is another one where calling it a fix seems like it's pushing it,
it's a modernisation rather than a correctness thing.  Otherwise

Reviewed-by: Mark Brown <broonie@kernel.org>

--tfyue51kgDGwV8Y5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/fyYACgkQJNaLcl1U
h9DT/wf/VMbUkU8GwMx98xtshQnPU/8FOZoH/xdLiecPsP7qbcqN5eutWjisFH8B
Db3qWbWJwAPTaK4jriCvU1bjIzXp9PRrRSUEm51m6643Cs8BdNN6OrCShQ4GQEIp
rTZB2EZ0uRRhY6JcoSwjYKVMjeq/W1Kb+Rji4ZejysrE2wkWN33sg9OYS/COtOEW
gHoJBLQR7bHhq36LLchnVgd8uGYAEu6Nvb2LMmKQY7eETODbLQSlIzWHc6lda5Vz
ktjsL8vnXPjiur9yiKglCXzRfFmugd6C5FS43dB5Uakaut9rG78XW82QEz78/4H0
RTyX+qf42g4tWq+34RSGjZlGLyO9/w==
=XzmO
-----END PGP SIGNATURE-----

--tfyue51kgDGwV8Y5--

