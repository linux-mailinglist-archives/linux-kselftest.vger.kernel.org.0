Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A2864CF3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Dec 2022 19:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiLNSPb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 13:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLNSPa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 13:15:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83811742E;
        Wed, 14 Dec 2022 10:15:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A503FB819DB;
        Wed, 14 Dec 2022 18:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572D6C433EF;
        Wed, 14 Dec 2022 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671041727;
        bh=0BmA2sdUmN/0H6bbu4xldL4TdosNr/M4n0sVyfeeegI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHcRYNrgY1gXRhfqCBWuxjsuOtI33SPuvTT1HAPzxZ0IrB6ukcSjj5Oc5bG5Q7MYf
         ZQNtum52MYbK0xqH4tufnWroG3wBsBA5/sPuW+vP8ERzGcX4uN1w1Oiwg24PfCRsgg
         vfMn8lgffN6fN2x0xxtSNGVWZ7Z5TezGgo8KmSYQ0Kr5irTL5NFD1bwbryBc8Nu9cT
         r+LJN82SqhT+737X7U5Y8bWAFQr8tJsiVNlNn66CqH6eMlVGadZDoy9h3lq9EFSKuH
         H6abOUTIyISkcdz3Mv2795diG5GfCrF78CmxQ8lYTF/3ic6ic88/F7Fz5JVeS2aLgl
         zcll0XRluPOfA==
Date:   Wed, 14 Dec 2022 18:15:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>, kernel@collabora.com,
        Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] kselftest/alsa: Increase kselftest timeout
Message-ID: <Y5oSui0udT/6cvSI@sirena.org.uk>
References: <20221214130353.1989075-1-nfraprado@collabora.com>
 <808f35bf-2800-c34b-cae9-4d8eaa11294d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KKCvmbbZzU+Uot0H"
Content-Disposition: inline
In-Reply-To: <808f35bf-2800-c34b-cae9-4d8eaa11294d@linuxfoundation.org>
X-Cookie: I disagree with unanimity.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--KKCvmbbZzU+Uot0H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2022 at 09:40:02AM -0700, Shuah Khan wrote:
> On 12/14/22 06:03, N=EDcolas F. R. A. Prado wrote:

> > The default timeout for kselftests is 45 seconds, but that isn't enough
> > time to run pcm-test when there are many PCMs on the device, nor for
> > mixer-test when slower control buses and fancier CODECs are present.
> >=20
> > As data points, running pcm-test on mt8192-asurada-spherion takes about
> > 1m15s, and mixer-test on rk3399-gru-kevin takes about 2m.
> >=20
> > Set the timeout to 4 minutes to allow both pcm-test and mixer-test to
> > run to completion with some slack.

> What I have in mind is that the default run can be limited scope.
> Run it on a few controllers and in the report mention that a full
> test can be run as needed.

> There are a couple of examples of default vs. full test runs - cpu
> and memory hot-lug tests.

For pcm-test it's probably more sensible to refactor things to run
multiple PCMs (or at least cards, though that's less relevant in an
embedded context) in parallel rather than cut down the test coverage,
it's already very limited coverage as things stand.  There is some risk
there could be false positives from cross talk between the PCMs but it's
probably worth it.

With mixer-test if it's actually taking a long time to run generally
this is just identifying that the driver could use some work,
implementing runtime power management and a register cache will probably
resolve most issues.

--KKCvmbbZzU+Uot0H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOaErkACgkQJNaLcl1U
h9A4ugf/bDhEAdw2PkfzmgWdKabB8/h5LgC72QYCUMIEDhyOOwxRebwjp3yZ7/pj
HIfOXnhTqwW63ulT3O7NwIwQq2lPyR90UZu0+y5Fc1dNLhwfgQMYicRbeyqlEh/O
0utC/oM6NX2zdC19uTvUzKPft3g19kfCh4ec2zgXQHW9FzdxT/El80TVmtvlniXH
J3C30SqJJj7GLOwteNK+p4ODpBTgtVJW/GZu05jWEc5sLw7g8empBSHkAdKmJP/M
6g+4sXeiNjgfWNMVcsjBfzhIpPV5bHpdPnH+lHmzF8yNwL3Od1kc2nC8V9rVohCE
/6JgaMqeTKNcN0H2NnsYEEAYBLa9SA==
=Z663
-----END PGP SIGNATURE-----

--KKCvmbbZzU+Uot0H--
