Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799FA7992D8
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 01:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjIHXdP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 19:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjIHXdP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 19:33:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D1618E;
        Fri,  8 Sep 2023 16:33:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E37C433CB;
        Fri,  8 Sep 2023 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694215991;
        bh=rWdg/MaewEbzcqXr37tHoPRHV8l4GTkG0MroPAtp1Lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgGC5YvzcxHvd02fydU4edg3Pg0kVQyl1dGefm31hjLCtR4etzQisTtosQu2wD2Y0
         3bfc5C/2DnIklmoLp5xXDVwRLwnZaDZbLrg1zKWxQRkRtt+ynnD5DDAfZqPj4spHB5
         fr05rTkHVg1g3bcYWSvGo4deSf8yI6mwWlmh2lTqM25xV7XBlO08YVYVdRZxelZHZm
         Ob2OQt06/uPYPyYDhuWtipDg5CnLiJsTpVG+RrSVKrnNd4XkQi61PxQJJrIRptTokg
         m3QCDh3pHOJSc41qktZcyvxjT8vkmytjz403j+GEHx8vaPXYUSvKSQ3+aoo8JhsX/C
         ut80VDPhAEkZw==
Date:   Sat, 9 Sep 2023 00:33:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        naresh.kamboju@linaro.org, anders.roxell@linaro.org, arnd@arndb.de
Subject: Re: [PATCH v2] selftests/user_events: Fix failures when user_events
 is not installed
Message-ID: <29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk>
References: <20230908201916.562-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CY/98AgbeuyecoIi"
Content-Disposition: inline
In-Reply-To: <20230908201916.562-1-beaub@linux.microsoft.com>
X-Cookie: My EARS are GONE!!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--CY/98AgbeuyecoIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 08, 2023 at 08:19:16PM +0000, Beau Belgrave wrote:

> Add common methods to detect if tracefs and user_events is enabled. If
> either is not enabled skip the test. If tracefs is enabled, but is not
> mounted, mount tracefs and fail if there were any errors. Fail if not
> run as root.

This will leave tracefs mounted if it was not already mounted which is a
change to the system configuration.  While that may happen if things go
wrong during a test we should probably avoid actively doing this and
either only skip or try to umount at the end of the test if we mounted
ourselves.

--CY/98AgbeuyecoIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT7rzAACgkQJNaLcl1U
h9CdFQf/UwAwvRegHgky4KJZPGB8LiHoBMhDUFFqu5cWbeZ0PlbjkFdGVJbTTsyL
uXQfeO5FFNnyUsz8a9i0O14u86i9wlmeCg/KCRxc/8v+0iVGFkVMEQ+BCVOWNbNk
f/dOYzAvO9YjYFFBDNA7cXPQE+7DEFco6rNoO44L4hV+Ll+YZUaJxHjAf8fPKSlL
2hSJdyLlHSyypCRg3Pmz3CDtcPgrMWyZNMe52JcdziQAeQ7dDyxOP1me/Ky8UwTd
XSXPN79dhkZS17ql4R59jtwompOPMLKz6MIFx24UqNeqrxGbJZPDIni7MTx/iI2e
GomTw28jfMyAx0g+eGEjhTcdYS7D4w==
=Y9VW
-----END PGP SIGNATURE-----

--CY/98AgbeuyecoIi--
