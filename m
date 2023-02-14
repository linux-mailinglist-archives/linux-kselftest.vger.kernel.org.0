Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA50369552C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 01:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjBNAHB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 19:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBNAHA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 19:07:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A278974E
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 16:06:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z14-20020a17090abd8e00b00233bb9d6bdcso8669739pjr.4
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 16:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni1yYPFdu41UARu5pIItL3XboMo/tcjz3CyjXE+FcRI=;
        b=ebJ5J/TaMdy8J8uKNSrf11Gfq9Dr3kw1aHoiIK+1SBelmcfc6QMiOg//q91qEkh+AN
         7sAvMP+QtxlP9pxHCXrd5bzdAonFPlfRIrYjhJo75xWFo4EXiXt/iryt+ZxxJV4HoeqP
         h/IN7dTCBNjZ/27kEBpyUeoomJEM8/dyxkjoVZYkPT89G9jOXWsBuhH9goP/Q7boA9rF
         D7T3YFW9th2nHdr+bQEGfOQCNIrNbarc/ehIvTSNW0xlzr4DaWZo2c+q9S88HqWMj+Hz
         +B6/AXR3FD2WGhQfUmqOSsWNClUqZjIVREuhHjg5nrUV7baDcIygfX9FSTKJmMG3UFvU
         xiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ni1yYPFdu41UARu5pIItL3XboMo/tcjz3CyjXE+FcRI=;
        b=egdHXiYIqCpXaXfnUWIdAB5i4hS9Kz1YERrxSe16/Po3u00UC2QW0FzbiRXSe1Ewd1
         byX2mgVyvILkSdk3Zyp+CtKnXN+Rlejcif8u/5wuOsq6+astigs/gbZmlBxq0Qj8OnWu
         zFW9ZWdTWoQQ2XMl5ZQ24WakkVW9o7sSG8H79y/Ca+hIG+Sv5h4pX4T6VdJetR34W9Cd
         SHhUVO1QORK9mnSJ5RcTrGtVHheC7vn/FJ9tSiFFJqr64VP/gaQJ88zW0lUEBDHLhBKv
         Mm9JmKstWoyeTLdSOoad0ZT1F9Kiwx53jXynZRr0Ppg8grB5w9+0ajzHb8VuQdUr94zf
         5rTA==
X-Gm-Message-State: AO0yUKU238fjxFbaSLVQ1E+N87ZptUhKNYRXVw3SDvUxjCTyWYGHDUmQ
        8LwliigCc1haiUhlJcBgLnkXbw==
X-Google-Smtp-Source: AK7set+a644jm6OFOJc1U75sImch57/244yvYGxnEKcNjDvfn+95/mfuHLzizj5QJ82jwqxEYYmO9w==
X-Received: by 2002:a17:903:1104:b0:19a:9880:1750 with SMTP id n4-20020a170903110400b0019a98801750mr754156plh.53.1676333215981;
        Mon, 13 Feb 2023 16:06:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u9-20020a63a909000000b004790eb3fee1sm7588792pge.90.2023.02.13.16.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 16:06:55 -0800 (PST)
Message-ID: <63ead09f.630a0220.cd224.d1fc@mx.google.com>
Date:   Mon, 13 Feb 2023 16:06:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-36-g6e81461b06b6
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 2 runs,
 2 regressions (v6.2-rc5-36-g6e81461b06b6)
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

kselftest/next kselftest-livepatch: 2 runs, 2 regressions (v6.2-rc5-36-g6e8=
1461b06b6)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-36-g6e81461b06b6/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-36-g6e81461b06b6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6e81461b06b6a4a24bf97fca37d9b89f72ce8126 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63eabb1bdab7dbbf038c8658

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63eabb1bda=
b7dbbf038c8659
        failing since 48 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63eac2b76812c6f90c8c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63eac2b768=
12c6f90c8c8631
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
