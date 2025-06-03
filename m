Return-Path: <linux-kselftest+bounces-34218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165D4ACC799
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 15:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A78174041
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05A822FF2D;
	Tue,  3 Jun 2025 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dht3Pp93"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F561A08AF;
	Tue,  3 Jun 2025 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956886; cv=none; b=tGZX6MmBxldBU0xwj+FKJS/iBYSy22yAC+CtqzSXTqW6mlkuDhYP2QsWHuaA4JTzncdJQHtr/8C0XEMfZrNnQaC6iASQJ+x3dxvOCiA40YuWIeJ6zgIB6CHlkX/m2QLoam/FZPguSavefAe0UXnMCxDUG6JkemZ5pEhc4QH+bV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956886; c=relaxed/simple;
	bh=zH4rUyvq8kOPfx1d1qPsT3TCt7wQNpsiju3FOhyNFCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYeC5zbN+Yb/Ym4gfgyb7DEuGCzQAtzSFqm72PG8wZ/HyN4Ujltd7EjeUDWtCfkEZnEIIsVwd5JljVnyq11MCex1WP1GOvX+st+tJ7Xiv7m4BK+BExTN07p0MnnZ9GbPIpbakPEuTaJye/1yck3fcgb1upltecjRRX3gcBjWx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dht3Pp93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F95C4CEED;
	Tue,  3 Jun 2025 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748956886;
	bh=zH4rUyvq8kOPfx1d1qPsT3TCt7wQNpsiju3FOhyNFCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dht3Pp931bj65euV99zmThwCaRTyizAb+Jan0MzDsI8jPYpT/7k+RwXq34aF3Rr4w
	 +fvYFNDVUmsw1dgmKRJ0h4h9mYSsNA/0hgOCgcFDVH8UzVjVBCj9kQUlCUTcZkFg7m
	 05z0UG4j9eaxtvBdqWjz4K/JyfS6iVdJVtIkig5sLp7HDJIKE4IrUt+gZMG8XNdL6e
	 AvnuZO0A7XCqCFWq+b3b5duJVDHhUy0/2TnS5iGTp1qX1EebT1YroY3BqvIjhoGSJ6
	 KhkcD1oHSSPWuR1A1Onr2WvJbtZPMBKrzQaraQ8ErCmsmAij2uCnOS8UBNzcZQdFNx
	 5NlA3MeYaa3Cg==
Date: Tue, 3 Jun 2025 14:21:21 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] selftests/mm: Report unique test names for each
 cow test
Message-ID: <9961082f-848d-43d3-b97d-3df675ca4415@sirena.org.uk>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-3-ff198df8e38e@kernel.org>
 <c43347ce-433b-498e-bfd7-f09b8e781197@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6FZ12iParXl9eD5E"
Content-Disposition: inline
In-Reply-To: <c43347ce-433b-498e-bfd7-f09b8e781197@redhat.com>
X-Cookie: Avec!


--6FZ12iParXl9eD5E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2025 at 02:51:45PM +0200, David Hildenbrand wrote:
> On 27.05.25 18:04, Mark Brown wrote:

> >   		ret = mprotect(mem, size, PROT_READ);
> > -		ret |= mprotect(mem, size, PROT_READ|PROT_WRITE);
> >   		if (ret) {

> Not sure if that change is really required: if the second mprotect succeeds,
> errno should not be updated. At least if my memory is correct :)

> Same applies to similar cases below.

I thought about checking to see if that was guaranteed to be the case,
then I thought that if that wasn't clear to me right now without
checking it probably also wasn't going to be obvious to future readers
so it was better to just write something clear.  Previously we didn't
report errno so it didn't matter.

> >   	} else {
> > -		ksft_test_result_fail("Leak from parent into child\n");

> Same here and in other cases below (I probably didn't catch all).

> We should log that somehow to indicate what exactly is going wrong, likely
> using ksft_print_msg().

Can you send a patch with the logging that you think would be clear
please?  I dropped these because they just seemed to be reporting the
overall point of the test, unlike the cases where we ran into some error
during the setup and didn't actually manage to perform the test we were
trying to do.  Perhaps the tests should be renamed.

> >   	tmp = malloc(size);
> >   	if (!tmp) {
> > -		ksft_test_result_fail("malloc() failed\n");
> > +		ksft_print_msg("malloc() failed\n");

> perror?

malloc() can only set one errno.

--6FZ12iParXl9eD5E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg+9tAACgkQJNaLcl1U
h9ALZwf+KcO2BAip9nr8HfmSM0LrVxshV2/1yhu+F0+8i7WhuFXk+1gK/ub0Ue0F
IhbjYpgC19NQXStOO+NNyG3VJ8ldaOZL3225ADsAjUT+0e7mKaDI3oW2XKNGQOK8
XCi0/c2xaSCRyANRmYvVHGdzwDqmGZMNDBucCKdr9OZk80s2899XAFqQV35Wp2zV
71B0pJeaiW0Leb2ym6pzfr6mq/+0FBaEFwk/J14FvzBsyVQYTXPM/WVGbcyW+iEb
xpdn2cWjA1JRkzA6P/AA7Qhler6UxFACZ2HiVDrlOSP0fNQMFOqw3Im07giphodQ
QONqZpVJ4ofJp/RM1pN29stc12RnXA==
=eR7D
-----END PGP SIGNATURE-----

--6FZ12iParXl9eD5E--

