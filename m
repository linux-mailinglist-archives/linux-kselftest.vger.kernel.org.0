Return-Path: <linux-kselftest+bounces-41886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AD5B8654E
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 19:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57B07C686D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1F283124;
	Thu, 18 Sep 2025 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soMw9Xnj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B014B06C;
	Thu, 18 Sep 2025 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218171; cv=none; b=dA53Rrty9dNcgiKUeRAojChBdx34kAPsT3wz+HzggCc84wSBGn9CnG34ulrFVoJJKd7lDB5DtBDrYZU7qo8rdqYspIEoeHEAq171eAT2Al/HEGGQNrdov92w2LCPDdifPUUado/jg2FoLC6cA6eB70yZVPjU3svh/6TRnwkIkY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218171; c=relaxed/simple;
	bh=mEfVkBpEmX4LqDSdnh5MGlyopQoeHAPLnvqvAtXytRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJb6cXPcpkaMuzjhp8dUbdWlGoyq2J9FcqOhGMFvyJyRDn/XmVpmieMEhvFi313SzpKGRF7z2JE4wr3IpTjnrGueFzV7iMmlZBIdU7lOOwzW5Wq1y6ldQorrH9Chxc6Z2jiTY1AT7kGNvcPnPqp2ujYqrn/UnXaJtAHSoWtTFkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soMw9Xnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD01C4CEE7;
	Thu, 18 Sep 2025 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758218171;
	bh=mEfVkBpEmX4LqDSdnh5MGlyopQoeHAPLnvqvAtXytRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=soMw9Xnj+exAZ2k8HgMA91ndd6uOHczKxaGV9dhZx9DL3fmpsG3RkkqOQKF8Dgo0m
	 ou2AY8VcM8wE7AqAa5ioL45ieaVEOapn85yGQRf+EiIUv8hTFsXNgwcTCwu1y2O6Zp
	 IeMOKHjRkHg0LNc6PhPP7lu+n2iiX3HCw4E/uvFrO74qag4qYtUb3G9ZdqmKsC9DX4
	 3pxZ2+ipeB+WyBXaOvrqoMK92Cbn8IxcWyBBXesgf32AP9SuvuzKarbTlkp8EOGcTl
	 UyDbvx6rrmuLhWCkAHvQeQXluiGnULUCyDrjnZzJ6+jwbD98sg2pstQGE4de9eOpqb
	 9jHtxj2T2gtEw==
Date: Thu, 18 Sep 2025 18:56:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: brauner@kernel.org, "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>, jannh@google.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Subject: Re: [PATCH v21 4/8] fork: Add shadow stack support to clone3()
Message-ID: <21954e72-94e9-433a-a155-222c9052d4c6@sirena.org.uk>
References: <20250916-clone3-shadow-stack-v21-0-910493527013@kernel.org>
 <20250916-clone3-shadow-stack-v21-4-910493527013@kernel.org>
 <aMv9XRq_sAQbQwjI@willie-the-truck>
 <aMwtdtRHT7oHhYLf@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XiyciUMuZFVOfLZH"
Content-Disposition: inline
In-Reply-To: <aMwtdtRHT7oHhYLf@willie-the-truck>
X-Cookie: Victory uber allies!


--XiyciUMuZFVOfLZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2025 at 05:04:06PM +0100, Will Deacon wrote:
> On Thu, Sep 18, 2025 at 01:38:53PM +0100, Will Deacon wrote:

> > It would be great if Christian could give this the thumbs up, given that
> > it changes clone3(). I think the architecture parts are all ready at this
> > point.

> ah, I may have spoken too soon :/

Well, there's also the fact that this is based on the vfs tree (or would
have conflicts with it).

> Catalin pointed me at this glibc thread:

> https://marc.info/?l=glibc-alpha&m=175811917427562

> which sounds like they're not entirely on board with the new ABI.

I think we're getting there on that one, and the main thing they're
asking for is the ability to reuse the GCS after the thread has exited
which would be orthogonal to this stuff.  I see Catalin replied on the
glibc side so I'll direct most of my reply there.

It would be really helpful to get a clear idea of where we're going with
this series, it's been almost landed for an incredibly long time and
having it in that state is getting disruptive to doing cleanup to try to
factor code out of the arches especially with the RISC-V stuff also up
in the air.  I do think the issues glibc have with this are orthogonal
to the changes here so hopefully this can go as is.

--XiyciUMuZFVOfLZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjMR7EACgkQJNaLcl1U
h9D1nQf/S4za9m0EXxhhOOufFtQwWatoF5T4w9ZO30g2u5/wuQAFZeTtARtrFj4I
Xm26dM7BBBElSdWXIWVxzROT10yXZTN0Hl50o6jhgohNXiV+Bf0dpAR+rGHp7sDh
0/TpMZMKikrTMhN89mQoHzvIktHJW1v14t3eUTrE/GZaPMdoIg1hIGY00tEVSArg
nraXjUQMb4uSswTMGJWAzMIiQWQfJ7A+7Yj7Zu14xD+cY55s+xVeAQ2HmRufGpkB
k7LBGaC7bzkqn7QkqMbwF558gcSC3Nl0WEvzndmxg4i9aN+Xafl4+kQVogguI39S
UfARm8uNUebl5zS2zY71r5esgHQCXA==
=Qji3
-----END PGP SIGNATURE-----

--XiyciUMuZFVOfLZH--

