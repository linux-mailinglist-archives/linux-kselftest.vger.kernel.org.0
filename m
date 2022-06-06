Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB31E53F15E
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jun 2022 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiFFVGy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jun 2022 17:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiFFVGt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jun 2022 17:06:49 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3D78E1B3
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jun 2022 14:00:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 187so13676088pfu.9
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jun 2022 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=S4mJAux2OovuhjKc4ql68B8/tohBM2TtrXI8bMTV/OU=;
        b=dlpFbIDDc5GDS6Zm5AMhf28DD3XVKOUnRFv2ndx8lHPH1Y46Cdt/4RzjUXZPvJpdzD
         vXinqbcDrxITWfpIabrXexFK+AW/8VonCHs2j9M2RoshodEHuvgyonqYizLKHC+0qS3h
         FU1FhaNHB9w1G8ny7NIorUnLt+KCe9RRYBYlKgljolv1i1Bd4omnTXyF3s6Y+SAvK1WA
         LSDfgXyxAnv/hGIMc7w/IFWBQJk8GN9+YWCCUOv+JRTE22yfI+E04s8N7c3KtCULxeFK
         WyeOV39THVOSuIuLUgheUKVwKvNI28Vws93//tXiCthi+GocZ3qnD+oBdce32Uvb8bJA
         dx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=S4mJAux2OovuhjKc4ql68B8/tohBM2TtrXI8bMTV/OU=;
        b=nqI9785HrLoQM3mTxD93E+QiLHGCknXDBko0tkPlTvBMUg5RqDOB5Llwcr9U3lSYSN
         T0vCHfPX40NbU2nkyMnw6WCrLf+ukjofEuvcBN6iHv+FWOhGoS0QdgjK2qqwPLuRTlLJ
         2c7rB56+yfgIWzhceSNSyd7GtJRlsrcwkMavil1OgD1Vh/H87M7EOa0zA9hMDavNVsTE
         pteG8Ukq3YV/oKSTp5afngoHTVHksqGceNjnAcNf5m9KW6JyBlHrl8J4fgAa8HhWHO5M
         3rSCwgIbkD08SWZ2BJUBR5j5b8K1o272JKpcX6nmKfAdLFgnXaeMdeaum5C31fpeLX1r
         /ULw==
X-Gm-Message-State: AOAM531r9+Evp3sHukl+npp+NWVnXGJ3zl/H2Ac294OAy96Kxrpa+kMe
        gE2yaX3TAg96m8udapOw+IzMXg==
X-Google-Smtp-Source: ABdhPJwJ5NcxlaXCg6n89YMnokM44lY0HXBZ/slgvpo56T9D1bjKsUi9p92GPg/rKRp7hev3P3QA8g==
X-Received: by 2002:a05:6a00:ad0:b0:50a:51b3:1e3d with SMTP id c16-20020a056a000ad000b0050a51b31e3dmr26330806pfl.18.1654549238794;
        Mon, 06 Jun 2022 14:00:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902e9d300b001641670d1adsm10907331plk.131.2022.06.06.14.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:00:37 -0700 (PDT)
Message-ID: <629e6af5.1c69fb81.f0189.8807@mx.google.com>
Date:   Mon, 06 Jun 2022 14:00:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc1
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 4 runs, 2 regressions (v5.19-rc1)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-cpufreq: 4 runs, 2 regressions (v5.19-rc1)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | clang-14 | defconfig+=
kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
9-rc1/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v5.19-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f2906aa863381afb0015a9eb7fefad885d4e5a56 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | clang-14 | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/629e5e79660022567ea39bf5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-14 (Debian clang version 14.0.5-++20220603023205+576e5=
b39ae4d-1~exp1~20220603143239.145)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.19-rc1/arm64=
/defconfig+kselftest/clang-14/lab-baylibre/kselftest-cpufreq-meson-gxl-s905=
x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.19-rc1/arm64=
/defconfig+kselftest/clang-14/lab-baylibre/kselftest-cpufreq-meson-gxl-s905=
x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220603.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/629e5e796600=
22567ea39bf6
        new failure (last pass: v5.18-rc3-19-g15477b31db104) =

 =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/629e59c837d80f0071a39bec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.19-rc1/arm64=
/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-cpufreq-meson-gxl-s905x-=
libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.19-rc1/arm64=
/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-cpufreq-meson-gxl-s905x-=
libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220603.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/629e59c837d8=
0f0071a39bed
        new failure (last pass: v5.18-rc3-19-g15477b31db104) =

 =20
