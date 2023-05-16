Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D0C70512B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjEPOpx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 10:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjEPOpv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 10:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE74A30FA;
        Tue, 16 May 2023 07:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 645D5632DD;
        Tue, 16 May 2023 14:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D53C433EF;
        Tue, 16 May 2023 14:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684248345;
        bh=M60Le/hi7ny2xMpvbfBJksM91CYUmDvuLDK42BEt2q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMU5dTStAJZci8Kol5YY/FGWHWlopYVFThWRFtIKPg1Lb+dvCj/1OL3q+TCODHsP2
         1XUMVEXT50a/ftjHniHraG6tM50pj3JOgYs90pHvYa7sOceM4Fs0AvcqGBsg9Jc//Z
         v7hwnNNPbUDoWdzyUCvOTopGnPGvXZ7Yb+NazGz87J6IvQ5807eJZzJfsMo4zLlomf
         pIG9yoMbExH8xXiF8A6S9tVIsmhQCwPgCxc9AZZUjNolmX7ORQD0uWGE4CzY6Jn5VL
         uoTc0VGykGQRFkWmL6Rqs4ZaAQUrb5GhR3jzs/XYq1WZjrhLiQxROL3lh+FWCr5rmy
         JkUrbH/T21xAw==
Date:   Tue, 16 May 2023 23:45:42 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in
 fpsimd_release_task
Message-ID: <ZGOXFjJnSVz3Lss6@finisterre.sirena.org.uk>
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
 <20230516134447.GB30894@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B2Htttz3A3se8jyc"
Content-Disposition: inline
In-Reply-To: <20230516134447.GB30894@willie-the-truck>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--B2Htttz3A3se8jyc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 16, 2023 at 02:44:49PM +0100, Will Deacon wrote:

> Mark -- given that this is an SME allocation, please can you take a look?

I'm on holiday.

> I think the implication of the kfence report is that we're writing beyond
> the end of 'task->thread.sme_state' at some point and corrupting the
> redzone.

> There are two reports here, so hopefully it's not too hard to repro.

I think I *once* saw something that might be this but I've never
reproduced it, and I suspect that if this just suddenly came up with
LKFT in stable kernels when there's been no relevant changes AFAIR it's
not showing up terribly reliably there either.

--B2Htttz3A3se8jyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRjlxQACgkQJNaLcl1U
h9DF4Qf/Z7ilCYT2Cj93mUVCpgT3fU0hapi2LhsW6GtEd9ig8EhpUhsUU66FvDEi
xSutCd+ZA/2Vr1UBOeRCAxrGuD+QLnKA5CcqliPfnip8QUK0arQ6CFx7KpWr1LEM
M2hVfNquXQ1MgiGsUfnXJpFo07As7b/coy37uO1k23MjvneIb2irdkGtMxiTDxfJ
1iCbhDZQt6eXXkcbVhCnaFVvrhtU5DtFd7cPsynQREf+DMeD0jQVlUYsuefkCd5g
RmybWEEE8/ieOo5t5tHCjLcqt4jnswlzNS8PC8gHjDtG5WGR/hhD/4UWqkCwarYi
NeBJvtdpzLf1qKuo81Ywi8YOzQ9fwA==
=o7iP
-----END PGP SIGNATURE-----

--B2Htttz3A3se8jyc--
