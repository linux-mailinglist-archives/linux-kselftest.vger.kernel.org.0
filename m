Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B211151196C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiD0M6c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 08:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiD0M6c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 08:58:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5CEDFAD
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 05:55:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC4B5B8268B
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 12:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B3AC385A7;
        Wed, 27 Apr 2022 12:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651064118;
        bh=ik025cWnUzwdoaHADK+8h2P9IwsEUWm7IYWCYLZ3Jmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+i0/1kDtoLN4lXDDBShq+2y/9AjkB2EDS2HGL59B2GVbZVSHFLMFI2iTGmhB55Pm
         G2qJ7eRlYss/3N16yNlEjyQHtH6m5Xn2Gg+bkgFFm130OzwdDYUgXYEN3vS111WcxV
         RunHMvRYgf2B+/9ehX3uFKa0N3fWlJT2Y01yHeYuZeXv87rIMA6mNC+B0r+NdXuSGa
         F6gJ/XrReTvS+1IYdxynJ/UwVynkvISIfRmoZDttysELDFY8p3EIdnzIjMdAh1N0wL
         twIYyIoL72QOiOO74U0gIxogwtz6FS/osi9ScCyYjCYuIc4gqzYYxztSpYI5tebGsm
         YlXq5skDtDSwg==
Date:   Wed, 27 Apr 2022 13:55:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v14 27/39] arm64/sme: Provide Kconfig for SME
Message-ID: <Ymk9L2TwsjLSRj6g@sirena.org.uk>
References: <20220419112247.711548-1-broonie@kernel.org>
 <20220419112247.711548-28-broonie@kernel.org>
 <CGME20220426221433eucas1p253f6350eacf87d8cac2c05adc903656e@eucas1p2.samsung.com>
 <64573cca-4bd6-a65e-0ba2-867c6488e82c@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2+6n7qNJEoo8AZc1"
Content-Disposition: inline
In-Reply-To: <64573cca-4bd6-a65e-0ba2-867c6488e82c@samsung.com>
X-Cookie: Buckle up!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--2+6n7qNJEoo8AZc1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2022 at 12:14:32AM +0200, Marek Szyprowski wrote:

> This patchset landed in linux next-20220426. By default SME is enabled=20
> and it breaks CPU hot-plug on all my arm64 test systems. Bisect points=20
> this patch, because it finally enables this feature. Here is a report=20
> from QEMU's arm64 virt machine:

This is the cpucaps infrastructure not being able to cope with FA64
since it's in a register which is only there if the base SME feature is
there.  It works during boot because we have custom code for walking
through the registers there, and it works for the hwcaps for both SVE
and SME because at first look we don't seem to recheck them for
secondaries.

--2+6n7qNJEoo8AZc1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJpPS4ACgkQJNaLcl1U
h9Cm/gf/XectKTe1EPTDGmPeHt7Fg7pjBk2H/X3bRTO4VmKCmI1P6wPHSWH4Ptuz
iSzT5q3m/XwjpS5B1z9ENjQ5NQ6zC3fMlxM1qHfP+qZsmpob4YCHQldLcz2csfSU
d93ZoESxuheQ0+NGOXdhu9cl2vudTkiDeoqlJZca33anZj8+wi+eIefciDrnJ9fk
/QfoA1uIBhxeqvSo2EEvi3FP1RmxioztTOFI+XH9TqRmy2jx40kfXMcb6qqUQfc0
GZkEqViat/I/x/f6yUQ6oIhR+q1t85gc+jQz9dkb8TyHI6NgTR3ySIekdezwCgSW
2G8Eee5LXK21k5wIOM0WkIeFSE/iGA==
=MFEc
-----END PGP SIGNATURE-----

--2+6n7qNJEoo8AZc1--
