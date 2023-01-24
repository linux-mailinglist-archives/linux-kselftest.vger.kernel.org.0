Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449E8679354
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 09:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjAXIoU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 03:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjAXIoT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 03:44:19 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC83D36FCA
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 00:44:18 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso8993891pjp.3
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 00:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=68K2nbojVHJwc7RemhFhsqKb1mS700EUotXvItKo92Q=;
        b=sf+WvmzcyqbDvTRYJCPjiRAm+sWSZkBpZoyqXkSwmZP/tSYn9rWVnxOj3GVZ2S3M9s
         asiQrRMU2oK0VDAvgh/BGgkHV7b6bFeKf5NNhtct4gF3qDbmuDMZprW/cW2DdfWf9qTf
         5rRZgASZ22VTELkyTN8dkMCiE2JA2OFi9v6zZ8ORAsI9efFO89FYfpoiqdAfqJtpdkql
         r545nXGgjANM2TvadrIULdyUksdKybzwDC85OEL+Aisd2FON83KLCKQXHwiTd4BWPtzy
         RvDM8fQH8qMaMZBib4n28SQrrjmg/V9mQe0JmlvdqRM1G+M08T/YBRZpi2dP822qJN5E
         zYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68K2nbojVHJwc7RemhFhsqKb1mS700EUotXvItKo92Q=;
        b=N+XFwFGhA6obm5s748nrtIj1uvkYunnjsL/qI9rpwEb67vi7ajWuMny4D1F8l5TQuM
         ++Vaxt53NZA0mW+D9YzOgx+HwPphnEFGZ2gvQGZJuvJ7YcknVdtMEmr4OUI787DEaXft
         dnZz4FWaDOb1LUKhjbcagKKmo/25LJ/GT9usJ2N1h17NeuFj8jGP62+dWhWAvwlKFs3K
         3cRToaqmEy2qI3MbROHgyVl6pTi0AETfBzMatWCvR0dUPalGhqaxWZrrTbbDCDyYPSsq
         kapvriqin7sRGhfKfNuDvGdqhM62mQr1vn5A0x5M+xnhdmv2TqgPUHGO2JBSPRqGwagB
         OPTg==
X-Gm-Message-State: AFqh2kr7OxZlwESXbwxuIN7Zm0QkDSJId1tIe92WL+MfXLfsCaVtjELg
        VTADLYpeX97p16VnaVV8mMASZWHbwYtEdBgBxEA=
X-Google-Smtp-Source: AMrXdXus4TlbwDo8E8YA2Lu9NJmtMRTuznugkzv7lGDbI/VworekL+LYDdID72pJ69ngSQgnaKZphQ==
X-Received: by 2002:a17:90b:48d0:b0:226:d7e8:e11f with SMTP id li16-20020a17090b48d000b00226d7e8e11fmr29587200pjb.12.1674549858306;
        Tue, 24 Jan 2023 00:44:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p23-20020a17090a0e5700b002271b43e528sm7516706pja.33.2023.01.24.00.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 00:44:18 -0800 (PST)
Message-ID: <63cf9a62.170a0220.67db7.ab6e@mx.google.com>
Date:   Tue, 24 Jan 2023 00:44:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 6 runs, 5 regressions (v6.2-rc5)
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

kselftest/next kselftest-lib: 6 runs, 5 regressions (v6.2-rc5)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2241ab53cbb5cdb08a6b2d4688feb13971058f65 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf9132fbd358e4f6915f7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-imx6q-sabreli=
te.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-imx6q-sabreli=
te.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63cf9132fbd358e4=
f6915f7e
        failing since 28 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf8ca9a5c10e6509915ec0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khad=
as-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khad=
as-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63cf8ca9a5c10e65=
09915ec1
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf8b866eabb39bee915ef1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meson-g12b-a311d-kha=
das-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meson-g12b-a311d-kha=
das-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63cf8b866eabb39b=
ee915ef2
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf8da5f47a76e242915ee1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lib-m=
t8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lib-m=
t8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63cf8da5f47a76e2=
42915ee2
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf88b85b1a6f1e44915f38

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lib-mt8=
173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lib-mt8=
173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63cf88b85b1a6f1e=
44915f39
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
