Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3C17992AA
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 01:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbjIHXIe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 19:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjIHXIb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 19:08:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F791FE5;
        Fri,  8 Sep 2023 16:08:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BB2C433C9;
        Fri,  8 Sep 2023 23:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694214507;
        bh=salNxs9lLXGL2pFylW72b0vqlDDT0L/9nFvYDSD1rbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8RRs1uHRBIPCSTgHYjQtew/XHYwhLMbUDo9UgQCZZo4Iv+G749bzuWbRhOSCfZWs
         vTgCcTxEILQTlnhn+v/7D+m+21hTND3K4hCQEIis9xxqUs+/+TSLtfdcyrAMQR8QvC
         p4MOqgPKvYAZxSbAPBvnfveCl2jjCsYfjaLPHBACeKVN7oBdkG2btDt1gTC/W9Pcsc
         jLEhhB2k6Q2dwNSjWgwOClW10q80c+PFz68ZqpNrbWi+1CH+Dm0+zNzp6pBrsEz4p8
         kLX9ttCPsV9qZReNG+0ipRr4Lh75Jqjzh6/0iZkSWksXQFLSUYiguoO/OkL9OvhC77
         +kkmLFojF97ag==
Date:   Sat, 9 Sep 2023 00:08:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Takashi Iwai <tiwai@suse.com>, kernel@collabora.com,
        Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Mark test plan as skipped when no cards
 are available
Message-ID: <0fa0901e-d271-438d-bc2b-11399ad3b07c@sirena.org.uk>
References: <20230908181242.95714-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gtB/MfxvGH0d09GU"
Content-Disposition: inline
In-Reply-To: <20230908181242.95714-1-nfraprado@collabora.com>
X-Cookie: My EARS are GONE!!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--gtB/MfxvGH0d09GU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 02:12:40PM -0400, N=EDcolas F. R. A. Prado wrote:
> When no soundcards are available, it won't be possible to run any tests.
> Currently, when this happens, in both pcm-test and mixer-test, 0
> tests are reported, and the pass exit code is returned. Instead, call
> ksft_exit_skip() so that the whole test plan is marked as skipped in the
> KTAP output and it exits with the skip exit code.

Why?

--gtB/MfxvGH0d09GU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT7qWUACgkQJNaLcl1U
h9CVNgf/bknC546PS9Qi9kytQmrmnRIck4p3/Yv2zeKVVypqZ+T9VGGd45Z5yOtF
lRcilGo976cR1/xT4LFNuDyrUIM9d3fqf5HSQ0RT5UlYnJ1YExjD5DZvdZsqRr9C
79g6q2UjiLMqarkMkiML1b3+w5pgJqPp5gpHtMuFl/aTWO1js0SXiJYEvnm7g8p1
gjApPBitF8CVuS9XzqR0caAPUBkJSfRqWfVJYNQXnuF9+/bzZa+qChKjOxZ7GMY1
328IIC47xB/5Yu8N672MYqwmtN4PF0lxXGH8l0/5SC4NHAs36XK+Kdwr5hE5nzwo
q4w0VkZAwxSF3wCCH1LNKkGnVDmXeQ==
=Shz6
-----END PGP SIGNATURE-----

--gtB/MfxvGH0d09GU--
