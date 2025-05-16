Return-Path: <linux-kselftest+bounces-33206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6511ABA27A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 20:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D41147A6BC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 18:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4818027CB02;
	Fri, 16 May 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nsiu26Qy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85027AC5C;
	Fri, 16 May 2025 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418870; cv=none; b=B9pF3AQBZ11MoxOhTSVMc2IsYon3T1/jiOQDiSk3Xa9lC0JTHFO1Z2tBDJJ/n9aVoq1UdK7fSzuVHGZHvk6T/9Osjl+9uEUddEXdQD7NRk/9cyAn2KxZW+bj8UUkCrG+aN5mnowcRmhq1A4DdKDEIqro4BpFb5cnPp0mg0VuK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418870; c=relaxed/simple;
	bh=NDQ3oIAK81gY0XPqiwX0d/dvGcwzYLnE7nxbmPCbTY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfgVNoSmdyslng6qvN/zuWJm2m/Dv+tV+1s+D0L0x+4+Nuhxbcj0PrnNmneLdN4UPz0/8DqprhRRvUVlN/vUqMu6cG5OkUhiZVhR/OreqHF0mL/z8GQoz3IHQnz7dCfxeiaj1e+O1IJVy8OzCMUdOZiqgEMhnyGttnF0qmo6+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nsiu26Qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24ECC4CEE4;
	Fri, 16 May 2025 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747418869;
	bh=NDQ3oIAK81gY0XPqiwX0d/dvGcwzYLnE7nxbmPCbTY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nsiu26QyPbRgf5TPznJIJOzpQVrbSTQCNVVmXUO2pDu4VVs+n/+Qe22sAVXpTMy6j
	 WBMLzciw4Te+AsPPcBApI/0IKX7LT3BffjFhTegMYG6W6AlL8+3ZjUe+ibjBOqNPfj
	 zQfqZh1/a6j2rIvQr3SToofPTZ8Oq7KA9b6qhiFWpdFLBldDPF0rUw43Qo1xwvaTeQ
	 PUZ8ZV5AFX1kHeYP1IoZ5OHtMQURg4oKW04Vspj0SdcD0XBSPaMNlOaHS4wZMr71B9
	 stVbSD0z+TfaWA0Vv/UJHgyC9tvIiHdFbJPZbxCRZgmZxxWdxdU0FLcKuAJOHZPq0J
	 MWaCTb7kHwbCQ==
Date: Fri, 16 May 2025 19:07:46 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Fix test result reporting in gup_longterm
Message-ID: <aCd-8kEyDm2f2w0z@finisterre.sirena.org.uk>
References: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
 <f924f789-5269-4046-99a4-2991f9a3ab3c@redhat.com>
 <aCcvxaFc6DE_Mhr1@finisterre.sirena.org.uk>
 <58dbef73-6e37-46de-9092-365456306b27@redhat.com>
 <aCc5E-wB4nBwrKEP@finisterre.sirena.org.uk>
 <46d151d7-c04b-4538-9725-dc4f46ac8ac1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F0Ea/dgySH8XhVmb"
Content-Disposition: inline
In-Reply-To: <46d151d7-c04b-4538-9725-dc4f46ac8ac1@redhat.com>
X-Cookie: Well begun is half done.


--F0Ea/dgySH8XhVmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 04:12:08PM +0200, David Hildenbrand wrote:
> On 16.05.25 15:09, Mark Brown wrote:

> > > I'm afraid we have other such tests that report duplicate conditions.=
 cow.c
> > > is likely another candidate (written by me ;) ).

> > That one's not come up for me (this was one of four different patches
> > for mm selftests I sent the other day cleaning up duplicate test names).

> $ sudo ./cow

=2E..

> 1..778
> # [INFO] Anonymous memory tests in private mappings
> # [RUN] Basic COW after fork() ... with base page
> ok 1 No leak from parent into child
> # [RUN] Basic COW after fork() ... with swapped out base page
> ok 2 No leak from parent into child

> Aren't the duplicate "No leak from parent into child" the problematic bit=
s?
> But maybe I am getting it wrong, what needs to be "unique" :)

Ah, yes - that's got the same issue.  I'm not running that program one
way or another, it's not immediately clear to me why not - I can't see
any sign of it being invoked by the runner script but I also can't see
anything that I'd expect to stop that happening.  I'll have to have a
poke at it, thanks for flagging that.

[Converting to kselftet_harness]
> > That'd certainly work, though doing that is more surgery on the test
> > than I personally have the time/enthusiasm for right now.

> Same over here.

> But probably if we touch it, we should just clean it up right away. Well,
> if we decide that that is the right cleanup. (you mention something like =
that
> in your patch description :)=20

OTOH there's something to be said for just making incremental
improvements in the tests where we can, they tend not to get huge
amounts of love in general which means perfect can very much be the
enemy of good.  If there's some immediate prospect of someone doing a
bigger refactoring then that'd be amazing, but if not then it seems
useful to make things play better with the automation for now.

--F0Ea/dgySH8XhVmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgnfuwACgkQJNaLcl1U
h9C+1Qf/RpnzjkDNIVJbiN4XdRsp/uDYe3/nV7RLlL/fbTisY3dHyhvFom59dhod
1Ii/9OxAP4NDn5QeNPrvPN+mS4G1qhwz9EMIkqGKZVT+LhZnHoIWOv2XrpK0nzSV
EavRh5bwqqkANX4d1ArzLTbNaF9Y7jehxFp9AkxKUfR20NgIC7fSZUVBtOCteOoK
J0plCu8UuZECzL79JZ9PB3FMlm81yNFCczCMQP2XjFs+ECFuFYZef+Jv06lI2M7m
FY1Q5l7ILhEprXZJXrL4MKbgWZxRpe8s9uv/JQ3NRDeiXORWV8AyFMXZYSNTurwK
xhdCIS1qJRYcDjecpJE5vGMlk3xi4A==
=67hP
-----END PGP SIGNATURE-----

--F0Ea/dgySH8XhVmb--

