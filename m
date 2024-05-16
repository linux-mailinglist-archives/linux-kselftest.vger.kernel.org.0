Return-Path: <linux-kselftest+bounces-10294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2614E8C782B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 16:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C821C20EF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2164206C;
	Thu, 16 May 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIRwHfUF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C35146D51
	for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868140; cv=none; b=WMHqqKdFz/VC1qO9T7DbHbiDmQzwYnyK5oAiDbyuBCaQuZvI+NgBYloYinUwu8ZsEVojEDkgYDxRBFydVVbe4Iv2ftlB4nm5B1VE7MHdUap6IsguRBgLLr2dl0WZd8T3QvFO3SRQEosqotBNd/uGkw60IWjeMUlfYT3zaJap48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868140; c=relaxed/simple;
	bh=f4Vni0UCjnk7izOH6PIIP9oxVDSwzyLNoQmdv5znkvU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GgxSOFO6qSDbdm0woroKXczp+OyZedHERVDLD+OlZfgX3sJsL0i1i6FWwhRBzPu+8nMb3J5BEMODw79p7yhP1Kcy6HWlVGAwdzC5GoEB5+2X7FCXPqcrxyVv1t9a4Ta/96fsyojpeaA26b7Zbq1zdtV3j9alkmpVt5CwwvmIh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIRwHfUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C200EC32786;
	Thu, 16 May 2024 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715868140;
	bh=f4Vni0UCjnk7izOH6PIIP9oxVDSwzyLNoQmdv5znkvU=;
	h=Date:From:To:Cc:Subject:From;
	b=SIRwHfUFtUI9tqYpxp5erAJyzqUwPHB+nO3irx74Aq5tWflNUL8saNOy2TiCbYwA/
	 2L2rZdcQte8y95LVmFRnAEI6p+Ce3C6S1Tx9ZnRClBuFi7/Qr8IRz8Q9ALS6yPv+vn
	 lWkddoCZ3GfQKvBrdA15ww4Abn4tPrA9rOmuX9+HVgaSu5BvkI91BVjwCDk0j0ltKz
	 Ufc0bROT8ePe/E0xnefMfsSl76t2nv3FwYnjxW/ZzaCZME4hupK4QuFTAeQV4IR5Hm
	 nYHoMPnFDzaEWGaalYz/qEh+NMVZ9aMBBFJuXIkDeeaYwTOXCU1goffvV1WEMRVQNT
	 icFOEfOkot13g==
Date: Thu, 16 May 2024 15:02:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Edward Liaw <edliaw@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	John Hubbard <jhubbard@nvidia.com>
Cc: linux-kselftest@vger.kernel.org, torvalds@linux-foundation.org
Subject: -D_GNU_SOURCE kselftest breakage in mainline
Message-ID: <d33973a1-4d49-473e-99b6-f0a5174458e7@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pUlWBn3JlmFq/w8N"
Content-Disposition: inline
X-Cookie: I'm having a MID-WEEK CRISIS!


--pUlWBn3JlmFq/w8N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm seeing quite a lot of breakage in mainline as a result of
daef47b89efd0b7 ("selftests: Compile kselftest headers with
-D_GNU_SOURCE") and daef47b89efd0 ("selftests: Compile kselftest headers
with -D_GNU_SOURCE") - thus far I've found that the use of
static_assert() is triggering build breaks where testsuites aren't
picking up the addition of _GNU_SOURCE (including stopping installing
the other tests in the same directory), and there's a bunch of tests
which #define _GNU_SOURCE in their code and now trigger build warnings.
I'm looking at fixes and mitigations now.

The build failures are taking out the ALSA tests entirely which has
caused my personal CI to explode badly :/

Thanks,
Mark

--pUlWBn3JlmFq/w8N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZGEecACgkQJNaLcl1U
h9B7ngf8DvOMpsIiJyZpsELzvqTiJGDyGYqWvnd//9cPGTECr4eU1QlQeujG5YwW
qECJ8YG8BNBadoRjVl2DehCfyCf5YdEU2fr4PKLdPan85NhkAhmglDdv9SxsIMtB
fm98LkXAsc2gexq2EuO2NSjd3N9DHU42BmbOfACu5XIPfrTsIkVLVRwMEb9KRFGw
ckymgwZ2YTo8nVWH0/NqDL6yrJ52Kq8R+/vx9hF8Q/xJwg0FUVyiGxzl7vhAq8mQ
PyG/PC9OG4+p7NTIqa7tVBmDGCh9BBLtKsUl2f8Z9tIzLkezT6tDHWriepcnDeqw
4/SP4UKHRUos3llyfKtpmc514MHHUQ==
=toZb
-----END PGP SIGNATURE-----

--pUlWBn3JlmFq/w8N--

