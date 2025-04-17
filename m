Return-Path: <linux-kselftest+bounces-30989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75416A9100A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4C917F2B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AE227713;
	Thu, 17 Apr 2025 00:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6Cy7/2K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468DEB665;
	Thu, 17 Apr 2025 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744848996; cv=none; b=l398L4yGG4k59BMRLUL9z2jxFDR7ltu8TTXRMkZ3jWnKViiTeiYm49Ppa9REmpx4RYMOQKUHiPyquykMCpHL3nZId6So/sdZ8u0AF8G/eXgh3/Ko1n2xSmPxSMkmJZprV0uEQLGrf2IBAzHguM2BwfvRYTF8hVR3RFrQ8VPKIxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744848996; c=relaxed/simple;
	bh=jAI9+HKtXh5b9rlQYFE5DGfhztxLlcA5ct/sAfAGKRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btKmCxpvnmONcy0WEtJZdmManAYWtETtzXnZ8DwGl123+HASBJxBv+kIHyYRwZlcG1qzraP0/TpMmqjXOqMQ94gUzYyAYOWheMDDh54egcwMe7FpJe5v13a0tOrES63vkOGIQ4A4iJVnanxQHT+sB+OaGe9o64kvKz2YigHXH48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6Cy7/2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00557C4CEE2;
	Thu, 17 Apr 2025 00:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744848995;
	bh=jAI9+HKtXh5b9rlQYFE5DGfhztxLlcA5ct/sAfAGKRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6Cy7/2KCh4/xG17A1WQT7zx4McOhzar3GR+aOGztSrOdf830lwqgmElTbj4Dd3R0
	 BFdPHElLgcToZljE4Hsoj4CE2ZFT68PrN/IVScoighVMbzKMCZqGa/+jtHk3VvDL2b
	 djnJKde75IMXUZoniRvw0av+jYdn2NEk2ADnTP/WTgwmRBFFH9Kb1Guxm4Z0xe3BHt
	 sBdEwNuYoZb63zu8Lk5T+rD4S0VaU/t1YIs8jfN6oVFWn/TkZoE160ZDdBFxgOnjAa
	 kjFNXWfQ2cLRejEsoJxq37AZroK659Grn2NuBLccdDzZPwu3wxxa4lJRUY8Zxah2lb
	 Gr/2sOFtZf8wQ==
Date: Thu, 17 Apr 2025 01:16:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Differentiate bash and dash in
 dynevent_limitations.tc
Message-ID: <9711c674-5d63-4ca6-bf36-fb6399af800c@sirena.org.uk>
References: <20250414210900.4de5e8b9@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EPQlgORsgAo5lLSH"
Content-Disposition: inline
In-Reply-To: <20250414210900.4de5e8b9@gandalf.local.home>
X-Cookie: System going down in 5 minutes.


--EPQlgORsgAo5lLSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 14, 2025 at 09:09:00PM -0400, Steven Rostedt wrote:

> The dynevent_limitations.tc test created a very large list of arguments to
> test the maximum number of arguments to pass to the dynamic events file.

A bit late now since Shuah already applied this but JFTR:

Tested-by: Mark Brown <broonie@kernel.org>

--EPQlgORsgAo5lLSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgASF4ACgkQJNaLcl1U
h9Cflgf9FdIagNHPYwE9GvqjZSQyPRMpg+Q6zQ2laVhYVkUbrs3aDv2N3IOSNIfw
eF8szaJJ2DTfOtb8MMUMexcfWjhC0Zalz/dVcerSjwHpkje3or6Ugn0jNTHNYu2n
QlhTNd5yX+wFAPXTiUygvRIkZ8LeGNOwJdja1jo8vEtzqna/tuoc8Aex11lOhd3Y
Pm6fJOisGsiqiQuR7QDzYniVdUx6sXkF/vxh51aHaP3OtmMh0OgCwCtGRSjKNTxm
VhD50MEhHWHgXtKjr18CTyL2vamldxwvUC7hr5+rQhOPZCVbUarVlsfAot9dmLrt
ZqNin8DwuRB7F4nb0x2qbBaXinDehQ==
=EErK
-----END PGP SIGNATURE-----

--EPQlgORsgAo5lLSH--

