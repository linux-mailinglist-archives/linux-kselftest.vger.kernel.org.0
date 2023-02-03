Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61D468A481
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 22:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjBCVSZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 16:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjBCVSX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 16:18:23 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CCA4862D
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Feb 2023 13:18:21 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cl23-20020a17090af69700b0022c745bfdc3so6100114pjb.3
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Feb 2023 13:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hWRdtpd2E/eOKKnStlfmZB8MSt87GmI9nvYvpelNT3o=;
        b=48XWPUfuopnFyf1OCmn8tWHfZeS5lNtwWRsgO3juNMBg72Zc85pBbnxLhDeX4HTQFt
         syzA2wxLFwlKyLJETatN19voqjIXt9MyOHvWNDfFOaSE8MSsryFuCFBo+QlzvlHwHTnN
         uqHcrjv187VBe9AjkeicLrGcdpQd2MB6EFAEZ3aBB254VO/BnwxP/tcVIvbkAsZ670jG
         JUCrQjUTnUgqLcPAv5KoLEou+jZM6Ulqiyua29feWI28TzWYmt9bRj3u2WJb10mUC5py
         9hHLfhD7E097IQJtwfYDn4DhXpvdWAMGWdMqpkhPP4247T5ehRCqh1Pvi4L3yiUXBgPV
         WdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWRdtpd2E/eOKKnStlfmZB8MSt87GmI9nvYvpelNT3o=;
        b=rQWWKGil4eOC9xk1sbSbWSlIFRQmEcWrIZdRbwv8g6uwDDhM/wOSuZBSTrzfLBJi2d
         D0K1JmDTu9GpPi52+R7yWM4FXn70fx+rm5CQUT3fmDJ+pM4F5A75JuIXR91Se/6byfGw
         1Owfb5Fg8MbfO6z+fqCwm8l/H54Rht8gOLXT3AxtFo11Z1UqyjeCL1AKOpfWeP5DPuuJ
         tU9pGeqDAARLG5xekBCR71BBggzmXTCTFdNbKEEqn6u28jSxMr6iRQXLVGesqfNWW1zL
         9WheGEI4AJS6Ly8NMdLYSenaK7nCibbEn4QeTyujowv7BCOOh4UmwTG++euNpIjQyVZj
         wflg==
X-Gm-Message-State: AO0yUKWA4Abr4Eafg3w7kFGexdyArGQ3HhbzKwKc4xkF6yLYVhOo8u4u
        1mQ631qvSmye4zyPGau+69flcfHotOm5piE2O56x/Q==
X-Google-Smtp-Source: AK7set8RClBBi6kUpp/58wITwbQSc7cO5TQLDgzf/1XTGPcccW7MGNzME8ZSfzzn7+ToUBErooZcWQ==
X-Received: by 2002:a17:902:ce0b:b0:196:3056:38f4 with SMTP id k11-20020a170902ce0b00b00196305638f4mr12620658plg.50.1675459101441;
        Fri, 03 Feb 2023 13:18:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w22-20020a170902a71600b0019681ab4658sm1963151plq.309.2023.02.03.13.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:18:21 -0800 (PST)
Message-ID: <63dd7a1d.170a0220.0956.3d49@mx.google.com>
Date:   Fri, 03 Feb 2023 13:18:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-35-gb23b16d35135d
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 4 runs,
 4 regressions (v6.2-rc5-35-gb23b16d35135d)
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

kselftest/next kselftest-lkdtm: 4 runs, 4 regressions (v6.2-rc5-35-gb23b16d=
35135d)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-35-gb23b16d35135d/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-35-gb23b16d35135d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b23b16d35135d8c067abde6a6e1467127c3dea87 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd6ecaab4bf7facb915ee6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63dd6ecaab4bf7=
facb915ee7
        failing since 108 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd67ef6e118b08ac915ec3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63dd67ef6e118b=
08ac915ec4
        failing since 108 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd6e946dea6323c4915f2c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63dd6e946dea63=
23c4915f2d
        failing since 108 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd67efee78139a85915ebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63dd67efee7813=
9a85915ebc
        failing since 108 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
