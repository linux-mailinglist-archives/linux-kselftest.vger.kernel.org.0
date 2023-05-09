Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AB16FBBD6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 02:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjEIAHN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 May 2023 20:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjEIAHM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 May 2023 20:07:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F76D49C8
        for <linux-kselftest@vger.kernel.org>; Mon,  8 May 2023 17:07:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ab032d9266so49047955ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 May 2023 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683590831; x=1686182831;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zkz9U662TgExGVU4pCctXUzRux4PG5ty00uuBLFMBYs=;
        b=B99bGgmL6WW5rWeyKnkuoHP9+VVCOZEDZNuhyTBgA/BLTeY2P0Wg5NA+4SgaDRnKPd
         mfQ0d9xGnWqvmVFFMHuDlVYhWbM7RknnCZ+zZFcKXudtWnwimDQqERnP//rdNtuISd3j
         KAdBF6TXJwshAdISYByUig2mvfH1ZkWvEMZJ7IrjP/BWRV88S45wlmwcdszAAqyVNn+e
         iDI6nsi1kSgKKsl8DDaJVBY27LkNf7IzX4SZtj6LD6T6CSZ65/Hp/qdYM1qqewAXsict
         cBmqfQbkvFgjGQd9M8ru7+UY4rOJgKCLPvqRGjUKjf9qt07WHbfPDVE2phqV+lTj62+L
         ABqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590831; x=1686182831;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkz9U662TgExGVU4pCctXUzRux4PG5ty00uuBLFMBYs=;
        b=CYw42N1Q6D7bznRuTY4i9q8cX8cMWUxthyWmBrrLrmapoSWO98p4lMnRdrf7kGa05t
         wZji6Cx2vPrSduFFB0xF8wHPmUvMA4723RUdEl1cFeJ1C1nAMI+Zu7dqOUamnAj6I28D
         d7c1oIxDyQdyGCBx4vNNHWWG8/cvhmP6eXRNZOo0XLAFU78FRU/zHCkv8LiMnZJiKhO6
         xIJ8/p+EkriXyJeRRkoChHmBfbysA7QGqU6v66LiIQ/mIYBvePgFcu/3O6/abEYhaFeq
         kpoBPMSFwJRrwJJR8+CYKllYNSk7RwQy3By7hm7MM2+dLoiSrglsZ/X3lCG47toniINS
         Tj6Q==
X-Gm-Message-State: AC+VfDxz1K5n3voYofM5BHrzbuusAh0LA1OiBae93zxS5Pw4VDMGNj5b
        kBwhOBV5F+M4+HMJfzjFS+ynog==
X-Google-Smtp-Source: ACHHUZ5r6ScIaYKpu1DbuLnQkRF1uLJxYm62x5/pkHhqhcdqACNkdgPzuJvz5J3hSjSUuRSlUAKNvQ==
X-Received: by 2002:a17:903:120c:b0:1a6:d15f:3ce1 with SMTP id l12-20020a170903120c00b001a6d15f3ce1mr14869237plh.34.1683590830853;
        Mon, 08 May 2023 17:07:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gb12-20020a17090b060c00b00250334d97dasm6415741pjb.31.2023.05.08.17.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:07:10 -0700 (PDT)
Message-ID: <64598eae.170a0220.165e0.ba1b@mx.google.com>
Date:   Mon, 08 May 2023 17:07:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.4-rc1-3-gd7eafa64a158
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-seccomp: 7 runs,
 3 regressions (v6.4-rc1-3-gd7eafa64a158)
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

kselftest/fixes kselftest-seccomp: 7 runs, 3 regressions (v6.4-rc1-3-gd7eaf=
a64a158)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
4-rc1-3-gd7eafa64a158/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.4-rc1-3-gd7eafa64a158
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d7eafa64a158cc9f1d26b3c615d4ada3c17c02ee =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64597d1c9582b592152e8691

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230421.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64597d1c9582=
b592152e8692
        failing since 132 days (last pass: linux-kselftest-fixes-6.1-rc3-3-=
g89c1017aac67, first fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645984bba2669fd9ca2e8628

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230421.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/645984bba266=
9fd9ca2e8629
        failing since 201 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459858bedff53ce172e87e0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230421.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6459858bedff=
53ce172e87e1
        failing since 201 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
