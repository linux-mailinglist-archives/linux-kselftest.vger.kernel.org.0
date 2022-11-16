Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7966462B12C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 03:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiKPCRW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 21:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiKPCRL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 21:17:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16C627DFB
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 18:17:10 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso1004856pjc.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 18:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N0cNSXop75EQWNmIO+xLIkWO8c/qLhxDty3ygazW1Tc=;
        b=8WQWn17oP3r1w4w1yfgENufG2tx/v88/F151X+glsNPTaNGErBiSITEGhBH0ntOBoY
         nX1k9OEOECuSj0ly0ZU6nQGeUmxwjk38hN7I83h1N7HwK6g4o4aZXLm/Msc6dWls4nD7
         abPVaC9Rjds4XMJwj66QiXlVGiabB3cohbDuq8BFVE/K2mFq8hIg9CVCkK3S3wpcaUiz
         r+i3dcfZXIycc8K3G6LzjBvhkuJBsGeshsl7ZRKZk+OVwycrV/beJYloLJr4dkI4MSw/
         Pkzaq2SdjlxFiSaiiwTiQa43YB9DXxz5Y2Ie2ooGFK2XEYJMjb+Z//yd4GbyeGuxpa3q
         k76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0cNSXop75EQWNmIO+xLIkWO8c/qLhxDty3ygazW1Tc=;
        b=dvMoh2EQxGIJLhSLS/g80eLLkOznp5axNzCIpiuZGevxLHdnGGBty01gB1ygUtW0by
         QcMIRF2eps15WjbcqRPB9Oe2XsVjModk4qohiOBNcn32iQ49yINbFtHkT3rtLHlBZFrS
         0ichUPQeHAmwXfTafFcKI4iDAAXWxiZYcCWshr7d8xFooVUKRFXRjhupdyssD+x3bGdv
         OI2hwIbzG0LNxL2nRJ4x1IiLsIBFq40oH+hRA79ymHG2Q2LyUXt45wAGiWmAIBbDuGmI
         8nsJ+j7rfvGJpeo8N8YyfLPvZ8Yw6LAPkkuSrXf+IWnT9SL2ZeVSzAykX88yRTleLL8A
         Z9sQ==
X-Gm-Message-State: ANoB5plfneafPETvxZ2H9Yogq7C4sT3zPVAOurZfaH0F00mrQRIvss4Q
        jqtRpFKuHh2gdIMrbHHWIxIS/g==
X-Google-Smtp-Source: AA0mqf7rlOwfAPy0aI/RGpaz/bFFCi1dK/9lNau2yf8Aq30UInfGerD0jr9rk8NHnvk4ubr4lEXndg==
X-Received: by 2002:a17:902:f549:b0:188:5c0c:7590 with SMTP id h9-20020a170902f54900b001885c0c7590mr7044114plf.65.1668565030122;
        Tue, 15 Nov 2022 18:17:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79dc5000000b005613220346asm9379046pfq.205.2022.11.15.18.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:17:09 -0800 (PST)
Message-ID: <63744825.a70a0220.26720.e02c@mx.google.com>
Date:   Tue, 15 Nov 2022 18:17:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-16-g35eee9a363be
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 3 runs,
 2 regressions (v6.1-rc1-16-g35eee9a363be)
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

kselftest/next kselftest-livepatch: 3 runs, 2 regressions (v6.1-rc1-16-g35e=
ee9a363be)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-16-g35eee9a363be/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-16-g35eee9a363be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      35eee9a363becb854109e35d568299bafc97c9d1 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637439e949522291552abcfc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/637439e949=
522291552abcfd
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63743dd244cb8d493f2abd92

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63743dd244=
cb8d493f2abd93
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
