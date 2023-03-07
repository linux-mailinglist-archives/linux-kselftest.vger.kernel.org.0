Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6886AF2E1
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 19:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjCGS5W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 13:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjCGS5E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 13:57:04 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47218B4F75
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 10:44:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so17523186pjh.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 10:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678214667;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bU/pxsPak8qbN/ze/UUtdfffZmW8HKlj8Q9CviPfnGQ=;
        b=5HKj+uDffysHGzaYY5ioT+iybiW+QUBmsYyjmOw4qtBILGHXh5Cz9vKUWmtPIwxm2M
         1QQVFmQniuN8vjealKaek00n5aifa4YEAJRCySF62+cCvelJ7Dg4s1kIDdClBgjNDF7T
         CHdybecTaXQfmkY/iF5DVZs8eK6wne7BRdFvXECQUianK+9EmFWM0fGP4H89+MZKZiQ1
         hR4e03fZQopruyD5aYy7IkDsuu3vQ37f/1SvZyWOs1IzvMLqdNwg1hMP9+Sj9YR3WbmZ
         znKe0b2Fl58q4uDnQ/svRoytX9cSaNmkXCRhknwcniD+GTWypf23p8UmtVeMwvu6O1Q4
         Y3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214667;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bU/pxsPak8qbN/ze/UUtdfffZmW8HKlj8Q9CviPfnGQ=;
        b=lIIcjNkheIzgLFSPhhKh5RJHbzb/9nIPr5Lc+nhoDnK+X4b6t8XoqSUqtDNX69zS4y
         P3ieSB5Lf2l4MHV02wzNFkRCNnylFqBNJH58PY1a16nOAJ+UkcU5d1wPICbG9AP1MMTv
         GRweWyVtb+MrdxwxCOAG6PyB5ZX9ay2WbjYxNZ64RRjKij4vhrmJaFr7piQj4gNfZYze
         0CTPEizSQ9wsLpPZOIRrAruQU/nR+TJvVUchMWByvOMCls6vEF4WnGa2Cv/m+EFXSVP6
         UPH27xg8D/vEzHiIPfd4Zx4FeNuTCpuZwr9jvycF3GSn6PO/M7ks3VlJ3EntIC2tk7Wx
         3Xag==
X-Gm-Message-State: AO0yUKWDzqkVgzCnGD8ln0IFqSVyxbdg8ZnAGf7OXLY3gDavZROYxEuq
        QYH6wjy/31/iK5Av7V/eDBreQWdtvi6k2FYUVYucdQ==
X-Google-Smtp-Source: AK7set+ebQOmPEVeepWhnSXevvkUaemXj2cv1jdQGCFHh5dd90gL+7qqHgrmJcFqG6aGPdg2n9hoDw==
X-Received: by 2002:a05:6a20:1bdd:b0:cb:6869:ca66 with SMTP id cv29-20020a056a201bdd00b000cb6869ca66mr16627416pzb.19.1678214667409;
        Tue, 07 Mar 2023 10:44:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a62e805000000b005a7f8a326a3sm8187633pfi.50.2023.03.07.10.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:44:27 -0800 (PST)
Message-ID: <6407860b.620a0220.5811b.f9c2@mx.google.com>
Date:   Tue, 07 Mar 2023 10:44:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-1-g2da789cda462
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lkdtm: 7 runs,
 3 regressions (v6.3-rc1-1-g2da789cda462)
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

kselftest/fixes kselftest-lkdtm: 7 runs, 3 regressions (v6.3-rc1-1-g2da789c=
da462)

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
3-rc1-1-g2da789cda462/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.3-rc1-1-g2da789cda462
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2da789cda462bda93679f53ee38f9aa2309d47e8 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6407743f2c62013d088c8658

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6407743f2c6201=
3d088c8659
        failing since 140 days (last pass: v6.0-rc1, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64077c37edecf107388c8638

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/64077c37edecf1=
07388c8639
        failing since 139 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64077a004355929b6e8c8645

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/64077a00435592=
9b6e8c8646
        failing since 139 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
