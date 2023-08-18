Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631E1780C2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 14:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbjHRMys (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 08:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348924AbjHRMy3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 08:54:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF1230F6;
        Fri, 18 Aug 2023 05:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82A83633DB;
        Fri, 18 Aug 2023 12:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB92AC433C8;
        Fri, 18 Aug 2023 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692363266;
        bh=orKiM/AYBzvSh3wzYTayQ45OuPrlWY7ULQPgi6qbpLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JmlJJOM06l+xQoLCh+CVGObMiAfkKrRTsYKUxly0YIRPRvx5EnMz5m5o4FMqSWkvO
         EPEDRQYiixgn52l1vHxxJDtFJsp7jzmzq8TkZ0iTElk1IZpQmsDvNJljwkaEpab21S
         ZNoDJHWPA6T1C8GBJiPv3PdrRwW3CcrVQmtLLWXNlRwKfn7JeT+PIk04i/4a4mJMwV
         9OGcQQ0CpcQbjqM2jy7Bnd2e39Xf7/tPOBmxbKPX2rvoUSTk6ucX2IBxJKBS4NHP4D
         eA1MsCS8aH8oERuWf5yVzBBdGlFy9oJxlL4763wxqECHmRfiypGtBh5HrxBmpcbgy+
         HeEp2vN3T1KmA==
Date:   Fri, 18 Aug 2023 13:54:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>, kernelci@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/3] kselftest: Add new test for detecting unprobed
 Devicetree devices
Message-ID: <69848238-17d8-4b87-8bc1-474cae127410@sirena.org.uk>
References: <20230817233635.2306377-1-nfraprado@collabora.com>
 <20230817233635.2306377-4-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S4sLu4sSqqlfNLG9"
Content-Disposition: inline
In-Reply-To: <20230817233635.2306377-4-nfraprado@collabora.com>
X-Cookie: Your aim is high and to the right.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--S4sLu4sSqqlfNLG9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 07:35:27PM -0400, N=EDcolas F. R. A. Prado wrote:

> --- /dev/null
> +++ b/tools/testing/selftests/dt/ktap_helpers.sh
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2023 Collabora Ltd
> +#
> +# Helpers for outputting in KTAP format
> +#

These look generic so could be at the top level kselftest directory in
case any other tests want to use them?

The test itself looks good in so far as I can read shell.

--S4sLu4sSqqlfNLG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTfafwACgkQJNaLcl1U
h9D54wf5AdYx/ucoN/omjRE/OASexlSt6X45/Ke1OOogDr+mlhkQBJP3zbGFj697
EGbmQxxAk9J1A4wAWul2+r39m5ccV3AXmdL9EWkGLhX7BB9mFTctb+57vNlvjY7Y
NttfaUuzOj7MR2d7KhrVHhAv9bDEhdaA8d+kMk09qUv/IfbMeIaFqkAiT5wk8UCL
pZYWuzX6ZYRpkqPaCGc8XpOKcbOCPi46M+oKir75Cpz6UkSTCOnsTJaoLNanLoDw
MXlgFfMYT8/wd5BaYn6yD8fYQh8cjs2Er4ORC/YngdVAva31UK0cBG3EuwSrnEZp
VaB9uLK3zqNtlbJg6zHCXocxBUhR1w==
=n0TR
-----END PGP SIGNATURE-----

--S4sLu4sSqqlfNLG9--
