Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7578160672A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Oct 2022 19:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJTRjn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 13:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJTRjm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 13:39:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9036E2C640
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 10:39:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 3so233244pfw.4
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+wFnVorLQYCfSpNcjRkZc3a3RyP2ksuUJxpJlrxzbXU=;
        b=vRKJDrNhpLdmPLAsRAoN4ivEk+TgMG7ubexKzkgIZjmKNmTAOSjzuufttxmxys0Cwi
         9k89FwH0s3UgouDtYtOEBra4YHGkI2eRjusL/4lHE9JkORgckmonGAD11CepLJGR0xsU
         MeYJYN0xPc1Q5PHLjq9UDwvLZFJtjap8jFmC4vYP37F7t1xSEaadXn2+JgoMConFUdKh
         sBdU9fSVUCtoPNheLB5XTUX0rNRj8H05btOXOp+kBfhiYaPzbajVUs2B1uBwF8Cma/oR
         tJCPFuejRaLonMIr6SS39UEvAhXohEDFyLsVntsep5VNVqj/wwkTpbE1XwhwJBan/B0S
         AhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wFnVorLQYCfSpNcjRkZc3a3RyP2ksuUJxpJlrxzbXU=;
        b=Hxc8eoDGFnflrMA0aRtuWWiueLGr+NSDw3sWKK9BFhaJo/P5K+exs2HLv5RIFm7gwo
         thdcZUlzWzbpyV9NK6MO05VVL9zOddoC9VgjWJF8FxrDfuwnnl1pNwyWXrgRiKGx79/v
         qQVCsMzEr1UsYGFQ4SlthP1/4FR/2v7SsJiBseLpwYu/oB1+gkAbJjrRNCevu6AaI7dz
         kO2ZN3/m8oP3OVTi9mHqGhO0bbpNoYwMSlPlbMqgBCYEVzc6aB44nzEQmds+rGqThWgo
         1HExw70Z/FRsv3odB/0Q+U/3hmL1gEQmHH7njm3wlxgk5E84GZ18b1bRzmjUfZw2ZXAJ
         VQyA==
X-Gm-Message-State: ACrzQf2eVHZMcjB1fJPo+ojC7nPr3AuN8rn9M8BNvkHyPr8H+CVwPr7b
        BMXivCnqCvkZi82Myk2HFRMFT/gkDV7yPbTu
X-Google-Smtp-Source: AMsMyM5tdquOdXW3Jx8xzR+KmfA7guRuq5uXbI7aZgVOX5mnQiSy0AHBgqwQZe+ZO0cfpmGBswiPzw==
X-Received: by 2002:a63:454d:0:b0:43c:e834:ec0 with SMTP id u13-20020a63454d000000b0043ce8340ec0mr13056390pgk.270.1666287576060;
        Thu, 20 Oct 2022 10:39:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902aa8800b0017ca9f4d22fsm1796689plr.209.2022.10.20.10.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:39:35 -0700 (PDT)
Message-ID: <635187d7.170a0220.1c1d6.3a7b@mx.google.com>
Date:   Thu, 20 Oct 2022 10:39:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-1-gde3ee3f63400a
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 7 runs,
 6 regressions (v6.1-rc1-1-gde3ee3f63400a)
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

kselftest/next kselftest-lib: 7 runs, 6 regressions (v6.1-rc1-1-gde3ee3f634=
00a)

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

meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-1-gde3ee3f63400a/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-1-gde3ee3f63400a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      de3ee3f63400a23954e7c1ad1cb8c20f29ab6fe3 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63517aacbdae95bb3b5e5b42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63517aacbdae95bb=
3b5e5b43
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6351791f2386a890e95e5b41

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6351791f2386a890=
e95e5b42
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63517d18c6fc9cde805e5b4c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meso=
n-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meso=
n-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63517d18c6fc9cde=
805e5b4d
        new failure (last pass: linux-kselftest-next-6.0-rc2-11-g144eeb2fc7=
61) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63517c3f5b791df5da5e5b52

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson=
-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson=
-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63517c3f5b791df5=
da5e5b53
        new failure (last pass: linux-kselftest-next-6.0-rc2-11-g144eeb2fc7=
61) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63517cd14df1f8e8b35e5b4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.2-++20221003113153+5f620=
d003fda-1~exp1~20221003113249.70)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63517cd14df1f8e8=
b35e5b4f
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6351764ee81960aef25e5b65

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6351764ee81960ae=
f25e5b66
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =20
