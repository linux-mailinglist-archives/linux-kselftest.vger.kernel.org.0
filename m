Return-Path: <linux-kselftest+bounces-5859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE67871000
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 23:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B03B1C208BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 22:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9251C6AB;
	Mon,  4 Mar 2024 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDdYgZaq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A451C687;
	Mon,  4 Mar 2024 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590808; cv=none; b=RmeYx7t0rN7MeoV6E2y/1UesQ2MYtiHR4ZCXEuRLpCY5kU4NTdfoGPTCy+lTohcsKbl3hRgYW+/sI2+Ck+6NbJUEhvSxMQW6Tw8pk3cH+o5wPq4EzHEM7UlvWex7regXGZb8xVKZAp2/EfLP7TIg5U68DklRxC07O70iBHPdPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590808; c=relaxed/simple;
	bh=qmXTnNqvGt/oGPfYFvQo/wwd8VyuHl2B3KGyc0VaoqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzliQcHnTbIM81U4eV3u8YgspTXM9D8Bbz9g8sH6TRo+uHP3sJTXLnZTM04YZ06yw19LKRiKBVOojuyaNTvmPFbvJ9XvO8pXANzHPOH9pp4F2j4jp7xOA2raRo4HHc9GGOqVdWWcPiiRGnKLtDQ46O9YmUYJUWij4IBRpDRJ1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDdYgZaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06527C433F1;
	Mon,  4 Mar 2024 22:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709590808;
	bh=qmXTnNqvGt/oGPfYFvQo/wwd8VyuHl2B3KGyc0VaoqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDdYgZaqr6a7IMnlvahw8/3PrwYyKa/cGswY9lH/jT+2FZGkibixj8Mr0JylYmB9k
	 9ypVf3NPzPlJ96nXtKi9kPg89ozUMwpv9J6VyI0n/6CDuy4FHxHI4OrlUQuIUmWF3H
	 wgF6f3e0Mga+yfwdzvDqo7JDgGLrD0VTVlCUFTFqo9J2/i8ggiTGhKze4RwIgbNZK0
	 i99nyPC762w8OxNMarTehIneVhKvUcy2xSnW3NvhoJZDpKDziP5o5u9MnaIrg+rR0c
	 ZcfKG5VA3fLAixREyINZ7S0GBK5Ui7svIu5+mVhPvz6k0dkURJHj7Y1cY2Xm1jIhv7
	 RhGfTq+11RVvQ==
Date: Mon, 4 Mar 2024 22:20:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	jakub@cloudflare.com
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using
 xfail
Message-ID: <05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
References: <20240229005920.2407409-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hO45sqC4rUaVfCUw"
Content-Disposition: inline
In-Reply-To: <20240229005920.2407409-1-kuba@kernel.org>
X-Cookie: Please come again.


--hO45sqC4rUaVfCUw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 04:59:07PM -0800, Jakub Kicinski wrote:

> When running selftests for our subsystem in our CI we'd like all
> tests to pass. Currently some tests use SKIP for cases they
> expect to fail, because the kselftest_harness limits the return
> codes to pass/fail/skip. XFAIL which would be a great match
> here cannot be used.
>=20
> Remove the no_print handling and use vfork() to run the test in
> a different process than the setup. This way we don't need to
> pass "failing step" via the exit code. Further clean up the exit
> codes so that we can use all KSFT_* values. Rewrite the result
> printing to make handling XFAIL/XPASS easier. Support tests
> declaring combinations of fixture + variant they expect to fail.

This series landed in -next today and has caused breakage on all
platforms in the ALSA pcmtest-driver test.  When run on systems that
don't have the driver it needs loaded the test skip but since this
series was merged skipped tests are logged but then reported back as
failures:

# selftests: alsa: test-pcmtest-driver
# TAP version 13
# 1..5
# # Starting 5 tests from 1 test cases.
# #  RUN           pcmtest.playback ...
# #      SKIP      Can't read patterns. Probably, module isn't loaded
# # playback: Test failed
# #          FAIL  pcmtest.playback
# not ok 1 pcmtest.playback #  Can't read patterns. Probably, module isn't =
loaded
# #  RUN           pcmtest.capture ...
# #      SKIP      Can't read patterns. Probably, module isn't loaded
# # capture: Test failed
# #          FAIL  pcmtest.capture
# not ok 2 pcmtest.capture #  Can't read patterns. Probably, module isn't l=
oaded
# #  RUN           pcmtest.ni_capture ...
# #      SKIP      Can't read patterns. Probably, module isn't loaded
# # ni_capture: Test failed
# #          FAIL  pcmtest.ni_capture
# not ok 3 pcmtest.ni_capture #  Can't read patterns. Probably, module isn'=
t loaded
# #  RUN           pcmtest.ni_playback ...
# #      SKIP      Can't read patterns. Probably, module isn't loaded
# # ni_playback: Test failed
# #          FAIL  pcmtest.ni_playback
# not ok 4 pcmtest.ni_playback #  Can't read patterns. Probably, module isn=
't loaded
# #  RUN           pcmtest.reset_ioctl ...
# #      SKIP      Can't read patterns. Probably, module isn't loaded
# # reset_ioctl: Test failed
# #          FAIL  pcmtest.reset_ioctl
# not ok 5 pcmtest.reset_ioctl #  Can't read patterns. Probably, module isn=
't loaded
# # FAILED: 0 / 5 tests passed.
# # Totals: pass:0 fail:5 xfail:0 xpass:0 skip:0 error:0

I haven't completely isolated the issue due to some other breakage
that's making it harder that it should be to test. =20

A sample full log can be seen at:

   https://lava.sirena.org.uk/scheduler/job/659576#L1349

but there's no more context.  I'm also seeing some breakage in the
seccomp selftests which also use kselftest-harness:

# #  RUN           TRAP.dfl ...
# # dfl: Test exited normally instead of by signal (code: 0)
# #          FAIL  TRAP.dfl
# not ok 56 TRAP.dfl
# #  RUN           TRAP.ign ...
# # ign: Test exited normally instead of by signal (code: 0)
# #          FAIL  TRAP.ign
# not ok 57 TRAP.ign

and looks suspiciously like it might also be related.  Again, not
drilled down fully yet or looked at the code but this series jumps out
as most likely relevant.

Full log at:

   https://validation.linaro.org/scheduler/job/4046205#L6066

--hO45sqC4rUaVfCUw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXmSRIACgkQJNaLcl1U
h9BhQgf/bFLmzfQuUxA6124NIKiqdndv7e/KA0FS32nG+TW6aE1QxkZxEDz8Cw41
vdfUdr3GmkTmdx+n1H+40+1HFSEiKXG5D1CJ17nsMcCDwIr2xRXNHPevXMuyOep+
fkhT1DhySxlHwoCMzhSWbwpkU6NVEjM0KnS5RLBjHeClNyrUd/jzNxkJml/INjG/
H0X2ZzaRHUN+UXj3EKxhnjKECOohoymyuTVsybJkXOgycTZj04vk/0yoQDQ2sjdN
T35tT0DQCmbHkznSUmT49IyDNdIwQufaqA3bw1M2HjYgyvRy3ir/6XVV5XJVzLUD
WKoUYhmZFNyt8+SomPIKivgDrnjvOA==
=PkaD
-----END PGP SIGNATURE-----

--hO45sqC4rUaVfCUw--

