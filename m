Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AB7754244
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 20:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjGNSJu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 14:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjGNSJt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 14:09:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE3AC6;
        Fri, 14 Jul 2023 11:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B89761DBD;
        Fri, 14 Jul 2023 18:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59072C433C8;
        Fri, 14 Jul 2023 18:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689358164;
        bh=pA+vRQfgNyWNSj75T9hcPBjiY3mtcI5vwT03oDiej+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxjRepRkwmtuVKA4PrTjNFAFH+/WlsYNdy0MeCTaRxAg4xAKj1oyYSTil4IEGlEX2
         DJ1QuSuvzGknnTBknR58e3nMjklAYBHoTOxfVhCMiHL8X+hEVpiA/fFMB5o1s4aBJw
         fHoxyrH3+yvkA2MAJByg1P8wkkUTiO0IDwUIXh3nsa14XnV7f7ZRw3OuQDIs4LkOfl
         ZiLQvgBXir0xCeGopZtJJJMtD4mz3YtlKRwao3G/WV4kF4ve81/ZNfeRyUYtKJlc3A
         RH4FcJ5VxKV+WcHdDPmOqIZ7AJJUaRCaBV8ZuakvpTkENGIjiFctzDqA+JzIAjbto8
         0QPQlLRX0TRHg==
Date:   Fri, 14 Jul 2023 19:09:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Message-ID: <421bebb3-19e9-47a7-8b2b-f69f125df22f@sirena.org.uk>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <8d944238-1a9a-e93e-fdab-54e74fa12e11@linuxfoundation.org>
 <785e1c1c-84d8-e87d-f22f-9a53d27f30f6@nvidia.com>
 <620a5b91-9715-ee28-423c-851506b10832@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/UPNma6tP2wZbraZ"
Content-Disposition: inline
In-Reply-To: <620a5b91-9715-ee28-423c-851506b10832@linuxfoundation.org>
X-Cookie: Preserve the old, but know the new.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--/UPNma6tP2wZbraZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2023 at 11:48:51AM -0600, Shuah Khan wrote:
> On 7/13/23 14:16, John Hubbard wrote:

> > Actually, I was hoping that my two fixes [1], [2] could be used, instead
> > of reverting the feature.

> Mark! Are you good with taking these two - do these fix the
> problems you are seeing?

I reviewed the one that's relevant to me already, the arm64 one, I'd not
seen or tested the RISC-V one but that looks fine too.  I'm pretty sure
Andrew queued it already though ICBW.  Either way it'd be good to get
this into -rc2, this is seriously disrupting arm64 CI and I'm guessing
the RISC-V CI too.

--/UPNma6tP2wZbraZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSxj04ACgkQJNaLcl1U
h9Bo3gf9GtQCDAtojQWTiIZphZWIbg7iRowVODVD77IgD6xCNdPmj0Voe4seTB/x
G1kQFcmiuhhCvtF1NSKapvc7Ej6LiRvFtvtgytqFyfvdZowMK1Q8v7u7XsgUobtG
UPdQiMYInvs5iiEDsC2o4lTShiN6Cg5eS2xZA54KwlfBuE/s0iveq2CpEschalrD
eRmi+akPrcQx4OeAcdRFM3oAoKIusPzR7e5qzKFtwuIU2hD8cX5wPHhulSKz9yWG
SOC12+/iIiEbBpj5fKpdgRMu2e+HAX4ErD3zRdDpJFwgGaef9Cijt0G3v99FpxY3
MBhcMOCDcMbCEA4b326SfTIHeppPig==
=KuKT
-----END PGP SIGNATURE-----

--/UPNma6tP2wZbraZ--
