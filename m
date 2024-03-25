Return-Path: <linux-kselftest+bounces-6542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6267C88AFF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 20:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7E2C050DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AD91514CD;
	Mon, 25 Mar 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeyOuI7h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E73DABE4;
	Mon, 25 Mar 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382123; cv=none; b=XB67EDXV4eAw5akSW/H6R8bekB3crwTr6O81r7SV0Qo3iI/ujR6SLZgwX4YMXALNhmh3ftiJd2ykt31ji+OHMPIwVOaVI+6sym+7MV7bJydbmlBcIvQig7rJ8pEh1nPN7yuLnORLh+rDelQmVdGnxifC3XrVioXuWay9TMb0IEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382123; c=relaxed/simple;
	bh=KCKMR+ILD4PVJLMsuipVfj8QVOZrAGWjhVprqfmw3eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KT6baVoFVlASoKVe0Y2e9qxFAFH81X/ffUor1uESQlJRvL5q3y0/ZUge/fPsiPFnN16X83u+srz4LEKamgPkqDFjg6xmPYGtgm6Geq+eDK4uBeHCcgG0uHIQ2Pa4Hl4nvYkXmyJPnkffgcLxpDV81B64Qb5lDuq++QsoiIWPai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeyOuI7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09906C433C7;
	Mon, 25 Mar 2024 15:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711382123;
	bh=KCKMR+ILD4PVJLMsuipVfj8QVOZrAGWjhVprqfmw3eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SeyOuI7hEeFDNtNHmTwXhfq1ktE+wDYayMxGK2ZLVMYuwp0kbnwLz5e7Jmt/ns1ym
	 u2ofHLYbYwBOXyGplLOOVb+6dnJwPk6Q5ZFQze/PLrViEtIOruOSEr3wVUt0GpZRlq
	 VlJEg31GSfcodBpziQTUS+4hVlu0/79hyrA3Qxa1H942H8Bto1U4Ekx1mLU46+2DMX
	 9SUM9LAyWtepGWr5XWprmlsLhkKBUbI6s2EY/pxoV6lFEQUMruzqQQQw3dHVLystmT
	 DEk6ONnMoC6dWei9FCiwuNihKscwW/Z2kirMneP00lkvqgGqhDAfXQotktbf6LDRCf
	 wHsaoesDL0BkQ==
Date: Mon, 25 Mar 2024 15:55:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, x86@kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: kunit alltests runs broken in mainline
Message-ID: <c01d6e1c-1dad-4012-b8b0-dccf19b2e3f2@sirena.org.uk>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, x86@kernel.org,
	linux-wireless@vger.kernel.org
References: <b743a5ec-3d07-4747-85e0-2fb2ef69db7c@sirena.org.uk>
 <9c9e1297e2548b363fc93e774c8546e6ebf4efd6.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4jvBTpuTtm1bPuXu"
Content-Disposition: inline
In-Reply-To: <9c9e1297e2548b363fc93e774c8546e6ebf4efd6.camel@sipsolutions.net>
X-Cookie: Evil isn't all bad.


--4jvBTpuTtm1bPuXu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 25, 2024 at 04:29:53PM +0100, Johannes Berg wrote:

> But I'm not sure why ARCH=um is different?

It's probably something to do with it lacking a bunch of features of
normal architectures, especially around hardware support.

--4jvBTpuTtm1bPuXu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYBnmUACgkQJNaLcl1U
h9ALDgf/XYMGzxDASg1Yc8Xy1aYc9Vb0lyDqOp0iIGFDCn4UraS7RU63hYEfJ9R8
DV/58lF9zliBinTQ4thT4fesKQsvQF51UJNH/WGUxyRg1McSxUtXkSK1DzRJmMKG
JdFBftK8O4DlXrV96jszwXw9TZZNCaaRY8adwLVSZ1Y6FWlTTsz4miog5lZlIyWB
N79/pkCbXjFD2MTtCiqNop+TXS1c24fLKH3G146bU4voKKd3Kx7Uo1uiiZQ2ebco
Ofa+UNn14ETNn0YKsM5vngb5MaD+/EMFpxOPKEtX4fu0BPt+0akIr8UcnM5K6BTi
z+U6vwsi/C1NgLQQLkS5Kpi0evb0vQ==
=Pr7g
-----END PGP SIGNATURE-----

--4jvBTpuTtm1bPuXu--

