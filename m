Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4ED760D39
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjGYIiq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjGYIiY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CD51BD0;
        Tue, 25 Jul 2023 01:38:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 469856109A;
        Tue, 25 Jul 2023 08:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B321C433C9;
        Tue, 25 Jul 2023 08:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690274289;
        bh=75o10mSjqJBWCxjFsnKBmzyrlcMUSVpStl11WnkgBLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3cAEjTy98Q4JWsqMD6b+Y5ze6DRM/m8TiDOsUlpvN3vD2CZKKT6l3kecc8tFs4Qk
         vFg4eC36+R2CnB4jg1/ENZFw5eb4VmnkWsOLtXjUUOT8tNdIffQ1vw5nV9daqDt717
         NxMPqlj56b2iouzQUk8qbSRMYv8lsBW4baMc0j2xS3vRMq+Zd6rrAIM7rlNYRDO1Ma
         PXWzkYJxTlWNCy8DaMtlnlzByxS+AEbEk05fKzoRE1oYoO+tk1vZgIRqySq8y+3lXh
         fk0xiNwKu1ZYp+qcDYawox3CzZH2Ae5SZceTm5YLMF3hGJN26LUTJv7xkX6hxBzcqB
         HmZg2LbTT7yjw==
Date:   Tue, 25 Jul 2023 10:38:07 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arthur Grillo <arthur.grillo@usp.br>
Subject: Re: [PATCH v5 9/9] drm: selftest: convert drm_mm selftest to KUnit
Message-ID: <j4twjg4rd74qq6wjr7nrtrtkh6cdxehuw5lmeavu7z5q5lhtih@nofkcrdnwty7>
References: <20220708203052.236290-1-maira.canal@usp.br>
 <20220708203052.236290-10-maira.canal@usp.br>
 <7yc3fkagtlr4i7qnkulwvfzqjs7v64ddugcc3cxt6g5oawvqoa@ax67ukkrr7jt>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="owxyeq7tmkvx6yhm"
Content-Disposition: inline
In-Reply-To: <7yc3fkagtlr4i7qnkulwvfzqjs7v64ddugcc3cxt6g5oawvqoa@ax67ukkrr7jt>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--owxyeq7tmkvx6yhm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 27, 2023 at 03:14:39PM +0200, Maxime Ripard wrote:
> Hi,
>=20
> On Fri, Jul 08, 2022 at 05:30:52PM -0300, Ma=EDra Canal wrote:
> > From: Arthur Grillo <arthur.grillo@usp.br>
> >=20
> > Considering the current adoption of the KUnit framework, convert the
> > DRM mm selftest to the KUnit API.
> >=20
> > Signed-off-by: Arthur Grillo <arthur.grillo@usp.br>
> > Tested-by: David Gow <davidgow@google.com>
> > Acked-by: Daniel Latypov <dlatypov@google.com>
> > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > Signed-off-by: Ma=EDra Canal <maira.canal@usp.br>
>=20
> I'm very late to the party, but I'd like to discuss that patch some more.
>=20
> Two tests (drm_test_mm_reserve, drm_test_mm_insert) in it take a super
> long time to run (about 30s each on my machine).
>=20
> If we run all the DRM tests and VC4 tests, each of those two are longer
> to run than all the ~300 tests combined. About 100 times longer.
>=20
> I don't think that running for so long is reasonable, and for multiple
> reasons:
>=20
>   - While I don't know drm_mm well, it doesn't look like any of those
>     tests do something that really should take this long. I'm especially
>     skeptical about the fact that we test each operation 8192 times by
>     default.
>=20
>   - It makes using kunit more tedious than it should be. Like I said, on
>     a very capable machine, running the all the DRM and VC4 tests takes
>     about 50s with those two tests, ~0.4s without.
>=20
>   - The corollary is that it will get in the way of people that really
>     want to use kunit will just remove those tests before doing so,
>     defeating the original intent.
>=20
>=20
> I understand that it came from selftests initially, but I think we
> should rewrite the tests entirely to have smaller, faster tests. It's
> not clear to me why those tests are as complicated as they are though.
>=20
> Also, going forward we should probably put disencourage tests running
> that long. Could Kunit timeout/warn after a while if a test is taking
> more than X seconds to run?

I'd still like to address this. We spend ~90% of the DRM kunit tests
execution time executing those two tests, which doesn't seem like a
reasonable thing to do.

I'm fine with doing that work, but I'd still need to figure out what
those tests are doing exactly. Can someone help?

Maxime

--owxyeq7tmkvx6yhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZL+J7gAKCRDj7w1vZxhR
xerxAQDCxqP0JKHuCaV7AFlcqB1iP5OH6fCfYChHsrZijcuP9AD9EWis6v9nmqru
2GHER9aXP+pP4zewT4hOg20jZUMOvQ8=
=vRci
-----END PGP SIGNATURE-----

--owxyeq7tmkvx6yhm--
