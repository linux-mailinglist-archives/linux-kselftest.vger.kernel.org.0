Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9667233E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 02:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjFFADA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 20:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjFFAC7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 20:02:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD865F4
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 17:02:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-652328c18d5so2711270b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 17:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686009778; x=1688601778;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qedegr9Z0Kqz2v0Lk+TqxghzXWvGjWa/BUVoxIqSQ4w=;
        b=r0cAboiVugRXAC0cJUTS42xYXVg2M/4YwMa9NecMsNyQCYA2COE27l1gbpoKSjWVtS
         NnK6RDfNmKWkX9YjrU9qDmbiBxiIkHwxmlBQc6erxekwkV6DMIjj2VsfJtxiz8GtDgSR
         C8R9GuUoTwAqTJo35Y4ydUGd7eG+hCaD6JTZXkg94EKTqagQd7TbyOkw6khDq/mn26Tw
         zXoxCJgRbMbKtcbSBakSznajFBYAncRWvPwpatZhYKlvtyCdTHybdOLNHUhpQlLyNdnR
         jOKss0X3LNifvEDK+JvGznaayrN7eoldQdYMywCu80JwD7agyhvkOfAQsClO+4QHmbgl
         EokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686009778; x=1688601778;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qedegr9Z0Kqz2v0Lk+TqxghzXWvGjWa/BUVoxIqSQ4w=;
        b=Y+UBeyA59VAEbwhLIrhbnAE8oT3sl3lEMuU9pqQMSppm5/OC7XKZ3XgRI/QlUozOj0
         Fb2h+UZgnplu8SAeTu7ctXbGLAUAH4LG8H1Jq8i/Q4ghdFc4Vv4YJNp8LmyEpnf1kyL1
         PXEqsVHtloyTgG1KhrOLK/M9JgnF1oU6brVy5Nb2TpPAVxPwnceDIepQO9FeD9Rl0jJf
         V80srwDm5pZFOQL3m6MD22GiV0w4mninwBVGLDYBpguazSQ1E/xdGCcisv2p1fAwm8iF
         au8Hw5sPm0f0kjXkNSYhVz5pBSoyRJbDLuYQc+w+qkncWDv+PIDPpHHn9gqPxjhMxKPd
         Utog==
X-Gm-Message-State: AC+VfDwjKOuFEoPCFtAgIuvZelukMCTcSvCrGtkIUw9rHSHR2aKaY1z4
        OczOBxolEUcM5mv6QbTIGMbFCg==
X-Google-Smtp-Source: ACHHUZ6o3HVVFGa+G4yL3TlV+r4vuCxj0nSb8dwh/kz1DTr9c159x6GMhvcNqAyHbSxd+ESYObZPBA==
X-Received: by 2002:a05:6a20:d906:b0:112:bdd3:9b81 with SMTP id jd6-20020a056a20d90600b00112bdd39b81mr444326pzb.15.1686009778243;
        Mon, 05 Jun 2023 17:02:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p20-20020a62ab14000000b0064d1d8fd24asm4084107pff.60.2023.06.05.17.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 17:02:57 -0700 (PDT)
Message-ID: <647e77b1.620a0220.e4fb2.6d8a@mx.google.com>
Date:   Mon, 05 Jun 2023 17:02:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc1-9-g4d1deb59f3ff
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 6 runs,
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

kselftest/next kselftest-seccomp: 6 runs, 3 regressions (v6.4-rc1-9-g4d1deb=
59f3ff)

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
-rc1-9-g4d1deb59f3ff/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
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


  Details:     https://kernelci.org/test/plan/id/647e64ae2d49db397ff5de84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-s=
eccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-s=
eccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/647e64ae2d49=
db397ff5de85
        failing since 160 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e6bd0bfcc8f09caf5de57

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/647e6bd0bfcc=
8f09caf5de58
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e6ca4d9585d0f57f5df15

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/647e6ca4d958=
5d0f57f5df16
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
