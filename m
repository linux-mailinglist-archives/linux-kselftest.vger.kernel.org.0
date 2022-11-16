Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEF962B128
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 03:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiKPCRU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 21:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiKPCRK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 21:17:10 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C81813EBF
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 18:17:09 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w23so8697325ply.12
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 18:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g0oVZjByKEVbUnzgKvtfM812DIo8pr3LNdUIdkLa0yM=;
        b=esnTSH6WKnLdh2LUDs9co6fIwuC+kLJejRvxvofdawpkCcLhLn6S7emqzfkYkhJw3k
         nP4OHuB2VZHOKQg0yBeXTEf24czYBKfxy/SaZhfMi1ILhkzZgjdRd31XMykdCDgrWdkP
         pLGbgnm2fljuwgcXE0LvM6sFe9zeNFTFs041SXJ0m+JzTaoe8/2ZZLxG/COtDIwye3vc
         FCM9iBQWBhSRsyQacVlHjv3Vu383/mK0edFqCuothlLx4wmx8/f+5IFp5tFWJ7C1dmPA
         +iM+G+96Qc0FfGyr0iC/84IZ1r2FISxjtEI+cJSkk+6fxyYkB8tTK3xFGQ9QsOOKxdB6
         wj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0oVZjByKEVbUnzgKvtfM812DIo8pr3LNdUIdkLa0yM=;
        b=hTWoCI0n104+wdxL0Tr6hFmx74sM4o11ojoMBfi7TJV4UFZs0lJ88Yujti82oFekWq
         BETu1LG8sD95Q7cglFZJiJ6ohvPUTY1jGXMPCLkDqPrIvFbKQjEJp3vVCLDMVmXWR0E4
         Z3hN/KBvKy2KRQsCo5FCPbIeaAq2uX9BuJEe7HIbcrFaGoockiG9voRuXDJrgDg50jK9
         DEieM+umhq2DkLcm6jh3qBPnpQ9tHsjCjoaQ9sByeCkfOOU29QJBAnXMNHAin2Vdj/xi
         mQumA77NyoNDR94D4LUy81i55NVuxRq01ly1aPXtsYXw9veHKUE4+X+zK6Z2E/dTwvFm
         dJ9Q==
X-Gm-Message-State: ANoB5pluYuzzSVjFu3G/pYYkKQIibBMeTGs6Pp0k3YX864HQOeaH09Gl
        6pLw/9wjDtXYu1xfIYmY3CwpYw==
X-Google-Smtp-Source: AA0mqf7OFn4Gmy9UBFPQRxmosuoCj1NReI16SVmUYtwuzXYKPyvYKG9SxW61rErw134dgulTpMS4aA==
X-Received: by 2002:a17:903:3305:b0:186:68e6:ed6d with SMTP id jk5-20020a170903330500b0018668e6ed6dmr6614105plb.129.1668565028990;
        Tue, 15 Nov 2022 18:17:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b00186b6bb2f48sm10758917plg.129.2022.11.15.18.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:17:08 -0800 (PST)
Message-ID: <63744824.170a0220.b1f0f.09ec@mx.google.com>
Date:   Tue, 15 Nov 2022 18:17:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-16-g35eee9a363be
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 5 runs,
 4 regressions (v6.1-rc1-16-g35eee9a363be)
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

kselftest/next kselftest-lib: 5 runs, 4 regressions (v6.1-rc1-16-g35eee9a36=
3be)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-16-g35eee9a363be/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-16-g35eee9a363be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      35eee9a363becb854109e35d568299bafc97c9d1 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63743acf89aebf0fef2abd0c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-m=
eson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-m=
eson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63743acf89aebf0f=
ef2abd0d
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63743bb6a5e924ccab2abcfb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63743bb6a5e924cc=
ab2abcfc
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63743a2571a8911b082abd57

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63743a2571a8911b=
082abd58
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63743c6ad2730cf3d82abd20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63743c6ad2730cf3=
d82abd21
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
