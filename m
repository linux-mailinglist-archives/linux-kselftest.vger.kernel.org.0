Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA54C697298
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 01:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjBOAQm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 19:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBOAQi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 19:16:38 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0FF30EA3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 16:16:37 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id v23so18716436plo.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 16:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2L03Xqsn/rtF/fxHEkzpIJk7Xe9IkrjMBdpgF0v3DY=;
        b=R3OrKavrWzOWETleW+R4nmTcHvdKXk7xz4+vnZnOlm35hBNJ1nMp3+5S/VsQadcDrq
         Rc1ZxrsyJMPS4xlOQLZn9JnRX2O01JAnB/BlLTt8WrBFcu5nJ0IJFS5k+muKDvOdcKdO
         w4v3IgqGsRVVDv2JjuyICmjWE4xKYz5h50zsCtblCrQmOmxGOxlTVWWbUOSBp9q+C1jj
         9QfwB4n3Y1YuCwzOqa4IYYe5yjz2tUi0snpCfsf7j5pAqcCha+2RQl1bT3VyL5e36GIx
         MFJCHKVVrITquZ6PKFiK2xksBT9wLaZliMRtOQwNtUy7IqgiJZZ0tR1E4I19+IbYh2So
         DkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2L03Xqsn/rtF/fxHEkzpIJk7Xe9IkrjMBdpgF0v3DY=;
        b=SC6acT3tdkIZL8C9QbMxSBJYmgVouxA+wMMMV0+7IVwHtp0EaLLL3k/VFZI53ec9aN
         e2xXFkxDzi6qlE0ZTiAxGzT16EV+wNTG/1bu3XIlcTNePxs/qyi1DshyxOmTFy3j9u/S
         pPCfZj7BL3hEhbMn1X+ZGdwXnGcsPaIiPTCJTSRwYVxnFuExE77G1qzJUxNvGin/AqUf
         ErtF+K21wiqPS7OS2XsIjTWxC6eO1M5h2XO+Nc873IyW8SS0YcjA7uKwTgUAvHpnruyB
         E24cG+Wn7W8aJYhad1xlZNMzkDTvMh/cjedn3v4RB8KcZmpHMIZ8urppEbC4NOTtNljk
         HBlg==
X-Gm-Message-State: AO0yUKWYKGyQD9QQx7HZuEnz/lrxeTjHD/VvTV6dYImSwa6OHCL1IYmr
        t84OfET5hCkwBkgL5OztDlRhJu6+t2Rkga3+bKg=
X-Google-Smtp-Source: AK7set97NODdzrpxxb7svtXG0BkXWsLshFPLE+gJ1neAl98FKumpNd0g/5PaX0U2iu7qf/neMg7txw==
X-Received: by 2002:a05:6a20:244b:b0:bd:15c8:7e38 with SMTP id t11-20020a056a20244b00b000bd15c87e38mr826822pzc.11.1676420196469;
        Tue, 14 Feb 2023 16:16:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y19-20020a62b513000000b00589a7824703sm10351982pfe.194.2023.02.14.16.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 16:16:35 -0800 (PST)
Message-ID: <63ec2463.620a0220.9567b.30d7@mx.google.com>
Date:   Tue, 14 Feb 2023 16:16:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-40-g0eb15a47bf43
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 7 runs,
 4 regressions (v6.2-rc5-40-g0eb15a47bf43)
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

kselftest/next kselftest-seccomp: 7 runs, 4 regressions (v6.2-rc5-40-g0eb15=
a47bf43)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-40-g0eb15a47bf43/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-40-g0eb15a47bf43
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      0eb15a47bf437a268b69ab1a1a45fdf1f609b69f =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63ec0fb91ca4c907f68c8664

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63ec0fb91ca4=
c907f68c8665
        failing since 49 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63ec200c9aa73617538c8631

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63ec200c9aa7=
3617538c8632
        failing since 117 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63ec14b9d68a0a1d8c8c86b0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63ec14b9d68a=
0a1d8c8c86b1
        failing since 120 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63ec1492f62b1e4a268c86a6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63ec1492f62b=
1e4a268c86a7
        failing since 120 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
