Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8316E750D25
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 17:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjGLPxq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 11:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGLPxp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 11:53:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE1FFB;
        Wed, 12 Jul 2023 08:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4920A618A8;
        Wed, 12 Jul 2023 15:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A1CC433C7;
        Wed, 12 Jul 2023 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689177223;
        bh=6i7Y4lQ5kM2O35VpIsKle6TMvXVfixvr1cKHxKvRKXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HyLMdkVD4F7rnG2PftNw8LtDgCj9djEt4RoA062Zm0ylTmA3goW8U2wX7ja3mzPYk
         x2suxPH2oKbc9FXrdM7o9Q225rzsjREDDcF9oP14pODw9qeXDHZSwP3nbq2JnTgp3D
         TloY6w4lO3SCQB7jvcoome1CHVtDSkrapIGdcibHPlqaIFgFhBGg7IvBIAlAbK5bH9
         qwuC6d7JlmunWaN9Qn+61xy5oo9ycoLvWdFc4gfB3aYlTxr4ZPtF5erYBPzCX7oZJ/
         YsSvs8nCBvDP25GSOs8Ye5v63fmXY/36lpvEe/+qWJb+rs4Zn0e7HldvRrG0ntzE21
         UVO5/V6ByRLpg==
Date:   Wed, 12 Jul 2023 16:53:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] selftests: ALSA: Fix fclose on an already fclosed
 file pointer
Message-ID: <03293bcf-7193-488f-9897-5d96790db55d@sirena.org.uk>
References: <20230712140122.457206-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wVNsGP+PGG+ocxCF"
Content-Disposition: inline
In-Reply-To: <20230712140122.457206-1-colin.i.king@gmail.com>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--wVNsGP+PGG+ocxCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 12, 2023 at 03:01:22PM +0100, Colin Ian King wrote:
> In the case where a sysfs file cannot be opened the error return path
> fcloses file pointer fpl, however, fpl has already been closed in the
> previous stanza. Fix the double fclose by removing it.

Reviewed-by: Mark Brown <broonie@kernel.org>

--wVNsGP+PGG+ocxCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSuzIEACgkQJNaLcl1U
h9BkeQf+PybKLN8z4YJie7BNQAYU4xABABxmQKw35R+xYMirTAbNdSteSQV3JRql
i2Z6aQ2e3HTAgx3tXQ4bgpNQrL4Lcz48rJAfMda0RBKReuIz1LfTW3d9ZoUIU0Lb
qYpvkL0Vjf0au1c1nRU6n6eb2ahu7VlJHgChwdB6ueOpBTKLbfpucVvt+dy3X5hJ
MbhkO/cs8jcOvyuzHZB6EjPHcPq1vr2zukAsTzmM0xZ5yxGFhewHpS+tPg7RjGwt
iC+4rv6dD85ZakRYIO5hYkdQhzIy9pOiuvE82+FGyaLSjnPOlwNAO444OHsWtiQ5
2CIxOWF/BIbsTJt+m2zSXOWZ3X8Mhw==
=spEy
-----END PGP SIGNATURE-----

--wVNsGP+PGG+ocxCF--
