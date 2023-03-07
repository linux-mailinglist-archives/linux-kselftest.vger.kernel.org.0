Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5A76AF183
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 19:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjCGSpL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 13:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCGSo3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 13:44:29 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B967A6BC6
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 10:34:27 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso12709698pjs.3
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 10:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678213966;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MLIs2ejZyMxPDDM73K3fwlFAuPcIxQRnMEUFwtjzTQY=;
        b=FEXqhCGd5URwpovXZJLioO9xaIlOVuH57hB6skXBmtAY0p2sUn4f5w8kxA1QN/U6SY
         ibqJt/m3odB3lY4boprgVDTfB+QvIZWVHQR5ofTMpPC8c0V0025BLl+LpVJqJp3svnoI
         si8W4Yhh2ivbE5c1qtonFOnfLDlvw1Ms0qmJ9/9M75dYXcjLgLimQatFU8CHMvZO/JRd
         4Z2ycOJ7XbpJYUNT4xSULVrO41p4d7U3eJNHf+0rxvblh3uei5B7bVFSOOFCQStwMrhs
         H924J2QB2Qz0ymJq49U/jM1AOZNusp7S9orx9gFAMbAC3jARH8k/lN/fipYoXpsxyNPz
         Srqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678213966;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLIs2ejZyMxPDDM73K3fwlFAuPcIxQRnMEUFwtjzTQY=;
        b=xGNqK7T/p04mB4z8jdHNnYeqWREu9Bv6imCb59XIu/19n2iophOS/cBeCaIRRNgmHS
         bcas/vnwwbOvebm85p3Y+sqkRqu/5Dz4VGzhMUBsx/1qlLKNwieeFvWwiWcEC00G3wua
         eIe1UTNJfNE+KFVKfAFzAwY+yl0HHn3kwd2FLNETQTlb83c9ICqsuYYNQjruFZFegBMr
         oNO+aCDXfcYbTW4rLhCW1Smbdc2MEUvOWFbtSTiz6oW60uGULAcs/qrYl9NCmHXiRs2v
         X+VmP6EG5uZsxW+QnPGswbbckV5AsPAyhHxrj3nO8O7DAdwPIoWC7bWxF0CV/lWG8xbD
         ZUmA==
X-Gm-Message-State: AO0yUKXNB12JFCCfHKjvD9E7s54gTKDF/+D9SFt/rOdzpjLaic9w8xVp
        2C9L0SR6gL5AQFSZwB3LbZCoSw==
X-Google-Smtp-Source: AK7set80WYqy5X8LHhmbvjuoTrnfbrERhEKh2irCtZFQAbpsDgzu92+WVSK5G88qSwZMsWFcErkTdg==
X-Received: by 2002:a17:90b:4c49:b0:237:99b9:c415 with SMTP id np9-20020a17090b4c4900b0023799b9c415mr16723940pjb.38.1678213966686;
        Tue, 07 Mar 2023 10:32:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o44-20020a17090a0a2f00b0023440af7aafsm7666985pjo.9.2023.03.07.10.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:32:46 -0800 (PST)
Message-ID: <6407834e.170a0220.e7ce1.e72f@mx.google.com>
Date:   Tue, 07 Mar 2023 10:32:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-1-ge1e17d7debf4
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 2 runs,
 2 regressions (v6.3-rc1-1-ge1e17d7debf4)
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

kselftest/next kselftest-livepatch: 2 runs, 2 regressions (v6.3-rc1-1-ge1e1=
7d7debf4)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-1-ge1e17d7debf4/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-1-ge1e17d7debf4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      e1e17d7debf486fd3b757df9e009b8d109e4be43 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/640774035d8cef5fba8c8632

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ivepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ivepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/640774035d=
8cef5fba8c8633
        failing since 70 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6407784890f9bcb7788c868e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6407784890=
f9bcb7788c868f
        failing since 140 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
