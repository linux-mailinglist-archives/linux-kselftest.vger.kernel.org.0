Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E804798676
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 13:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbjIHLcM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 07:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjIHLcM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 07:32:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A4E1BE7;
        Fri,  8 Sep 2023 04:32:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB75C433C7;
        Fri,  8 Sep 2023 11:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694172727;
        bh=+qSIAZksfKxDM/K85aG0fWiH6N2GKiCNwUA/WSqTZio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4zD/CpdQFgwV7gECTT9oQX3RilGXHsKGHp4eSAphDPntlF+8y+AWJSrzNcexlCkS
         2Tdq2k3dej7StV8+vAIWe9diWz3T4dY0zt+p9FqPT79SfWhOxZtJUFuAA3isA3C+yi
         8Bn7XGF04uyAN55OPDuNpuX4G/ZI7bSgWo3UqYLexkV+GAS5PaySlDLFjmVfq+K1e1
         eXtoKf0rkhyiF0hEunah6lqhqrlXK/xl+fqIfRBmVt+kucq0Dnq1TvRZuHgKvCajoa
         R5ojpaJ/6X2uf0OVqBjI9t660JztcY+wRc4eRvjXKyBER8vtlfeWLA3Wrm27XlMHmQ
         Bgv3aOGbkco8w==
Date:   Fri, 8 Sep 2023 12:32:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     perex@perex.cz, tiwai@suse.com, shuah@kernel.org,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ALSA: remove unused variables
Message-ID: <c71fbf31-5c1f-47f0-9e71-a2e35cac2d3a@sirena.org.uk>
References: <20230908081040.197243-1-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Br3Il55jz3CmY9Rg"
Content-Disposition: inline
In-Reply-To: <20230908081040.197243-1-dingxiang@cmss.chinamobile.com>
X-Cookie: My EARS are GONE!!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--Br3Il55jz3CmY9Rg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 08, 2023 at 04:10:40PM +0800, Ding Xiang wrote:
> These variables are never referenced in the code, just remove them.

Reviewed-by: Mark Brown <broonie@kernel.org>

--Br3Il55jz3CmY9Rg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT7BjEACgkQJNaLcl1U
h9AmEwf6Agw2NIcZRz7UbcGNYFEgM1Sa6znuAsY7bjEVL3M4aCkORUTZPRDm26/0
KzxAld/MoA7pWfH5tj3/9My3yHgwrd3VRXmHpSCwRAh3AWeGDb3wne6/P82GsLCo
FxnpAvCHLL4YZ31eJ3oKAWNRWyMFsbOq1eZTsv6ijOifNhl9iKgrurLM2355V9ed
/K8t3+8afSesYyh9mMti3uZRsPhFZOlSoX0Zhcus1BhKAuwiax/6Wv2QBek1Vbbh
wl00Sky9Z7F3jW6zgnNqyRqSRhnu/YK2VDjYbmguHq1rc3BI/7O+I4kak8cS8MKo
PYTWhO7gdy1E8noxD/PxcLVIccnWTg==
=95/n
-----END PGP SIGNATURE-----

--Br3Il55jz3CmY9Rg--
