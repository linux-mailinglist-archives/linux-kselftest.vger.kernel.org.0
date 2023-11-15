Return-Path: <linux-kselftest+bounces-177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EED87ED16F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 21:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F184728172F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 20:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7B33DBB8;
	Wed, 15 Nov 2023 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c54zzP8l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD113DB8F;
	Wed, 15 Nov 2023 20:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DC2C433CD;
	Wed, 15 Nov 2023 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700078491;
	bh=vYmwl8eEVWTHFHPxo7gRqNR6d4fj7k328P0ex3wMUqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c54zzP8lOFLL2JQlrnVVQ2f2EmcbiIDxROdtd0qYbPdToWJA4yqmkGH1J8Cc5nhY9
	 7K8+amo7y67M5TWmRG4xbepi2nNM94sgyGwkA8A2eDCnhu89U4amlp8R4772tAroxa
	 y3pZAOKA0o8JoyewcH09aZMvGrUs6jiXMiEusqpqtfrwBK6HNQ2/g/bdavJtBFNCed
	 6M7nDDSLJAOvl4ciyVdgc65FfQkRHLpLAHtNY3n7jXkZcQ95tp8p1cF6apg5i5wVAu
	 wirG8bzDeT3Nd4RpZxNb1IJqvsS0606AgKXTD5L6FtHotRlVwUjM1bEaXCNK2dswj0
	 n4CuzjHzs3nQA==
Date: Wed, 15 Nov 2023 20:01:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
	workflows@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
	Theodore Ts'o <tytso@mit.edu>, David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Message-ID: <1c43a4b5-55d4-402e-8eeb-db8e247dd713@sirena.org.uk>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <2e8979163c8ed93f6990c6a91c34cdf96a76daaf.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YeklDa1YphrbT8Xr"
Content-Disposition: inline
In-Reply-To: <2e8979163c8ed93f6990c6a91c34cdf96a76daaf.camel@perches.com>
X-Cookie: For internal use only.


--YeklDa1YphrbT8Xr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2023 at 10:31:21AM -0800, Joe Perches wrote:
> On Wed, 2023-11-15 at 19:43 +0200, Nikolai Kondrashov wrote:
> > Introduce a new 'V:' ("Verify") field to MAINTAINERS. The field accepts
> > a name of a test suite which is required to be executed for each
> > contribution to the subsystem.

> Perhaps this is simply too much overhead
> process requirements for most kernel work.

> While the addition of V: seems ok, I think
> putting the verification in checkpatch is
> odd at best and the verification of test
> execution should be a separate script.

Verifying that the expected tags are present and valid does seem firmly
in what checkpatch's wheelhouse though?

--YeklDa1YphrbT8Xr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVVI5UACgkQJNaLcl1U
h9CTVAf/fbczHJVHBaknVXeBvlt0p/Qv+qn4JkvSm4MppQglFDxhmBqQoUtulxUs
ulOvXjwFdT60p5+KIY8dnjLiXWdLwTItNSJYSHtc3vsiCxqQNG5Jk14BLAzPYDAV
yaPf5HrL8K7wQH2BvEgTa4b/CnOO14nmBPLuoYhOBzkMN9jEYulvLPyBnQHx+WOU
QH3+kb3NRa07kEcwe1zi1fIVpH28vS/e0dILtPK//7TKXkQlSri2i6WpT8KMknTZ
DeUNm56Zf9ivi/QgmN4TuKwPBn1T7vLVP4glHC8B2jN8u0W7EdGrnv3Mm90yTMe7
pYNcZ6zIqxDP89HUfbGAoapJMb/l3w==
=ngzy
-----END PGP SIGNATURE-----

--YeklDa1YphrbT8Xr--

