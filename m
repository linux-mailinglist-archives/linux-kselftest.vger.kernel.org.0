Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF927AF96E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 06:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjI0Edz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 00:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjI0EdG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 00:33:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71DA59E8
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:16:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c46b30a1ceso91090595ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695784598; x=1696389398; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NRXSdqdZ2XooTxHH7SmT622Y7CVRdyNai4aU3Bo30yE=;
        b=WN+LIvsgavEDUi3fn7t1QLLmP0FDfR/yAI9Tqg4hmNOxMXkQEWMUsOE0/VI/IUKlkI
         WidIIebaFW7JtEo5TnFCkmBiya4OHH5EwRNuliAQ72sp4gWlNVYsykpLYKJRit140Yn2
         K1Odg7S7Co1kSM08UWlQ5TP/VSPmm7bKfsqZM5Wc5SFSvWcNu/LxbB4Ms3uXHH42UAS5
         ITx1LRwVgdQMgx8zJg7xJVKRLuiVo9cULDtxni+QS5HxRWVUoiIdjoVK0wiLbo8ddK8K
         4/bEnwPBvChiG9VP3LQj0YsKqTjR0y8SByroDjlztQcPJhjtFygss8WAZkLEn4p/ramD
         7Q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784598; x=1696389398;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRXSdqdZ2XooTxHH7SmT622Y7CVRdyNai4aU3Bo30yE=;
        b=XP9ntjkraYrnOcvBnBDKsfnNAnEoXrmQn8E2HX5Moj7UZN/7ySAawpnibjNmn0WdBT
         cbH3apWNvn/G0hX5tIapUOgmUZexhUlsDwp1Mq/E/KpQ5UiF5SyFrZKsdtnwv6YxXZwO
         s72j5RdJ3PwcFTH6uIW9B/Josn67XxRquOZzi56h8IsP/tP1C6VSd2T3EohgakWvfqWi
         5FWI+SB0lCrLrjM+HNX83mzOtCfAPn41VTVOcLf+mSg7hEPCJKSoPOOg6mEfRU1K0wKZ
         VLWcGfoxU6VtWThFmzT4W0V/s159eIvVwQDMIugph466OiQFKFMgv/ATwoD7O06sEH2P
         ILPg==
X-Gm-Message-State: AOJu0YyXrkoO6lsc1piOucpd6PdfSylYwXZ/pJihVTm4wYwmsRtknzAu
        ACtJJ57cILtKdRTwMyae2Aj8dw==
X-Google-Smtp-Source: AGHT+IEWuo0tVkysZ614gWok1PKtdV0dpxSBpQqnzYD2OuS3fdKQy3i7pKue/3OQk+U4FRPBnbu5Gw==
X-Received: by 2002:a17:902:ab56:b0:1c5:d354:93b6 with SMTP id ij22-20020a170902ab5600b001c5d35493b6mr572714plb.67.1695784598279;
        Tue, 26 Sep 2023 20:16:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001b881a8251bsm4793421plh.106.2023.09.26.20.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:16:35 -0700 (PDT)
Message-ID: <65139e93.170a0220.c7008.3738@mx.google.com>
Date:   Tue, 26 Sep 2023 20:16:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lib: 3 runs,
 3 regressions (linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-lib: 3 runs, 3 regressions (linux-kselftest-fixes=
-6.6-rc4-1-g6f874fa021df)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.6-rc4-1-g6f874fa021df/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6f874fa021dfc7bf37f4f37da3a5aaa41fe9c39c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6513924e19c9deb3d48a0a4b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest/gcc-10/lab-collab=
ora/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest/gcc-10/lab-collab=
ora/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6513924e19c9deb3=
d48a0a4c
        failing since 344 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651394d4f12a3a434d8a0a85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/651394d4f12a3a43=
4d8a0a86
        failing since 331 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651392dbf6c180beda8a0a49

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/651392dbf6c180be=
da8a0a4a
        failing since 342 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
