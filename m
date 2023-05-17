Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8371D707204
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 21:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjEQTZc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 15:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEQTZ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 15:25:29 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A045DA273
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 12:24:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517c840f181so608351a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684351493; x=1686943493;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kcyAy4WWgOvfHwI75DtcNaQZ1/GeyRg3rJlBrP69S3Y=;
        b=S/fkgV7V8NDaZdJ9cIDHoOZ+GjZiGo8FLP0Uj9Ah4dJJ1UVmv0Z0Q2oQm0ZOGA6zhC
         jxLCwvzmQ6jZPl4Mg35a2WrQDvzddXjSiER72bOeLdXZZX9B67TKV2sccZFGjXs4V1AR
         etv5K5b8sfHIczRL+Nq4wMrkPKEI/5oUppYtjDRqw3M77O0N5AezYpCtmIGKg8nl8pb/
         yFfGW1anCSUqRQKTM1XEAp1Hy0cq6nX5vTpxnb9pl64maQjBsGMAyx9UjMxHEC56maXV
         vhSVeELm6kEQVX8p/PqISC4J99E0UeJyoLJuAWsU76wC96ndQ4WPDMDw1vvNMdHby4cM
         BX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351493; x=1686943493;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcyAy4WWgOvfHwI75DtcNaQZ1/GeyRg3rJlBrP69S3Y=;
        b=cWEs/SaBxzj7vguclbJK5+0BrCqzys90yLOaJk9nzoalnXWcqCqX1XMEuJ8GcuL3rB
         sd2hf5486/b3I10yItWPeIs6ZpLqR7a1TLTcg3/xLH5qbALTXTb71ePkwaSbhWbucdId
         5ZuWOrLx8ZefcE9fd6RTMSwvwwqnFKa+FZa3Nm4WSumumyR4/MkUCBtpfugCg/ThKKmL
         3oA4Q61AtubugLL3iHVIkHYS8UapCLnIRNc0RF1LhgmTsxeeakYMOMGh1Hw0zrAoYMoN
         rncpToxtHcl1rhAOqVh3VIexk6xweMWxKSKXLBpgvz6z+JNBPhd/g0iiSfAu6fyA80iN
         OtGQ==
X-Gm-Message-State: AC+VfDzDgiARtQl7u9PeRfNECjAdXDzYD+1u9JEpr1kKGbmMKifo9mLO
        F23mRmrrHq2kl07Ij8CiW4QzEazYxRxwQhqrsFhfTA==
X-Google-Smtp-Source: ACHHUZ5Bjj96Ye4eVFOX8DvsjQxCtWndCpwJKVk9EzQcbvUeCW1+YLjaiaSb2eP0Rtj6KhTC88V53g==
X-Received: by 2002:a17:902:a503:b0:1ae:197f:dba9 with SMTP id s3-20020a170902a50300b001ae197fdba9mr12527205plq.2.1684351493391;
        Wed, 17 May 2023 12:24:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709029f9600b001a1c721f7f8sm17941395plq.267.2023.05.17.12.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:24:52 -0700 (PDT)
Message-ID: <64652a04.170a0220.4c0ca.32fa@mx.google.com>
Date:   Wed, 17 May 2023 12:24:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux-kselftest-fixes-6.4-rc3
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 6 builds: 0 failed, 6 passed,
 6 warnings (linux-kselftest-fixes-6.4-rc3)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes build: 6 builds: 0 failed, 6 passed, 6 warnings (linux-ksel=
ftest-fixes-6.4-rc3)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux-kselftest-fixes-6.4-rc3/

Tree: kselftest
Branch: fixes
Git Describe: linux-kselftest-fixes-6.4-rc3
Git Commit: dbcf76390eb9a65d5d0c37b0cd57335218564e37
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
