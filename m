Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F7163445B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 20:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiKVTKe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 14:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiKVTKc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 14:10:32 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E48F8C7A0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 11:10:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id t17so13344966pjo.3
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 11:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9b2LZNNYWkT/o4h0sToKV24lLYcOC0jDOcSti39Fras=;
        b=47qyl+EbxADizTyxTJM9q3/W2A2DRF3QtHdbNdhm+jTfn9CXzVSJ7dGOv2jsHqr7ak
         UgrKGy5N3lrCljETt/jw/7tNqpAM+IcVPA7LYZZm2vhyYonJ46Q3hEofowyka0q+G9lP
         fV2UYCLNsuLRCjDU10SWqJB7fIicPy1zFqFFTMTs7wyZ+BjNogxsEhXW9W/v4xaMQdty
         HIwjltQ/Ioz7oWm/DXGfmmUFTpxeOQg/5j4bhJ+PO4DFPKGJJTWRUbiQx+UPn6oaZAV1
         j9ccb0ojI9TqZUQ0VuKqeF7R4LhRGXrGHnksNsyFHTMwzekkLOhIzk7BRRwIniJoCRjj
         EpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9b2LZNNYWkT/o4h0sToKV24lLYcOC0jDOcSti39Fras=;
        b=V1HWgITdTm6iY81T6s+vlQ5MFRR8PPFzSq+HNYoXc9Kqxt9vhDJp400AiuFsRSEYGG
         6IUUCuE/ZapCYne+Vhkl3vKjkv/Dym9s4iWNF433a0HVeR4s2N1JsTim4+/rGUXMNeQv
         RiY61AX1QBoaKOBA37yAfHFYnn9QIeprn5xXAan1Z178xR06qc4cTDVVcK5jJsuaZmKR
         gECKbtxYDCbI+A17oqEABK1cbpjDBX4ZBZT5SvjAAZamyOo4QzdRLxo7sdwVoAiLWw4V
         /2Q5eq+d1tDbEROv7gXkkq82/e/7dPwz5ks3osQJ9fDpJ57RP3B3rTqM5rx2GgOTgjLN
         UU8A==
X-Gm-Message-State: ANoB5pnwgo/FIavoh0MfIyQYAHn68YPz3cuUUgthN4UzP5jWW4l/Rk6K
        x3FbvcNJSifjPN/3QWTKBcV4EegwEoYwjRti0dI=
X-Google-Smtp-Source: AA0mqf7uIdDWpw1EpL3BFh3Q6Eu8lx0dl26LJTOSinV3pgYFz29Chs0t5DM7xDKzTCIi0+9TI+foRw==
X-Received: by 2002:a17:902:7d97:b0:188:f87d:70d3 with SMTP id a23-20020a1709027d9700b00188f87d70d3mr5322535plm.43.1669144229717;
        Tue, 22 Nov 2022 11:10:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b0018934d1ed31sm1968006plk.177.2022.11.22.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:10:29 -0800 (PST)
Message-ID: <637d1ea5.170a0220.6a6f4.32bf@mx.google.com>
Date:   Tue, 22 Nov 2022 11:10:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-18-gc93924267fe6f
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 5 runs,
 4 regressions (v6.1-rc1-18-gc93924267fe6f)
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

kselftest/next kselftest-lib: 5 runs, 4 regressions (v6.1-rc1-18-gc93924267=
fe6f)

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
-rc1-18-gc93924267fe6f/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-18-gc93924267fe6f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      c93924267fe6f2b44af1849f714ae9cd8117a9cd =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/637d11c1c599b078c22abd1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-=
meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-=
meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/637d11c1c599b078=
c22abd1f
        failing since 35 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/637d10967d19a951512abd06

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/637d10967d19a951=
512abd07
        failing since 35 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637d141c6389785b0c2abd13

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/637d141c6389785b=
0c2abd14
        failing since 35 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637d11bac599b078c22abd1b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/637d11bac599b078=
c22abd1c
        failing since 35 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
