Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2074E022
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 23:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGJVUT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 17:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGJVUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 17:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF26C0;
        Mon, 10 Jul 2023 14:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F162611DB;
        Mon, 10 Jul 2023 21:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCB7C433C8;
        Mon, 10 Jul 2023 21:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689024016;
        bh=PwMqdQLmowiwTUlzoglqeOirbMbgHoU/ygQI6Oo7x0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4TzT2zaVoZbdB9kmewigfEk1Uv41v67ivz0bXKa18LkBLHeTPJV/REphFT/55dzO
         V0x4qUCoWHuNmrEBaiwOMyKCAbxMw+tLYGwa6XlsRX3u89O727pursepaI2iu2SD3y
         N6cgRQQUdxFwd97djcag2JS9mJIbBiJdLfHE0asDNf3NtZ1p4ffCVy6X7EKG+seGpd
         uAmODaBNWWcriLMSposT0poI2ITa9DGxfB/tYs9VrxexAPg41oIk4nBEWu3FyK/y0Y
         Ren7I19CdqAkugUyPxMExm/v6n46jY5CRU4ghp+/hB0/6ze77+YhnCZOq0tRXX6esN
         Eppbx5+yYsYdg==
Date:   Mon, 10 Jul 2023 22:20:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Message-ID: <ZKx17G7ULaQox7Xo@finisterre.sirena.org.uk>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <04a35122-5020-5ad9-7bdc-c17f9a27bf50@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dgnTDEaQyMt2CY6r"
Content-Disposition: inline
In-Reply-To: <04a35122-5020-5ad9-7bdc-c17f9a27bf50@nvidia.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--dgnTDEaQyMt2CY6r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 01:22:41PM -0700, John Hubbard wrote:

> There are 30 or 50 other pre-existing arm64 selftest build failures which were
> quite misleading at first, until I got into the "right" selftests mindset of,
> "massive swaths of selftests are broken, deal with it". :)

There are no such thing as far as I am aware - the arm64 selftests are
*very* actively used by a range of people and CI systems, I certainly
build them pretty consistently and am aware of no build failures with
either GCC or clang.  You do need to install the headers to get the
current APIs but until your commit everything was building cleanly.

If you are seeing any problems please report them.

--dgnTDEaQyMt2CY6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsdgwACgkQJNaLcl1U
h9DxnQf/UQdQ8w5Isi5d5a7ZXBJMvft/d1PTtPc1MVAUBfuZZTu4fF/1XkjG6seo
kgXT0azHBPV1GZZWYG2ow+yzQzI6qgsRfeMNulz0KbJXIIKGO3o5D5D3zGOvQbav
Fc0nY6hFWD+AU24fsWpMVxdRNbc5eSboOCHn1AippSTDJjPGUjLY5h6g97D1vgAt
knra3h4vLewDe6encM+5WvytdQlPcdaJj+m8jnnMg9TIqYMuybR2ANxhGJeDb5la
ILM8zxte8jyHjwpomNzUY43EtoNtGhb8f+H1UVtxy3ZH35I3BKJJTr0QejYbUi2m
4KMW4Jw44YgWUasuFmaUe1QCisAYnw==
=1yw0
-----END PGP SIGNATURE-----

--dgnTDEaQyMt2CY6r--
