Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74B174F2D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 16:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjGKO5h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 10:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjGKO5g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 10:57:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C785DB6;
        Tue, 11 Jul 2023 07:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64BE261549;
        Tue, 11 Jul 2023 14:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1184FC433C7;
        Tue, 11 Jul 2023 14:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689087454;
        bh=2Fpu6ygnQ3uWAeph6ExhTbNxaRHMJNTPysKbsFxrvWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZnF9eOA+KB4jwS17edr4HzC+mMgnJl0sgt3Kag/0kL051eTxpMUDc3e4E7Z+RnKm
         /Mma2xgD2OzKWAtnGa7JmFLkr0EDA/lE5KgcZXqFaM4uavda3VmjS03uusjLKGAHoD
         YgzqDVAGKr8/1q1xtzLeINcH9obveKwvHguaGT1798a+jiB23ROp+4KdYfJ6VMyjJO
         2BoGAJys3lVJWkNzUUg3M46Lb8tBjX4VdB/0DoclfkCtcPvfs0I+obr5OArzQx4C5T
         bhyahQ5M/NlqmSFlHDfN4hRMB6IrKC6ChW15LDdZSIQoN1OTQX1dHIPmQlGWak34fo
         V2ux7LRrKgHuA==
Date:   Tue, 11 Jul 2023 15:57:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/arm64: fix build failure during the
 "emit_tests" step
Message-ID: <79cd64fc-3504-4b0f-9691-5c16780ea472@sirena.org.uk>
References: <20230711005629.2547838-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dG2iMzQbVziAMbZW"
Content-Disposition: inline
In-Reply-To: <20230711005629.2547838-1-jhubbard@nvidia.com>
X-Cookie: marriage, n.:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--dG2iMzQbVziAMbZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 05:56:29PM -0700, John Hubbard wrote:
> The build failure reported in [1] occurred because commit 9fc96c7c19df
> ("selftests: error out if kernel header files are not yet built") added
> a new "kernel_header_files" dependency to "all", and that triggered
> another, pre-existing problem. Specifically, the arm64 selftests
> override the emit_tests target, and that override improperly declares
> itself to depend upon the "all" target.

Tested-by: Mark Brown <broonie@kernel.org>

Thanks!

--dG2iMzQbVziAMbZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmStbdgACgkQJNaLcl1U
h9DMyggAgAnsBy1dwAUVK1Tk66KT+ix/5rHDy24wZTmt84bLK0CJtmkcMSmuQ0IY
dNzxLhU0kCgm0VXqKvyA0P9gj8WfkolnvaOGRGXwF+gb5dvkbbAr2qgu2pvayY/A
XrUBxsHn2BHY3luUM0wrcc6FiCXucdLGDUTnmAxokmqWaMfmkUbsGq96hpt9iAws
Foux0MYZHuLKkLM9Hvi9v2dSEVqwb5wzLvNSJfbZ12nR8FwKnwEoUZh5teSMWu4r
DYZtsE8zogain2n8OKx3etAv45IXHJYwKHgeHbRII1TAga4slsxwOL8Y76HdrEIe
Jk9eyQvXd19Binu3UVMtYSlNafiZ3g==
=iYS4
-----END PGP SIGNATURE-----

--dG2iMzQbVziAMbZW--
