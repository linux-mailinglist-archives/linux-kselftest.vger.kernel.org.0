Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAFC7234A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 03:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjFFBkB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 21:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjFFBkA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 21:40:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A198E8
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 18:40:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b021cddb74so26773915ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 18:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686015599; x=1688607599;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v2vV5FZA5S2i44pD8z5iumD4xg12CtH1g+3Hq9vfd7s=;
        b=mxYbewKm8ZtWNlPZRAAhq12tCbGmkq0Ff74vD54Bj5JOdn6qaU5Mj0UQpmgW7COV7s
         zo42bVGkjrPjCpVxG/jk96s8gkIwp/JBslGE08XkFX4NS9NT3SpMOJNVsqXdG1Ctcxoj
         UnGc4UqfvSvL8GzJgxmsYkCxybey6rUqQEb/9kq6a35MsmTBN35Y/lMT0G+I4zYDheLv
         opd0uYf3t7m1FLGzCm6U09DqabYMOe3u6mgftWdG5vOZVxbVu37zc35DO4HZtfbCNWKs
         i+x+0+6cx2taU6MJsInAtDxuNsW00qhObf8oCEO924TFxD+HCqOr/ggeQVWjkWucf17n
         zgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686015599; x=1688607599;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2vV5FZA5S2i44pD8z5iumD4xg12CtH1g+3Hq9vfd7s=;
        b=aK7FaMmX0deChND2XbmSjK9/eP+sEtN7SFkDkmzQxPvk3RK2J9eZUMtQMKhqLH8wzv
         yEIhnfGcvRY1Jg3+ldNFcT/rTqe6jFQXv7jaW25e9z7L6hdUJcdHpPhlK60iUGOSnnx2
         BmLw5vF+k2u++fvPWi33q1sm++UbQe0B9F0gkSaIpLlCnxheeOsCQAZgzuwj7pGqRhrV
         6xPM1IcahSOGWkRYLDn8d/wfiFy9BwaLf9Pc+9jQp01cN4lDz6VjaLVpH1dQrDM3bPPF
         roCrjYu9sGwEoXmQnPWXH2TJxgosqaifcgkdI2CbS/cYbGsmU+Bt7Sm4jy4P/dcfQtFF
         A5Kw==
X-Gm-Message-State: AC+VfDytjLKL23m99PlM8IRTmQU9qoKDXVZq0HAUL13tVPL8z+cWu4kJ
        zPa/+E/zsISdSO5BVecaAH/XJg==
X-Google-Smtp-Source: ACHHUZ4QxxpUBLnk5st8mourTpaJ7l8Shr2WmAz1wR8lW9K8L13rsZX6xjf098Gv2n9BCj5NTSVuuQ==
X-Received: by 2002:a17:902:db08:b0:1ac:750e:33f4 with SMTP id m8-20020a170902db0800b001ac750e33f4mr444562plx.32.1686015599472;
        Mon, 05 Jun 2023 18:39:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902ec0200b001b0034557afsm7177641pld.15.2023.06.05.18.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 18:39:58 -0700 (PDT)
Message-ID: <647e8e6e.170a0220.66f79.d549@mx.google.com>
Date:   Mon, 05 Jun 2023 18:39:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc1-8-gd909ae0a8562
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 9 runs,
 3 regressions (v6.4-rc1-8-gd909ae0a8562)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-cpufreq: 9 runs, 3 regressions (v6.4-rc1-8-gd909ae=
0a8562)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-8-gd909ae0a8562/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-8-gd909ae0a8562
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d909ae0a8562b404eb1aa9dae6b2f15c9e163984 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e7eface10c1a6aaf5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-me=
son-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-me=
son-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/647e7eface10=
c1a6aaf5de26
        failing since 228 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e810c0a1488624bf5de61

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/647e810c0a14=
88624bf5de62
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e80161c74a0a938f5de27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-su=
n50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-su=
n50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/647e80161c74=
a0a938f5de28
        failing since 219 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-8-g94fea664ae4ee) =

 =20
