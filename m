Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD8C739F4C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 13:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjFVLLR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 07:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjFVLLQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 07:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300CA1BD9
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 04:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B76A6617D1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 11:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CF4C433C8;
        Thu, 22 Jun 2023 11:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687432275;
        bh=oi1dNXkhA12TB9OBN/75+d4+Pa3h8hd2TBS8dCF4s0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRAUGLxWTKmEwo0azxhkyo+fteqViBj5p8coj8vVRTzW8eoGOQIm48rg7jM6VqUq3
         xaangIsPt12bdSZAc9z4Ip9AXmjPSozgZcQkj3hHnXzVyIJZBinhJbgjhNFKuSuZkh
         pxq4f3ZJPi7TN8PwSPiJA9v32I4cHARiepaaUD/SYPB9V1SyMHCbJr8/M1rClF2Qsq
         P3SXw4F4UIgiSz53rKqVPyJLpxVfgnmIMD/W+WE/DRRiEV81uALUKoUj5zzqxTEf1F
         /GhYuYeg1PrnhRaqY6GGqOvrk/bPOMZRwNjSjK+3y6nN6cgTF+cunUMYwsTqDOWYZx
         s4mCGSSKODaYQ==
Date:   Thu, 22 Jun 2023 12:11:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] kselftest/arm64: Add a test case for TPIDR2 restore
Message-ID: <831f3de2-eca9-42fd-b6fb-82730a03c52d@sirena.org.uk>
References: <20230621-arm64-fix-tpidr2-signal-restore-v1-0-b6d9e584d2ee@kernel.org>
 <20230621-arm64-fix-tpidr2-signal-restore-v1-2-b6d9e584d2ee@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QDpwLIonhX3oR9a2"
Content-Disposition: inline
In-Reply-To: <20230621-arm64-fix-tpidr2-signal-restore-v1-2-b6d9e584d2ee@kernel.org>
X-Cookie: Please ignore previous fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--QDpwLIonhX3oR9a2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2023 at 10:00:51PM +0100, Mark Brown wrote:

> +struct tdescr tde = {
> +	.name = "TPIDR2 restore",
> +	.descr = "Validate that TPIDR2 is restored from the sigframe",
> +	.timeout = 3,
> +	.sig_trig = SIGUSR1,
> +	.init = save_tpidr2,
> +	.run = modify_tpidr2,
> +	.check_result = check_tpidr2,
> +};

This is missing a

	.feats_required = FEAT_SME,

--QDpwLIonhX3oR9a2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSULEwACgkQJNaLcl1U
h9AFfQf8DqAWjmoPVnT9ovvCV+cs+pNN5SDRZ+bINQmAwE5nXGqDM18HD/BO1LXI
e7t36tpX/7mUnPEchL34FCETv7fVcqPcxgiLOW+pRyPZ9TX6HcIjnHfWIFu3zVSk
bgBetjLM7FIbYZp7gJ2rBjRteUDMTNXEtmVa+Wb/ltM+qVjDM95ickTuT4UhqLit
ga6lu7x3M4rKAJV1sFzZG82IMW2N+d9F0j2v1IacEYhfTDSUC2uhlN3HG+bHWsmT
iv1jMOpVx5yiRGG4mirb5pqz+RkZYFDS2Ce7s1ZB6rai1/16JlnJaeZhEi41pFn/
p55a1BjostVQXxJPF+fqY/fILvtiPw==
=Byxz
-----END PGP SIGNATURE-----

--QDpwLIonhX3oR9a2--
