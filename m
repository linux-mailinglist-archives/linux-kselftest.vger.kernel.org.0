Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E312D63D6EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 14:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiK3NjF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 08:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiK3Nit (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 08:38:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B9B2EF43
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 05:38:33 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so1990347pjp.1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 05:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A5z9SYRBUkF8lnNQbe5xISr/gyUhpqAvuobRPpfKFnM=;
        b=ODJ2xhrBDQYp2UF2AT2xLQ0UPih5et15hg1o1gXAVMd9Wyo5PA8BmZWsGUcAv1ZU/U
         P95QYHAcKvnDtW3IcEs0VQwBJcTTEAYJqe2DFicvNk8NubdE33rG3LCA96qMPil4PDEY
         Er7DJWobOhQIEGtoZ3T8gPXlidyd8tegf0XdWYi9ni5JVqoTzpKNOSwDwk2XQdCDy2VQ
         r0sAXgnmttPzrz7aEj5IigVC7iIi/4jXNoNNUC3MIuE4VdCxWR8/EGqRHLQSqgtTQIFT
         jZH9Zz3ubgZ9MUyAdAJrml4M997h603nc3BTiwhqh+Wmcl5TtMEoD0uTL52Hfsm7tMaf
         QzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5z9SYRBUkF8lnNQbe5xISr/gyUhpqAvuobRPpfKFnM=;
        b=UW1D7mJbf+pQqsk44VVh0rJ/yTn0aBO4NB+nSIQe00mgjd45do1o2GQtq7boyPgcuN
         NQQDoD4AHOcpP05O8D7dmbo97ZaC8y9ix1hzpVXs2+m1gOZPf6H8UTAmjtOgL6NaNdK0
         VPfC/RnBEvCtmCVDKTlknKMPMEd1KcdrRqHdiIzR3yY+BX5IwsgJrWJFOL7M+Rq5Zbjb
         cqvU2Z/NMwHsXytjD7U7ZAKlKdvwxVJxqfMJssAcaf+j1rAaj+5jBt6rCJT2xJ9oYUC0
         rqJZBkUupb1d8BNW811VsBSQZhnlIDcZ+rkYTEIBiNUPOOz7wQA1ilzQ5eRjQG0BU/JS
         gWIA==
X-Gm-Message-State: ANoB5pneqBVW+hLVnVdrvieeqB1VgvOUskObdJpK6uu1hY2VDdJyKJkh
        bwlfOfWJq24Qai4ybDmV4vq80g==
X-Google-Smtp-Source: AA0mqf7Wr2gWDQJbUSi2uzJsZwBSMF8CONjCmNtMOd0UeRcbrbqHOtVrMnBWsSbVyEjsz4wpCeLzuA==
X-Received: by 2002:a17:90a:c68d:b0:219:80b:6ea with SMTP id n13-20020a17090ac68d00b00219080b06eamr29511828pjt.212.1669815513023;
        Wed, 30 Nov 2022 05:38:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u184-20020a6279c1000000b00571cdbd0771sm1404887pfc.102.2022.11.30.05.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:38:32 -0800 (PST)
Message-ID: <63875cd8.620a0220.8232c.237e@mx.google.com>
Date:   Wed, 30 Nov 2022 05:38:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-23-g8008d88e6d16
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 4 runs,
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

kselftest/next kselftest-lib: 4 runs, 3 regressions (v6.1-rc1-23-g8008d88e6=
d16)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-23-g8008d88e6d16/plan/kselftest-lib/

  Test:     kselftest-lib
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
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63874c8ce23c0d01da2abd15

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-m=
eson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-m=
eson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63874c8ce23c0d01=
da2abd16
        failing since 43 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63874f2153425b5bc72abd02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63874f2153425b5b=
c72abd03
        failing since 43 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6387503908ab4e6dd52abd07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6387503908ab4e6d=
d52abd08
        failing since 43 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
