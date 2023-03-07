Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217C26AEAE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 18:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjCGRi2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 12:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjCGRiE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 12:38:04 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C62394767
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 09:33:57 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id ky4so14941586plb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 09:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678210437;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=31QN1iVQ95oOC34zVaFnApZFp5dk6W4TiJlAYjdShLo=;
        b=pcf2w887VFKvSGdiYWztLatB5NWzneP9AznF47eWPZSvN1tZgyEIiTMkZm3mEXdjpT
         k1mJ13pUI1HxsYC5h8zV9+Gpzg65PVfEAvak1D9+Npuk0QOcI+kaOfPBODGxGUUffSD0
         NycqT3XpuGN79947Os7DcER4kNIfxq5FGIxf2ltup6UnouGRw38QlB4k1tbCiPkyL3v5
         D36CX9DbdRTQjdfD3sRSDp/8I/Ku6nFuaqAs7CYGX2h/vAqr5T+YCoAHBTwCKa52xAbW
         Kfzh64alUE+sr5c9/Nqsp1QPVpGKBblUlJ2peZGy0IKNc/r8ia1E+lDA/j8Urte9NBM4
         g+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678210437;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31QN1iVQ95oOC34zVaFnApZFp5dk6W4TiJlAYjdShLo=;
        b=w68eojuJkgh1UF9vsfVl0083hSSPj11i1gL2PCc/in1Dm2GhzE/bspMI7gIROn0A/R
         l0Q93Z4x58y/tIPiKQcTKSjYOI7iWT1arXfVtDF2W3DYM6FMUHevTbQlf0EnIP7MPJTz
         +unSqrd/UJLhnHOskVcKYCe4qz5AoZHXaQmJIlcQ6xo0VkL01XZCnjepRwfXjFlrjo8F
         Ba6NR0rwcqPqVzWZ9lOw0AAfS1XE+tT1+m5THsYqE6OFNWiQGFOpP3i0y4CRtR/oTcPi
         aafYR4sFlYydOnMQyY+Z/itj4o2h3+mgSp4Hy+NO4PstfiFa1rAm4OrIHz5uOAytkOk3
         L6Yg==
X-Gm-Message-State: AO0yUKWw59ByINRijKRF63G6tT4nu2MNpVmmb5VvQIe5PO4chGi2au6x
        b6Y6DO4Y//Xt+2ncMSTmErik0yjOqLENaflwy3sq3Vgu
X-Google-Smtp-Source: AK7set9ETHzXgQFJRUgXU9HvINnFXSggvZON0rXzfYfOTymM4tl5svA3faKe5eetu3g/ZfcKnCK5hg==
X-Received: by 2002:a17:902:e88e:b0:19e:5965:8694 with SMTP id w14-20020a170902e88e00b0019e59658694mr20182392plg.60.1678210436940;
        Tue, 07 Mar 2023 09:33:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902e5d100b001948af092d0sm8603432plf.152.2023.03.07.09.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:33:56 -0800 (PST)
Message-ID: <64077584.170a0220.efb31.f44b@mx.google.com>
Date:   Tue, 07 Mar 2023 09:33:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-1-ge1e17d7debf4
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 3 warnings (v6.3-rc1-1-ge1e17d7debf4)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 6 builds: 0 failed, 6 passed, 3 warnings (v6.3-rc1-1-=
ge1e17d7debf4)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.3-rc1-1-ge1e17d7debf4/

Tree: kselftest
Branch: next
Git Describe: v6.3-rc1-1-ge1e17d7debf4
Git Commit: e1e17d7debf486fd3b757df9e009b8d109e4be43
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 3 warnings


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to=
 !ENDBR: .text+0x1463d6
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to=
 !ENDBR: .text+0x14654b
    1    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to =
!ENDBR: native_write_cr4+0x4

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 3 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to !END=
BR: .text+0x14654b
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to !END=
BR: .text+0x1463d6
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to !ENDB=
R: native_write_cr4+0x4

---
For more info write to <info@kernelci.org>
