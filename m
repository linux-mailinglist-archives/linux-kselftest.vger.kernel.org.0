Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF33376E705
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 13:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjHCLgZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 07:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbjHCLgX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 07:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B38726A1
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 04:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81B2E61D47
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 11:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41606C433C7;
        Thu,  3 Aug 2023 11:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691062580;
        bh=U0S+gbrXhbCZSbLfs5i5eHQsmciJTQ2TecuqZrOpqLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJLdULekhUXFycSZ336K6Jt4Q3f0EIGR+svi0rTOV64e+UkXsZf61YEtWh2sLkCno
         VptLEZp1KQ5bEGJaF0lRmFB5lG/jTMPzpAUqa5Z60HfhTLnMZnU8+NQCXwAWT/0kWm
         ohWdR2me9ZefxhUvih8Mmgt2600vB3L1FsedLGRgyDf42sqFL2aMzGcJCWVJGBJL88
         axHCDs4XZRtfYwlznpEUODqucS66SZUX1D1cSVQB5Iym6A2GJChzwUmKBJ6TJK2NyY
         ZQ7bfxi6kyyXHUHQ7PlqvvYe5HoVBhAll75j1q0T9epQitit+/BCdBalMfZjb2KKeV
         JwyLzxi1yL7aQ==
Date:   Thu, 3 Aug 2023 12:36:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     will@kernel.org, shuah@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, xiexiuqi@huawei.com
Subject: Re: [PATCH] kselftest/arm64: add RCpc load-acquire to the tested
 hwcaps
Message-ID: <54792955-9bd1-417f-8000-8e95f06a76d3@sirena.org.uk>
References: <20230803070231.3962475-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BZMDdhXlWK3x4PK+"
Content-Disposition: inline
In-Reply-To: <20230803070231.3962475-1-zengheng4@huawei.com>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--BZMDdhXlWK3x4PK+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 03, 2023 at 03:02:31PM +0800, Zeng Heng wrote:

> @@ -364,6 +376,20 @@ static const struct hwcap_data {
>  		.hwcap_bit = HWCAP2_SVE_EBF16,
>  		.cpuinfo = "sveebf16",
>  	},
> +	{
> +		.name = "RCpc load-acquire",
> +		.at_hwcap = AT_HWCAP,
> +		.hwcap_bit = HWCAP_LRCPC,
> +		.cpuinfo = "lrcpc",
> +		.sigill_fn = lrcpc_sigill,
> +	},

The table is roughly ordered by feature name, it'd be good to keep it
that way (apart from anything else it minimises merge conflicts).  It'd
also be good to follow the existing style and use the FEAT_ name for the
feature as the display name, if there isn't one then at least something
similarly all caps like the name of the ID register field?

--BZMDdhXlWK3x4PK+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTLkS8ACgkQJNaLcl1U
h9BLNQf/Vp2Ira/ojqc5d3IpsJtU4SmX8nDB+Zd7OEW01CKsyuNGDAsL9MxBKaRw
6NeKINsBmNqMc3wNlweA5L4Hcvx45JkGyywGoDPRMTFcmfvCzdOSs2ZeviG3Hg4W
oQ7SBu4YJKoKGtwU3w1aSyTBu2lztjA9vSLmdD9PTnqzcOvPveSOmHo07WVxXW5K
ulsbbQTLAkMrwqAPg6khkB5Pe6GudmbO0WPgx59wFMlEBgFLqSW6RRPAqPFkXx/N
ouVBcZCJZmuv5RBL46kPyt9XeCg4lPXaoRR9TrHJn+uJEnXr311hlNHtB6dzrO2o
jwc0OEo8YJcNySyY3GSiw1xBcjajpw==
=qQ/f
-----END PGP SIGNATURE-----

--BZMDdhXlWK3x4PK+--
