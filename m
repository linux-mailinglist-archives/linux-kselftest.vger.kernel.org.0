Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D54274E117
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 00:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGJWah (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 18:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGJWah (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 18:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289941B7;
        Mon, 10 Jul 2023 15:30:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94FF661234;
        Mon, 10 Jul 2023 22:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1F7C433C8;
        Mon, 10 Jul 2023 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689028235;
        bh=3aYDbMLS8gbBAT0pTmBXom0DR9pequUWpETs0BPTXQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qhd6Qrbc3gLTYfWDfurVXAEwESS0gghpr06Fs+LfCNQZjtvAxYSrBSx+akaMS/tLa
         jBkYR5f9zdYQ+6mEBn0xx+ZL6Y5h1/jeFMUG07IsChPrxNv2tV/mdDw7EZ7KeuFbqv
         Y2X2wzP/rpTu9btpt3P2vcAf4L+L+K2a8QZZscxrxBStCjp6pyLqAvvI9AtOXq/M7a
         FNcyXxxoDWkPPoKeZ1M3MlYcML7ughf3RbhJWYMS4VbCgvgAyfOePQl+3I0k6dI23M
         8hnY+fmk88JUHpKixSXUgnRrYBKiXROimMaL1w6WkmL+XD2M+vpU+jT4/qgR+1MUA9
         68JDxr9cjSuRA==
Date:   Mon, 10 Jul 2023 23:30:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Message-ID: <ZKyGh8AKRLobQKlX@finisterre.sirena.org.uk>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <04a35122-5020-5ad9-7bdc-c17f9a27bf50@nvidia.com>
 <ZKx17G7ULaQox7Xo@finisterre.sirena.org.uk>
 <ec86c0eb-5c6d-48a2-c216-ec4f40710ca1@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A2HdvkGmzCb8nKVk"
Content-Disposition: inline
In-Reply-To: <ec86c0eb-5c6d-48a2-c216-ec4f40710ca1@nvidia.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--A2HdvkGmzCb8nKVk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 02:31:56PM -0700, John Hubbard wrote:
> On 7/10/23 14:20, Mark Brown wrote:

> > There are no such thing as far as I am aware - the arm64 selftests are
> > *very* actively used by a range of people and CI systems, I certainly
> > build them pretty consistently and am aware of no build failures with
> > either GCC or clang.  You do need to install the headers to get the
> > current APIs but until your commit everything was building cleanly.

> > If you are seeing any problems please report them.

> oh wow, yes, I am! It's on a slightly older installation (gcc version
> 8.5.0 20210514 (Red Hat 8.5.0-18)), but there are a lot of basic build
> failures, I'll get them together and send out a note.

There is a floor on binutils version for the kselftests that's more
aggressive than that for the kernel itself, though that looks like RHEL
8 which has binutils 2.30 which *should* be fine for most things - the
MTE tests won't build but they do have version detection so should skip,
I guess you might have trouble with PAC support which doesn't have
detection in the tests?  It's certainly old enough that I'm surprised to
hear someone doing development for anything current with it.

I just tried a Debian based GCC 8 container which seems pretty happy
for arm64, the command was:

make -j16 O=3D/tmp/out INSTALL_PATH=3D/tmp/kselftest \
	ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- \
	CROSS_COMPILE_COMPAT=3Darm-linux-gnueabihf- kselftest-install

(the compat toolchain isn't used here IIRC).  It does skip the MTE tests
but otherwise isn't showing any obvious issues in the arm64 tests.

> Meanwhile, if you would like to try a quick fix, I have one that fixes
> the problem on my system. I'm inclined to dress it up with a comment
> that explains it (with a "TODO: stop using recursive Make here"), and
> send it out as an actual fix:
>=20
> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selft=
ests/arm64/Makefile
> index 9460cbe81bcc..ace8b67fb22d 100644
> --- a/tools/testing/selftests/arm64/Makefile
> +++ b/tools/testing/selftests/arm64/Makefile
> @@ -42,7 +42,7 @@ run_tests: all
>         done
>  # Avoid any output on non arm64 on emit_tests
> -emit_tests: all
> +emit_tests:
>         @for DIR in $(ARM64_SUBTARGETS); do                             \
>                 BUILD_TARGET=3D$(OUTPUT)/$$DIR;                   \
>                 make OUTPUT=3D$$BUILD_TARGET -C $$DIR $@;         \

That does seem to work around the issue at least with a quick out of
tree build, including with GCC 8.

--A2HdvkGmzCb8nKVk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSshoQACgkQJNaLcl1U
h9B72gf/bG4zsdgvPAfpCrtQZigPZ1y8k9YCk4NwudygQJgD5kAsKBt6MPToz9pF
QBoHXzZNbLqsxjsV5dSNXDHFwWBEQYoiivipyWkUmsXgfkXYTi8epoXtgygF4Zfc
9XDlPRaa98CiSTu187MbSxAjaJvLSwHOfs8m0VW80jir0nwaVyOqD2geYbXF7swZ
FBEgemXwQm0u3UqBuXfGKN1uGnX6/XfProIbs9JW/tEF+eMfFEnog7oKPHvFj6XN
LBeAUboWXQy/8kZcSwYEo2xuKZY3wW46a1wGdmOJg0CWzarznI9zjr5g5RRZ5r3d
mAz8dgvlRbrT/OATjy+BKUkVEmkJ4Q==
=RcK3
-----END PGP SIGNATURE-----

--A2HdvkGmzCb8nKVk--
