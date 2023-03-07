Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F306AF181
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 19:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjCGSpK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 13:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjCGSoa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 13:44:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9993A9DC4
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 10:34:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso17449281pjb.2
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 10:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678213967;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GvjtwD188p5ft+MbweP8624EdFjCyp+eHirJ35cOe90=;
        b=uWdch2dc2JFzd8w8cip+G8lK/3CGH7z+u9ItUu1bAkwiKD/QLXmWYQQFJNwGfzkjPk
         cwyCb1aGuluBI4MDfkNKABrQkRtvKBvmBbAkzIFq7BC1depFwCqSym0W2pRQEiA+AoqJ
         0YORaytnI7DO/eHS5ag8XE0O6fQ+GJZqT83fDGTZlp6P/GDTrMzjgHOdWw0CwrzEGnx8
         k5u5/jr8B3tW9jSqckCtfePVqS+WZl2uPeNOL6XIpBNCxCnyp4T3IYKK2IPVCxUOAsPX
         QrB+IP8glXLJvPmQDh6cNxnV3H2rr0ybSbOBJQ2AQNkfl/uxrz9iKwRmJsRuDCKpdt+g
         iC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678213967;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvjtwD188p5ft+MbweP8624EdFjCyp+eHirJ35cOe90=;
        b=cKeMOGB4xx0msmHVUb+2bY79epebzMy+wnG50acJjFh2gXR/f5dJSsvNdPotcKcvWp
         Yd7vFE6yOdpe/SXd7+NUwUgxKMudnUFOlUUcrwZOQiRSi4fsw3NxHUgE5OjydV7diLST
         C/+qPbzJ2hple2nPd0mrQZxj0QXdZS38mikf7zdRputLIGUkSOCgdLj1I2D8EbbiD1y0
         QIMi+hBbKuNI9ms1HqicDS+3TOp7X8HUJlsuOScVohn9TnDzVvIwrSBwtdTiVpV/iym7
         vV/m+7BX9v8h7kVMu3nuKgmxqeftOtLy/nIUCHF2qm1940xhisV0UyHDNqsQunaVPHbo
         QrUQ==
X-Gm-Message-State: AO0yUKXrzADDIuJzUmuU1HYPJHTmuQ6tM1XOlv5v5Ftv6AoIu/JIb2pr
        /4jnb9rtAtF7FtRiH1FM1zWCcdoVPWFP/MLnh5PfOb1T
X-Google-Smtp-Source: AK7set9+k8Gym6iEXs0tPMZTIynsxTiVLDGpbxwWpbfh0s/WkUjmPfeO1YNzhcu5gHPh8u3r6cg9Ow==
X-Received: by 2002:a17:902:ce89:b0:19e:6cb9:4c8f with SMTP id f9-20020a170902ce8900b0019e6cb94c8fmr19006112plg.41.1678213967479;
        Tue, 07 Mar 2023 10:32:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o20-20020a63e354000000b00502e20b4777sm8118471pgj.9.2023.03.07.10.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:32:47 -0800 (PST)
Message-ID: <6407834f.630a0220.5fd36.e656@mx.google.com>
Date:   Tue, 07 Mar 2023 10:32:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-1-ge1e17d7debf4
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 4 runs,
 3 regressions (v6.3-rc1-1-ge1e17d7debf4)
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

kselftest/next kselftest-seccomp: 4 runs, 3 regressions (v6.3-rc1-1-ge1e17d=
7debf4)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-1-ge1e17d7debf4/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-1-ge1e17d7debf4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      e1e17d7debf486fd3b757df9e009b8d109e4be43 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64077366c3db2914108c864a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-s=
eccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-s=
eccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64077366c3db=
2914108c864b
        failing since 70 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640779ed3413ee27728c865c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/640779ed3413=
ee27728c865d
        failing since 140 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640776fabbb7c6e9918c8653

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/640776fabbb7=
c6e9918c8654
        failing since 140 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
