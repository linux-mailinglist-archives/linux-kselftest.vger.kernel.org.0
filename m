Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDA268A483
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 22:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjBCVS0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 16:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjBCVSX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 16:18:23 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02422DE6E
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Feb 2023 13:18:20 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id jh15so6551079plb.8
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Feb 2023 13:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Mw/aSlYN8d30UYPXMnqaZXMsqhRbq2ExQ+RF8nVNBI=;
        b=QfPK1Wo36psOCgBYD0Y2B9gWRiPsddibyZstWn7bqcpnLG8hIurx+qdus2r4/Gy6Br
         eAAEPF2Ap3RhvPqzNLgqpPFtw+MW7VT0Oudd8fbU6d84qTDsQHmd+yeyApfFCb6vNg/Z
         Sd2U51RYe+klUdulJC5GhesB5Cl2B8xHEhqFpXWegMiJyvxDQRKxqhTHQrVk85Vc/scF
         IhmKJIdFkM2upZy8TwRgE2LTeStStDUJi1LbkWHEHuQFdmIorE46ZMaZktAJHFd+WzuM
         b4eYL5TPrrCk2XWBEg91piWmt2kPVrEXDatYJW0OpNjGDn6FBvPivtEDLgKlTNNxHHha
         +hNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Mw/aSlYN8d30UYPXMnqaZXMsqhRbq2ExQ+RF8nVNBI=;
        b=zHCM1sUtjlNx7batU8Y6WsRFUZWsItoz9Jp4Tvx8izFCA17thxaNZIG9jrAWiqM62W
         1At4a7ynIX6LavwEgulczj6KBotLcQh/PwzeImTT5zid20KryqMWfqyQhCegW+i7h++q
         qxcq1Eh7/K4EIZGOwZgZbHJY10N5Qk555TFG1dYO7znP3PceqWcse5YuB8DZ7lF1+Sn9
         /OiXhafylYTCand22hIP/U25gYsK51bq3ioL7axxn1cfyIBZNudRgulaa7wYJliWgpQb
         gaeMbVC2M44J9YH+Js7nqHCAj7KHEudCFeYNWtAAe2GH68+BYYRLaUSBiOA98C9PMc0c
         31Zg==
X-Gm-Message-State: AO0yUKWFwk2hcj9pBZxhvDRgrXtM579TQ/6SvpWacuFp5SFs6uzOtZXj
        QeA0z9TVdDzpsK6SA46RMrcV/hhu1zeEn0Y2zARssw==
X-Google-Smtp-Source: AK7set9V9I9/Zrwnd4gNURw85IZn7wldDGD+NBXTF9Dr2PjyOs0H+CI9/fPXx7DF8w6EzYpiBvVaSg==
X-Received: by 2002:a17:902:ec8a:b0:196:56ae:ed1d with SMTP id x10-20020a170902ec8a00b0019656aeed1dmr13923979plg.69.1675459100408;
        Fri, 03 Feb 2023 13:18:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902a50b00b00192cf87ed25sm2077637plq.35.2023.02.03.13.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:18:20 -0800 (PST)
Message-ID: <63dd7a1c.170a0220.76d42.4334@mx.google.com>
Date:   Fri, 03 Feb 2023 13:18:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-35-gb23b16d35135d
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 6 runs,
 6 regressions (v6.2-rc5-35-gb23b16d35135d)
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

kselftest/next kselftest-lib: 6 runs, 6 regressions (v6.2-rc5-35-gb23b16d35=
135d)

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

meson-g12b-odroid-n2         | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-35-gb23b16d35135d/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-35-gb23b16d35135d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b23b16d35135d8c067abde6a6e1467127c3dea87 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd692cbd09204dab915ed2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63dd692cbd09204d=
ab915ed3
        failing since 38 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd6c583aedb52f71915f51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63dd6c583aedb52f=
71915f52
        failing since 108 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd6a3ffc235b6879915eee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63dd6a3ffc235b68=
79915eef
        failing since 108 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-odroid-n2         | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd6d647b49f52e1d915ebc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-mes=
on-g12b-odroid-n2.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-mes=
on-g12b-odroid-n2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63dd6d647b49f52e=
1d915ebd
        new failure (last pass: v6.2-rc5-1-g65177e47d303) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd6ec6c5f1746c03915edd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63dd6ec6c5f1746c=
03915ede
        failing since 108 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd67f96e118b08ac915f9c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63dd67f96e118b08=
ac915f9d
        failing since 108 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
