Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB377072B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 22:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjEQUFV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 16:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEQUFU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 16:05:20 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDD149F4
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:05:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae52ce3205so8364035ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684353918; x=1686945918;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7W8mLA3rHXv7hli9TJ1zaVfENo2UOwhbRxJPAdrHVGY=;
        b=YGFWTKwFCZ7oDtIbwgXfRmi00s2R79LSOvhSlYPJsVnh2BEca0cMX0VSUwa7BN4HUU
         xjeyp9OVhE5ChkqYwrZRCNILSno+Gf70kvwbhBARXSwEvSnJEnzN0fXHAIZn7VyMAkHl
         /UjK7+1tTC0vvGtM4e6i28eh44mSo/MwSCWfmhzGjbwi/nukVeLkozzAA4W/2XH4LbBZ
         UIJM8jYYWmuFl61kzSIRUsm6i20pY9bRLKSmA4qILawJwxSoC1WLxG9N8c06AcsNEJwK
         PTRmnWmZMl749aRTiML3WJhnVCgx+Uaid+olgPpBSfnM/idM/7NefZhMwnJO3B6tdPWO
         l7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684353918; x=1686945918;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7W8mLA3rHXv7hli9TJ1zaVfENo2UOwhbRxJPAdrHVGY=;
        b=VDrVybP0wcuAnHSBGyd8b8lNEXK94dVMC0UdfsmdikKFJAJYQ0P8c71J3H4HUb3hXB
         c3ZuVOSGsyZRnHTNP4W38D+FOU2QtNyul3xP7Dk4ZGUa3cTdViX/oxGTjaZvDtxvoxJv
         KXiOzZXKabbkZq+a6351EmtwAGZgNu5AMexLbARLN5JEM/FbTXZbCAGfdzMCxCJVCkXx
         SmmRSO3RBAeWqD+zN2Q9bbwwkJbkgI5mxrQsSA8K/LZmwmN8WKvh5X7e5IHhW520SaFm
         K1+GMIDMU0I7kmXfxT6JM2O0ppv8O0bor/BTp0l+NVXrO0uPtj8trX5dWSxbUbdIg9QI
         I7hw==
X-Gm-Message-State: AC+VfDwDXVAQ1NHeyAEY8T/SVkXjMtAu9HrwplsddonRaW4t2hJv7Qkh
        rwoqr3L1Anl4chIY2XPunbopsEsPv+dKt12V8ggS7A==
X-Google-Smtp-Source: ACHHUZ5RxS4Ke6FAvNCi3yOIY0RahP6lv7sLuayAYPEim8WVLB267JJIDYDMgmHxF1InDsPEGHEWyQ==
X-Received: by 2002:a17:902:9009:b0:1ae:4ba0:af86 with SMTP id a9-20020a170902900900b001ae4ba0af86mr4299445plp.64.1684353916594;
        Wed, 17 May 2023 13:05:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i6-20020a1709026ac600b001aadfdfcd06sm13268113plt.299.2023.05.17.13.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:05:16 -0700 (PDT)
Message-ID: <6465337c.170a0220.6207.9b12@mx.google.com>
Date:   Wed, 17 May 2023 13:05:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.4-rc1-5-g3ecb4a459a1e
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 2 runs,
 2 regressions (v6.4-rc1-5-g3ecb4a459a1e)
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

kselftest/next kselftest-livepatch: 2 runs, 2 regressions (v6.4-rc1-5-g3ecb=
4a459a1e)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-5-g3ecb4a459a1e/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-5-g3ecb4a459a1e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      3ecb4a459a1eeab1ad135f87057aa3ea4c9af1b8 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/646520b685908320d22e865c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ivepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ivepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/646520b685=
908320d22e865d
        failing since 141 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646527fb66e7da4aa22e85fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/646527fb66=
e7da4aa22e85fb
        failing since 211 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
