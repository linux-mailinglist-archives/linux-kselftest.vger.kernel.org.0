Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B35621730
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 15:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiKHOq7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 09:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiKHOq0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 09:46:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E512CA
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 06:46:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5209D615E6
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 14:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C24C433D6;
        Tue,  8 Nov 2022 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667918784;
        bh=5gwYFOVGF4mpjIAIeDXcm5vGvJBWzCTEf0IjQbFWZEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzH1qXQnkEGUUP7fss8g1QQ5kV4xMlp3hi8uLJAqbGqMVIbGQpfRok1Oa3ZCYHMa5
         xOqG2T1tnhMVE63yVbz070A2eFC3W4uHMR1nEKHLnL1YRErPi6E6w+Kv8uSBLbTZA6
         3IdE4fXPgcQhmtsKtcKCG/ZPJpdlmxKhq3hBGckMOx4zg9W9s6q50bwziyQ3iWlfcm
         /T0MqTlJXDe+rGBlgDSdMLKYp32N4+wbFOydfEjoJTBcSrAXiH6e1LqfyMQ09LO7+C
         lc9n37PIKYIUsnmBvViMnQ5W+YG3LRwo9kNM5Hcr1BLLQHxMyq1QXeao/8qTqP2CcB
         M4zgEgR1jVTDw==
Date:   Tue, 8 Nov 2022 14:46:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Liam Girdwood <liam.r.girdwood@intel.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Curtis Malainey <cujomalainey@google.com>,
        Brian Norris <briannorris@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] [RFC] selftests: alsa - add PCM test
Message-ID: <Y2pru8JLAGSjkDiJ@sirena.org.uk>
References: <20221108115914.3751090-1-perex@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xRL3iVwIhEqKXGUP"
Content-Disposition: inline
In-Reply-To: <20221108115914.3751090-1-perex@perex.cz>
X-Cookie: Fortune favors the lucky.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--xRL3iVwIhEqKXGUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 08, 2022 at 12:59:14PM +0100, Jaroslav Kysela wrote:
> This initial code does a simple sample transfer tests. By default,
> all PCM devices are detected and tested with short and long
> buffering parameters for 4 seconds. If the sample transfer timing
> is not in a +-100ms boundary, the test fails. Only the interleaved
> buffering scheme is supported in this version.

Oh, thanks for picking this up - something like this has been on my mind
for ages!  This should probably be copied to Shuah and the kselftest
list as well, I've added them.  This looks basically good to me, I've
got a bunch of comments below but I'm not sure any of them except
possibly the one about not putting values in the configuration file by
default should block getting this merged so:

Reviewed-by: Mark Brown <broonie@kernel.org>

