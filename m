Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE856DDF57
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjDKPPx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 11:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjDKPPd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 11:15:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A975FE9;
        Tue, 11 Apr 2023 08:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC0762851;
        Tue, 11 Apr 2023 15:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90480C433D2;
        Tue, 11 Apr 2023 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681225996;
        bh=A0BRRsIQ4AE6ZpQ1ZKYCWbf7VoxhQkFpEn1ZoQVKmbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WwlNnA0Bv7DJmfitKKRghDf77kt/Dps6aKuynJg9nsxF1sqivSBDTBqQKkP5HzqzJ
         iueM6sLtBZhbPe096hIWMj8ITSJ59L7XtCycuGhaHsXTA0hgJCoA+ZMd+3SO5wlKcc
         +M8myly0dWwgTitW+ghveP3QcgLCYwTZz01RCslzIg1bTse1iCuWLl2tCWwFJtFeq2
         SvTqgcZFsQsdAvaZaZQS16kViFfUDom9KsN+i2zzgSnlVj+tWQNrpSGxbIRa26IL0U
         EkLIQQbRxO1cw/osPc/gDWmW+2rEfT1+Rll1Hys9Q6b1WNd0aK8SgfoRdhJCRC7nPU
         VUGL1mfEAXwYA==
Date:   Tue, 11 Apr 2023 16:13:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, paulmck@kernel.org,
        Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tools/nolibc/stdio: Implement vprintf()
Message-ID: <0144ab97-f34a-4803-8fdb-52340f2d73f2@sirena.org.uk>
References: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
 <20230405-kselftest-nolibc-v2-1-2ac2495814b5@kernel.org>
 <ZC8OwUPAC4s413jP@1wt.eu>
 <cbece9a0-b8d0-4f3e-9a55-9fe87e111392@paulmck-laptop>
 <fc52d5c1-61db-b8e3-e608-12434b0ee740@linuxfoundation.org>
 <9dfb88e8-2a61-47a8-876e-581e4c717217@sirena.org.uk>
 <20230411150320.GA23045@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L1UFlPmecxrcSJYU"
Content-Disposition: inline
In-Reply-To: <20230411150320.GA23045@willie-the-truck>
X-Cookie: In the war of wits, he's unarmed.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--L1UFlPmecxrcSJYU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 11, 2023 at 04:03:21PM +0100, Will Deacon wrote:
> On Tue, Apr 11, 2023 at 03:31:10PM +0100, Mark Brown wrote:

> > It seems like more of a kselftest change than anything else so probably
> > makes sense for it to go that way?  The example user isn't really even
> > needed.

> Fine by me, as long as it doesn't conflict with any other arm64 selftest
> changes you hope to land for 6.4.

That shouldn't be an issue.

--L1UFlPmecxrcSJYU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ1eQYACgkQJNaLcl1U
h9BiYwf/YByjGX9Lo4Jnr4wW0Zo5HxRI3UR/slbdJTAOZuhRSwQZbSsQUR8N9fC8
MH9/yFSTMiDZfvHoUXR8EoTxJdyNow59fbx19AGxuXMCCfM2P8d7P3iIkPwvXaGq
W+bgFnxwisg+PcY4DOByf9fO77NXVerevXs3h7aRxw99VsgT1jzt9sS3a0s1S/yk
KBPe7iYs12JsaXMB0nPOTs5ziAM+RY4phpQT2Vvsis5YU4PHKhy0e+HXIk5Zt1mr
P/RbWvwm3NKNtSXEIw+EJljcGexrowyCkH/rfZuGNvzf1FNJKY69pnw2tCSCKMsj
IKbteWF/zkk1Bhsr19fMDbn5pCb2jw==
=jFTX
-----END PGP SIGNATURE-----

--L1UFlPmecxrcSJYU--
