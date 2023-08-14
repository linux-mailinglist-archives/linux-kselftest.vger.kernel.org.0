Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7077BE36
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 18:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjHNQiu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 12:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjHNQio (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 12:38:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A188C110
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 09:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36D826329A
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 16:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01E4C433C8;
        Mon, 14 Aug 2023 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692031122;
        bh=Jf1iq9wGtQfAIBSrpy5kkz8GRhPWJIBfCGoDOX+sg6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W84N48cxbiaK8DJhvqBuceVGFwkK6ClD+RToC1HSNPx5ZxBS8qn0Zxc/1cHflhWrX
         85uyykDRjyNTZQVUR05++hki6WCrJTqRza2ny+/iaq/mB4lHka+lrAcG8aKJdpD6kp
         pM0LfDovYWRK5RbTAOydWae+wyTgIpCttTEXLPvID/Xr3oTxSLrstv64f3l9/DNgIs
         zu2GdJBBkMS/jzk4ha00REKTnKhyjg/zyQc597jSd6B3OJJdZIS+5qEh5qiPUxW8LF
         KhfNVbm1iN6OMRGDNJ0eV42TWIkhBCrf5s4Jkfw2qs8ERpvatbWKPM9q59PV6mZy9J
         2oQ0YPM5LGuIg==
Date:   Mon, 14 Aug 2023 17:38:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     shuah@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, xiexiuqi@huawei.com
Subject: Re: [PATCH -next 3/4] kselftest/arm64: add pmull feature to hwcap
 test
Message-ID: <3864eda1-0d02-42a2-ae9c-0d1eb3195a19@sirena.org.uk>
References: <20230814021747.1784812-1-zengheng4@huawei.com>
 <20230814021747.1784812-4-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82IVcnuVjLk8SJTS"
Content-Disposition: inline
In-Reply-To: <20230814021747.1784812-4-zengheng4@huawei.com>
X-Cookie: FACILITY REJECTED 100044200000
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--82IVcnuVjLk8SJTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2023 at 10:17:46AM +0800, Zeng Heng wrote:

>  	asm volatile("mrs x0, S3_3_C2_C4_0" : : : "x0");
> @@ -359,6 +365,13 @@ static const struct hwcap_data {
>  		.cpuinfo = "rng",
>  		.sigill_fn = rng_sigill,
>  	},
> +	{
> +		.name = "PMULL",
> +		.at_hwcap = AT_HWCAP,
> +		.hwcap_bit = HWCAP_PMULL,
> +		.cpuinfo = "pmull",
> +		.sigill_fn = pmull_sigill,
> +	},

Please keep the table alphabatically sorted - the function is in the
right place but this seems to have got reordered.

--82IVcnuVjLk8SJTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTaWI0ACgkQJNaLcl1U
h9CgHgf7B0sGb+LPurc7k9CkdDHSRChUt9+5E/NIHJrWmRviOXcgQNa1kByy4H1B
TSgaAbHgJPBjKrn9s7LbfOxVP2osiIIhRVoDdFZbhJL7EWFEUsQylSyPzFsjIGjH
BAw1r60vNyqCMLYYhgKG9F/rk2exVCi54uyaC/mvH9iONSoncqt+ej+OFIwL9CmW
otS3P6l6ucO3i0PAqr3XJh76yX++KbRlye7UoYiIUF3sEviAnd2l4fApcQew6V5I
WKhrzOKXW+r0+p0Fhs4azhLEIRpHsO82bQNUd3fydXs+8N6iLEKF9SM45AILeAQq
kddH1+RoAK8WPTHtJjB+/LPNvncIhg==
=Kx54
-----END PGP SIGNATURE-----

--82IVcnuVjLk8SJTS--
