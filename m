Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2C8629BE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 15:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiKOOVC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 09:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbiKOOUx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 09:20:53 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C896D2C11D
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 06:20:47 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z26so14248457pff.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 06:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pam0otcRkFn0QHPY7cXn1KcpZPtfEjSoyYOaHErsrw0=;
        b=CuTQ41kRy4LAnUu5wggkk1hDsw2Msm5mqmCH4pnFVWwWg7fHpRqUKZnr3Cma6AtAbi
         g4CI4dHK6ycGgt+G+f6mbMfRghFtz/78bqZwMv+0ggCuyyXu3re7BxpBZMqQKBzNpNRR
         QK+GTZWzHYoNM6v3mUA2cnmnR1wPonkQwss4iKERiTyjOHP7xteqp67VcDJpGMdwucOs
         TIgNqlveSirghxu4eaOiM0XTtbo52DSM87yW2IkMWRtxOGHLVDsJ6T4vkLC2qq5IV+3t
         kGuHJ9DF1UDvrqO3PqMqMXqHzVVPBNT6L6MhrMIL+NBpmNqnO3lKMJr1Npq11+aXmSpH
         adBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pam0otcRkFn0QHPY7cXn1KcpZPtfEjSoyYOaHErsrw0=;
        b=gIEuSvBo+7D0eb5VPWxQ7Ii9qoxxvnlIZcVFGGOfdRHn+QGKeDntb3GYSekvRWZgai
         G7hvdT169Ka76cSfnsJJZa4e4P6AUXOLdGt6VjU9rq5g7Hj5ybgRX7z/mF0E386uj8HS
         52jo4ZmQCe3xC9jDckp68d66716B/8uAvSxY4jO1o7D9a02EaOM1kwfpO1yZX69KVblf
         PfwzRkPtpnumhJEJoAONrQVS/lk2y7PW2rOxVXesZCzptjaJ35Px5iQ1blesQVK/XIGP
         TyF0r0qMGXkot3rt/3lv+eXO9ny/Tf30Q2lJ05YRCOLRXVnFua+qeEuM6hEr0Zj8NNOB
         Wl+g==
X-Gm-Message-State: ANoB5plAF5hxI8EFX3BiNiW94V6pdlue6lF4y8/J09CKxKXar1HTeivC
        PSvqRhX/g0l2GMh/SiEByxBwEQ==
X-Google-Smtp-Source: AA0mqf5dDwys+LKC/ZbhFqw4yHPZuLPNEIc9DJ7TIuVRPvVI1B8btJELs/jqiQQcGmW02suT+qJ4yQ==
X-Received: by 2002:aa7:9706:0:b0:56b:9bf4:c1c4 with SMTP id a6-20020aa79706000000b0056b9bf4c1c4mr18823843pfg.67.1668522047267;
        Tue, 15 Nov 2022 06:20:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b00183e2a96414sm9919174plg.121.2022.11.15.06.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:20:46 -0800 (PST)
Message-ID: <6373a03e.170a0220.65c59.ee7c@mx.google.com>
Date:   Tue, 15 Nov 2022 06:20:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-15-ga1d6cd88c897
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 5 runs,
 4 regressions (v6.1-rc1-15-ga1d6cd88c897)
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

kselftest/next kselftest-lib: 5 runs, 4 regressions (v6.1-rc1-15-ga1d6cd88c=
897)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-15-ga1d6cd88c897/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-15-ga1d6cd88c897
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a1d6cd88c8973cfb08ee85722488b1d6d5d16327 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6373921e56e3c0ae7de7db51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-m=
eson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-m=
eson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6373921f56e3c0ae=
7de7db52
        failing since 28 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/637394db939cc70d90e7db8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/637394db939cc70d=
90e7db8e
        failing since 28 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63739262ed380c2f76e7db60

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63739262ed380c2f=
76e7db61
        failing since 28 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63739353f5e20c2adfe7db58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63739353f5e20c2a=
dfe7db59
        failing since 28 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
