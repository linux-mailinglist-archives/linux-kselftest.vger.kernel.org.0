Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BCB771AD1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 08:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjHGGyZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 02:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjHGGyP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 02:54:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DB2198B;
        Sun,  6 Aug 2023 23:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 924566129B;
        Mon,  7 Aug 2023 06:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F55DC433C8;
        Mon,  7 Aug 2023 06:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691391252;
        bh=Z+bbSWp+iTKuc6nMMWDMyK5HRW0hCgjlS5Ejp1gNsto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d07X106Qf6huErjWltXmTvMlXxPFR+LQm8kpi2gkEuvn1sKE0MacU5bWIfUTlK3Yg
         u4uPboOGs2R8k5jjCVYwPmRqxckOntHm7/IQhQ/itnG0Ccc5lhUWVlyPKSTeiLauh4
         miDqSpq5Rq6tfDZ81gb+GtjsCraXX3pLDEInutbBHmiXyMwQyRFtYE/VuDoGTW7iru
         PXbKB+nFvaGqDRRggDFX68ti9/SGMMGDceTXyDkIgi0T13k3BIXA4N4+5I6XFJtmSJ
         6YILQmP4fKPnyFui+a//RMJ+G+waxzSz/JadXANqBUdOFIbY+IakJCfY1GaO4lC115
         dRq6V9p2x/ltQ==
Date:   Mon, 7 Aug 2023 08:54:08 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drivers: base: Add tests showing devm handling
 inconsistencies
Message-ID: <ckldghyavb6fj2mxfcw5spsr3v2rlyj2br64tnvwl5waz3i6id@zbxu7ipjtlwd>
References: <20230720-kunit-devm-inconsistencies-test-v3-0-6aa7e074f373@kernel.org>
 <xlb7rwyg5j4hk6afqssxniprn72goxv4avjzjrs3oc3nvfhbsa@fn4amdp6dkx5>
 <2023073131-glimmer-both-05b6@gregkh>
 <2023080416-suspend-cattail-f048@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ksi2ulj7htpymjyy"
Content-Disposition: inline
In-Reply-To: <2023080416-suspend-cattail-f048@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ksi2ulj7htpymjyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 04, 2023 at 05:01:50PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 31, 2023 at 09:28:47AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jul 31, 2023 at 08:34:03AM +0200, Maxime Ripard wrote:
> > > On Thu, Jul 20, 2023 at 02:45:06PM +0200, Maxime Ripard wrote:
> > > > Hi,
> > > >=20
> > > > This follows the discussion here:
> > > > https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnl=
nfwb@houat/
> > > >=20
> > > > This shows a couple of inconsistencies with regard to how device-ma=
naged
> > > > resources are cleaned up. Basically, devm resources will only be cl=
eaned up
> > > > if the device is attached to a bus and bound to a driver. Failing a=
ny of
> > > > these cases, a call to device_unregister will not end up in the devm
> > > > resources being released.
> > > >=20
> > > > We had to work around it in DRM to provide helpers to create a devi=
ce for
> > > > kunit tests, but the current discussion around creating similar, ge=
neric,
> > > > helpers for kunit resumed interest in fixing this.
> > > >=20
> > > > This can be tested using the command:
> > > > ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/base/tes=
t/
> > > >=20
> > > > I added the fix David suggested back in that discussion which does =
fix
> > > > the tests. The SoB is missing, since David didn't provide it back t=
hen.
> > > >=20
> > > > Let me know what you think,
> > > > Maxime
> > > >=20
> > > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > >=20
> > > Ping?
> >=20
> > It's in my review queue, still trying to catch up...
>=20
> I didn't make it here this week, sorry.

np, I just don't want that patch to disappear into the ether :)

> I kind of worry about encoding the current "odd" functionality in a
> test as being the correct thing, but will look at it closer next week.

I don't think I'm doing that? The tests we've added are all how we think
it should behave, the broken ones being skipped to avoid any failures.

The last patch drops the kunit_skip() to make sure that it's tested
going forward.

So we shouldn't encode the odd behaviour anywhere in this series, unless
I got you wrong?

Maxime

--ksi2ulj7htpymjyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZNCVEAAKCRDj7w1vZxhR
xTyzAQDxd6KiKHz8VbSLz7KZ0iaMt833B9AVaGNrpuJ6crXX2AEA2T6G1PnmKTtC
58kw4RHBcoJUjUze7V9SMywGhnJVtwA=
=1eb3
-----END PGP SIGNATURE-----

--ksi2ulj7htpymjyy--
