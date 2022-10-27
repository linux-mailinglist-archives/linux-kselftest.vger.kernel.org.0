Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014F860F7F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbiJ0Mtt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 08:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiJ0Mtc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 08:49:32 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51BBB22
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 05:49:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n7so1364286plp.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 05:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn1nr73Vb0li3xl3WAd4k7WjUR6Yq6LrcvfftlitTaM=;
        b=GLnxutAXJ0VtjXrMa847H9hrWL06L9p+H6OWDFusLtrKfczGeKtfkVTh6erHHet0qU
         QdzWherEFsW1HfsSQHIEzI7sD/0R6Epo2/l/qn1K1aVyHyaws1xbd1Ila8+jVNFNzVTm
         5PcPPLWtvatXFV0mTWIfR8yQn/FM9OdzPLKDlhQdAXGGrO8kGmzEZwU0SsGD9PxC1CIK
         Jr4lQiKE8UA2cQig4GQNETYU5I+udysncqcXhNIjCjYDfed7qgDtxc7GcdEZFgXWSLbt
         AGv3npcdj8+gTOuBJ5/qKPA/Al6wVz9Nsc5KiOQyfWCQVLlG8W8KC6oAvF3PMJlV4LAR
         tGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qn1nr73Vb0li3xl3WAd4k7WjUR6Yq6LrcvfftlitTaM=;
        b=h2tUeyajtsXQaJXV08pWCvZYe9Vc7bKFMqxf0Nx4/8LRJNVQOAK6GbW/F3sMicdqbH
         EwxB+wIRmSU8+JzPJWmipLSojcI7EC407XAqf4rml3dLC8gEEbnyPjxpPx8DY/CWKSZN
         Va6DU+CHWpXxm8kqEF8a+fOLcfO2T8EyFqzsfacF8Q6gQjoy6RVUoHauII7RlzdvUHgC
         50oO0vptZG/xG1X0F3O3U0rd/2dKycv8d9fUHyEXLKvLp2XJNAsrTggDGqErUgRmJtYn
         0HslTmUlPEaQxqn2HhdtBqkZnwvlYX2IU9nk0FMhLyJ7kdyvnd/qx9iHtv/gS99QLLob
         uqBg==
X-Gm-Message-State: ACrzQf20Ml3sokjA+jgOAk+f46VsyCJhb2v3+DSgyn7uB9grK1KMhzc5
        dm6zTgfEwwttQbSWKO6X3bdVTlrQVFTW7ML6
X-Google-Smtp-Source: AMsMyM5kb7r5Y14uPLgzy8ZrVzd+G0qE4aAAVSCIZ2mZdhN/UQ24Xo8k3pem+hXK19SmLa4Bo1Mkow==
X-Received: by 2002:a17:903:1112:b0:179:ce23:dd57 with SMTP id n18-20020a170903111200b00179ce23dd57mr50884177plh.114.1666874967110;
        Thu, 27 Oct 2022 05:49:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b00186abb95bfdsm1145022pll.25.2022.10.27.05.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 05:49:26 -0700 (PDT)
Message-ID: <635a7e56.170a0220.1026e.1f85@mx.google.com>
Date:   Thu, 27 Oct 2022 05:49:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-6-gecc7d67af402
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 5 runs,
 5 regressions (v6.1-rc1-6-gecc7d67af402)
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

kselftest/next kselftest-lkdtm: 5 runs, 5 regressions (v6.1-rc1-6-gecc7d67a=
f402)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-6-gecc7d67af402/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-6-gecc7d67af402
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ecc7d67af402dda4b4d353dfa9837339319c9d4d =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/635a6e2ce7e9aa8d2de7db68

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/635a6e2ce7e9aa=
8d2de7db69
        failing since 65 days (last pass: v6.0-rc1-1-gf1227dc7d0411, first =
fail: linux-kselftest-next-6.0-rc2-1-gab7039dbcc61) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635a721cd21a5bbdebe7db50

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/635a721cd21a5b=
bdebe7db51
        failing since 9 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635a70b455903146cce7db5c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/635a70b4559031=
46cce7db5d
        failing since 9 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635a70f38e98fb4b6be7db67

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora=
/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora=
/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/635a70f38e98fb=
4b6be7db68
        failing since 9 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635a70b855903146cce7db73

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/635a70b8559031=
46cce7db74
        failing since 9 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =20
