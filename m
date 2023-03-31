Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D276D2687
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjCaRU2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 13:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjCaRU0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 13:20:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040BCB474
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 10:20:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso26110037pjb.3
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680283224;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iPT3W31x2j+JJJTffuGI48n0z7fVw4JxvH77ju/Af3A=;
        b=oavfO98pHy6LPyDmJpfKYtk5/hTAdr6AAlz7q0x3/5v25ClnIWLPq4d6niRs8dgYEx
         CiK6pZkojmGBqCYM9fBMV/C8c5E2vrGbmblDSAsQiROmV6xPMimPQVT/GGIOlXZvOXuT
         KYSRfh/te/KGhVL7scQWgWO8K5bQZvxS+IYwUEUO0gG8y1CyIE8Mzhx83Mhgbllk7daz
         xh8V9iinxt2/GsHxXByHV2b7jDJ1rcMRXhq35Y/fNVmImNrrReagtwyH5e/VIzwFI67e
         ua7b4EIba5RbA5sdwjbnBVw/4Pi8MGHBVuM23D8QprwDINPg5ov6B2ddXdorC/C06Pup
         Dk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680283224;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPT3W31x2j+JJJTffuGI48n0z7fVw4JxvH77ju/Af3A=;
        b=1EULImAqCeTdVlNt10PoCjYSANleeHqiiPePcHcvCaQ2HBHoIupP4ccvsOei4VSbs9
         3bMbAf3CYPvT8aJ7wi3o98S5KBaNom5zBvAz/t2PU34wjIjxECP0We7pJNgHjJfors6x
         V/ZXH0MKhuculIjupMWBeEtVjq1bQgCVSyXbsAZN/iaSFEaPZ0xuvuwZxsa02OeW/gnG
         1ZnsYi9J+ohgeUZS8Bv+Mvy0SzKuCNarSqrUZXwKOZ5Wo2oIYwLk/+g9nmgNh+KKK/4d
         4nGzQzW6dJ3OTpcmDsSkpDl7quABBd5/w+3Z4nB1fPWPoFu0cpPvScW5z1kqXdXnpeBE
         cy4g==
X-Gm-Message-State: AAQBX9ftgAwn+9UrvMyfqJmGHQt4EYN9786f42WuJ75+aNM5YLKSYMb5
        MNuPsEHg2HacaqCje/i8xNCsng==
X-Google-Smtp-Source: AKy350b6nUtUPO6lRLIq/8IyTZ7MENgY1H3PCRoN0bpnTbZjkN+lBRREkuDB09Biv1o9uqK8IXN7KQ==
X-Received: by 2002:a17:902:f68b:b0:1a2:9334:f79a with SMTP id l11-20020a170902f68b00b001a29334f79amr7390325plg.38.1680283224480;
        Fri, 31 Mar 2023 10:20:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902c18600b001a04d37a4acsm1846495pld.9.2023.03.31.10.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:20:23 -0700 (PDT)
Message-ID: <64271657.170a0220.1f62e.3eb4@mx.google.com>
Date:   Fri, 31 Mar 2023 10:20:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657
Subject: kselftest/fixes kselftest-lkdtm: 4 runs,
 3 regressions (linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-lkdtm: 4 runs, 3 regressions (linux-kselftest-fix=
es-6.3-rc5-1-gf1594bc67657)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.3-rc5-1-gf1594bc67657/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f1594bc676579133a3cd906d7d27733289edfb86 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6427051c668029d06062f771

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6427051c668029=
d06062f772
        failing since 164 days (last pass: v6.0-rc1, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642706b8af6517d97b62f77f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/642706b8af6517=
d97b62f780
        failing since 163 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64270556e41d0a343e62f786

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/64270556e41d0a=
343e62f787
        failing since 163 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
