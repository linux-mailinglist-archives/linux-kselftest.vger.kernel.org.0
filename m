Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD9E6E15BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDMUW3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 16:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjDMUW1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 16:22:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D249029
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 13:22:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m18so16158230plx.5
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 13:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681417342; x=1684009342;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=si7UUYa+oKNFi/OhuX1zGGUor4OoGkmMSwbNKtvIQkw=;
        b=Kw4SfWMjhmR1bzfF+lQRbYCEf+NvAhps4bnv6cOzPJ6//QCXxPHKvdDCOSoSFCm+hX
         3mJ/moiAkm4R8W/1719n0G5JJ8uhdD4qpKJdrur5I9kWwIvmBqISRK6E/EncwbEnzZbU
         HDuHezBpAgeSnsNpzfUza+tA8ZkNiwurjrfbIDjjk9KIMQ02V/1JEMjKFgMNrWwxlXc7
         A0/rE4ML0IEDEa9LiYNU23ewssT1K5WjIVr8VWLvI0Rp9bNWyy5R4WAtRhew6+Lzds3w
         sVtsvT0RYX/A4QTg6Dy1J/wYPnuN0yhMrgSQPCiVSXq37kQ/G7w2+hC8a+k0f+k783uh
         MJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681417342; x=1684009342;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=si7UUYa+oKNFi/OhuX1zGGUor4OoGkmMSwbNKtvIQkw=;
        b=YEMHDEo14xF7yeJ9DH/d476zJomElqkXm5oPHkHXKaIb1belo625nFGcw+Da/rO6vv
         YHPV2wKX+7kuYSWhF2y1+g+d5wLP0iLQqz6ixIKdVmsZzAdFv2tAwuvL2Ro4JNuFreuq
         8c4LC5L0Rusi9bFXYIOw3SSZmg+FpwFbAvzpLYBuzA1xYKGW2ZDrnPZYKJ1saFH+QuOw
         bmy2rbWDVEeIfXYENpH6I+r0HWM3E7kdMlSFwmbHwb3CeIsDEdX+vYWOjVkGS4enlVVq
         5KB+/mYHod0hKiZEt7tKw8LTwz7DofnaTPp3NlcEskKBkhh1q/eSiCO6qCBPVUGSQGxT
         ABfQ==
X-Gm-Message-State: AAQBX9cWGORJqzOaamVzwAj3W/2whrodkXgcB8XwLlQsHmHhGcsRhZ9P
        MJ8fdFrnSPasG837qkzh7FrQwIFYovrnN+UidwhdIa8x
X-Google-Smtp-Source: AKy350ZGkSZlbVFhOO75eSf79z/X4fGTncpgjEMcI9ApCDoBgqiHiECg0q05ahDzYDDCNFZJlgxwSQ==
X-Received: by 2002:a17:90a:fa94:b0:247:2b5e:ab52 with SMTP id cu20-20020a17090afa9400b002472b5eab52mr1591860pjb.31.1681417342110;
        Thu, 13 Apr 2023 13:22:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090abf9500b002470ce35621sm1707546pjs.20.2023.04.13.13.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 13:22:21 -0700 (PDT)
Message-ID: <6438647d.170a0220.3b86c.416e@mx.google.com>
Date:   Thu, 13 Apr 2023 13:22:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-24-g91db4fd9019a
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 5 runs,
 3 regressions (v6.3-rc1-24-g91db4fd9019a)
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

kselftest/next kselftest-lib: 5 runs, 3 regressions (v6.3-rc1-24-g91db4fd90=
19a)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-24-g91db4fd9019a/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-24-g91db4fd9019a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      91db4fd9019a08251a500157cf0d88de457e1a96 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64385725e4d28f71722e8665

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64385725e4d28f71=
722e8666
        failing since 107 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6438560fce73cfd42f2e85ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6438560fce73cfd4=
2f2e85ee
        failing since 177 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/643857de802f1b66b02e860f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/643857de802f1b66=
b02e8610
        failing since 177 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
