Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAA27BF2F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 08:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442225AbjJJG1A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 02:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442235AbjJJG06 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 02:26:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765A39F
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Oct 2023 23:26:56 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690d2e13074so3945507b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Oct 2023 23:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696919216; x=1697524016; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bFJTEzZNB29nZjLm5BmoUnk8dgKUHsQaC23Tofecjiw=;
        b=gGudrYy+UdfhqACaBOkQb8SLwnDG/O5Ckh0RyR4QN/JLwQLAbjYr5hGZ1oLcMid/33
         BSklHV3LFZkRdlFqNjVlS+QSVXTNiKC2GKyDVxM4OnQtjqjga86DGuB5tjVDcBjwcZbo
         Apkt4+FyYBBtmWHZNmDeuRovJmTecd9XCHIZKbVWvZgpiiQfxmWifNIQ06l/MaEgOcG3
         hhKNSU9cJ6fSgnpFnJt9zb96To0XJqmfJXCspbbRLrb1xTtXMZiD9SKmNa0Xiz2PJ2QK
         Kr+NHoVzpuMAndRHxS0MzSad1jTjUy0hSJWtB1erjqbi5e6GmsfzPFaBB7EFBwgcFh3O
         3Pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696919216; x=1697524016;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFJTEzZNB29nZjLm5BmoUnk8dgKUHsQaC23Tofecjiw=;
        b=aKCryzT1PGHhrvFpyqbzF+XbqorCQMK7h4gVmEf4HGOIGDF20ms4pepCRcG13t0Y5D
         i0L5fEk/RAW8ut52hHdkGBB5ObTHaFPr1lNY6e2yVqKFO+raSt10c9bdtkOcDZQqrP+X
         ibHTD6xqNyXrmBApidrzSglPl/Dk1z5DJ++zokhWK+TI8D/rHWMTlWZjTPJw8cnJqwnO
         jG6u/eLLHuhf4lDZHuAgYID9cxLIS/cgUfQILRcbLppLqCUbjol5eyDOoAW7uLCcTuM+
         bDVa4ggG+Ec9noBsdeDPMx6MZq/wJZuhA9NwH7F03X7p5Fs1lQ7QyXvxe68w10Ci85WT
         6bww==
X-Gm-Message-State: AOJu0YzvJnjMLltUJT0RlvVVWuKOD4KZXNvC7cpQ4eM1/s8Egc+vdIOv
        k0k7V/cUaFhjUiop+7HwP3wVVvwwevjxNg+EdJVJPw==
X-Google-Smtp-Source: AGHT+IE+QNzvJMBfHqQEX8jGMmNDnryUNQqp7ZBsSP8g9vDndaax94GWUv6wFL8LhutV/85g7HKYOw==
X-Received: by 2002:a05:6a00:218a:b0:693:3e7d:cb4c with SMTP id h10-20020a056a00218a00b006933e7dcb4cmr15669945pfi.16.1696919215857;
        Mon, 09 Oct 2023 23:26:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x20-20020a62fb14000000b006889081281bsm7409181pfm.138.2023.10.09.23.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 23:26:54 -0700 (PDT)
Message-ID: <6524eeae.620a0220.ca241.2515@mx.google.com>
Date:   Mon, 09 Oct 2023 23:26:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-18-g2531f374f922e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 2 runs,
 2 regressions (v6.6-rc2-18-g2531f374f922e)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-lib: 2 runs, 2 regressions (v6.6-rc2-18-g2531f374f=
922e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-18-g2531f374f922e/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-18-g2531f374f922e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2531f374f922e77ba51f24d1aa6fa11c7f4c36b8 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6524e1f5d00dd397beefcf88

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-18-g25=
31f374f922e/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-18-g25=
31f374f922e/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6524e1f5d00dd397=
beefcf89
        failing since 357 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6524e54af7539cc9a9efcf22

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-18-g25=
31f374f922e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meso=
n-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-18-g25=
31f374f922e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meso=
n-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6524e54af7539cc9=
a9efcf23
        failing since 354 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =20
