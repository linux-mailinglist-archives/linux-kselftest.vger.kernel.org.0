Return-Path: <linux-kselftest+bounces-9479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972808BC181
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 16:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79AB1C20976
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1782C1B4;
	Sun,  5 May 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI52Dk0Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C57A1E48A;
	Sun,  5 May 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920774; cv=none; b=rxr++/w1vLFFJlCQLyMomgPGTbtzN6Pvq5x0GqYzTRDTRbdf77vAzWPRyZhNQXjeT1lN3OPLTNScRdwOIjkC9iM0idwFRaNIwLHh81s0JiZztFax/u8tXewtjn6TG9+4CUWRZylaw0BtX9nZMui/mZZJEq18ZmFVdi0DfOEM76Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920774; c=relaxed/simple;
	bh=2KU9PdnxsTmlZXzYE8CTMxfSaPGkR5IcACPvprUSSq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyV9OmAMXEFK1qMtrDskQ4ahAnRfKkVAb6/lwnqmAjuTiOAfO7D+5GNgmWZ9KQkJEAiJUcTHwuplt0aanhJn14OqCJNvK4wpfSwPV0oYAKVzx/mghLNMUN1W1v0+c/5Mnhtwx80IY91V9s95fdspvv4QPZNRlaWinzwfTInvciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI52Dk0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFB0C113CC;
	Sun,  5 May 2024 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714920773;
	bh=2KU9PdnxsTmlZXzYE8CTMxfSaPGkR5IcACPvprUSSq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QI52Dk0YUZc7D+PeFsxlJUIDmpv3vsEMhjBn2zw+xFlLNqeE6JY0Ze8xufnRyBdYN
	 +GqdN3jdJ1h7hZu2crL0ETWQKfpnxMoofqpcZJZjJkD06jIfs3J0pFfK+zi01Amb11
	 85RBEDfZO5FfUz3xrotyUUD3js3REtpmCFe847aLa7E6IDb2tvQLwdWdsQCVZX1WPT
	 r0q8WAh2+65jymiZO2XOvBL4nh/viqDvmpFUDC9s/aQNNluzrf5JSq7PycFFYly4V8
	 ztBGAtCp1GLaPtLIf1IMLgAhXpl6ZDUks3a/TCwV3kJnzNU56kns6zLpvlfe3JC+Al
	 /o5dsaMkHtiKg==
Date: Sun, 5 May 2024 23:52:51 +0900
From: Mark Brown <broonie@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>, linux-sound@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/alsa: fix a build warning: return a value in
 all cases
Message-ID: <ZjedQ6ZH4p_4QI54@finisterre.sirena.org.uk>
References: <20240504021330.33429-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kc7/Yw5jYfcwspOn"
Content-Disposition: inline
In-Reply-To: <20240504021330.33429-1-jhubbard@nvidia.com>
X-Cookie: lisp, v.:


--kc7/Yw5jYfcwspOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 07:13:30PM -0700, John Hubbard wrote:
> dump_config_tree() is declared to return an int, but the compiler cannot
> prove that it always returns any value at all. This leads to a clang
> warning, when building via:
>=20
>     make LLVM=3D1 -C tools/testing/selftests
>=20
> Fix this by unconditionally returning the "err" variable if the code
> reaches the end of the function.

Reviewed-by: Mark Brown <broonie@kernel.org>

--kc7/Yw5jYfcwspOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY3nUIACgkQJNaLcl1U
h9A0DQf/Sm4T5cLBFo1crAijqgYhia2UFGRUbgX25oBNtteEGtseMCPCna58C8ZE
qsKSLsvmhh69Af7mOs4LAp7b8tlp1tOvTEgbNPIZcHCM9mHJ7c5IHIiZ0gfr50hw
eImQhq5m7nsbQzUoCcpV/e/1W6dL7F8ifAC0zfoa5d4pCpB/G9Vcyvi/efmgENCL
NY6zclPKKNl34shTqOYbxid8Dnj+bad7197D8uAvL933qXxAOeBRwcjeFkSOEqsQ
3xhBdnD1mBk5qfLgz3LNinaLVWQWr3jucVMhYyYlYjODJy631dDT1zv0obK7n3+a
fDF8SNhye8zKNxN6QNnL9BK0VkxQgg==
=CkGU
-----END PGP SIGNATURE-----

--kc7/Yw5jYfcwspOn--

