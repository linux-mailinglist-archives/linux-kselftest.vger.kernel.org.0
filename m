Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BA0679356
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 09:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjAXIoW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 03:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjAXIoV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 03:44:21 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4143A84E
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 00:44:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j5so494199pjn.5
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 00:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DfN3xIl1qXCw0J1PzFOxrcKiQDcH3X8cjPXF/hicN38=;
        b=CmNQ0Tz5KmMZ4eeQ0gGT/EG7NGMUHBRf4qcZKv4c2KD3CuaBBrTONj/ewXDeiVtHNi
         6CWfxx3r45pjVLF5DGk4xdrSCk+w6hFlRHgSnA9jYLmFy/sbF5SjzofOML/FeycnuR55
         +OrLjcKKCmzhSnikRBYlTW/I5ykctO91oGZlzB0wg/lAGJi56GYZDLeUKxWyZcJ3dHm7
         H8q9J2ISdyvtmJgwdqvgprs1BDuuPz1Lx72Kdt0bElJDCNE+yxkNDmWUkyHLDNL3qKEk
         KOvfcdoM82ckAxY0q22TtzTQNkoD/51HWrC7Uy5DLacv8tRPxWG/CIkT23ntszyKC9ef
         VVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfN3xIl1qXCw0J1PzFOxrcKiQDcH3X8cjPXF/hicN38=;
        b=jZohbhX/JJsaLB2Ui/W+QbglYBliSg/pH0OcXwor8+hWOAvuctcIinCvSwPxg/6RfN
         sMqZgcbZ3mq94jNn0gdUHAmLatalWViuBHE80KPITaS30bLv18nFHp0nhvpevEQG+950
         73LVzju+3sxkszFXXPraUD4XzagONaA7xp/wToFAdiVB9hYMDL+cl9t9dCXwTI+Yh1CF
         XaLwdFrVBtOCrMhVxtUWDQiTzrtNw0SExHo4qDki4EJBqG1eTh+cV5WG0Wuqc8K76gji
         wAddn3q4w3Bcg84okiYm8BENynMkj0C0mSdKq04Y1a9c7hYxGzTFmgJCciLfRPLYqt68
         K5pg==
X-Gm-Message-State: AFqh2kpXE4MRiDS1giZLpbFnFvqRObsrCE7L5lt5zlyvdR37wpTRO/Nj
        Zih9VM9KX7WRS1xHjaGFEsqQQxBqsZajoyGEutI=
X-Google-Smtp-Source: AMrXdXuk4ASlhoJbkq3LzPlmsctZyjI+2sNfpVlm7MEFNluxJmMgec9JYqHyIWB67wgJI8ZSZa3S6Q==
X-Received: by 2002:a17:90b:3cb:b0:229:2441:53e3 with SMTP id go11-20020a17090b03cb00b00229244153e3mr28053205pjb.39.1674549859033;
        Tue, 24 Jan 2023 00:44:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id nh15-20020a17090b364f00b002276ba8fb71sm777616pjb.25.2023.01.24.00.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 00:44:18 -0800 (PST)
Message-ID: <63cf9a62.170a0220.1b767.1148@mx.google.com>
Date:   Tue, 24 Jan 2023 00:44:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 5 runs, 5 regressions (v6.2-rc5)
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

kselftest/next kselftest-lkdtm: 5 runs, 5 regressions (v6.2-rc5)

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
-rc5/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2241ab53cbb5cdb08a6b2d4688feb13971058f65 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf90c5eeb2dfe397915ee8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63cf90c5eeb2df=
e397915ee9
        failing since 54 days (last pass: v6.1-rc1-23-g00dd59519141, first =
fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf8da66750665263915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lkdtm=
-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lkdtm=
-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63cf8da6675066=
5263915eba
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf88b9df0df669c6915ed1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-m=
t8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-m=
t8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63cf88b9df0df6=
69c6915ed2
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf8d9ea4a42923f5915ed9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lkdtm=
-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lkdtm=
-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63cf8d9ea4a429=
23f5915eda
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf88b1df0df669c6915ebe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-m=
t8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-m=
t8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63cf88b1df0df6=
69c6915ebf
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
