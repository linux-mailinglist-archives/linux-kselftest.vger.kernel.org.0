Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9D07DC041
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 20:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjJ3TSs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 15:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjJ3TSr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 15:18:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053E9D3
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 12:18:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1171EC433C7;
        Mon, 30 Oct 2023 19:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698693525;
        bh=dO3G6JDh2nnmC/bwSDOns+y1owi1vju7pdeFjUIx3EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CvOUhs5FijnVE8ErysBczECrWZcgEn+hk7JvmEb/KgOSxXGlKXWOKBuk0yS7t4mmL
         qOJuIhpafKyh5ZC4uT7r42nrmOyW1BhhVnvmdMQ/AkjlszLFIPQwVVJ2rZAGqf4n16
         xAIfjPQcnTqZr+EySlYMPyIZk3tA26yIPUqutRepbJuk3cSyYveCPVCwNogv5ewlEt
         TPP8MZavzIt5ZVxu0n6hEZeoaMmZpF1bpN7zeuvkOOLlKlpyVQ0j4RIBR9kG4OlGpq
         rmrSIk1dUxnsPOoHTAlObp7pM/Ihe2IHjpcZxBhTcQ8HnmsxkIcyb0gnwAaYsKLNt9
         h/g2o+rbNrMGg==
Date:   Mon, 30 Oct 2023 19:18:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, maz@kernel.org,
        oliver.upton@linux.dev, shuah@kernel.org, will@kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 21/24] kselftest/arm64: add HWCAP test for FEAT_S1POE
Message-ID: <1caa89d5-2184-4ab8-9620-8a1c0d7850d3@sirena.org.uk>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
 <20231027180850.1068089-22-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zujnxR0fWdTbL20W"
Content-Disposition: inline
In-Reply-To: <20231027180850.1068089-22-joey.gouly@arm.com>
X-Cookie: Boy!  Eucalyptus!
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--zujnxR0fWdTbL20W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2023 at 07:08:47PM +0100, Joey Gouly wrote:

> +	{
> +		.name = "POE",
> +		.at_hwcap = AT_HWCAP2,
> +		.hwcap_bit = HWCAP2_POE,
> +		.cpuinfo = "poe",
> +		.sigill_fn = poe_sigill,
> +	},

We should set sigill_reliable here - there's a trap for the POR_EL0 so
the test must fail if the hwcap isn't available.

--zujnxR0fWdTbL20W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVAAY0ACgkQJNaLcl1U
h9CfbAf+Id1VyCAQbxj0V499TJRAchoHYN7/dcWVEyuEUBg5+cAG9dBPQLOf0tOE
4DsEW4Kufll5OrCboNdRqdg1KRK3wpwugd8LkpyLUn6sEs/alUjrc7sICqeBLtNm
caCUgd0p3qIKUxQzmg/fKn3p5lZX9smYdW9RCRwKnkZYw3JSbE1b24iSVdk5vXI8
SqFKjZkm/+96KUx76M3roMtFgQ7i8vE/jhBHojc3lvU7qdTz9U2Usj6/h+Hrf87W
TVMoZGauHJLc2sgLV5aIjEe5lDYolpKa+27WFUJ6HWEzVIihVZGPh59Z6XbLNRXu
Md+2s0TjPvf0tGF58mlHrF7e0OZSBA==
=l9mT
-----END PGP SIGNATURE-----

--zujnxR0fWdTbL20W--
