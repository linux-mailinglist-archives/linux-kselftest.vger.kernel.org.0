Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1DF76EB58
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 15:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbjHCN64 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 09:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbjHCN6w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 09:58:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E88A10F0
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 06:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7E5561D98
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 13:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E07C433C7;
        Thu,  3 Aug 2023 13:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691071130;
        bh=2VW+iLq+oMdrWcLcAR8EiLVnlP3VOCyC9fSsFTlh1os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=muFKso60hy73INTEgfjMQmDPPihTzOhmD/lZL8TPonGEhyUlNAnzPU+ldtBr7k5HY
         yBmtB1JxA/G1Edw7N3lT7rbX8pC4Shk52G8mXHcZJQo21itF5nRXG0IhXXglvsbkaw
         /jNWYH2+UJYRvRQjnhKx2TlH67wHG4J6Rg9k/rSi8VvJkwpt4zR3gCyfBieXcfFV3X
         e/5AVZbRqWymQMQx0ScAEhAzapuDiJO6J55kVBP8LHxuIZT46SkvkSe83ZNnt+MYRl
         8owAfiVNXlkW+kp/OJ9LYifNlua7H5z7Ev6WWF/AlHQEh3DXZpMB4goS40Z8nDSa27
         6zE7w4oCjsGLw==
Date:   Thu, 3 Aug 2023 14:58:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     kristina.martsenko@arm.com, catalin.marinas@arm.com,
        shuah@kernel.org, will@kernel.org, xiexiuqi@huawei.com,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] kselftest/arm64: add RCpc load-acquire to hwcap test
Message-ID: <0a535ff9-aa67-4e7e-9d4d-e78a113a993f@sirena.org.uk>
References: <20230803133905.971697-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rTmqvgjUbd0Svfsd"
Content-Disposition: inline
In-Reply-To: <20230803133905.971697-1-zengheng4@huawei.com>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--rTmqvgjUbd0Svfsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 09:39:05PM +0800, Zeng Heng wrote:
> Add the RCpc and various features check in the set of hwcap tests.
>=20
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

Reviewed-by: Mark Brown <broonie@kernel.org>

Instruction encoding verified with binutils.

--rTmqvgjUbd0Svfsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTLspQACgkQJNaLcl1U
h9BM1gf/bgCOfsHnUhMYWRkLBDl2xUGRXj/kCrU0SYG6IANeSi3A6pEO/Q+5vU3T
oVGCGp3uMHXmzz4+FCNZ3RRLicoI2lMyhCfeLfIJZRpDYRIHtjohm2W5YkQtztV+
YTWsd9gQTOrbsuOMUvv+MgnMQ5mJhlnvOcZPZlMKI3w13MJGf7tBzIzRRV4oLAQ+
ansSmk6dv0fruATiYE64wAF/hYePS+hzzzzXMyNdC6cliOuPxVwVlWWXH4G29lmg
2E+x57mJOgqJzTuI8yuHdUAW0wo8lsF3CBHLjKLzxPS7l85Ppf4/bBkS4zsxRObd
ybgLyq6k49inhtvCJLMLeNrcbm3GeQ==
=RPa/
-----END PGP SIGNATURE-----

--rTmqvgjUbd0Svfsd--
