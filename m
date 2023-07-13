Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92FA752790
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjGMPnq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 11:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjGMPnp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 11:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532C62710;
        Thu, 13 Jul 2023 08:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D830761A05;
        Thu, 13 Jul 2023 15:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B77C433C9;
        Thu, 13 Jul 2023 15:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689263014;
        bh=a02n8F7I0BC9O3H7WAzCyYW5N9p3gBn7c9lJd2JE190=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfOVpNnct00JOEZz8f6ofK8Np5RrswDO/LANYthjXblaP6MJvrz/J75iIInrPrR8A
         mLZJndIqh6jREZtgoEYRRL1NkydUTupj7PaEPuWAilZzfh0tiM4LQt1FIJBXvafRo7
         7HWqi9v6tJ4auKKUhxdpUe++/9+npal1bkM+BhSgftDd9IEyQhP860s680yuMEEmhW
         ssHEjcOVyjgycdZ10Q+egHwFklDxSg+pVJ6LUlKSPGqCH1o5cr6otrGzP62eYdsY3s
         mZVjUyXSC3sXkhHIOZX9+fu/FvZreIO0c0RVnhfWa0zrHS6vHLrICM1lDoPo+efxLT
         u2eAaq9J6wNyQ==
Date:   Thu, 13 Jul 2023 16:43:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 9/9] selftests/mm: Run all tests from run_vmtests.sh
Message-ID: <5b4fcf62-98c3-458e-a0e7-8e86ec354cb9@sirena.org.uk>
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-10-ryan.roberts@arm.com>
 <d77c6592-09f4-036d-ad00-a7a28de1da3f@redhat.com>
 <2b586ba2-7522-a823-afd6-7b4d978f18c2@arm.com>
 <97742685-e026-417b-8c8f-938330027636@sirena.org.uk>
 <8d2e75e7-0d38-6e6c-a02a-b66a18515dfb@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y9sB0v2MUUQiI5hI"
Content-Disposition: inline
In-Reply-To: <8d2e75e7-0d38-6e6c-a02a-b66a18515dfb@arm.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--y9sB0v2MUUQiI5hI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2023 at 04:36:18PM +0100, Ryan Roberts wrote:
> On 13/07/2023 16:30, Mark Brown wrote:

> > The results parsers I'm aware of like the LAVA one will DTRT with nested
> > kselftests since that's required to pull see individual test cases run
> > by a single binary so it's the common case to see at least one level of
> > nesting.

> That's good to hear. But bear in mind that run_vmtests.sh does not use TAP. So
> you end up with a single top-level test who's result is reported with
> run_kselftest.sh's TAP output. Then you have a second level (run_vmtests.sh)
> using custom reporting, then _some_ of the tests invoked use TAP so you
> sometimes have TAP at level 3. But those tests at level 2 that don't do their
> own TAP output probably won't be parsed by LAVA?

I think that should mostly mean that all the tests that don't
individually produce KTAP output get ignored by parsers and those which
do produce KTAP output will be seen as nesting one level up from where
they are (ie, the individual cases will run directly from vmtest),
though there's likely to be confusion about expected run numbers for
things that actually pay attention to that.

> Since you agreed to put this into the CI, I was going to call this part "your
> problem" ;-)

It'll run, the results are a different story. :P

--y9sB0v2MUUQiI5hI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSwG6AACgkQJNaLcl1U
h9ATFQf8CDkX97XcCz4UtVfkVlN9UXmTmpyuRQjNSh2CHkbvSzihJqhlE/J1YTOe
vBavd1wDJTa2HkgTgFKVrbZe5+oME3wGPSR9Hu+uhm1zQfCkkHhR0rsJjJqGZ9hN
l2YMM7cqSl9UC0QzX8lcTUTAOb14pAC5ikmnWd4LlMFVtR6sZHoqZk60xsxvZymb
evGt7ytkwQxliaEKv4kVsA2NDeiQ/awIcIeg26VNABqHa/T8MoGteDxdx2ZkeFAI
2Lp8OV6YGhDmBn0lnuY+qoTUWdgceIuau7ISav3S6udB8Useinu7ab19HPw48nDL
oq5PM+NJhvqYKm9ZsLM7JNhMbQi4bQ==
=HNhe
-----END PGP SIGNATURE-----

--y9sB0v2MUUQiI5hI--
