Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346D770DA80
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 May 2023 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjEWK2X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 May 2023 06:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbjEWK2X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 May 2023 06:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B802129;
        Tue, 23 May 2023 03:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BA8460FB8;
        Tue, 23 May 2023 10:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419C7C433D2;
        Tue, 23 May 2023 10:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684837700;
        bh=rEtWtzgud+dO4P7xKWlT7z3oMQmShxLx4UZLon9bI8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itC55Fb3VuqSwZMKKdERBjnsvn4Pl3mwXDIyQVMQ5ZdClxgMM2XYDfxPQNmHwVeOA
         k8MwbLW9WlO41YUIrtYXkTHHpDUOERpa8kOp1EiqEu7ABatoOhX1CBBzkSQpunmXX+
         yZJujZPRclL+9Sb4lpuYgynCwOXHpFzcWYtbgs+5X7uZBc5WBFqzg59IAcxS4U7xdT
         keKGS8IcCOVkOeS/LHHd5b+H+PJYTYYtuw5GJmbn/yslH+GCWk942e2coAv7zddNxR
         Dxwrg7qTwgKYbcgtNTqUZCpiC+xqXhdI/De+Yt7+AL8W5QKhCoLy/Ot8JfjQ413XEL
         YkgYpYhdwqFog==
Date:   Tue, 23 May 2023 11:28:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in
 fpsimd_release_task
Message-ID: <99c3fac1-e964-4cf6-ba14-58de305aa37d@sirena.org.uk>
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
 <2d9a04d8-c09e-49aa-95eb-32b4679f7eba@kili.mountain>
 <ZGWE36pSRMsIHCCa@finisterre.sirena.org.uk>
 <43d53046-f8d9-4c4a-90ba-709910a13f97@kili.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tUbDFipGxi8zU7ey"
Content-Disposition: inline
In-Reply-To: <43d53046-f8d9-4c4a-90ba-709910a13f97@kili.mountain>
X-Cookie: Beware of low-flying butterflies.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--tUbDFipGxi8zU7ey
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 22, 2023 at 06:40:59PM +0300, Dan Carpenter wrote:
> On Thu, May 18, 2023 at 10:52:31AM +0900, Mark Brown wrote:

> > > When we call sme_alloc() it will say the buffer is already allocated
> > > and just zero out what we need for "vl", but the existing buffer is too
> > > small.

> > If we are setting the SVE vector length we do not need to reallocate the
> > SME state since the size of the data stored in the sme_state buffer is
> > influenced only by the SME vector length, not the SVE vector length.  We
> > unconditionally free the SVE state (causing it to be reallocated when
> > needed) since the size needed for it depends on both vector lengths.

> arch/arm64/kernel/fpsimd.c
>    909          /*
>    910           * Force reallocation of task SVE and SME state to the correct
>    911           * size on next use:
>    912           */
>    913          sve_free(task);

> Sure, this forces a reallocation.  But what prevents it from happening
> before we reach the task_set_vl() line?

Reallocation is either triggered by a trap from userspace or via ptrace,
as is a vector length configuration.  The two cases should already be
prevented from running simultaneously, and can't simultaneously perform
two actions.

--tUbDFipGxi8zU7ey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRslT4ACgkQJNaLcl1U
h9A16Af8DEHdwYbxzAGJWh0art8EcInVylPkg10slrjsYkGzxsElEhGfBJadP853
Q8eenp8r+T1Mp8y1gxa5C6kzU+Zgv3k8QkaOuZ6WJoXuH5iB57pHeRiakeaXyEqF
RGze2TlhPN5ztgkNxllH4arDKvzxrPr/r3DuZRYOLTDLiEvCbVeZ4ev43K8Fu12x
X5vhL+s0ZAHTIzN/SLwLW2LMF3fBSbYg/zBBcuLFy7aaGtQpNvAKD3g1YpdoQnIR
nvciW+LV1Oi0/gW3Pl/1bG8PxBFDhAHVj50DDuWpo2oQ7qKVxQXnnj1ogS6FCpa6
rnW5/mie6Z3vvMnDnFexfq5+dM7nGg==
=y/eH
-----END PGP SIGNATURE-----

--tUbDFipGxi8zU7ey--
