Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F126FBBD5
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 02:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjEIAHM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 May 2023 20:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjEIAHL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 May 2023 20:07:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE8E49DA
        for <linux-kselftest@vger.kernel.org>; Mon,  8 May 2023 17:07:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ab05018381so48864745ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 08 May 2023 17:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683590829; x=1686182829;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MrUshkEiBAaDWSEwfNSpygC5tZL7YyQGgWzh3n6GqdA=;
        b=Ja3HJ+OoTRr6JB3YdFJTmqTsQ+eQCpk9jn0bBTYGHIXgA1l7GJ1Ee80Ucae3ADYhoQ
         oINeRcoXsHwu6ha97DW+YBNTiiMuLZaRu4VUBTASge7BDEYeq+0IrJUtL6p0X4Sie7ec
         6liO+0T49/mkSERj6dSFlyC+RGnJ4aK1F/ZC6rAGpVWHfCjxWkTBIQyNf8uVo9ixWXaa
         c0D6C6b9ajJXDqdihG7Bm7GEtD845EXih2MDFaychz4E3UGDaNNdXugBzBVyJ4mGSIZD
         1kd9Y2Mb9yUZInwiEsmHvlgBSnyXhbnC3FhIUXkgq1/0VCITxggJKRiO5eOMRmhAl5lM
         cuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590829; x=1686182829;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrUshkEiBAaDWSEwfNSpygC5tZL7YyQGgWzh3n6GqdA=;
        b=Z0LKIwKEdSNLw+VolL5h+DCGlfIWPGXonNwxrqfw4py57jD6IKgOh3w+v8FC1nPB0g
         kCwpwStMjljW11VtBRo6+KAtI2wiTiiySCrjPHBifp03zRscOK7RmFsB0GQbF5sUnx98
         mC+Rmshlvcva65RFLBJpgnfh7ZT596u/un3upq++H+n6P7Tr+HBpRvu/Y1XoFWO+nnzG
         PIumz6Ff7vgKZu246CnojdcF0rtv8T/Wv+t2I+Yb8NIk5TFYrkyqP6UhnR0pNBXsVMD2
         mMOeBRjY089K52h5de0HRvcnlscr9BMf1bBpTaRiCqFDulNe24CrMm3UOc/Z1/Yw8jsf
         7svA==
X-Gm-Message-State: AC+VfDwRBV95iPhZ8SUCZ/ccLTYz1ruSvNvukJGNvZ0DHH9Q50XfjFB2
        T/ywXzHHPOvdpEq55i+jQoUb8w==
X-Google-Smtp-Source: ACHHUZ4+qGgr7ty6FxT8gOTH/85bOMXGqWKFsvhQuoC29E039WC9g82MOCvJBH1aZkx+ClCf+efJxw==
X-Received: by 2002:a17:902:db0e:b0:1ab:12cf:9e1c with SMTP id m14-20020a170902db0e00b001ab12cf9e1cmr14155867plx.32.1683590829628;
        Mon, 08 May 2023 17:07:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b001a6756a36f6sm65638plw.101.2023.05.08.17.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:07:08 -0700 (PDT)
Message-ID: <64598eac.170a0220.82eb1.0300@mx.google.com>
Date:   Mon, 08 May 2023 17:07:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.4-rc1-3-gd7eafa64a158
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lkdtm: 7 runs,
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

kselftest/fixes kselftest-lkdtm: 7 runs, 3 regressions (v6.4-rc1-3-gd7eafa6=
4a158)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
4-rc1-3-gd7eafa64a158/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
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


  Details:     https://kernelci.org/test/plan/id/64597d1c9582b592152e869f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230421.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/64597d1c9582b5=
92152e86a0
        failing since 202 days (last pass: v6.0-rc1, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645984da15cf2dafcf2e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230421.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/645984da15cf2d=
afcf2e85f4
        failing since 201 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459855c4e1b9b65042e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230421.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6459855c4e1b9b=
65042e85e7
        failing since 201 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
