Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7412D6D2685
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjCaRU0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjCaRUZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 13:20:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94271C1E8
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 10:20:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so24095752pjb.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680283223;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KAveTQwv/h9MBDKJs8vfmsBSfpCVq0oCJdYLjwqtq9w=;
        b=yQZlW3M9vlc+eIqavuWyFkEAFyKLt63j77km1GhbNBHxQ+hG5Qf1wYkzMiO7GVCncy
         7eqjFonqVcfXU14XDQnqpGIXNbz1pT9eI281HKoG+i1D71jH3JRbbKmkmmuKcLL8z934
         WxX8umR4Q7PE8KHy9EYuYyTkJvW7FqRdItYHpdY5DTu1OO9wlzwL0pF8Z5l+o2dxu0AF
         t8F68J2MN4+BjeDMJTkcBW6nR6jSRISPYg1m4KgQrtIVhtbSBD3+0gE2634UeevuXYBh
         m2zF3KyTlH23esv6cekjFVOnkXuXDV64PYW5yAmHicrMDPLgCSZHP4r5A1zlXv9BL8wu
         eQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680283223;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAveTQwv/h9MBDKJs8vfmsBSfpCVq0oCJdYLjwqtq9w=;
        b=cAUgtEx4ntDSUsQB4dUYR3K1WwaKO81xrOp9+zi3FnQTbGisIz88O5kAt/bzXo4Gtc
         UsPPb81RAimsR18dgIQNLqM4sR0WmifV5yjR0ip7TmWdD0+4drV1M9FNgY4EUJY1sSpu
         S64CJoi/B7sehgSfiVp/uWC0A/aZDGlQJ4eowJ8nSnJSYzlIgezkU7Dkc0n9fO7Y5GVM
         sBJd9jhNZFprJ4tKELYKpj6qfAVsrIhDer/SXeQ4XQ0zJwOHrG4Go4rOz1+QlwRX+FWT
         pCpNnAOSN/YDd/ZWX/0KcSR7qnQW8n468BxBqg3rZvG9l0CrIRZwucS+/DgFa5ag3Z1P
         PA2Q==
X-Gm-Message-State: AAQBX9eRoKnmPn/5h1JF98pgZCyTbtTAfOCW/iaOulFFxBWn8o26nDXb
        BcSy+6PGs4Ipf0+rgJpBakO79A==
X-Google-Smtp-Source: AKy350amOHjUjQb6eTYUguPfSmAP3gfsK/1NPUdXOaF7IR/pmQBmYzo6N639ueSog1exZubhCY07aA==
X-Received: by 2002:a05:6a20:314a:b0:e3:7651:44d with SMTP id 10-20020a056a20314a00b000e37651044dmr8472067pzk.20.1680283223431;
        Fri, 31 Mar 2023 10:20:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 37-20020a631665000000b0050f6530959bsm1755926pgw.64.2023.03.31.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:20:23 -0700 (PDT)
Message-ID: <64271657.630a0220.88ca1.4780@mx.google.com>
Date:   Fri, 31 Mar 2023 10:20:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657
Subject: kselftest/fixes kselftest-lib: 5 runs,
 3 regressions (linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-lib: 5 runs, 3 regressions (linux-kselftest-fixes=
-6.3-rc5-1-gf1594bc67657)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.3-rc5-1-gf1594bc67657/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f1594bc676579133a3cd906d7d27733289edfb86 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/642704db139983168062f77b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/642704db13998316=
8062f77c
        failing since 94 days (last pass: linux-kselftest-fixes-6.1-rc3-3-g=
89c1017aac67, first fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/642706957be410d11d62f770

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest/gcc-10/lab-collab=
ora/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest/gcc-10/lab-collab=
ora/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/642706957be410d1=
1d62f771
        failing since 164 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64270594635ff1067462f78f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64270594635ff106=
7462f790
        failing since 163 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
