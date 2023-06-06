Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B9D7234A2
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 03:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjFFBkE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 21:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjFFBkE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 21:40:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FC910F
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 18:40:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b1806264e9so30355575ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 18:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686015601; x=1688607601;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OLXrQmNaL3YdTElq8dQrSY0x4bXkot9SrFWxEoLFbhg=;
        b=wmS3a4jc9pxb05VOS2MCUlpXqgRsNwYeghHQFSnHmwql2LJNlaQL5NYLjNUdqusK4G
         /pdLKHFUmhW+11g8G8mlrFbshKUWBE29lv5e19AVFSxCj8oCwV1tV2Dt3IGMTk72S8qx
         CEd2gAQWPezvDM+x+nrs8FCpl0WlT6O6KgiBiD/80G1zoEJTKmEP2JJ4faY4RMyB1DnW
         kxIw1tkg4uPBGL6Yw/s3Sqob33ujgmvtz8IbfxaslLq1FbD10u5WHPm82NsJMVicOrCV
         EkZqrqrB12sfJchX3bAmJ3VB8NrA+7iJiGyuxAGpXbA4yyzeT2VeYUtWTFyK8gL1s5K6
         pJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686015601; x=1688607601;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLXrQmNaL3YdTElq8dQrSY0x4bXkot9SrFWxEoLFbhg=;
        b=gXi6LPvbmCgLCUfK3kTylDw3pLp+89SA+k0EYKWIdPj0WTYjywY05vQw7ga7rgWZ4A
         K/QWQSmElIfcUIu4+74HATI2xPyT6y72X6NEXytkXSpDdBw2AufOGkEzdPmmdKdj3b7a
         CmUJR07YdzkDJP64RAg1TBalKL7OOQcEyXTg+QaVdEUXn5lfl1qCmgCuRtMPDlsA4Ktr
         okxCKYJPiXRXuOclGV8eUpFWIf9bpNplG0tDoOqGpR1aXScuJFm87FixykBEH4RbWMbL
         aawe6LOYDflhptnp/GWPzJ9ZLdxceJFmQCthA+ZdOSWwdODp7vY9H7L1E9GLGtVbM/dr
         9kUw==
X-Gm-Message-State: AC+VfDz/JvNokubA3565jePRE0KXwUBguAPuliYyjAkRAQNw1FnXB4c8
        YLXYBwvhfbs7AK7jHo6W69au2dSiAlY8nj38BifKmw==
X-Google-Smtp-Source: ACHHUZ6CbUBtEMHFGUoi8W0GEY7GGC4cl6na1293H+Mw9BfJRaKyvkfPbkXAmmdrjPuaC2z0qL+JCg==
X-Received: by 2002:a17:902:9888:b0:1af:ffda:855a with SMTP id s8-20020a170902988800b001afffda855amr433841plp.9.1686015601667;
        Mon, 05 Jun 2023 18:40:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iw12-20020a170903044c00b001b00fd3cf5bsm7168562plb.297.2023.06.05.18.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 18:40:00 -0700 (PDT)
Message-ID: <647e8e70.170a0220.687bd.cd75@mx.google.com>
Date:   Mon, 05 Jun 2023 18:40:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc1-8-gd909ae0a8562
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 4 runs,
 3 regressions (v6.4-rc1-8-gd909ae0a8562)
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

kselftest/next kselftest-lkdtm: 4 runs, 3 regressions (v6.4-rc1-8-gd909ae0a=
8562)

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
-rc1-8-gd909ae0a8562/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
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


  Details:     https://kernelci.org/test/plan/id/647e7ce9afde455a6ef5de41

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/647e7ce9afde45=
5a6ef5de42
        failing since 187 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e81287c3f279101f5de3c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/647e81287c3f27=
9101f5de3d
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e8123d6459b574af5de2d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/647e8123d6459b=
574af5de2e
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
