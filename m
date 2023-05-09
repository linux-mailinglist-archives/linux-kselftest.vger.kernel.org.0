Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F266FBBD4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 02:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjEIAHL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 May 2023 20:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjEIAHK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 May 2023 20:07:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC57C49CF
        for <linux-kselftest@vger.kernel.org>; Mon,  8 May 2023 17:07:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aafa03f541so51165955ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 May 2023 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683590829; x=1686182829;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ltH2cceL469Jn9ttTvZeW26HB6xNknhRPjwY3TDVjrY=;
        b=SwDdTLeIcCqG234L/RKjNNaHn9Bpr7ZmzInwArur8BQliFLDfqIe2yuu4QW1kn0t1m
         hH7h3pNGscvhnaFuSJok3YPZ9uMkYtSPP5bmxlhVHR4dtrM92AFACTcx+w9cnYUfrRAt
         X062I+9uvms58zOcf533tTmifLExszMPzOXqb/z+Ouu3YMmUOwD1y4Oz5GBLBLHNA01l
         2ZqPjk13iG2bWrKlzKFubafTkpaGYHcWXWa3lNgdGi1QWCXeQK/c1ZcN2OV/3D/dXe9T
         7XIVwijYkEyOzksya1bCyBqdoVR4FDQaaRu0uNAw2jXXdOARViL1Kk5gUXkXxceYNd6P
         agxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590829; x=1686182829;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltH2cceL469Jn9ttTvZeW26HB6xNknhRPjwY3TDVjrY=;
        b=XelvbUhk81c2WTh8o/R3NWFudnzhV3eRiRcuIZmCARpmEvRK+z5dUGBPKE2OgyxEeF
         z6+fPor/ghJJK9Tst+U22NaCnFMIDUpMqiI79V8ppDlcy/raVYGmsPagsIGR9vE+Yjdj
         k3oO7ZXrtdqYFC2l3amWZQ60oT4hXXboJcIraDRvXa9+o+zjUTKH3UPmXgSCkyF1pI0w
         w8BF58mD8WoJm+67cU0L5bMmaM4yiC9QGjd6Znmv2n//mfB3X8h/ujPogkH9dPV45Glu
         p7voBFXgH8BYLtLfyEFefBIquTo2hzG1Y83GkTUssppebj0VSbZ1um+dxeeI1WF1V/NC
         Hu+g==
X-Gm-Message-State: AC+VfDxdgPyqfb+Q7Vd0fOO99QZQlWN3YTO/NqWAQ9QffphqcCR9pGgM
        rRqU4N2/Vgy0hxK1M3BwP6pLlG/Hxv1+NGvbvqR+mA==
X-Google-Smtp-Source: ACHHUZ40mu25nLbZ3P0rQmInLsU0qT4p0ahZGqqQCS0rbmGLiF3ZFS/1ICK6dgmHNhsbtFx//MdEVg==
X-Received: by 2002:a17:903:509:b0:1ab:25b:257f with SMTP id jn9-20020a170903050900b001ab025b257fmr11776221plb.36.1683590829238;
        Mon, 08 May 2023 17:07:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ku12-20020a17090b218c00b0023a9564763bsm10443887pjb.29.2023.05.08.17.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:07:08 -0700 (PDT)
Message-ID: <64598eac.170a0220.a3c9c.4f80@mx.google.com>
Date:   Mon, 08 May 2023 17:07:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.4-rc1-3-gd7eafa64a158
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lib: 4 runs,
 3 regressions (v6.4-rc1-3-gd7eafa64a158)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-lib: 4 runs, 3 regressions (v6.4-rc1-3-gd7eafa64a=
158)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
4-rc1-3-gd7eafa64a158/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.4-rc1-3-gd7eafa64a158
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d7eafa64a158cc9f1d26b3c615d4ada3c17c02ee =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64597d259582b592152e86b0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230421.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64597d259582b592=
152e86b1
        failing since 132 days (last pass: linux-kselftest-fixes-6.1-rc3-3-=
g89c1017aac67, first fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64597d6b31854bcea72e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230421.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64597d6b31854bce=
a72e85e7
        failing since 202 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645983fe64cc95ca652e8620

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230421.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/645983fe64cc95ca=
652e8621
        failing since 201 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
