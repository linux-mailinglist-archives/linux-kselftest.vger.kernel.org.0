Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF260760127
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 23:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjGXVXs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjGXVXq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 17:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AD710D8;
        Mon, 24 Jul 2023 14:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60EC76140C;
        Mon, 24 Jul 2023 21:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304F1C433C8;
        Mon, 24 Jul 2023 21:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690233824;
        bh=277o7f0Eb5yT07JMUAo4G4auNkjWPRK6+486ZkvEfT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g12HtrGDHpNU+dZZ7V4D4w2CoiKZK/lwm4GJyEKn2LC+Fa9PcvHO04XZGwlL5M9pT
         hk4W6t73YseH0qfHDFXwbFlAAfwLQe05U7CDMZPC/L/0S9gX3LBssBuCe7Gm9XfF/Q
         iBdw0FjWVGYTLOxzNWUsJKSpvJ5TQhpTBd0ipkAHcmIgK65giX9jkA9cZKiAcWzjte
         4pHKq+VdEKlLitptfVsjWw4GuvjIXp2p9sff5lLUUjz9y4Urh6jL64udUMOelMs6RO
         8xHgOZE+enRHAxueb4EBMXnK1GJhMJEEs1RHPingnldAt0/aXrsTF8YIJf5zQZ6fRG
         18oU0sDvFDoFg==
Date:   Mon, 24 Jul 2023 22:23:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/8] selftests/mm fixes for arm64
Message-ID: <8da61bee-41c1-4718-aef1-71790a48e3e6@sirena.org.uk>
References: <20230724082522.1202616-1-ryan.roberts@arm.com>
 <20230724093804.bbe8bc2a83d4575f17778eb0@linux-foundation.org>
 <ef907f64-f7aa-3759-1adc-3fb7e3f3487b@arm.com>
 <20230724120145.b0d985e6f926db587a7debd1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wudCvQllCxaWY7aH"
Content-Disposition: inline
In-Reply-To: <20230724120145.b0d985e6f926db587a7debd1@linux-foundation.org>
X-Cookie: Please go away.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--wudCvQllCxaWY7aH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 12:01:45PM -0700, Andrew Morton wrote:
> On Mon, 24 Jul 2023 19:49:13 +0100 Ryan Roberts <ryan.roberts@arm.com> wr=
ote:
> > On 24/07/2023 17:38, Andrew Morton wrote:
> > > On Mon, 24 Jul 2023 09:25:14 +0100 Ryan Roberts <ryan.roberts@arm.com=
> wrote:

> > >> This is v3 of my series to clean up mm selftests so that they run co=
rrectly on
> > >> arm64. See [1] for full explanation.

> > > Please don't do that.  Please maintain the [0/n] description alongsid=
e the
> > > patchset and resend it each time you resend the series.

> > I previously thought that the cover letter was primarily for the email
> > recipients and the description on each patch was the part that went int=
o git?
> > Clearly I'm wrong, but can't see anything in submitting-patches.rst so =
guess the
> > mm process is a bit different?

> I expect all subsystem maintainers would like the [0/N] intro to be
> maintained and resent as the patchset evolves.

Speaking for myself having everything directly in the e-mail makes the=20
whole process easier, it means that everything that's needed is there
immediately without having to go locate some external information or
dredge things up from memory.  This is especially useful when whoever's
reading the series has poor connectivity for whatever reason (eg, I
often go through my patch backlog while on trains).

Cover letters that I get do also tend up to find their way into git in
some form, generally edited a bit, due to the way I CI incoming changes:

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit=
/?h=3Dfor-6.6&id=3D85d12eda2382cd5b93eed720b5a08f39d42cfef4

though most people don't do anything like that.

--wudCvQllCxaWY7aH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS+69gACgkQJNaLcl1U
h9AGGQf/QSTLsJMpPjesovUVDXEZCC+Tv8JaESt/Wi8b5hp15Opt0MJK1Gh+D3CQ
ko2TyNyYoYZ8LnOr15LXo0rL2D7e3YSXL4BHGyr3N5SxoZeJhrF2LL8kt4OasJHi
sw38DE05VhUpgfyZjioPnKpFcx4GL4mV6eXsd+QhHGWV3suh2M1UBka/m00wjV/s
K4HGpoBkUVytKDyW7wKJJmB4INhSP3HsLKFLiVA1U7EkhQQtHN3mctWyJ+rTcPbw
4ANNAOu3fej8SsVf5j4fLzDRsLZwy1jIbTp5qTaLlrQaq6bU4zWsuekntfeWNN+T
1lm/OCfhfWte719dYnvBoboyeop+uQ==
=URhA
-----END PGP SIGNATURE-----

--wudCvQllCxaWY7aH--
