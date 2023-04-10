Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D86DCCE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Apr 2023 23:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjDJVov (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Apr 2023 17:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJVos (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Apr 2023 17:44:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD096173E
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 14:44:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a25ea73d3dso4111295ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 14:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1681163086; x=1683755086;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i4tUfPnX41DLuNXxJGYen3Q0BthB+VPgv5MPHzQA2NQ=;
        b=dUbJomzDKRStRXe5EkSmN/dzNs1cygJUTHGV08PK/7K1XvxuM4QybSs64AUUT9L6KK
         QQHyOC/epZfEQGerF77Wux6vCftX9yrfobjBa6J9WLcISH4on//DrXI7DkJNXVAiOeG/
         cB6w6Sj5//IW6IzKqVNlYCiya2QAlyxuawGQLQCW6SV6490Wq4jLgrk5vkqppS6SCO+f
         8Dvgb7ALadO9X6egDjOdfH2SO+KtP20scuWz2ft5XqQ7c0DFIA9km0WzivphWGp4l0nC
         FyJDPkNkzIQqx7ZTVVrkhDCsE+QHerxZTCaR763KKhsT4Ky0fWgpgl8ybWYlSKzLB7co
         QLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681163086; x=1683755086;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4tUfPnX41DLuNXxJGYen3Q0BthB+VPgv5MPHzQA2NQ=;
        b=PGbkxq/cGkiiHcLF3QKgVyDhrRZ4SAKRX18lRzWDIPyGaOgJgCtpdQ5E4yprxO37dp
         xb+vp2RvzPhrhfBMrcJW+mYSkqrlZQtxdILo8zJ8qUHKvakNw5PzpBIn7S7HilIXkgLj
         MbJr1L6fFWJhQ/ccFXsNiwHB7v5tEfMYF1uRC3IXxq680AM45S6roRG54zY7ToMC8jmI
         KTqYSqmF41ySM3j41tBNdsrvndiMBCk86ZI3V4lkhnXJvoUJWAeP4jRyLxbiRsTd6FDQ
         vBCZXmcaamPdb7oKHxh9J4iihkdY6FoCuz45PXUGUUYJSXf6XG9dvljI6znJxwk8ko1o
         ww2g==
X-Gm-Message-State: AAQBX9f5p2NantFccyhQKS3bBaFkKrOSlFwj0Rs2gsMXiaBRRC9YPluT
        P2jAHsn1MeogBifCfGHb7+SviA==
X-Google-Smtp-Source: AKy350bL/EJkyrREuolLP2giSmPVGLN7G91bWu3nNHzSbDhTaTdjsqzRU41pMY5Zr7CwP6H/qujrqg==
X-Received: by 2002:aa7:9a5e:0:b0:62d:b26e:fc63 with SMTP id x30-20020aa79a5e000000b0062db26efc63mr550127pfj.32.1681163086221;
        Mon, 10 Apr 2023 14:44:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 11-20020aa7924b000000b0062dee0221b2sm8304256pfp.21.2023.04.10.14.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 14:44:45 -0700 (PDT)
Message-ID: <6434834d.a70a0220.94619.fa36@mx.google.com>
Date:   Mon, 10 Apr 2023 14:44:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-14-g5874a6a187f2
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 3 warnings (v6.3-rc1-14-g5874a6a187f2)
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

kselftest/next build: 6 builds: 0 failed, 6 passed, 3 warnings (v6.3-rc1-14=
-g5874a6a187f2)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.3-rc1-14-g5874a6a187f2/

Tree: kselftest
Branch: next
Git Describe: v6.3-rc1-14-g5874a6a187f2
Git Commit: 5874a6a187f2e814542d7fdf918fd29f79ff25c3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:
    defconfig+kselftest (clang-16): 3 warnings

arm:

i386:

x86_64:


Warnings summary:

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

---
For more info write to <info@kernelci.org>
