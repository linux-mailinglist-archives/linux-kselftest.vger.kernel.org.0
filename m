Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6A6E2A97
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 21:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDNTSd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 15:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDNTSb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 15:18:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90A440E1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 12:18:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x8-20020a17090a6b4800b002474c5d3367so1554111pjl.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681499910; x=1684091910;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5ogLr7uIHIMvPCGlXjertNBvmiSroqdLIBVs49zoY6k=;
        b=IhrIOznEVHfe5xmu34/edL1xf7tw0ypa9JVT7l93R8h0RXGmJTRJ4uHc776kXAx7iy
         4kWQFyC1NVjwHlce6RrEnYj90Bk6pK8IriruzrGmTkMWVF0WON0V4knhJtdX0Uu6yZ0K
         Fgz9fnc/PDiq5HhAOoWAhvnHfDyUnwE7my5B5+G7sEDiSrGcm253w5bG0GE/0qo5983X
         qRc4B48Y4K9Fz4FNXlek2daYpTsQxyHSZYdSAOi8Anv58xSRh0eJ5Jk7RDSyKtpf7jbC
         CrlCsnM6dtym72T62RrmM3U+qKA1RoBOipVAU+b4AgHRoEFZMlsxmD6PgVLXzTZUVjhY
         OsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681499910; x=1684091910;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ogLr7uIHIMvPCGlXjertNBvmiSroqdLIBVs49zoY6k=;
        b=hFsIGS9FU54JQaFeHIVlO/xgdaJKnnzwgSk5VHCXVojtUNEj8ym11lp41r33Xhy1Zr
         qNxFGAAELBAiGc2kRXOnJZo5cF9yO+aydiKxLgKEOz3Av5paPwt6N5ArLqTTfBa/THso
         LZoUSjn+RJC5jNyULf/h3dJrq6M+F4202wKIPT00aimANVs7fhhfOaiHiikAC4+3xH2I
         2OUOw2U2mLG7f1axCtF6QwZ/jAYNBy8VS2IoGY0nnHV/IUk5JtgEnCFEwtQfwCjnVZun
         t2sk7KC5WqZMQ2EsvJWcCsSeeQxLSkbty5roHe4UldCJwhuNOk+PyUsYKYnW2gD2NxtI
         K9gg==
X-Gm-Message-State: AAQBX9eNrpiIUdbUwd4nrRJDGmS5Fll60qo9Ys1TEkJaQglqFT9PcQCd
        2QTovwHT3RAO4BcL1xfvLPdR9uiLEhvhp//4+yCVjqhN
X-Google-Smtp-Source: AKy350YoVsnVT5ij5p5s/UGcVPWV9E2uVWw1efrNg8k6/e0AyAwrALtMIVFCf8qM1FkfmpXmtHVhRg==
X-Received: by 2002:a17:90a:7564:b0:247:2ff9:1cff with SMTP id q91-20020a17090a756400b002472ff91cffmr4092362pjk.25.1681499910167;
        Fri, 14 Apr 2023 12:18:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a440100b00246f73c3acesm4960946pjg.33.2023.04.14.12.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 12:18:29 -0700 (PDT)
Message-ID: <6439a705.170a0220.627bd.c293@mx.google.com>
Date:   Fri, 14 Apr 2023 12:18:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-25-g50ad2fb7ec2b
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 4 runs,
 3 regressions (v6.3-rc1-25-g50ad2fb7ec2b)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-seccomp: 4 runs, 3 regressions (v6.3-rc1-25-g50ad2=
fb7ec2b)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-25-g50ad2fb7ec2b/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-25-g50ad2fb7ec2b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      50ad2fb7ec2b18186b8a4fa1c0e00f78b3de5119 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/643994cb30404d2fe82e8611

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/643994cb3040=
4d2fe82e8612
        failing since 108 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64399a59e475fb328d2e85fe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64399a59e475=
fb328d2e85ff
        failing since 178 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64399aa90d2dadc3262e8627

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64399aa90d2d=
adc3262e8628
        failing since 178 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
