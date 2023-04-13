Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C066E0FD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 16:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjDMOUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDMOUX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 10:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3788C2D43;
        Thu, 13 Apr 2023 07:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C42ED615A5;
        Thu, 13 Apr 2023 14:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9298FC433EF;
        Thu, 13 Apr 2023 14:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681395621;
        bh=7uOcMqCC9rFXgBG3LAgel2H2tG/3b3XSmuVAeWOxrKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJsu63SBsFVSnYBMAf9wX3lmjUgPYCPEgPI/ivavhli99al2TavQQBX/rNtyMs9za
         DFJmpRyqWsImEg5x3xTcwSwSbdElPmK4AmBCZXzBMGG632lrsfJZueF9iajq7sCg+x
         jzMcLSkgdPBnd0FmQPXc3Tu6uXv8oTlVZXxbZ2cnAxzYgnuIT7CFX+UoJVytZ+EzBe
         8aDi8qqs8SoXbLGqWV2iZcy6JKZbEyASympouPxGUsvy4pwQMl3j9CoYKGqMGUS4zR
         8YCbsJPjaSzthkVkg+VcR/3mu2VH/2CgMtb1D0jzJAYpgktfQP6TQa7p+jF4icmhoT
         M5XxJTxucw5WQ==
Date:   Thu, 13 Apr 2023 15:20:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux@weissschuh.net
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org
Subject: Re: [PATCH v3 3/4] tools/nolibc: implement fd-based FILE streams
Message-ID: <189e27d5-f58f-4d97-9d4d-f1d88c9ebda1@sirena.org.uk>
References: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
 <20230328-nolibc-printf-test-v3-3-ddc79f92efd5@weissschuh.net>
 <f28e3c85-84a4-4b30-a3f5-c2efad311fe7@sirena.org.uk>
 <a91f0fe9-fcca-4009-b34d-0c58542d9765@weissschuh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DAtBsIIT0GO5kgGm"
Content-Disposition: inline
In-Reply-To: <a91f0fe9-fcca-4009-b34d-0c58542d9765@weissschuh.net>
X-Cookie: Idleness is the holiday of fools.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--DAtBsIIT0GO5kgGm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 03:09:27PM +0200, linux@weissschuh.net wrote:
> Apr 12, 2023 17:58:45 Mark Brown <broonie@kernel.org>:

> > Nothing in this change (or anything else in the series AFAICT) causes
> > STDx_FILENO to be declared so we get errors like below in -next when a
> > kselftest is built with this version of nolibc:

> These definitions come from
> "tools/nolibc: add definitions for standard fds".
> This patch was part of the nolibc stack protector series which is older t=
han this series and went through the same channels.
> So I'm not sure how one series made it into next and the other didn't.

> This would also have been noticed by Willy and Paul running their tests.

Hrm, that commit is actually in -next and Paul's pull request, not sure
why it wasn't showing up in greps.  The issue is that you've added a
dependency from nolibc's stdio.h to unistd.h but nolibc.h includes
unistd.h last and there's no other include, meaning that at the time
that stdio.h is compiled there's no definition of the constants visible.

The below fixes the issue, I'll submit it properly later today:

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 04739a6293c4..05a228a6ee78 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -99,11 +99,11 @@
 #include "sys.h"
 #include "ctype.h"
 #include "signal.h"
+#include "unistd.h"
 #include "stdio.h"
 #include "stdlib.h"
 #include "string.h"
 #include "time.h"
-#include "unistd.h"
 #include "stackprotector.h"
=20
 /* Used by programs to avoid std includes */

--DAtBsIIT0GO5kgGm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ4D58ACgkQJNaLcl1U
h9A2SQgAgm17E78aM1sfqCFI9oXDemFsJn6JP25Tu96o/SY+kML0iOMqqldEG/WL
DxlSZpcC0cXr9U6cFcV3Ct4Y4Kbjq8iuHxUH9oV1fpokbO9NOUgTGphRTM/T7mhQ
zwXpSDsk0oKlUSLA/jx6WVGRIT0AfFn01CjVndG9UONpBUmnwJDX+AQaczsNm9cd
nzg0Zr0SpNMCn5pOI1WlxkRSkEXB1WzE2wIcrUdj/QRN7397pdZWh4VYmGHil2Sk
x/m2WY5FE0FtAYENe0XUxnzwrKGGAqq2R6KrZuAmjO574qgJeoMulKBQWZRor3tx
C54U7GP61IleXB1wWwPKcsHZoDMM1A==
=FQ+a
-----END PGP SIGNATURE-----

--DAtBsIIT0GO5kgGm--
