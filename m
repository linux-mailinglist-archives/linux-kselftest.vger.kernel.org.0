Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A411E6AF177
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 19:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjCGSoV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 13:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjCGSny (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 13:43:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455D1AF6B9
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 10:33:59 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id bo22so14118341pjb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 10:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678213967;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rBV2o9A4YwV6gVJrC22FaTnrNKvG8/F9hiFElEohR8w=;
        b=2aUINrmaa5e7D5hsPUpeOzMMHeNMMNtnPZIxXDf06GotErWyhliJhzTcDYhCdcxzs8
         WSCIidnzddORrCJZeDClr009lTmAOySvFJrjAm3Z1M1GxCpXwKhU2RWpect+/yjEqQWt
         kPI/FXe1uO/x6srK5KRROnhu+mlFtuD7A05UkMmZmcSviDJwa7xbvrsX1Ig4t1R9WVAN
         GCvFkkKVF4yRUBaOiHk5VOVa0S0zm5pKDcayr8ctriqaqSHQ95SzP5fvH+KR+RFIkHcn
         oK3aLHUweXv9sO0TCbb8rTID1atbCvd6lu8eynmcu+XlG8KUrYFJvxiYCmEDy9LzzGuf
         VEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678213967;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBV2o9A4YwV6gVJrC22FaTnrNKvG8/F9hiFElEohR8w=;
        b=TOASw29Mgebqe8PHcVIEmEaoPmAJP8+Q124LT93eh+TY9sdXnV+EORUcagEPpcKgXD
         sYzvJOlymv77RcYbQiytQVx/yjV0xZMUzBMfpE4wO/5+8HueDRGeTqLuhJTZlfbNnIo/
         9aP8t3GNkSBUVUR28sGAuUTi7TcG/VWaHzSRHEjS7Zu3S7hF3CBB6555tyBKtCvjjCih
         IjhhCCSmRSoPBsWdcretWnZt2TDxRsSKJruSl8qn1ekToN334cQT4n6NCV8JSi3Va9+l
         p8QSeS5awjtm6+wPiSMiVIGnkegb5/i6ZPMWaW9iqvjl/aMj3wdj+lBiGEPpz+HhZ3qz
         TVKA==
X-Gm-Message-State: AO0yUKWJIfKn/IS0tmnkaIfuNd7kceqj3Db3FsduHyqUNWbxM/MPUMKn
        QEBhCWgH4U/ce47q1Eka2HrRyxwbvmNk6F/pOuUxkW33
X-Google-Smtp-Source: AK7set+Y8P/bgwOOc+uebUqU7xpyUAqCQCPqvuKsogJo37NnjPSpBbjkjVNH6QQrh78hQFp8qjhSYw==
X-Received: by 2002:a05:6a20:7da6:b0:be:e0c3:5012 with SMTP id v38-20020a056a207da600b000bee0c35012mr15713837pzj.1.1678213967010;
        Tue, 07 Mar 2023 10:32:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j3-20020aa79283000000b005892ea4f092sm8446295pfa.95.2023.03.07.10.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:32:46 -0800 (PST)
Message-ID: <6407834e.a70a0220.a000e.fc49@mx.google.com>
Date:   Tue, 07 Mar 2023 10:32:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-1-ge1e17d7debf4
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 4 runs,
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

kselftest/next kselftest-lkdtm: 4 runs, 3 regressions (v6.3-rc1-1-ge1e17d7d=
ebf4)

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
-rc1-1-ge1e17d7debf4/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
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


  Details:     https://kernelci.org/test/plan/id/640772d7c7c82989da8c8634

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/640772d7c7c829=
89da8c8635
        failing since 97 days (last pass: v6.1-rc1-23-g00dd59519141, first =
fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6407789a14859f030b8c8632

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6407789a14859f=
030b8c8633
        failing since 140 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6407774678fc58b60d8c863e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6407774678fc58=
b60d8c863f
        failing since 140 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
