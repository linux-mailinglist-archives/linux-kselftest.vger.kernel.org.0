Return-Path: <linux-kselftest+bounces-6664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DDB88CDD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 21:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3162F1C3D69E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 20:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828A13D28F;
	Tue, 26 Mar 2024 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwGg+WBD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594F013D26D;
	Tue, 26 Mar 2024 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483648; cv=none; b=DIWe5M3qPor5L7NfJulUDRLV8CF745jIt+MuF8k0kjoaCBFojDmrdOhnCHQQk3Wr30mOEDKoPdf0TdQFjRBWzlEYS+crblWSv7z/ldyWDNZ7+nKqr1I054aOL9SH60BxU8EvneED0BdLaKgdT4/xPf0MxheNphgr5dh51w0NJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483648; c=relaxed/simple;
	bh=qN457HyeTZhamTl63ndalRGWGEdQLP0NXQQYmykMAZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8U52r956M8E8d+PxEN0EwKjDvtFYZ5nRLyebF2iicWKSwXTDIt7JFOw1SiVj+L31vD85G5PwJ3l+6Y0NWfWiHVL9lPiG6uBS3m5Z70q7BnwDzpA6LXM7Pw4gnsH6VOvgEP4bXn3jKUNZkXkVyGozJj02G/GY0z0kLS4aq89ABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwGg+WBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B020C433F1;
	Tue, 26 Mar 2024 20:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711483647;
	bh=qN457HyeTZhamTl63ndalRGWGEdQLP0NXQQYmykMAZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwGg+WBDnjO0fhcLggiiMCcpYRa/CH/88cK8SrsocN+BBOwfqxaQg4qWkeGZDSLO6
	 VLPdzgkzyQUC54eJctbtDB3CoXEqB0KamTSn2U6rOJPsVjWVj3V5GFddfRkEkK7Ymu
	 1JRDIm8sBPuee8IssT3qw7gLJfC4MgKMGT9Ss3gg/pqtiOz/9qnjP6E4X6RX+U6xpx
	 V6Z9WV0p0R5dNGspr57IB/XByPiFD7Wzmv3Y//cGFJUQTK+ptM0Pfx2QUiMPeemUfD
	 3sVu2fn0VyqeuM44OkiWUi6nBI9i5Wafa9PD4fHNO1nZDyFP19qnqUlDJFh5X97bFQ
	 eP+VeqsaT3w7g==
Date: Tue, 26 Mar 2024 20:07:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Michal Sekletar <msekleta@redhat.com>, linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kselftest/tty: Improve integration with automated
 systems
Message-ID: <892c8456-22bd-41cc-aafd-265a24748de5@sirena.org.uk>
References: <20240306-kselftest-tty-tname-v1-0-33505b31629e@kernel.org>
 <2024030633-managing-identical-9b92@gregkh>
 <6b0e9e08-62c3-4fed-95d8-185ceb4ce67f@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bpPy6tf6eqE9t/SC"
Content-Disposition: inline
In-Reply-To: <6b0e9e08-62c3-4fed-95d8-185ceb4ce67f@linuxfoundation.org>
X-Cookie: Equal bytes for women.


--bpPy6tf6eqE9t/SC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 01:49:11PM -0600, Shuah Khan wrote:
> On 3/6/24 15:51, Greg Kroah-Hartman wrote:
> > On Wed, Mar 06, 2024 at 07:21:24PM +0000, Mark Brown wrote:

> > > This cleans up the output of the tty_tstamp_update selftest to play a
> > > bit more nicely with automated systems parsing the test output.
> > >=20
> > > To do this I've also added a new helper ksft_test_result() which take=
s a
> > > KSFT_ code as a report, this is something I've wanted on other occasi=
ons
> > > but restructured things to avoid needing it.  This time I figured I'd
> > > just add it since it keeps coming up.

> > > Signed-off-by: Mark Brown <broonie@kernel.org>

> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> Thank you. Applied to linux-kselftest next for 6.10-rc1.

Thanks, but note that I sent a v2 based on v6.9-rc1 which drops the
first patch in favour of using the newly added ksft_test_result_code()
which does something similar (though with a slightly less idiomatic
API).

--bpPy6tf6eqE9t/SC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYDKvoACgkQJNaLcl1U
h9D+5wf/do4l7lPuTdGaLogAi6LgGDGJq0NAkpQA8Lhyi+4p5OpHUu+a23kPxCy1
RihNJloRh2+75+rBGeqSHX8l4QlV01wwLFpbXUEmd4GEK0bpJiu52qWk20ePp5lY
aYHjpBtWGo5Ci2/Yw6RNEt+ztm6iElpWfH+Tc9NPd4ABzm0mxi/bmoU7YRrPIZkT
CsMSOlfKQOMc9ox1SEEX9On5zWmCqAKZ5pHzVRO1uBP59P8nEawu84p8YTVZ+RnH
hSkcwbwqk2cG8EEq3Mr9BevAAGr7/0cc6bma3w+0f7fsYN3wpvjqxpUwQFBJgty8
nejyLpvgcCETtEbw3fPW5eaRSzcICA==
=p+9L
-----END PGP SIGNATURE-----

--bpPy6tf6eqE9t/SC--

