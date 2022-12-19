Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B68C650AF0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 12:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiLSLuW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 06:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiLSLuW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 06:50:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E92310D9;
        Mon, 19 Dec 2022 03:50:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF55760F0F;
        Mon, 19 Dec 2022 11:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D76FC433D2;
        Mon, 19 Dec 2022 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671450620;
        bh=TlJTHZdonBkhWOExVDUlCA2kkkEcYWS4MCZrzh4K0BM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvQpKMSscSr/1DDPf+ZT6Y3IF0Mo+ZPxRIilg/Acapm1v4VhCH0/XlyLqLh3u8ef/
         VHemVUlveHLu0sK+IW3Z4mwteRYF7X0SD5uJcGvWTwxx9ugxgNOgjCIEWD8DHTYtTh
         ALAkV0rhEDLbmGcHS7BzEgR/C0ziQNVeReXAEPZVQ/usrtsN43no+MZTZdYfb4ZEVX
         LLYiBQ9EfKzAEtrNlpDZc1P3g1DvxIVFQpX0p3TUeVnyYE/vX67Bs/dozB1uDUevmA
         u+/xmy1KWP4bpEkRPVKztsppVFPaqhMqlWcyMWHFKKdwT1OYKYZXAFP0wR89IeYKXn
         nGrinC+2GKDSg==
Date:   Mon, 19 Dec 2022 11:50:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH 1/2] kselftest/arm64: Remove the local NUM_VL definition
Message-ID: <Y6BP90rJpZzYcyD5@sirena.org.uk>
References: <20221218092942.1940-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QnlaCkif2cEFA4WL"
Content-Disposition: inline
In-Reply-To: <20221218092942.1940-1-yuzenghui@huawei.com>
X-Cookie: Pay toll ahead.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--QnlaCkif2cEFA4WL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 18, 2022 at 05:29:41PM +0800, Zenghui Yu wrote:
> It was introduced in commit b77e995e3b96 ("kselftest/arm64: Add a test
> program to exercise the syscall ABI") but never actually used. Remove it.

Reviewed-by: Mark Brown <broonie@kernel.org>

--QnlaCkif2cEFA4WL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOgT/YACgkQJNaLcl1U
h9DaJwf/e+/a0tIe3/N/H5IVzrNLx6r1lEAj1ZAou6Mxgf5dF4V0AuJtNB9BZoXW
lkpef038GDwtPbpVe0z00Rk3RrmMO7kNAoy1yTvCcdftr2epVhtV3VAFxg612e9i
r0YHQwV6kNviKjJOuJIMjMQS7a5rY7oWEW5kXy2jg7A0j4rZk2j2dUls3PaCBmxZ
Tyz00BXXdQfcEJsE/yxoQ9rT3ETQpOt0du8yuSiC+FODeZc1fT6JiT6qyw7RCptA
TMdct5BUYxFQq9vhdlB57rVoiHGqa2yxP1FoLhhPoIZmEAW0RkYDbccFp/cxbfJB
a1Il3KQK39oPuBrvZ7nSIfZegJZX2Q==
=49Md
-----END PGP SIGNATURE-----

--QnlaCkif2cEFA4WL--
