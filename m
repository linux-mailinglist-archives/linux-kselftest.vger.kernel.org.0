Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4147E41EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 15:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjKGOgI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 09:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKGOgH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 09:36:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769C9101;
        Tue,  7 Nov 2023 06:36:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E2EC433C7;
        Tue,  7 Nov 2023 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699367765;
        bh=Wo+OkR2SJcTjqFCSIGnmQqSy64cw3QrZuHtNre/B8bI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tscldE+NLcdAAiT/hy775GjoAKr9qz5Bu31hJqKNOw0pBBJGCTEAU4ZKRpFSh5/Fa
         WfdtPQE4Ghpt9hguNoCBCtTgizgLOeg5e8u9TpSDxrXGiCTX/lXzhzBBvScOt+FwJ+
         S73pX/e/42xjy3fAm6tBy7AYbreeF4SPI/H+EFxuw0ZfJ75kxFs/li8S8pNw7MVIzX
         fgg5EbE6QWg/SlFTKOqMm8CUDokKrArJSDLKoO3o3xiHVbc7Pbx9JOQ+ekqWAqdccp
         pQFWBrl1ZrIZ5CTOLggpLWvgnvKZcptbbUHV2enzuQ1hDz+1N14bsAE0C3UcLTdXZd
         1TgCxjCH7IaAA==
Date:   Tue, 7 Nov 2023 14:36:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Aishwarya TCV <aishwarya.tcv@arm.com>,
        kernelci@lists.linux.dev, kernel@collabora.com,
        Guenter Roeck <groeck@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3 3/3] kselftest: Add new test for detecting unprobed
 Devicetree devices
Message-ID: <ZUpLUd+Q0MyYC6io@finisterre.sirena.org.uk>
References: <20230828211424.2964562-1-nfraprado@collabora.com>
 <20230828211424.2964562-4-nfraprado@collabora.com>
 <e90cb52f-d55b-d3ba-3933-6cc7b43fcfbc@arm.com>
 <CA+G9fYsbq28w7m-sf6LhMscXHdPs0cGXU7kK6YzjKdUFKuQ+6A@mail.gmail.com>
 <e72e144a-c617-4a9e-adfb-e25ddabeb4c7@sirena.org.uk>
 <CAL_JsqL-3O6omPf4HcPFctgid+br04QW5p81qDx0CPMqh_eXTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FfS63bym1dSwnNAk"
Content-Disposition: inline
In-Reply-To: <CAL_JsqL-3O6omPf4HcPFctgid+br04QW5p81qDx0CPMqh_eXTg@mail.gmail.com>
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


--FfS63bym1dSwnNAk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 06, 2023 at 11:09:44AM -0600, Rob Herring wrote:

> A simple solution would be instead of passing the source tree root to
> dt-extract-compatibles, pass 'arch', 'drivers', and 'sound' instead.
> There shouldn't be compatibles anywhere else.

This does seem like a reasonable quick fix that avoids the issue for
now - nothing would stop someone implementing a more complete solution
later.

--FfS63bym1dSwnNAk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVKS1EACgkQJNaLcl1U
h9D+Bgf9HspkikyOl/hR8HPz+Oo8/wKTHACheiwhnT4RkfFcAbXX+kDJBjHC3b8R
F/dsfrL9G/LEvf1MoPIqr7LxmrGDUeVz/oirAlIsoJoRYJPPTwKE6zwH9S2AVU9x
1GFd84WdvTRSHRvPvxFe/EnyxfbL4InoEiG0c3qiI2pXze3EkdW5X/JSZ1hhvUsX
kqMN/TltmRFQAbDrIklsnkpU17Fae9Mi6tNe1xtcOlRfGlJicuOwReFSkanW50nH
ki2kXTbaLboOHmHXi3lSmMj4tMpHCtgfi3pVNsgwhOR9k2yW4/MrEGtQ9dSnKcUP
V5hhqjVNMF3TOOPlbEuEbTTjZMpULw==
=ALf9
-----END PGP SIGNATURE-----

--FfS63bym1dSwnNAk--
