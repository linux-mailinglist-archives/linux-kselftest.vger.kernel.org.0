Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600B0641003
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 22:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiLBVbI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 16:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiLBVbG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 16:31:06 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763E9EE97D
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 13:31:05 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w129so6059199pfb.5
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 13:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7vIo5R/fO3dWF2VhaZmMIByY/Q8oyDi6117YYBSsxhw=;
        b=LbLu+geXfHZp+prppvD1Z7u34ILEUPY1hOhQVf5Ah/Lwl2dzExLAqc52NB0qMy/0wq
         TEAwYUytRb0WjmlWqmXKxYogVckmmbddBUl8kFZkL7tj6BPw0zWMg1cDlmityhQHNutE
         paTZ2pOYzBHEaSFyKc0ibuo1BLcTP/YY2PhEZpGqpskRF8dJxnoNB/w2rFS84FzWZoKC
         5xwwe2bhPoUDuba/OGnUS+fuiPbyl86juNiT6NASoPvCU1amgiMmXWdchAcaCENQpu7c
         pR1HRSibXj0/UcKa4Bbe01tAqIS3v57dThXDy5uspb0f+o/EDniyVmTT+wdBHpmsAp/c
         1Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vIo5R/fO3dWF2VhaZmMIByY/Q8oyDi6117YYBSsxhw=;
        b=f50W+GVSeT/WvdB8QNyvPsciRAg/drTkVOxXdu/APnuZqY77Ozra4GAq4D8LzG8iVU
         P9nUJ/hTKuKbxfT+87SyulGLWdh2iaac/ZCtg2uE7/RQYwiPqvPnZphI2WWrTTk0iTXG
         jSxsn+8g79Yjile038J+lhgdD/o9wVGBmW25izM0XDxwDlD8J+zVLj7ov5k7kEtHaJb8
         ct/RoyT7uEvs9LAhGYO/fGVew/XQnnKc8DHNKODXxkw5zAV9SYzxN0Xt5nv11hXRxJr+
         zWJQ8PWS0GvYxC0PIyCzpyPkV27NpMK6Yw55gTRrYi9h4tjBnuj42HkAQ0hjgKjY9hX0
         sd+Q==
X-Gm-Message-State: ANoB5pkPgZSZrf0IAwad5zfJU1WUjHcFFxhLfEROsfnson7nrO6LiZf6
        ecFBHbXY5EaMAX77+IBa+liI+Q==
X-Google-Smtp-Source: AA0mqf5bLajYYRGLdiAAnghTjqPR+3asW+tbWA6MuihyWMukeB4firKXuKne/jYFSZpqzP09jjJx2A==
X-Received: by 2002:a63:f012:0:b0:477:b658:c2ea with SMTP id k18-20020a63f012000000b00477b658c2eamr43896367pgh.598.1670016664973;
        Fri, 02 Dec 2022 13:31:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902c64100b00189240585a7sm5918993pls.173.2022.12.02.13.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 13:31:04 -0800 (PST)
Message-ID: <638a6e98.170a0220.a4b6a.ba55@mx.google.com>
Date:   Fri, 02 Dec 2022 13:31:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-24-gd5ba85d6d8be
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 5 runs,
 4 regressions (v6.1-rc1-24-gd5ba85d6d8be)
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

kselftest/next kselftest-lib: 5 runs, 4 regressions (v6.1-rc1-24-gd5ba85d6d=
8be)

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
-rc1-24-gd5ba85d6d8be/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-24-gd5ba85d6d8be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d5ba85d6d8be7da660d4ac25761a48c74ade958d =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/638a630ecde3ea43c42abd16

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-m=
eson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-m=
eson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/638a630ecde3ea43=
c42abd17
        failing since 45 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/638a6017f74bee6bfe2abcfe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/638a6017f74bee6b=
fe2abcff
        failing since 45 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/638a5f08040ca701bf2abcfa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/638a5f08040ca701=
bf2abcfb
        failing since 45 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/638a60a1aab115b1fa2abd0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/638a60a1aab115b1=
fa2abd0c
        failing since 45 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
