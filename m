Return-Path: <linux-kselftest+bounces-178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 158247ED1D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 21:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7261F27F2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 20:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4404121C;
	Wed, 15 Nov 2023 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEeLV5bF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AAD3C462;
	Wed, 15 Nov 2023 20:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A699DC433C7;
	Wed, 15 Nov 2023 20:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700079263;
	bh=cc+Qc3CKicArBzoNO4D+FemtPpnp4Q8UDKbjxqJs1m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hEeLV5bF+pRWwRAL0I3ZeHydvzTa1jzMg6KU+757g/hpT04oPrvO+rmwWiw2mGkMd
	 j5Np+nC4039T4BE+kkQ9dXi/fQgO9/iCxSTiYHu5Fel3lCpEt/sCqnHqL94qvk/U0V
	 ZVyd4fisOQcy090dScdBZNBszL0/bfvmM90pYcSRRVPD3GfBnOxIRJ4stneKc+WOE8
	 E99X4mepsyre2xhMSIod5jz1K/hyMyBirN2DmWhg9JYWgPX1i5HHxwdBGpXNvxOVor
	 LseZXDSlRfOCrxkpO1ZwDoKpH8/P4UroCIo7ngjM2LTPjh5DgEA635nCN9nJZRUfdS
	 9ndTbdkQzTfBA==
Date: Wed, 15 Nov 2023 20:14:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Cc: workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Message-ID: <7a4a71a2-cca3-401e-a7ad-16ee47812900@sirena.org.uk>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5W2iXjax2zVxmLx5"
Content-Disposition: inline
In-Reply-To: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
X-Cookie: For internal use only.


--5W2iXjax2zVxmLx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2023 at 07:43:49PM +0200, Nikolai Kondrashov wrote:

> Introduce a new tag, 'Tested-with:', documented in the
> Documentation/process/submitting-patches.rst file. The tag is expected
> to reference the documented test suites, similarly to the 'V:' field,
> and to certify that the submitter executed the test suite on the change,
> and that it passed.

This doesn't feel like it fits so well with git based flows - generally
the tags end up in git one way or another so there'll be a strong
tendency for this to end up getting added for one version and then
carried forward to the next version.  The way the tooling is at present
it doesn't really feel like there's a good point at which to insert the
tag.

I'm not sure exactly what'd be better though.

--5W2iXjax2zVxmLx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVVJpYACgkQJNaLcl1U
h9CPKAf8CmOL6NCtOSmBDjQ7PEF5uXWhZVANO1qZpGszGxIsuEdu6eoUbxYcoq7g
oAygaCChem3euMtxBG/3misNJL2pc74hDZ+ZdtFFEZ2TRQouBCJmjaynmGBI+jQQ
wdIkJ9TVfGK7IjAY8vn+pwYYkDv+SLZSZfjoPvQqSFeS3fgKCjFl1O8JMLlux2De
ZYFTOTqk7602YBShzA3e4cV8mHKp1FOFSmotLvXGJ99YvfjRtrP91QMvv6i8Jmlj
XzwEwKLSExrZMQSZCothuNo9mnOde+fUzR8Ll1CbEOTGVZSZOH8t8grPm478UPkq
Ak9VkbA4u//SEolIRbanXPfc4K6AEA==
=szcD
-----END PGP SIGNATURE-----

--5W2iXjax2zVxmLx5--

