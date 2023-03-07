Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CAC6AEC03
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 18:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjCGRvE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 12:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjCGRud (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 12:50:33 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8952F97491
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 09:45:38 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u5so14942877plq.7
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 09:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678211138;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yhv7LZear3ph6wsxcQsO/iK2vfQrDtdCKXA/swyNU0I=;
        b=J9T3J0GbLLeXsCXjFADkP5vmhiQq2u6ZAMex6Rqh+ck2B5/DqLyHnD7FOwYOf3dHSx
         FksM/230oa9UMW9EKlmp5IgUgWD1kJ5vXjD9aZW0b7kmGMcuO9/VYjyxbtEbgEokDSNg
         zGBc8wlOa9GShBTrPv1ajkAzvabqKK2JvJx0nfrnTlaYGalWFq579IND9pogLnNSe8XX
         Q5e/R5Q8wy+s8qfQZ9PyU6XBgIjWnKbBO0Cai4isjeltt96Hj1RG38Ot57hdtvMh9WDT
         6WoxEkeaD6k5Q4y4jGHu5dWIYSgnRyyM1mpglaK+6Pi89+imyKZY8XBEy6ixPUfc6oKT
         ZCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678211138;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yhv7LZear3ph6wsxcQsO/iK2vfQrDtdCKXA/swyNU0I=;
        b=dRtwBhpWLUpalwamTlxGM+aauDolNtjhtnFY9HoYXTUzxVd1kGFgbT+ach6GhzQkIt
         qq3bZ75XlTOr5cioGY1TT3C8p0ABRMMv9N5Ww1KZVSCn0QEmNa7xqJv0eGAp6whyFROH
         pN8Fpsq7AuVupWT5is95N47OOJ0gqdo6BLBsNKJ2n7TbGo/KH84RSYV7m2sTEIJYvYXp
         gU/34pjcTL9OVZNdpYV2HGykzY11/nZcjO5WieRnUZrsXT1R5uo7LZFL5j4OzAEkEFBm
         RVIvXKFsUb4xw9LQaF8hHpNrlXGz6ilsiS5CD9eQio9ltEg3zHF7iSTKEfzyr4tdNcND
         gnSw==
X-Gm-Message-State: AO0yUKVAU0ABrMonPk9m8JmyN5VFTPBml4GTqZOUVJmF+u+BZ3TukaB2
        JQz8DaSneot6cQxmqNdhIGD8QEcq+Pk1CknS3FM2Gq84
X-Google-Smtp-Source: AK7set9ysW/xZSx8Rr4JVKf597QB67LGkfk5VlRcAFEkmMzjR162yelWbqY1bVY11q7tBV22myc/sA==
X-Received: by 2002:a17:90b:17c2:b0:236:6dc3:3e66 with SMTP id me2-20020a17090b17c200b002366dc33e66mr15902461pjb.5.1678211137976;
        Tue, 07 Mar 2023 09:45:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090a9f0b00b0023371cb020csm9503719pjp.34.2023.03.07.09.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:45:37 -0800 (PST)
Message-ID: <64077841.170a0220.c459b.1eab@mx.google.com>
Date:   Tue, 07 Mar 2023 09:45:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-1-g2da789cda462
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 8 builds: 0 failed, 8 passed,
 9 warnings (v6.3-rc1-1-g2da789cda462)
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

kselftest/fixes build: 8 builds: 0 failed, 8 passed, 9 warnings (v6.3-rc1-1=
-g2da789cda462)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.3-rc1-1-g2da789cda462/

Tree: kselftest
Branch: fixes
Git Describe: v6.3-rc1-1-g2da789cda462
Git Commit: 2da789cda462bda93679f53ee38f9aa2309d47e8
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:
    defconfig+kselftest (clang-16): 3 warnings
    defconfig+kselftest+arm64-chromebook (clang-16): 3 warnings

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 3 warnings


Warnings summary:

    2    drivers/gpu/host1x/dev.c:520:6: warning: variable 'syncpt_irq' is =
uninitialized when used here [-Wuninitialized]
    2    drivers/gpu/host1x/dev.c:490:16: note: initialize the variable 'sy=
ncpt_irq' to silence this warning
    2    1 warning generated.
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
defconfig+kselftest (arm64, clang-16) =E2=80=94 PASS, 0 errors, 3 warnings,=
 0 section mismatches

Warnings:
    drivers/gpu/host1x/dev.c:520:6: warning: variable 'syncpt_irq' is unini=
tialized when used here [-Wuninitialized]
    drivers/gpu/host1x/dev.c:490:16: note: initialize the variable 'syncpt_=
irq' to silence this warning
    1 warning generated.

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-16) =E2=80=94 PASS, 0 er=
rors, 3 warnings, 0 section mismatches

Warnings:
    drivers/gpu/host1x/dev.c:520:6: warning: variable 'syncpt_irq' is unini=
tialized when used here [-Wuninitialized]
    drivers/gpu/host1x/dev.c:490:16: note: initialize the variable 'syncpt_=
irq' to silence this warning
    1 warning generated.

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
