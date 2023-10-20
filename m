Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B9F7D13BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 18:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjJTQLm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 12:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJTQLm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 12:11:42 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8C3D4C
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 09:11:39 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-581f78a0206so523323eaf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697818299; x=1698423099; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yrk7Xt5ISHuEhtOh00tGcsj5Fv/zimrkyl/EeAHlj/I=;
        b=NTzJyu0BN8YjIicfHd66VXaKd2PrBK6aIKXfSD2G0V443lAT8Ajy+VIxsM112g8sad
         ICpO9oqbmqHnpjF7C86jBPGQcwAq35RyCxAkhKKLETQVxp8lkEoDm806ZhPilcpwbaWG
         V5BqlJ9//sVQ4biE3lJXs+2+dO0/cnxBUw+WVmwPho4LRBzOagt+zxE8PVviYPIf1FeJ
         f50SkeTjOvbQggzctRIWyQthK79sAXlHblkJO3sIj00VI/KJDtUghCoFKKwz69JtlRHl
         EwNyo3eDqgMzarPKcjEkFwTkdK7SIMFjs3ng6vrpXj5Q6yiaveSVcKVpxORH54zip3/t
         Cw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697818299; x=1698423099;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yrk7Xt5ISHuEhtOh00tGcsj5Fv/zimrkyl/EeAHlj/I=;
        b=HrsMqgNZg1UTQsWj6Y7qsvbkCzq6UKuPzdRi8NZJonCyCQhy9ziVIStA6F5isiZpvv
         oJqSW4IF8hK4zbygDxox5QMbWq3WmCS4j9XJJW75hYh8+hoVZ6dcRMP+ZLSRbdxmI1QQ
         UImxA+O964IxJ1YkOApnySwPwaO0sakvM68yUkZf07SXHg4qV5qoc8HeFAP48+gVs91Y
         0ENYt+71RdtG+t0KhUXH6xYJcyZy76T4AnazyfAK08ut0EOYfcUOAx66fN10TxyueV5P
         NeJ17U9yRjfmmbqohNjdlQvcTq/KOQSLLzRvGPPC0nBuEn5aQRjm52YeBuKMCC07qt6w
         dOVw==
X-Gm-Message-State: AOJu0YymDiB5RKT2QuYEjm8anw4zTUR4bmze4PLHF3FkErVZ9Sc5f4Nq
        krkSDipeh1V5MGQPdzsSgsgrp7bhHRoXM+xQpYHKuA==
X-Google-Smtp-Source: AGHT+IF+mNVCroSQ/muqh5mExVtmy4NAbkJyua2EP1gl3rpA+w8aqtzD9iJv60hWiNxdmXJqAQILFw==
X-Received: by 2002:a05:6358:2917:b0:166:a518:d447 with SMTP id y23-20020a056358291700b00166a518d447mr2554507rwb.22.1697818298088;
        Fri, 20 Oct 2023 09:11:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o1-20020a634e41000000b00589b7a9ef01sm1666761pgl.36.2023.10.20.09.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 09:11:37 -0700 (PDT)
Message-ID: <6532a6b9.630a0220.bcd72.60d2@mx.google.com>
Date:   Fri, 20 Oct 2023 09:11:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-51-g5247e6dbed00
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 8 runs,
 4 regressions (v6.6-rc2-51-g5247e6dbed00)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-cpufreq: 8 runs, 4 regressions (v6.6-rc2-51-g5247e=
6dbed00)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-51-g5247e6dbed00/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-51-g5247e6dbed00
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5247e6dbed0041147a83137f89cd45043301de5c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6532a25830fc983750efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6532a25830fc=
983750efcef4
        failing since 364 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/653299b917bc944cf5efcf1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/653299b917bc=
944cf5efcf1d
        failing since 367 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65329c326baa1a7f3defcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-s=
un50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-s=
un50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65329c326baa=
1a7f3defcef4
        failing since 356 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-8-g94fea664ae4ee) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6532a27130fc983750efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-s=
un50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-s=
un50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6532a27130fc=
983750efcef7
        failing since 352 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-13-g67c0b2b52916) =

 =20
