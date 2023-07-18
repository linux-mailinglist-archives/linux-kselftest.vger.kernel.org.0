Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED26757FB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjGROfs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGROfs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 10:35:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D74910E4;
        Tue, 18 Jul 2023 07:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8C03615F6;
        Tue, 18 Jul 2023 14:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54F5C433C8;
        Tue, 18 Jul 2023 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689690946;
        bh=J5DXyIj4vfe8bT4WtYNV1ZbYydMLcVz9l6iR9wFLLqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPGqsbgxqztB5ogffQPfbSnRgCoDuVw2oXXMW4t+Uu/M9AwDJSQUvCT2ZX7BmiXKe
         N3MGMwnhlkA+wga/CxDm3GaZjjJzysiBuWU0O/izoDLstwQoLIlzhsVilH+dO54y7o
         J/GTw1aLKinQnEqlQrbUzMqOaa3MUuoCgLvN43P4BnX8YGBQknsWL9PonY+3vgwfRI
         eejCp1QQC5ou+kFysY5RqfudxbcRAXPSdpfknYwaSqd6F9OLfOYdRAp7QZfsXTS0gK
         0H6nhsM40D825Zm4gmzxCD7mKEGhj7ruhHfsjGZljh96BFxCvAcLgcBjOdgMVywbuO
         TEx3Ir/qMyfXQ==
Date:   Tue, 18 Jul 2023 16:35:43 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drivers: base: Add tests showing devm handling
 inconsistencies
Message-ID: <vwku5mxdcbiqc72btevqcd5t533re6mlhhw4dywuajnoboyuuf@d4qi3thi55u7>
References: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7iwmlem2ihjy32zz"
Content-Disposition: inline
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--7iwmlem2ihjy32zz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 11:49:20AM +0200, Maxime Ripard wrote:
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

Ping?

Maxime

--7iwmlem2ihjy32zz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLajPwAKCRDj7w1vZxhR
xW+rAQDl8tNxMfnF8Ry3vXQfmjSC3kXHfvECJYykpBxExUwyrgD/TdezeNO0xqSl
PZlGDMlG1c6iTkLOe3F3BgKgfYNIcQA=
=PXMz
-----END PGP SIGNATURE-----

--7iwmlem2ihjy32zz--
