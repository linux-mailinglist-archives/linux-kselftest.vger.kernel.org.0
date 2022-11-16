Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF7F62BF6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 14:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiKPN2f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 08:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbiKPN1y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 08:27:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D24386B;
        Wed, 16 Nov 2022 05:27:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D56761DC9;
        Wed, 16 Nov 2022 13:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA56DC433C1;
        Wed, 16 Nov 2022 13:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668605272;
        bh=QJy5u2FbeCfYN6AAm7f1rdFfUCG0pza6VuIYZAWdyp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h+9JCXrBM6FkDFPX/5AQ0lPslzNGSaNcjKPAFMw3kW5vVUpipdNjxHwBbC25o52G9
         fUCETOXwb5jjfKshceHXW2HuG5Wb2QcSKe5Vl+Rc/XmNCczsYNymJ0ApdOgaQWw50J
         lmymadS1gx1FSuwiVRToUxDMjrz0sIj7tXNjRd2+RLSIWviRcWS0fN4ab1FbQRFczU
         YoiSV6ttcKFe15/WWxibaAWpxYXYiIxBhmjTkTq3hAZXYGwHSNHqk08pZvU6r13UVD
         4rcYxCi9SYKPKgXUph1JwNf90XHcrPtU5ntLdYCjzB3X3tjqdspX45a/gGOF3s+4gU
         doiAnltgs7CiQ==
Date:   Wed, 16 Nov 2022 13:27:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Remi Duraffort <remi.duraffort@linaro.org>
Subject: Re: kselftest: Bad test result: from results parsing in LAVA
Message-ID: <Y3TlVAgo9XSWKm1h@sirena.org.uk>
References: <CA+G9fYu0p4cFdkrkQyV4OC-iPpY18asV0VTP=O_sysLNaJJAQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t70fyBxLl90YCW5N"
Content-Disposition: inline
In-Reply-To: <CA+G9fYu0p4cFdkrkQyV4OC-iPpY18asV0VTP=O_sysLNaJJAQw@mail.gmail.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--t70fyBxLl90YCW5N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2022 at 05:46:33PM +0530, Naresh Kamboju wrote:
> kselftest running on LAVA infrastures provides test results parser
> from test-definitions repository.
> which is getting  "Bad test result:".
>=20
> I have noticed this on kernelci [1] and LKFT LAVA instances [2].
> We need to investigate and change parse_output [3] inside test-definition=
s.
>=20
> Report-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> Test results parser showing =E2=80=9CBad test results: =E2=80=9C,

When reporting an issue can you please try to provide some
analysis which goes beyond the level of "I saw an error message"
- for example here it's hard to tell if you think you're seeing
an issue somewhere in your test automation system or if you're
trying to report something in the tests.

--t70fyBxLl90YCW5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN05VMACgkQJNaLcl1U
h9Audgf/SBya/IJ1cRvhV5ZE/fj5Mr69G0ZC/uAdc5cK4GeThN6czSdLou40fdwr
T/jPLlo3693/Oz/UkKnlXuQNc/uIgzeerpXA2voVbdfOZV2G+mWVVgO0x1LSa7TK
1xwL6wQV7Oo08/D7O2Sm8e3A+8Aplp2TJn9BXHawJJmBPqQ+xasAnVNK2q/Rltwr
fS9BP+mE5LShnF0odjNO1dlRlmqElQ/Usdala9Ov4qyA/pxl7FR+ykmmlbCCUYT8
zywvwh1ahUV4gC9rpkaES6jYvJqowG7EirmocjavtDtdkN064Ci8VYqhh+nnkHEE
xND7yv/yt6Kl+oPlPASede0z7lftnw==
=aFhh
-----END PGP SIGNATURE-----

--t70fyBxLl90YCW5N--
