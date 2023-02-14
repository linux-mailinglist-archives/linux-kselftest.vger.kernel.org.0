Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C04695766
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 04:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjBNDYH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 22:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBNDYG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 22:24:06 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C3119F23
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 19:24:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e17so6837222plg.12
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 19:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dOux6dniQmhC8Kp6tahs4JFCEPNbUAYljsXqoTn8a8w=;
        b=wAvZ+HbjpKqtlgn4onNQ/LXzcXmDQwbGif54Z8V1cVjs7li5GGmbqXGBrD4lWo6Eyu
         Nye0M/5gegWhqkR2FYBrmvrnBjB3iatoi2Luveu7IkVL6Ge85YZq24M72JPgboM+AwA0
         aNXgclJg4TfPDVQrpD09sz0joHx0CVWH7KRpk+HcatXSz0G2KrO6RbEHrAHHJJyhnK1d
         vg1FpNxDCyLF1St4xHcDzZHQYHeg0D5O9HeqHnbNPWUGqtLQx1dIuKyjWmc7jcHoW0nU
         lGsAD0VPLF/uT6exvphyYbS83y4Sp40o4PCSEu2ZMUFY36Yp7sClXFguvQ+V6dkciagy
         xXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOux6dniQmhC8Kp6tahs4JFCEPNbUAYljsXqoTn8a8w=;
        b=WdlWUezeY+7t4tXF0DtsF3SqYGFfAfm9VJIbosjpD+W64nZBz2W7FS/llvJAPsPIhx
         2U7T7RwWkRzu0mbjI8fT59xxDbJCjMLcqsZ+QbNvr9ONyMBz7HQUxk7jZ6R+7zYKAPJH
         ZGEY2CkvT6bdZ57qk9iXQO76/oLXb4Ms+ud6Bv1CjYWWu4hjjdfPCIeoA9w5oLACODf5
         Scx6hX9u7EjD20dQNcAMVJqKn1RBKJynE/2GG/CypdvWph9aK0Muk62ufwx48Wj5sNOc
         AAPEasVa+muXqFHA4rH0qA4/BzKjK32wlRWSclezLj0HZk1Ge8xtykGKrH2jR5iabKwv
         CCUQ==
X-Gm-Message-State: AO0yUKViSQrVixmOgO5bvH8Nngp7pFGMj3saUVfxZ3egA3QaBl8kurra
        FQWK/eHVL4TYaDfn7ZWg2mkc8L0GZi1tAbjc
X-Google-Smtp-Source: AK7set9rlvFr9shcSJaJQVqO5NeT+BwE3qAujn1nhaAhOS+cCDbwmjj7iVK8nMehuq0MVmrGKPCczw==
X-Received: by 2002:a17:902:f682:b0:19a:9641:d1ef with SMTP id l2-20020a170902f68200b0019a9641d1efmr1281872plg.18.1676345043870;
        Mon, 13 Feb 2023 19:24:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p21-20020a170902ead500b0019a6d3851afsm7406244pld.141.2023.02.13.19.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 19:24:03 -0800 (PST)
Message-ID: <63eafed3.170a0220.184db.e93c@mx.google.com>
Date:   Mon, 13 Feb 2023 19:24:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-39-gaca5a0944c30
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 4 runs,
 3 regressions (v6.2-rc5-39-gaca5a0944c30)
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

kselftest/next kselftest-seccomp: 4 runs, 3 regressions (v6.2-rc5-39-gaca5a=
0944c30)

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
-rc5-39-gaca5a0944c30/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-39-gaca5a0944c30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      aca5a0944c309c56267b0c1d001aa999ddb2fb1e =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63eaeb59ffd557350f8c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63eaeb59ffd5=
57350f8c8631
        failing since 49 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63eaf19c6345625b4c8c8673

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63eaf19c6345=
625b4c8c8674
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63eaf0aa7c1608e3e28c8662

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63eaf0aa7c16=
08e3e28c8663
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
