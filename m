Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1390F758040
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjGRO6N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 10:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjGRO6D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 10:58:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0189F1988;
        Tue, 18 Jul 2023 07:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EB3061626;
        Tue, 18 Jul 2023 14:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE7FC433C9;
        Tue, 18 Jul 2023 14:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689692280;
        bh=hIrsjnhdx+cSgJaXC5WSiVTHcaGG12oAtcPhHcL09+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFPkanMqJXC8i85duHuH6SSWDH56zYjhm4PSscaJPFb7ShhJ4an8akumew5xuAJKd
         RnQd/TlWIuKe2+gshtIoNEWjfLaKQgADvrNoEfkGj+H/pypGZgeQsAbtK1d7Ce8e4A
         xLIp2ayT/qQDzCcMEhEM5a7UnQHyC68tPZTT3kj3+ZJW+7V1a9rbeLGPYNDPIeujw2
         Fm2AyflRqID9YyZWfNcbE6jg/yZ14Qjr95bhHKofXJJQxFcAL6/Kkc/ueyIhqh/yo3
         kkxB+4rP867mbZhiTvysuGmwJpICWcj41T3nABdhb347MZASwWFBKD9adsaJ6zYmlJ
         Y5w/KawqVqCvg==
Date:   Tue, 18 Jul 2023 15:57:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Message-ID: <1ea67208-1dae-4c74-8b64-e0a1029e94be@sirena.org.uk>
References: <785e1c1c-84d8-e87d-f22f-9a53d27f30f6@nvidia.com>
 <620a5b91-9715-ee28-423c-851506b10832@linuxfoundation.org>
 <421bebb3-19e9-47a7-8b2b-f69f125df22f@sirena.org.uk>
 <f479b731-7782-0417-2d4c-31a7c3c9491c@nvidia.com>
 <20230714112653.0b42d3c9818b038d219b5e41@linux-foundation.org>
 <68ccfd77-ce2f-857a-37a7-e9b3edcd495d@linuxfoundation.org>
 <5e5bf5c0-bcda-ec2a-ba4c-5f35dcfbc373@nvidia.com>
 <d03af9cc-c72e-d23f-73ad-ca0e079c3187@linuxfoundation.org>
 <85526b4e-c2ba-4b19-9c2f-ba39a248a713@sirena.org.uk>
 <d8c8d82d-059c-fa98-09de-9eda61370f7e@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JV/PjwGPigZIXN6w"
Content-Disposition: inline
In-Reply-To: <d8c8d82d-059c-fa98-09de-9eda61370f7e@linuxfoundation.org>
X-Cookie: Nothing happens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--JV/PjwGPigZIXN6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 08:56:02AM -0600, Shuah Khan wrote:
> On 7/18/23 08:54, Mark Brown wrote:

> > These didn't seem to make it to -rc2 - it'd be *really* good to get them
> > for -rc3, not having the selftests there would be very disruptive to the
> > standard arm64 workflow.

> Just about to send the pull request for rc3

Great, thanks!

--JV/PjwGPigZIXN6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS2qHIACgkQJNaLcl1U
h9A4JwgAgVdJvsXv4koBtfkkAwwKXjIVg1KyNCJNIKEV04W8rQBaxGFBhPydtF70
0lwOEYbe5gWKosZrEdx6Dvx7uuXvYfrfhV3hkq3AXGTgTenfVVlWIsUji6e+j0cq
/1GKrFjXZJvMILzgeAMUaDNUM3Vjk8dYr8Gw0gXEUk66AXwNeCJUorh7o3o4i3uM
3FSeTCfGYmdBCC5BmDWyGXWzZxL0T6ieHnegW0X9SKF5RoFv3uSYs8LlZvNoo4Qw
1SngE/e7AFqgEqq/LYyM+OkorOFv78m6d/DRrkF8q9FMDjaRWQcMinWZH1dlb5Hc
sATbogkjCsP3uoGLijdeeR4I0pHKQw==
=jUFb
-----END PGP SIGNATURE-----

--JV/PjwGPigZIXN6w--
