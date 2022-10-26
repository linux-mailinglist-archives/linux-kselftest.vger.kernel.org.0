Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB3F60DB7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 08:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJZGmK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 02:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiJZGmI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 02:42:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBEFA834C
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 23:42:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m2so9169326pjr.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 23:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ffbhltUH38fgTQ+O7p8mcY4XJluymEHA0jGG6IZt+NQ=;
        b=fGR+Jigecs37udTJLcJ1MTNCCFt6e+AcSs5bpv3DQPBmxP4i1rfFA5Ii9KcDR6TNP6
         5vMXtbAgOR6IdkYsE1HsV9IIywT9r1yoOvC3kJx6f9SjWZv1KP/zRUOWgtEfteaROxza
         vpeUWfS0OoNaYNGqogaN5BxwqSlruamDjr+JBsVwQd6LSX8qCKLZ+ZQkHzX5389xTZ7f
         zVikMzdP1o1KQDqHs+ERa3Nyc4nltZ40IQVfbW83erwv4Ip9+/BaeBkcO+ME1CbBZimV
         0ueQ68J7trrLXTyQPSDf89Njmwpkl1FoJ9eI8V63z5JDkYneh6MJA3LS39GxlQ+Y9Xjg
         OUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffbhltUH38fgTQ+O7p8mcY4XJluymEHA0jGG6IZt+NQ=;
        b=0F0wv0GlW/P+LSGhw1CVTUVWCk7mudCgh9wks/tDkJJDDE/BCEGfyh8hgbPnn6U13q
         4NwTemLGqydMMc66bYBIph+UpdZqLpsB3FHbSLnFib8giRJa/uJKXIXGEB5lhni4UWVy
         tmwEXNuiHDJfL+P6OgyfJMIWMY9FgHL09UKBdZcg2v9q4R8KUx9lIwqEV05GupZSPRm3
         h4h2W2dCCnlLxgVM3czs+S01T9CXRyi5fj08fFXae6kI1VcZa6hv+8VV6c8ASK7YmPUW
         MEPqTTIRIT4J9OHEHy2rHgjOE0LPfcDA1llMbQGiFweqRt3+OqTRRK10NqTUUjOX2C1K
         W5tw==
X-Gm-Message-State: ACrzQf2CVYVfrJhDFnh90x2qoBjUqvEW4hfUQixehZ9xXpF4Mv5zOLm8
        YiQmLkGKDcTgDpNwcRpo7kUTDS0lWQMwGrY/
X-Google-Smtp-Source: AMsMyM78TU44MJSkGwbzo0PE25pljDTcnphGGPTaLrIGgAHd62/WQ8CaV8UA1muapbYj8og6oixGJA==
X-Received: by 2002:a17:90a:4888:b0:203:6d42:ccae with SMTP id b8-20020a17090a488800b002036d42ccaemr2562329pjh.166.1666766526823;
        Tue, 25 Oct 2022 23:42:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id mz17-20020a17090b379100b001ef81574355sm578555pjb.12.2022.10.25.23.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 23:42:06 -0700 (PDT)
Message-ID: <6358d6be.170a0220.20c53.13ca@mx.google.com>
Date:   Tue, 25 Oct 2022 23:42:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-5-gec7b4511185b
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 7 runs,
 5 regressions (v6.1-rc1-5-gec7b4511185b)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-lib: 7 runs, 5 regressions (v6.1-rc1-5-gec7b451118=
5b)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | clang-15 | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-5-gec7b4511185b/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-5-gec7b4511185b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ec7b4511185bba95fc702c33a388582c8842d454 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | clang-15 | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6358cca9f196096ce05e5b3f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-15 (Debian clang version 15.0.2-++20221003113153+5f620=
d003fda-1~exp1~20221003113249.70)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest/clang-15/lab-baylibre/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest/clang-15/lab-baylibre/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6358cca9f196096c=
e05e5b40
        failing since 8 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6358c6a8ffb9c4124d5e5b3c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-15 (Debian clang version 15.0.2-++20221003113153+5f620=
d003fda-1~exp1~20221003113249.70)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6358c6a8ffb9c412=
4d5e5b3d
        failing since 8 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6358ccbcf196096ce05e5bb7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson=
-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson=
-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6358ccbcf196096c=
e05e5bb8
        failing since 8 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6358c58b4cf45c92e35e5b49

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6358c58b4cf45c92=
e35e5b4a
        failing since 8 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6358cb6bbf48e7cbbd5e5b68

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6358cb6bbf48e7cb=
bd5e5b69
        failing since 8 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =20
