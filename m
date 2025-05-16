Return-Path: <linux-kselftest+bounces-33173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D892AB9C0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 14:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D05D501749
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744E723C51C;
	Fri, 16 May 2025 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQS/7nvA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF83235063;
	Fri, 16 May 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398600; cv=none; b=id/ZjriLt1PjnMBagsh2yrtN0AUZW9NEFAK2iP7hzvT6BTsvpChF5ySCuoMJAR/deYCxdc4m0coopotPLGJJHHhQ5DDJIxKQQRFtA3ZnQ7WlL7+P5bBLloZ+opim79jUmAh5/aQEW8xOaxUtwup1l+ZqaZk1oUgsnB23m1gqNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398600; c=relaxed/simple;
	bh=v60gkmBBs9thffCH+KRcGOvOSb27plbXUWEj4N9vc9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE+bF1XmP/ZRP2Xml8cO0ROAHTr4NJABNXeu7dxfxpWu0C79Sn3AQmJ6MCmPuMCVt6U8sE/5Hw2Wa1FRlSrDD5wdQs6cqDChGQ9+SkpTmRNBVsBezPhd2svRNNpRoX3Av3P5q49P6XZ4v4N7VQwz6lkLIAoJ1+ztQigJv4hovIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQS/7nvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DF2C4CEE4;
	Fri, 16 May 2025 12:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747398599;
	bh=v60gkmBBs9thffCH+KRcGOvOSb27plbXUWEj4N9vc9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQS/7nvAYZH5uI9JzECirMI3mQVI54ZX42fKXb7ca0ktFWDVPErTwR2nCXq1dGXs5
	 oPkLLcVa7crcsKSYuY7nuLx9KrNbQS8eNCqxUIZwkvd9l2Qfv9tnxDQ4BnUpSZmjJ3
	 WdLzM/EISz3OXP6zRfhUjUlnLPpimkmoEaJaboNEAARasn2H4P8JgqZ9WXbNBqmWrC
	 PyuOgkjq8WMFO10qUDYicyK4yVtQbKKQxgoyK6HsexlHqewLb2uWkmEYPaJNOAXL/4
	 nIhoRBJtoTHh6axJ1K6gGGibFJ4xb4W4S7vNqvBMXP3rQ9SFLsdkZlpxxL4yg11cYr
	 XpN3fFkTf6+QQ==
Date: Fri, 16 May 2025 14:29:57 +0200
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Fix test result reporting in gup_longterm
Message-ID: <aCcvxaFc6DE_Mhr1@finisterre.sirena.org.uk>
References: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
 <f924f789-5269-4046-99a4-2991f9a3ab3c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+lLg9Zve3xwFMbDn"
Content-Disposition: inline
In-Reply-To: <f924f789-5269-4046-99a4-2991f9a3ab3c@redhat.com>
X-Cookie: Well begun is half done.


--+lLg9Zve3xwFMbDn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 16, 2025 at 10:02:16AM +0200, David Hildenbrand wrote:
> On 15.05.25 10:57, Mark Brown wrote:

> > The kselftest framework uses the string logged when a test result is
> > reported as the unique identifier for a test, using it to track test
> > results between runs. The gup_longterm test completely fails to follow
> > this pattern, it runs a single test function repeatedly with various
> > parameters but each result report is a string logging an error message
> > which is fixed between runs.

> As the person who wrote that test (that you apparently didn't CC for some

I just CCed whoever get_maintainers told me to CC for the patch.

> reason), what exactly is the problem with that?

> We run tests. If all pass, we're happy, if one fails, we investigate.

None of the tooling is able to either distinguish between the multiple
tests that are being run in gup_longterm, nor compare the results of
multiple runs effectively.  If all the tests run they report themselves
as being duplicates of the same test name, if one of them starts failing
the effect is that one of the duplicates disappears and we get an
entirely new test that's never passed reported.  If multiple tests fail
it's even worse.  This means that UIs displaying test results end up
reporting things unclearly (Was there a regression or was a new test
that never worked added?  What was the test?).  Since it's difficult
to track the tests between runs tooling that does reporting of things
like "This last worked in X" in the UI doesn't work properly, and tool
driven bisection of issues similarly struggles since it can't tell
what's going on with any of the tests between runs.

Basically, the output is garbled and vastly less useful for people
running this as a matter of routine or as part of a broader kselftest
run.  For example with my own automation I probably won't notice that a
previously working test failed unless every single test fails, and newly
added tests that never worked are a much lower priority to the point
where I may never look at them depending on where they are.

If a selftest is reporting multiple tests it should report them with
names that are stable and unique.

--+lLg9Zve3xwFMbDn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgnL74ACgkQJNaLcl1U
h9CSJQf/fXhm7O5lg8Qrz14Y3i/j8Av9aIR/LUBLxRkJ/v19xwDexB6y0bQQVmCF
j6QFkQ9Ifxz08T3R00Ravg5WUQRjeSmhDlksSli170TW3QPRJUWmXuLuG2RBo8s9
TmunvK5zQyOIqYCoApXIygewwr1ITKIa1sg5sYnIpDp71Lk2jr77pZG89tQ3AJcu
Yd4HyhtuyA8CIfYO56eZFWyDI5xUQNrBNw3HS3YqQVw1SkU8LOqjjTcxADfovi6J
ddcFWTUCNhJ0fUzyY1QlUCXkocczidPmBLhYSeBXWU/oPnELAFm4OR6rxRLOOQq5
GQ7BFmSkcer8MMNiQRHM7MGpIpUKZw==
=/Hzi
-----END PGP SIGNATURE-----

--+lLg9Zve3xwFMbDn--

