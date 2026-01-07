Return-Path: <linux-kselftest+bounces-48394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25076CFD74A
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 12:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 923DB30019DA
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 11:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EACB3148D8;
	Wed,  7 Jan 2026 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHmLJTvw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962030F545;
	Wed,  7 Jan 2026 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786301; cv=none; b=gvUYSJXCapGdpRwrTUNgJ+NyJlGq4TnLs1oPqlvbCZ0wH+1d6XQXociAFfPCPrQ/5bfXWdXRqYaUp0L68xYAh1gIIuhwWCGrIjj87v60jsIqEEYFdyFUVlxu7Jvev4LnNTDXY5OmExT0EusqI5e6d8mMiG31mjwGNgibkbwi6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786301; c=relaxed/simple;
	bh=U78ONRWmwz2WH/BhLsJ/KDqiXNz0V6xhHYfAOq6nW7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzQ+u3dPVFguaObdMWM+ap8tqUjjrOtgUUeTmJCCISH63XQSoS8VmzeMCVhQf4LpxQY8NVwYX40lz6hzUz7VmiLYE/Awe1zG2zpWJKs4fTizGBXdjgZ1vwCJsHUuu54kNOU94pB0DKqnCubHKdax9mqKmyx+k0Y4rHz1JvBdn98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHmLJTvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FDDC4CEF7;
	Wed,  7 Jan 2026 11:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767786301;
	bh=U78ONRWmwz2WH/BhLsJ/KDqiXNz0V6xhHYfAOq6nW7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHmLJTvwbkEgKWAHytU4pXHG45MFBbx9IxlV1oUeeyYDJOKamHdPBPbdD+ory6KXy
	 zDV25YkbE3RgIgJuMbGp/FFSdatXOQjhIsYxrFFFow1C4NfMWc2PphS5Oo4OOxGdMh
	 Ais7luwAxY0q1r042+FOg4Kj9PMQKvApGVdGY9SS5QuJLZStdO9UBwUDp5fhjWkw+9
	 zeQyuvv4lS9czEq3mqnV0PVUxtTIIStu3a2kOdasaqAVhanVRiPy4vNO5X+Smug1SD
	 19YN8Sb3QfysNMnpVDDr9APvY1FIdB0XwN5tbrxiTpudd1vqZHLtt8t+Zus0tmMqV1
	 d4I+41lHm7fQg==
Date: Wed, 7 Jan 2026 11:44:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Ben Horgan <ben.horgan@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] KVM: selftests: arm64: Skip all 32 bit IDs when
 set_id_regs is aarch64 only
Message-ID: <e1907b3a-416e-42d1-a682-4ea514572b64@sirena.org.uk>
References: <20260106-kvm-arm64-set-id-regs-aarch64-v4-0-c7ef4551afb3@kernel.org>
 <20260106-kvm-arm64-set-id-regs-aarch64-v4-4-c7ef4551afb3@kernel.org>
 <4cb1ad60-f8cc-4efd-9c9d-9ae52001e547@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u4ub/+ka66XeoUsW"
Content-Disposition: inline
In-Reply-To: <4cb1ad60-f8cc-4efd-9c9d-9ae52001e547@arm.com>
X-Cookie: Is there life before breakfast?


--u4ub/+ka66XeoUsW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 07, 2026 at 09:54:58AM +0000, Ben Horgan wrote:

> Not touched in this patch but the check for aarch64_only looks suspect to me.

> From main()
> val = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_ID_AA64PFR0_EL1));
> el0 = FIELD_GET(ID_AA64PFR0_EL1_EL0, val);
> aarch64_only = (el0 == ID_AA64PFR0_EL1_EL0_IMP);

> As we are concerned with system registers that are accessible from EL1 and higher
> should this not be checking ID_AA64PFR0_EL1_EL1 rather than ID_AA64PFR0_EL1_EL0?
> Not sure if it makes sense for the two to be different though.

The affected registers are ID registers so they're always physically
readable, the entire ID space is always accessible (the otherwise
unspecified registers read as zero), and if you think about it for a
system with AArch32 only at EL0 you still need to know what the EL0
features are from EL1.  Like you say it's a preexisting thing either
way.

--u4ub/+ka66XeoUsW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmleRzcACgkQJNaLcl1U
h9AVJgf+Mn/sKDgmo66c5NvxoCXjOoZfe7OcF1vxptR4Xhi48ZKjiIIfsvbXBmO4
t0/y5Qrj32kojFEURmi4jDtycN6dUxXRrzJtiwoyUMYGnJGFx2bjPvWytAmcpYiH
wZ1Zjcvyje2tyCxxS8sZ9W86uwjtEb9nR+T1cythwqdQDAb7odZ9Dp8h5jnv/3I6
DtuUA+3f7H0dUWr15UGFTolCAP3Si3VISKgLTpolcT/rKMA+An9fYfYbt5OzA2r0
NLqvIMHKMTIXG/EReN6q1DaKEI0Sn0/ymrMdEMb5xglL+7Myd96RM4lxw4zZISXl
ZeHydmawsPpyhxY3Fn5cySG+pvAV4g==
=RS5q
-----END PGP SIGNATURE-----

--u4ub/+ka66XeoUsW--

