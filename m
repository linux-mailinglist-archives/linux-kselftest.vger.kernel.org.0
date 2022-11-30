Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0A863D6EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 14:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiK3NjH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 08:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiK3Niu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 08:38:50 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F572EF44
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 05:38:34 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id io19so16688262plb.8
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 05:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FVOLaUkEea6BCTVhLcsBu7aZp0K5zRuTtVfesh5+c0A=;
        b=BrTiJ5Ech+zIDuIUmfF24uJd1oULt1rh5J08Pc4YyCZz8WUieWUnmc14nLBPNxcT4I
         zHtrDFLLpehqbQvdq5vFaPfspSxp9Kwj+6DfVCnoh7uYyCFJYAXXXVUhpWF3HQTgHjWv
         dTw/LW57bDJwPwt5M//RXjMLv56OHb0mBrBBftw2altdDLwJC9PL2cbPnXzrzge5Bckn
         iqt1XCYMVBOgHGCeOyx+PAEEmXr8LnYKwN1roK+g7PNA8STt21Fw98LRgaRxHETSG/tY
         hRzDPpggFMqMykSNoqEMK5DCHlvaWI1+Akbd5u+/mhL3Dw/8v/fH1PkvYdFFLxQ//Mh3
         Y6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVOLaUkEea6BCTVhLcsBu7aZp0K5zRuTtVfesh5+c0A=;
        b=2soYvGCzfv5dnxHAKZ0dRgnRFxw+Hdw9IVzDyN+It11ChgeEyisknhy/lXr9x8TVc7
         5xhL6Z2azlkW2kN3I5R3CB4RO4SXGZguE3ZNdr95Z3JNnibdQMz5gK1NAZlnQs/F+FhC
         EipptwKfX9YC0Hf4KiwXQjtUbmWmiERiB6PqU6JlEeM/Piq/h9FzXgsIib4qojy0PONI
         uTgV08DbjZjYACvm61q9uGSFvNKxn465JY3gzpWGShiQ+IXnfIiMJt2O3VPzQimZyNkz
         AOFZlcQpZohYQ7yc8B6jxKEQtky82Ppgn6ofsiyFZ92XFcb2uv63HADedEQaDfQvcF9C
         p3HQ==
X-Gm-Message-State: ANoB5plgVUKJdegx5sJ6w/5/Lv/FKYg6k+UCems0iUjxdGVObNkpLhuh
        ZaJpiQ0QUBKzdjPIxyJ0yJXYPA==
X-Google-Smtp-Source: AA0mqf5h6iz/kdkajgZ+0vKB5fM/j+z40KIwRGYnbWy9idqD2b8xqtzqaJ+DsBmwax+Qwib3lssaXg==
X-Received: by 2002:a17:90a:de90:b0:219:44f2:8618 with SMTP id n16-20020a17090ade9000b0021944f28618mr12140473pjv.79.1669815514127;
        Wed, 30 Nov 2022 05:38:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b207-20020a621bd8000000b00562677968aesm1406596pfb.72.2022.11.30.05.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:38:33 -0800 (PST)
Message-ID: <63875cd9.620a0220.24e29.2206@mx.google.com>
Date:   Wed, 30 Nov 2022 05:38:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-23-g8008d88e6d16
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 3 regressions (v6.1-rc1-23-g8008d88e6d16)
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

kselftest/next kselftest-lkdtm: 3 runs, 3 regressions (v6.1-rc1-23-g8008d88=
e6d16)

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
-rc1-23-g8008d88e6d16/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-23-g8008d88e6d16
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      8008d88e6d160c4e73de5be7c3dcc54e3ccccf49 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63874aab6407a3c5472abd1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63874aab6407a3=
c5472abd1f
        new failure (last pass: v6.1-rc1-23-g00dd59519141) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6387505108ab4e6dd52abd17

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6387505108ab4e=
6dd52abd18
        failing since 43 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6387504f9b8d4fdce72abd2a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6387504f9b8d4f=
dce72abd2b
        failing since 43 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
