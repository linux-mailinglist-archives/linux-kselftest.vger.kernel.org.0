Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C92612ADC
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 15:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJ3ODG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Oct 2022 10:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ3ODF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Oct 2022 10:03:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C3CB49D
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 07:03:03 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 192so8612409pfx.5
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IhOa09NtLqeZy33tpaikQ4pqkBVgvUwlvq4Usy8Rxw8=;
        b=fdbtmPERRfUWb6YXCn419m30huaCwjfjLuP/V6UNRG1ZvxuFwQq2d1iP1S3ulmkaQT
         /9B61sGhDZSNQWVQdGV4DkNZtezGQRvyUQ+4knOF6NWNi1pm1pIVkPguF1YrP3q4D/rh
         06Lhmc+gAq6nWcDIFoNQ/Lv6H5q4JTqc56zy1lr3MtlUnROo8lNAmgqEOn9g2X0nbJ2F
         6xKJ+QDzGUDNaL93jaWYRyb2zJzGqYZPRfYJt8HUb/BOvIsCQ+nxThTilFUsUR0WziVS
         Do4nk/ENIt/ZwEhDymL38tVqaS8xSQ6MG2A4K7xJaQ56PwlJ7viN2jnMj3mL3ouQaaay
         7IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhOa09NtLqeZy33tpaikQ4pqkBVgvUwlvq4Usy8Rxw8=;
        b=DdZvg91R0eYSV22p6u6d7zUqgm3vNx25PL6R3bRspkORpk1tfCxBOt1NdSVtRtEpSp
         XbgUXlPipX8erSgQdvvqKoHrAn5lohBa9xWCSPCoZ6QY2A9R9pHSTCiZ7L5WeDsOAE4A
         9xJqT3j7DQFs0W+eyYyRhB++fCUPbAlz0wxWjNNdLXKbmudpLBsl7F5ODbnlnShEsrnP
         nPVuji/ZHN1zf16HV9CBM71A/6PlEu8MWHROLVC6kr/Sl4ABQhUvs6U1RoxJaYKbfFiQ
         mhHpFMwjUxW64gFlwopptltx/yOcf2Q+rtvLAnSrx7IJYWWNbbtqciPEdoFHObmOErNp
         G8dQ==
X-Gm-Message-State: ACrzQf3optjsrk079NRDtAI6adlONAW0QTotlOwcOTwisTe18Wus2gSC
        VWSAg6lQd6JDLZfrd1jS8+VJgQ==
X-Google-Smtp-Source: AMsMyM6KMaEA9m55pPLvE3jshHaAmoDT1TxH9lEm08vtNDoSqVXKKGGIm6/QDtUxD6JoVkKSdNduDA==
X-Received: by 2002:a63:441a:0:b0:46f:79ee:917c with SMTP id r26-20020a63441a000000b0046f79ee917cmr8140256pga.165.1667138583454;
        Sun, 30 Oct 2022 07:03:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090a590300b001faf7a88138sm2425379pji.42.2022.10.30.07.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 07:03:03 -0700 (PDT)
Message-ID: <635e8417.170a0220.5a021.3945@mx.google.com>
Date:   Sun, 30 Oct 2022 07:03:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-lib: 5 runs,
 4 regressions (linux-kselftest-fixes-6.1-rc3-2-g3d982441308e)
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

kselftest/fixes kselftest-lib: 5 runs, 4 regressions (linux-kselftest-fixes=
-6.1-rc3-2-g3d982441308e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.1-rc3-2-g3d982441308e/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      3d982441308ebdf713771c8a85c23d9b8b66b4d4 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/635e75f7d70d3539f0e7db93

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest/gcc-10/lab-baylib=
re/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest/gcc-10/lab-baylib=
re/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/635e75f7d70d3539=
f0e7db94
        failing since 12 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/635e75efd70d3539f0e7db82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest/gcc-10/lab-collab=
ora/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest/gcc-10/lab-collab=
ora/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/635e75efd70d3539=
f0e7db83
        failing since 12 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/635e763a9aae86c280e7db7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/635e763a9aae86c2=
80e7db7e
        new failure (last pass: linux-kselftest-fixes-6.0-rc3) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635e720a43925c2935e7db74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/635e720a43925c29=
35e7db75
        failing since 11 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
