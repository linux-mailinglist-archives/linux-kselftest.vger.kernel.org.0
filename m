Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99376682CEE
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 13:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjAaMsR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 07:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjAaMsP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 07:48:15 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16114234EE
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 04:48:15 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 7so9975873pga.1
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 04:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t3F9AtrQk4Q1yaZqsNM58auqDTF0Lnch0cecdcFtfOo=;
        b=OkYcYdrkl0Hh5WDa7BTVRUYkAxjrNnDY3MSs7tsPiKjUvV3dBcIt1srGgyglKlSvEb
         ceLcSN435UN8ZMh5zU7kNGeV4sooVP/10j40a96hlRQusSI/sk5kO5umccDUrYsFJMZQ
         wpjOw2SSltaNTMrNe+ZVo4NeBG7W/sOZXn3tIM+b5AgThORGLSKtDQCHifeKrhOVfj/Y
         4I7ruhyRemGAHcoYqivEoP58MAjEl6PBwlMNlDxep1iZMrOPJ3dvDEpnm/7/yscJ6UsI
         LME53padLbDwhjWa6F3mOnAn/fTsSldgdSl9L6fWlphELhadxKGMvHOEN1aAYtztlz33
         deag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3F9AtrQk4Q1yaZqsNM58auqDTF0Lnch0cecdcFtfOo=;
        b=iC8TVLVT/ei1dADZk93IDKQvxIhPG1zZ4f3WhM2f4HxiqkVFqSorW2EYv/mHOhuf83
         NARrwNuQiKObgcJBg6jW9yK+/dRc4o0j7yAnmLRcjbYbl+9v0LQSytBx9kYMxXLV/HPb
         to8CUcyEbYLR4W7L5P4ybNS+YRPzRFxswwmQ/iAcXm9K8Umxs3f2G+zDxF33MTEommt6
         A/dLP17hs+6C16peqjX2JPgkfgTAxcCExUWNIQOzeWPPGI1D0BYSTSvFgb+Vog65ARdp
         Wo8Mvi9yb/2eTeMmTBHHRttl7xJgD4Ud9kDjqJZBSR4qVpqxr6jH43foq7c/jIAEJy1/
         ZjAg==
X-Gm-Message-State: AFqh2kqXD8fPI80/zjDkOTEvR0u9ugQm5qlxgh7TUVBCBnm4QJimdE6v
        T23T12vz+PLh8Mf0PaYUSKZd1w==
X-Google-Smtp-Source: AMrXdXvSCWWHfWi0X06Hfj8COS9Qyc8gYHSYkpSU6pBcSWbsLSxEkMWrn8AK6QtYOjffZtoe5clKeQ==
X-Received: by 2002:aa7:91c1:0:b0:58a:fddd:9b1d with SMTP id z1-20020aa791c1000000b0058afddd9b1dmr47081862pfa.10.1675169294564;
        Tue, 31 Jan 2023 04:48:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e21-20020a62aa15000000b0058c8bf500bcsm3733752pff.72.2023.01.31.04.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:48:14 -0800 (PST)
Message-ID: <63d90e0e.620a0220.3cb0e.693c@mx.google.com>
Date:   Tue, 31 Jan 2023 04:48:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-31-gc837391e4499
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 3 regressions (v6.2-rc5-31-gc837391e4499)
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

kselftest/next kselftest-lkdtm: 3 runs, 3 regressions (v6.2-rc5-31-gc837391=
e4499)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-31-gc837391e4499/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-31-gc837391e4499
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      c837391e449979b550a9aabfcc253d245b5436a1 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63d8fd0f17d5179c16915eca

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63d8fd0f17d517=
9c16915ecb
        failing since 61 days (last pass: v6.1-rc1-23-g00dd59519141, first =
fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90233334c490530915f03

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63d90233334c49=
0530915f04
        failing since 105 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d9013f218e547789915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63d9013f218e54=
7789915ebb
        failing since 105 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
