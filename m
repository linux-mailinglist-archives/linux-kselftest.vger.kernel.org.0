Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93B26C5BB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 02:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCWBIm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 21:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCWBIl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 21:08:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E93135AA
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Mar 2023 18:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64B45B81EAB
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Mar 2023 01:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C2AC433D2;
        Thu, 23 Mar 2023 01:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679533717;
        bh=aEL7/dp7dUvkEgYFy6Lor6d2YJXiw/Ri7nwDbpKut3c=;
        h=Date:From:To:Cc:Subject:From;
        b=tLMpPTXV4o/v7u0c5+DwiBjVmE7MlezEERMRH58uJHQLsg78oCvMKt371UfY95bmC
         av+nSPj+jrFNbEa/+DFfN7tI5z8l9IwDHyGZ1y1O3DDxXgKk2fGniHgZCgBMgN0XY9
         KJqutHVx69Kd2c1THSF3IIBZQqJNT6bqVsPpaWDIO2g6wZQozz+lCCDjKhf1d0fQF/
         1NAE9I/K/8FJHmClx+DZKKjc1lPTheh99jL/QcTlHz6Kh+lbAvzloWdwmsIDHzu7S7
         ycaC7J++t8faBy5tCCePRiMU4Czvhy/OnZcZ6jbLBZx3i6Nww3uPN406aA1B0VqwqX
         oXy/ybSBN30PA==
Date:   Thu, 23 Mar 2023 01:08:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Running KUnit using the wrapper script
Message-ID: <ZBumkUcw8cQfjvO7@sirena.org.uk>
Mail-Followup-To: David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lJbf9grCVROT6NMf"
Content-Disposition: inline
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--lJbf9grCVROT6NMf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've been trying to do some stuff with KUnit but I can't seem to
find a current tree where KUnit builds.  Running on Debian stable
starting from a clean -next tree and running:

   ./tools/testing/kunit/kunit.py config
   ./tools/testing/kunit/kunit.py build

based on Documentation/dev-tools/kunit/start.rst.  However I get:

[00:42:59] Configuring KUnit Kernel ...
[00:42:59] Building KUnit Kernel ...
Populating config with:
$ make ARCH=3Dum O=3D.kunit olddefconfig
Building with:
$ make ARCH=3Dum O=3D.kunit --jobs=3D8
ERROR:root:In file included from /usr/include/stdlib.h:1013,
                 from ../arch/x86/um/os-Linux/registers.c:8:
/usr/include/x86_64-linux-gnu/bits/stdlib-float.h: In function =E2=80=98ato=
f=E2=80=99:
/usr/include/x86_64-linux-gnu/bits/stdlib-float.h:26:1: error: SSE register=
 return with SSE disabled
   26 | {
      | ^
make[4]: *** [../scripts/Makefile.build:252: arch/x86/um/os-Linux/registers=
=2Eo] Error 1
make[3]: *** [../scripts/Makefile.build:494: arch/x86/um/os-Linux] Error 2
make[3]: *** Waiting for unfinished jobs....
In file included from /usr/include/stdlib.h:1013,
                 from ../arch/um/drivers/fd.c:7:
/usr/include/x86_64-linux-gnu/bits/stdlib-float.h: In function =E2=80=98ato=
f=E2=80=99:
/usr/include/x86_64-linux-gnu/bits/stdlib-float.h:26:1: error: SSE register=
 return with SSE disabled
   26 | {
      | ^
make[3]: *** [../scripts/Makefile.build:252: arch/um/drivers/fd.o] Error 1
make[3]: *** Waiting for unfinished jobs....
In file included from /usr/include/stdlib.h:1013,
                 from ../arch/um/os-Linux/skas/process.c:7:
/usr/include/x86_64-linux-gnu/bits/stdlib-float.h: In function =E2=80=98ato=
f=E2=80=99:
/usr/include/x86_64-linux-gnu/bits/stdlib-float.h:26:1: error: SSE register=
 return with SSE disabled
   26 | {
      | ^
make[4]: *** [../scripts/Makefile.build:252: arch/um/os-Linux/skas/process.=
o] Error 1
make[3]: *** [../scripts/Makefile.build:494: arch/um/os-Linux/skas] Error 2
make[2]: *** [../scripts/Makefile.build:494: arch/um/os-Linux] Error 2
make[2]: *** Waiting for unfinished jobs....
make[2]: *** [../scripts/Makefile.build:494: arch/x86/um] Error 2
make[2]: *** [../scripts/Makefile.build:494: arch/um/drivers] Error 2
In file included from /usr/include/stdlib.h:1013,
                 from arch/um/kernel/config.c:7:
/usr/include/x86_64-linux-gnu/bits/stdlib-float.h: In function =E2=80=98ato=
f=E2=80=99:
/usr/include/x86_64-linux-gnu/bits/stdlib-float.h:26:1: error: SSE register=
 return with SSE disabled
   26 | {
      | ^
make[3]: *** [../scripts/Makefile.build:252: arch/um/kernel/config.o] Error=
 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [../scripts/Makefile.build:494: arch/um/kernel] Error 2
make[1]: *** [/home/broonie/git/bisect/Makefile:2028: .] Error 2
make: *** [Makefile:226: __sub-make] Error 2

[00:43:20] Elapsed time: 20.233s

which isn't ideal.  v6.2 is also broken, albeit differently:

ERROR:root:`.exit.text' referenced in section `.uml.exitcall.exit' of arch/=
um/drivers/virtio_uml.o: defined in discarded section `.exit.text' of arch/=
um/drivers/virtio_uml.o
collect2: error: ld returned 1 exit status
make[2]: *** [../scripts/Makefile.vmlinux:35: vmlinux] Error 1
make[1]: *** [/home/broonie/git/linux/Makefile:1264: vmlinux] Error 2
make: *** [Makefile:242: __sub-make] Error 2

which makes bisecting a bit of an issue.  The kunit-fixes, kunit
and kunit-next trees in -next have the former error.  Can anyone
point me at a tree/config/commands that's suitable for working on
KUnit at the minute?

--lJbf9grCVROT6NMf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQbpo0ACgkQJNaLcl1U
h9BSsQf/dIdzsWIwXDmbPVRCTDllpOQ4eWDS9gYFZQQyuv/gi9tcV1codXPTLCkc
rwhPIM2mp0vEHoZll0NSUL2+UEES6xn4TuTbydZESsXgDkwdjLRdVTr2jrS8VGix
6Wq5Ro3QCrJmIcExeRNrkK9amkbrIxCuVgz0gcTY8d4kfXI92V7c0jCy9OvHaqHs
mnT2R1ZQ15jMazjfi2RLi4N5Vv7gGNq5rv2rPOFoyMERsVG8BCainFv5Th73VBgP
JvKOzQlzpM6reHA6lUJsNlHAQOVkG5rEkJfxarZ8SjShi5caI+gCJrDW+OhoZwnR
LSsWkYa6mMzX6IuX8+xlbyfvReVemg==
=YUuC
-----END PGP SIGNATURE-----

--lJbf9grCVROT6NMf--
