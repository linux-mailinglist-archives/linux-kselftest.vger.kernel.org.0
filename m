Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4926E151F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 21:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDMTXi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 15:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDMTXg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 15:23:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D34E40EE
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 12:23:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n17so74053pln.8
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 12:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681413814; x=1684005814;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gPDqaWF3sS+3CVRV6pquq0Ql95vrw0dTc/uLuPqiFhc=;
        b=y9ddKeHsXBMPGr1+IwPVBJpTzO2me87doej1DHAusGD9PvC1OaVdaigKxRnxmyLdH0
         CWEwHbPGqarAKg3AXp8XpT+3jj5oEORWfGl/cdXyUDucgYwjdVzv7YOuGhLeKrYBFyDd
         RbJMzZVPORBUpB96e2nkryuBR9Qv3DvcVI6HMkIFlJ/cWesSa/XHD3em+n67SeM/dlPx
         Y3Eh4EhtAQ0rL2TndOgjl4nppsHvyxu9hkLSQONUW619oE3BDaJT8sCU5tkNE9bF0lmo
         rYs4pyNiTWsEuDx4kfhDG99X7yHn8jGDVMCCGTgTK7j4elNs27Rcz7/4KChilQXdvIDV
         BG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681413814; x=1684005814;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPDqaWF3sS+3CVRV6pquq0Ql95vrw0dTc/uLuPqiFhc=;
        b=G+df3np6JnrLHT4Vu5oWWfCCGd9njljcC3+2q3Zc51kcMRyoh3h7LKDs90sLfgW2EA
         QEqVLHdxhcVaLxD4Aaf0ijUsniTqgba5HG2h2XNCw8+FUbX7ReqRNWqbfPezBDj5D8Vr
         zbGGqBfpPmQb36nJ8qvpjV1YDo0XxEuAKZcNT/lFb7P+AsEz9tfmIiAhyFg0we3K1DPB
         5E/r42I9NpWznG00yB2yLcN8VGYpcR7RlBrNDSacYQsw+yf3XHOuhqy2CK0BOwYhzw4K
         b6dYNdtBAqtX7iYX2f3luiFsSwXCvKJXRI0UNQ7pNbIMHNUc6f6J7Ng/S31f4+rr4T+l
         SH6w==
X-Gm-Message-State: AAQBX9fklcfGeJv/2HWbQPy1ZNmGSlShOwrKA43l8deYI+XDqqBsoQaC
        BVADP4nFPQ9ttWu+qD+eHzeuCw==
X-Google-Smtp-Source: AKy350Y47H19PXucdjs9lTuuMjfixkLUC8pAs66xUygSXE+3GwhR86a4mgowCZd1NTpunC1+KlaUDQ==
X-Received: by 2002:a17:902:b18c:b0:19f:2ae8:54b9 with SMTP id s12-20020a170902b18c00b0019f2ae854b9mr68514plr.32.1681413814574;
        Thu, 13 Apr 2023 12:23:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c10400b0019a773419a6sm1803796pli.170.2023.04.13.12.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:23:34 -0700 (PDT)
Message-ID: <643856b6.170a0220.39b98.4065@mx.google.com>
Date:   Thu, 13 Apr 2023 12:23:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-24-g91db4fd9019a
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 8 builds: 0 failed, 8 passed,
 9 warnings (v6.3-rc1-24-g91db4fd9019a)
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

kselftest/next build: 8 builds: 0 failed, 8 passed, 9 warnings (v6.3-rc1-24=
-g91db4fd9019a)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.3-rc1-24-g91db4fd9019a/

Tree: kselftest
Branch: next
Git Describe: v6.3-rc1-24-g91db4fd9019a
Git Commit: 91db4fd9019a08251a500157cf0d88de457e1a96
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
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

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
