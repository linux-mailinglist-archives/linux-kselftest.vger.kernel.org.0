Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129606C8E45
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 13:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCYMjc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Mar 2023 08:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCYMjb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Mar 2023 08:39:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ED111171
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Mar 2023 05:39:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45BE4B80707
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Mar 2023 12:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8455FC433D2;
        Sat, 25 Mar 2023 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679747968;
        bh=bzJOuXphixxPvR/XYoxhnmG5KfSgPy8eDYnhLSnOZO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFEsUChueDK8qoQh/M8MpJxH5+qymYzKfttjvuK4tPnEcfxjPFnNHILYE3MdHty3S
         hWRP9LXwLS0XCRS458kAq7Cjvzj5pFm/orYfzPYW3L8MM76WzN0/f1fAOHD9/ldOoL
         DAu2pJorZF9dGZpFPgOkUApvDg+egUMn3pkXWx2PVhWl8W7qUsxYK0YpJNLEduhKFp
         IatxXZjyFBjN7wbWX2uy2S9rnHN0ciozlHl6NfhrOOKV/of6JlxU91GmLom4/CxSoS
         LmFJlJOhPxvJsQ7MmBIMhobNm/iWTSnLqWsESnzUuur012/yOyXfUYBQddGSBW/c3i
         VdF3r9dDyI6WQ==
Date:   Sat, 25 Mar 2023 12:39:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Re: Running KUnit using the wrapper script
Message-ID: <ZB7rfA2C7bSf7OlB@sirena.org.uk>
Mail-Followup-To: David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
References: <ZBumkUcw8cQfjvO7@sirena.org.uk>
 <CABVgOSk-3vSPsWDDzVO4GnzN8FAbBpx_jfKgTc9B=o7FODBhiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VNwuxaWUFVpGbLFb"
Content-Disposition: inline
In-Reply-To: <CABVgOSk-3vSPsWDDzVO4GnzN8FAbBpx_jfKgTc9B=o7FODBhiA@mail.gmail.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--VNwuxaWUFVpGbLFb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 23, 2023 at 09:31:10AM +0800, David Gow wrote:

> The most convenient workarounds (other than having newer gcc /
> binutils) are probably to either run against a different architecture
> (e.g. --arch x86_64) or to build with clang (--make_options LLVM=1).
> Those should be a bit more stable for bisections than UML on the older
> gcc versions.

Running with --arch x86_64 or arm64 seems to work around the
problem, thanks!

--VNwuxaWUFVpGbLFb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQe63sACgkQJNaLcl1U
h9BPiAf+NPdUd1/DAJkvFCNRHrZipB3ngLkLKE6hR3/SjNEePaegpymO3HRzomYF
XR0Zv0E53X1Ll0aEioESIfqmK1NNvo5wOWy/JEbb+kPtoxItvZQXC0gVv9Mqv2YZ
5qvohsDRO6J1vrDO/9eTFjb4w0kfc8AtesPho2Za0GyRqc6OM9Hpj3x1VdVTDT3K
PLXrTrQ5mJp3G6gMCa+gDnU1qZEC3LE3pVknIuBS/IH7jp002DXPC9hf81U5NAx3
m0eSa6SwAxI3EJZqcMAumviY+O8Mp1k8KPhIE5cjghTSI5ptF1KqLaGK/qvh8pmi
E6DXujE21vrNUxIMeD1VcsiGQ+lGOg==
=Yr2e
-----END PGP SIGNATURE-----

--VNwuxaWUFVpGbLFb--
