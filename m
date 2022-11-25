Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AAA6390E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 21:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiKYU4v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 15:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiKYU4s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 15:56:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6EA31357
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 12:56:48 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so772482pjm.2
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 12:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=paO6d0fHqGoVCuLEo4526qqunTLo4APucahq9UFdXk0=;
        b=Vu9PmSe2sARwdTgDa6OI6eWd2fhP1ffkrt5ayHK6ibWc1dVVcqN/N+f2edg3vwjpoZ
         MxLp2uIsVos0Puf1CNokF1JVRzTJJXXtnVYMCy2K6Lb9HC+1mOHVLq15ZL4Jgy++kBdR
         TZoPRqAT4r9nSjntTGOJjAExebv80mqTvqi28PFhFEz5hiynZytGp/+a8U6otRtPAPt5
         SA0t8mxiNsBgal5uYCAwNxZdf20Wyum2bYFcL7UDWQz1pmbb8otO3TVh/gNEX4OjTZwm
         aCk66nll3lT6YfBP2BwzhqjD8fCby6FWJcJS50GaghVNg/opO75xb6xJ/boQ5RX55uB1
         iOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paO6d0fHqGoVCuLEo4526qqunTLo4APucahq9UFdXk0=;
        b=DvUpLjQo9FWRKU934WmPE/KY6sOfKi/cevFFHfduQTVzrQoFP7dj3gCPlGcWVfuUua
         v/YPrsSm/SQ6c9rFIVe2kASIwi6JlmQVoP+zfmBmUcdU3y431d0QPizdYP8mQ5iMlzN/
         wc6ejpFeyj59fq0HGuXJnprkXMlNBanK1V4/P33hrvYKbzwa3AY5HEfbSk9Z5ATZkRJJ
         OxG6cS2JjvonDdafmZaDXVSgNfIYKn5oYiKJCizXTeunaP3jCDqU/t2yfRX1BixEm0St
         CvASB1MFk71rnLWP0PA2hY6R8NGVmGcScKFaBKsgGHSWZRegTD7LWYcrd5H9VYivRYOh
         d+bQ==
X-Gm-Message-State: ANoB5pm2XSUGe3iXqe5a8cfSnx7ccdY223MJJn3T+ViLwLLXecRm+5Vn
        HlGQdKlUbVtjuCHuAGNDJCc0e3SQhNEzDktKA3s=
X-Google-Smtp-Source: AA0mqf7iw6AuvuSzHTFvyYKMR8MhPq8EGIWXt5dJmDogcnnIvgvDeTYRgVjsi38u+Kt5D2MK7lULtA==
X-Received: by 2002:a17:90a:fa46:b0:200:1df3:a7a9 with SMTP id dt6-20020a17090afa4600b002001df3a7a9mr47236560pjb.202.1669409807536;
        Fri, 25 Nov 2022 12:56:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e5ca00b00189371b5971sm3845664plf.220.2022.11.25.12.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 12:56:47 -0800 (PST)
Message-ID: <63812c0f.170a0220.2151.546a@mx.google.com>
Date:   Fri, 25 Nov 2022 12:56:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-23-g00dd59519141
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 5 runs,
 4 regressions (v6.1-rc1-23-g00dd59519141)
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

kselftest/next kselftest-seccomp: 5 runs, 4 regressions (v6.1-rc1-23-g00dd5=
9519141)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-23-g00dd59519141/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-23-g00dd59519141
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      00dd59519141398120b4baa65c0ab4b67dfd3e19 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63811de8822031755e2abd0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63811de88220=
31755e2abd0c
        failing since 38 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/638120f71007fe076c2abd20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/638120f71007=
fe076c2abd21
        failing since 38 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63811d87a966de385d2abcff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63811d87a966=
de385d2abd00
        failing since 38 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63811f1785d9944eac2abd3d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63811f1785d9=
944eac2abd3e
        failing since 38 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
