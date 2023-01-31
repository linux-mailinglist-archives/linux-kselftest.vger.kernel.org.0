Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4383A682CEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 13:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjAaMsS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 07:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjAaMsQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 07:48:16 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D9545F4A
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 04:48:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cl23-20020a17090af69700b0022c745bfdc3so7746691pjb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 04:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W+Mr97/E9snB2WQ7PBpN7pekuWEmNFwvGyGzYhapwrM=;
        b=v2FIeJGK76j2o9Os8fHfzGMKDrJUSJeBtWbUB+e+T2DkcL56I7tVBFUxDH9/p4JCKC
         aFZgC4VmDsvh8v0Ag+EjbT0nqnqogB875PF/QreHVAHnIkLz/F2SYTXbUle74gIhAPqv
         u6Xxi2lrvRgCIxynnLvDG3kb/ANNhwMGAHFjKWB5yvneuGSMH61zLmbJclWfHfdINzaz
         6oY6hrQ9LaPNGUQ9xst70P7wZgQxxs5Ztg+BBJMzKuCY+dPFf1axzatlp6OrrpiEe6aD
         em8BF3ZPEdzKrvR7N0i2RnUpNr80vv7PieD8EWpFNrMhBZ81HBkj6qR2VikEFEcN/vE0
         qtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+Mr97/E9snB2WQ7PBpN7pekuWEmNFwvGyGzYhapwrM=;
        b=50rx2MSZA3rQGRYL6zCGvOLU2Ca0X/P02J/xCxCw4fjLxeq+0P9JoVNz7pmuSstyZg
         PjpYYKGknG/oJc2uo488mW1QrLpx7i/5JfFvYxPJScJZRJyG+JAJ2HqPiN/dFhWLT//j
         uo3jv22VSqhZ4yMmFbpqZgwnhQ6xqpbqM+U/KFwVmSMjhIRtO9rflNb7JNR9w7T7DsER
         qrG/fnccvyVDvoJD7WqsSiOYQ19STJyE2qp8Hp+Lq+lFoEHOO+WNuo16GbN+dXJ37A0v
         5fy5QNzyd2D4DpVf6ojDlbnnz9VPsWbXABFPm7AjijflhWvMi7iyuyQg2j8jiV0pIB9j
         /GAw==
X-Gm-Message-State: AO0yUKVYQbaN3+y8D25BlViemmFlqDRmTXuIUC0+UysHOohj8Ef8YiDT
        iSqTZHW1payHV6Y2gqfOBnVVyg==
X-Google-Smtp-Source: AK7set8r/16ATExd0CpgT9Mulc1YoZjggSnCs8ywsywKSj35YRweeH4rEtO7xHWuX9+OvoSYDak4Yw==
X-Received: by 2002:a17:90a:72c8:b0:22c:8171:e366 with SMTP id l8-20020a17090a72c800b0022c8171e366mr11024082pjk.4.1675169295022;
        Tue, 31 Jan 2023 04:48:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h2-20020a17090a648200b002296094b9cdsm10689923pjj.24.2023.01.31.04.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:48:14 -0800 (PST)
Message-ID: <63d90e0e.170a0220.bde5c.1209@mx.google.com>
Date:   Tue, 31 Jan 2023 04:48:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-31-gc837391e4499
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 3 runs,
 3 regressions (v6.2-rc5-31-gc837391e4499)
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

kselftest/next kselftest-seccomp: 3 runs, 3 regressions (v6.2-rc5-31-gc8373=
91e4499)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-31-gc837391e4499/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-31-gc837391e4499
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      c837391e449979b550a9aabfcc253d245b5436a1 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63d8fd1676c8084153915f3f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63d8fd1676c8=
084153915f40
        failing since 35 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d901bf148262a349915ee4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63d901bf1482=
62a349915ee5
        failing since 105 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90135ae8ccc9611915ec7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63d90135ae8c=
cc9611915ec8
        failing since 105 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
