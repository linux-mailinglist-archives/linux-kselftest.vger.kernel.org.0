Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D631F7233E3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 02:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjFFAC6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 20:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjFFAC6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 20:02:58 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A50F7
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 17:02:57 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-39a3f26688bso4602956b6e.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 17:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686009776; x=1688601776;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YJT6ubZsGjreRqIADsAeto8Lx9AnDjVB84AVNPfrNpM=;
        b=R/xaN2Dl64Wx8hySso49kB/qL3/6PT6bhUwk8Ls+WjHpdrcxzKcR7oHIGGHT0FcmSC
         DvMbNTUIshEILZ7ctg5RzT2x0x1IQy5QUXqjH9GXlEzHKNKvtgBUCQl0GUpL1bruljm+
         vqCb5/5xIdwYRoeTpQul5A1cMrMl8qUJUrw9MriVHcMH1AoUuHox8ZEtzk6eIY/J0T1N
         L9vl0JL/zjsWnqVhzdwMnW0tjg5c/v9TmsTjanOs2e4RA/IcigwBDE7VwjVc5V5jJgyn
         OePztSnBPTi6CG1Ae7wyFutdKZu9DYJ1ve1SRdHN40Rte76IIkDoHXtiWA/Hzouieqck
         vTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686009776; x=1688601776;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJT6ubZsGjreRqIADsAeto8Lx9AnDjVB84AVNPfrNpM=;
        b=M5UVupxijNkHfb5YVErR9/iuh21o9BkLSg2QItb4SeYCiGQYfi0bKqiQirdDPNuQMJ
         1GtaTqTIZDiQNAIQa0DTs/fZ2lXLvaalLpPFPT7o2FcABCPDFwsdoT5HOruUUEUMpqE/
         VFr0TNhHSEWvKzoUt/8+fUn2RgQScgjbLQgb8SSW3sxr3KHjQZVyO6/vedZAw9whEU0K
         DzAKG7XNwc5njl9bsLbeSoGLNClGqLWyGmqWuA4zPxxd3rf3VPiAeeB3V0moITyXCGiU
         2R4JAjXpSvZ/FUOvWAwD6dCWTr084rgWTwg8axNeq3z1LKI4G/zkJs70tkmNO3rHVwqJ
         fa5g==
X-Gm-Message-State: AC+VfDxRH05nPUQNgORXF3Kt8qDVtpMBdw+lWMcfZMg5uByd6+8l1Vw1
        jAuVUsmJmro1sdEVjvm8wUtVxg==
X-Google-Smtp-Source: ACHHUZ6HoGWZCWComUSU2uvQOrWonj1yI+33S+mJgiQ1iyFZIOjMqMUx1RAL+eE2CNJ+bq/qmr8OPw==
X-Received: by 2002:a05:6359:67aa:b0:125:800e:3105 with SMTP id sq42-20020a05635967aa00b00125800e3105mr786657rwb.3.1686009776341;
        Mon, 05 Jun 2023 17:02:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v24-20020a17090abb9800b00256b67208b1sm8172329pjr.56.2023.06.05.17.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 17:02:55 -0700 (PDT)
Message-ID: <647e77af.170a0220.faaa7.ec9c@mx.google.com>
Date:   Mon, 05 Jun 2023 17:02:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc1-9-g4d1deb59f3ff
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 2 runs,
 2 regressions (v6.4-rc1-9-g4d1deb59f3ff)
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

kselftest/next kselftest-livepatch: 2 runs, 2 regressions (v6.4-rc1-9-g4d1d=
eb59f3ff)

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
-rc1-9-g4d1deb59f3ff/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-9-g4d1deb59f3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4d1deb59f3ff643bd2d442bdd4dd5f58515a1629 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647e63d1b2ae34de19f5de41

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ivepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ivepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/647e63d1b2=
ae34de19f5de42
        failing since 160 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e6c8fd9585d0f57f5debd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/647e6c8fd9=
585d0f57f5debe
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
