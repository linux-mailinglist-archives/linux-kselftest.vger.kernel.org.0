Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC8F732193
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 23:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjFOVWf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 17:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjFOVWe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 17:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E15B1FC2;
        Thu, 15 Jun 2023 14:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF1ED61701;
        Thu, 15 Jun 2023 21:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBDDC433C0;
        Thu, 15 Jun 2023 21:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686864152;
        bh=y/syxi6LWP54++e8nMldw1VX9hibKkby5BGKloVYLrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IcqAlPJw9XWxkaZLMRGSNqtnoiR4fsrGZv6jcypOhBYarWrXPgTaGPjCpj4jflM3X
         5T4gygQLv96lTjkshE2eUvclVPeDj4TmB2f2zvvLtzSymKPHaY638HVLSvMlwso+n5
         A6AcdVxMuRdRjNugoUpvrs4XzgeqBVAr7d2dsTe/yUDwLb20aSwPaWH3fY0aDfylZJ
         /2ivpZ5exOFBJpUVdoG1ns2AO1VX/QiT3VZ4kQk4GayQi39jGrv5VUoYr+Sl2GOVP/
         uo+HFe3YZHkhI72hubzV6HlaanbNlM2mOSn0rmQCFWoVP+HmbBqbTyPPcXRWJHdL6+
         fdXP+CEIVLVSA==
Date:   Thu, 15 Jun 2023 22:22:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/mm: Fix cross compilation with LLVM
Message-ID: <d7e56d51-e492-473f-992e-7f8a00527df4@sirena.org.uk>
References: <20230614-kselftest-mm-llvm-v1-1-180523f277d3@kernel.org>
 <CAKwvOdk0sPi95TSdbyEKXud68nHq_7=ccDwaCkVsyd54ArRC=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DQwDQ9qhsp4E6wdO"
Content-Disposition: inline
In-Reply-To: <CAKwvOdk0sPi95TSdbyEKXud68nHq_7=ccDwaCkVsyd54ArRC=A@mail.gmail.com>
X-Cookie: You are false data.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--DQwDQ9qhsp4E6wdO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 05:01:56PM -0400, Nick Desaulniers wrote:

> Broonie,
> Thanks for the patch! What's the best way to test this?
>=20
> $ ARCH=3Darm64 make LLVM=3D1 -j128 -C tools/testing/selfte
> sts/mm/

> Is what I would have guessed, but I get errors with or without this patch.

make ARCH=3Darm64 LLVM=3D1 -C tools/testing/mm TARGETS=3Dmm

> Also, fwiw, b4 shows that you don't have a pgp key setup for
> broonie@kernel.org; I don't think it matters, but maybe it's a
> surprise to you if you thought you had set that up,
> $ b4 shazam https://lore.kernel.org/llvm/20230614-kselftest-mm-llvm-v1-1-=
180523f277d3@kernel.org/
> ...
>   =E2=9C=97 No key: openpgp/broonie@kernel.org

That's an issue on your/b4's end, my key has had an ID on it for
broonie@kernel.org for years (looks like back to 2011).  You probably
just don't have a copy of the key locally at all, the keyserver networks
are pretty borked.  keyring.debian.org should work.

--DQwDQ9qhsp4E6wdO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSLgREACgkQJNaLcl1U
h9Aegwf+M33q922PSuwTh70lmU3iTvRAvHn/rXFTNDvfMAyQXcGIfvSlRpKCxZYb
/MhPP9mL4ttUXXMDVrZcahPOHDHwUE35QvyZ+4gaVQr7LLR70N1jr3ppLDl9lEMZ
x8umg63XnuV4rozuZFmjshQC5l4Ph3BskGTS2TtHz3wa1Voa87VCRJ8S0v3zaPjW
HGqLONB9ssipYHX2YjDWibRcjpTY1qyLA/lnixYJlre345uXdhX2DVfuaVgJ50La
opPmDecHuMHLFq1Mw+Lp9NOtQeQIyQbi0zUpPbdvFKD2FI5aHp5Pqiy5CUb9iMAL
Jb412IsCWhMhm7YEaGabl+1spBBBeQ==
=cvFy
-----END PGP SIGNATURE-----

--DQwDQ9qhsp4E6wdO--
