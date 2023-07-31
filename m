Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E32F768C0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjGaGeJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGaGeI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:34:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25A41A5;
        Sun, 30 Jul 2023 23:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CAAF60EB2;
        Mon, 31 Jul 2023 06:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21148C433C8;
        Mon, 31 Jul 2023 06:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690785246;
        bh=bOGPqyAhP6NkQ9Nt5AzPo0hLJf3if97so02b3TdyVTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwqMXlBMFnV2uyI4w26lA04dvmEulzeOwfGlh763tWl1tsakYPqLQhJ63udXur5iJ
         giDd/sHg8e8g/EyHw57JMVEvnEzGow541PBIVJcYIZ+yX2UgOzDKxxkQqhph/1lWO5
         /7Tlnh2SP7FpQJtncl8460KnJ5umslNJzwuRTaNTsgRIbisUsSjmJV1RSwHj4njXY7
         WoKzQ4+ucdG3b97LBt7P6pofUT8U9wd6Y2Qs3ey5T+ix8sQq6soaEsk2c81MlhWtmJ
         9fUP2IDpAE38p1PeeDyqHlv+Vu2W9/56AFW/JMNjDFUGvGwsfuXUnI3ERvIuMEu6/0
         nghtpxALo886g==
Date:   Mon, 31 Jul 2023 08:34:03 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drivers: base: Add tests showing devm handling
 inconsistencies
Message-ID: <xlb7rwyg5j4hk6afqssxniprn72goxv4avjzjrs3oc3nvfhbsa@fn4amdp6dkx5>
References: <20230720-kunit-devm-inconsistencies-test-v3-0-6aa7e074f373@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ngko36la6fn5mvtn"
Content-Disposition: inline
In-Reply-To: <20230720-kunit-devm-inconsistencies-test-v3-0-6aa7e074f373@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ngko36la6fn5mvtn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 02:45:06PM +0200, Maxime Ripard wrote:
> Hi,
>=20
> This follows the discussion here:
> https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb@h=
ouat/
>=20
> This shows a couple of inconsistencies with regard to how device-managed
> resources are cleaned up. Basically, devm resources will only be cleaned =
up
> if the device is attached to a bus and bound to a driver. Failing any of
> these cases, a call to device_unregister will not end up in the devm
> resources being released.
>=20
> We had to work around it in DRM to provide helpers to create a device for
> kunit tests, but the current discussion around creating similar, generic,
> helpers for kunit resumed interest in fixing this.
>=20
> This can be tested using the command:
> ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/base/test/
>=20
> I added the fix David suggested back in that discussion which does fix
> the tests. The SoB is missing, since David didn't provide it back then.
>=20
> Let me know what you think,
> Maxime
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Ping?

Maxime

--ngko36la6fn5mvtn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMdV0gAKCRDj7w1vZxhR
xUvlAQCVUQFWLCCy/RsHWZl/04GmMfMzBDx0vIKKH43nS1KGCQD/STsk6BmpR0wj
vrWDYrM4BwzQMcR7NipDGlzMcWBlvwk=
=ELtm
-----END PGP SIGNATURE-----

--ngko36la6fn5mvtn--
