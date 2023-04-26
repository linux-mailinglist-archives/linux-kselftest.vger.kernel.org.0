Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55436EF490
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 14:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbjDZMoI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 08:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240507AbjDZMoE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 08:44:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6346583;
        Wed, 26 Apr 2023 05:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2E216364E;
        Wed, 26 Apr 2023 12:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAC4C4339B;
        Wed, 26 Apr 2023 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682512971;
        bh=uieBeTHPw0OyQKwNBxDYcvIw16jfHMMim73G+Vggw2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUaMoeG0VORpZbZ86IjeoKr31XXs/aNKwiacEuMo6eINeHP+VyDLqUQn59LmBn8Pj
         hIi8/k2Bbyz8z9v3MFYqYjcyXmmZVcDaCbqbFoHhqud0xZEDrjS1y3clUNgi1CKidd
         x/pNLmoA2/8M6vLJ2/WBkuMMFWsyrcTnUDAW1AMFiWQ1nkKtT0ayZhOQ3IsEgCykX6
         93n7r1uoiGJHFx/LOCJCLJaec+0tksdche/pvqJHdyFJoVTXyQFMMIrJ/34ihBgTfH
         YVpoL6flPh9beTeLRYSsaCPvo26iNwObtXCzCbjEPtkaWgcIZpagge3460EDjBH7Zh
         /HyoBaOX8VwyQ==
Date:   Wed, 26 Apr 2023 13:42:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: REGMAP_KUNIT must not select REGMAP
Message-ID: <36a8dc3b-50bb-4db8-a7eb-bb69517187da@sirena.org.uk>
References: <a89cb0eae953f534011d3a655fa70feb01fb2b73.1682510075.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wI5iOEwEcWninvPe"
Content-Disposition: inline
In-Reply-To: <a89cb0eae953f534011d3a655fa70feb01fb2b73.1682510075.git.geert@linux-m68k.org>
X-Cookie: Drilling for oil is boring.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--wI5iOEwEcWninvPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2023 at 01:56:44PM +0200, Geert Uytterhoeven wrote:
> Enabling a (modular) test must not silently enable additional kernel
> functionality, as that may increase the attack vector of a product.
>=20
> Fix this by making REGMAP_KUNIT depend on REGMAP instead.

This doesn't work since regmap is a selected library so there's no way
to directly enable regmap other than by enabling something that uses it
and it is very likely that the virtual configurations people often use
with KUnit will not have any physical hardware and therefore will not
need regmap.  It seems a lot more likely that someone would want to run
the tests on a platform that doesn't otherwise use regmap than that
someone would end up building in regmap on a production kernel that
wouldn't otherwise have enabled it.

--wI5iOEwEcWninvPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRJHEUACgkQJNaLcl1U
h9DkMgf+M3R7UaVQ67Gg1Ebklb9FqUD7UYByywsPobp19ufSlH69H3Tn/IJMh1SX
YW/EurCEO7+1RkB0dbbNX38pOwjyCd2XQNLPp7p5moFmDoM9t322JdwLplHkCLe6
t8hQxF068Ax+crAuMBt/UzTpPVADZpqh3EAeeVI0xpa/Yy2ysFPJy/HIaV5G8idy
dcVvkaalbraCgPRnw9mb1WsmRE4st85zVIMia37oRnC+243Rh7l2zsgvb02OsQox
NbFGewieYzlbNtrVjM5Lvl4c4upbeHw5laWgMosf8egATFgUA5tWuPaxaUfK3oie
3G5vqZuHcJe93snOVj4rSHR51puKVg==
=1cSX
-----END PGP SIGNATURE-----

--wI5iOEwEcWninvPe--
