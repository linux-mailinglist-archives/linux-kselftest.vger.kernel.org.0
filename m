Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4F6DDDFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 16:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjDKObe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 10:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjDKObT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 10:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DB246A4;
        Tue, 11 Apr 2023 07:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65FAA61DB6;
        Tue, 11 Apr 2023 14:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21C5C433EF;
        Tue, 11 Apr 2023 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681223475;
        bh=FxshusFhkLSqD8VVFjKAZ0lTKteKhqRO31rZyJhDFaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPi6ss7Cj9TPuKQ+4yhmLMQqjuvGY3aLMiq6Z4PI3hXcK4Uh2EdVZ+C+SMar2lmuk
         O9Yc+71Z0yCO9y39kgnZUz5iSRqjl+tnvvL6/mmjsYm1S4nolpwQyVSfmInlO7+XIZ
         JC2u+EbHSoxYw10i+5OxSMT85dZ5fjx3TeMIuBQL7RuOksnggGIrt3hYgHcSzfDxK1
         hEup2sAqXgZReh5GMSlkNu0tOk5YY62/DL73El/UbwxF7t7D+v6GefFYHIHpZR4aLO
         lMc+fC80ZOxwEvXUsxEFBpwX9YpOkVbocsC3zi2fHAtdJLEkk/cwJyi5uGhGMvcXVd
         ZLX0ceZaLq5ag==
Date:   Tue, 11 Apr 2023 15:31:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     paulmck@kernel.org, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tools/nolibc/stdio: Implement vprintf()
Message-ID: <9dfb88e8-2a61-47a8-876e-581e4c717217@sirena.org.uk>
References: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
 <20230405-kselftest-nolibc-v2-1-2ac2495814b5@kernel.org>
 <ZC8OwUPAC4s413jP@1wt.eu>
 <cbece9a0-b8d0-4f3e-9a55-9fe87e111392@paulmck-laptop>
 <fc52d5c1-61db-b8e3-e608-12434b0ee740@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikaMBnalE2kSmUMA"
Content-Disposition: inline
In-Reply-To: <fc52d5c1-61db-b8e3-e608-12434b0ee740@linuxfoundation.org>
X-Cookie: In the war of wits, he's unarmed.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ikaMBnalE2kSmUMA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 10, 2023 at 12:30:04PM -0600, Shuah Khan wrote:
> On 4/6/23 12:43, Paul E. McKenney wrote:

> > Alternatively, if it would be more convenient for Mark to send this
> > up via kselftest:

> > Acked-by: Paul E. McKenney <paulmck@kernel.org>

> > It currently merges cleanly with the -rcu tree's dev branch, so this
> > should not be a problem.

> > Either way, please let me know, Mark!

> I can take these through kselftest or can go through arm64

> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

It seems like more of a kselftest change than anything else so probably
makes sense for it to go that way?  The example user isn't really even
needed.

--ikaMBnalE2kSmUMA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ1by0ACgkQJNaLcl1U
h9AdOwf/ef2K4FS5NC2X5JFtmHxasft3ExxGAIzwI2FFzmPKRLOJwLctThZFfYIb
2x6bej5BCZ6nQjDUrckEglZ5rRlb/s9VzGELvn3w0RsR0dnPQtYQXfYt4zR2pSVt
OWLN2AznoWmaMCx2FZc5nWgiaTxW32BrBIfaOHfF3nV2mrXO1qbCNzgdbQIkydJf
HN9gZRdKJAfKFHIKIyiQ0Pkng7k2u+9NnyEkSmOSMlUVWCpEHTiYIGO2xh6D4bME
0Nbm+MhRjs0h5okPFnFioyCNey4noUN1zASYmTk+TBMeKIc0GcgRsmzMmOTKESMR
KGetRNC2Sm57xIzbjD5lJNCv3OGIvA==
=YHmn
-----END PGP SIGNATURE-----

--ikaMBnalE2kSmUMA--
