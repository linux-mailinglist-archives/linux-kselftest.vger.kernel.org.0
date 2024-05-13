Return-Path: <linux-kselftest+bounces-10132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2C08C3D0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 10:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22FD1F21DF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FF5146D74;
	Mon, 13 May 2024 08:20:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42046146A60;
	Mon, 13 May 2024 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588441; cv=none; b=eFuTJ/IpM2o/Hb05uncRCXJidpdA/C3lgTGNR5DVEVV1JMe1tWRCEfmNqjnKhCuKHdI/hNNZOjxYhPpzolwLbwNx18vHV9RTY2YMq0rL3fGE2LmkCNbzHCcx4CdB2brXF6JPNd5u9HJI7lgd87olpGzukHIoohaMcx89hwXlWpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588441; c=relaxed/simple;
	bh=2NTXXEv4W0FORRgMaOhp6PQvg0PL8AwY7zxFlKX1Kn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuPpUu1rcyfAhF+PQL4I5Zwcg14WrJqhPIc2tqWHX4KQ+CjggfJsLHXT+zJKs+nVIWMCAri6YbuQns87l5cOxXAU8/n2pDdjVC60qWtUksxdG13Dgit2OVspN7mG0vN6ea95Frdh7MmtdXpEYnr6LSNtFpPqB1dVZZNhvYQzdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9A5471C0084; Mon, 13 May 2024 10:20:38 +0200 (CEST)
Date: Mon, 13 May 2024 10:20:38 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>, pbonzini@redhat.com,
	shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 08/25] KVM: selftests: Add test for uaccesses
 to non-existent vgic-v2 CPUIF
Message-ID: <ZkHNVtwcrf91k+dR@duo.ucw.cz>
References: <20240507231231.394219-1-sashal@kernel.org>
 <20240507231231.394219-8-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P98zZM4op0/acSa9"
Content-Disposition: inline
In-Reply-To: <20240507231231.394219-8-sashal@kernel.org>


--P98zZM4op0/acSa9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Assert that accesses to a non-existent vgic-v2 CPU interface
> consistently fail across the various KVM device attr ioctls. This also
> serves as a regression test for a bug wherein KVM hits a NULL
> dereference when the CPUID specified in the ioctl is invalid.
>=20
> Note that there is no need to print the observed errno, as TEST_ASSERT()
> will take care of it.

I don't think this fixes the bug... and thus we should not need it in
stable.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--P98zZM4op0/acSa9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZkHNVgAKCRAw5/Bqldv6
8n9/AJ9yPe/a5Tb1+iIlDBMPfK4qcPQrVACeNRSDmf0pWoYVHMxMJ7/sJYTC9Q8=
=HZDl
-----END PGP SIGNATURE-----

--P98zZM4op0/acSa9--

