Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60F86C8265
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 17:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCXQdZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCXQdY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 12:33:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7E09004
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 09:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBE28B82355
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 16:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0E5C433EF;
        Fri, 24 Mar 2023 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679675601;
        bh=f1wFCUhAyXmbjBDZI6rgUcj7zWfbRRwTxc3RfY86ezk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FC/7deq4Xgdi9t4bCIgu8hWxH21V1+6YRLtGHNy4z2UPjNeD9FnywiSZlv+HKW/Dr
         EM8SPtwy2mLp0wk+GEQV1ASli7PGoRCY/TBugONItUmwLnJ4h4H41mcFFQ4XN/p2YY
         /lWPruX8WjmraohZ8Z74pcs8JRb7taOfLKPv6zyc7F893xV5oNrNr7STV0CUx7toy4
         kR0tK/G08jwNx/kJB9HOR+vwF0m5uuFfWo2X1gjmx+0YCBuJ+7Z+H8i7QDNGbEpEbB
         c+VBhkxEVNMf5mdt/duMe/mouSXN/KBnG8Kpg/vlmpXaLNMwLrhVe+DzU6szh2rCPf
         O/JSXSjdRtJIg==
Date:   Fri, 24 Mar 2023 16:33:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Heinrich <hallo@alexanderheinrich.de>
Cc:     tiwai@suse.de, perex@perex.cz, shuah@kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] kselftest/alsa: Fix -Wformat compiler warnings
Message-ID: <ZB3Qzes5fpFhmazb@sirena.org.uk>
References: <20230324160158.4076-1-hallo@alexanderheinrich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eKo8yaINNsrYcS+7"
Content-Disposition: inline
In-Reply-To: <20230324160158.4076-1-hallo@alexanderheinrich.de>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--eKo8yaINNsrYcS+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 24, 2023 at 05:01:58PM +0100, Alexander Heinrich wrote:

> For the string to int conversion functions, the return values for the test cases
> in pcm-test.conf are non-negative and in the range of unsigned int, so I just
> cast them to unsigned int.

That sounds like you're masking some issue rather than fixing it,
but...

> Please let me know if I can further improve on my patch (it is my first)!

It might be easier to split the different kinds of change up into
separate patches, it'd make it easier to follow what's going on.

> +				phys_width = snd_pcm_format_physical_width(format);
> +				if (phys_width < 0)
> +					ksft_exit_fail_msg("Unknown PCM format\n");
>  				samples = realloc(samples, (rate * channels *
> -							    snd_pcm_format_physical_width(format)) / 8);
> +								  (unsigned int)phys_width) / 8);

...this isn't a formatting function, it's realloc()?

--eKo8yaINNsrYcS+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQd0M0ACgkQJNaLcl1U
h9B5FAf8DDOY2qRM0ARpoXbWW4oA9UFmVb0fMB/TAKue7xi+hEil4hnO7X27wNAV
VaRx7hpF+t0hrQY/LzGgiHOv7KSznAQ9AcWHaqezkTaIfu8E3t1Fr5/e6K5RCE10
9NykMDrgQsE5djIteJrj4mt7A8YVI1rWR8d9FtCPvRnj1jFqRqBM7bQKJZNI6H3i
hoH0l3NnxIVk6Mj1lzboOqg24aixO5HAjn06Ja+j237LkaGytGmQsvcy7NGrN0cq
1Qxb3QdFo8tq35gFwCQHhUFDhtpIX5v7PQyNg1xObtTJ57shfyuHZWPZAxO4YC9q
A15jbE6OAiTrehs5NsCD2/T5sLFspg==
=Cajr
-----END PGP SIGNATURE-----

--eKo8yaINNsrYcS+7--
