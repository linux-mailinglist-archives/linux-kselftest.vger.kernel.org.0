Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C37D504D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjJXMwC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 08:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjJXMwB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 08:52:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F21CDD;
        Tue, 24 Oct 2023 05:52:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74452C433C8;
        Tue, 24 Oct 2023 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698151919;
        bh=L2uwd4m19z0M1YbZ58t/ggXDa8mDy03V1QQ4dHrZh0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D60vIAXT+B0Xy36BsLzWu08JSceFbJx4UNskmDRmlb2QItWlkDm8EYFq5NYsJF0E2
         lU83l2v3t/rNcdn1G9+xr6WUQjKtIrihHX2l9Vgth2QO/1OoUse+QaluSElh9Gfsye
         Mu1+6CKzPpXohV2wnezwcKFU51NXzUVjIJviqY/DG0XR1axjWRuuyElcpwUXDslk9G
         kqaaT0EySjGmQGzN/e5YKik21qWiK2p+YoCtt1430pUEUIFesd6FmE172pIr+syoOv
         QqUDvhg9tQW3YV31uSYyLQ6pgD2Hb8VLxN9dv5aa1TZwrlJR4wr2tSYyQeuO+MCPUE
         i4x8OvKjBf/sQ==
Date:   Tue, 24 Oct 2023 14:51:57 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kunit: Warn if tests are slow
Message-ID: <svoucztzwyejdmifvmshs3vbavixs3a6jic3aszukw7zycwelp@kwpshm57d3jj>
References: <20230920084903.1522728-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="46ikj6leewj4oajx"
Content-Disposition: inline
In-Reply-To: <20230920084903.1522728-1-mripard@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--46ikj6leewj4oajx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 10:49:03AM +0200, Maxime Ripard wrote:
> Kunit recently gained support to setup attributes, the first one being
> the speed of a given test, then allowing to filter out slow tests.
>=20
> A slow test is defined in the documentation as taking more than one
> second. There's an another speed attribute called "super slow" but whose
> definition is less clear.
>=20
> Add support to the test runner to check the test execution time, and
> report tests that should be marked as slow but aren't.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Ping?

Thanks!
Maxime

--46ikj6leewj4oajx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZTe97QAKCRDj7w1vZxhR
xSfPAP0WUM98GRrmKhVdaqjj7vA28IpispbnR5G8BgPwnF/H3wD9GmsrQPGVE4Kv
b1i/ofaQYe8q11X9M4Td1zlHbgVPJgA=
=hmst
-----END PGP SIGNATURE-----

--46ikj6leewj4oajx--
