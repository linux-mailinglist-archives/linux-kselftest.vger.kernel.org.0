Return-Path: <linux-kselftest+bounces-18930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D39A98E484
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 23:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BEE1C21A2F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 21:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90F4197A69;
	Wed,  2 Oct 2024 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTU7o2bj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC464745F4;
	Wed,  2 Oct 2024 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902874; cv=none; b=Yt9PdLEtWjCwoboRhwLjbYrYopgfb/Rzvs5b99QBZDFG8HTWjjOOg1ydPmC26oG6I3el2iJKSIrAoxnrLruxfeOGXGc4b75JvDEs40xXFIcssbQQTEPLanLTh4h31mI4TL+aNgS1Hqo/3w9j+/0HHDyAIMuERJPkrGu82GbegiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902874; c=relaxed/simple;
	bh=LRRZb5jbN3mdDq16uHd5GpfD2+xzWvO+kARF1tW0Lrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2JGsZ9oOPKcK8yceNnnbukyIyL4/tw5gjCsXIDvh54ylz9IWX2GdMd02+jOjo86cS0Ee4JMm7NyOfsaI7xgVvtgjrtWCrS2/WM7zAO0LTodWbOVnAXNxFJxnOWQ0FpibgQ0v3J70YEI52CO9lR7wuOgkBs2qDZUuBC8+378SdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTU7o2bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12CEC4CEC2;
	Wed,  2 Oct 2024 21:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727902874;
	bh=LRRZb5jbN3mdDq16uHd5GpfD2+xzWvO+kARF1tW0Lrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aTU7o2bjYGW+IyKz614dLl3om0M2iW4jlpprrpvFGHDktQxL7+5BcL9lmA73Eosqr
	 +oMyQs+FLNEH1mneB7CkqxM8U0G1QvvQPoAL/dqRbcvKkIl7HO+hubPbilIa5dNB0L
	 ocMyuRV2WRlIh3fzJFEZ5GnNQN4nexjPt8Swbw8zn+pssd5/0qTE4jxuLXlgy2iAby
	 r8dDumJ/LM2hqmm9GEcfKTc/rgrKTMhpAVqKtII5lSyyjDR9smNCMmivCnMz3k4OPd
	 oZMgaL2O+av2Z5HxLKxUD/Ah9r4dLt/Orxa1++sTHEokk25XRsgqEdOo0S2zqsqx70
	 3bxBo3SOxcmvg==
Date: Wed, 2 Oct 2024 22:01:10 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"jannh@google.com" <jannh@google.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"bsegall@google.com" <bsegall@google.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Message-ID: <Zv20luC6us-LEMqN@finisterre.sirena.org.uk>
References: <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
 <77bc051d-b2c9-4e3a-b956-be8879048e20@sirena.org.uk>
 <5464b915b52bf3b91ec70201736479a5347838af.camel@intel.com>
 <158190d9-a4a6-4647-84e8-f4ae036d984b@sirena.org.uk>
 <20240927-springen-fortpflanzen-34a303373088@brauner>
 <727524e9109022632250ab0485f5ecc1c1900092.camel@intel.com>
 <20241001-atheismus-stetig-4f6f3001715c@brauner>
 <6bf15851-03fe-40cd-b95c-f7e2ca40ac54@sirena.org.uk>
 <0999160fd5282ac129aab300b667af35d7251582.camel@intel.com>
 <b7ef38c9-1e87-468f-94a5-a3c7f209d200@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tOwcQFVW/KtwHJ9x"
Content-Disposition: inline
In-Reply-To: <b7ef38c9-1e87-468f-94a5-a3c7f209d200@sirena.org.uk>
X-Cookie: Editing is a rewording activity.


--tOwcQFVW/KtwHJ9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024 at 02:42:58PM +0100, Mark Brown wrote:
> On Tue, Oct 01, 2024 at 11:03:10PM +0000, Edgecombe, Rick P wrote:

> > I'm not so sure. The thing is a regular stack can be re-used in full - =
just set
> > the RSP to the end and take advantage of the whole stack. A shadow stac=
k can
> > only be used where there is a token.

> Yeah, I'm not sure how appealing it is trying to use a memory pool with
> of shadow stacks - like you say you can't reset the top of the stack so
> you need to keep track of that when the stack becomes unused.  If the
> users don't leave the SSP at the top of the stack then unless writes
> have been enabled (which has security issues) then gradually the size of
> the shadow stacks will be eroded which will need to be managed.  You
> could do it, but it's clearly not really how things are supposed to
> work.  The use case with starting a new worker thread for an existing in
> use state seems much more appealing.

BTW it's probably also worth noting that at least on arm64 (perhaps x86
is different here?) the shadow stack of a thread that exited won't have
a token placed on it so it won't be possible to use it with clone3() at
all unless another token is written.  To get a shadow stack you could
use with clone3() you'd either need to allocate a new one, pivot away
=66rom one that's currently in use or enable shadow stack writes and place
a token.

--tOwcQFVW/KtwHJ9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb9tJIACgkQJNaLcl1U
h9Bkpwf/c6g+k2PVrSLzsEUR3JAZSDFGui28/pfaqYsoTehL3za4CT5tjk1LE6YV
0T54vGR5M2n41vh8T//I4ItTAkb/Xs2p0FEsEqESF8a9LSuuFSdM3yp2woqwgeXz
FZcE6ysVZhHoGcChbWjtnDcrILmFR0VJAIUInMWYwsYam4LtHaW+YEO7NFBCtYPv
WS0BNEv+lGtTFbM8qNfFBWQGvRp+WkSUPKrpRThcY/UmXPqrrgd8E4d/U5qX/4GO
7f3+czgZpE8nz5hF8aaWSBwr/dARz7FvnSPdiDXuTASrPZF5jwURJWPQVrm6GoTy
t2qA84msWefPCTiBqxyKM/pYry5ifA==
=dR04
-----END PGP SIGNATURE-----

--tOwcQFVW/KtwHJ9x--

