Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3172969552D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 01:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBNAHC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 19:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBNAHB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 19:07:01 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DB61A668
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 16:06:57 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v23so15332448plo.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 16:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fsy1zu40JEslq0rYE1uFk3acuPSCia3XFRsOr5eDdGA=;
        b=fDIKngNbjforqQBHUEizmTgnIlpP2lcFCcYuCe/EIA0a569XYfZO7yjmm8q1NVTpc2
         NmLqJKmxALQ8qZnykWw/tP+oOQX2RbMlBfT4ScNwrGPslTkBZGmGkrfkdeEQ+rG3NoBT
         82tJTn9tXX1hBo0wKlv3TvbOonpRA82M1CEjmtke+vZ+eDC1husmxl/qXSMO0Xus+CzL
         6CUneeP4kZI/guQGo3J+bSDB6SBKeKKiipSvmSP39N+41PJWYe1ozCkju1vKoi/MmFzS
         hcXNeuQp2Jr0Zrb90I8YUvZOPtE0kLHhPZcafYQqaP2NAwxZ+/UCdQyTlkRHEmg6S6XY
         C0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fsy1zu40JEslq0rYE1uFk3acuPSCia3XFRsOr5eDdGA=;
        b=IC1daiAPmfFsLtw37J+QxdHPmpAaWC8nYBjMCEJbrUd9PxR00GVqEkfgA+ho3Lo3Pu
         OLcCGg5U0c3tkFMQi+eTvLswhsAg/rERtdRLiicO9sZB76fpD8nbWMIBFBaCrwnT/PlW
         Ui5Y8MBn7r+b1GoYP2Pa5d/cPMbQo9yokBD60LN8ZWixcYQ1mJEYiYvA/7lOj4KSWp/q
         aaYd/7+6/MWvZR6EgBPBeVvSz5bOC8xlD0YtfdD2qUn3vOxHQzt1N40cH943NIKRX3Wk
         wMCuTJnDMKhbUYq30NXRHcfvbv+bxzJ2FSVscV1ANNN2CwuvNKSKUhS9K79fgfbuB63T
         lgvA==
X-Gm-Message-State: AO0yUKXRVzk5Z+jQpLdBnnPVA4XK1cgQQfJ/xY+2SMdlA1vI9BY6FzlR
        o+fIoxFMZ/q3ualJ4g5P6eOjtw==
X-Google-Smtp-Source: AK7set8fJryxNkogAeKMFhXoQa61Hobt07v1G6bm5RDVFcKSL58JZe7DV1YlDVEh5wSrWW6pRsolYA==
X-Received: by 2002:a17:902:e881:b0:199:4d25:6a4d with SMTP id w1-20020a170902e88100b001994d256a4dmr18923210plg.10.1676333216645;
        Mon, 13 Feb 2023 16:06:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b0019a82ff8c38sm5008889plb.29.2023.02.13.16.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 16:06:56 -0800 (PST)
Message-ID: <63ead0a0.170a0220.47566.8a50@mx.google.com>
Date:   Mon, 13 Feb 2023 16:06:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-36-g6e81461b06b6
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 4 runs,
 3 regressions (v6.2-rc5-36-g6e81461b06b6)
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

kselftest/next kselftest-lkdtm: 4 runs, 3 regressions (v6.2-rc5-36-g6e81461=
b06b6)

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
-rc5-36-g6e81461b06b6/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-36-g6e81461b06b6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6e81461b06b6a4a24bf97fca37d9b89f72ce8126 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63eabad75323050c128c866c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63eabad7532305=
0c128c866d
        failing since 75 days (last pass: v6.1-rc1-23-g00dd59519141, first =
fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63eac15a8d3bbc994f8c865d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63eac15a8d3bbc=
994f8c865e
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63eac2b32cea262a488c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63eac2b32cea26=
2a488c8630
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
