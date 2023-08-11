Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DEF779115
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 15:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjHKNzV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 09:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbjHKNzD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 09:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8A630C1;
        Fri, 11 Aug 2023 06:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C71DB67231;
        Fri, 11 Aug 2023 13:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DB1C433C7;
        Fri, 11 Aug 2023 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762101;
        bh=KhZcaIG5xy1vW5rnxc77mFzoV3j3AEu0bgxbc/xhT30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiCnX3S9fK2Rn1vjsJehHuXxMuqnHIv5KAQHSUy7/Lwqry+6O2MxAfEAFZhuP+T94
         mtzGWJz1ed/GuuDsPqVERfkdM+BnRmqhbX9z0gASEULfOIGAbYc827+Oyimw7XNunu
         MqP3Fkm3BWv4u/6eEmtgPAUP/Wj3pUnX+6UWhwW73N/NZDHs/h6V//hjVhGzqVLTJZ
         znM2XpHNZ/ZOMSq4dVY8VBKQ1Hx3mLf1hCJvP2GTzgTBrw4IXq4vnPqTuDbp24m3RE
         8zecKJYsy/KuV8W9N3qBrnI/SXpJm7RHy1Ql7/h3L1RRxKDAFFXkD56GV5BvV99qzX
         H1SqYRGy5aDgA==
Date:   Fri, 11 Aug 2023 14:54:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>, cocci@inria.fr,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernelci@lists.linux.dev, Julia Lawall <Julia.Lawall@inria.fr>,
        Bjorn Andersson <andersson@kernel.org>, kernel@collabora.com,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] kselftest: Add Devicetree unprobed devices test
Message-ID: <ZNY9sBgzrEQVVQT+@finisterre.sirena.org.uk>
References: <20230810202413.1780286-1-nfraprado@collabora.com>
 <20230810202413.1780286-3-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YBiry2C1ACyZhi5x"
Content-Disposition: inline
In-Reply-To: <20230810202413.1780286-3-nfraprado@collabora.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--YBiry2C1ACyZhi5x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 04:23:51PM -0400, N=EDcolas F. R. A. Prado wrote:
> Introduce a new kselftest to detect devices that were declared in the
> Devicetree, and are expected to be probed by a driver, but weren't.
>=20
> The test uses two lists: a list of compatibles that can match a
> Devicetree device to a driver, and a list of compatibles that should be
> ignored. The first is automatically generated from a script that parses
> the kernel source using Coccinelle, and will be run as part of building
> this test, therefore Coccinelle is a build-time dependency for this
> test. The list of compatibles to ignore is a hand-crafted list to
> capture the few exceptions of compatibles that are expected to match a
> driver but not be bound to it.

This doesn't appear to produce KTAP output which is going to make it
less useful for generic kselftest runners.

--YBiry2C1ACyZhi5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTWPawACgkQJNaLcl1U
h9BnHgf/cXFsgTdlRlxShMvzuWgYlkgOS1VSqUTQh8iNOqiDU3RAsnDLNA2YDMJM
x3hGTDn+EGy06P2hVjDrFOTpuQJ0zi2GtBoVhCRRR5k3keavSVmMe8d+YC6PPe6N
uMc1XEYnM3sqEV/+BIEZohMBi5NuvpRR1/p4QnEPiK/9PTFHLAzLLSwiu9xbrnE2
bM2yfcAaq7cdPsDlLBa90KZ4cS2bMwZBj/qDij7968mN5LbZy6qm5Tmjjx2bh4bm
PxK8FXkJYavfIEgL4CiC02mtOWgE47+RZt4LlLzMShl9kV+fGYJSFGaqktMmno/r
7EIlN4+OtUQ5XuQGxIpxuq9UWZ9Khg==
=J+CL
-----END PGP SIGNATURE-----

--YBiry2C1ACyZhi5x--
