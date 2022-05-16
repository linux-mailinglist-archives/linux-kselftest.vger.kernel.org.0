Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BE3528C5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 19:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiEPRwb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 13:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbiEPRwa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 13:52:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85E11CFC1;
        Mon, 16 May 2022 10:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97159B815A6;
        Mon, 16 May 2022 17:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ABBC385AA;
        Mon, 16 May 2022 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652723544;
        bh=V6OYfbvl7Gf5jRVgQc6Zwaa10DLCSHKSqD/KiJIBun4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DrLKI83o0O+3SLQ8Gd81gugSBsgEJvkW8r3IjFj5jvZs5WCQDZfv/oLy+9iLWMBAA
         ST7cF7XRRy1j0sDB1lcG5oQNRF1qn+BlWsPbbX+tGDg2LlZgLUYD5DO5QIW5motEkt
         O4bCAPKqgFSG8lgRmtrzcx+yH8utQ8M1D+dVS4b/e0xKaySz+glNSsFNn+13W1SLbZ
         NxuW+x1iGowuDgoKi916FnXIwCBjSyJE5c8GLizqXT+8t0QeBTBAIin6X/4/8U/QLD
         DBEoq9ZKUehrdGDUXgn2g7aIdShs8JIQO7yCUf5aw7iz7vSxydrmg2JdtxAMN0Fa69
         RuRNZuvafwzfQ==
Date:   Mon, 16 May 2022 18:52:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Antonio Terceiro <antonio.terceiro@linaro.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest: alsa: handle cross compilation
Message-ID: <YoKPU/QbrkuJPlnx@sirena.org.uk>
References: <20220516165856.401452-1-antonio.terceiro@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l68LM0N6va3Ya2h5"
Content-Disposition: inline
In-Reply-To: <20220516165856.401452-1-antonio.terceiro@linaro.org>
X-Cookie: May be too intense for some viewers.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--l68LM0N6va3Ya2h5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 16, 2022 at 01:58:56PM -0300, Antonio Terceiro wrote:
> Calling just `pkg-config` is adequate for native builds, but finding the
> foreign libraries with pkg-config needs pkg-config to be called via its
> architecture-specific wrapper. This works in Debian, where there is a
> corresponding *-pkg-config wrapper script for each enabled foreign
> architecture, just like there are *-gcc, *-ld.

Why does this only apply to the ALSA selftests?  There's a bunch of
kselftests that use unadorned pkg-config calls.

--l68LM0N6va3Ya2h5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKCj1IACgkQJNaLcl1U
h9DcoAf+LVpPlFZWQHDWJ58ZynWUjK/xxuF/HWxAsfbguUHtJNjWrCUgsLI3ipJJ
/dF3BjpNo4wqsC+6DO5DW+aYiUgzOKC9MhY14A0DQPnbmLSmOhmfhDgycXSyiawq
qF6Xj9UX9shFYAYi5A6TnULsxnhAc07vDbj7VgTwmNOpNm4d/8/2ksWReJJi0/Ab
7gnnRE4xV0sqVBg1XQxAarGT3aNu8JBnhwHnr5gEuLAUyrql57+9dIGCJfngtDxY
BB1lgJBTrW8Z8duAmb2JU+9SbmFoeQUawQAxPEJOG2PebDDJsovTNCu8gmrV52fn
+7+y33ypsIRzVF+/WvbVh4JE32YDxA==
=NDzX
-----END PGP SIGNATURE-----

--l68LM0N6va3Ya2h5--
