Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA749A514
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 03:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3409015AbiAYAYk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 19:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2368880AbiAYAAV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 19:00:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF36C10015C
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 13:48:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F2D061028
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 21:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F6DC340E5;
        Mon, 24 Jan 2022 21:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643060897;
        bh=50+UALUPVbunurEjC0UVh84iQHXJWlzJWNwUTawoMqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjCI9I/rT4m54QNqL9HGwwiZqJa8/a7nXn/vZ2DxiC2j3bi7+sRMUBLdzPiQO1LW8
         lAcUSGvVHG7uQAiscQ189Ho5dl/NBLQTYu7D1DEmyKYc3O+3We565pIMhxa1PPBzjg
         8lbJnaDDN8AM6lRGdeKheQCGLKXg6rpIkY6utCThiTEpAfo0JIHO0L2UOQI8cnz5PR
         3O6iPvAsjYof8oBNIqz/H0qulq/ptdpVFXuABt9o6cAPld2tt/xyxnLm3P7+NoBBZ5
         L4u3ZY3LLEnnK2CkGoeDQgB+XrZzy04bQmW2yw26XD73rkUSPdVUVrrWmEapZKKs6L
         DbV22dxB2D8oQ==
Date:   Mon, 24 Jan 2022 21:48:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] kselftest: alsa: Add test case for writing invalid values
Message-ID: <Ye8enGjqmiUB9HTw@sirena.org.uk>
References: <20220124151410.2715572-1-broonie@kernel.org>
 <f9a0addc-9e81-b2c2-e5c7-d5e69dae26cd@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cwaJp+ta+0NJ0ix2"
Content-Disposition: inline
In-Reply-To: <f9a0addc-9e81-b2c2-e5c7-d5e69dae26cd@linuxfoundation.org>
X-Cookie: The second best policy is dishonesty.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--cwaJp+ta+0NJ0ix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 24, 2022 at 02:35:53PM -0700, Shuah Khan wrote:
> On 1/24/22 8:14 AM, Mark Brown wrote:

> > +	/* Restore the default value to minimise disruption */
> > +	err = write_and_verify(ctl, ctl->def_val, NULL);

> Why not read the value and then restore the value, in case the value
> before the write test is different from the ctl->def_val?

That's what we're doing - def_val is the value read from the device at
the start of the test program before it tries to do any writes, we then
restore it at the end of every test to minimise the chances that the
device configuration will be messed up if the test program falls over.

--cwaJp+ta+0NJ0ix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHvHpsACgkQJNaLcl1U
h9DTkwf/cU056WrJZ2F9IyNRorjNUrNAm2Fmlihu3pVp1r5qqN6evIhVF9j7vuPe
Ym/WtIXTeqZmAczFWVCtG5H70D7WmJ1feUbFTO94Aw22Q6ufP94VdX7ccRcNBEA6
aXEiLKbZON0UnnLQud5OyApNZ9K2qNZtGbvzmQA3Y+3EyeX6InVSU9kgK6wo7YUh
3AB/I9CchMRRis4kgnWb7SvfwLNLgj6ZF6YOT4IwTB/aAnaODhChoe0VG3JUxIJu
YlRSDYWp4RI2CNhDpLQDiSqKkrvkcuF5q1ru0KOeN+dqMmKhrnt5ptB1G4IRNI4w
NUo2GsLuibsPEIuLNlTrtsrh+sYKPg==
=vBl0
-----END PGP SIGNATURE-----

--cwaJp+ta+0NJ0ix2--
