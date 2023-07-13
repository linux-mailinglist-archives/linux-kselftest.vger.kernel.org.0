Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA91D752569
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 16:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjGMOpm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 10:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjGMOpm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 10:45:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386632705;
        Thu, 13 Jul 2023 07:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCC016157F;
        Thu, 13 Jul 2023 14:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C950CC433C8;
        Thu, 13 Jul 2023 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689259540;
        bh=9x2+cvi+3bTenkv1neM15nfVBtvEgjl998KUiR4iaaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fb+lbr3rXs6mQK6vDdOoMi9PbVJLhx7gakT+qkYxDpktn9DlvXCe4dUTbSXjrK/3o
         ITsy53hn3nBDsHjuWRvIHyLxHDdMDEnGn65XqdzzaOsDi6slhDIBjK8T++wmcSGQPK
         yAqthuJHPgmk8zmOPBf/Vck1vfkSUD5IPF+RQxE3TXnW5FKwIZNKpagx35sU9ndB5c
         FVoYKzhltVJBFARZ8rXRKxjyx0QsDNl6xBsXdcZtoWUsljFIrIhl7hAwT6dHLo4jPx
         cPZUpejuonWkiSOhXt7qpxgW2q+Qv19Xhl/mSWT0hCf9MlHDgpUgPfON/W8pe1zwQI
         /9mLX7/Ab2TKA==
Date:   Thu, 13 Jul 2023 15:45:34 +0100
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
Message-ID: <1b33e341-e86d-4647-bcbe-38d2667cb891@sirena.org.uk>
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-2-ryan.roberts@arm.com>
 <8a8d077c-55bd-4710-9dfd-1cbb1a9170a8@sirena.org.uk>
 <1e560ea5-3eb2-40a8-33aa-514eb026de3a@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="opkr7b0grNXS+tLU"
Content-Disposition: inline
In-Reply-To: <1e560ea5-3eb2-40a8-33aa-514eb026de3a@arm.com>
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


--opkr7b0grNXS+tLU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2023 at 03:32:19PM +0100, Ryan Roberts wrote:
> On 13/07/2023 15:16, Mark Brown wrote:

> > so that if setbuf
> > isn't installed on the target system or the tests are run standalone we
> > don't run into issues there.  Even if the test isn't corrupting data
> > having things unbuffered is going to be good for making sure we don't
> > drop any output if the test dies.

> Note that currently I've set stdbuf to encourage line buffering rather than no
> buffering. Are you saying no buffering is preferred? I took the view that line
> buffering is a good middle ground, and and aligns with what people see when
> developing and running the program manually in the terminal.

TBH with the way KTAP is specified line buffered and unbuffered are
probably equivalent, I was just defaulting to unbuffered since it's the
more conservative (if less performant for lots of I/O) option.

--opkr7b0grNXS+tLU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSwDg0ACgkQJNaLcl1U
h9BjVQf/TDjeTXyfVia9mY7E3G3glN1Oxz4ObsUpvF6whyd5D7AjlDAjrB41x6xs
S2dLRBFeHLXa2DABIRYUs0oNpoaI7QnBdIurIHO1JdsDWhiPhgIthBDOoYnOzKy0
QB4aJOcg/MfYbbdcqxL9CpiZU0dvFJA2Ge4sEC3gBJxLzj4nW9y7eSI+Aro9RYxD
WZsPeOqGrxlzRplEf6ENdoiPxFvfx/wog2pc+dpgfXxYo6JMeJreShHPbHvIguGA
4eeLtN5whg3nZ6R2gAFBkqmbCrBDf+K713xaO1a3WPWVyr6Guqbee/uTwA00CHkV
7XtoMJ0hi9IE7KeQ8BRYKcym5LjPpw==
=yLQw
-----END PGP SIGNATURE-----

--opkr7b0grNXS+tLU--
