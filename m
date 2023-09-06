Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92B27940FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 18:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242840AbjIFQC3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 12:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbjIFQC3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 12:02:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F361988;
        Wed,  6 Sep 2023 09:02:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F053C433C8;
        Wed,  6 Sep 2023 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694016144;
        bh=Ufzz4lBVQfr/PI/5NOwXPNYYbWPWIUxJX0X2PSFXwK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7EhAWd/xx6bY1mrD9ap1J9yKEr4kfPZR8a02AYlwO4aFiuMNiiEd74lEku61n9Ct
         hCOM8r+jDV6WUDAlAZcmIMPvmz791BIBohGf9yuiZM7QUwH24WMkybCn/fKIg0g0Nw
         OaBv9FNbPvMWIQWuwGvq+XkPUoteH2iXLgkSWkBR7vIj5ScmK0NepvD3MYXu3zk3wo
         BUuAYAJapCd0dHozZ/4Uvj7xkpStlgnPTADuu7PpSBS9JosCrmTe94l+8NFM0UOUt+
         aegMn2DsBpFIZSrYA2EZDwRFrNabPC9zK75SEYn/nXuubKOSCdVPJa34S0KB21ueEQ
         12nvUA5lZLB1g==
Date:   Wed, 6 Sep 2023 17:02:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: selftests: user_events: Test terminated by assertion
Message-ID: <e24daa53-d8c7-4c40-b04d-20b64ae220fa@sirena.org.uk>
References: <CA+G9fYuugZ0OMeS6HvpSS4nuf_A3s455ecipGBvER0LJHojKZg@mail.gmail.com>
 <ZPidKsNWH34Xt+r6@DESKTOP-4OLSCEK.>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NOMTLqgHkzaHZdzi"
Content-Disposition: inline
In-Reply-To: <ZPidKsNWH34Xt+r6@DESKTOP-4OLSCEK.>
X-Cookie: She blinded me with science!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--NOMTLqgHkzaHZdzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 06, 2023 at 08:39:22AM -0700, Beau Belgrave wrote:

> What is the expected behavior of self tests if run without their
> feature enabled? Is it expected these should skip vs fail in that case?

Yes, tests should skip if preconditions for running them aren't met.

--NOMTLqgHkzaHZdzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT4oooACgkQJNaLcl1U
h9B9zAgAhq2Pa6rUkN5+3928LxSggXbWiggCO+ZETjJmD+BxJ1QfJ2/rWnGA7sW3
BtR8GCMqnCsm7vmcovi03mYPSpf5Z1dnV/vDYL585Nb9MDJhQKPgbqbjNa5JIgH3
sFsFgmrefSgUqE5k6Gsh4rytdlSP43zKSWpeZ5nVCuU4196svKbNAuAjZq3wmMyX
ukheJ8Ic+0r0j/ZO+tWNvd9WP1NIaUteci0oL40GpeEJCg0KNlmNBl97Prt4zRW6
U+9RWFsfqkTmfDFsDDoiTkA+nURGprXi7pN2riXqkGtSF9OPw5ewCvncNfizCRwK
5IvAhFNfqi5HzkkDt/J+mEwliuTWzg==
=kVrH
-----END PGP SIGNATURE-----

--NOMTLqgHkzaHZdzi--
