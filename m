Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14B87740F6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 19:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjHHRNK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjHHRMZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 13:12:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A06F1BAF3
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 09:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7DC762505
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 12:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F381C433C7;
        Tue,  8 Aug 2023 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691497691;
        bh=KkQ7Y38y+a30IIrybA8mAVVryfsfDuJ4TwwCjjt7UtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJCZYLN9aUl1JxWWqR4Ic7CRuZjFgBEx47zwDzS4wrRLzhFB2sMcUQozqaBVgU+dM
         Mf5QAGrZaXUYEnRODn8cYK/UwIcEHKR0ON18tHQKl9kqzW/8Fnz1PpMyH0v8Pg3VFF
         9Vh93tWEMCGA5mRfxD5fK1xYAfMJPVvb7RFv9sg+Gd6xbXRw6Ebq8LHS9zdu+jHRpI
         KEv9jTxfpIxVmHosZlgJDPVP09gdZf4nakww6B97qmu6NZw/POm6M9WLzmOG5dayBN
         3RZxOLr/4ma9oTcYBSBj7UiyiDUzS5HpZ6Wg+f93mOu3Iw8wiTjZB0xrh+PZLICJX5
         EyKk4IFjiuDOA==
Date:   Tue, 8 Aug 2023 13:28:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     kristina.martsenko@arm.com, shuah@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kselftest@vger.kernel.org, xiexiuqi@huawei.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] kselftest/arm64: add crc32 feature to hwcap test
Message-ID: <064a303d-656b-477d-8b24-41eebb24cc42@sirena.org.uk>
References: <20230808061356.2215158-1-zengheng4@huawei.com>
 <20230808061356.2215158-2-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xzEtjvulq2Vr5Nh0"
Content-Disposition: inline
In-Reply-To: <20230808061356.2215158-2-zengheng4@huawei.com>
X-Cookie: You need not be present to win.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--xzEtjvulq2Vr5Nh0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 08, 2023 at 02:13:52PM +0800, Zeng Heng wrote:

> +static void crc32_sigill(void)
> +{
> +	/* CRC32W W0, W0, W1 */
> +	asm volatile(".inst 0x1ac14800" : : : );
> +}

Same here, you could assemble rather than hand encode but otherwise

Reviewed-by: Mark Brown <broonie@kernel.org>

--xzEtjvulq2Vr5Nh0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTSNNUACgkQJNaLcl1U
h9Bjmgf/RX5mCaipnQ9Dbyf5KucZHKIKAjymOvQ3RIAbsly+NqLglcwTI7Q6NCCo
N+FyzGHuGme8cGHAicdjGs2zaYuNEm4o5988cXQy4GJSRC4iRMLE0IABVt5Q5vE0
I5rwtZCWkdd2STa1HQKqEKMQuP8lgB4TCg77SGdcfY/1fSWH5ytO6DT5XralTPGU
H45ac8BuKebIAsfU9sx3FxvPyEjj5tThBXl+kDx7fW6JktAb+wdbjNceOT+38MA5
piJy5Z8BK50qQrKt4eZNLttrO36cJKvJWKJboQsl86E/tM3mvlquH5H7WfTOuZBK
C1NU98z6smYbzyMvWThyHm28Ga+vDg==
=LVp/
-----END PGP SIGNATURE-----

--xzEtjvulq2Vr5Nh0--
