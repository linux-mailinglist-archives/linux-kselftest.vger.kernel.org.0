Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DA87234A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 03:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjFFBkF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 21:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjFFBkE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 21:40:04 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE89110
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 18:40:03 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39a50fcc719so3816701b6e.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 18:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686015603; x=1688607603;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gEYuLkp5uc9lzWH8y7WwaRspMjKaVCOPpr8Ff18r/n8=;
        b=NM8Ry3Px125i1Q4jYTKQZqtJVkyGtV2znBXdH8yAiwtvAipfa9W9VHYRCaOAwJ/lUd
         Tf3uwcyBiLW05g+SSVwRHUWy2vkk32pOi5Mq3MSHR/ppePJLmNHYYtEhn/SBDg625JZH
         5t3L1Z+svX7cig7Mp+xJXkbJphQ2f+UUNl0JgSZmWwF/B41jZHVbt9W8+btxoKlvgCDi
         zPIxmiAsAC3B9Of8QAaiOMPNUrDbwnZZD2/BqhtfnhtSUDnodm27Zdet5K/AP1LEOm/S
         JZLIcSSXN+vZ1uvFRf9QvNFPd5RwoJ5sCkF6DnCKDAdsH7Z5mJLw876M94FpUKS+Ifc8
         86vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686015603; x=1688607603;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEYuLkp5uc9lzWH8y7WwaRspMjKaVCOPpr8Ff18r/n8=;
        b=bYLDBNNhrDjcYlB8sewWVilyElob2JgmaX4mOHfOMNSIW2fhh7+tq/4oOgDY1g71cD
         cQsPaL7jt7tlAYVVkeqtkbv4ADA+21mtTExLsf+dkvYS4XdUiARnvoovPk2UOt0iafMi
         MA2Hs3QRu69W9u8+6lR8DPhWxB7ikXNNHNroUrvo1SnJUFdu+DAE5KOPPDNM2mwLF7xu
         BLWPnDiytiAE4aXAyQR+dQmuOFDgcKIrsw3d7HlXtEusfeEj3HMVhqld2Yk9PKwOLpzG
         Ek5+bEOXOS7wwquT222wOSk8a9O/WMZLlN/9Tym85o7OC971XLVqsKK3mAuMYUQpmto/
         2/Bg==
X-Gm-Message-State: AC+VfDym+z7uQ1ET/0qaU98Eev2DeC9Yx1ii+NZqEicA5WaQpnTukpne
        0y8t4yx3/XfjBWA3is/FFa28ZA==
X-Google-Smtp-Source: ACHHUZ7czNBsabHpRkj8J6lCMn8A89N0gjsHUBqJwVkI2xP9TrE3KyHDSVGXSD0h0R69xWxbfBDhAQ==
X-Received: by 2002:aca:230c:0:b0:39a:a847:f08d with SMTP id e12-20020aca230c000000b0039aa847f08dmr466125oie.39.1686015603033;
        Mon, 05 Jun 2023 18:40:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t24-20020aa79398000000b0063799398eaesm3530624pfe.51.2023.06.05.18.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 18:40:02 -0700 (PDT)
Message-ID: <647e8e72.a70a0220.ad2b0.678a@mx.google.com>
Date:   Mon, 05 Jun 2023 18:40:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc1-8-gd909ae0a8562
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 7 runs,
 4 regressions (v6.4-rc1-8-gd909ae0a8562)
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

kselftest/next kselftest-seccomp: 7 runs, 4 regressions (v6.4-rc1-8-gd909ae=
0a8562)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-8-gd909ae0a8562/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-8-gd909ae0a8562
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d909ae0a8562b404eb1aa9dae6b2f15c9e163984 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647e7ce8afde455a6ef5de3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-s=
eccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-s=
eccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/647e7ce8afde=
455a6ef5de3c
        failing since 161 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e7f734082ecb647f5de64

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-me=
son-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-me=
son-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/647e7f734082=
ecb647f5de65
        failing since 228 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e81214cc0e97e66f5de51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/647e81214cc0=
e97e66f5de52
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e8116dc925153e2f5de4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/647e8116dc92=
5153e2f5de4f
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
