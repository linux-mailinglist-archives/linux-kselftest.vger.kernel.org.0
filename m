Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A762F77BE43
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 18:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjHNQle (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjHNQlZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 12:41:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775BF113
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 09:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BBAF63188
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 16:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE30C433C8;
        Mon, 14 Aug 2023 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692031283;
        bh=lUVpAtCzwI1B5yhbYO4zqCEYMAUdWJXeclifsmMFpXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaGCTbcQoEoFa4rCd0LYSzN5r4doc8yUww+4DViwD5tFHwQZtADQB7o3qXsZtd07b
         SquGs9gvTL6LETMnxINMZWWK8QXmuJKcjNbLZdCTYDcaSzBqls+xtx7t6ERBaiDEy2
         idgs70qTf/BKiV0Em45716eSHDV7S1+xtOdr1WrMp72LWnb+Y/YkTaNoCRT5AQN351
         S6aHBzDqQwoOBc4pgVWUI2ZAZ1YWrTiyuQ1vGR4c8yjyMLsDCYYDUkSF/ofHtgiVCg
         szoHuiXyys/N01pRbN43T7D09ZhqNTK82dNzs7axet/1Wl3GEVl/cZBWZUA/3jvhET
         gS2pHgBc7QcHQ==
Date:   Mon, 14 Aug 2023 17:41:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     shuah@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, xiexiuqi@huawei.com
Subject: Re: [PATCH -next 0/4] kselftest/arm64: Add crypto-related feature
 checks to hwcap test
Message-ID: <95e69b70-bcc4-4ec7-ba81-aea2122e15ea@sirena.org.uk>
References: <20230814021747.1784812-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L5O7AMtbkTX7GE40"
Content-Disposition: inline
In-Reply-To: <20230814021747.1784812-1-zengheng4@huawei.com>
X-Cookie: FACILITY REJECTED 100044200000
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--L5O7AMtbkTX7GE40
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 10:17:43AM +0800, Zeng Heng wrote:
> Add new feature checks related to crypto to the hwcap test.
>=20
> The following is a log snippet from my local testing environment
> based on for-next/selftests:

Other than the minor issue with the sorting this all looks good and the
encodings all check out so with that one issue fixed:

Reviewed-by: Mark Brown <broonie@kernel.org>

(the other patches are already fine)

--L5O7AMtbkTX7GE40
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTaWS4ACgkQJNaLcl1U
h9CK+Qf8Cfa74JTimWiRWQrbQ9ONlHKGjx87lw6cAmhmLZQ1iJUBBCtRYUg/awAG
M7s75BK5HZx6nIivjRSoAZmqBREQwTt9UquacGQTKRt4swM5iis6Sc+14e+0oixd
JfYPGo3X2kDr5Sq/GeIur2JLA3r482CZSASW/A9ZuMTIYdjxGLg+zW6nezLW0gsQ
llpYarh7CKs/PyGJJan2n5yVSoABD4WU1qHqWCcHAggfYIs/DMN9HbzlwJespgrP
bJZzPpM5X2oMGFBqJX6qoA+0h5ZHJaoK6+6jEhCbr+uPmp9qj+OFSn8+M1XVq2oJ
KJUtaBhIhgJJh6lcS9uqCAYyFM1TZg==
=vcEG
-----END PGP SIGNATURE-----

--L5O7AMtbkTX7GE40--
