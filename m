Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4604459CD49
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 02:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiHWAoD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 20:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiHWAoC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 20:44:02 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D42619008
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 17:44:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id g8so7530160plq.11
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 17:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=X6HTLxYGft4RiDl5n5FaEdJltxWAPE5OTaVMo/traPc=;
        b=lJhfWvz3nnu8b85BYBRYSo6fccWb6irR5yuDVEh2Ju9PeixIUatbvhEXtn0fFAavYj
         kDNM1Ck+piaKcVwkX8DjWlTULMhur3Nk/77EhjkoSxq4yQ04AydTPV8+lhUoZ3PI/9W4
         QTRqTWhyOjATvmK28aWH1RUt/rddawukYoe/YubAYscyZQD1cqzkFMS7ZprNxkLHZM4d
         POAcdSnONo8lbFIUj2fCtyQiwI5DHMSpDigG1CU9fuZOwFd+8m0y9E+VyhTc7cJ+xmfV
         5byqHl5NQE80lVmFR3P5+9wDYb8yr5FlmhjnlBQXxB3oVgkJgpEdlOP5zPZX6YGitG+j
         s2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=X6HTLxYGft4RiDl5n5FaEdJltxWAPE5OTaVMo/traPc=;
        b=NOVLYIy5052UDXdmBq6a2R2PZu2DHbLJCNS+9xaFcC0UsBg3UlMpPetl3O7PknMxIK
         vZOy9IZC/5ddwSR3Zz7+X0d41zqkZhsWxjsyDuhuDEAk/WAjknh0zyJsvGMr7btmZ0su
         VsMFsBTszzNajRZyFpS0tQ77YvYNkHKnBiIeMhFNADQRfEEFQDs77s/Eht6Fl6V8/cku
         LPvrxS0/wyejsY/xID6FZujzEkkIL7rcRwvi2mh3CBamcU0QFlNl2snscjtQz8sJWZsj
         jvzSlrvhjka+S3vL841057IWRYBinRrTyl2p2zfpuMv0Ao3TWlc6LOzkUfK4U4pboNIj
         VsaA==
X-Gm-Message-State: ACgBeo0WUF0WEJ4I8XYREkxopBYaQKcAftpjWW8ATXv+3rSPXLyVMCx9
        a6qdkUa5oj9MsK1QWxpTovVRCQ==
X-Google-Smtp-Source: AA6agR5rs0iHCG9rjD6X8pcV+A3GDa9lvICypcMFXbMCvSw0W+HRaI+wgTlS76CLQZl1gra1eAfIJg==
X-Received: by 2002:a17:903:1246:b0:171:5033:85c with SMTP id u6-20020a170903124600b001715033085cmr22297293plh.146.1661215439980;
        Mon, 22 Aug 2022 17:43:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b0016d338160d6sm9071377plh.155.2022.08.22.17.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 17:43:59 -0700 (PDT)
Message-ID: <630422cf.170a0220.a6167.0766@mx.google.com>
Date:   Mon, 22 Aug 2022 17:43:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux-kselftest-next-6.0-rc2-1-gab7039dbcc61
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (linux-kselftest-next-6.0-rc2-1-gab7039dbcc61)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (linux-kselftest-next-6.=
0-rc2-1-gab7039dbcc61)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/linux-kselftest-next-6.0-rc2-1-gab7039dbcc61/

Tree: kselftest
Branch: next
Git Describe: linux-kselftest-next-6.0-rc2-1-gab7039dbcc61
Git Commit: ab7039dbcc61229aa635357b847a643973497561
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, clang-15) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

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
defconfig+kselftest+arm64-chromebook (arm64, clang-15) =E2=80=94 PASS, 0 er=
rors, 0 warnings, 0 section mismatches

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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
