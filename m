Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71C57658C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 18:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjG0Qcs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 12:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjG0Qcq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 12:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563D43594
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 09:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B006A61EDF
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 16:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA48C433CA;
        Thu, 27 Jul 2023 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690475463;
        bh=DwcP8LV8fiqUHHv7LsduOc+7hZGPGbhziQoDwwtOeps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ld/T1ziMWu2rAk1yV7vNMHkFUotVv5HU9wqF2EfwtAK088a5+Qa3VNpbSMQAIeRt1
         cypimZ2A7ODHqSZenQx5RlcvTuu3K78pf1Z8080ItT0y2zubER9LWl0p3iJFxRsm29
         5HZis173NPTBelAzeLl4CKedzAno1iObEfRPY5RMgn3WDeR4VJP7lFjq9iC4hOjxua
         n0enKPKK+247upr8VwWfQY2Sxss0mkKCobQmQ4jSB3wL6noavWo6JCrBWVRcqMXHgV
         emEhfKQCRbjytUjAzvti3AA2UYtqMX8FkvnmhMIllob35CXbkJhGOuHmEIj2kzTn5k
         hixImu65VfRIQ==
Date:   Thu, 27 Jul 2023 17:30:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] kselftest/arm64: Exit streaming mode after collecting
 signal context
Message-ID: <8602583c-e6f5-4382-b597-4266747825a6@sirena.org.uk>
References: <20230720-arm64-signal-memcpy-fix-v3-1-08aed2385d68@kernel.org>
 <20230727155009.GA20050@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6aM4cY8c7DuxFqWs"
Content-Disposition: inline
In-Reply-To: <20230727155009.GA20050@willie-the-truck>
X-Cookie: Go 'way!  You're bothering me!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--6aM4cY8c7DuxFqWs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 04:50:10PM +0100, Will Deacon wrote:

> Looking more closely at this, I see that the bpf and kvm selftests are
> able to include <linux/compiler.h> directly, so I don't see why we need
> to open-code this here. I also spotted that we've *already* written our
> own version of this as the 'curse()' macro in selftests/arm64/bti/compile=
r.h!

> So I think we should either use linux/compiler.h or make our curse macro
> usable to all the arm64 selftests.

Ah, actually it's not including the linux/compiler.h you might be
thinking of - it's including an entirely unrelated linux/compiler.h
which can be found in tools/include and contains a much smaller set of
things.  We can port the macro over and try to do the dance to pull in
the tools/include headers, hopefully that's not too fragile with the
various combinations of build options and the additional complexity of=20
the arm64 tests having an additional layer of directories.

I'd be happier doing this as a fix and then touching the build system in
-next (I've got the build system changes now).  It should be fine but
the build system has changed over time and is prone to fragility - I
can see people wanting to pull the fix back to whatever kernel distros
are using and running into trouble with a more invasive change.

I was going to mention that kselftest had to define it's own
ARRAY_SIZE()...

--6aM4cY8c7DuxFqWs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTCm8EACgkQJNaLcl1U
h9DGywf/QArxmolEwP9zEMarW6gk4tJ2MU7DANp34a3EE+gtsNvt64nQS5ra5jwI
Skrc5HgFVW7b9W/H8CUTx9kB8FyNzje19UQAO6NvoQin7xT+xi0o+NxYRWGnf3qo
oTIVY1KpVuUDE9azleiS5NfJbece0x0NXjtUyy/ZTivHvIOICyL2L4eBsCP19Lk9
UvWXjd+MXJBKsXGKRdAyMF6c1TLAy8RLYogqkEWsjusNCgLNP0oHVkOv27dvDHdL
Ym59EhCoy1AuVz0Utm6RG1AQE213oZU5U0Sa03AdErpzZjN3tDkUBH7n7ctAiM1n
mf7pzpLyGR5UfpkkSrr7MHhaYdu+5w==
=GIZR
-----END PGP SIGNATURE-----

--6aM4cY8c7DuxFqWs--
