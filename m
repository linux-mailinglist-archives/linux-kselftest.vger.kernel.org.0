Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A497650AE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 12:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiLSLoz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 06:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiLSLob (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 06:44:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D94E0BA;
        Mon, 19 Dec 2022 03:44:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F21960F0D;
        Mon, 19 Dec 2022 11:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98ADC433D2;
        Mon, 19 Dec 2022 11:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671450255;
        bh=OuPBhqwvNtHFMcb/Xbxq79dm1uMM0B659l33Yxk/qGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fTQC8vh3JoN7sbkaE6QgWwGu7E6hxapusdes1ufJX5Vtik2u6KT/2JxiERDyDFFSL
         EKde3Impl/jhzsTp8XowKQQPF7t4wyjYdoEArJVZjrnaMCPTn89Syer8ncNfydpbwQ
         tokhdfG+r+ywQfB8hbIIZiFt6wKN4SrbAtCGkoo1B8zjrseTpEDHM3ooU8tCXMDRe1
         olNsf09t0H5TPU8mHjPoI+10cNmM6+Y0H8YgQ/neJv2FHB2r+8GQkmjORtPp3ZkWMw
         pi12HOq6NheGw+aNkqJGmWNag/IBDSmz/AA7pkaUnIrx3ZuT51lUuWKcaeJuQqPqQQ
         GIwjeke3QjHLQ==
Date:   Mon, 19 Dec 2022 11:44:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH 2/2] kselftest/arm64: Correct buffer size for SME ZA
 storage
Message-ID: <Y6BOipXQ9ltkWC4a@sirena.org.uk>
References: <20221218092942.1940-1-yuzenghui@huawei.com>
 <20221218092942.1940-2-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I+PoBtwpJvjPl5Yi"
Content-Disposition: inline
In-Reply-To: <20221218092942.1940-2-yuzenghui@huawei.com>
X-Cookie: Pay toll ahead.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--I+PoBtwpJvjPl5Yi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 18, 2022 at 05:29:42PM +0800, Zenghui Yu wrote:
> It looks like a copy-paste error to describe the ZA buffer size using (the
> number of P registers * the maximum size of a Z register). This doesn't
> have practical impact though as we're always allocating enough space even
> for the architectural maximum ZA storage, with SVL equals to 2048 bits.

Reviewed-by: Mark Brown <broonie@kernel.org>

--I+PoBtwpJvjPl5Yi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOgTokACgkQJNaLcl1U
h9Aefwf/VXUpH3f5Yr0GQTXtx3DrralIIFNM2yB7sZh0t9D5OdcmJpwk3JMwIGot
XJBnLvxExTCOBd9jxsp9w1k48f9OsOAkapuy/gWSDD55Hp9x2E80Ub1GHDlUqpgp
vfCK+KIXLDVR/GgbF3EG22OulxpOhwCtDAxdBwQHT2qVY5nG6q6BYrbSujB+JsHL
g+1aKdxs0vhSi2/XSn8mA2st8bv+JW6YtmaT8Ek0Vfd2g5QlY492Cvtj9gFFoyXj
9bQnD4pgA2qmGaWXYXaIhK7YvSjDnOZ3XfmQey+4+SkDGmBN6RAAD9cC9JuoW3N+
+jzGwNgSQLTqste4nqB0PNZSQcZWGA==
=43yk
-----END PGP SIGNATURE-----

--I+PoBtwpJvjPl5Yi--
