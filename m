Return-Path: <linux-kselftest+bounces-6993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A97E8959AB
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 18:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6391CB2CC1A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B25414BFB6;
	Tue,  2 Apr 2024 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sc1KfrtT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D414B077;
	Tue,  2 Apr 2024 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074843; cv=none; b=Q5vM6WaGSz7TSYnMPh3v2KE2xvyMKZzthk6OJvFLaHWFGG8yHAenRLA6W6ezEnVDDAEMKqUF4dQ7r31cvhOY93aRcvTa+MfQxRmJg+Jstnkn3vPqgABXVjiT/3WTZSYWFrg/+1phIdIsVUW4rLEbYfIeo4hOKgjJCmZGtoV0Ewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074843; c=relaxed/simple;
	bh=1nEuOFAWZ57fj7SwvMx9awMLbIaQIeYglVGlMpWXeQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T89A9h7lOhawF0MmjI/cqXcZ4lR4P0uf6lce7GAlHeJ/Yjay/aUz/jsCaWp0wxBkKOja/qblxdO2poH9gZE92Gu4JTTMcP9rToljA8vrO5kTZEr1Cy5auMy3U8rK3EdY2oCIYAtqGP+WbMdvVZqxTqFaEXPdEitIktyfEjPpFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sc1KfrtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64C1C433F1;
	Tue,  2 Apr 2024 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712074842;
	bh=1nEuOFAWZ57fj7SwvMx9awMLbIaQIeYglVGlMpWXeQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sc1KfrtToUvAjh9YwNkASIEnW2mKzUNCuV7C5CoOKKA68BM1WZcr63qdMLRvbOfdn
	 5tPViqvFFNvnb3yhZ4Yv9ijd8gFBfRuUtEvRKmid8CR8lq+kSkauZLdvnAMU52RPqZ
	 QA1iZyLMa/qz7/mghKhjCpds4O4Zmyq/glyN/k6LYahZjcyImQ4A7OQkpQ1laZ7GgV
	 ip7cPgWNZJIDGusABNuZLmquTrGlpNTGUA7G+PqxMl2PW0lIyPgEzNU3wqb9LmOjOF
	 IoEZG8Iy1Z1eNOZbs707mv1vd593dmo3EPIF3nrywfERER2Jmk3aiDQaMldIz1kkz5
	 g/yJlS9czCHmg==
Date: Tue, 2 Apr 2024 17:20:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/5] KVM: arm64: Share all userspace hardened thread
 data with the hypervisor
Message-ID: <562e1ddb-75e5-4c02-83ea-b946b88d35c8@sirena.org.uk>
References: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
 <20240329-arm64-2023-dpisa-v6-1-ba42db6c27f3@kernel.org>
 <87msqesoty.wl-maz@kernel.org>
 <fb54d7b0-9c83-4a0c-a08b-b722c9381ca7@sirena.org.uk>
 <86h6gju87m.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZsRoYufVRq8HDIbM"
Content-Disposition: inline
In-Reply-To: <86h6gju87m.wl-maz@kernel.org>
X-Cookie: Knowledge is power.


--ZsRoYufVRq8HDIbM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2024 at 03:53:33PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Sure, those patches are still in flight though.  It does seem reasonable
> > to target the current code.

> Sure, if your intent is for this code not to be merged.

> Because it means this series assumes a different data life cycle, and
> the review effort spent on it will be invalidated once you move to the
> per-CPU state.

I don't have any visibility on when those patches are likely to get
merged or the general practices with in flight serieses here, last time
around with some of the serieses that were in flight it was quite late
which did make it unclear if things would go in during that release
cycle at all.

The amount of churn in KVM recently and long periods where the relevant
patches are apparently pre accepted but for various not always clear
reasons not actually merged is making it quite hard to target, you're
obviously going to be a lot more in the loop so this is doubtless
clearer to you than to me.  It's also been a little unclear what the
expectations are for basing things on - some people do prefer to do
their own merging for example, and while you have mentioned your in
flight serieses your communication style means that it's not been
entirely clear if you're just noting the overlap.  Is it just that
refactoring series you want taking into account here or are there other
in flight serieses that should be rolled into a base?

--ZsRoYufVRq8HDIbM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYMMFQACgkQJNaLcl1U
h9BDVQf/cg+fzd23KIrGiAWOOdVY4LvIfnSbQLI4D21tWm3gJlGZ6eImlJ62QQAU
8JaTbACh3U8/tV6s/6g6FUKVobLvFA/iU1+n4VZEQ48Ff4f3o+TWJQVAwpGq2PXJ
mkpNQmxOHLPIoE2oGDz3sSBu+6A888trmpCyidGfy8NA5+5N6JPAV8wlv57XBo/C
tN+utUoWo9Kk4wQEcuimfo1hCIKWQDY/wtDLfCsgjTdEvelyGo/fdGQwmb4fskoV
LIi/ZxVwlhrToV8IqnwYirKQLt0eeE5oy0ExSfR26SJP8d6uFzhEFzyhSPx3aCJd
LcbhFstoGtpCqu90KCaYfleTeza12g==
=lAvr
-----END PGP SIGNATURE-----

--ZsRoYufVRq8HDIbM--

