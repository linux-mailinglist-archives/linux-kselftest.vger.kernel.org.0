Return-Path: <linux-kselftest+bounces-5998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834938737AB
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 14:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FAD1F21700
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 13:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3715E130AFC;
	Wed,  6 Mar 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/ph4DFX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0110612D1FC;
	Wed,  6 Mar 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731528; cv=none; b=cq4hUFUlQeAx1QULfcdVsT2MM0j+jgti3POOskFaGQOXqo2Ti+TMoUCFJHQGpdf6g+B9iJePOQS0BEQqcHm/3xlmTOEbNvTBrZTz1mSQ/+vJbCflb2M2bH/AGWyqVpaXUZ4ThIMl2FBeH1sqP0ET5WpGecqCskC9OLb7VTF8y2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731528; c=relaxed/simple;
	bh=Kh2Ebket9d7as8vvmamHqBCPWWX5EhjBSevupRPlaz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+Nl2C4d2h6AuaAsAIXmG5cdkMWrq+bYALxVwz18z80BHs48bAtD8CzzFWaRGFhGqSuDVfdy7o5etMFWcwQ1pnSQynQGpgj70IqA2xU6g6u3pIP0U7BregWFIvtaUrZ+7H7FoZKaFDTw8jZwppQHL22/dKUBk1LJR0jN1Y4+HPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/ph4DFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC03EC433F1;
	Wed,  6 Mar 2024 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709731527;
	bh=Kh2Ebket9d7as8vvmamHqBCPWWX5EhjBSevupRPlaz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t/ph4DFXRJayQ2ild59MfAIg4bBwulm8dokY6du0gkP38qfJjeNu9e3M4CnsQQrSn
	 7ZCclJa2ZKqZVGrnx+laqKhPQ1Ei8UDVONnDK9Xl+gZjSDKsiD0+2JlyC6ad2jACsP
	 JWGaTYNXyM1zNdO01MKlxZZK22MADH2pJMtNapy9b8HlS1tLZiyho6miaiK8qOU8kb
	 7JnwL0eRsAe3sMq3STq1wWaCq3DgvusO0vzVRK67kxhawc2W3K3JRZMTzuX+j2NLfc
	 fKTcZ2KYBWSCwwbvCwTa2ctAnbXLQlGQRKeSbyIkjy0dEPvzV9QSrDHQUucg5JwOvD
	 LC5vuGPTGFoVQ==
Date: Wed, 6 Mar 2024 13:25:21 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>, edumazet@google.com,
	jakub@cloudflare.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] selftests/harness: Fix TEST_F()'s vfork handling
Message-ID: <56384a64-2570-41b2-b76e-cc57fe76710a@sirena.org.uk>
References: <20240305.sheeF9yain1O@digikod.net>
 <20240305201029.1331333-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxX3NQjSxvpOqvOM"
Content-Disposition: inline
In-Reply-To: <20240305201029.1331333-1-mic@digikod.net>
X-Cookie: Have at you!


--zxX3NQjSxvpOqvOM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 09:10:29PM +0100, Micka=EBl Sala=FCn wrote:
> Always run fixture setup in the grandchild process, and by default also
> run the teardown in the same process.  However, this change makes it
> possible to run the teardown in a parent process when
> _metadata->teardown_parent is set to true (e.g. in fixture setup).

This fixes the seccomp isues for me, thanks:

Tested-by: Mark Brown <broonie@kernel.org>

--zxX3NQjSxvpOqvOM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXobsEACgkQJNaLcl1U
h9DG3wf+MinaM5BXBAhG5DvbveKvr85agXlt4D40zkDCyRFyyvHtX2j333Z67i/M
421U3rDVDcc+MEs2MgTMuMtNjC47gWyuj8/OUcEYr/1iYTRVNWbWyCYky7Ex3tqh
gJxcqOKdU92AOPM7tNnQtp96fQvhR5QKfW5uQYFr9m4o5Ou/ROr5+EqSD2PohUBr
k7YO7qnnR4IObGoVh6IClvYfvFjRmJcPsgJMtvIUbxb4wbbhhfEITSv7wGorKw2Y
uHheAKDk7LnOLfFx+nUHIZrNeZ+lg2WWt8/gYZNv3YRUIzQ3OkEsW2XbgezOze+z
9L9tGVrWqEcMsu9RNjQCk6wU0vBfMQ==
=zkdw
-----END PGP SIGNATURE-----

--zxX3NQjSxvpOqvOM--

