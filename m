Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CAB785B64
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 17:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbjHWPFZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 11:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbjHWPFY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 11:05:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B60AE71
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 08:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9678F6588A
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 15:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E95C433C8;
        Wed, 23 Aug 2023 15:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803120;
        bh=t0yWTMWo9z549iZ8p3wOxi/qvcUOMCZlxSHV1Ds5aTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RlEb/Ox8/01JknE9JK/eUX2Vbt6MYiTSqDlYTansmmHlQ8KReElun84Iogj7TjzCc
         QYQpTon4dkuIjiivUUgDTYYPG1Hr/EnU/Wp0pJ6vvGGvT6FIb0hozxGPyRP+k+ywq2
         eD5N6jNizV7/hJxmcFGO2Fet8Qx8i0lbil/It8F7mctgqPtGfOY2445DK1/OCzu3Q5
         4t/X3MaZw15QtSk6akoi6MAHxE1dC5sGwWczyI5QTeGGKhKTnh+73kR7L3rRyV1B8w
         7QxzjEergYNO62zN18bNpg9W1fbyHhPYfPXeydJ3pMmS1aZdZv1xV78pwDRYf2j2QN
         kESq06TJ9QA/g==
Date:   Wed, 23 Aug 2023 17:05:17 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org
Subject: Re: Repo for tests which fail currently?
Message-ID: <ZOYgLVsehrfID2GZ@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
References: <ZOXxSA1UKBkU/ou4@ninjato>
 <2023082335-retail-gallows-1fdc@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WRUBLPmqB3F67yQY"
Content-Disposition: inline
In-Reply-To: <2023082335-retail-gallows-1fdc@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--WRUBLPmqB3F67yQY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

> Why not just add them to the kernel tree, with ksft_test_result_skip()
> being the result for now while they still fail, and then when the kernel
> code is fixed up, change that back to the correct
> ksft_test_result_error() call instead?

Well, I don't want the tests to be skipped, I want them to be run :) So,
they will indicate that someone is working on the issue when they turn
=66rom red to yellow / green. I expect the issues to be all over the place
and I don't want to monitor all that manually.

But since I do want them in the kernel tree and kselftest already has
some nice infrastructure (like required config options), I wondered
about a seperate directory, like "kfailtest". These tests are not run by
default but whenever an issue from there gets fixed, an inverted /
improved test can go to the proper kselftest folder. A bit like the
staging folder where items are expected to move out. Except, here not
the tests are ugly only their result is.

Maybe I'll start with this direction and see how it goes...

All the best,

   Wolfram


--WRUBLPmqB3F67yQY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmTmIC0ACgkQFA3kzBSg
KbbMRRAAigGpQOA4DZ6fUMM5ksRAE26aWJA8EDVJNK+MHf30OloDHqIye0AN6zQc
UqAicuu5RNoABWVtITKmSt+q6PdUwLMSExe8DVGwX9E1RU+QMSOxAmSKRBXiDnmi
xQzf8EWGcMMfaMXS1FWQpm/15Mc9lGbj25Kz8elmAmh64eCVyHSv19g1OIwqtmWz
scZdnklO9wDMywEk7gu/xC5JN8/5OebesuT2LgqOcp1RucinlGZKZD2pVQvc3kq2
UcXlWY6SADM51rMfsK9BdYZCPFhFbr9IVQZ3rM9Is1cCa3hI4EWEdKwt4maPNq4Y
TxYvm/cmjvjQBO2q1t3+B8Ai9xYu3lBnyMSQB44PpTd6o62F0bpgx2I6BXBfT4vg
5yH0WfrYeMX266XgzpBd3nMqhZNhHcgwjQFQ6KLcIcCwgxmjk4McZ87XS5RLAK7L
Z9mTfSxfEOfEWiBSgOrkUt9vvE/LFmCw3jE4uG0yVTHoCK90J6bJ8SlonUnDnDce
M+cEdBIh53Q1QrfkchHAU8ZG9dDbaSSv7KIUa+Mco7COzvAFThyXI9UuwD5d+FJh
2f/j85Nh8k2iau4oQvFiDrIjA1t3iTI3YsTJoYvcfZ4D+zvB2XOY62HaMnV1Kx5Y
vqb3KaJq8XIb46no1LQft7Bd2bD2ZR+Xodq/gBVFpHbCGPUB158=
=Z9BZ
-----END PGP SIGNATURE-----

--WRUBLPmqB3F67yQY--
