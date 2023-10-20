Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1B67D0F8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 14:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377277AbjJTMUw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 08:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377209AbjJTMUv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 08:20:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96765D41
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 05:20:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso678062b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697804449; x=1698409249; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z/nANq3y5fmXuB2eODAwG3sUDnRb3DF5gDzje2/cYyg=;
        b=mCigUD07itnctExhprI6MYiWkKEGwpaeTbA5M5gfpEusEOoNEsNWRJYm1/TWBsdzPq
         etRmAQDQvDEaVkWHeeUU2HZxJYiaCQLTBz9bd8LlpIC/6oNhjSm/4oRTiJg8j+ZdFBPI
         L5KIWI19l+CBa9G64vRbDY2Pg7vR9d+M4/peqhM2Bh0YR66LLiaI4kSdlaRAxIILmifv
         2CAflpDwaA1ExfrirLktOlQ+14oT/4L+rQJ/CSStAvwGuBz21i+4+u9n81AdcsYiIHUu
         npRBeJEJcA2b4s9Xeg5yplMSU4Z4Z7qeXF2kM4RTXhZj4JkVBP9kbUOMtjhdHmcJeO0A
         7ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697804449; x=1698409249;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/nANq3y5fmXuB2eODAwG3sUDnRb3DF5gDzje2/cYyg=;
        b=X6IRN5J+mGg6tbqwWFk7GdOPi+5e42/byCyzO7nNIaTJNq/xMRSWA2/f/1q5oK7lyz
         P6NdEUhTGXRmgx4/ym/POXvi3nzhRb08wulR9vhgLNbYwbQKbaOaH1nSzsBgp7m0TSyE
         fgfTuiCo/o7hmW+OrDg5MyafyzgHsRFWfEPRYN8M4an18r3oSwp+tCOFj+1nKdv3xQfX
         KnAL4WvPvJi5vUxiPYc22xKm6kuV0Kkm9pEVO1rvYMKhCs4nYNOFoaS92641/mPuf3Jo
         F+urb2AHIpd8Z45LXW68xAVMOsiR0BHmApNfXYSHnUQvKQlwwlF46Lk4BWVbjWcyYmTv
         6GYA==
X-Gm-Message-State: AOJu0YwJRRRUTNH9G7eUkrZrXty8vexi+nlMi9T5NoABzbBS8poRrmfH
        n8ofM+blLt7vVix/YX/97kPga/nHz7ffZhogUDvY1w==
X-Google-Smtp-Source: AGHT+IFh6vcJvsh6Uty1uPRMOQl12PtD99FjW7aknHoO/1PmngPWi4/dPYuLNWWlUczAADXldLW5ag==
X-Received: by 2002:a05:6a00:813:b0:68e:3eab:9e18 with SMTP id m19-20020a056a00081300b0068e3eab9e18mr1700998pfk.12.1697804448844;
        Fri, 20 Oct 2023 05:20:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gu5-20020a056a004e4500b006887be16675sm1399124pfb.205.2023.10.20.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:20:47 -0700 (PDT)
Message-ID: <6532709f.050a0220.cf2cf.47f5@mx.google.com>
Date:   Fri, 20 Oct 2023 05:20:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-seccomp: 3 runs,
 3 regressions (linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6)
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

kselftest/fixes kselftest-seccomp: 3 runs, 3 regressions (linux-kselftest-f=
ixes-6.6-rc5-1-gcf5a103c98a6)

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

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      cf5a103c98a6fb9ee3164334cb5502df6360749b =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/653267f8ea95ea63f3efcf5c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/653267f8ea95=
ea63f3efcf5d
        failing since 354 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/653264227fca08dcefefcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/653264227fca=
08dcefefcefa
        failing since 366 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/653264376c819f477defcf00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.t=
xt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/653264376c81=
9f477defcf01
        failing since 366 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
