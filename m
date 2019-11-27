Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4CD110A93E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2019 04:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfK0Dy7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 22:54:59 -0500
Received: from ozlabs.org ([203.11.71.1]:36541 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfK0Dy7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 22:54:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47N6Nc2q3Wz9sSV;
        Wed, 27 Nov 2019 14:54:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1574826896;
        bh=VRt47i4/605IsiKXVOfWB0kbI9hGLLHWqXnYS03c/Z0=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=ZZXwh+s3oHakIpYyoM8cjR60KmGSDLisf+XlzrcXqBNWQX3kOZ1L7Igs0tbumgn6l
         NYzfigaLE8Axe7aRe7AspZ9KR8vvSmScU5aAUbfo3QdwsXC7rqs8NsL8mi2jSESot1
         s2uJC8FqhNtaIViXWcAtYyiJo0lDC1MHQcf/i9HP2elxEHYZU6UJ5BKMcBmAhmI3qK
         s+V/cnhdty1COv3iJ/oucG2KAzSuscJbkUUEVhcLmz6T4xMezQ/jtWzUZaLz1/UuJY
         ZGfBJbDZeQ2SGo2++oHzB5BF8p+Xke4jc93jgAIJ/Z8ZjdamCOt9tRPChSBdcpoRNV
         Rx9qR8R2Dpx1w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Cristian Marussi <cristian.marussi@arm.com>, Tim.Bird@sony.com,
        "shuah\@kernel.org" <shuah@kernel.org>,
        "linux-kselftest\@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: kselftest: failed to build with -C tool/testing/selftests when KBUILD_OUTPUT is set
In-Reply-To: <8d34a9b9-f8f3-0e37-00bf-c342cf3d4074@arm.com>
References: <8d34a9b9-f8f3-0e37-00bf-c342cf3d4074@arm.com>
Date:   Wed, 27 Nov 2019 14:54:49 +1100
Message-ID: <8736ea2cty.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cristian Marussi <cristian.marussi@arm.com> writes:
> Hi
>
> while testing on linux-next
>
> I see that, when KBUILD_OUTPUT is set in the env, running something like =
(using TARGETS=3Dexec as a random subsystem here...)
>
> $ make TARGETS=3Dexec INSTALL_PATH=3D/nfs/LTP-official-debian-aarch64-roo=
tfs/opt/KSFT_next kselftest-install
>
> works fine as usual, WHILE the alternative invocation (still documented i=
n Documentation/dev-tools/kselftest.rst)
>
> make -C tools/testing/selftests/ TARGETS=3Dexec INSTALL_PATH=3D/nfs/LTP-o=
fficial-debian-aarch64-rootfs/opt/KSFT_next install
>
> fails miserably with:
> ...
> ...
>  REMOVE  usr/include/rdma/cxgb3-abi.h usr/include/rdma/nes-abi.h
>   HDRINST usr/include/asm/kvm.h
>   INSTALL /kselftest/usr/include
> mkdir: cannot create directory =E2=80=98/kselftest=E2=80=99: Permission d=
enied
> /home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1187: recipe for target 'h=
eaders_install' failed
> make[2]: *** [headers_install] Error 1
>
>
> This is fixed by unsetting KBUILD_OUTPUT OR reverting:=20
>
> 303e6218ecec (ksft/fixes) selftests: Fix O=3D and KBUILD_OUTPUT handling =
for relative paths
>
> since bypassing top makefile with -C, the definition of abs-objtree used =
by the above patch
> is no more available.
>
> As a side effect when KBUILD_OUTPUT is set, this breaks also the usage ks=
elftest_install.sh.
>
>  $ ./kselftest_install.sh /home/crimar01/ARM/dev/nfs/LTP-official-debian-=
aarch64-rootfs/opt/KSFT_full_next
> ./kselftest_install.sh: Installing in specified location - /home/crimar01=
/ARM/dev/nfs/LTP-official-debian-aarch64-rootfs/opt/KSFT_full_next ...
> make --no-builtin-rules INSTALL_HDR_PATH=3D$BUILD/usr \
> 	ARCH=3Darm64 -C ../../.. headers_install
> make[1]: Entering directory '/home/crimar01/ARM/dev/src/pdsw/linux'
> make[2]: Entering directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
>   INSTALL /kselftest/usr/include
> mkdir: cannot create directory =E2=80=98/kselftest=E2=80=99: Permission d=
enied
> /home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1187: recipe for target 'h=
eaders_install' failed
> make[2]: *** [headers_install] Error 1
> make[2]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
> Makefile:179: recipe for target 'sub-make' failed
> make[1]: *** [sub-make] Error 2
> make[1]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/linux'
> Makefile:142: recipe for target 'khdr' failed
> make: *** [khdr] Error 2
>
>
...
> Any thoughts ? ... or am I missing something ?

You're not missing anything, this is broken.

> (I think I'm starting to see this in latest CI linaro kselftest while the=
y cross-compile for arm64)

It just hit my travis jobs when I merged up to master:

  https://travis-ci.org/linuxppc/linux/jobs/617482001

Shuah can we please get this reverted?

cheers
