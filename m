Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB4453C761
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jun 2022 11:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243000AbiFCJVr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Jun 2022 05:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242939AbiFCJVq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Jun 2022 05:21:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550663A188
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Jun 2022 02:21:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 36D00CE2331
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Jun 2022 09:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140F1C385A9;
        Fri,  3 Jun 2022 09:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654248101;
        bh=+BMSu80xfVtQxs3ju2bRATIgEZnaiZNX0MR13KrlpwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rpaJqAzghwMOzeNFsLvQ5l4IeriqnHw39YddokDG2HEqmTVdTguFmYIcvZxWPAqG8
         jgjAQUxn0QcqojKlgE5A+fOpQfgkYNo8w/PCHruj7//WucYdWCHLlKwkjPFQJhiWhl
         uflWJnMNGUNUoLs0YcyhVfTNZF7b+sTKss95dV5ogt6a8oaTQ/eT3BV7xfdosI8NxY
         gb+piAfBW1p5JxfsjZr/KNzP9boOA8cWs5ZU2+rDC0JbHmckGCfXfoaCzYZJeB5N8C
         xrX+4OFBAPJDmUSsnssBO7LSIrl7ags7ElF96Evv5BEz3FX4cFQ3HXzc335utshycx
         4FVAm0gqk9dBA==
Date:   Fri, 3 Jun 2022 11:21:39 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/arm64: Fix mismerge of Makefile for fp tests
Message-ID: <YpnSo6QKQqG8k63M@sirena.org.uk>
References: <20220524151454.1487390-1-broonie@kernel.org>
 <YpkS5NXLCxyhN5E9@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T/qAV6hDgzONdBir"
Content-Disposition: inline
In-Reply-To: <YpkS5NXLCxyhN5E9@arm.com>
X-Cookie: May your camel be as swift as the wind.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--T/qAV6hDgzONdBir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 02, 2022 at 08:43:32PM +0100, Catalin Marinas wrote:
> On Tue, May 24, 2022 at 04:14:54PM +0100, Mark Brown wrote:
> > The FP Makefile defines two TEST_PROGS_EXTENDED instead of one of them and one
> > one TEST_GEN_PROGS_EXTENDED for the programs that need compilation. Fix
> > that.

> Do we still need this? The fixed commit already uses
> TEST_GEN_PROGS_EXTENDED and that's what it seems to be in current
> mainline. Unless there was a mismerge in -next (I haven't checked).

Yes, it looks no longer relevant.

--T/qAV6hDgzONdBir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKZ0qIACgkQJNaLcl1U
h9AGdgf/W0kXcGY2f5zaIZ5M0ALbMrjHML5P+MMkVJcYovSTqTBRXsN8DkGQutmn
P9BFaqmB5GxxIPCUu4DaM6reL06F4qaN++2N4CY50Blhgx9SzS+a13jRsL5+U58V
8g4n9xUg8j6bfg3hSfVUy2xGmKJ1tVmksXBqrD2BA5smPedIVswJda8GbtioEv1T
gFgUPJLFBdwFnFu4FtEke7df3uSzNnqYWKiYBZkL4gj9x1O5wcGiLyyezmxwOPQ4
8yg92PUXBnqSqtC5s3idNSwylSOrOdUzn1gfxeRv2SXsEgvXQ5PdJkxi7+mpo5qR
OxK0QP8ZrHf4DF18PSNd2bpDmLcJHw==
=iidz
-----END PGP SIGNATURE-----

--T/qAV6hDgzONdBir--
