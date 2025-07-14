Return-Path: <linux-kselftest+bounces-37250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B62FB03FFF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF474A37B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1166A24EAB1;
	Mon, 14 Jul 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IunKLAIg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19E246767;
	Mon, 14 Jul 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499739; cv=none; b=AKE2LLVdwXJAqLn0+bGeDUJL6puiDLTLe34GE83JdXxFKBXhpTGizxrSX0dEKExgdjuKY5cJ2PgkzlsjtQZu45hXShF9zdiWOFh4VZFbHt2dnKpTPfKtgr/x7AJoJaR0fv2t2Zo7fzCSuzVLEFcBOqgCcU8ucnCN1gCd/CpCIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499739; c=relaxed/simple;
	bh=dQMp3Ed76Brn4mr71z5eM3y/S6u63AAUedcvy/zDi3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfEuxFVUhHc14ZX0yG3Yj3Ogk3n4N21xzM7y+QiCM90+1QHdM6d1C+5fKDhCGX0eenFgQlU5lrNdJWuQoW84uNQX0jPPX3zfYcrXUOUVpfImHe30/6tShh36Y3hIshM1ykMIOB1CpbqMiKMZ9ZMmCYwlfKHWjP4y+4AMyzttvUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IunKLAIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F77C4CEED;
	Mon, 14 Jul 2025 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752499737;
	bh=dQMp3Ed76Brn4mr71z5eM3y/S6u63AAUedcvy/zDi3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IunKLAIg8iMZbN3FKxL2b3ZdHLbEZqaIE+Dyb3UZsS8Dyezsp8GvkEIWImkMhXfbt
	 sL7u9bSB/epaFtcq+6H1EN/F6Kzcg1EriH2YTtPniEozPit0shElP5L4IfpFc0JVy4
	 wesAbksMb+tn8t4BzXZ16E7/lMKhl3rdSkN2ofnevj+CFe8ojgWIOySI6P2mAbv1Hs
	 TIWgYgsoFkr4NPKu00fBybgivOMdUOJ3OPGD4QqQqilihSaeAP9XMwlmQCJHwm/0KC
	 lSWXzTvYRDnaq1DpOBKlfzLKUtOGGUfSMHJ8fgSDoiX/RxvKwvKfG04WxU/4azP4ss
	 dUrSZL3YYxCKw==
Date: Mon, 14 Jul 2025 14:28:50 +0100
From: Mark Brown <broonie@kernel.org>
To: wang lian <lianux.mm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Liam Howlett <Liam.Howlett@oracle.com>,
	Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	gkwang <gkwang@linx-info.com>, p1ucky0923 <p1ucky0923@gmail.com>,
	ryncsn <ryncsn@gmail.com>,
	"zijing . zhang" <zijing.zhang@proton.me>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5] selftests/mm: add process_madvise() tests
Message-ID: <b01d1d06-9d7c-4081-b3e3-c2c0fea06fad@sirena.org.uk>
References: <20250714122533.3135-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="au4xLk1UCIU5PYUe"
Content-Disposition: inline
In-Reply-To: <20250714122533.3135-1-lianux.mm@gmail.com>
X-Cookie: Non-sequiturs make me eat lampshades.


--au4xLk1UCIU5PYUe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 14, 2025 at 08:25:33PM +0800, wang lian wrote:

> +TEST_F(process_madvise, remote_collapse)
> +{

> +	self->child_pid = fork();
> +	ASSERT_NE(self->child_pid, -1);

> +	ret = read(pipe_info[0], &info, sizeof(info));
> +	if (ret <= 0) {
> +		waitpid(self->child_pid, NULL, 0);
> +		SKIP(return, "Failed to read child info from pipe.\n");
> +	}
> +	ASSERT_EQ(ret, sizeof(info));

> +cleanup:
> +	/* Cleanup */
> +	kill(self->child_pid, SIGKILL);
> +	waitpid(self->child_pid, NULL, 0);
> +	if (pidfd >= 0)
> +		close(pidfd);

The cleanup here won't get run if we skip or assert, skipping will
return immediately (you could replace the return with a 'goto cleanup')
and the asserts will exit the test immediately.  This will mean we leak
the child.  This isn't an issue for things that are memory mapped or
tracked with file descriptors, the harness will for a new child for each
test so anything that's cleaned up with the process will be handled, but
that doesn't apply to child processes.

I think doing the child setup in a fixture should DTRT but I haven't
gone through in full detail to verify that this is the case.

--au4xLk1UCIU5PYUe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh1BhEACgkQJNaLcl1U
h9D2gAf/XSHWkSHMfUatmFAnzIj+OI5FkqqF4LaylDlMsdeIRdjoxGNkquKk27ws
7xolTAbdeaxz0Dzne04hHvAGc8lzxEMfxYfWzwKuFZpdCOszT3nXnRdGH8BcWvGI
BLMibYwQbRW55TX5BSE4+hdBXuZA+R40l8trfIzpCj+gel3nGWWiMUnTChxqVICX
UxZXi0SNC0vSRJgtMn5/1vfMInhp6WfxIJ6QXnP314lCY8RZFDJThGE3VLe6Qi6n
HjSqHN4NhmDDI2j9AzHnCW4z4GWXs8QQpse0NVABakTiHOPoOA63x59PvLjrkoio
9JDT+pMy8w7RP9UpxFUoEJNewRIiuQ==
=Cplh
-----END PGP SIGNATURE-----

--au4xLk1UCIU5PYUe--

