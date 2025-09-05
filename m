Return-Path: <linux-kselftest+bounces-40856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2D2B45D5E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 18:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67BF3B0509
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93B32F7AC8;
	Fri,  5 Sep 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oksLV3ps"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D51DF73A;
	Fri,  5 Sep 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088162; cv=none; b=SoLRQlm7UBY0T6xGMeyTXiasmFk/wiKVRwMyaT1H0pp1urUxRDrI1EdYiExdxJxZxVQPsffJmaZ6xVXNDJQ9rhWL20k54+newb6e7NXxZC7dbMJIaEoVn64RnbH6V5f0iELJTCVArY4hQ9NVFuEMPIbt5VT9krnQsEMKwcuQLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088162; c=relaxed/simple;
	bh=PlMlS0cF6RcEgdVdv6/9YJ/SnAbrlAGo6z/ImCbfQ9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAYVgJ3qkd0Do1HizTCx7lbZItJIW/Zfg1FDoyb8La2k7dO/IQPaYAzwOLATni/PIgydKMbI/irbHzeUl8DVkLU1OK0ONLJw8N8bJq9J7Wpe9mDCerPIxC3gRV1S5Z6LzGzwddHBXxgtF1aOzZLxe03xZKP1SapFlO7RQCsSW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oksLV3ps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F60AC4CEF1;
	Fri,  5 Sep 2025 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088162;
	bh=PlMlS0cF6RcEgdVdv6/9YJ/SnAbrlAGo6z/ImCbfQ9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oksLV3pstoyjM04jR59r7HDJMAPpjw96BLnkKRe3FoyAOKk034FH5EXeWVp4ndFhm
	 ocMwKILyNSqBh/jpfxrmQt7CB/JyWF89l3A75KCrpvo4YEqLth29G3fNJ2FfxJtK2o
	 fhUze9IcJZ+taijz1P4APglZf16/GgFHxeRkGECkTj9kHjxLNIN8q0bwQT/33FMa1p
	 E/Wguu8s5STe5U/cny3G8DL0Mh0nmGBWBKkSMj2YaAug2D5NUURjD/hXhLH5TLQMax
	 e4tdCuDadUbWBmtSb47DpXmmcrzylO0oN8xkqKPofSrM1TXfYxHprX411mPPAoucJL
	 TwGGaE0t8hEtw==
Date: Fri, 5 Sep 2025 17:02:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v20 4/8] fork: Add shadow stack support to clone3()
Message-ID: <8caf310a-7179-4d4f-be73-2e25496a915f@sirena.org.uk>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
 <20250902-clone3-shadow-stack-v20-4-4d9fff1c53e7@kernel.org>
 <20250905-nutria-befund-2f3e92003734@brauner>
 <0ff8b70e-283f-4d56-8bab-bcae11cd5bdb@sirena.org.uk>
 <202509050900.8A01B1E6@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bXrw6/8HL/Rx0OhI"
Content-Disposition: inline
In-Reply-To: <202509050900.8A01B1E6@keescook>
X-Cookie: He who laughs, lasts.


--bXrw6/8HL/Rx0OhI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 05, 2025 at 09:00:51AM -0700, Kees Cook wrote:
> On Fri, Sep 05, 2025 at 04:43:22PM +0100, Mark Brown wrote:

> > discover the problem fairly rapidly in testing.  ss_token would shorter
> > but the abbreviation is less clear, whatever name you prefer is fine by
> > me.

> Bike shed: shstk_token?

That also works and is fine by me, probably better than my idea.

--bXrw6/8HL/Rx0OhI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi7CZgACgkQJNaLcl1U
h9CrTQf/WCF6wuB+D6VB3gd3Hwp4LHFCaxlsSWrgZUbnjpWWCM08n5HtahpJQU8O
YvIELSrRv5dmbBn8Hzn2M7X+NPPpT+n+xAa2SbCn23vwzdc/OwCdMC7NcxgUz+le
Yhf8wY0oKbYne7lNywwSgIkXfAF2fMtZQDP+WSvQGshmLKJeUy/zkJ0k+s83s+uG
gp3ASqFusWUBQPASJw5VFejhmRNSpYVW7wDj7tGdiXnYisBjY4zyqx1amoNbYixO
6g8paBiH4Qk370DRV2FTehhpeiaeuhgp84ubwYPl6Au+jpYOWCsAT1rxF1V/qxRL
TyUdPnZPdiCmmhKuj27gvQ6NSKTjcA==
=upgs
-----END PGP SIGNATURE-----

--bXrw6/8HL/Rx0OhI--

