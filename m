Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02866AF2E6
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 19:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjCGS5Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 13:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjCGS5F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 13:57:05 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF139B4F7D
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 10:44:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p6so15212929plf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 10:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678214668;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo9ofBGQSw9Hvj+DMBjMxuavaRPzyx7J3Uz0yGD1qTc=;
        b=1CDGP8O2V5XfHbnSGb0rloSr0E07xhG0qVfGwkdCHBlMlDSwhCls+IDsf8ZTmET4Hz
         ypXSTN1HjDZLqnex4Hxhl5Nblh5jy3pwD1e7ODVzSkrNtAr4ar7kV9MzPigtG4y9RtmH
         lLyf32xkWmNnKEaoYvQR0ySJIHwJJlTyBrqovMM9iGO87/efeGfWy0q7jTl03jY7JDUO
         It5ji0glowk2D9m5kaLgCv/Jd51C6ilCH6VItMQQgkVdsK+/PA/TP32UElHiqRdVWEoV
         pFp8H0vXBtaLidZkYCTqGwe2XHh1iKTfn9XKafnulo8/mqIUFIxMek5/aDEk8qDvGKbF
         t0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214668;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lo9ofBGQSw9Hvj+DMBjMxuavaRPzyx7J3Uz0yGD1qTc=;
        b=VHHXWYgnInlYl9le1BEeuvR//g7tucmOR8qxAp+iE9fJsCotp1JWLLMv5tQuAy4B0X
         dH16crMP3r3TEg+9wdFuv88pf7VRlnWaB8R+edfXoh3XmWS8hoQKc40tct/3R1ctmhSs
         pkGHExIgOcFJqP5T8yLOWGu6KWrCWGfwnJ3TBZ1W3aj4gRs3rE+vO3nrTp/q77KhxL2n
         vlWJpHEbXTnI/Rflpr+kTh5mML5E1oJxgZYh/HQlCrVbY97qRScM7OG67yQONdLi3HgW
         f4Z+esBmQR5feMn44d2q3upXQN9hnbXRTn9RSt+StvZsc4J5M7fXM/6LUO12K4yyiLdO
         5Rvg==
X-Gm-Message-State: AO0yUKXaEk9OsQtq1ezmvbTzGUh+q1w72uWqsB9O6dgQHXuRnS57v3MG
        HZTbol+xaduJZCmKax4KtFUbgTBN40/rbYfg+mlH+g==
X-Google-Smtp-Source: AK7set8g2XES+oen91SXmWqiy6fe6TKKFm8mAOLdqGitnPVx3xbQRcH+wvPq4CkWG0eauyue9inp/Q==
X-Received: by 2002:a05:6a20:4290:b0:d0:3b46:3cf8 with SMTP id o16-20020a056a20429000b000d03b463cf8mr3731017pzj.30.1678214668145;
        Tue, 07 Mar 2023 10:44:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w8-20020aa78588000000b00593906a8843sm8396333pfn.176.2023.03.07.10.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:44:27 -0800 (PST)
Message-ID: <6407860b.a70a0220.28860.f2f5@mx.google.com>
Date:   Tue, 07 Mar 2023 10:44:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-1-g2da789cda462
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-seccomp: 7 runs,
 3 regressions (v6.3-rc1-1-g2da789cda462)
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

kselftest/fixes kselftest-seccomp: 7 runs, 3 regressions (v6.3-rc1-1-g2da78=
9cda462)

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
3-rc1-1-g2da789cda462/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.3-rc1-1-g2da789cda462
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2da789cda462bda93679f53ee38f9aa2309d47e8 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6407747b9e64be54368c8636

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6407747b9e64=
be54368c8637
        failing since 70 days (last pass: linux-kselftest-fixes-6.1-rc3-3-g=
89c1017aac67, first fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64077bba6957f3ee748c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64077bba6957=
f3ee748c8630
        failing since 139 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64077ade6f8a1e97a58c8634

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64077ade6f8a=
1e97a58c8635
        failing since 139 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
