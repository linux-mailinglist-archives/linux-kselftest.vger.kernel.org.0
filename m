Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E576C2E93
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 11:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCUKUA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 06:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCUKT5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 06:19:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559BFC673
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 03:19:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id ja10so15486655plb.5
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679393979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZiB1QCGpJTR6v8RLg6kgctsuGThfDPtpU/rdFqYfpo=;
        b=VefioWkgusg5W1Ps6989YK33wqP3SUUmcVcbG7zuGjsC/WfZfYbfNko7MJXTb149E3
         /GNCHc+sEwRCE2JsSEqmaqAGRtL8RtoswTuUGnn/ZXfaJDmz+lbajn7dm1u04SGL9Dc6
         0oBnD75Zv3GFNK/qY3A2xyLg3bj25MBTFLItA3MROrSpbo1cYuujaRTpl5Z/lbNTYPMJ
         6G2EHq3n77t8MyBvE1O1RUZyKcSFY6aB801msY+4GxxfplZycf+oXVU6xvwxr+AFm6Kw
         JiLEOnYXvsrQK+h2ZiU1mq8mwN5rzsMK2BynRMudh7oqoluvCe1oCy2WgTWMztcuSx1j
         qnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679393979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZiB1QCGpJTR6v8RLg6kgctsuGThfDPtpU/rdFqYfpo=;
        b=ew+66OqTALZpZNSihCrP1ACfFYPiskK0ohWEsjcaTWqPRqkdK76V1txtSrNPHf0YZc
         YZADWoZq7mYCOBxAjw63MPJqYwNCOhOJ5rlcaLzuRbq0e55XJzMUuOuPP/thV/UjUWex
         JPoA50WKQvoHMPiXo72OPbpcNNqCBEQGhz5mFGKQpOXO2Y17HrQGtjP2uq6ZK6arMn6R
         HpOO1VF9KZufsA/TeTNor0IHV00i0AHKxfFxV5nuDun87EhIZoT8wdkMFT0TZfGt0rVP
         IXzqrgZppFgoE/e2TTDp6YV+Ty1oGk0IXSm8Gd+JbhLHbSihsYG1ENhE98mDHgPCkB8L
         TJjw==
X-Gm-Message-State: AO0yUKVsz888ynMU8CzO0wqi6Ncka/muEREAsuPC84Px7rqrSkRpRugC
        HnlbICqObKknDA9h/GvlVLLAHw==
X-Google-Smtp-Source: AK7set8mu5uJzEHwL/izolervYhsuKQmexA/rLk3Q8QmqW0Nxp4cO93GO8WZd2o5Hv8cUQ7B2/VmCg==
X-Received: by 2002:a05:6a20:3391:b0:d8:f312:b3b with SMTP id f17-20020a056a20339100b000d8f3120b3bmr1539919pzd.3.1679393979284;
        Tue, 21 Mar 2023 03:19:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i10-20020aa78d8a000000b006281bc04392sm256375pfr.191.2023.03.21.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:19:38 -0700 (PDT)
Message-ID: <641984ba.a70a0220.1df3d.046d@mx.google.com>
Date:   Tue, 21 Mar 2023 03:19:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.3-rc3-1-g05107edc91013
Subject: kselftest/fixes kselftest-lkdtm: 4 runs,
 3 regressions (linux-kselftest-fixes-6.3-rc3-1-g05107edc91013)
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

kselftest/fixes kselftest-lkdtm: 4 runs, 3 regressions (linux-kselftest-fix=
es-6.3-rc3-1-g05107edc91013)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.3-rc3-1-g05107edc91013/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.3-rc3-1-g05107edc91013
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      05107edc910135d27fe557267dc45be9630bf3dd =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6419777cc875a8ac849c9510

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm/multi_v7_defconfig+kselftest/gcc-10/la=
b-collabora/kselftest-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm/multi_v7_defconfig+kselftest/gcc-10/la=
b-collabora/kselftest-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6419777cc875a8=
ac849c9511
        failing since 154 days (last pass: v6.0-rc1, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64197439fd20979be39c956b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/64197439fd2097=
9be39c956c
        failing since 153 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641972b8036eb2903e9c9512

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/641972b8036eb2=
903e9c9513
        failing since 153 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
