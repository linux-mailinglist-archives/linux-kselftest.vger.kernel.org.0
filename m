Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264A079BDA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345445AbjIKVUe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbjIKO3J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 10:29:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC09F0;
        Mon, 11 Sep 2023 07:29:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4D1C433CB;
        Mon, 11 Sep 2023 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694442544;
        bh=AigyTmddvwvr5mfoNvzt6guQgCiVr/QlkeCPzes3DpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLI6T+Pp+fXc6eZt4Rlqy8LMVXTEOollEM8Ic8DUPtv5m5HijnH7t2DTBjAO32w6q
         VVhhOd05/0L6qET6YIoB+rzt/mnqUZF6H6yQ2ylqmKbtvSUTcyKuvRh3R3BesS9qEr
         Cgn+8FFSCeMyQfj3qnRcURWBTYSbRABZ4AKHqWKGSaRZoMDO8zne5qTHKG2aidDeBF
         q6bH3iA798CQr4f6nTMh1SFXk+Zi0qIcviqrpkLkiBHoHEOSjN9ieLLifj3Xy/PSA2
         bCq1o4NOgH31hEaVOnUflk77kd0PkpKdjNuFcGsnV0jm5j7axwkUn2A26u4aXea4SZ
         McvPpsjB4m1vQ==
Date:   Mon, 11 Sep 2023 15:29:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Takashi Iwai <tiwai@suse.com>, kernel@collabora.com,
        Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Mark test plan as skipped when no cards
 are available
Message-ID: <ZP8kLM5ln2YBCHap@finisterre.sirena.org.uk>
References: <20230908181242.95714-1-nfraprado@collabora.com>
 <0fa0901e-d271-438d-bc2b-11399ad3b07c@sirena.org.uk>
 <868a8f08-ba39-4550-8e7b-0572ea03c4e7@notapiano>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="upLhFwPGUAS0CWZq"
Content-Disposition: inline
In-Reply-To: <868a8f08-ba39-4550-8e7b-0572ea03c4e7@notapiano>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--upLhFwPGUAS0CWZq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 08:35:37AM -0400, N=EDcolas F. R. A. Prado wrote:
> On Sat, Sep 09, 2023 at 12:08:22AM +0100, Mark Brown wrote:

> > Why?

> To better reflect the actual test plan status. If 0 tests were run, it do=
esn't
> really make sense to say that the test plan passed, rather it was skipped=
 since
> nothing was run. So with this change, if there's a regression that preven=
ts the
> soundcard driver from even probing, the result won't be "pass", but "skip=
", and
> the reason 'No soundcard available' will be in the logs.

So, I would interpret the overall result for the suite as being "No
errors were found in any of the cards discovered" if there is no
configuration file specified which enumerates the set of cards that are
expected (if there is a config file that's a different matter, we know
what we're expecting).  I'm not sure that the different behaviour for 0
cards is super useful.

--upLhFwPGUAS0CWZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT/JCsACgkQJNaLcl1U
h9BPVAf/RSFHSOlUvU0zkBcxBW+G0eqxamHxmKQmBzKhecWQfBvToFYzyPMTI8hj
1nkjmK70vMjHhjLZZri+srrnWwBLzVknDtJbaMFXkzFQibRN3P/60ChXGtg9WC1X
5YzCyo+Na071zvmceag5yoyC55RoWZiMknKj89Y4DjL6cnExT7MEHuBGlwioUjjP
1NApQduQGNWL8TNDcUkbDRa+ZPAkB6LspNVY4J7+S+R8jCqIINtX/YlKK+1oz60a
50FFhWVNgjGigFqy/yGMaAocWDhSkTrf5xqHb5CjlaleQlhSW1Lh/TVaClZNPI9E
0F0Aj163sUBtchAoz9QUWSmzw0qWDg==
=bHB7
-----END PGP SIGNATURE-----

--upLhFwPGUAS0CWZq--
