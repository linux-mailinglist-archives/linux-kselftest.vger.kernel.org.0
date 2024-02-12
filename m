Return-Path: <linux-kselftest+bounces-4511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF50851842
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 16:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD101C217AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 15:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0093C68A;
	Mon, 12 Feb 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtg7rot/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6B3C495;
	Mon, 12 Feb 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752301; cv=none; b=nIq77NoTzF+sapVRo5NG2T5HlLUrirRZpxPvwU9rzuTsxPUAnPVwOzVpMkq6gL+g4CfXgMLowOyf9Wyna/FboxLFr8M3bGeyyOMoACVAbZh7a01CBEP8Ylc7jrvWMRisUeabS4TuMU/WMRvE4ffAzF4iBW3JAr6sqth5M9J1Iyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752301; c=relaxed/simple;
	bh=Cd/iw/5vcxyyYrBP24MEFOKZ+DHyFw+KqFdbcnovNVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmaGr67RGkBU5ECC+SWtemwzH0l6oBBLEGMWsYA3r2LYUiaLOsqZ/fiPGm8HKZL5vgWvp1z5mlFZdnf11mF2tTD+xOdAlGhMAPVoNAhOapysb2xg4yetwb+eGCoSW4UHZFwSN3uPqTf4czMfDgJ/EKchLCxJdZsfbMYHsjMlwI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtg7rot/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC73C43390;
	Mon, 12 Feb 2024 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707752301;
	bh=Cd/iw/5vcxyyYrBP24MEFOKZ+DHyFw+KqFdbcnovNVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtg7rot/f5QgzB4hgk/dy1zl482VuvbYzeiubONaxgc/E+2TLSHhzmiPn2bmw8y3d
	 oMTEwaSUCrG5M4GUmQ73zy04SBE1mzTNDVgLTps/Ff7d7TXI1cGV77ZmqCGMyU+jvS
	 XLlS2zoOYNHuTaqe/YjL5OVYbH4ynMz8bH6L6sCdR6XzZ68bW1pY8rzSQseKsG+hIf
	 30bdfCOuFqWcgBejHMzjUmEnDCHyu8iwMQ709w+PlKZPjTl3y1Fpj5ekQPSUCJJVBJ
	 WwR7WTCXMi04V2PROGhOKxE7bXGpyd3EOFNRS71TB7wEKO+22WOtAk3zEytYzPvCwX
	 Q+NwrOtJN8xDA==
Date: Mon, 12 Feb 2024 15:38:12 +0000
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"bristot@redhat.com" <bristot@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"jannh@google.com" <jannh@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFT v5 4/7] fork: Add shadow stack support to clone3()
Message-ID: <cc43d304-e24b-40fd-9205-fd27889e6a24@sirena.org.uk>
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
 <20240203-clone3-shadow-stack-v5-4-322c69598e4b@kernel.org>
 <565ca9697cf26be5509ef4b3c1cc95fa4f692b9f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XnIAPc9INoBAbmh3"
Content-Disposition: inline
In-Reply-To: <565ca9697cf26be5509ef4b3c1cc95fa4f692b9f.camel@intel.com>
X-Cookie: Will stain.


--XnIAPc9INoBAbmh3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 08:18:11PM +0000, Edgecombe, Rick P wrote:
> On Sat, 2024-02-03 at 00:05 +0000, Mark Brown wrote:

> > +=A0=A0=A0=A0=A0=A0=A0if (write_user_shstk_64((u64 __user *)addr, 0))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return false;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0return true;
> > +}

> So, don't we want to consume the token on the *new* task's MM, which
> was already duplicated but still unmapped? In which case I think the
> other arch's would need to GUP regardless of the existence of shadow
> stack atomic ops.

Yes, that would be better - if nothing else it allows reuse of the same
shadow stack for multiple !CLONE_VM clone3()s. =20

> I wonder about adding a shstk_post_fork() to make it easier to think
> about and maintain, even if there are no issues today.

I agree.

--XnIAPc9INoBAbmh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXKO2MACgkQJNaLcl1U
h9BqSAf+JmlarRUTbUjNy7XErOY1+sGJ7QrnXHdQSEcNoGjYbcTudWKT2BQBtPU4
25OZCFe6MnCp1WbVvkSJjlDsRZSWI0fgc/o04ZjWeCSg2vNekeC8PabqKBqGB6eJ
kPruQ3h37qAloHiol4sFqqRZKSingsICPpOD6K5SIpf5wtOHlBI6rh9kdMPxCAYm
EiD5bZJCR0WGUAqV7ntWMdT9KDo5W/qbH0RYCeEJlnKBcku1QhfDXu3ixhfjm5cH
uSQCQnE3fEUu78UJPfbFmnhLW333PHKcZPNRDp4sL4ImxIR/YQyuXrkX05UscKvv
nWPnxHSYJ9Rv3JB2RMXeeQCfd3cEZw==
=ZDZz
-----END PGP SIGNATURE-----

--XnIAPc9INoBAbmh3--

