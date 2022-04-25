Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF350ECB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 01:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiDYXnm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 19:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiDYXnj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 19:43:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F232319039
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 16:40:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p8so16273213pfh.8
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 16:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=SmUJojiu5loz30/whb4vyd319lgN0Y1+Uni/X0VERlA=;
        b=M6fcEj511zuSrgVQ2J1TtcsfSOx13oFdcrmX71R7hBCdr3535xe9HY+mrBFZaw4UmG
         u3OAdk8uqusyUVBbnBG1QaFtHNngOXVsP0/Yrprw8L0IVhhBVWzS+PicYAnlgATZBrWh
         bdEFlOhb34WsSc0NqUj+Sk/rjOawB5JLl5Tq6WDorxl2kmF2DihGq6WPqI+mcPE/FrJI
         p39jyRyvm0t34cbnJCssM8bTIYina3oqPuQQof1p1PuPOiRO3+qFbrVyzkCyKTafKbHP
         mU5pFzJuMJsV7P3llnodFMa1OKlMJehtcjo4mjFOp7zMyTP+RGuxqVGpRXPwhHWBIef+
         s9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=SmUJojiu5loz30/whb4vyd319lgN0Y1+Uni/X0VERlA=;
        b=jvyeeoxv2W7KAvhPHGCKzk9qzSkxTjCteVmETXz7FVn71cDgBgrPulGJbmQprQzXe/
         vLyX3QB8ZpOUiy6M5ja4oX8uvMH9eRCCY9V/Oz+w7XrGO19q01EycG9nkR2AG5SMnDXo
         48HAoDxrwBaQx6BuCTXb3sSeBntl6RvK2YZ5ZBlmYYWYhSOoA15rwqidB2zCzhCDZCpE
         5nEfDNdGKsNIS5vv9fYROyRcNmq2gmcbMzWO+cVAO7uc/DlLmy94KWLOjffSD0Uy08lJ
         vyKUsQPIMKCYvSKgI2azBEyYPEcGGas3FE3KgQ0Ji7ZXRRohQZf8ui7sNgyxaOl2W8y+
         BWpA==
X-Gm-Message-State: AOAM531KbygX+8W31bSGbjBDJbuRzmOER2afDQuPF2Sh860p0bx9N0D7
        8aZIavRRacL+IiIObX37Lhb0YAR043f8dsSoZtA=
X-Google-Smtp-Source: ABdhPJxqYtanOsBeuUhrAihXugfxZmBF1Osv6mxQ8/J8yc64D0ILcvW3vJM416Nj/CgIUbRi05YOmA==
X-Received: by 2002:a63:2a83:0:b0:3aa:8d90:a6b7 with SMTP id q125-20020a632a83000000b003aa8d90a6b7mr16934416pgq.314.1650930032508;
        Mon, 25 Apr 2022 16:40:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i127-20020a62c185000000b0050d4869918csm3085940pfg.216.2022.04.25.16.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 16:40:31 -0700 (PDT)
Message-ID: <6267316f.1c69fb81.eccbb.6e35@mx.google.com>
Date:   Mon, 25 Apr 2022 16:40:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.18-rc3-9-g170d1c23f2a3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next kselftest-lib: 5 runs,
 1 regressions (v5.18-rc3-9-g170d1c23f2a3)
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

kselftest/next kselftest-lib: 5 runs, 1 regressions (v5.18-rc3-9-g170d1c23f=
2a3)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-14 | defconfig=
+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc3-9-g170d1c23f2a3/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc3-9-g170d1c23f2a3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      170d1c23f2a356932259034f73d579d0bab857d6 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-14 | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/626729d78bdb63adb0ff94e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-14 (Debian clang version 14.0.1-++20220423123016+9a3e8=
1e1f91f-1~exp1~20220423003106.122)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3-9-g17=
0d1c23f2a3/arm64/defconfig+kselftest/clang-14/lab-collabora/kselftest-lib-m=
eson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3-9-g17=
0d1c23f2a3/arm64/defconfig+kselftest/clang-14/lab-collabora/kselftest-lib-m=
eson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220422.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/626729d78bdb63ad=
b0ff94e7
        new failure (last pass: v5.18-rc3-3-gabd26d348b2a3) =

 =20
