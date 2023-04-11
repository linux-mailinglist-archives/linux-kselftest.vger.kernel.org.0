Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990246DE7E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 01:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDKXRV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 19:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDKXRU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 19:17:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE351726
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 16:17:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ik20so9327699plb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 16:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1681255039; x=1683847039;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oTHhRsVYdXZQEeo5z0U6Rd17lTK2l9rBHTddJfi+aXk=;
        b=16lQhqUcFVQLb41a8l0Td5Sty/Q2/XYlecb5iB6RdV8axXt3F3F/nVCTmZX52oYlYO
         sd0Y1ungJTuO6u06ehO87If6w2KuW2NTJsMuimzZWW/yGUZIei02ePTSaNxNT1NUKWLl
         l7r5gDSccmn0QWSeeuYzXeHmUytLdqa/ktM9fCGgUZt9S7rDxCuqxVPo5j0RIfdvf6Jh
         knxht48x0SdfgAD6KjVNo3yvovwnjwzuqXsvR0yQfd5C4I9hL1LIYjf8gd9vYWnwVZ4X
         w+Q6BNkqM6kuQhhsqEyeSEPqJ1ViwoVrae6MoEiK+xFglJi4QyNrHy69u5ynHtI7AoA1
         AS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681255039; x=1683847039;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTHhRsVYdXZQEeo5z0U6Rd17lTK2l9rBHTddJfi+aXk=;
        b=iKOO4yZRq4dt68gCCtkWI0vsVq5bl3p2xaDwR+HGFX2xk/0lLjRRMctl/m6M/I5eOk
         u5T4chanEuvi2thEdJLnLphPe1ky/F67cdk9Qy/XJC75G6t198HVmJAfOiT0Y2ALFLTx
         ES+f+6m1W4n7xLQE742MB1QiEjb5p80S0xO98qXn/VxC4J+oLd8nRlhspc42rWSvH0Ut
         Rjl0K6c4TMM0I9yYUwlQe0zVHyymlQ82SRJIBZVAi++yVlhzLAImQciRiEDEuJ1iHs8Z
         kTHK/Lz06Z1/uVEII/LXWfHjpgq3gyR5yY5QraQgd/M+5GRTYon0vI0Mhmzx5Iv4QQXk
         NhPA==
X-Gm-Message-State: AAQBX9eMtX138Kob/xHXvp138mLijYZY4pWEVdl6MMz8XfwAGBgm4nYe
        5gmbKQHB/NVm5jaGk72WrOq9hg==
X-Google-Smtp-Source: AKy350bOMrDmnQ78lUgldFM8hXNCG6ZZ/Ma/oqLP+2SOe4CelpbC4UcPNKGZ+kOtDXFTgieoJG/8bg==
X-Received: by 2002:a17:90b:4a89:b0:240:e532:d868 with SMTP id lp9-20020a17090b4a8900b00240e532d868mr16672857pjb.43.1681255038869;
        Tue, 11 Apr 2023 16:17:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t21-20020a17090aae1500b00246952877d8sm126885pjq.34.2023.04.11.16.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 16:17:18 -0700 (PDT)
Message-ID: <6435ea7e.170a0220.803e9.06e2@mx.google.com>
Date:   Tue, 11 Apr 2023 16:17:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-17-g266679ffd867
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 5 runs,
 3 regressions (v6.3-rc1-17-g266679ffd867)
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

kselftest/next kselftest-lib: 5 runs, 3 regressions (v6.3-rc1-17-g266679ffd=
867)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-17-g266679ffd867/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-17-g266679ffd867
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      266679ffd867cb247c36717ea4d7998e9304823b =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6435dd5a674292a4ab2e85f8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6435dd5a674292a4=
ab2e85f9
        failing since 105 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6435dc6dd35dcacff12e85f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6435dc6dd35dcacf=
f12e85f6
        failing since 175 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6435dc47e7ccc9b6702e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6435dc47e7ccc9b6=
702e85e7
        failing since 175 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
