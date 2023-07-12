Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46843751329
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 00:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjGLWDd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 18:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGLWDb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 18:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8319B;
        Wed, 12 Jul 2023 15:03:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A31861949;
        Wed, 12 Jul 2023 22:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E97C433C7;
        Wed, 12 Jul 2023 22:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689199409;
        bh=bEz3S6Rfs3r5HCNaoCNLul+fdM1q+lRi28PE5uCBHXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KbDqL2AQAS2Z1fvYDH4z9kywGcwQQqljGcCzM1LHn04PLsPDCft5mok13qWKS7f3P
         rer2IW7Z6BToGl64i7rFsZbGDzH17kUeGkIJjVIhl69grtpEDWBiGiLod9nwCFyVCc
         qnFhsei4i9G0iphySf3Lapdf9blNxXh09yYMTj3fHPtISvDmx1/uhMT+mEU4zWulfK
         ZE5kJw69+MT/Fg8qfyplBKvxwDw3Mcq/al6Zfg+dZbXpcn/G1pWMfmNvNMzc2EMmz9
         VyVomWCjWs/fXaSZ+VfrLAphbIYbhYttg8fXxnuwjP0IkBwOs8kADgoJ8rBss/oIp9
         mkr7UaSuIzk5A==
Date:   Wed, 12 Jul 2023 23:03:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     =?iso-8859-1?B?Ik7tY29sYXMgRi4gUi4gQS4i?= Prado 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] kselftest/alsa: pcm-test: Decrease stream duration
 from 4 to 2 seconds
Message-ID: <87ef1544-c1aa-4cce-82f2-60c6f1c2b1c8@sirena.org.uk>
References: <20230620220839.2215057-3-nfraprado@collabora.com>
 <33bea0d3-b8dd-4936-812e-392166df4437@sirena.org.uk>
 <443f697b-fecf-6e8e-0b76-65257aff7da8@perex.cz>
 <9069ad0c-d166-4620-a3de-a36ab233cab0@sirena.org.uk>
 <5c2d5213-5299-44f1-9611-26002c8a5d3a@notapiano>
 <87352krcz5.wl-tiwai@suse.de>
 <f5cab2c2-1638-4d19-aff3-d46ed34b857e@sirena.org.uk>
 <87wmzwptu0.wl-tiwai@suse.de>
 <06b8bfde-e4f1-48ea-aa3e-35d2fe5df046@sirena.org.uk>
 <87wmz8i746.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YOSJHa72S2bjRsM/"
Content-Disposition: inline
In-Reply-To: <87wmz8i746.wl-tiwai@suse.de>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--YOSJHa72S2bjRsM/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 09:00:09AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > For KernelCI we've got coverage on both.  I can also run stuff on the
> > boards I have in my lab on demand of course, but there's more coverage
> > in KernelCI.

> OK, now I applied those two patches to for-next branch (i.e. for 6.6
> kernel).  Let's watch out.

I'm seeing failures on my i.MX6 boards, both the Q and DL have started
failing in the same way:

# default.time3.0.0.0.PLAYBACK - 44.1kHz stereo large periods
# default.time3.0.0.0.PLAYBACK hw_params.RW_INTERLEAVED.S16_LE.44100.2.16383.131064 sw_params.131064
not ok 10 default.time3.0.0.0.PLAYBACK
# time mismatch: expected 2000ms got 2229

reliably (the actual time drifts by a few ms).  The other boards I've
got coverage of seem fine, and I didn't check any broader CI yet.

--YOSJHa72S2bjRsM/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSvIysACgkQJNaLcl1U
h9AoUAf9GFV6uRbjiNwTovFYeApJ9BUjMx0evaR1svC7uHsEc6jzkMQeC2Ssf9Lq
p5dSAPjlNPm6qu2tNRnTc4GWZ7NLvgr0jagowz5fvbesyn+QACOllDp//2q0ar7l
OniJV3ltXp+OmHVIit6PwIBq+G7tTpiNRTR4pJo1TItMS7itfVTHbNYpg9cAZb/W
hZ5hNn2Gzq0BM0BhFsuNryujSkYPkf+Egr1NSCZVVEVVT3bt8iPthuzgu01rMsdM
j86yj67c+kS7VBcAMNsWQc+bEztE8qKoYTYdWw7dY7rx+rFK9CyIJImAfJ7jLt4I
OUrSfUp2owCrxO5LU8xGa/SMTjkSAA==
=8m6M
-----END PGP SIGNATURE-----

--YOSJHa72S2bjRsM/--
