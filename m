Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED825200F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 17:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbiEIPWs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbiEIPWs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 11:22:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543C322781F
        for <linux-kselftest@vger.kernel.org>; Mon,  9 May 2022 08:18:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E47D26111E
        for <linux-kselftest@vger.kernel.org>; Mon,  9 May 2022 15:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E1AC385AF;
        Mon,  9 May 2022 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652109533;
        bh=IrCql5Cwme6q8VK3tMeQU4jWLhTD/nRPyRwhwJbycUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=riLTEBZwRiXZ6yEKbqud1BAN/eTcE/oU44LDoG3w+Kgwd/K8B/ylJHcQ0TQrnVqDI
         DbbPmwPKr80TNBUe95cWNZVXmeUZQk0nuYJOZmpHdIm/d5udQZcrNp04WY6XEDjwGm
         GJ7mtaa3MMbuD3nZCQp1A2DYsRVoi6+6zAOvQ6gzKI4/nLVHGMuc2Q0ykwkMTCm6EV
         OnM1vIoExOLSOjFuTzf8Ugjfk+/nCd8HOvP4vlq4xTdpU9ZrOKjdSSdDC1oq4XWyiC
         BrF03Son7McGr363lY8V1gUuAFyj3bLHJ7KoTEl1BBPGPL2aSR8GSnfTT8RKIzd8/H
         FDI8D50rG78cw==
Date:   Mon, 9 May 2022 16:18:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [ARM64] status of MTE selftests?
Message-ID: <Ynkw2I4IlNEvyhRY@sirena.org.uk>
References: <87wney4svy.fsf@redhat.com>
 <YnVNADyaft0WkNHu@sirena.org.uk>
 <87levb3u1s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NQKsEA3PHP36D90h"
Content-Disposition: inline
In-Reply-To: <87levb3u1s.fsf@redhat.com>
X-Cookie: Boycott meat -- suck your thumb.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--NQKsEA3PHP36D90h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 09, 2022 at 11:59:59AM +0200, Cornelia Huck wrote:
> On Fri, May 06 2022, Mark Brown <broonie@kernel.org> wrote:

> > I would expect them to work, they seemed happy when I was doing
> > the async mode support IIRC and a quick spin with -next in qemu
> > everything seems fine, I'm travelling so don't have the
> > environment for models to hand right now.

> Thanks; I think that points to some setup/config problem on my side,
> then :/ (I ran the selftests under QEMU's tcg emulation, and while it
> looks better, I still get timeouts for check_gcr_el1_cswitch and
> check_user_mem.)

That might just be an actual timeout depending on the preformance of
the host system.

> >> where $AXF contains a kernel at v5.18-rc5-16-g107c948d1d3e[2] and an
> >> initrd built by mbuto[3] from that level with a slightly tweaked "kselftests"
> >> profile (adding /dev/shm).

> > What are you using for EL3 with the model?  Both TF-A and
> > boot-wrapper are in regular use, TF-A gets *way* more testing
> > than boot-wrapper which is mostly used by individual developers.

> I'm building the .axf via boot-wrapper-aarch64 (enabling psci and gicv3,
> if that matters.) Didn't try to make use of TF-A yet beyond the dtb (I'm
> still in the process of getting familiar with the arm64 world, so I'm
> currently starting out with the setups that others had shared with me.)

I'm now back with the models and it turns out that while qemu is happy I
can reproduce what you're seeing with the model, at least as far back as
v5.15 which suggests it's likely to be more operator error than a bug.
Trying to figure it out now.

--NQKsEA3PHP36D90h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ5MNcACgkQJNaLcl1U
h9CUggf+JPz111098/bBtIoV55QfHAac/0s96YdFz1jtq91mSvxMv2IetAm1I3AQ
aRRDAH5/E7ANwE9bsk+dkhZzPStsW6pxUi7yeC4GPoUmqsPY22cnM3m/++6qVnjB
DfW+ysa+rF2B738Q45X7Nyo3kOaYLjEw0b8pmcFW0EMl+X36030vPZRqH2CkZtnC
CygWNp5frQkpJ72hAoV0rxYkL3r38S33F9j6PJUelobQgArLKU18yDxULXS6mLIe
uxiWTacVVgEd712qbr4HcF6MugSwF/5ZD6mZv6UwmwJGc/oHlhHOO+C90DFYA/FZ
tMfIe2RLv5NNrpLnGL+0x7+bxQcWcA==
=vhbT
-----END PGP SIGNATURE-----

--NQKsEA3PHP36D90h--
