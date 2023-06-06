Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41307233E2
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 02:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjFFAC6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 20:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjFFAC5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 20:02:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F03F4
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 17:02:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-25690e009c8so2389403a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 17:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686009776; x=1688601776;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn9+4w02a0YQyDpA4yz2IN6ZnSMx+Up5BHAj4GOID7o=;
        b=oDBSAYgMQGN1F6D1l+KPkncURP1vGah0ruVR3OrSETsKozZhWeWhhPWV7ErwH7N+Ey
         RYOyLxAZCpLXrXzpb5c9IcE8qVSatC09CBYKHyyFB4eV6SZCh6qcYFFuNmSzL4aiE2gc
         g1IiuSHxW/kJHahYGmhYmYYP8PYUmwVXx/ha0yDau9L7DldKCVfqJuVETO7F315ObZbQ
         gCrjltdS19No+N4a4SpvNob/wxpfCqmus/2fnAl6uFPPSFkdIb3OxgDUi8hvBPckdCk5
         86UW0YpJ0US4l2WAoNvJ3Qq9DlEjsncZOT8iV8MtkakMeE/DEuyCY7KJWnFHr7KQE/wb
         ljtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686009776; x=1688601776;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cn9+4w02a0YQyDpA4yz2IN6ZnSMx+Up5BHAj4GOID7o=;
        b=eJA1ywkrVlZ1QGQiSZDJyqFHOuyL9BCfuTz72Vo0eni0spp93PlxUbj1tRx7Tv5SF7
         4AWFZmYg8PrDzmabG87+2oReHbgQBTfhKYPO7pF9eb6FNT3BYL/zbLxo4JoBJ1nopwb1
         OzscqIMTefkP3EO23u7OUL86i80iHk5lLAVepJ6HWnyb1HxLK8/5mxPZzRgx5Mm55KNr
         LN0VCzpSyL1sNzadF54XwrrOoGGGfZEJwW60+WtgQz17qL+59uv4LCwZTdxCWsMO6IlV
         U4Li9hjo0EkDIifOP/fDeBwvFmgrBMxxjYrBHA2g/igKfNkjuV7ckwAYhV/SFzZtueNK
         zENg==
X-Gm-Message-State: AC+VfDzcDp4vYDo6swCZNmnBVD9PgsERx/cp4LmI2Br3b+rTl/Y0XWSJ
        /tQ0eZTL50JoHBfLL90EcWnDpQ==
X-Google-Smtp-Source: ACHHUZ4CoUH5Msq/k1w8mCrD94grX+BQaZj2IwzS+TAnQumLQXhdGaipLlu4i9I+fM6YkS+7aFRRfg==
X-Received: by 2002:a17:90a:94c9:b0:258:6eb3:44c3 with SMTP id j9-20020a17090a94c900b002586eb344c3mr53455pjw.44.1686009775837;
        Mon, 05 Jun 2023 17:02:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001aaf536b1e3sm7129442pll.123.2023.06.05.17.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 17:02:55 -0700 (PDT)
Message-ID: <647e77af.170a0220.64b17.cc73@mx.google.com>
Date:   Mon, 05 Jun 2023 17:02:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc1-9-g4d1deb59f3ff
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 4 runs,
 3 regressions (v6.4-rc1-9-g4d1deb59f3ff)
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

kselftest/next kselftest-lkdtm: 4 runs, 3 regressions (v6.4-rc1-9-g4d1deb59=
f3ff)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-9-g4d1deb59f3ff/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-9-g4d1deb59f3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4d1deb59f3ff643bd2d442bdd4dd5f58515a1629 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647e63cf6fcf5fb1fbf5de2e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/647e63cf6fcf5f=
b1fbf5de2f
        failing since 187 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e6b66025bd88e84f5deb7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/647e6b66025bd8=
8e84f5deb8
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e6b6e7459881ae9f5de31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/647e6b6e745988=
1ae9f5de32
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
