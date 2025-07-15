Return-Path: <linux-kselftest+bounces-37352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30726B059A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 14:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5852B4E7196
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 12:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A6A2D77F8;
	Tue, 15 Jul 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItvuXR4w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71740533D6;
	Tue, 15 Jul 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581568; cv=none; b=AQJSrAjxkdXAQZfdywn8r7MprBhTh+X811RKjv5MMigPsGVjHRIj13OI7HSWH5fKslQER4B8QCVoHD4dlZq4ZkHt6VaOOEaL3UY6OFbSQSnd9I631uGqapBXQEj8E/uuK4e4dnL4FKvyUhaLEkEXw1BTepUwCkFerp/058wePEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581568; c=relaxed/simple;
	bh=o7EVf5uzJ4EvsXYUGJ4XQhpmS1+B0D+4vpO9n/CVKPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHThy9bGMv4PJLtr9FxpFh+VP5YmMNuzIZtgYC/Q96OKebWNEUNBsyJLTx6lpQMN3F0+5HB5B+SSYbXOdORW7x2scsjSwg9viQPStfPjaoW9tOvCOPCAb7pD3j8zW+kTBP26rc2Eizca6ToPFxppWMWkCOV179SMzRsIkuhG4nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItvuXR4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4677C4CEE3;
	Tue, 15 Jul 2025 12:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752581568;
	bh=o7EVf5uzJ4EvsXYUGJ4XQhpmS1+B0D+4vpO9n/CVKPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ItvuXR4wkm2/W1bX8X2AzlFnYwrNCxnjkeWm/R3FY0RT5LOqp5l7OZHTN4DxxoOsX
	 /58su3bD24fqwenmdLTWHz36YobuLVbaoeZlkPFvVohW2hWe1XWCJWxR+SAsHhYE9K
	 VZafG8rdRRgZ0Yi5JfgMz+d/amrRJP632j4L1skzoYuPDVPv6ZCT6Wdu+c4Fzx2yki
	 OgAoNZcxW4KvQC5xJP4gMV5xBbBZa0lmpZ/Cll8U053WrCU4h7whB6Tb5P0nxb4HTs
	 ltIWMTRGvWo7Ne1XCr4jprpK0HsnY1J892wmBL4rtq7t1giPzhq8DEG+5hj+iTtQKw
	 R+37Qw1qGAZ8g==
Date: Tue, 15 Jul 2025 13:12:42 +0100
From: Mark Brown <broonie@kernel.org>
To: wang lian <lianux.mm@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, brauner@kernel.org,
	david@redhat.com, gkwang@linx-info.com, jannh@google.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
	p1ucky0923@gmail.com, ryncsn@gmail.com, shuah@kernel.org,
	sj@kernel.org, vbabka@suse.cz, zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH v5] selftests/mm: add process_madvise() tests
Message-ID: <e727c66d-a034-4e83-b743-c66235bae1e9@sirena.org.uk>
References: <b01d1d06-9d7c-4081-b3e3-c2c0fea06fad@sirena.org.uk>
 <20250715105808.3634-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EmftRvcuiOumshMV"
Content-Disposition: inline
In-Reply-To: <20250715105808.3634-1-lianux.mm@gmail.com>
X-Cookie: Your own mileage may vary.


--EmftRvcuiOumshMV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 06:58:05PM +0800, wang lian wrote:
> > On Mon, Jul 14, 2025 at 08:25:33PM +0800, wang lian wrote:

> > > +	/* Cleanup */
> > > +	kill(self->child_pid, SIGKILL);
> > > +	waitpid(self->child_pid, NULL, 0);
> > > +	if (pidfd >=3D 0)
> > > +		close(pidfd);

> > The cleanup here won't get run if we skip or assert, skipping will
> > return immediately (you could replace the return with a 'goto cleanup')
> > and the asserts will exit the test immediately.  This will mean we leak

> Fortunately, this situation is handled by FIXTURE_TEARDOWN_PARENT,=20
> which reliably takes care of cleanup when the test exits early via ASSERT=
_* or SKIP().=20

> During earlier testing (in v3), I did run into an issue where a missing c=
leanup=20
> led to run_vmtests hanging,which prompted me to make sure that subsequent=
 versions=20
> correctly rely on the fixture teardown mechanism for child process termin=
ation.

> So while your concern definitely makes sense, this specific case should b=
e=20
> well-covered by the existing teardown logic.

Are you sure the parent cleanup sees variables set in the child and
actually takes effect?  We fork() the child so it should be a new VM
which means that values stored there won't be seen by the parent, it'll
see whatever values it had before the fork().

It does also seem like bad practice to have duplicated cleanup code in
both the test and the fixture cleanups, the fixture cleanup always runs
so we should just use that all the time if it's in use (that's the whole
idea really).  Indeed as things stand since the cleanup in the test
doesn't reset self->child_pid so if the cleanup at the fixture level
does anything there's a minor risk that we might race with the PID being
reused and kill some new task=20

The fixture teardown handler also doesn't do the close(pidfd), either
that's redundant for the in test cleanup or should be in the fixture
(given that it's a child process it should be redundant as any open file
descriptors are closed when the process exits).

--EmftRvcuiOumshMV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh2RbkACgkQJNaLcl1U
h9Bs1wf+Kn7LZOeVd6+qrZjPfTgff+jl9D4mpmKb9oyqoo4Lx2pyGgng69V38RQY
WAwl9VsblSiauDreCyPRQQTxfsatgsnq9fwUkZaOZQWCYVGLH2165bn+oxLsQeRZ
G8xURtiUIm9tCJQD21OerJFPf+nIzjB6Phsv2V7aVox9yQ4D11Oq9YLwD9128LAx
MFKrBjlnn5/IOTtD96VuoVOj/eEhP5zNduoaTuqvE7g0xwgxnjTHMsorPzeV4jYi
HjQh0VDPCD2ewHb0ooctOofNw3849D2T36egMIYNAHWFalLTJW/XD3ZdF5y0RksM
DJBhTbLA+WcmScZLEa/yXxH8NmA9uQ==
=/UuP
-----END PGP SIGNATURE-----

--EmftRvcuiOumshMV--

