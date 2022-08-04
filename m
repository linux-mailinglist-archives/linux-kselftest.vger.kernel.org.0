Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8E658961C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Aug 2022 04:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbiHDC3P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 22:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiHDC3O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 22:29:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A568311812
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Aug 2022 19:29:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p18so779260plr.8
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Aug 2022 19:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GSy0A2A4PPtaXpd9+sB/n+IUCNARV73K4NXRcE8eU/4=;
        b=XFusSHwaWtZR4WyfNXEg2RL+7XFgl2ie1CdH+784gkt7QNt6vg+udYcumQm7gEwoOZ
         ydiLnizLFI5Xfioxwq2HKslEInNBKjBkzdeOhHqPbYxxwR1zcxZ7WqpEiSd6/rt1VP4U
         Z6/U6crabahncoe367Ead0MMw1d9Euvlctffbvh+QOZwbg4Ii22LodVa875MvSEqwO1k
         Qxyn7A6R9fTcgtq0h8XnLGxq8wgQjlw8lpdXqkjWUbTQNwMhrTN+xfnXU0bx4AcVHP2N
         VVTa0cPaOA/hYaQSdCSRCv5OaYGULNDO0CT40fmSLXkM1++dUcPykIZOE8OXpmExRzN6
         tWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GSy0A2A4PPtaXpd9+sB/n+IUCNARV73K4NXRcE8eU/4=;
        b=KPjnSG3Oy/xpJt+TzUeDbYUBgl9Le9uFkz4G1+/uSRVchgOhhmeqw0sRv3EYXe8vD9
         7f3o5PnO4NJw3XkJRVfcbgCReLI+rdo5fQ96llgogoMY540TRsrJkLEyI6U6MoNzCOuP
         RLGqwrynNvQ0TGw21spueXe4sLJs0VOT2Td5bs/3JVYaHsOWNenI8Cc0JAKOMuD1ETPX
         R7GH0bJ/s5lIxiKeShHln+O4LRPSe35oLYsiAsQuGdq4j8ESxMqaHLmtnUCBzt9iib2C
         dogGLOE9hFwHGGlz69oByZ/8bUhNX6rgFKVcL7EgtMrF5yPF6igrEqsxuLEiQ1uMVLin
         xtDw==
X-Gm-Message-State: ACgBeo0Y2nXKeo3sHai7XFYBleZB0Vyfp+jRPAd+wBFyyCu1Y0A2YJGI
        U7zWkn9qT+eO0aNrJHS43yEQTA==
X-Google-Smtp-Source: AA6agR5TytWzZIrQKRzWhx1eVGWVskFCcqzZAmP3II4dCJWRcTxHZK59yalHr7D5SD4koP57+HyvGA==
X-Received: by 2002:a17:903:449:b0:16d:d781:313a with SMTP id iw9-20020a170903044900b0016dd781313amr26585081plb.75.1659580153139;
        Wed, 03 Aug 2022 19:29:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b0016d2540c098sm2649864plk.231.2022.08.03.19.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 19:29:11 -0700 (PDT)
Message-ID: <62eb2ef7.170a0220.aa3d1.534c@mx.google.com>
Date:   Wed, 03 Aug 2022 19:29:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux-kselftest-next-5.20-rc1-1-gb1d34b1375f97
Subject: kselftest/next build: 3 builds: 0 failed,
 3 passed (linux-kselftest-next-5.20-rc1-1-gb1d34b1375f97)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 3 builds: 0 failed, 3 passed (linux-kselftest-next-5.=
20-rc1-1-gb1d34b1375f97)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/linux-kselftest-next-5.20-rc1-1-gb1d34b1375f97/

Tree: kselftest
Branch: next
Git Describe: linux-kselftest-next-5.20-rc1-1-gb1d34b1375f97
Git Commit: b1d34b1375f97fb1e67959d863e0e335bf3d2069
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 2 unique architectures

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
defconfig+kselftest+arm64-chromebook (arm64, clang-14) =E2=80=94 PASS, 0 er=
rors, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
