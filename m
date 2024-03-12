Return-Path: <linux-kselftest+bounces-6260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E33879743
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 16:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FECBB21EEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE517C087;
	Tue, 12 Mar 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW//o/XO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30906997A;
	Tue, 12 Mar 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256547; cv=none; b=NvHdrdScemd5djw1QcUolkrzhOKdhNAlT+hBAJtWuORU9isq3kk7Gan6GVm/NrVxlZ5VuVZ8mi7YO/lC7ct4ZE8uvorgikqjwisRECuIXuGG7ujnNUXsI8rkZXXiFnAsHL50OYa8iIBraXlbyAnDyEQkuAjj3SQiyW8ZTpg2e0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256547; c=relaxed/simple;
	bh=VZ4RdUpZnnmsa7p41EkDiD8Pda6QAnfCyDAaAvhh35M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyYY6q+QcDa1KMjvvqgYuLtCceYjHBQH8pqXRRpQ3EZIs9Bu8f+v0nvDDnjFpQPgCcva3WAA8gQlKY1CvOjOrw6vm0RjUJ7MSx5m1DSUi45dhUdk9SBJSpqlUNiXfUie0PKeJcODpWnwYsurTLYwEk/rjYfcWPbOmK5oOuKW9ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW//o/XO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F7EC433C7;
	Tue, 12 Mar 2024 15:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710256547;
	bh=VZ4RdUpZnnmsa7p41EkDiD8Pda6QAnfCyDAaAvhh35M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JW//o/XOd16LQfnD9OhRP5h8UBGG4+NJgz4hSATwgEM7PcKKeHzgX4wKZPY0UGDeg
	 pqIQRB46iUE0L8CTkskV93k8ZCoiBbZi6iQ4EbF53cx2ZGx5Q4QakvXlHnnfkG5oHV
	 CKEe+qypY1dFWhIbixGj2qrXsBXWiewcrTcUCqu0U8svWRKBslLjuQnbaFXFoVc3LF
	 kzZTqR1aqt5NxqwdHQJX82rE/rnB//sxEWGQmhnBaV9iGWyLmWy3DsyfxtJO+tGdXL
	 pPVyRNlBHms6Sj/E530ZgYUfV7cnevsU3yeEHf6XGCb/v/Bmq/5DtEIO4Hrzo8Iknj
	 qRWugAQTYLadA==
Date: Tue, 12 Mar 2024 15:15:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Valentin Obst <kernel@valentinobst.de>
Cc: Shuah Khan <shuah@kernel.org>, Anders Roxell <anders.roxell@linaro.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Guillaume Tucker <guillaume.tucker@collabora.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC] selftests: default to host arch for LLVM builds
Message-ID: <dcfc27f1-430f-4fe2-b16f-e0bf9c51de5a@sirena.org.uk>
References: <20240303-selftests-libmk-llvm-rfc-v1-1-9ab53e365e31@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K+VY3Y953r366r+6"
Content-Disposition: inline
In-Reply-To: <20240303-selftests-libmk-llvm-rfc-v1-1-9ab53e365e31@valentinobst.de>
X-Cookie: Oh, so there you are!


--K+VY3Y953r366r+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 03, 2024 at 01:44:36PM +0100, Valentin Obst wrote:
> When using gcc without cross compiling, i.e., `CROSS_COMPILE` unset or
> empty, the selftests build defaults to the host architecture, i.e., it uses
> plain gcc. However, when compiling with clang an unset `ARCH` variable in
> combination with an unset `CROSS_COMPILE` variable, i.e., compiling for
> the host architecture, leads to compilation failures since `lib.mk` can
> not determine the clang target triple. In this case, the following error
> message is displayed for each subsystem that does not set `ARCH` in its
> own Makefile before including `lib.mk` (lines wrapped at 75 chrs):

Reviewed-by: Mark Brown <broonie@kernel.org>

--K+VY3Y953r366r+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXwcZ0ACgkQJNaLcl1U
h9BUQgf9FBk0W4fl1KIsv1Zq1y29HJ7MuSO3XtmT0CG5+VmvTrmU0NYgenK7GniC
Ydf4SfucSUfcc3S933rBslfvRACYhWMLlrY7BVn0qkTn1Cd3Omxt2BZww4/CxrNU
0mRxSUtjOH5yBuEwJOolHQimtn3L0IYTyeAEPIM3j9o1derPNluU6gSzNpRkKsZD
d9GX4VKQsFKwbVgr+UKPGgV0Zqd61W4KyD4X3j2I3nk6Y5ZNwhgN9KZNze0fs5tE
NxHkFt+OQUjfrQP5KDCaoPoaB8Nxz3amut7vARmSa5U5L6ozdiwKzG3asLBBXgYp
AyvsKJ/MjUcj7yfLZ4Jva0tsKc61BA==
=D88T
-----END PGP SIGNATURE-----

--K+VY3Y953r366r+6--

