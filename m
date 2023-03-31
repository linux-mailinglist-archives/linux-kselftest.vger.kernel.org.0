Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73256D2574
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 18:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjCaQ1l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 12:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjCaQ10 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 12:27:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC38D27007
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 09:22:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so23912703pjb.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680279697;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=37qqI/bwK1/tmljha8vDWtoRRd+oIltmRl9kyhy7WtA=;
        b=ytmF1CfUEwG24Q4vQ/LHpas722PGcd0/SBJ6dLaXwnuSevD0Tvalx7F3wyEA8C19pG
         H7BSZeT73uwspKQ3RaQIZa9TsB4zdlYsamsjcuoPhU4W/rSpFcXpMoDlhIQbWRcvDxRW
         qd4to43HUIbIH7dwLNTZ1seyGGLpSoCoYwQprFtTDrQZ8SjkP6rjOgRkybmT0idCbv+R
         aQgEgWARBhyk1Q37wanCGP3xtaYzn0ciFa5E/Av2lVhswfLMVE83xBu4WezWKEkCBDIJ
         EWwPSuQoR9uX0FW6dKQ0HVlplzMPJsoEZCzoPocy3odtnEwa4Y8om+WPEvwq0HHu8yJh
         enJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680279697;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37qqI/bwK1/tmljha8vDWtoRRd+oIltmRl9kyhy7WtA=;
        b=b+bTJw2Z4G55vTYDraauumCgGqPD6h5F6MLbNsizS1FABJ8COJO4+FGr/grRwNVB6h
         Zb/dpp/+24DtP8g0RUze0p3iMIXf+Y80xuV7aRWodqWh77y5+75wam/DjcQF4gj5TVV4
         7veEScIMnGJMG7PtCpLr/ncrQE6kuhkJMt8lA0yh5AiOpKYblKEGOlDtkDCagu/eEXSS
         p9afCenXE9hGyC4vM1onSWn/uP71xK4GneCX/1CumCTlh3weU3Tw/Op6vuGN1ayVFFI8
         QGZhGGTV4nJvVnFuhBdBzk025eUgV804n3oMlvmeTWwF2t09eWMeE7W7j3r5EWcqDFil
         /W7w==
X-Gm-Message-State: AAQBX9eUK8Djd6dQvtu9pXARxPJM+q/wnTLJemD4j3FvYgv21IRpo0tx
        URx+pUQTwTh/S8uYEg5+QZi0UA==
X-Google-Smtp-Source: AKy350YAdIgExMESLTGRAywVD7gQLSVvVNBmjmQId6PN1MKJqCm0k3Fan7WS7Z/xOXdDaUAblxjQ7g==
X-Received: by 2002:a17:903:22c4:b0:1a2:8924:224a with SMTP id y4-20020a17090322c400b001a28924224amr9780069plg.25.1680279697036;
        Fri, 31 Mar 2023 09:21:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k2-20020a170902e90200b001a19cf1b37esm1803410pld.40.2023.03.31.09.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:21:36 -0700 (PDT)
Message-ID: <64270890.170a0220.31a27.3d95@mx.google.com>
Date:   Fri, 31 Mar 2023 09:21:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657
Subject: kselftest/fixes build: 7 builds: 0 failed, 7 passed,
 6 warnings (linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes build: 7 builds: 0 failed, 7 passed, 6 warnings (linux-ksel=
ftest-fixes-6.3-rc5-1-gf1594bc67657)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657/

Tree: kselftest
Branch: fixes
Git Describe: linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657
Git Commit: f1594bc676579133a3cd906d7d27733289edfb86
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:
    defconfig+kselftest (clang-16): 3 warnings

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
    1    drivers/gpu/host1x/dev.c:520:6: warning: variable 'syncpt_irq' is =
uninitialized when used here [-Wuninitialized]
    1    drivers/gpu/host1x/dev.c:490:16: note: initialize the variable 'sy=
ncpt_irq' to silence this warning
    1    1 warning generated.

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
