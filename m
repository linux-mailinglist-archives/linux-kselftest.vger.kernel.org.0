Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F9E67BB94
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 21:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbjAYUDH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 15:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjAYUDG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 15:03:06 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD532E52
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 12:03:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c6so18954943pls.4
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 12:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nhK1KcRAcCK6pcWI0CmEcL/Px6h1+Z3lNeZH1AvBqrw=;
        b=oU1ymYE2qykyaPIcZ5yVUi//LMTq/kzLipgpwgNbEUwvv1dYsBUh0WNe4NHH0q2+e+
         sup7pqONU2wsm/dsZXj/gc0ROqkNAxY36SWUMtvW+t/fBDdyAWY8bFl6VBxwpfdGzNy6
         68TxIkbSMY8UhEJUxoL192rMxa1F4eD9ATenUe+2y2b3Y5g1pb3Mu9XHHElZ6tOcsXCH
         /DtpFSYZOrLulm0OdDQC0sJqr7MOuOIiYfhr2fPFd3S5pXssHBOZdgH27M0eqzl5ee2H
         1fIC6cxYHM/Br2Zs4rVTzMyHn36o6bAX/rgEuVODyR9oXOoFugjNwPNjZhFoB/5AXglz
         4vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhK1KcRAcCK6pcWI0CmEcL/Px6h1+Z3lNeZH1AvBqrw=;
        b=ijx3tBzXlCYtwVAZMSsg/VIGd+22dzMwKgfSgyfOiedqBjKjEGJOsbw7r1hIBvuHXc
         ruN0MSaRrOyQ1qczNsP/J86dPxl0jKTZK5n2MA2ON7M2un8q3IKwVOO2ll9bJH9+KMos
         DUAi5Dxsl/F6tR93PUI4XOQ3hN/urSvtN0/R824gQdFiNCaPaFrrROX8aTu4sBtIuN9o
         zQkEL4bLV4aPeC0bgT73ZP1919KyDrfXbNHaqPsNSzxhKhQxEWZqwEREux3yiN1PhLKP
         +bwzJzQAfGhS6dTIbOpFFLOSxSj6tjWcBQh2tozniSZay1qZOB/ApSdm8HfoxfQ1ydQx
         NqJQ==
X-Gm-Message-State: AFqh2kqmKai769ZXMiV4e3NhUdCXbgGPj95Tp4PuBCaW2oDiMlJsGHod
        rMmOxGrngp9Od0qWfxgSnfqgOHIUAfS3w/VAg7A=
X-Google-Smtp-Source: AMrXdXtqWfjYJ38gGTkEHa/D8y+bmt9TJmwtw+tJXqqOFu8PtjjGBuIgzITVUBxNErDdhD/Ezdf2og==
X-Received: by 2002:a17:90a:f604:b0:229:9627:80b2 with SMTP id bw4-20020a17090af60400b00229962780b2mr33803293pjb.46.1674676983478;
        Wed, 25 Jan 2023 12:03:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e23-20020a17090ac21700b0022bae41c820sm2014728pjt.56.2023.01.25.12.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:03:03 -0800 (PST)
Message-ID: <63d18af7.170a0220.de60b.385e@mx.google.com>
Date:   Wed, 25 Jan 2023 12:03:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lib: 5 runs,
 5 regressions (linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8)
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

kselftest/fixes kselftest-lib: 5 runs, 5 regressions (linux-kselftest-fixes=
-6.2-rc5-1-ga49fb7218ed8)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | clang-15 | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a49fb7218ed84a4c5e6c56b9fd933498b9730912 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | clang-15 | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d17ecc7fbf0ed288915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest/clang-15/lab-bayl=
ibre/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest/clang-15/lab-bayl=
ibre/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63d17ecc7fbf0ed2=
88915eba
        failing since 99 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d17a45e8f8440229915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest/clang-15/lab-coll=
abora/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest/clang-15/lab-coll=
abora/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63d17a45e8f84402=
29915ebb
        failing since 99 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d17be7d3ee09798d915ec9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest/gcc-10/lab-baylib=
re/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest/gcc-10/lab-baylib=
re/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63d17be7d3ee0979=
8d915eca
        failing since 99 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d17a091c433e05b8915ef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest/gcc-10/lab-collab=
ora/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest/gcc-10/lab-collab=
ora/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63d17a091c433e05=
b8915ef8
        failing since 99 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d17aaba4a612df5b915ee2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63d17aaba4a612df=
5b915ee3
        failing since 98 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
