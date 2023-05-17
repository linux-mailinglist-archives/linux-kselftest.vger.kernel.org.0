Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7358F7072EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 22:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjEQUXs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 16:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjEQUXr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 16:23:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290B086AE
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:23:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae3bd3361dso3595035ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684355022; x=1686947022;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cozWup9zmVbe6ET5RrlES1MXVmr+lFlcYBYGv4Q/yLA=;
        b=UTB3l53DuErn1I/WOLcGqjzZ4HdEKHt5IeMI6DYrzIrm3tzscZYM4s17DYzAC3KsiX
         jaka/5D8AqwxSYUapJyDBhohrsllnrMngFyLQrorclz1gg4SIIKZWUuPR8fQ/Iv2E1XZ
         KvVAKyrNhTJ3dcMud0xt/N+5lkL2K0Pn4vz563JP4WWWQ0gl29PWgJ6ahiiJ3AtDUqlM
         yKTn+tHNmmUpC3Wz69735+9bI2YscuSeplsWnI6QFuiXTdkTZrqSfVlpVY/rXSCDZ0Sq
         0dBCv0qbJp+Y12H9ttXBpFeGwIGSVQVZnwoO3Y596FPQ8GQA9MSnFDFwCKpydjkVk7gO
         PU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684355022; x=1686947022;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cozWup9zmVbe6ET5RrlES1MXVmr+lFlcYBYGv4Q/yLA=;
        b=C+QBnL83FCpW8P5jr1mdcJUUrxdvCHDRUmbKIubgx7oSJyExhzYl1L5+6J3x2AxcA5
         XPCzaKPBFbpZ64Q20WtAIjnTzcWdZ6eLt+nEBQEfIX2ABRQ3hBZ68gOSBq9mj80vrEdj
         +/4S2vMR5QbpSnhYJbZRjJ4ZJsYRMC94y+kYa6Eecl2IyJHkmG7mbdc+0hkvQo9S7LY/
         d8CActbfIz3AEMESDkezC5pkKB62LiL5yvdkSVPTLV164jmzMRYFrrcc4fquIHvuST4U
         G86lD6NiuTjugTMzYIMKDAz+7a8IZsGBECovKlnBwdMK4HnUVsTit7Pd1nN6d7eCMCiv
         8pJQ==
X-Gm-Message-State: AC+VfDzSMIBQ9TYERY2+fPJN/f2THp6LYICOGJhc3LTPhDIG82hEtM3p
        KB2PYDnhAnyEpphqZ+8LComqoCvuSpaywbFWJNCYQg==
X-Google-Smtp-Source: ACHHUZ6XsHPgNCQsVwm0z7vLTAvZ82crBrEyuovbjlr3fNDdDYaEtbrQN+npnF1Xscqt3Bk6W9A2EQ==
X-Received: by 2002:a17:902:d509:b0:1a6:f93a:a136 with SMTP id b9-20020a170902d50900b001a6f93aa136mr4240031plg.22.1684355022551;
        Wed, 17 May 2023 13:23:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ji9-20020a170903324900b001a63ba28052sm416838plb.69.2023.05.17.13.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:23:42 -0700 (PDT)
Message-ID: <646537ce.170a0220.2a2ba.1954@mx.google.com>
Date:   Wed, 17 May 2023 13:23:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux-kselftest-fixes-6.4-rc3
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lib: 2 runs,
 2 regressions (linux-kselftest-fixes-6.4-rc3)
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

kselftest/fixes kselftest-lib: 2 runs, 2 regressions (linux-kselftest-fixes=
-6.4-rc3)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.4-rc3/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.4-rc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      dbcf76390eb9a65d5d0c37b0cd57335218564e37 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64652337397549e3352e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kself=
test-lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kself=
test-lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64652337397549e3=
352e85e7
        failing since 141 days (last pass: linux-kselftest-fixes-6.1-rc3-3-=
g89c1017aac67, first fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465290e2d208489682e85f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-colla=
bora/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-colla=
bora/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6465290e2d208489=
682e85f3
        failing since 210 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
