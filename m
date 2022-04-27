Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFC4511D0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbiD0RyC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 13:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244427AbiD0Rxs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 13:53:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C91C5C859
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 10:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3911061EA4
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 17:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17561C385A7;
        Wed, 27 Apr 2022 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651081835;
        bh=6jY1jtyxgrTCbFu7kz//RW1qAIrxkRaSXDG7YBuiiTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2MjAfvDvCHdhOcFLlJFcjevC2mMB1CezOdJ761C60oRGpygidHKX89//cbIWuWf7
         5JUaZsLmsFm0kXtehoTZHR91Z06k1dq2yGm7CEtCxMruRfOTKGJyJfcPY3GA0nvis7
         XLqGnPE7NH+YxHxoYCYmM4qN3DsiF/R9IdaheG2TP63ZIj4Oy3N53rvpphond0oD0K
         4nZIGDt3DSrmg1PUqbZhYgo2m9J8wT3MlQbfh3yV0apW66RooZNDmXBDdWyT/tr0kO
         6CdkEmWuXvPDIUPjk4FnqFYUeIM6ItgMCQwcwVpS/p5/1BooQPBc2tcKUnooH+FbEn
         YbS2EF+lkJp+Q==
Date:   Wed, 27 Apr 2022 18:50:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/4] selftests/arm64: Fix O= builds for the FP
 selftests
Message-ID: <YmmCZrCWqBz+jhn4@sirena.org.uk>
References: <20220419200442.1374548-1-broonie@kernel.org>
 <Yml+s1MzY7HC81U4@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rt+xvKj9z2y2aKN7"
Content-Disposition: inline
In-Reply-To: <Yml+s1MzY7HC81U4@arm.com>
X-Cookie: Buckle up!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--Rt+xvKj9z2y2aKN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 27, 2022 at 06:34:43PM +0100, Catalin Marinas wrote:

> Would you mind rebasing them on top of the arm64 for-next/kselftest
> branch? I get some conflicts with the SME patches that went in there (or
> I can sort the conflicts out sometime tomorrow/Friday).

Sure.  BTW note that the kselftest branch doesn't build since it doesn't
include the SME branch so the test programs for the SME ABI haven't got
a bunch of defintions that they're relying on.

--Rt+xvKj9z2y2aKN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJpgmUACgkQJNaLcl1U
h9B7Agf/dEGarXIc2eFzWM8aRhjEPQZubPuaWxpi0nYUjZKIxngHMjriUDb4fo4x
fhLV4ZNRpKgR+Vpcr9O0+KCtJa/qB6E6z8WLpT1ClkeB1GXv2HlWIQYsoeJwr702
DUFE3DJSXlgxD+NJlziUmtN9Oc9N5y1Ir0hxznqFCThaLOGS2i9KQSNWEHSiCf4d
g1Q4ARUAMq+F0Fru4SxIVSYZ9USs8h0V8t4PbSFYu1JnupWAO0j1qg56GAgTe6gN
ymUe0x5Pt6ag1FJvmx8Q/nJAEeglIYu1UqMzis09ELqXzFO9cy/LDAnYUadQ7c3G
vmJH9YrSHjs6hC9E/cI9WKG2Vtif3g==
=pHQo
-----END PGP SIGNATURE-----

--Rt+xvKj9z2y2aKN7--
