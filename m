Return-Path: <linux-kselftest+bounces-392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2757F37B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 21:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D4E2823B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB4449F8F;
	Tue, 21 Nov 2023 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKhUW0WC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2943942076;
	Tue, 21 Nov 2023 20:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06810C433C8;
	Tue, 21 Nov 2023 20:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700599731;
	bh=KolmBwKpbH8naVtlkDeppnK3S5S+HMNbhSd3gc0CZxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKhUW0WCGHF12g7ooSZO9omLXTl4ZDn7ynQ20GnZgxM7ibLgdypYYdQ6so4kas9ni
	 yByBTagw90rO8Wjft/2KURnmg82qBdlqGi0Xe3BDWWmUML2qm/sCllHaRKZCFj1KT5
	 avxMFmTwveLnrhmGz6KEPfgG9eWLXeNscGBwBVB8yo3xyddcQ8IpHNj0voNyzqbLeS
	 waDhkDNt1ZmZ2ev9BeBmZ+Cp7gzf+BtufTaPQS1AGtnUHQFE+I82Au1TmsI/rXEeiW
	 69fitct9TaAJxSKlfQ3cfQlqdVdgOAgi05b5b7P4Ujxhf65MwbGHnxdNqe5f7K9OIu
	 2XwC5s1/gZyiQ==
Date: Tue, 21 Nov 2023 20:48:48 +0000
From: Mark Brown <broonie@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
	workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Message-ID: <ZV0XsLBUnzoP3KqA@finisterre.sirena.org.uk>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <CABVgOSkRpL9KC4FDMrQ-g51b0_BB-=m71LzaQNG8UsqHJ7VrkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Qm4wxwj82KSPBf4"
Content-Disposition: inline
In-Reply-To: <CABVgOSkRpL9KC4FDMrQ-g51b0_BB-=m71LzaQNG8UsqHJ7VrkQ@mail.gmail.com>
X-Cookie: Slow day.  Practice crawling.


--+Qm4wxwj82KSPBf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 21, 2023 at 06:36:10PM +0800, David Gow wrote:

> The other question is how to handle outdated results when a new patch
> revision is sent out. Personally, I think this is something we can
> solve similarly to 'Reviewed-by', depending on the extent of the
> changes and cost of the tests. I suspect for most automated tests,
> this would mean never carrying the 'Tested-with' tag over, but if
> testing it involved manually building and running kernels against 50
> different hardware setups, I could imagine it making sense to not
> re-do this if a new revision just changed a doc typo. If a URL is used
> here, it could contain version info, too.

One thing with Reviewed-by that's a bit different to testing is that
Reviewed-by is generally invalidated by doing a change to the specific
patch that needs at least a commit --amend.

> Personally, I'd like to require that all patches have a 'Tested-with'
> field, even if there's not a corresponding 'V' MAINTAINERS entry, as
> people should at least think of how something's tested, even if
> there's not a formal 'test suite' for it. Though that seems a
> longer-term goal

A requirement feels like it'd be pretty painful for my workflow, or at
least result in me adding the thing in hope of what I'm actually going
to do rather than as a result of the testing - all my CI stuff
(including what I do for outgoing patches) is keyed off the git commits
being tested so updating the commits to reflect testing would have
unfortunate side effects.

> The questions I think we need to answer to get this in are:
> 1. Do we want to split this up (and potentially land it
> piece-by-piece), or is it more valuable to have a stricter, more
> complete system from the get-go?

I think splitting things makes sense.

--+Qm4wxwj82KSPBf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVdF60ACgkQJNaLcl1U
h9A5vAf/f7C2XrRwjIRIADD8Ve0hYKnWBqwkrLTphkTj23ZtQSNnLIITZ05iaoQw
71Tv3qjAA6hNllYEMhokmzVR3tnWSwIrjrl4kgejoIl0xxkYvfwovMneEy0zvwHW
Qlwfz4MoIXXJxOrbMCfD7RVXYWhu/XYzheIKMul6/KbJskCdg9Zr1qC2boS6F09i
mu6jEGy3PP8/iRBd4l8cgotkPjia61cLiN55iI8YHw6FA3+t3MhSVTpCT6djwWFe
0h19srptjeRH41akN5l7j6rgBSjlSjlluk3cip7pC+31FtUFy3pW2gg12GPE5POr
uVWCogn0zxnbnN0INipYeYnMZD6KEQ==
=x8lK
-----END PGP SIGNATURE-----

--+Qm4wxwj82KSPBf4--

