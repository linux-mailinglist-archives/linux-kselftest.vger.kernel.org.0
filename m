Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D3F63F895
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 20:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiLATwU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 14:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLATwT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 14:52:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95290B8469
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 11:52:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B2CA62109
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 19:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6015AC433D6;
        Thu,  1 Dec 2022 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669924337;
        bh=E8LneJJGahSRzAFyNkoofCvon5tjAeUOeY9NwqMnrrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qugjgLZBohQvVbkv30NRqEvnOaw6oSDnrPjIBYfO3PdIWw8bd7ovMFLtrSENV0LWH
         zbehtN12UnGwFxKSTtzy4SjsRH5l8vXltSg12S6BpR35gMEQtRkb+uZ+6TSHu5BmN0
         9BRI6BRDlNv+uySSJLoKBhJNEMGGp36gx3LGUwqm7/504gzUXmfboELlIcr22BZsok
         CbAfxISX2y0gu5alDa63X9tpWSrbZYtXA17yheZw0fqNw3zeyA3TkxNZNdi3wYkuAd
         gKBdfIhCPjd1ACPpg9P+UZJaJSpZ+od2XQFesneprDf7bxuG4n0YkQtXaDJCh2mxW6
         tR98rgUqpCmtw==
Date:   Thu, 1 Dec 2022 19:52:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftests/alsa: pcm - move more configuration to
 configuration files
Message-ID: <Y4kF7fG70EySxDQn@sirena.org.uk>
References: <20221201173333.2494019-1-perex@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="53hJecbtB+xfMhYR"
Content-Disposition: inline
In-Reply-To: <20221201173333.2494019-1-perex@perex.cz>
X-Cookie: Leveraging always beats prototyping.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--53hJecbtB+xfMhYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2022 at 06:33:33PM +0100, Jaroslav Kysela wrote:

> Obtain all test parameters from the configuration files. The defaults
> are defined in the pcm-test.conf file. The test count and parameters
> may be variable per specific hardware.

> Also, handle alt_formats field now (with the fixes in the format loop).
> It replaces the original "automatic" logic which is not so universal.

> The code may be further extended to skip various tests based
> on the configuration hints, if the exact PCM hardware parameters
> are not available for the given hardware.

> --- a/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
> +++ b/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
> @@ -55,6 +55,14 @@ card.hda {
>  				period_size 24000
>  				buffer_size 192000
>  			}
> +			test.time3 {
> +				access RW_INTERLEAVED
> +				format S16_LE
> +				rate 44100
> +				channels 2
> +				period_size 24000
> +				buffer_size 192000
> +			}

