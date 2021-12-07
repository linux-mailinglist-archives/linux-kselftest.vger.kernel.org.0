Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606B246BD8E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 15:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbhLGO2i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 09:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhLGO2i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 09:28:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742E1C061574
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 06:25:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AEC6B817B7
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 14:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB319C341C1;
        Tue,  7 Dec 2021 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638887105;
        bh=XWSl8z8bDIc3cY4UlMtxEGhBhJpDvfLHCNlG3LBUaZ8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=OqMMp3h8+WcxB+3zPWJNtOi3Qh50Y5G+/OQrvzMIlvXn836K57U2yXDfpGiptO4J6
         JXfmF5UQIasH07KYkwBfg+w5IYGrnMkwJv+T6Q/jd07+CiExz137ewTjHVuEXtumEZ
         31uXCoUXzOmElSubyJL6wZIFSDESDb1Bc/HAuNlb534mb2NYMzcPJSGzGYxXyzX7tJ
         Y5SBZNAirdZYzKwtXK7ZmaHa+VVBm9WRLFkhvY2b42+qER1NaAuBvX8gX6BTz3SQ3Y
         ZeOKw+31Wib1ZgA4JsRT0Mqr6s7DpVmgQgjkPH8CF6gtGOlLpO8siE1cKMNEvCssD1
         yp0PQNfR4REng==
Date:   Tue, 7 Dec 2021 14:25:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
Message-ID: <Ya9uvPx37AcOdwLK@sirena.org.uk>
References: <20211206160305.194011-1-broonie@kernel.org>
 <Ya7TAHdMe9i41bsC@workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SAnHYBT7G/FMxttc"
Content-Disposition: inline
In-Reply-To: <Ya7TAHdMe9i41bsC@workstation>
X-Cookie: Only God can make random selections.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--SAnHYBT7G/FMxttc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 07, 2021 at 12:20:32PM +0900, Takashi Sakamoto wrote:
> On Mon, Dec 06, 2021 at 04:03:05PM +0000, Mark Brown wrote:

> I think it safer to take care of volatile attribute when comparing read
> value to written value. I'm glad if you review below patch.

Yes, that's a good spot, it was an oversight to not take care of
volatile controls - I'll roll that in if I send a new version or
I guess Takashi could apply on top of my v2?  If people are mostly happy
and at Jaroslav is also preparing patches on top of this it might make
sense to get it into git sooner.

Reviewed-by: Mark Brown <broonie@kernel.org>

> As another topic, the runtime of alsa-lib application largely differs
> between process user due to the result of parsing text files for
> configuration space. I can easily imagine that developers unfamiliar to
> alsa-lib carelessly adds invalid or inadequate configurations to files
> under target path of alsa-lib configuration space, and they are puzzled
> since they are unaware of the fact that the kselftest is affected by
> userspace stuffs for the runtime.

> If we respect the basic theory of test (idempotence), we can use ioctl(2)
> with requests for ALSA control interface since it's not so complicated
> (at least it is easier than ALSA PCM interface). The purpose of
> kselftest is to test kernel stuffs, not to test userspace stuffs
> including alsa-lib implementation and variety of plugins.

Right, I was originally thinking of implementing this in terms of
tinyalsa which is much more direct (though I was amused to see that's
gained userspace plugins at some point!) partly for this reason but the
lack of widespread packaging for it was a bit of a blocker and it didn't
feel like a great idea to essentially do yet another userspace ALSA
library even if as you say it can be pretty trivial.  Jaroslav's
suggestion of using a custom configuration to override the default seems
like it addresses everything though.

I do think there's an advantage for test comprehensibility in having the
test written in terms of similar APIs to a normal userspace application
- it makes it easier to relate what the test is doing to normal usage
which is helpful when trying to understand what the test is trying to
tell you.

--SAnHYBT7G/FMxttc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGvbrsACgkQJNaLcl1U
h9BLrAf/T3grq1I+17ob6+wag4tm9GXkoicm9ezwbnlqflJSIKCoXltGpJUBck85
K3rSaFASldn9oPicWZ5zB7QoCblVJOQrvhUsFs3uZnWYZqsfgY50OXkFLzUp8wtT
9gvMghXWSTaF1u55l5JJ9FkC1dChoEynb5vowP+3UzQKPocaJSZ3/RKZSdwy1o80
Jw7fAsOQ8sMzj6SrtIrL9QOj8DMbIBMwx3S9T+GfR8chJA8Ovo8M3O7mnJRxH/TU
WGcR0paAbBsCV/YJhQDkpelLQEmuvmcfV9a5a5Dp/ir7nPlI4ShGZ3yX3Pxpa//8
4QZgLL9OEPMnmTjN+19Wr7+o8HYY0w==
=RWoN
-----END PGP SIGNATURE-----

--SAnHYBT7G/FMxttc--
