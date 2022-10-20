Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D072D60672E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Oct 2022 19:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJTRjq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 13:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJTRjn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 13:39:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12BD2EF22
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 10:39:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 78so143664pgb.13
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 10:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gigobFfcECbLbAW5FhT37X73gda5nuQbuOplle/crJM=;
        b=0OWFUpgBnod/M2W88UTIuXUqpsel+AxOvujY8HaS9NGntjg8mliy3tQVuv2k/QjYbj
         bqR6/DSwo8X3ERYPMhLaEci6oFZC8ugoh9ClhjJnwoHtz7MfXir9+P+HUN17moJc41rK
         O0XxRRSLhqOwvdPIlZ89RdLkBPjKHqoTKRG8b67yn90JLW2VvjqQQamIwX5HZhjCGMVx
         jEJtmi5tkHza1mbuYoadvF4uDyuvuL2E/6RhcjFYiE2rjUE3nJ0wI4UIYjEkvHRB9aG4
         uPOoyF2T8lgzkbuwhlZCpY6vBvmCGzZnX1eo7Kt5hfJ7THzaueowqS4ndlPYhQhWPJqF
         kjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gigobFfcECbLbAW5FhT37X73gda5nuQbuOplle/crJM=;
        b=l3oUaAisKm0l1C7fRpiX4I9wWLfXZt5vwEvhMUnY9k7koi8FSHdfciQvofUbCIq4SY
         opuQebBxyQqV9uN491BefU9FhFQCxECuJ7MKZEAUtABbou05+ohjeT4QGdzruk+nZ4bs
         8AygISCEinYx8Nws615KTfJNmeeJIQbvDaZNlmRGWwhH9aHhh26/+O1s5OqfFhlmczch
         uUdNDGxJweQSF/tjvrPoAr3r6iyl3JGD+hZC4Conv30DXwZA2wKFie98Ig/UMAmoXzbi
         WdKov/14Kt0d6na7DlEJE7MDVZTNgrUISfkfw1Entst4uraF3NCiQMpQha/SDF4PmtG8
         g+nA==
X-Gm-Message-State: ACrzQf2uryD0ZEfYi6UtdD080VNRcO13sRC5dk2tVj27Y8xX04O7IT81
        2B7p3nCxDOk2jR+g0Yn0naZo/g==
X-Google-Smtp-Source: AMsMyM4fIW4sUTAyQKUsVk5Rw5vQYjVoQ9+5khFA2LrjeEe9aZGl+ikE9u0Y/9mEOJs3mln/u7raWg==
X-Received: by 2002:a63:4845:0:b0:460:1693:acff with SMTP id x5-20020a634845000000b004601693acffmr12842932pgk.538.1666287577353;
        Thu, 20 Oct 2022 10:39:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x62-20020a628641000000b00537eacc8fa6sm13639884pfd.40.2022.10.20.10.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:39:36 -0700 (PDT)
Message-ID: <635187d8.620a0220.134fd.9757@mx.google.com>
Date:   Thu, 20 Oct 2022 10:39:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-1-gde3ee3f63400a
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 7 runs,
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

kselftest/next kselftest-seccomp: 7 runs, 6 regressions (v6.1-rc1-1-gde3ee3=
f63400a)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-1-gde3ee3f63400a/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
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
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63517d19c6fc9cde805e5b4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63517d19c6fc=
9cde805e5b50
        new failure (last pass: linux-kselftest-next-6.0-rc2-11-g144eeb2fc7=
61) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63517c675d6e6db8965e5b5b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63517c675d6e=
6db8965e5b5c
        new failure (last pass: linux-kselftest-next-6.0-rc2-11-g144eeb2fc7=
61) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63517c9601c83ed1935e5b63

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.2-++20221003113153+5f620=
d003fda-1~exp1~20221003113249.70)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63517c9601c8=
3ed1935e5b64
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63517654e81960aef25e5b6b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63517654e819=
60aef25e5b6c
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63517a890022a5ec4d5e5b48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.2-++20221003113153+5f620=
d003fda-1~exp1~20221003113249.70)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63517a890022=
a5ec4d5e5b49
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63517675748cbd43755e5b3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63517675748c=
bd43755e5b3c
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =20
