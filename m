Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B624F679357
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 09:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjAXIoY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 03:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjAXIoV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 03:44:21 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F01E3526B
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 00:44:20 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso17835492pjg.2
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 00:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ucbHVJ0co45563aNNDrgdsTTv2fqnKk9+LYfAodjKvM=;
        b=ZUNl2OCm8kyePRTcJ23TSKIgOzjz56+3rhURnqTaWUAOiqT65esAle3F6jzDHm6VPe
         rM2XzBdSjR5Ry81EtEjMjJ7L0cOwgMdAVPEevuqYUyA93583vgAGeeLXTYwpV4BydLTX
         mLmx/SEqyvVDA6kJozSwjviTqFXg53PIUa8Ki0LCpdthwQMe+d0SFawe8iMjDUlpx/5o
         MQNsxUtqOrjJW+8ea8/57/MxY1pcFd7H78tJ+JJWmQpS2G9JBritYU8PEU330yDbXisj
         wuYcWl842NPqtrKZQd7Z1BFAk61Zm0fh1KhLzrWuoSnKOZJoMWH0sLgdjqgNv1KJ5MyK
         zYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucbHVJ0co45563aNNDrgdsTTv2fqnKk9+LYfAodjKvM=;
        b=mh71mb3UqJkbMi7HO/LWckL/ZTO3mdIuP2KzO6R0/2W2RWL9YGJqDHRu+u6iyIrLyJ
         XmIJiuyvQKHkXgK1VksBSxv2ilkOYP+9bt5YPGsgd/r2fFlkwgtdcp+oP71SBZ205aEV
         CVgospTdlQjwwLMQ+zvkNWME8gJgMeTgdaKnauyUykwDNYpjmdKfEArlauzcQlMfFo/A
         pP+EktQa5a7KXeJBx/LtyIaa8ft0rrMGjVdeHvARxRTNx47Oj3YNLgC5nVT9mmwu5iMO
         g9nX8xTn7KWNNEnRgIZi+PhGm1wCN24bJwm2SHOlX54CPTnQoj9yhU+p71aANT4V0oOs
         gVCQ==
X-Gm-Message-State: AFqh2kpOfNIVzH9kHMHcRmbtmubFgZgXM8j+CssFbZm4xftP3aoFrdaO
        RS58PXxeRP4C+sE2D2kph1W5i8xbHyO2Lv5rEp8=
X-Google-Smtp-Source: AMrXdXtDg2r4G+CPTi1nXhaJKH+TUzJss/VS843fxXYs9aFOXmHO1a0kbvflAdo0ifz9qFENGv6cAQ==
X-Received: by 2002:a17:90a:db90:b0:22b:b3b6:cf76 with SMTP id h16-20020a17090adb9000b0022bb3b6cf76mr15089568pjv.17.1674549859885;
        Tue, 24 Jan 2023 00:44:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s3-20020a17090a764300b001fde655225fsm2381502pjl.2.2023.01.24.00.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 00:44:19 -0800 (PST)
Message-ID: <63cf9a63.170a0220.e48f8.073f@mx.google.com>
Date:   Tue, 24 Jan 2023 00:44:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 5 runs, 5 regressions (v6.2-rc5)
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

kselftest/next kselftest-seccomp: 5 runs, 5 regressions (v6.2-rc5)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2241ab53cbb5cdb08a6b2d4688feb13971058f65 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf9133eb2cf7b867915edb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-seccomp-imx6q-sab=
relite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-seccomp-imx6q-sab=
relite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63cf9133eb2c=
f7b867915edc
        failing since 28 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf8da0f47a76e242915ed5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-secco=
mp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-secco=
mp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63cf8da0f47a=
76e242915ed6
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf88b8e324ffd662915f0c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccomp=
-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccomp=
-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63cf88b8e324=
ffd662915f0d
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf8d9ef47a76e242915ed0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-secco=
mp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-secco=
mp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63cf8d9ef47a=
76e242915ed1
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf889de324ffd662915ef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccomp=
-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccomp=
-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63cf889de324=
ffd662915ef7
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
