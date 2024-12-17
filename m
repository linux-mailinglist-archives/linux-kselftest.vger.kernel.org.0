Return-Path: <linux-kselftest+bounces-23447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995C69F4C17
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 14:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF93178D5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 13:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FE11F3D44;
	Tue, 17 Dec 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpysCSle"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720EB1F2360;
	Tue, 17 Dec 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441139; cv=none; b=mgkSnZv0XYAHPix2hw/qo7jWabtLY8kjrMv0djFcLRccr9lj30ZWnMHRVMV4TE/qvPHCZDk6nnIoLStNwZdK+lCYrXqVzO3pKaQijWD4MUy2DqCKfmSYV1S1/1Z6FRcnGcz+aOc//r92XceTLewVqMCfdOR1Tnx+U1vz4Dbq9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441139; c=relaxed/simple;
	bh=NNbGIpTR9ucHUcd+V1m67aWIvcPZWpSvpzY+Npzf1hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMa3Wbxq63GR+nXQOWvtlfXuI8w6JvQjCc9sZy7TMhAzrIByJ9nicFuKP6I3FxnNuoK03FqHVnXecF7FlSEav5s1e0Gys1qN0g2VGEN2ZMu31sXDJNU8msT6JpQ0lVS+gRir0av/5q55qunDqBN2qLtySj3k9Eyvg/PICtGlsMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpysCSle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FC9C4CED3;
	Tue, 17 Dec 2024 13:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734441139;
	bh=NNbGIpTR9ucHUcd+V1m67aWIvcPZWpSvpzY+Npzf1hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GpysCSlePkJabnerFbvi5fPnVnRCsBQ/1bTUFJu8J4tWaWLIviqnLkqtPGY6BClp7
	 nahp7nmC85UjUJ9P2M8BYeG84EqGfgYEi2jbLHssRRmDUVM4+Oqrc0j8JVEluhUsoI
	 3bQaU4ZAvRCkpglFE8vnsmETULygZTss1raEhiHx/50+3nt2euINfS2/Yd/NalvkL5
	 EHyCKQHLQ1KzinISRtBB4CpkvKBRsaZX+1+n3uEOQD9QSSsYvjgCx2Y0p6nUh0miIv
	 zBFRkVLFvjwPVYG3ac7TfMN2pJsfOHVKnkecBCblUKLO9a+AduiIdszSQT9wc6IhJe
	 RLzpoYJwEYvNg==
Date: Tue, 17 Dec 2024 13:12:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix set_id_regs selftest for ASIDBITS
 becoming unwritable
Message-ID: <53b40aa8-f51c-4c4e-a4ad-e6a9512e5197@sirena.org.uk>
References: <20241216-kvm-arm64-fix-set-id-asidbits-v1-1-8b105b888fc3@kernel.org>
 <875xnisocy.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dtQUalAAlROS9KmZ"
Content-Disposition: inline
In-Reply-To: <875xnisocy.wl-maz@kernel.org>
X-Cookie: The sum of the Universe is zero.


--dtQUalAAlROS9KmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2024 at 08:30:37AM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Fixes: 03c7527e97f7 ("KVM: arm64: Do not allow ID_AA64MMFR0_EL1.ASIDbits to be overridden")

> A patch for a test doesn't fix anything in the kernel.

The selftests are shipped as part of the kernel source and frequently
used for testing the kernel, it's all one source base and we want to
ensure that for example the test fix gets backported if the relevant
kernel patch does.

--dtQUalAAlROS9KmZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdheKsACgkQJNaLcl1U
h9ASOwf/S1R7+IQSKi6x5xNzlJGe1wq68D6eyCvxwgq805v6KbH1QY48zzqkVGtl
PlLhzdq+yIrf/DZDSmGACc323zLxZ28Arzca7+suyV1hNjJWtOEqktVZmgZCerrH
ghLZlctH8YxaGc7X8OD7IrhE6js2ZmJu3+A0vhj5355BOKxR+PuWAQo3hkAvpZxb
uk1rN/58DEIEOkX08nDV6YBAQzAHtzy1asI5EoUxA97gqWiLbVdPL5iog+owQ4Jr
IDM5VdwYPZOLOqiLRhEzBTxOY030BKwXeh1bzP40JlyFPcJn60Lrqa49Rz+eLaeE
l72maJr7HKHCyM419K5Seww9Byak5Q==
=eH+J
-----END PGP SIGNATURE-----

--dtQUalAAlROS9KmZ--

