Return-Path: <linux-kselftest+bounces-18898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F1E98D6D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 15:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516A41C22419
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729C81D0B87;
	Wed,  2 Oct 2024 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxanbP6k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456AD1D0164;
	Wed,  2 Oct 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876578; cv=none; b=O1rgoy0VT3IKnww+//BrMmJUOtfVti090cQiWu2zgZCbbLIoOScemaI2VOW9gfjH/sj2N3eeqxEktAmXh2840F5ZOk+DSeh9kl9eGrMxJkAXjlkAYEXZko18E2cfjcvkJadZCxtV0OXiK9dCRzk2zX0vooVizccR2CVvt9HdaTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876578; c=relaxed/simple;
	bh=mnR+XM0NLcG4YKhTB9RsqvHcFQ5UPkjI6KL9XwTdtoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gn+HRR8DubQwhLL/dCsExCJ6oepHQtEQm8o+OXHSY25u+p/DVf3bm3Y1yVSgy7GEHIax4dBwiMK4pROrr/XtAau6E2dm6xJnS3HLIy6dqCMyqApWWSxbcEJAT/yHR4CF55dZY1EpCwWYBWSHsX7p7UMJVwmm5/audJngOUQoz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxanbP6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C108C4CECD;
	Wed,  2 Oct 2024 13:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876577;
	bh=mnR+XM0NLcG4YKhTB9RsqvHcFQ5UPkjI6KL9XwTdtoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxanbP6kRLwuwRYfu+wOMj12AeayFuB95DYdWr5E/x4PvyFOoKiCl0cFhp1AMmmTa
	 UGZ3vs7jRYH+anJ6NdIxvROfYkJ40+bgm+FcXUZOibasdawD1xHAspy0tu9Q3uRQKD
	 uqyaPvXz7V3sWqqOEkeA3L1ngvqf9ZK5ZgBRe52yXaphFDtex0FXrBYpcjT290syXC
	 BKVIxh/WyG0PqdInUchTUOCrCN5hJ9HifuWgZzeR7+70vFtZl8/Kltm7gr0rLmEDwx
	 0lYhH+bGouuqSNmuGq1KjAcbkbjhpSYCstMqVa06vKrkFI3yD6Ep0OEKmdrL3AyYAb
	 kAWk4dWkSdI7w==
Date: Wed, 2 Oct 2024 14:42:48 +0100
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
Message-ID: <b7ef38c9-1e87-468f-94a5-a3c7f209d200@sirena.org.uk>
References: <5643761f-cc38-4e41-9ddd-f0a1934f8724@sirena.org.uk>
 <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
 <77bc051d-b2c9-4e3a-b956-be8879048e20@sirena.org.uk>
 <5464b915b52bf3b91ec70201736479a5347838af.camel@intel.com>
 <158190d9-a4a6-4647-84e8-f4ae036d984b@sirena.org.uk>
 <20240927-springen-fortpflanzen-34a303373088@brauner>
 <727524e9109022632250ab0485f5ecc1c1900092.camel@intel.com>
 <20241001-atheismus-stetig-4f6f3001715c@brauner>
 <6bf15851-03fe-40cd-b95c-f7e2ca40ac54@sirena.org.uk>
 <0999160fd5282ac129aab300b667af35d7251582.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jMJGTXcgxFsF8Hxq"
Content-Disposition: inline
In-Reply-To: <0999160fd5282ac129aab300b667af35d7251582.camel@intel.com>
X-Cookie: Know Thy User.


--jMJGTXcgxFsF8Hxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2024 at 11:03:10PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2024-10-01 at 18:33 +0100, Mark Brown wrote:

> > My suspicion would be that if we're doing the pivot to a previously used
> > shadow stack we'd also be pivoting the regular stack along with it which
> > would face similar issues with having an unusual method for specifying
> > the stack top so I don't know how much we're really winning.

> I'm not so sure. The thing is a regular stack can be re-used in full - just set
> the RSP to the end and take advantage of the whole stack. A shadow stack can
> only be used where there is a token.

Yeah, I'm not sure how appealing it is trying to use a memory pool with
of shadow stacks - like you say you can't reset the top of the stack so
you need to keep track of that when the stack becomes unused.  If the
users don't leave the SSP at the top of the stack then unless writes
have been enabled (which has security issues) then gradually the size of
the shadow stacks will be eroded which will need to be managed.  You
could do it, but it's clearly not really how things are supposed to
work.  The use case with starting a new worker thread for an existing in
use state seems much more appealing.

--jMJGTXcgxFsF8Hxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb9TdcACgkQJNaLcl1U
h9Bhgwf/RLTwlOEBvHNWnum583EyjziOq63r48YgG3FKhtlqWzQ2Ms2cPSj/NbRE
ouuuZoJPg1hXcc/dnyD9/5rS9aI7L6Qdjp9dA8fdDiVQF1Wt8qYFJbveMJqVUL/a
vS12BXtV/zt2kbI9zndAqds654g0UlIFax3Th7G2q7yIA3oCUvJa/uTzWLHhpVpG
6xSIwTqNoHV1UXvmjOYESlItBmfPAS8G6x7en7D/leUY9QAANG89u6dBEdPBZeWy
2/Wy/6bPtSqWZfHmQWqjUq+GyqJ1sca4uMHDLwAEErbMKUap8qkimmlCZ1iliTNL
68j6HsRp+8G536NP6/c69ElIFLnJWA==
=EK0V
-----END PGP SIGNATURE-----

--jMJGTXcgxFsF8Hxq--

