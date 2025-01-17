Return-Path: <linux-kselftest+bounces-24721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015C6A14F3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 13:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66683188ADCD
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 12:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0086C1FF1AD;
	Fri, 17 Jan 2025 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj5Kns1/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB22155300;
	Fri, 17 Jan 2025 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117431; cv=none; b=ikZU4JGK/xgv8BWiZj9B/AKeiWgdNXoMb3hK9T0A9pvJIAcNaAgO7ceP/j1K2EXL4CIsw52hUlMdq8gVU6vt4C+/tu79bMA/DDlTop+mka+qpCTsOSutj4zNrT4WBpaODCM8lGvrmQy2tOwlr/uDWo/BHj4Zv3N/u3DXThN5Eew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117431; c=relaxed/simple;
	bh=C7ihVmOBoRg8/pOWpnsBxf68sB5l0kSj6Vonmuw8xuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+PTmPImhOtkTl8TW+J//KSGEvao/9MH6YjN3rH4rjr5HRZajysJPC+5y41BXpjo16eGKAEwsnBQRmLDNcPYP2w4IWQB1tbIPaGjIfMSenKOQnWlD+jb33LX84WUS4rBOgXPx5rkTPY4Yh2fatjrycg/VdG4ieBnLwzSCCbKKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mj5Kns1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AA4C4CEDD;
	Fri, 17 Jan 2025 12:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737117431;
	bh=C7ihVmOBoRg8/pOWpnsBxf68sB5l0kSj6Vonmuw8xuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mj5Kns1/fpx+c72LVjZ6q/gF+xXMZfwdjaBEDzrnIyaYXOBnkW9tXuyEF7tc0Vb8e
	 GWsKTbKd6RlGtfoMn59Yu42poWlGMuoDa2jIPMgo3hJ+BELiPAGM9MJ9EWiWE7MsL2
	 Nrv3QFHfDWKHKL8SfSkQQJlYYrwYz6d1qS1+ySC3wD9fTRzB3vOHN9pPbioFMrCCzy
	 gdsqtaJR7sS1Xw861NfkD4FknAi+Zv0TNjLMZZ1ZMKInZ5Dr+8Vlw25zi0NYMlkCpF
	 8BSHQ2FvGxdBljMiSU4vQaMm9tbTjn0rUKnbRqtXzCmPfUh/ol1tTPEs5C1BJGB5e5
	 RiJVaWfdomfVA==
Date: Fri, 17 Jan 2025 12:37:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v3 09/27] KVM: arm64: Factor SVE guest exit handling
 out into a function
Message-ID: <714fb3eb-630e-45af-bd72-be36b2bcb72f@sirena.org.uk>
References: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
 <20241220-kvm-arm64-sme-v3-9-05b018c1ffeb@kernel.org>
 <Z4pAMaEYvdLpmbg2@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D+TJE7NiAHLoddf+"
Content-Disposition: inline
In-Reply-To: <Z4pAMaEYvdLpmbg2@J2N7QTR9R3>
X-Cookie: Q:	Are we not men?


--D+TJE7NiAHLoddf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 17, 2025 at 11:34:09AM +0000, Mark Rutland wrote:

> I think we need to fix that before we extend this logic for SME.

Based on some off list discussion I gather you're working on some fixes
including this?

--D+TJE7NiAHLoddf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeKTu8ACgkQJNaLcl1U
h9DWvAf8DiOPECmm9haJpiLCtiiBARlyLnyBFEfgOFIDtmSO77aoxsMpBj0plUKe
1fKqnIcSudLGM/61UGkfK0e1CZxkb3DaDTq/zmVbTOBor72y033GymoiWIjDJB4K
53om+5RwuO/GP0Fb4X8ZTiVMMBVsFxbicJqreg69M1LfXFWYGAlA8aEky4iAMBKM
boe+xctRwbuYVFwWZYI5MjZQKkUOUw1YGohYgeRA3pk9XJnDWLRmYGXBVyGkdt8Q
sZkxkpMIhebnsiUenkNJC1Qb9yG0TiE1T+XuhJ7hRu28baG7u0W8FSWwxSYpqq5G
3JNKJQLbG/MSzuX9Vkp7Eu+uhCG6/g==
=wzZf
-----END PGP SIGNATURE-----

--D+TJE7NiAHLoddf+--

