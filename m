Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AB9656654
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 02:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiL0BF2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Dec 2022 20:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiL0BF0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Dec 2022 20:05:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331BE273E
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:05:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso15948501pjt.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma8Q7SVUQkHya/UmXsYrzPqtRk0+IzDOgsMYjiS7rnc=;
        b=4GxluoMOLGzRq8iSqrV4x6Mk2xSRgyTrLJpTbncizs/nPU9ey/zHLJKtk3nKs+gQvx
         PIqGU55tQeAmLA7kF5GmDrJJ9ETrnvab5Jj34uqsALZ296pAa/14hnN+kqZeAE4jSDX3
         PEDZ25+swnH58NXoWnUsvYS04KeTjWmnwNfgYee7sPyxPSXmMAQ298gle00WN3M/U0ZI
         KToufNcRGibrmirhyrSXva1BTzoWkKLMfuLy38UwpvzysqP7xzAxQPkm3V18qeAabUh3
         QPz3+aKfRKrRd/KYNgNIuWhUTkqXCDNatx1QrrKZBMb6ODSfV0TdPtR2deTo4l+iyRpf
         IW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ma8Q7SVUQkHya/UmXsYrzPqtRk0+IzDOgsMYjiS7rnc=;
        b=E9frg/KCbb87TQZUbC8aHsew05Bs9UC7HXbpFRuV+ONP5Icf8+bSCTRer6y8fNKfrH
         Y7fMMher+B2MFPKjq6kjMj7bv0riGt068kzs9VWmNHVaRiLVI3YVNIdZTM017Q4JG8/n
         SX2OQwcAWtdOXgCfQyWr/olQc1QsJXUkC2Z3aJ6EVUPVxNOiR5sJiqBD89pPQ9cA2TKg
         FFG5+Z297o0p+7G/S36I7FhGr4v+PyoPnTEggS98D1cDLEbQUDk6/KeMB75GrJpXfYJs
         9mnPTvR/PuagqJ16kGH1N1r8kjyUT1wFTBnCxPFsc2VwLpX9PMmeQ0i/RyJgWZPzIaK4
         b67g==
X-Gm-Message-State: AFqh2koV08By8J0uDB6pW9GMzaDUldBR22lqm8HKpOl/BZcFPuLgAklg
        h7c3cYiRh/XgYr5+T8VF/+tgDO+p0sSWUJDihRg=
X-Google-Smtp-Source: AMrXdXtxl71aA0jAMTxfqbRUHi7WkblIxK/WughjVvdslRRTEvo5USuzBbWA9S/4lbUP29iQg+L5lA==
X-Received: by 2002:a17:90b:2487:b0:225:ec6b:71a2 with SMTP id nt7-20020a17090b248700b00225ec6b71a2mr6555851pjb.42.1672103124618;
        Mon, 26 Dec 2022 17:05:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v3-20020a17090ac90300b00218a7808ec9sm6893226pjt.8.2022.12.26.17.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 17:05:23 -0800 (PST)
Message-ID: <63aa44d3.170a0220.c90b5.c85b@mx.google.com>
Date:   Mon, 26 Dec 2022 17:05:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 5 runs, 5 regressions (v6.2-rc1)
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

kselftest/next kselftest-lkdtm: 5 runs, 5 regressions (v6.2-rc1)

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
-rc1/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      1b929c02afd37871d5afb9d498426f83432e71c2 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa37223f96cdff844eee28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63aa37223f96cd=
ff844eee29
        failing since 26 days (last pass: v6.1-rc1-23-g00dd59519141, first =
fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa37fc09a37c9c1b4eee31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lkdtm=
-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lkdtm=
-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63aa37fc09a37c=
9c1b4eee32
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa3647882f4d5fde4eee21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-m=
t8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-m=
t8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63aa3647882f4d=
5fde4eee22
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa37ec4e8ad6a4194eee28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lkdtm=
-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lkdtm=
-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63aa37ec4e8ad6=
a4194eee29
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa3660882f4d5fde4eee2d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-m=
t8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-m=
t8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63aa3660882f4d=
5fde4eee2e
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
