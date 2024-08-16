Return-Path: <linux-kselftest+bounces-15534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2F7954EB0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 18:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75641F21435
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE22136E30;
	Fri, 16 Aug 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEcYCFCU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F404179A3;
	Fri, 16 Aug 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825200; cv=none; b=LngxmoQwvQcYr/T6+EeDkIApzl+TXU2u8xI5b37k6onIeMa2oyCMrTEiZNR/GlZK13ISoAinVWQT/xdQPPL0o5eC8Kd/PvY/U1Gp2J2CbHjwYZM/9y4wq0U8mHlFJh0onQkDaU2XJIOVnJHRJru1j3v6YH2tZ2g91yXAiFsj5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825200; c=relaxed/simple;
	bh=+wHgLCMoNBTbXfTrTddHqDd6dedGHf4s3xdy+t7NxlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7Soa4bPnr9ka+GInfE3u0SEhBvLVMTdxE87GA406emYc8A4L+km/nTdv6OQtC2R/hCHdFl1zEFV5WB35uspm+sZeXZ6Mfa0O4g3/ShAiDwp8Ta5XkYYa04q+pitbje0j6kCt6uw+tFwAkueN4k3jQMOyKJLTNGQcvNd3De2VFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEcYCFCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD69C32782;
	Fri, 16 Aug 2024 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825200;
	bh=+wHgLCMoNBTbXfTrTddHqDd6dedGHf4s3xdy+t7NxlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEcYCFCU28GMlOB2IagRpXWIRYODIfkp7pLUkD92oEiCVC8jh73ELOhQfPFcmZrN7
	 msmyGRQYAMH68iGk8lyq8E4UGqW8KiU4cDa9ilMwqEZ2NaoxgimByUqdNwreDVGWn+
	 Sd5pAScq6Ca1fZ2SQdczHJVekgUTh6Dx2pfi7t++RjrOTs1c7A5WFFA2OjumGuMwRa
	 FYWGT79cPaf42/FdXxN9S774iQjkXHKM87oDPm/thJwcfaLWAHAGluBEsegoDfisdX
	 Q8nXrYz1KaD0zOTNdek8K7zXyXWfAHl51H/UfAwr68yrsTHZof4G+TAE3CcqpxKLcw
	 Ehw0fY+/UoDOQ==
Date: Fri, 16 Aug 2024 17:19:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: brauner@kernel.org, Kees Cook <kees@kernel.org>,
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
	Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFT v8 0/9] fork: Support shadow stacks in clone3()
Message-ID: <ae718ea0-bcbb-48c6-8513-81c353d1729b@sirena.org.uk>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <CAG48ez38VVj10fixN5FYo1qujHSH17bPGynzUQugqeBRYAOBRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OAknQQKfG3OHJHRI"
Content-Disposition: inline
In-Reply-To: <CAG48ez38VVj10fixN5FYo1qujHSH17bPGynzUQugqeBRYAOBRw@mail.gmail.com>
X-Cookie: A Smith & Wesson beats four aces.


--OAknQQKfG3OHJHRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 05:52:20PM +0200, Jann Horn wrote:

> As a heads-up so you don't get surprised by this in the future:

> Because clone3() does not pass the flags in a register like clone()
> does, it is not available in places like docker containers that use
> the default Docker seccomp policy
> (https://github.com/moby/moby/blob/master/profiles/seccomp/default.json).
> Docker uses seccomp to filter clone() arguments (to prevent stuff like
> namespace creation), and that's not possible with clone3(), so
> clone3() is blocked.

This is probably fine, the existing shadow stack ABI provides a sensible
default behaviour for things that just use regular clone().  This series
just adds more control for things using clone3(), the main issue would
be anything that *needs* to specify stack size/placement and can't use
clone3().  That would need a separate userspace API if required, and
we'd still want to extend clone3() anyway.

--OAknQQKfG3OHJHRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/fCYACgkQJNaLcl1U
h9Bk7gf+IN6OW0esjGTwucGU05u2q8/D58PS0K6hdwW93kXXCfMIi6tu3LPKICVK
yx77X1fO4P4j6K56dl/hV7inTSFiOx+1YtUEvia0hYaAek3iml/kk4gyG6I2HMGA
xcqEI41t4zp0sedKPUO7kGoEi4eZLYADaC01jPgQy3QX3QDsdAyMIxWA5+7rmYyO
fsZcOJZ2NKOukJLa5y6ngTVxbIdjJQ/t3tMTpVeUyTCiTd5+ax9efRiyjzDH0KCV
uM8a9HUk18alrQpAowDgVYZp1dl6+FDJ8C6RBk3PvrwrQN8UN9HhqkZMzP0jJK3G
P0c78igE/ZZ4M0bl9hdPuEzJt5Yj9g==
=00pP
-----END PGP SIGNATURE-----

--OAknQQKfG3OHJHRI--

