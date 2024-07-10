Return-Path: <linux-kselftest+bounces-13464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617E792D27B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 15:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE662824F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 13:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DE319249F;
	Wed, 10 Jul 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB+HIIEb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3DA192488;
	Wed, 10 Jul 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617063; cv=none; b=nZHSIv4Hgq3Tpt+kHtY0e05iZRv9wA6HQUr9lwWzcq0ukIL94mLM3fSDRKRdA3r8jjJmslF1ahudNa2+fN0hYCw/6nf7PPfmDoCw9IGHRvlCPQ5gBEJ0EF/G3NNzxJYBDm9kZq+PNhQuj03vmopRUyMF14ZZxu9UfS3UtuZWrAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617063; c=relaxed/simple;
	bh=2C0SCICUVCA7qXDa+oaxC/O0LDsnqm9TnLyXjcGE6jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMvv/iFEIVjFwmJcR8IRxc+gcw8L/8vDeb0W12UkPSjhmAj5TodwhTdOnZaSux0sBssDlrm1q7SrzbK5XnaTU1AYX9Bcjhdfe5Scgwm3KGZ5daDeLeev7aO6hf1qQhbWjYYwmbPl2fXcM9EeEcDqzrPR6AftETGaG+FfiWr29lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB+HIIEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5D3C4AF07;
	Wed, 10 Jul 2024 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720617063;
	bh=2C0SCICUVCA7qXDa+oaxC/O0LDsnqm9TnLyXjcGE6jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QB+HIIEbqTmMGIRtnY0cBYn1eTmT8P3INCBcP+V33mGBAudR8xHoIjNR2tZPHvr3b
	 wR8URe5Zh5w3UoL48KyovzLEAOUIQuCa/gdK9jKG2ITsoTwQQcJyuViQB7WYPVYtm8
	 ilwzaRnQS+6ommCzQLCUUlp4CH6g5psWI9p/uhLl+t6ZBWRI/0X6U7Al6Tj6mA8siV
	 NmB/yeL47YUbpn7/8ilItIAawYUGVVc9Pk9Qucg8kzGh8kaliREbOEBe1s9YbvBeMX
	 cyo19SM03nEltewikc9dMTmVKFcL8+fqHKufwTOfCgS13az3XV/a7IuoEemjsLl+E+
	 uJloajBeT0cqw==
Date: Wed, 10 Jul 2024 14:10:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>, kernel@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: arm64: tags_test: conform test to TAP
 output
Message-ID: <Zo6IXQM-R_1YJGIn@finisterre.sirena.org.uk>
References: <20240602132502.4186771-1-usama.anjum@collabora.com>
 <Zo5xCW9GJqFeTZUi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+DeUeqluINSvPD0/"
Content-Disposition: inline
In-Reply-To: <Zo5xCW9GJqFeTZUi@arm.com>
X-Cookie: Your love life will be... interesting.


--+DeUeqluINSvPD0/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2024 at 12:31:21PM +0100, Catalin Marinas wrote:

> Sorry, these patches slipped through the cracks. We seem to be pretty
> inconsistent with using ksft_exit_fail_perror() and ksft_finished(). Is
> there some plan to update the rest or is it only this location that you
> came across?

Any ksft_exit_*() should implicitly do a ksft_finished(), the _exit_
will just exit the test program immediately.  ksft_finished() is for
normal exit from the test program after running everything.

--+DeUeqluINSvPD0/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaOiF0ACgkQJNaLcl1U
h9C03gf/QrzQHK2kkcpp70nVcG6K4B2np85gQ+s3m7dVjryEkMSsEJnNdqiIRlUj
xF44BYqmpc/wt6dMJ6nW8PkDG2/J9+H7HV9W8/FJs27erDOlGWo2QX+vKKP8pi9Q
EpGQyJtDXky0XIudXFr0Oy5E/pEbyhR7/JF9QDxcEgWb18LSja2EgYfZ7IcKd/79
pn3/1HtmqNLMWyf+gCpD1omN/4HXA8Qzh1PHd1XdrclZEIS62y8kf+wk4qXUpM0q
ZkBcmV6EzPtsHZBpKlOpTOoM2oYjULJ45sZB8++bJ8PwF9W4uwashQ5ZWMfgQxmm
x1yea3CyTYgXIXnfkUhxgWn5WpPs0g==
=ecGr
-----END PGP SIGNATURE-----

--+DeUeqluINSvPD0/--

