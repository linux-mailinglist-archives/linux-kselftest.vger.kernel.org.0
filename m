Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF0F7524E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 16:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjGMOQy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 10:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjGMOQe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 10:16:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C721A273F;
        Thu, 13 Jul 2023 07:16:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5581461544;
        Thu, 13 Jul 2023 14:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCFCC433C7;
        Thu, 13 Jul 2023 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689257789;
        bh=yZj473BZjtFSxSSsUfNJOsl16FRhfrBduETWUEIiqRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6kQQaL5l5mVf9mwXlHAIk/+VY6NLdr4m2fJ0+HN6mUufSihhFaagXQLvrhA3DXuN
         7hMCp77mjxX25DiPIrLzOuIkbCeWzUxcvEtBz3zNU5RBb9e1KBe37xwre9ZVKe5sL9
         OMHt5vui6ay1Yo9nojBcJbHtvUJO+xIIDnDBvBsncLNgEe85tGpN4Q2Xh7v5ESpcsj
         ZJL4l7CpxcjdoFDhDxeR+FWHJ0FsWF/JoZjXcyIHlMCz+qLUjCrspFwbU7f2Yo9wos
         DJsD2I0KhOQkY4lGz1txyViogH3hhmU9w170l6m5WcvMlTLr/KtFgZPXFKuCrd5FWf
         JJPMZdi+gBBJw==
Date:   Thu, 13 Jul 2023 15:16:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 1/9] selftests: Line buffer test program's stdout
Message-ID: <8a8d077c-55bd-4710-9dfd-1cbb1a9170a8@sirena.org.uk>
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-2-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1+oRuEmNeKIqQtgT"
Content-Disposition: inline
In-Reply-To: <20230713135440.3651409-2-ryan.roberts@arm.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--1+oRuEmNeKIqQtgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 02:54:32PM +0100, Ryan Roberts wrote:
> The selftests runner pipes the test program's stdout to tap_prefix. The
> presence of the pipe means that the test program sets its stdout to be
> fully buffered (as aposed to line buffered when directly connected to
> the terminal). The block buffering means that there is often content in
> the buffer at fork() time, which causes the output to end up duplicated.
> This was causing problems for mm:cow where test results were duplicated
> 20-30x.
>=20
> Solve this by using `stdbuf`, when available to force the test program
> to use line buffered mode. This means previously printf'ed results are
> flushed out of the program before any fork().

This is going to be useful in general since not all selftests use the
kselftest helpers but it'd probably also be good to make
ksft_print_header() also make the output unbuffered so that if setbuf
isn't installed on the target system or the tests are run standalone we
don't run into issues there.  Even if the test isn't corrupting data
having things unbuffered is going to be good for making sure we don't
drop any output if the test dies.

> +		if [ -x /usr/bin/stdbuf ]; then
> +			stdbuf=3D"/usr/bin/stdbuf --output=3DL "
> +		fi

Might be more robust to use type -p to find stdbuf in case it's in /bin
or something?

--1+oRuEmNeKIqQtgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSwBzcACgkQJNaLcl1U
h9AB3Qf+LhTlPox4ghR+y8/9Tm4CFlMNRleBzmfEDcafaj6y1aFYXP9Lla5vs6HT
DziBkUJB3jmvW7gNDYMT0xrVxHampqA52kjYLlg6Z/dRFHttU+pxZ5cHIRvZDEfn
vfsHkr0nUGx94gRLvJTdAUR2Q31EraO7h7jwL1Q3TJuE19VhzQcc4SVif8D8I+Ul
JNUu9UusPMcfJVUX5NTWFQsxovITYR2RFlY4PpPMn7zmtiRTzaJrybA6reF0JYSs
HDXcmwF7t2DZWpJIyYoNYmAxDOdODMynYs0NBKPftSti5Bnxb1MH9qkN1BEj82rO
sveDxDVGKTNkb4HhNhzYzf8bb3tunQ==
=hm+s
-----END PGP SIGNATURE-----

--1+oRuEmNeKIqQtgT--