> The configuration may be modified with the configuration files.
> A specific hardware configuration is detected and activated
> using the sysfs regex matching. This allows to use the DMI string
> (/sys/class/dmi/id/* tree) or any other system parameters
> exposed in sysfs for the matching for the CI automation.

> The configuration file may also specify the PCM device list to detect
> the missing PCM devices.

>  create mode 100644 tools/testing/selftests/alsa/alsa-local.h
>  create mode 100644 tools/testing/selftests/alsa/conf.c
>  create mode 100644 tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
>  create mode 100644 tools/testing/selftests/alsa/pcm-test.c

This is a bit unusual for kselftest and might create a bit of churn but
does seem sensible and reasonable to me, it's on the edge of what
kselftest usually covers but seems close enough in scope.  I worry
a bit about ending up needing to add a config fragment as a result but
perhaps we can get away without.

> index 000000000000..0a83f35d43eb
> --- /dev/null
> +++ b/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf

> +       pcm.0.0 {
> +               PLAYBACK {
> +                       test.time1 {
> +                               access RW_INTERLEAVED   # can be omitted - default
> +                               format S16_LE           # can be omitted - default
> +                               rate 48000              # can be omitted - default
> +                               channels 2              # can be omitted - default
> +                               period_size 512
> +                               buffer_size 4096

I think it'd be better to leave these commented by default, especially
if/once we improve the enumeration.  That way the coverage will default
to whatever the tool does by default on the system (including any
checking of constraints for example).  I guess we might want to add a
way of saying "here's what I expect the constraints to be" but that's
very much future work.

> +#ifdef SND_LIB_VER
> +#if SND_LIB_VERSION >= SND_LIB_VER(1, 2, 6)
> +#define LIB_HAS_LOAD_STRING
> +#endif
> +#endif
> +
> +#ifndef LIB_HAS_LOAD_STRING
> +static int snd_config_load_string(snd_config_t **config, const char *s,
> +				  size_t size)
> +{

This is also in mixer-test, we should pull it into a helper library too.
Something that could be done separately/incrementally.

> +	for (i = 0; i < 4; i++) {

> +
> +	snd_pcm_drain(handle);
> +	ms = timestamp_diff_ms(&tstamp);
> +	if (ms < 3900 || ms > 4100) {

It feels like the runtime might be usefully parameterised here - there's
a tradeoff with detecting inaccurate clocks and runtime that people
might want to make.

> +	ksft_set_plan(num_missing + num_pcms * TESTS_PER_PCM);

> +	for (pcm = pcm_missing; pcm != NULL; pcm = pcm->next) {
> +		ksft_test_result(false, "test.missing.%d.%d.%d.%s\n",
> +				 pcm->card, pcm->device, pcm->subdevice,
> +				 snd_pcm_stream_name(pcm->stream));
> +	}

We don't seem to report a successful test.missing anywhere like
find_pcms() so if we ever hit a test.missing then it'll look like a new
test, old test runs won't have logged the failure.  That can change how
people look at any failures that crop up, "it's new and never worked" is
different to "this used to work" and people are likely to just be
running kselftest rather than specifically know this test.  It'd be
better if we counted the cards in the config and used that for our
expected number of test.missings, logging cards that we find here as
well.

> +	for (pcm = pcm_list; pcm != NULL; pcm = pcm->next) {
> +		test_pcm_time1(pcm, "test.time1", "S16_LE", 48000, 2, 512, 4096);
> +		test_pcm_time1(pcm, "test.time2", "S16_LE", 48000, 2, 24000, 192000);
> +	}

It does feel like especially in the case where no configuration is
specified we should be eumerating what the card can do and both
potentially doing more tests (though there's obviously an execution time
tradeoff with going overboard there) and skipping configurations that
the card never claimed to support in the first place.  In particular I'm
expecting we'll see some cards that only do either 44.1kHz or 48kHz and
will get spurious fails by default, and I'd like to see coverage of mono
playback on cards that claim to support it because I suspect there's a
bunch of them that don't actually do the right thing.

Like I say most of this could be done incrementally if we decide it
needs to get done at all though, we shouldn't let perfect be the enemy
of good.

--xRL3iVwIhEqKXGUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNqa7oACgkQJNaLcl1U
h9BTLgf+OYAlhB9FKMmF6Sa4xThE/JjnVMVg+DPOCzb4ZocUXPCrIEys+nY4RHis
mOSfiWmqB2jtrg5LBaDpfKCnsIs8zyVgiLlKFh8GU5dAgmipgptX/0DMr0BuhqaT
6SrF19S8Dm4GJbnIlfBfHYuLJ/H6y7S3lvT4qmD8bN8CTeImvIKBYeiwk2Ge3wSC
06/QbS3IPs2zTObC3NhHhGl31xQ2RgtPBEncD/CFLvyoUr9BUbu9rxsyAiM0ZwBz
A8sEmdXBwpO6o32tgmemlN6MBaeEv0ikZFoEEmTLImNCV9ljXwUBp7cooIXahdyy
NOidsMw6Za1+QSPeS/UKZ3mmRPuLBw==
=o4V8
-----END PGP SIGNATURE-----

--xRL3iVwIhEqKXGUP--
