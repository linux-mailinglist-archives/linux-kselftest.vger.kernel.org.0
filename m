Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362AC656663
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 02:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiL0BSj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Dec 2022 20:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0BSh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Dec 2022 20:18:37 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A541A2AE8
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:18:33 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso2296686pjc.2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9lrEBojXndf9na0XwiSEweKMT3z7m0EhYy6FUTb7Eqo=;
        b=SuL+HgrbbI+cMJF8dKu3Kcjv4UsrortAeUNrsBogOw4uW+BTjMqpk5Z3JDg5XZDf7Y
         TxR/QlAH0Szy1qI7XZinSqxk1onv2CdhPZFrcGHwAUBlBE17dnviUsIUD7neF3Inf3zr
         Rq6Tl6BEU53ErbsEXrVBTyHP7XaMoW1r7H60ZdU/PtTclL98MW43mitqcvkIODW0MVKR
         /4M5rkOvzB0Jved5Gna0efxAhQhNLNL2EzTfNaiJTsyTlNMjYnlpgi0BSpbTnYgRgZJo
         5X76JIwLvRltpmcHECJItNX6mtqURBGzb44PCRPCHnx4akbLWpCgxoVCIW5e43R5GzJc
         tyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lrEBojXndf9na0XwiSEweKMT3z7m0EhYy6FUTb7Eqo=;
        b=IVsEpiBCtVQsrfxSYQF1jDjR3wk/hZ/uLv02q1SI9aawfMk7iydy9Q1w74xLXIkgg9
         +ilvnU1cuOt2Wx+NxWyXmwaxpMPjWbQweF5fRKN4ygTpPa/kJNx3Dq0iE/+BrTWD3cE2
         xEoykSgYfpFUXa11Fa+ih3tXwXMJvyprROsvU61RfZGEnJ10q9QSAin1mjWZnHpvyyHR
         D1ehwfr2BhVxyoL76E0Zl21OOZYhxej9y7BLVU2e35XozJj72v2Z5BqA3annJaOMuK73
         cIRpNtqxdLMVGQ4W7gvq/OWJCyODdRxM0BvpaL2thLUH69iACS0srzyzBD99aIM2InNf
         7oxw==
X-Gm-Message-State: AFqh2kp1UxasKtNacKf78tl3nn9Q4P5NFSFsKa7ZNmP0RBvEMtkcsTDx
        iRSKiEEgCVk40tK0dBhaiNYuBQ==
X-Google-Smtp-Source: AMrXdXtddFEXPpsDOxPx+6j4zXhV8abUgpemqB5PlU/M1G/4YlT3v2xCALRXmdiJfISR7OGAo36T5g==
X-Received: by 2002:a17:902:c401:b0:189:ba1f:b168 with SMTP id k1-20020a170902c40100b00189ba1fb168mr32550822plk.1.1672103913149;
        Mon, 26 Dec 2022 17:18:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903028e00b00192849e1d0asm1535939plr.116.2022.12.26.17.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 17:18:32 -0800 (PST)
Message-ID: <63aa47e8.170a0220.e43fc.293b@mx.google.com>
Date:   Mon, 26 Dec 2022 17:18:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lib: 5 runs, 5 regressions (v6.2-rc1)
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

kselftest/fixes kselftest-lib: 5 runs, 5 regressions (v6.2-rc1)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
2-rc1/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.2-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      1b929c02afd37871d5afb9d498426f83432e71c2 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa370e3f96cdff844eee21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-imx6q-sabrel=
ite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-imx6q-sabrel=
ite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63aa370e3f96cdff=
844eee22
        new failure (last pass: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac=
67) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa39f3751108c4c54eee23

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-kha=
das-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-kha=
das-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63aa39f3751108c4=
c54eee24
        failing since 57 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa3ae31dff1d6a1f4eee1a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meson-g12b-a311d-kh=
adas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meson-g12b-a311d-kh=
adas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63aa3ae31dff1d6a=
1f4eee1b
        failing since 57 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa380a09a37c9c1b4eee3d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lib-=
mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lib-=
mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63aa380a09a37c9c=
1b4eee3e
        failing since 68 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa3a293719c7d9cd4eee27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lib-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lib-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63aa3a293719c7d9=
cd4eee28
        failing since 68 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
