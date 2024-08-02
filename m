Return-Path: <linux-kselftest+bounces-14714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2D19460A1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 17:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19B2B2155F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 15:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1302B175D56;
	Fri,  2 Aug 2024 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+nqwhbL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9297175D20;
	Fri,  2 Aug 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613034; cv=none; b=DhVBus1k925WSiC+tz0pS3Y/BGO4xuG9uk8CjPDoZuJpzdV0hi1aZ3Y3bzHAFYRQRbj0dhBC0dVWUUr0nQKa7Wj7dGFtkanguOb3Tm4pquKkfx0DLmXU3dVGyzsWOkniPB6pZEaPhZX4L61eJGqm/JdRBmlKL2hXtYnBZbPjcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613034; c=relaxed/simple;
	bh=dafcIMIFQ0h0l81bhDdDQdZSYzceSCxC/WQUrSCPbq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkDiFl1iL67SeDFwBnSnKlr7dmr891+ef4I4Eq07WCfCSXCBoJQxM+yxFlljoeZw2xDNh7ULDtbQfWiPHiJxaqVO69d1HDim+ZVoKtGRTsp4BC5V5U8VorPL2ZqHke8SyWQVWIxFsRxaWkGNkMU/zusbDtUAtmUaDiFBAHoKVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+nqwhbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A224C32782;
	Fri,  2 Aug 2024 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722613033;
	bh=dafcIMIFQ0h0l81bhDdDQdZSYzceSCxC/WQUrSCPbq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+nqwhbLDqg9WLMmo6qO5CUc0nGxweOF6qOZNV4YQoCBs6w8Cy6LESjA6caXD2/1S
	 UII2U8aAj0/awwNKTHibEOCrVQ2KMHhPh1Hg+G+5HTHwyGlBLRdwqY3mE3jYmep/2H
	 ygwjyb0l9NwE3R6OAiR0MELlIx3KmEs6zuGeTFPFL0E0w+pSqOKkVkkGLdZMs4Im3T
	 tENhNC1eihGIfnzEsoW3CcAiIVWlZ2Yb7wUqccqnN1S4dvY/ak140LZ2G1keXxvqKG
	 yJ/kNaPqmSxjGGR2cdwXutP2UZOb8ZosWYR5rcgC0ng/r9Z3RpnaZ7P7Hs1xgcRc0+
	 iUsug4VRc/iHA==
Date: Fri, 2 Aug 2024 16:37:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: arm64: Correct feature test for S1PIE in
 get-reg-list
Message-ID: <24e95f62-bae2-4379-ba81-a46b7a7a0cf5@sirena.org.uk>
References: <20240731-kvm-arm64-fix-s1pie-test-v1-1-a9253f3b7db4@kernel.org>
 <86le1g19aa.wl-maz@kernel.org>
 <811ea0eb-bc87-4ac3-8bca-27c787e43051@sirena.org.uk>
 <86jzgz1eqb.wl-maz@kernel.org>
 <7b9b3ef4-66da-4314-8265-5947998758e9@sirena.org.uk>
 <86a5hv11yp.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9axSuRjXIbAji0fO"
Content-Disposition: inline
In-Reply-To: <86a5hv11yp.wl-maz@kernel.org>
X-Cookie: -- I have seen the FUN --


--9axSuRjXIbAji0fO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 02, 2024 at 02:36:14PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > > Not for a point fix, for sure. And if you do, make sure it is entirely
> > > scripted.

> > When you say "entirely scripted" here I take it you're referring to the
> > list of registers as well, and I guess also to the information about
> > what is enumerated by which ID register values?

> The register list is indeed the #1 offender, and that should just be a
> script that goes over all the occurrences of ARM64_SYS_REG() and
> replace the encoding with something that uses the symbolic name.

Oh, I see - the scripting of an in place update.  It sounded like you
wanted the tables generating at build time (which I do think should be
the eventual goal).

--9axSuRjXIbAji0fO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmas/SMACgkQJNaLcl1U
h9ArUAf+K3CnMFpO7TV27aodB8mRTj1ui56EgH9rzWcITM4f5M++jv5jAAbeP3xi
GHwzm6i/kKECrko7I+JvK7MomcY9ZhbrdPiYrHohMA0SpHDhUMLJS4sEo77cNs2E
sYDTFtkgJcWKi3htQOF7FYFKA9J7a5muzRNRsMzI3hmW2Tu2MZoblpD45/hleU3O
aoVsut9qXWiWl4K6SqwwNMwdmhKJ4p4qPTqx5IEsZQNydQX4KHWNkZ8HhKIwpU42
od6tZAupRFtj8A9fRf/ij805dICTpoc7LTxIsm9N2ZkjKKjyJtTfy5ddkCEzketH
Ah9pv1mPTa6KcTcrgrujjzBEP6gCZg==
=5iSv
-----END PGP SIGNATURE-----

--9axSuRjXIbAji0fO--

