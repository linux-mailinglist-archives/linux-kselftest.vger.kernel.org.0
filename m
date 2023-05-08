Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD586FBB45
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 01:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjEHXIT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 May 2023 19:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjEHXIS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 May 2023 19:08:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A467B46A2
        for <linux-kselftest@vger.kernel.org>; Mon,  8 May 2023 16:08:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so1694347b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 08 May 2023 16:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683587297; x=1686179297;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+V87lh5qKkk6Mt/ToXZokAw7CHnmHXHwtBwqLD1qC8Q=;
        b=EIyx2pCsJ8yLk2ZQLI73v0mgC7+l+eD+IJegQFYLaVykKAdWHm3Dh8u+aZtFlQ9uHE
         shJtvCzuxjOESef77o6mwLuCZWCYa6OQw2Umd6tonZN3DIZuiKrKZwJJzWh/XG4fAnan
         6nSREupzYTEbkwtykpvaLluH+SweEB5BbNQ2vWiyPaLX5Agh8xsvDiegfl6jEIS9Kr43
         MUhfrpJDSj61CuDWm07vBIiPze2f3Y47o3C+b+XkqLLlzIDX9uAztn0c3vwKl7mEb5ww
         vzHYnsB1sXfVSUIGAQ4g5GB5W/4YoKVVz0amPWlYZpmG3eE1ccXarKjSZqo4cLgcaXfr
         ucrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683587297; x=1686179297;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+V87lh5qKkk6Mt/ToXZokAw7CHnmHXHwtBwqLD1qC8Q=;
        b=BWOBmh0O0UQP8mz5smWMRoulkvIdA4g899Yxi+h15WuvCVN4gDQoVJplMN/SXNAvOE
         mCjX65ukrOhaUbAQnaGJQm5BYJRwd2rVZnK9eCT588QKu4WDm28p/ub2m+APC1AZsvMd
         6mZEvg9XCHj2AV3h08aHwYJU3Asfb8R7KiHNu79zBPtloa4ugYnCHs1bLIV17c3uw5Jh
         e9hSNhAiJGPT6PwkiraF73znsSUbeydWEB2eHmR7kFIZJWC1KLvgLY5eue5vJV2W4LTD
         ftmow/Ot51pinl8cHK169SCk38vVBE327Hql4Dho3twU9zJyJbF+O4FFqNBZCwkXoQnl
         HpwA==
X-Gm-Message-State: AC+VfDyFEGSJjUfgMAXT2p01aH93wSoWLuFvd+FTgLKqQzveJ+l8sUbH
        FJ59XSBPto4oh9Nfy+Og9YupzvsoWnAbWLLmL3Yr2w==
X-Google-Smtp-Source: ACHHUZ5wRbupYu6XMky3p8FGgipez31brnJl/LcSNGRbmEdwJtfLKSp3uz5M+vGYa4bic7VbLcq50A==
X-Received: by 2002:a05:6a20:3d06:b0:100:900f:74a5 with SMTP id y6-20020a056a203d0600b00100900f74a5mr5185249pzi.56.1683587297129;
        Mon, 08 May 2023 16:08:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p21-20020aa78615000000b00638965d4248sm439809pfn.184.2023.05.08.16.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:08:16 -0700 (PDT)
Message-ID: <645980e0.a70a0220.353aa.199d@mx.google.com>
Date:   Mon, 08 May 2023 16:08:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.4-rc1-3-gd7eafa64a158
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 7 builds: 0 failed, 7 passed,
 6 warnings (v6.4-rc1-3-gd7eafa64a158)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes build: 7 builds: 0 failed, 7 passed, 6 warnings (v6.4-rc1-3=
-gd7eafa64a158)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.4-rc1-3-gd7eafa64a158/

Tree: kselftest
Branch: fixes
Git Describe: v6.4-rc1-3-gd7eafa64a158
Git Commit: d7eafa64a158cc9f1d26b3c615d4ada3c17c02ee
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (gcc-10): 3 warnings
    x86_64_defconfig+kselftest (clang-16): 3 warnings


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to=
 !ENDBR: .text+0x1423b6
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to=
 !ENDBR: .text+0x14252b
    1    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to =
!ENDBR: native_write_cr4+0x4
    1    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: .altinstr_replacement+0x1d1b: redunda=
nt UACCESS disable

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
defconfig+kselftest+arm64-chromebook (arm64, clang-16) =E2=80=94 PASS, 0 er=
rors, 0 warnings, 0 section mismatches

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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 war=
nings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: .altinstr_replacement+0x1d1b: redundant UA=
CCESS disable
    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled
    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 3 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to !END=
BR: .text+0x14252b
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to !END=
BR: .text+0x1423b6
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to !ENDB=
R: native_write_cr4+0x4

---
For more info write to <info@kernelci.org>
