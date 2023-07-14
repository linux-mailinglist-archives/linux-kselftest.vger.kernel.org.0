Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6FA753FA4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjGNQMU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 12:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbjGNQMF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 12:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396463A9C;
        Fri, 14 Jul 2023 09:12:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3A9361D66;
        Fri, 14 Jul 2023 16:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62961C433C8;
        Fri, 14 Jul 2023 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689351121;
        bh=ws5Wodwv96nMd2sAmsG4FBrWyNfSQxLW/+oHC8se9xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gbf9Kvxf+9f1LiBGtbFLik1w+K4GfJ9GLNUTx7x9SZWPZMA4EuWv0FHPcw8Npn/+T
         hXpVb/pZo2VSv4CIm8IC1KZRNAafDU8BX3D48j0BhyHAAUkZfjow3nw4D3AEn1M0s5
         FC5CwA4yWIiX/JJSUN7M6WwhqjiBODSgOg+u5Iz62KBh7rjGXKpLTd2vEOtbFHvaMw
         hlZUYic1FkISN85ykkXrbH4uhfK0iD7gq61SCWpItld99x3UyV7hdf1TYJ99ULt9tZ
         5Lrela2l/vufSmfYbsNDe10QSvUJr6VLN33I0bELwzW9T7du2zBEf/SvT7M/QvVDkB
         Rr6xoD+deGcBw==
Date:   Fri, 14 Jul 2023 17:11:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/9] selftests/mm: Give scripts execute permission
Message-ID: <479a1704-a383-4385-a6d5-773cbfe1d4c8@sirena.org.uk>
References: <7935c31a-6c47-95c8-d6bd-176b81046699@arm.com>
 <20230714160058.45215-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CZYy7fd3hsXdUxsO"
Content-Disposition: inline
In-Reply-To: <20230714160058.45215-1-sj@kernel.org>
X-Cookie: Preserve the old, but know the new.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--CZYy7fd3hsXdUxsO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2023 at 04:00:58PM +0000, SeongJae Park wrote:
> On Fri, 14 Jul 2023 10:44:14 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> > Personally I'd rather keep this patch and try rather than proactively do a work
> > around.

> I don't have a strong opinion here, as mentioned before.  That said, I feel it
> would be good to have a clear agreement or explanation about that, since I got
> similar situation before[1].

I think just from a usability point of view we want to end up with
things people are expected to execute actually executable.

--CZYy7fd3hsXdUxsO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSxc8oACgkQJNaLcl1U
h9BGigf9HIUnaZgscQpeiZWmNiMcL8H2JzwsKQMgiceeanLwURwT6CMHdbgzxIui
rdnseQuisjw9FB4Ki6eCEAXnkAMyASEB8HW7YRiAhd7J8pSl6AFWWnVPhsQLO1OW
Nc04umuZscVO87FEH0YR+ebxvIAZiEswbUbEZ7FOrQU/uURzWCAPUFa7/H2MbVv5
oA2Ft60C3kp5aoA6uIAA5lwYpWVivKjNKzM0jwyiFOOQTm+zo/4Y54+WGexDYQyc
uhj446zIHYk2RTCpfbnzBlMxXuapvwWFr64c3gzYgo8+CAmoIOpMl8bpp9Cn47cj
CcYIi39PZWn6z3aBY/OtkccD30jpnA==
=5MMo
-----END PGP SIGNATURE-----

--CZYy7fd3hsXdUxsO--
