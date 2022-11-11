Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C530A62593A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 12:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiKKLUa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 06:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiKKLU0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 06:20:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE4F69DC7
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 03:20:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FB5CB825C4
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 11:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164AEC433C1;
        Fri, 11 Nov 2022 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668165623;
        bh=AvwbZqodjyTounHUgp/fomcc4iUUix/FPpfKpH7wwIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQ3rczdGVR928hMYdmbOjZRUg1E1AId0fJ2AMMnGsTeKaGIEfX05kUaSp5oIIYANR
         wRSX22wqezS7kJnHgtveSmmjV1cjwr7Gn4qc2vKE4Eur4Nb70UYgyyphmn4iPMue/1
         vn9/Ey7oXjYrJSUCKKQULpg/9QuYsFXMIgs/5cJ37F1Gh/64T3YCggQvCsfnObU0Wd
         wnQ79hwr2H8lUcX44Qnr/LyZeTMA3Meqkg25v9yrK9FJBX9C6CFRM+3rgs2CsxX3dA
         taFCb4zHfuPNj4uJBFY8XwWr+Rmv+7hpke40+un2pYfwv7zBN6doJLXsOuyJLQtaOw
         BIeE6/1C/sKrQ==
Date:   Fri, 11 Nov 2022 11:20:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Luis Machado <luis.machado@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 04/21] arm64/sme: Document SME 2 and SME 2.1 ABI
Message-ID: <Y24v8Q8FLl7jxDZP@sirena.org.uk>
References: <20221101143336.254445-1-broonie@kernel.org>
 <20221101143336.254445-5-broonie@kernel.org>
 <ac30884b-3c48-4fb9-d649-aaf5863e4505@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5Atr4jAvQFMf4UUB"
Content-Disposition: inline
In-Reply-To: <ac30884b-3c48-4fb9-d649-aaf5863e4505@arm.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--5Atr4jAvQFMf4UUB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 11, 2022 at 10:17:57AM +0000, Luis Machado wrote:
> On 11/1/22 14:33, Mark Brown wrote:

> > +* If ZT is supported and PSTATE.ZA==1 then a signal frame record for ZT will
> > +  be generated.

> I noticed we refer to ZT0 as ZT sometimes. Should we use ZT0 throughout? Or maybe ZT, if it makes more sense?

> Otherwise it can get a bit confusing.

I was deliberately trying to write things in a way that didn't assume
the number of ZT registers when not specifically covering SME2 itself in
order to accomodate future extensions that add more of them,  It's
fairly clear, even from the ZT0 name, that this is a possibility.  I'll
replace the plain ZT with ZTn where not specifically talking about what
SME2 does.

--5Atr4jAvQFMf4UUB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNuL/AACgkQJNaLcl1U
h9AHTQf8CDV4F0nTZkmIv69H7cR7fCR8e+OOdhis5PvaArmrUOfmejqnHJ1UtiSc
QEff7VjGBqurksYSohhYvk3ZaT6NnN70SJXsQVuL4VmDxKJBQD5SJoh6uhQPCc/q
ZxNynFd7UJHfR9NtiKM5vIIt7TBru81qKhs1E5bp13v11lHiAiKRx7h+eLa5xyEZ
x9xsP8DRPuxYEJxRDAuqhM97QyGvJiNZ02HjCH6DUN+5lBBWyIsdpK2rofFlSDjv
kDLuoafJF9Tv4TN4vmPfIkdAtCV5RDn6VjUnKi4fHHGmcN6D4Aa2qqOigBrmZZHz
X1W50b2w+bQv+bdBflNp8mBL9osczQ==
=qkUy
-----END PGP SIGNATURE-----

--5Atr4jAvQFMf4UUB--
