Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D0D6DE7E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 01:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjDKXRW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 19:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDKXRV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 19:17:21 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5C0171B
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 16:17:20 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-517c5738c8bso706754a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 16:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1681255040; x=1683847040;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8ylKJv1sO9gmSp0K0THjhWdHZ2zP4sR8Q4dNYQtwHl0=;
        b=Kp1EZwRBo9X2cb7KAfchTowMqFoKd0v5AfvOmxonbnZEYXGhZeqTe03CKt/Syzd1w2
         1VREhGy4i7KBZ/tH4xgvv6FfDILNSTvDOZ2c5/p97qUPDQzgAYaTKdc+XOfNW1Na4qek
         +3yEetASDC/UaZqeU8T/qLrsHDXoJwEmQcXCgvOCCVeTVd3RZf/xhzkRox2iJIukqQak
         185FEI4bxC/WxK+KONhbPVF0IqNXa8bTbIHBG1EKoz0sRThOLimZh7J8T8cFucYgpYWY
         g2iNq5+NdNbUdIZTxLQEHmp0PgCJxjWBe+lxivgtaxef4vEiTDxwleBqSRjhGvW19taU
         r3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681255040; x=1683847040;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ylKJv1sO9gmSp0K0THjhWdHZ2zP4sR8Q4dNYQtwHl0=;
        b=1FJOYX59mXLGQ2nGJnDJ09uuh/fh7GroZU/2qibd27pfivwLO/YBA5PkkUBQV6Ek1I
         RLY/XIy17jfck/vndzeK35PVUmsGWlKcR5Px0EE/Zu8x3+cRwehJfLZjLnka1g4Le61G
         GGkE21pn96aBFf+pvsfEn44v5H0/is2o87qDhrXCiVGc8yBBNtX4lfLcWI/BQ/bBiUPb
         hB8ULUQ96kAUvcb/1PCBxzYeZQunNTShFt3x4971+kYDginMsPyLxBuyVY/T8Vq+YxGz
         YtcV/yWdrNXXaQcGQxDyBkSgByrfxxBSWTsBs0bSren/4cxsEuo2U7w4qfHEGMNq8qMD
         +Efg==
X-Gm-Message-State: AAQBX9egQdAg/3GXsCiKZUUM7KtrM60i8GK+tbE9ghcY/ZX+772wvnTv
        vso8HL/NLHx2eq6aYODCEb0idg==
X-Google-Smtp-Source: AKy350aFX7M4F61SInxpTclnk+YC7lCXu0RISmH0fsHrPa60jO6RR8cc/GFAk/n5GORGFWFobNVrNQ==
X-Received: by 2002:aa7:9828:0:b0:627:effd:71b7 with SMTP id q8-20020aa79828000000b00627effd71b7mr408716pfl.33.1681255039906;
        Tue, 11 Apr 2023 16:17:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a19-20020aa78653000000b0063afaaa77c3sm634580pfo.115.2023.04.11.16.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 16:17:19 -0700 (PDT)
Message-ID: <6435ea7f.a70a0220.f1e59.28a6@mx.google.com>
Date:   Tue, 11 Apr 2023 16:17:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-17-g266679ffd867
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 7 runs,
 3 regressions (v6.3-rc1-17-g266679ffd867)
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

kselftest/next kselftest-lkdtm: 7 runs, 3 regressions (v6.3-rc1-17-g266679f=
fd867)

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
-rc1-17-g266679ffd867/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-17-g266679ffd867
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      266679ffd867cb247c36717ea4d7998e9304823b =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6435dca8da3c60967e2e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6435dca8da3c60=
967e2e85f2
        failing since 132 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6435ddbdba6077fa6a2e85fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6435ddbdba6077=
fa6a2e85fb
        failing since 175 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6435ddc2ba6077fa6a2e85fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6435ddc2ba6077=
fa6a2e85fe
        failing since 175 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
