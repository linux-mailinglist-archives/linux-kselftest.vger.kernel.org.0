Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D3F6A0C7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 16:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjBWPF4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 10:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjBWPFz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 10:05:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AA24A1FB;
        Thu, 23 Feb 2023 07:05:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAF4C6173C;
        Thu, 23 Feb 2023 15:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAB9C433D2;
        Thu, 23 Feb 2023 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677164753;
        bh=pILPGxBt1kJYtwWzhF/f0Y6FgifBCmAAPLsPd7Uf7Jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSK0Z7mAF/TyVWOcprYHz1DoIxuKXxjdElzHtikBLLxCwtqZVmfpCoOwLTdOt5F1E
         Jz3ROmBmPnbHHmFnZl3wnN1TBaQQ56an4akdlBDe0l7bhEA33gR128c6YNXEX9Y05C
         cC7cHKy1bQYSWu8dDYHNxhtU45IbisBGe0Zc7KdMVFnuclopStvYwXlIFKLuKaa8ua
         OpSWgd7ZNZNZnYmEXPnoapvcYaruSPAy2JUupm4oXJENg3a4EtlAD7oP7u/n73GNM6
         PMpyLMOBN9+R+C8huYkwV9DbOeCrwZckzhpJo2tw3PrhOlN7RtEnJZxrO7IAOJhay4
         fe+acPowrfZpQ==
Date:   Thu, 23 Feb 2023 15:05:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, shuah@kernel.org,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] Fix snprintf format warnings during 'alsa' kselftest
 compilation
Message-ID: <Y/eAyrYs+wEu180d@sirena.org.uk>
References: <20230223143214.16564-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="moK3dVaIIIQiq0dD"
Content-Disposition: inline
In-Reply-To: <20230223143214.16564-1-ivan.orlov0322@gmail.com>
X-Cookie: Hindsight is an exact science.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--moK3dVaIIIQiq0dD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2023 at 05:32:14PM +0300, Ivan Orlov wrote:
> Fix 'alsa' kselftest compilation warnings by making snprintf
> format correspond the actual parameters types.

What warnings are you seeing in what configuration (arch, toolchain, any
custom options...)?  I'm not seeing anything when I test.  Are these
perhaps architecture dependent warnings?

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--moK3dVaIIIQiq0dD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP3gMkACgkQJNaLcl1U
h9CM4Qf9E0H850zw25V6gVtIWyUE7gWogdUbveseWkxHrigCVh4D6QNPMAPEhfZ+
hJHzOTntQ3rTerdrTVsAHTbv9CFFiJq/q/nHFgbaLzNtWZXEAGpc0SOaIyo3zpIX
EM7Q4yuMVgTCEwVXtyORE+866Mv/ZQdoLc1nLCkuXW5gRxFtitPyQaWppIT78ELA
L7ecbqFM5YzAPSrm3fz9GSXZZ0b7oDlWMh5JbW4ptilREvBwZoGEiXzS8iXYGk1K
4ikV3nfCjeIgTgOFvaAHY3RhpEpesaAA9yw1D4Xp/uRGtVYKVM6ox5KUQefRrixc
CSXH8aLRckd288owYYnZglJxk9fHKA==
=Hvq3
-----END PGP SIGNATURE-----

--moK3dVaIIIQiq0dD--
