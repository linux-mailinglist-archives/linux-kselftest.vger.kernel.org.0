Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EF6617C56
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 13:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiKCMRc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 08:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiKCMR1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 08:17:27 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD39D643C
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 05:17:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 130so1412586pfu.8
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Nov 2022 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Oei17uOi85k7K6dBVTUEmbp+3wfN7D3BBYE0xnT7quQ=;
        b=0DycTCa40bKxbmkRzdyfMwp1heoeBiqdIFVEcOXYjgC2z8vqcn+5iz8v+mSEydWVHG
         T+VXWBZ1uHeJ0IhH7j+FaBZewgkvCOCbgS4SDNi3fMh49RZYOK0zm9irzjaCGK2VlwsF
         ZzHOCZDOz6jH/97oesxxUDQctRjhXkecuXh460VZf6+0oPCksmWJE7WelOkXnLqLhuq8
         zzqCrOa5H85b84E1Se/q+174iutgmvwObj7skR1okOjFMt/UXh7OJZWt1BHdJ0DZYGZQ
         5+Ja4Xx/vzbinVVR6uXmNjzdaH96AUCshJ8r1uPeHGAvHIPpvEOrr8B1pUGnwF8Xdy/8
         nb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oei17uOi85k7K6dBVTUEmbp+3wfN7D3BBYE0xnT7quQ=;
        b=UKPjvGxrlpmsvHsY4cGSFntYyyCgW2GTX9+PKl4eko7RDrBo/FBWIgQToYlcwV2Eg3
         UaXS1CKUCwfRPZi85AQPtnS9bAN/iGUVYwcLWfCRhA4Sc+G+v8mjpFcMu7DmluuaVEIt
         BCXDwxZ6SYQby2dhX9bVHAShKJkC5qminfBLswqQDVoOvWCJ1Te75ukOn9B7i98X8yh7
         PB6Jf0xdXjSVymvixjve4rftYh/7K4udlPcV6fFaElMO55L2Rv//3JFo2ErAw9QVBNxW
         z5UdI/e682iqHMupFeyh9FhWYg7j9NZ8c/P0ma3dXfjlAHUALC7Lyrn2VJQ52e84R4ut
         Ex2w==
X-Gm-Message-State: ACrzQf19aDPGBPnS7cMuc4D1jAPc8AGB3fwX4iZrDCvUA8azrCXiw9gM
        HFnTbTpsREXqZSiZDzyVns2qOw==
X-Google-Smtp-Source: AMsMyM441Jczgq6T0hjSUTG8B8F/9mzUtJqusUCQXoA2U+JrEbCPg5HEMpskz901Yu9+jKF++qftFg==
X-Received: by 2002:a63:105e:0:b0:46e:9bac:1c3 with SMTP id 30-20020a63105e000000b0046e9bac01c3mr25026064pgq.388.1667477846270;
        Thu, 03 Nov 2022 05:17:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l16-20020a17090a071000b001f559e00473sm3229085pjl.43.2022.11.03.05.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:17:25 -0700 (PDT)
Message-ID: <6363b155.170a0220.7a918.5dbd@mx.google.com>
Date:   Thu, 03 Nov 2022 05:17:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-14-gd942f231afc0
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 3 regressions (v6.1-rc1-14-gd942f231afc0)
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

kselftest/next kselftest-lkdtm: 3 runs, 3 regressions (v6.1-rc1-14-gd942f23=
1afc0)

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

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-14-gd942f231afc0/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-14-gd942f231afc0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d942f231afc037490538cea67bb0c667e6d12214 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6363a214af72d688c5e7db8b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6363a214af72d6=
88c5e7db8c
        failing since 72 days (last pass: v6.0-rc1-1-gf1227dc7d0411, first =
fail: linux-kselftest-next-6.0-rc2-1-gab7039dbcc61) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6363a17718be19251ce7df58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6363a17718be19=
251ce7df59
        failing since 16 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6363a1918436f297c4e7db52

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6363a1918436f2=
97c4e7db53
        failing since 16 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
