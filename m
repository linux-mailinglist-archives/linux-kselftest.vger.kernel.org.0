Return-Path: <linux-kselftest+bounces-9145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980548B7A8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 16:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82A11C23A4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57DD770E0;
	Tue, 30 Apr 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmPZ0xjG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B693AC16;
	Tue, 30 Apr 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488638; cv=none; b=PyM1Y27/UaLvrWZGBQ7uDb7mBJTF4noBeJBCmqJmi+uX4jhYVcWntO+0KhMRw6kRA9q2wCfUYVBWCQEYzeQmDLN6FMicuOoRdCMdENRPLcNHHsNjMdo++du3JqtI/VjRCIljsItVVhVzNfXXP15bXKOAw9/H87HbNkCh/yb8FVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488638; c=relaxed/simple;
	bh=mbqmnAlN+c26AhPMSZaZL7s7W0uRfeeBO5nO1tKIaTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHPKD1Wu2SdZXieMcW4scWiAgEsEwGuj4x8gALtR1mqW6usugQZU9v4ta9QmgjZtlp+VE33E5UagWASN+GVSXgSLxAHH5LNcV0hQ/+u6rAHkqh1XjKec+SbcF1AkPT6Q5bwnG0xFqbCN5H0kut1/rBQANuLpIf2kMHL0U+7aWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmPZ0xjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F873C2BBFC;
	Tue, 30 Apr 2024 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714488638;
	bh=mbqmnAlN+c26AhPMSZaZL7s7W0uRfeeBO5nO1tKIaTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmPZ0xjGXNdgtEjiLGHMlCaORSmMu4FguUoF4QZVMD8bIfCfM1Swfpi4aJ2itMciG
	 eQNsJfLZy/mLutQU7E8v/rtEymX/hyZd5YbztkRVdmIUriy5Gu9Zr6ozjav3Utq8SY
	 oitMwMgxDBGlttrMG64xNoTxQPIgZxxyiY7s0LcsM6GmwFJmt6/Z14japKAuae/GA6
	 oAl1UcU1oh3uUL7eAujdi5LZEUwihFA8qmlVJkjAyvgk5k37yq1tn9WlZ7fwJB043T
	 n6AJaNnhZGnogPhiQUdaM8EMA6qXjBTH61LWW+yI+0UwctulfrYMQQgoCVAl+ByXuZ
	 I1hLHkk/2NtqQ==
Date: Tue, 30 Apr 2024 23:50:34 +0900
From: Mark Brown <broonie@kernel.org>
To: Valentin Obst <kernel@valentinobst.de>
Cc: jhubbard@nvidia.com, anders.roxell@linaro.org, bpoirier@nvidia.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	mpdesouza@suse.com, nathan@kernel.org, sashal@kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH] selftests: default to host arch for LLVM builds
Message-ID: <ZjEFOj8NXGO72Ocl@finisterre.sirena.org.uk>
References: <b728014e-9e8f-4b65-8d9e-ace0e2f6f18c@nvidia.com>
 <20240430114452.432969-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+2N1ZSdud7IfUbkL"
Content-Disposition: inline
In-Reply-To: <20240430114452.432969-1-kernel@valentinobst.de>
X-Cookie: lisp, v.:


--+2N1ZSdud7IfUbkL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 01:44:52PM +0200, Valentin Obst wrote:
> On 4/29/24 12:04 AM, John Hubbard wrote:

> > I'm expecting to post the series soon, hopefully this week. And I'm
> > thinking maybe I should carry your patch as the first one in the series,
> > in order to ensure it gets picked up. Or, I can just refer to it as a
> > prerequisite in the cover letter.

> Correct me if I'm wrong, but intuitively 30+ patches that touch selftests
> from many different subsystems do not sound like something that is going
> to be merged fast. Since I'm also planning to send a separate series that

It just seems unhelpful to lump everything into a single series - a
large portion of the selftests go with the subystems so you'd be
creating a bunch of cross subsystem issues and large serieses with big
CC lists tend to be both offputting and noisy.

--+2N1ZSdud7IfUbkL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYxBToACgkQJNaLcl1U
h9CnHgf9FW21a3ozXdhj/Oic+zay9OsBXDD5PzsxtHrSfQc8xPMWnsidCS6k8Mb7
NyYuh3KXvLgZ1Q6K6UH19fUxkegq4JrRZxSr/OPLo+oQbkhYsQ9TkUWKrvC+0Cxx
h12qTZdBFAEPEFc9a1yGWrHOR5PoQwV/FY206keYPi25TlYy98MopIsbJBExGOQ1
U2DyAjKFaffspnSJOSsuRw0k3+uZLwscoPUjjqD1SxbFqlNtLFNDNQySOQZkXU73
oXrcYjZ1oSD9LGUkVs5lS8A+DrkOLUZ4/ADKeX9DB7sA6AOnl4a77YBujE7bYGBJ
sin7uM9pMR4A0d83T4DtqLjiFTSkZg==
=4BbA
-----END PGP SIGNATURE-----

--+2N1ZSdud7IfUbkL--

