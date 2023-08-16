Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A3977E299
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 15:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245553AbjHPNau (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 09:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245574AbjHPNae (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 09:30:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A41E52
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 06:30:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7760562613
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 13:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEDDC433C7;
        Wed, 16 Aug 2023 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692192632;
        bh=qx48Uz1McCl5/w4g8q/npJoT231WTFacMfTHZi2XEGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikKaKZWEKP0LW+vYYf4/8eE83Z0zovAJSHkZ0if6+G1tc7RJRLyo0jMegprDx+Go+
         d9EO9c17xIOa4qnUr/2AB/dY3yxkJa4JTBnZilclXWjzqB0l9k9kMS282xmOXy+rFa
         b26JEO37NmUYg/sUXcWTVZK4NEBhsY5fp9iBEU3gcALdo8zIbW6PSyeZkT1oagSyjY
         mx1AXy6dvZKOqxAasO13ptbRTXwzQzC+VovvVGNCMJO2vZizJeToGcVWzKmB0/tNyr
         Bgq/mMRdCmPN5ACOhkQMBt7TPNO15Xb/fxS6J6sVmyTknmgBaMI17rlvvbxMQNjNlf
         WxFEIZdCKvDUw==
Date:   Wed, 16 Aug 2023 14:30:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest/arm64: build BTI tests in output directory
Message-ID: <68259a20-4818-429b-afcc-bc676696aa09@sirena.org.uk>
References: <20230815145931.2522557-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ZEyg/TOZKZj+pFb"
Content-Disposition: inline
In-Reply-To: <20230815145931.2522557-1-andre.przywara@arm.com>
X-Cookie: Old soldiers never die.  Young ones do.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--3ZEyg/TOZKZj+pFb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2023 at 03:59:31PM +0100, Andre Przywara wrote:
> The arm64 BTI selftests are currently built in the source directory,
> then the generated binaries are copied to the output directory.
> This leaves the object files around in a potentially otherwise pristine
> source tree, tainting it for out-of-tree kernel builds.

Reviewed-by: Mark Brown <broonie@kernel.org>

--3ZEyg/TOZKZj+pFb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTcz3IACgkQJNaLcl1U
h9BYGgf/cvghYJIXFD/3cPmsl1CRWy1dLCbx1DJMo+uk6Ifo+jpImdLGO/qmck2d
nGB7828Z4cbPY8y2qBmgzNVPwS6qTazibpVRDBjWFMxXYykIDzdFrWqc4GprbhaE
rA49PmyxH95Utgfafl+SY5GyGYSvmBwLJDQwtkhhuSgClqgqtPqZVBSmovmHzkS4
o+cO/kJF4ccYO1HgDVD3DJS1gJzBoXiqODPEvO7V+D5Mq5snhydpHLeBINDwMH1e
tj87qSAxnfBBTqsKJzg0YStlSxgqSS51qwOqn07EheMDULyDjnKk2icVtsKURgJL
CkCVgNiTk9NbOfNWIZdbsO7uv3pJDQ==
=AHNS
-----END PGP SIGNATURE-----

--3ZEyg/TOZKZj+pFb--
