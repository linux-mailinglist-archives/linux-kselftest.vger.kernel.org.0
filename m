Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C130660672B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Oct 2022 19:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJTRjn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 13:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJTRjm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 13:39:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6419328E3F
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 10:39:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 78so143608pgb.13
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ywEJWG6P6/VEwGNCc4DHuHQ4VJE8udZuu3tqL18XA+U=;
        b=IjxQu5xefL5bdYzly9SMCKCMSfmsnPnVc16CJkl0iADjc/qf7EQyDxOXcYMJM8qr1+
         oBvTiPNxY7wSj6kx1nKxHEg8d/RtcnN7Fl1oBF02EY9h9/A+diI0s790w+W9x+dcggjH
         L6mFvbTqjgVRr8qdERt8bxIRH1Nq2/oszYl9z+6lw5H0qh0LsGeu0hAPz/7/A52gBVPN
         C7wGELAQ3VBZl4nqH7ClUsGJK88vDnMkum3XyjAce6f0G4Pw5Kn4Z2oNydB0vIkI/5Pt
         Z5HPmTKne/gRZkDREHLLVcYFFsYm96+9X99BXmZ6J87uGCugUhJgV4DYk+14iMD6Y/K5
         S6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywEJWG6P6/VEwGNCc4DHuHQ4VJE8udZuu3tqL18XA+U=;
        b=2nQcRH3CCr2ZgLHKOLkJ/omiH/ok+ezzIApojTsFsKGaqBrR0ilaGGZznswUw4fKVy
         JlmawLPYFprQAOYbuVSAx6uGR3ZBC3A8sDTD5ZLykvhBWOu4Sb1j//QrWuHhiTnZXTVg
         V46belsi5ooYNmkUMUEas5dhOsF89bgn9Tv3rhex1IkHEpIVfe8pV3lhypuFJHc+NxVX
         0EQKIwepNS6JStLEdKz0A00Nu8hxzDSCfmJpMo6jZPNGCKsQUGoYGdypyyTb7ZrIDtYY
         ZjlPaHDmukH/qFqg9bQkCOFh0z/edoIShbL+mZM3FIy7V/PhiBltzcxE99eI8H72t9aW
         QHvw==
X-Gm-Message-State: ACrzQf2oXtKqYhKzk/nXRlsU8G91rHxiXqviN5FezJbbClUxjzKAgr1D
        +Z7B+qNC0jA1Vkb4MG62pZO+BA==
X-Google-Smtp-Source: AMsMyM5ITknCeBV/y1KsfKbaMbEWUzuway7iQoPh7aztuYqKdAPAVO+gpABNbAi7A9pVQ5UjdwzGDA==
X-Received: by 2002:a65:694b:0:b0:43b:f03d:32b0 with SMTP id w11-20020a65694b000000b0043bf03d32b0mr12412617pgq.543.1666287575670;
        Thu, 20 Oct 2022 10:39:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k5-20020aa79985000000b0054223a0185asm13513996pfh.161.2022.10.20.10.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:39:35 -0700 (PDT)
Message-ID: <635187d7.a70a0220.2c554.93a5@mx.google.com>
Date:   Thu, 20 Oct 2022 10:39:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-1-gde3ee3f63400a
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 4 runs,
 4 regressions (v6.1-rc1-1-gde3ee3f63400a)
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

kselftest/next kselftest-cpufreq: 4 runs, 4 regressions (v6.1-rc1-1-gde3ee3=
f63400a)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-1-gde3ee3f63400a/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-1-gde3ee3f63400a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      de3ee3f63400a23954e7c1ad1cb8c20f29ab6fe3 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63517ea839c48a5cbb5e5b4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-cpufreq-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-cpufreq-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63517ea839c4=
8a5cbb5e5b4f
        new failure (last pass: linux-kselftest-next-6.0-rc2-11-g144eeb2fc7=
61) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63517dcfe7872fc2b25e5b46

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63517dcfe787=
2fc2b25e5b47
        new failure (last pass: linux-kselftest-next-6.0-rc2-11-g144eeb2fc7=
61) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63517da9a851b3daeb5e5b3f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.2-++20221003113153+5f620=
d003fda-1~exp1~20221003113249.70)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63517da9a851=
b3daeb5e5b40
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6351766a14032ae99d5e5b4b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6351766a1403=
2ae99d5e5b4c
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =20
