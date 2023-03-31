Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C306D2686
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 19:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjCaRU1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjCaRU0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 13:20:26 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473681C1F3
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 10:20:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id le6so21859263plb.12
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680283223;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HeiRDoN3STbRXq5fts+Arn4EaZ4XqxfBabJcJ8J+Eus=;
        b=FRo4XATieVgToLX1Myk3x86zgHQD+hFic7VH0/7VtKLImax4A7i00f29qMFYbPNX9a
         XNLBwk07PIhtNDwh9HL2FmCOK0FZm5XR5aYx0/I8SNUDylzpTDBXIj4nsLU/KZxdG7j6
         gw/n2HsTdNP2pzP32mDmNgE9wQ/z+TUqo4QcieKbS0nUbaVs0NJlXWi9G6CQ/20lNQEX
         mwAJ9NEih7tn4VdpAKU3y4TvyBDcqlvAeHjiXbXaPymE+mAR8LrWWHpsCtUXnr2OhWvA
         8T1oBvBaRqlOAqZo6sPhV4bNowFMdFUOI6tacZnt8F2LcQuH3ONblK9Z6uI9JmHM4B1H
         BR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680283223;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeiRDoN3STbRXq5fts+Arn4EaZ4XqxfBabJcJ8J+Eus=;
        b=mVt1vZVtt78pjmhrzf1x0o4eYRRRYOHjVLcPZp0ek5LAxgNCsMBrRWScolm+9ZSeg3
         Re9B9H2530RaRN54FFjm7Tmt76aJMFRLC5rGK0YV5hXCkZ3ZCQTIuiyMtPRM+eg/VPiI
         UtZc0oICng/ft7xR5QKNxrVYNs9NLRG0mifwoxIgp6KMs4E40xckN8Yi/Giowg29IDYe
         +pUdutErc99/SU11mCjO8sjD84DUv2KfgMOzPc2rCqXn6g0EovqT246CnTRpVma6jmVY
         mK0adAy/hqxrYqBex7hip7tpxzXcs7Nd2CQlJDZ4twWDcEPPzAlqzrRlsIID4/mzHYeW
         TPDQ==
X-Gm-Message-State: AAQBX9cgg9sIlu+z7ge2YuTK3SuYOW6CUodqTEbIiTWKcOFEUnpmY8Gl
        RyGDFbCCDyblLfabmtSk6I+fdSUO/GNH/tpEMUnvkg==
X-Google-Smtp-Source: AKy350ZZsFKL35u5JpsHNaxFlH1pD+rqyQXu2FI/awjZGhlIjuqscBe1oPF0et23SRyfsFe4rUZbPA==
X-Received: by 2002:a17:903:27ce:b0:19c:da7f:a234 with SMTP id km14-20020a17090327ce00b0019cda7fa234mr22379954plb.67.1680283223665;
        Fri, 31 Mar 2023 10:20:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id az6-20020a170902a58600b001a1deff606fsm1818457plb.125.2023.03.31.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:20:23 -0700 (PDT)
Message-ID: <64271657.170a0220.7908b.49a6@mx.google.com>
Date:   Fri, 31 Mar 2023 10:20:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657
Subject: kselftest/fixes kselftest-livepatch: 2 runs,
 2 regressions (linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657)
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

kselftest/fixes kselftest-livepatch: 2 runs, 2 regressions (linux-kselftest=
-fixes-6.3-rc5-1-gf1594bc67657)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.3-rc5-1-gf1594bc67657/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f1594bc676579133a3cd906d7d27733289edfb86 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/642705f81a899df4c262f7a8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/642705f81a=
899df4c262f7a9
        failing since 94 days (last pass: linux-kselftest-fixes-6.1-rc3-3-g=
89c1017aac67, first fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64270551e41d0a343e62f77d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/64270551e4=
1d0a343e62f77e
        failing since 163 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
