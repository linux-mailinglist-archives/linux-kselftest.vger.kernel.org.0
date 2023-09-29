Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6542A7B2D3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 09:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjI2Hu5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 03:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjI2Hu4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 03:50:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273A91A7;
        Fri, 29 Sep 2023 00:50:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391AAC433C8;
        Fri, 29 Sep 2023 07:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695973854;
        bh=GGbpHYnnHtkusyGSK6jQIjPmfyLPGabIgOAYFgPfq1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DAesCVn5p/1cB0JR2N4tEHjJbvZVaCWqQiGgTvbTgJzI5lrdY+DS6OkYDWAQIvvzF
         C2L8vLOYIxuRxVRhjHoBQRLRU1KYQYlPjevbu8OkDaIFIgdtQAhQd4fJBp8YslIF/o
         jdv59SXlX+HXbyo/iFPv3R+fEQZ74YsMCgqj+FSnndZETMTuwC1R37zapsituVSo/X
         Gp8G3pvE+B/R76+2tRThEvQL9PMGnXI0phbx2wcPd3Hm+pFAeTB05K8kg9vwXcaDhz
         8wObjn3LfRGwTtzFwUQGRh5tIvQDk+5n8Q63ZWNs6TzfjcNEPkw1+d7JZBA0r+KHtn
         mUuaxqOrQ3dlw==
Date:   Fri, 29 Sep 2023 09:50:53 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] kselftest: Add a ksft_perror() helper
Message-ID: <ZRaB3SfRaUFsP7XN@finisterre.sirena.org.uk>
References: <20230928-ktap-exec-v1-0-1013a2db0426@kernel.org>
 <20230928-ktap-exec-v1-1-1013a2db0426@kernel.org>
 <202309281747.594B3352@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x9263VfYFBG144cp"
Content-Disposition: inline
In-Reply-To: <202309281747.594B3352@keescook>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--x9263VfYFBG144cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 28, 2023 at 05:48:22PM -0700, Kees Cook wrote:

> > nolibc doesn't have a strerror() and adding the table of strings required
> > doesn't seem like a good fit for what it's trying to do so when we're using
> > that only print the errno.

> Oh, interesting... what environment ends up without strerror()?

Like I say it's for nolibc - it's just some header files (all in the
kernel source), while it generally aims to be libc compatible it's
intentionally very small.

--x9263VfYFBG144cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUWgdoACgkQJNaLcl1U
h9DSKQf+Nwu+SS/OWR23p6efn+V6eqT6BHD6pcarmjnNkHqSzy9l3Ygy4S6Fbny+
eE8I8uhXrP345bqn0SdeNI05MiO/qH2F5qDM7nnt2h6Lnm9JnyIEybeu8tXMKxGA
q9EfIdKsJoY3EjJPVLU6xTj9z/9c1v+3JeDKFYiM+548twGcVuWvQ0I2rpoE60kY
c8OiWo6fa9klyrhKUazGjL0HdWGel7j9JNppMnY5946rxkaR5Mfjc0kiYtlGlYdy
A1Q8DNgk/z9N5bdbBHtYK9TNeGlJ1wZAfIYOwNlWFgKO+iUl+anJNedA5C0ldYnZ
DJtFu//F0HRs9f6y671Y9mzI2jxrjg==
=bjp7
-----END PGP SIGNATURE-----

--x9263VfYFBG144cp--
