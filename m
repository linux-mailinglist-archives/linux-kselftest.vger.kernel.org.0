Return-Path: <linux-kselftest+bounces-4190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC1C84B333
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 12:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D4C28C8E0
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0123E12B144;
	Tue,  6 Feb 2024 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9wNl4vY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF158131;
	Tue,  6 Feb 2024 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217870; cv=none; b=p3tAnlwUxmTTbwxUyGxVBrYg9ZHHjK68kwSBM9omrKbeG6AWXtSR1Nk6Xob2mZG53RR1/yHLD7m+RJ3f3k+HBoU+V6msiyqC14zAfzswxZZqLeyytlNg/1dRbz5O7oIR6Jn7qSMeWMjZM/K8e1TQdoL+Q9/cDH+QVwhS1Z7Osx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217870; c=relaxed/simple;
	bh=DfrxxqH92Hu5SEI8vfNMqR3mxYQkWLDB8B3EGp8bioA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh+3BvzUpxBIz9swSPFfRCeLAi/WWt9JD4Q6SiyAiE9REyWWYDxAF9Qqc8RKfxyCcgaEfmK+GWlRXB3oeNdkCRwekRfifNYYbTBVokrvZZcjcbjbNYK4gUK9660pYylAvdYB/Yh74q8mprmf0FAL1TGkKYbtKDp1G2nYinnSaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9wNl4vY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A618C433C7;
	Tue,  6 Feb 2024 11:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707217870;
	bh=DfrxxqH92Hu5SEI8vfNMqR3mxYQkWLDB8B3EGp8bioA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9wNl4vYR01t2bzx6iS2w+unyv/c/FJJQAcSWxG9ornbuBC54t3zbQkN3wlSYUC7l
	 igb5F9tCljHYnJWdGs7QPh1jTXDbiCIeusb2urqc6SJebyJA4LNKRLpw5gre3jUIJj
	 mqVWit1rY5PYLxbuu4+QdovgC6pFYi/TEnytR05qz0zMU6TRHIsVXyyS6X/LNf76Cd
	 TCq+sMfApEI9pgyw57s/k8wTzgH3ysJNy0+a54d5w6lpy51PjywNyFUsJaiaVU4ij4
	 2/VScgOyloGh+pxN2rEFSiU+NiI/Vi1RKNR9dVkQZyu/8wdWJMuDara9kVLlIcSSNu
	 pkCPYlpA11G6g==
Date: Tue, 6 Feb 2024 11:10:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: Pin benchmark to single CPU
Message-ID: <ZcITtknvEVm0QPMo@finisterre.sirena.org.uk>
References: <20240206095642.work.502-kees@kernel.org>
 <ZcIG8y0U1VyMsCAD@finisterre.sirena.org.uk>
 <202402060302.C9BD99F@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="njvYj7U5fPrYgqIJ"
Content-Disposition: inline
In-Reply-To: <202402060302.C9BD99F@keescook>
X-Cookie: You might have mail.


--njvYj7U5fPrYgqIJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 03:04:32AM -0800, Kees Cook wrote:
> On Tue, Feb 06, 2024 at 10:16:19AM +0000, Mark Brown wrote:
> > On Tue, Feb 06, 2024 at 01:56:47AM -0800, Kees Cook wrote:

> > > +	/* Set from highest CPU down. */
> > > +	for (cpu = ncores - 1; cpu >= 0; cpu--) {
> > > +		CPU_ZERO_S(setsz, setp);
> > > +		CPU_SET_S(cpu, setsz, setp);

> > Is there some particular reason to go from the highest CPU number down?
> > Not that it super matters but the default would be to iterate from 0 and
> > there's a comment but it just says the what not the why.

> I was arbitrarily picking a direction and all the examples I could find
> started at 0, so this would be more (?) out of the way. :P

> Without a cpu cgroup, I can't _exclude_ the pinned CPU from other
> processes, so I was pretending the last CPU will be less likely to be
> used.

That feels like it should go in a comment so it's a bit less mysterious.

--njvYj7U5fPrYgqIJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCE7UACgkQJNaLcl1U
h9CoNQf+JBHx4ZhTG5cNFyNkvKvu9gedS2BANj9bnmpFJa568Xl31oNYrSvsSKlK
9DNP0APa1BU2imWa47G7sCddqqqKTACyd45pnbr1n7/UDGdu50MXHONH3NUmLdqI
1mvoxUmrV95MBigN1oLcx+Z9vDYa3jzb2vNF7HWkKpYnPjodwvsI21mAQchHTVXK
/U7agI3TvLlr8GxvbWJnIuu6F7lkjHhqJpwYWUIKkNKuZeg68wcE6LReZluvImBr
XSl1DdXgshm+HtygDxzQWJmXJ75sARmWNLWS1a3oAGK7L4QnVdYM5cwAvv0QTfOd
DnEbL9YdL0Vot/6hUPF/DbqOUrUb2Q==
=NNub
-----END PGP SIGNATURE-----

--njvYj7U5fPrYgqIJ--

