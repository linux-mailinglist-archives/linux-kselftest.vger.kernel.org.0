Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F26375271D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjGMPcJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 11:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjGMPbt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 11:31:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4E030E7;
        Thu, 13 Jul 2023 08:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 930E761A2A;
        Thu, 13 Jul 2023 15:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AEFC433C9;
        Thu, 13 Jul 2023 15:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689262266;
        bh=+bl7pGAIjOwAWrnLWJZrbTUju1m6vSqMi+vbA9qDarc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HdkGpCT4OKVPWpXMzoWAdJXWeDmQQTIlz5UuWbQdX+FvsVaIiM0RIaHNjXyYw4Dpq
         0E+TrM+ZTNpDNJwspFrtMpNOhFrdpOsPWUDaBfc3ky4V48UpYQ+tRCAUzyqBCzSQrx
         +Qr+/D+SHrVrK/rap00ix0c99qWp3/nuBANKs42UsY9eosobXOCNW6lytER9gvJuWD
         QLfPBtH8KTKz/u5FNixfjCu+d5lKQ6JLNPtXt7Gc3hRzU97eK9WMdkaeCb791Xhzos
         vbeyoTTpbX7ZOi8+yvSPBb2NXH8uKDWEYN5F6MnSlarQWxtFPwzB5a5byrsMhsYJAO
         5ziK9vk1ax0dA==
Date:   Thu, 13 Jul 2023 16:30:59 +0100
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
Message-ID: <97742685-e026-417b-8c8f-938330027636@sirena.org.uk>
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-10-ryan.roberts@arm.com>
 <d77c6592-09f4-036d-ad00-a7a28de1da3f@redhat.com>
 <2b586ba2-7522-a823-afd6-7b4d978f18c2@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="onJhUM6E6puuqySH"
Content-Disposition: inline
In-Reply-To: <2b586ba2-7522-a823-afd6-7b4d978f18c2@arm.com>
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


--onJhUM6E6puuqySH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2023 at 04:04:44PM +0100, Ryan Roberts wrote:

> So with this change at the kselftest level, there is a single test in its list;
> run_vmtests.sh. And all the other tests that were previously in that list are
> moved into run_vmtests.sh (if they weren't there already).

The results parsers I'm aware of like the LAVA one will DTRT with nested
kselftests since that's required to pull see individual test cases run
by a single binary so it's the common case to see at least one level of
nesting.

--onJhUM6E6puuqySH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSwGLMACgkQJNaLcl1U
h9BznQf/R74hHYm7LdjI06OmEd0RI0mxw6+/XWm6KKDxZ28fK3TAx/HdCd5QL+i/
53Cdoyeoc4fCAPKY9in1xVo492p8qYdCetruuUUjHm5FVQFFH29Jb25Crjk0NxqT
8iFlNAv42sg0wvOVKfdHShqFu8LakabasfEulvz4Mp4WQdCTOiuq34MidDS1TZxE
GXO/Q+6BGTDr0BAK0gyhZWY+ENIyGrmdwYh4G630kEbYxV8tO9CNzrUpjH4XXO+4
inh3KdiiJuXJTHLV7iwVkVeVRsvuc0LDXr8IwlPzTkk5twaFtTjMs1W0Zs38jtib
2BY8jadzeUk/WzvXnnCzbAjmL2g+Dg==
=JjuZ
-----END PGP SIGNATURE-----

--onJhUM6E6puuqySH--
