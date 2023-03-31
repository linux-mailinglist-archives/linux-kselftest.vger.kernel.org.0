Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E2B6D2688
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 19:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjCaRU3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCaRU0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 13:20:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8371CB87
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 10:20:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id r7-20020a17090b050700b002404be7920aso22098295pjz.5
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680283225;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RdJH+fKHNxaa/t3gBEsC5D5G+73x7CCC1y3jp7fB+Ag=;
        b=k/q9gQaY3lv6FB41Jm63O/sIvuIgYZRUJPfW1mnjuI1GR08yJgD5m5I8QcC9VmcvRC
         WKHSO8IeSwYQXkN9y3g86coq+w32eWgHJs1Gm4vnWKRGUGLsHfHjlZVOFqHfqwnmPGpk
         3hPXBVXgr4sIagfjrnpxD4m9UXjYDNIHlM6LY2dsOMNXzpndA2kfKou06thgzOhVxRWX
         OBKddz9u9Fe6NUdysh0Bq0P2dtcrgD7GiTIxJ1jkWxwELBSkEXWagC7Bz7YGTODyRqa7
         7ZYBVOHc6YhxDZw0wa2LH7HsDsN9p0S0IeC5hOKvNPtVAwP1CIUcYP4CQvJkx2M2Nffp
         N2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680283225;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdJH+fKHNxaa/t3gBEsC5D5G+73x7CCC1y3jp7fB+Ag=;
        b=FbPPHOjS0fl2Tkm0jl7tbBRBisWqMs3BTMi334CTAyqWmGUM4qJdS+V06DqD+q+h64
         pkWsqKXX5ZAfPY9Ecv3n5q7dl99pomZcK60Lu86ou3kw8wU61ynyW+mbICRpinqOMb5y
         C0iHxXTKAZFvr+/ghIXoX0Da+FKmbwUIzi8w+I8n+RrMN1+YercS2WNVsR5NZZX3/G4J
         iCUBWyIMcAFA9D9pNWWHGPDBcZRNu1BjZ/B9I7DZJmRWNFbBXHyTXgqhgOOpibQXher8
         AKU7su9BqluKUfI4op+qtL37t0G8QDdhwOBUad7I9NDzhNz8FwX8KeQccrQ7piXEH6Jq
         RGuQ==
X-Gm-Message-State: AAQBX9fe4YuGp1rAe6Vv3pRjkJmYL/xf7t96rtk/U0ck/D+TZQ4qr6fv
        TRv+J95UbBIiTg+j6IN9YgS5YyeaL00P/MSLdvCZWw==
X-Google-Smtp-Source: AKy350ayRg5cNo8+fuC++/Y+wx3es+MC3mKMlt2wrYkqYqLnCpLBAffZEgWad/OHyVw/p+lj/UazMQ==
X-Received: by 2002:a05:6a20:dca5:b0:e3:8710:6846 with SMTP id ky37-20020a056a20dca500b000e387106846mr6592406pzb.10.1680283224860;
        Fri, 31 Mar 2023 10:20:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p19-20020a63fe13000000b004fadb547d0csm1813628pgh.61.2023.03.31.10.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:20:24 -0700 (PDT)
Message-ID: <64271658.630a0220.cc136.4356@mx.google.com>
Date:   Fri, 31 Mar 2023 10:20:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657
Subject: kselftest/fixes kselftest-seccomp: 4 runs,
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

kselftest/fixes kselftest-seccomp: 4 runs, 3 regressions (linux-kselftest-f=
ixes-6.3-rc5-1-gf1594bc67657)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.3-rc5-1-gf1594bc67657/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
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


  Details:     https://kernelci.org/test/plan/id/642704d1005b5f6e0562f776

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-seccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-seccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/642704d1005b=
5f6e0562f777
        failing since 94 days (last pass: linux-kselftest-fixes-6.1-rc3-3-g=
89c1017aac67, first fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64270559727e91640c62f789

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64270559727e=
91640c62f78a
        failing since 163 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64270553e41d0a343e62f780

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.t=
xt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64270553e41d=
0a343e62f781
        failing since 163 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