I really do think we should be giving these names which help people
understand what the tests are intending to cover, it'll make it easier
to both understand the results and maintian the configurations going
forward.  Or at least commenting things, but names is probably better.
Since the timeN is also used to figure out what type of test we're doing
that'd mean either adding an explicit test_type field=20

	pcm.test.48k2_S16 {
		test_type time

or block

	pcm.test.time.48k2_S16

or alternatively adding a human reabale name field

	pcm.test.time1 {
		description "48kHz Stereo S16_LE"

which is more readable but does mean that automated systems aren't going
to surface the meaningful name for users so readily - you get things
like

	https://linux.kernelci.org/test/plan/id/6388c0cba8274c94402abd12/
	https://linux.kernelci.org/test/plan/id/6388ce6efef77e61ab2abd10/

so there's a UI barrier before people see the test.

mixer-test is kind of "fun" in how many test results it can generate on
bigger systems but hey, and there's some output corruption going on in
the first link which looses us the capture tests.  I have toyed with the
idea of putting the control names into the mixer test names, but some of
the test systems currently struggle with parsing spaces in the test
name.

I do see this is all kind of baked into snd_config_get_type()
unfortunately so perhaps the new description/name field is the best
option here?  We could add that incrementally.

>  	for (pcm =3D pcm_list; pcm !=3D NULL; pcm =3D pcm->next) {
> -		test_pcm_time1(pcm, "test.time1", "S16_LE", 48000, 2, 512, 4096);
> -		test_pcm_time1(pcm, "test.time2", "S16_LE", 48000, 2, 24000, 192000);
> +		cfg =3D pcm->pcm_config;
> +		if (cfg =3D=3D NULL)
> +			cfg =3D default_pcm_config;
> +		cfg =3D conf_get_subtree(cfg, "test", NULL);
> +		if (cfg =3D=3D NULL)
> +			continue;
> +		snd_config_for_each(i, next, cfg) {

I can see the benefit in moving the defaults to a configuration file
instead of code but rather than having it be an either/or it seems much
better to have the board specific configuration file extend the
defaults, resulting in us looping over both files if we've got both.
We'd need to have something that avoided collisions, perhaps the
simplest thing would be to just add an element into the printed test
name for the source of the config so we get output like:

	ok 1 test.default.time1.0.0.0.PLAYBACK
	ok 2 test.system.time1.0.0.0.PLAYBACK

That does mean that the system test list can't replace the generic test
list but like I said elsewhere I think that would be a good thing for
clarity anyway ("X works on system A but not the very similar system B,
what's broken about system B...").

> --- /dev/null
> +++ b/tools/testing/selftests/alsa/pcm-test.conf
> @@ -0,0 +1,16 @@
> +pcm.test.time1 {
> +	format S16_LE
> +	alt_formats [ S32_LE ]
> +	rate 48000
> +	channels 2
> +	period_size 512
> +	buffer_size 4096
> +}
> +pcm.test.time2 {
> +	format S16_LE
> +	alt_formats [ S32_LE ]
> +	rate 48000
> +	channels 2
> +	period_size 24000
> +	buffer_size 192000
> +}

It's probably especially important that anything in a default
configuration should skip on the constraints not being satisfied since
we've no idea what the hardware we're running on is.  Rather than
requiring skipping to be explicitly configured perhaps we could just set
a flag based on if we're reading the default tests or a system specific
file, I'm not sure I see a sensible use case for system specific tests
specifying a configuration that can't be satisfied.  Doing things that
way the flag could either mean we add skipping or that we report two
results for each configured test:

	not ok 1 test.system.time1.0.0.0.PLAYBACK.constraints
	ok 2 test.system.time1.0.0.0.PLAYBACK # SKIP

which is perhaps marginally simpler to implement and makes it clearer in
the results if it was a straight up logic failure rather than a timing
failure.

I would also like to see 44.1kHz, 96kHz and at least one mono and one 6
channel configuration adding (in my patches I added 8kHz mono since it's
the most common practical mono format and 8kHz stereo so if 8kHz mono
doesn't work it's a bit more obvious if it's mono or 8kHz that's broken).
That could definitely be done incrementally though.

--53hJecbtB+xfMhYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOJBewACgkQJNaLcl1U
h9AwhQf+J4U/pJ+kkchlGBmuS0cYhVtEf6P11C55p0kWxXnizGRG0xKdzx8ZYxPy
2E520aiMi1lbaLolobgOVo8CZFEjY+W8fBMOLfJbC9Lqui5/2DCGck/bc29KTHS2
K5lFqwm0AZnKscwG4HkPx2FVPm3Og9EmAwA0iOHVGUciEnqSxPh+TGFkrAdYhky9
CxhneiMRqZ1Cy2LjkAO/+6CFRELCPk5GyXylUvqBDjqnAYuCZEn1NG+Wy/q0fwLl
JWIs+rqlRm0L2rpYGY94CKOQKNxCR4Ya0HNaM3G3CCeXe49FDCynPjcvC7UAlQ/1
CnIRaVhnxpiUJlade6k9XLWeXnhwyA==
=4Ams
-----END PGP SIGNATURE-----

--53hJecbtB+xfMhYR--
