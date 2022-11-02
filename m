Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC676164AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 15:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiKBOOh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 10:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiKBOOd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 10:14:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E914924F33
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 07:14:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y203so2381915pfb.4
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 07:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OS0t+Ap9kJlgeZQyB95jK6vsbRXUUSVakhirnYahl+E=;
        b=3Tg6j80tVf1ZcV85ietTZ5DaUQNENDvDm0KY9jUZVk2jwV9cVQeGkvqdRcM35xOxEW
         jGqhLzOyY8o3LYpBtDZJlECE2xPFx+Z8uNdqqOF22o77/UgVl7VDJDtig6uuG8Rk4JPu
         xAPdH0uENnjkMIkEtXgE/lQVo1hjf1H+AiTQ7fHXuQAH0Uqt3chi9q1H/kYKntjsupWz
         sjfxlzCi5wxM8mwHyWtgynjXjyaWLbZPpIUb01tE1U6Mf2pljyiwDP8x5F1NtQ4y0RIn
         MRrXX33S0vD1mltGP8FUqVqXjSCpfiku28mShJWgeHR+/zWSo64QYSK9C5JfN3YzwYUg
         NR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OS0t+Ap9kJlgeZQyB95jK6vsbRXUUSVakhirnYahl+E=;
        b=BuV5FqG3PCXRks6vRrQyNwII3cqXPq8DQ/9IEaiRIW4efBkp5DKOiXwEIMvlUG5SSe
         SZi1Hy4AK2gQVctdMlcVtpCViO+VgEvZEuuCHmdNdAHjCMMS3slKgmba7ur7ik7hl4gF
         4hYzBEKv8TWLSV1TQaadBvhb5szaPLwo7oMYEcTSPjlPR1F1Sqx681IcsUp53yvKSprl
         YVeQvz1Ns8DAn/01/9Umq2MXZPMXW8oZK+zihCwXenpxF6sUuPnmbwlZBd6iAHGv6+pQ
         101rMiFuB0nMvDROlN4SRG8EWZ8j6hqK7LRLU0sTMltBBlNQYPvI2Mv5ZtqS2vdub4Zz
         UkpA==
X-Gm-Message-State: ACrzQf1Mn4iyoVQq2hslw9pvQhFqkW63jFKVzwVKxK8pKLzdTm2xln6B
        ZyKAKElb+LRTba8cYQQPvzD1YAcg9xEM5Hjl
X-Google-Smtp-Source: AMsMyM4EKMv2bIoHZ1Bb6wGCi2Yd8QK1CGU8+zIwQVSutqHGF1PpBKTNFmg+Sc8HwNklJJZ9lHQ/Cg==
X-Received: by 2002:a63:f047:0:b0:46e:b1d4:2a68 with SMTP id s7-20020a63f047000000b0046eb1d42a68mr21619442pgj.496.1667398469467;
        Wed, 02 Nov 2022 07:14:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b0016f196209c9sm8434884plh.123.2022.11.02.07.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:14:29 -0700 (PDT)
Message-ID: <63627b45.170a0220.2e5ec.ed7c@mx.google.com>
Date:   Wed, 02 Nov 2022 07:14:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-lkdtm: 5 runs,
 5 regressions (linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67)
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

kselftest/fixes kselftest-lkdtm: 5 runs, 5 regressions (linux-kselftest-fix=
es-6.1-rc3-3-g89c1017aac67)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.1-rc3-3-g89c1017aac67/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      89c1017aac67ca81973b7c8eac5d021315811a93 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/636269807a76994c7ae7db5b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/636269807a7699=
4c7ae7db5c
        failing since 15 days (last pass: v6.0-rc1, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626ea50720ac3502e7db76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63626ea50720ac=
3502e7db77
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626ae456070808dfe7db55

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63626ae4560708=
08dfe7db56
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626e9d0720ac3502e7db6a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.t=
xt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63626e9d0720ac=
3502e7db6b
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626aec56070808dfe7db6b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63626aec560708=
08dfe7db6c
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
