Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0997108C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjEYJX1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 05:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240169AbjEYJXF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 05:23:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E79191;
        Thu, 25 May 2023 02:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D929E61382;
        Thu, 25 May 2023 09:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59219C433EF;
        Thu, 25 May 2023 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685006583;
        bh=/NFO1nzbu3SNTgkSzAFr5hPEGsvfGTNtf1SWZjkiFNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/z9LgWQDq6pHK1YyLCavOzIvJ3erBo2Pckqc3o7ftYAmydrF5DaFS/Cv8xCWngAz
         w3egT172PLv5GiE37go437Mjs5ZhNj1WEe0LH53JJ3+uAqKbVkafmotbF10ikUGQdr
         V7OC2+FcnbwZ2dBA49wSmRFwp/TTgr9Se+90Rxm7khx3DRk0ghZWfRBYQEjBxKIRxx
         8GOfu3z72/QFojcfpLqoHDBowaEXJZdhk2jExh6uUvKHyVEFxdDd3k+9WE1trUJ+hO
         uAX+RG8wP/Vgm3mMr5rpLOZMVNdcyZbwz6xaCEV9ljwFj0i94CKon4CYGfxT1NbuFj
         60Xd8I8zwOJBA==
Date:   Thu, 25 May 2023 10:22:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 1/1] selftests: alsa: pcm-test: Fix compiler warnings
 about the format
Message-ID: <9c82296b-4682-49e7-8302-bd678135f1b4@sirena.org.uk>
References: <20230524191528.13203-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ui8yeKsWQYJ4DzVb"
Content-Disposition: inline
In-Reply-To: <20230524191528.13203-1-mirsad.todorovac@alu.unizg.hr>
X-Cookie: I demand IMPUNITY!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--Ui8yeKsWQYJ4DzVb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 24, 2023 at 09:15:29PM +0200, Mirsad Goran Todorovac wrote:
> GCC 11.3.0 issues warnings in this module about wrong sizes of format
> specifiers:

Reviewed-by: Mark Brown <broonie@kernel.org>

--Ui8yeKsWQYJ4DzVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRvKPEACgkQJNaLcl1U
h9DsxAf+Nht9caEzRJNBmPMBSHUYB3tNjAWSzlQm0eXriYDJ26MGz9KgBYgKXZnM
jJJI4vp6G5IVlSaE8SKIv2S6ZKuYDjQIgKTNN0XOHI8L6l+oMbZXdt098xpyIzon
zhJ+P+PcKjbdqX5FwKOLeiUlDdSFtGCS1kev31HNO7tXB2WGdznZTW50c/SpwAi0
kBtU29b86ZhsIQJoNg9tD2k7QucisVaC0xwR36i9zkRUXh6hugjF92hmZ8RHGCHp
O4b3hkFPjGVmZRarof8uMtOGfEZS6GWa/9nPUfNCiOvHJFyukMVsCT44duyRqQP/
fAuTolWbJR0SIEFluP9lNdoZI5QIkA==
=UrY0
-----END PGP SIGNATURE-----

--Ui8yeKsWQYJ4DzVb--
