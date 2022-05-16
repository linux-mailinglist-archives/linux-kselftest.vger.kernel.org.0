Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE3F52836E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 13:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiEPLo2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 07:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiEPLo1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 07:44:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6BEDFBF;
        Mon, 16 May 2022 04:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3F77B810DF;
        Mon, 16 May 2022 11:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC2AC385AA;
        Mon, 16 May 2022 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652701463;
        bh=EmxLfawp5Dk6/SWKDlV1mvHcmHp8Dr2enYG7AsV29zI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ou5Z19QMaL128kR/T8bZXm/wLzTNxYqOdfkNiXnjEgrc2bo6IWp1OnecrFTlknVgt
         kQJFP+/VRUDKo+19pG/qpKsrqRrYWxiYanJADfhRwNY55BHgBVmVtKSm5wV+8OaZCr
         W1zfGmpFtwQa++M5oZ+AIjTP0LCQ00npV+JSoAtEMV63eBIuQaPlFOVHH/q1KNabPD
         XD8BqzYHXkVGKbCIU3VDjbbECwrqZu8gZCnMmAJsuxWjtrHWR5/EHoIInfwjvMdoA6
         IIzcR6b9yvPT9J+lLBrYXSW94MH3L3JfMWSgrurqm9dyJ2Ni6ftLdRWPr/FjPxtClL
         pxlIMvxpeMRjA==
Date:   Mon, 16 May 2022 12:44:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Siddh Raman Pant <siddhpant.gh@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: alsa: Better error messages
Message-ID: <YoI5EEPjOQPzB6se@sirena.org.uk>
References: <8598037d-0e24-9bc1-3f2c-a2751ec8e871@gmail.com>
 <s5h35h9c3yn.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5M0Q1jZTiTZHriO1"
Content-Disposition: inline
In-Reply-To: <s5h35h9c3yn.wl-tiwai@suse.de>
X-Cookie: May be too intense for some viewers.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--5M0Q1jZTiTZHriO1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 16, 2022 at 09:49:04AM +0200, Takashi Iwai wrote:
> On Fri, 13 May 2022 15:40:57 +0200,
> Siddh Raman Pant wrote:

> > This allows for potentially better machine-parsing due to an
> > expected / fixed format. Also because of eyecandy reasons.

> > Whenever possible, errors will start with the name of the
> > offending card/control, separated by the error with colons.

> > Whenever there is a description of an error given, the generated
> > error string from snd_strerror will be (mostly) enclosed in
> > parentheses at the end.

> > Clarity of error messages have been (hopefully) improved.

> But, honestly speaking, I'm not sure whether it worth.
> Although it's possibly a bit more consistent over all texts, I
> don't see significant improvement by this change.

> But I'm fine to apply it, so keep this pending and would like to
> hear from others.

Some of it is probably fine but there's a lot of different changes for a
lot of different styles in here, not all of which look great to me.

--5M0Q1jZTiTZHriO1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKCORAACgkQJNaLcl1U
h9DH2wf/V+ceewah5O1Pfdjt0PzOsKcr3er5o2sR3Bn2bVPSb37LtrKyLUXz+PNR
F7JqHqiJRA2ynQUsxWpRKneSLj8rMCh1QPl9k4DJiELy5UzhRiEPoKqaF4qyDW0l
03Ts3YCLGoZ8+jUr+ke67Gz63B5kxmrzoXsHjcp8d/xPMy7mUZYtJqzDN2Vdqxqr
U6iDhB2qN+sL6dw+2TpYs1PvKjrKETlEaieH0Q4CTJSACs/WN5aYFZNoVzmOgwwC
yb+0gevUiAtTZCjgu6Ki+BveQaUa39P3HNoOU9NSdPjkqHt1H7ixIHiaJANzT1xZ
VX5E8TqorRsoIoDtvTeoxdbsF7mfWg==
=xUpY
-----END PGP SIGNATURE-----

--5M0Q1jZTiTZHriO1--
