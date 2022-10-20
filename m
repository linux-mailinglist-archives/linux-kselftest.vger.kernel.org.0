Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8434060672D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Oct 2022 19:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJTRjp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 13:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJTRjm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 13:39:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4074F2D1FB
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 10:39:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pb15so78774pjb.5
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y67PDJ0WDwhr9WznIq1oDVeQdkx69NqsZn1KNxjf8Ds=;
        b=N3hY4TweR3t0y+Eicf9xWwTuLLZzhCUU7VnSEV4ZSW4984xDOKr+kCXxbCTI/Fjd54
         I+++RxItfsV//Jq9clFOmeACuh2PzX4rJgPS/MA3VENIHzJbZRcbwqss5SY/7NXR9JcV
         5P3l/gzdpX6YsWOUEk4JvLoa5pAqYbuu9ovT142W0OXaReg9ZKyM5QCslJXuHHrAesNd
         DrUFSiwOAEMczQNep194Lql8ZmTIRC+CXB7g/eb5jc+n8AqQ1kQ7r+HnfyzDrQUM1NXp
         3vwpy4MfB2rm1RoWHG03NM0tZ4wwm18JPyii8o63bau0ZOGaG8gnlQr93Rw721VPsSEl
         ugCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y67PDJ0WDwhr9WznIq1oDVeQdkx69NqsZn1KNxjf8Ds=;
        b=3eftJcWcLZASIYsTUEyVlI7EgJ3bAebaPNWsVqOn+tShMjF6ntTvczpe7pVQsEY+Xw
         Nu1WmLPThAyWM8cbePljW8Ph5RZo6zeoi4newFMuQ3Uve2rPOaIidkl1I5XAK44jbe46
         RP2jWAyn7fTiPKGr90FIiVTILXQPavNONgaVgTaR4WmO3plmssCAlmRXpcxx190vBbjD
         03GHHwlTriZP2dVhifS2zbN32VDtxBtZRGU4kQL2IWfGSKE6aaHXedA7RAW/HZCZPyb1
         GWN3G9JW3dKAwLeZ5MRJAiVmYo1ICHhVkaC0QQGtb0eDGN6UtTiSiJl2sX2lhPMPhW/g
         Fa8Q==
X-Gm-Message-State: ACrzQf3QupUQdtyUJCbkIUQTaWcgwbs6yGzObg1uk8HEQ3pkKCTOVAhE
        VrODwadFWXGOzFttsmRGHDtCiw==
X-Google-Smtp-Source: AMsMyM74cG/ZpHuQvurh3yxxO3bRGzh0mtBXQJIWOS39JbnRRpILJ8HX/iM7suJFdGE56HmHHms+lA==
X-Received: by 2002:a17:902:ebca:b0:183:d123:e2a7 with SMTP id p10-20020a170902ebca00b00183d123e2a7mr15192055plg.105.1666287576953;
        Thu, 20 Oct 2022 10:39:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 23-20020a631457000000b004468cb97c01sm11891965pgu.56.2022.10.20.10.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:39:36 -0700 (PDT)
Message-ID: <635187d8.630a0220.6ac6a.686e@mx.google.com>
Date:   Thu, 20 Oct 2022 10:39:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-1-gde3ee3f63400a
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 5 runs,
 5 regressions (v6.1-rc1-1-gde3ee3f63400a)
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

kselftest/next kselftest-lkdtm: 5 runs, 5 regressions (v6.1-rc1-1-gde3ee3f6=
3400a)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-1-gde3ee3f63400a/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
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
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63517580b580236d8c5e5b3a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63517580b58023=
6d8c5e5b3b
        failing since 58 days (last pass: v6.0-rc1-1-gf1227dc7d0411, first =
fail: linux-kselftest-next-6.0-rc2-1-gab7039dbcc61) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63517d979546b9558d5e5b5e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.2-++20221003113153+5f620=
d003fda-1~exp1~20221003113249.70)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63517d979546b9=
558d5e5b5f
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6351765f14032ae99d5e5b46

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6351765f14032a=
e99d5e5b47
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63517a7abdae95bb3b5e5b3a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.2-++20221003113153+5f620=
d003fda-1~exp1~20221003113249.70)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63517a7abdae95=
bb3b5e5b3b
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6351765014032ae99d5e5b40

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6351765014032a=
e99d5e5b41
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =20
