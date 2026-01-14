Return-Path: <linux-kselftest+bounces-48967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D915D20E4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 19:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D12D9304EF78
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 18:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E954D32E6BC;
	Wed, 14 Jan 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/3YuIa8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36EF296BB7;
	Wed, 14 Jan 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416520; cv=none; b=S2UpYv6x/s2JSydgbWz9+zjwTO6yAB8tZ8hGNQerrQ5ElG5nvut2bDghmJk63lys/CIqPhpycHw09dg+QdRZNa7CNgr8m2WGiKWH4cXuvu8XyhZjvbzqZpl15xP+wTozsu/LsvoXhlTgkOiZ2IrBGlDx8suHxxrqdcxh2JOUrKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416520; c=relaxed/simple;
	bh=8KBWIbkpJwQyTeH+b5e850ZKQFUEMxvg18f8SI8BdoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtXKoPGSXr+NKSzSiNg5bbDMjYa/lY3REtzaMsJ7684sugDgBLG+H53UiIEiBXxJvX/TfklAnZbLY1BhEMXyonr/CxRg/oci4JMI2psqAXFefN7ff9+y/wtrrFHZbg/c3S/VkBElgrGN/nDFdnBoSzrVaVSpIpQHzGe+PPfSugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/3YuIa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C58C4CEF7;
	Wed, 14 Jan 2026 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768416520;
	bh=8KBWIbkpJwQyTeH+b5e850ZKQFUEMxvg18f8SI8BdoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t/3YuIa8oSi/xC/GW3dpb1lZoupC4+ZqSiMYqsiRYtEJqPu5VpCncmLyynSJcab6m
	 lBJCYevFVEIqegwtLZxHvJqoCjsSXqVVmVsUGI2i5/xAgIiynXIiqV3aVETrQ8pzsj
	 j/r3LUKh0rJQ7on5AQeo4bk0Y9Xj1uCAYfpwyc9l9iKtksfZ0yQ/yrGOwPx+9pRZO+
	 FlEG6BL+gLBeSR4cWfZovOpnukvKBAAhf14aDSHc0HB+ZCwyzzyOikgCTwD7+I5dJw
	 RenN+N1iQg2SsDCExcca65J2x4S77imYS+qqfgCjzcZzgOuVQUnogF40oQgmb+PTt6
	 U6IahqNfIZSFA==
Date: Wed, 14 Jan 2026 18:48:34 +0000
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
Subject: Re: [PATCH v9 26/30] KVM: arm64: Provide interface for configuring
 and enabling SME for guests
Message-ID: <3be5b6a7-3b26-4899-8313-c849c28300ca@sirena.org.uk>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-26-8be3867cb883@kernel.org>
 <CA+EHjTxFfY_XkEQrNvme94uHoxQLWEaX1q1MikbcmwmUMq=NwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oq+yxN5i7kBipvCG"
Content-Disposition: inline
In-Reply-To: <CA+EHjTxFfY_XkEQrNvme94uHoxQLWEaX1q1MikbcmwmUMq=NwA@mail.gmail.com>
X-Cookie: Absence makes the heart grow frantic.


--oq+yxN5i7kBipvCG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2026 at 02:40:58PM +0000, Fuad Tabba wrote:
> On Tue, 23 Dec 2025 at 01:23, Mark Brown <broonie@kernel.org> wrote:

> > Due to the overlap with sizing the SVE state we finalise both SVE and
> > SME with a single finalization, preventing any further changes to the
> > SVE and SME configuration once KVM_ARM_VCPU_VEC (an alias for _VCPU_SVE)
> > has been finalised. This is not a thing of great elegance but it ensures

> With KVM_ARM_VCPU_VEC being an alias for KVM_ARM_VCPU_SVE, wouldn't
> kvm_arm_vcpu_finalize() fail for guests that have only SME enabled but
> not SVE?

If one of the extensions hasn't been enabled then the goal is that
finalizing should lock in the current state and prevent enabling it in
future but you should be able to finalize.  The check for vcpu_has_sve()
which blocks finialization is changed to vcpu_has_vec() which is true if
either SVE or SME is enabled.

We should, however, ensure that the VL of disabled vector types isn't
taken into account when allocating state in order to avoid wasting
memory - I'll update for that.

--oq+yxN5i7kBipvCG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmln5QEACgkQJNaLcl1U
h9Afugf/W7S3f9Opih1jYVPqRq1ITFPwn4oIVQt8vWQtOp6phpgeaEbVAIaBYQIe
eD4G1cgA3KXUU+K2fKQo2Ar61nctTEgEr+58MPeuamj4Z1hB2a3Vy5hTGB5LyIv9
U1EE5voSYFgHHl9+EZafvLf6DuTiPu6MksgwgBDiYvXF+sxtbZSKMHRPMVSYw8BQ
CEtdcOsodX04euF5khtGm1eSiHeJKuUAaPAEuqMYrFbMSzUHm6MZWm9rWP9JV1Po
p57BJt8/aUj19+5Q0LS6gnK/ozmrxfxf12t+3HXTcVxD79OOh1Tzw9DxwLDQVhnA
PbSht5ECwKz//OhF0SUzlplD7m5Wwg==
=bu0G
-----END PGP SIGNATURE-----

--oq+yxN5i7kBipvCG--

