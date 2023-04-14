Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1206E2A95
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 21:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDNTSc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 15:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDNTSb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 15:18:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D803F40F8
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 12:18:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a6674bcad4so6771745ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681499909; x=1684091909;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qmx5q+3O4kGIE8XzMPB4UE87sK73bBmx6UrLBilywO4=;
        b=DQ4+LUMxg6eABNO4OVELuArfm0H30g284yZLxnT8DXz1tokFMSF/jCmw0TLZcT+qvM
         q4iqTv9QEGFTTjqDNbsLSCq8Dt1jf3liWusUVdveJNKMEjZc3UQXYMPWk8eWfjL+6TIC
         L2FGtCwLFjF4BOZJ7bBWRAF8pk6Q7sCRGyg0r7MWRH2eRKRslh7buyzXdwen8bUVLKz+
         TApJ3koB7q+O0+9SUTkq2xpFQVGcy47Rvw+Ha/E/r4FHQEQdtiRtoLBWFnXCw5hpW+in
         KpMdyjRE6yKTR7qFOelWRPDDfLfS313guEJduSyOfkRL65FsOb2BzNm056HyqbRuT+Qp
         S1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681499909; x=1684091909;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmx5q+3O4kGIE8XzMPB4UE87sK73bBmx6UrLBilywO4=;
        b=N7S2rmzeG2q6c1uq85/roidbLzaX4wSeM1lX+qEWSI6Zxuz7VX6XcWoJ0fxpisKZFW
         lGWNAWw3iUotQVQbuQMUTx58Zyy0M1RRMroYRN8XhjGuE6JfZ9gg90Ox6211AfVWEa8E
         lyP7wr2mXY2g/Pd1E2A5SZQLL6hadZ1eA7RheYIRAEG7eywHMmqhY3yvYZwku62pJh6h
         +r4pHq92KBj3YjLtx1L52n5xFzwwV3UimIzz1FV75JA4PIN6WW6cG1viGh2Xo+f9xqJG
         KPG5aZIJ0hz52Fcc9djObM0gRbMkF60/SprEjQEmF7b3PXg6Tld6WmoKMCGfsXdoPuNq
         s6dQ==
X-Gm-Message-State: AAQBX9dPKTytnO525e1tFJIZMl5d2RLC8SoMQvUNfsx429pSXdtbp0/7
        +KN1Lxf9qEZZ628CeN2/YAId2NEtDJMa9MQvLJsel2XF
X-Google-Smtp-Source: AKy350Y6K3CFONRA3ISh3GzTFLv+4NIHs3IJBDvBacnUo1zdkqpTl3QobeCZ0J2/vt68KnN4tMq0zQ==
X-Received: by 2002:a05:6a00:1a4d:b0:63a:fcf5:fb48 with SMTP id h13-20020a056a001a4d00b0063afcf5fb48mr8558876pfv.27.1681499909316;
        Fri, 14 Apr 2023 12:18:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t15-20020a62ea0f000000b0062d8e79ea22sm3374788pfh.40.2023.04.14.12.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 12:18:28 -0700 (PDT)
Message-ID: <6439a704.620a0220.35a02.8183@mx.google.com>
Date:   Fri, 14 Apr 2023 12:18:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-25-g50ad2fb7ec2b
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 4 runs,
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

kselftest/next kselftest-lkdtm: 4 runs, 3 regressions (v6.3-rc1-25-g50ad2fb=
7ec2b)

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
-rc1-25-g50ad2fb7ec2b/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
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


  Details:     https://kernelci.org/test/plan/id/643994f25d3af187fc2e863b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/643994f25d3af1=
87fc2e863c
        failing since 135 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/643999ccdbc900cee02e85fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/643999ccdbc900=
cee02e85fb
        failing since 178 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64399bc189723ef7812e85eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/64399bc189723e=
f7812e85ec
        failing since 178 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
