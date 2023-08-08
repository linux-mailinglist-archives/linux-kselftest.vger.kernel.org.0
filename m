Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F252677423C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 19:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjHHRht (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 13:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjHHRhO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 13:37:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF676CC5
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 09:16:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01D5F624EC
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 12:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785D1C433C8;
        Tue,  8 Aug 2023 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691497529;
        bh=sC4E02/BINj7pWyMVS4nyFpH+D3+VLo6Wp6B42jku/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q28XMu64mWD15itogR6BMxaA6ubBhoSOaubWdiTCnaglTpbF66HSqigAVm33dEQUj
         smQ1R876W6LEBgC36amH/C6R61bi/IQIBZaEa4wXXbIoVG39LgPzNu0P///zk1Gqbt
         44nvYmCZcclX8NwhkQRREdroBbso7PgiwC8kl8RP5OiCjnup9NGU8IlsqBmKIB1NXx
         K5h4XO86/EIzty9ilZuPGaBqSb2qIiyTsqpC7of+PdXf1nBEtGjW783PoRt3+GAKow
         rTggNw9zo6LD+r6SxqzNvFwnINZ2zuzAfiQZmv++589imen0Toqvz/EEkWoXpcuV4d
         0DuCj6jSyasRA==
Date:   Tue, 8 Aug 2023 13:25:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     kristina.martsenko@arm.com, shuah@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kselftest@vger.kernel.org, xiexiuqi@huawei.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] kselftest/arm64: add float-point feature to hwcap
 test
Message-ID: <29093701-3fd7-443b-b5c5-4333a6812c4f@sirena.org.uk>
References: <20230808061356.2215158-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ahY/9JK6eeajWjO0"
Content-Disposition: inline
In-Reply-To: <20230808061356.2215158-1-zengheng4@huawei.com>
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


--ahY/9JK6eeajWjO0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 08, 2023 at 02:13:51PM +0800, Zeng Heng wrote:

> +static void fp_sigill(void)
> +{
> +	/* FMOV	S0, #1 */
> +	asm volatile(".inst 0x1e2e1000" : : : );
> +}
> +

That should assemble even with the toolchain configured for v8.0 so
there shouldn't be any need to hand encode here.  Otherwise

Reviewed-by: Mark Brown <broonie@kernel.org>

--ahY/9JK6eeajWjO0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTSNDMACgkQJNaLcl1U
h9Clbgf/fyRUUr0Fm7raPd7+oEvUJK1+OOiSohJBBi1FrE3WKR4utWBFUSdAVix0
LszS7Z2FbT2LZA2XDiCLzrdkcwTxaA+qsjrZ3q6RndKF/1AW8vXAWiLl+mvAmxl4
dDsDwzziKlLZTROTLTo6YV+jnIDHutCst33/1PwUULQBKx64rJQ7GiESrs5Yp2pH
JG3pyFBCNbEY51poQ716+E7RI8CMCyJBUqqc4D+YtBA7ftD/0ppDUdzUxTpqF7PV
x8ZXs4iys74O0I/qAYDv7z/KcPf4g0DHCsdEU7mEVCLr/U0cJgNQsQEefa0c1mDW
iUsPGrvwX5o4LCa/rpDQeIWDzmigIA==
=c5Q1
-----END PGP SIGNATURE-----

--ahY/9JK6eeajWjO0--
