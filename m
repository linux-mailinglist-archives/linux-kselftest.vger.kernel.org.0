Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8DD70DADD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 May 2023 12:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbjEWKvy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 May 2023 06:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjEWKvk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 May 2023 06:51:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09C6E43;
        Tue, 23 May 2023 03:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 744ED61C63;
        Tue, 23 May 2023 10:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD2DC433D2;
        Tue, 23 May 2023 10:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684838984;
        bh=ZG2CLRp9/Vm9JkeKzPKfnQCU9uZlSunAzgrrZSzYQxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qr9Jhlurzn9rvXMfUKy34vC9G4ad4qTbUmMQwI4yZaY7jsMPcUbKlPUcZHyMYZD0x
         //dy1d+B21cIr6UHeE/cIt+9Ucqi+ucJHzQ/j20Ehmv7gewdb/ET1W0WqGMrCAmpEq
         hWvVVuej26j+f1ttpngy8lycVOcpxlf468YZx46cXYwOWNQZxCwH+b8rP5VOQbNODl
         seyCYRaoBR1nZQE3cu+kIbAyqlrVWEnp5jTZutEHdyhmQSe7cJtm2g044eed8uP6Ez
         VmHROZYQl6SB+lCvsqHMSyeljVTToORrPrZ7fGcFYJD/IsCD5qNMXLbThNgXs5ObyL
         rFrJ8Zp3bdgfg==
Date:   Tue, 23 May 2023 11:49:38 +0100
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
Message-ID: <a174b99c-3b60-410d-b6b3-67e8e792354c@sirena.org.uk>
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
 <20230516134447.GB30894@willie-the-truck>
 <20230522164117.GA6342@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0WyD5qb6h9pTGLPu"
Content-Disposition: inline
In-Reply-To: <20230522164117.GA6342@willie-the-truck>
X-Cookie: Beware of low-flying butterflies.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--0WyD5qb6h9pTGLPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 22, 2023 at 05:41:17PM +0100, Will Deacon wrote:
> On Tue, May 16, 2023 at 02:44:49PM +0100, Will Deacon wrote:
> > On Tue, May 16, 2023 at 11:58:40AM +0530, Naresh Kamboju wrote:

> > > Following kernel BUG noticed while running selftests arm64 fp-stress
> > > running stable rc kernel versions 6.1.29-rc1 and 6.3.3-rc1.

> > Is there a known-good build so that we could attempt a bisection?

> FWIW, I've been trying (and failing) all day to reproduce this in QEMU.
> I matched the same VL configuration as you have in the fastmodel and
> tried enabling additional memory debugging options too, but I'm yet to
> see a kfence splat (or any other splat fwiw).

> How often do you see this?

As I said in another mail I've also been unable to reproduce this.  FWIW
I *suspect* that it might need to be run in the context of a full
kselftest run to manifest rather than just running fp-stress in
isolation, that's mostly a guess but given that the kfence trap appeared
to be happening on free at a point where the test program shouldn't be
exiting any tasks and should not be changing vector lengths on tasks
that have used either of the vector extensions.

--0WyD5qb6h9pTGLPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRsmkIACgkQJNaLcl1U
h9BhWAgAgmrfoTxlzsDDX+RDl6E01tBdBvmcEH5N6AgAWSJaMNjla/SYW31Pgos0
ArDjoqjfyIskP+UZ6T5UXrKxOe1rSaN6fwOovNCiyE+FIZ28Ml6cfp96YM/ElXGH
DrjHKAelYRTaZndLBq5aNmDGO1A6Fz2w4t0Y/5vUnF6X4dWKo/8udixbbMNPe551
NWehZoHz9eFNFPop3UDJKQPjZDDA0/LP6yBoAhsSN2ySzt1SuQBrO+NxpHqOA3ZD
KM5BVVJq51ZQ9FNR8TbylrB7lWkHoR9fDXnM6ukbCNy+giOa1lvDJyDHxMiKxQ6b
hBi7UdqunNL69HmnoS8jKoS0r0CBEQ==
=RfVs
-----END PGP SIGNATURE-----

--0WyD5qb6h9pTGLPu--
