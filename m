Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7586775AE4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjGTM1U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 08:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGTM1T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 08:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE1F2118;
        Thu, 20 Jul 2023 05:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABB0F618F6;
        Thu, 20 Jul 2023 12:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6CAC433C8;
        Thu, 20 Jul 2023 12:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689856036;
        bh=rCw+psKLDBdl6kAXIJPY9IcEhZY5IxhHwvg4KUYy27Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BwiRNKVJdr15gmyYf87c5qkAeJKVgK0bUhpYNBH1JoM8PiqO/jE0lKC7Dha56w0BT
         7O/vwi9WBffNUurAE/FZjy7XJUz2CFkFxvVB7vCi6Ru6h6KIU083RJOIryIfENkD1X
         oTENDWIdJqSXUAPOfCcYOIf/NGXgzL/80xC+2m1uOmTieNUgd9F7ACJib/Zssmi7kJ
         h8IWNcPMAhii51lmlhTmMjHATZ9KWJgeQ7ghBT/98FD0E6coqekAxPi+iTbkKn/6IH
         LI7B5Qlh4ewNKw5JkkAM1YGH45chzb7Sy41C856SadZ3c4y6onctYse05VbAblsj7m
         JvR4b6hrEFSTA==
Date:   Thu, 20 Jul 2023 13:27:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64/fpsimd: Ensure SME storage is allocated after
 SVE VL changes
Message-ID: <3ce4fc14-bd43-47e9-aa37-59bb3cd5d051@sirena.org.uk>
References: <20230713-arm64-fix-sve-sme-vl-change-v1-0-129dd8611413@kernel.org>
 <20230713-arm64-fix-sve-sme-vl-change-v1-1-129dd8611413@kernel.org>
 <20230720105235.GD11034@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CyMXBdFoH12etnuE"
Content-Disposition: inline
In-Reply-To: <20230720105235.GD11034@willie-the-truck>
X-Cookie: Ginger snap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--CyMXBdFoH12etnuE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 11:52:36AM +0100, Will Deacon wrote:
> On Thu, Jul 13, 2023 at 09:06:04PM +0100, Mark Brown wrote:

> > Since the ABI does not specify that changing the SVE vector length disturbs
> > SME state, and since SVE code may not be aware of SME code in the process,
> > we shouldn't simply discard any ZA state. Instead immediately reallocate
> > the storage for SVE if SME is active, and disable SME if we change the SVE
> > vector length while there is no SME state active.

> What is the advantage of keep the old behaviour in this case? In other
> words, if it's acceptable to reallocate the state when SME is active, why
> not just reallocate in all cases?

It was minimising the changes to the status quo given how attached
people often are to these things.

--CyMXBdFoH12etnuE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS5KB4ACgkQJNaLcl1U
h9C+0gf/fQxZuh51kIYByTPW3QLeYr1gzvXo8eFWKQxVOYg96BpcLaqbrocw6ZLg
E0VA1/CrGB56VUq99z4VY0JUrqFoupiFJE5M5MihIAUi/0PPH9LsvzvuXuIAnrK4
CmqsOfSQTbsXhntG34dq3UkcK7VZlbK4iSZsaKig3BLtIWHBVJ1WvLpnxEkVu0Mv
+qJM4GDgPeIXRKiMcxT6+Gd96Vza5VFUemOFSO9BGW5XzQE7Ix+NpT99XvE0MtwJ
mTVS7V3g0F+19U08hExwfgrKS1ybUONPOqncDhwLdghsLFFOeW8WI1ttxw26afX8
UO1YvtblScSAt6Aex+N4yBujBbHMaA==
=NOme
-----END PGP SIGNATURE-----

--CyMXBdFoH12etnuE--
