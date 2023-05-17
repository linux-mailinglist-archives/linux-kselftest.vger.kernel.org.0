Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24A97072ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 22:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjEQUXs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 16:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjEQUXq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 16:23:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2D87ED0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:23:42 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-643ac91c51fso971526b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684355022; x=1686947022;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ubGtkmj6dUV/o0tQu/H9J5iCmvtHreYVmx4lsrTJiF4=;
        b=khd0re6LUeixNNt99IbaIembkmHA7ei3qS0DCGuOSWSxHvQcL7btqXUrWdYvoF43OJ
         V4fTdVowU4Jgnli8VKUNOF87zXxy/La+WKZCBJtvZFN9MXBWBcb3wpwJ2/9G85ukYW33
         K4hKH/sUzYvtp4FUvmv36Nv7FbLKPHrsQHCR7VIhy0fj4+tVKQ1JgTGFSujapzRmfomu
         LbMdWgokhHyNiZdcXab/aNjWHoU60jIO49WS2xHRraTR0NCXt7ugoYY/DSlVqeOnuZOj
         QxpbL529SE1rb5bP9ugOLTP5dP7GH1y3ZbHWZsZJB3lCdn/f8uKuUnAmUU//zAnDwAlh
         8+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684355022; x=1686947022;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubGtkmj6dUV/o0tQu/H9J5iCmvtHreYVmx4lsrTJiF4=;
        b=YrMLslpDiRBdox8lxVfHZryTestzuao0xDhy0+BI7OB3y0IXmaG+G21Z8VNb/wD5J/
         VKNELXz0mblOg/FLATE95CuJcTH0wPUrohgkQmZIAduC+VnVknb/XmQh++6zoS/qGejR
         UrC90L9CUpk196cmE3XBlc/m4ruvF9k57ZxTgh6Ct/JzAsiAzC/q9R6NQffcrMxfSmjw
         xmNhkZxl36Rpg+dUuNZy0RcDBkNfqCWXmBWtoiVNoI9orAFGUG9dlvUvHjoE3ILsOpp+
         e+FhvJyslDpAE8FNskEUtessxaoBcFcbAG1nOkQvGSnMi5jt/ktfAaX6Icx7IFHPUDGM
         SiNg==
X-Gm-Message-State: AC+VfDwwIFIHZDg+eRiguG1635vIBdyMhXiojOA/dpMZrn1QfREo1dLR
        NEJ/7DTptRlyc5/5frOgN5+6tpHjE6RsKiS4VL9ufA==
X-Google-Smtp-Source: ACHHUZ6WgmvafDDd1OxjUbyTsuWjUACPym7w4y6DtioSGdA9PlLe9LZHnQLBI5Txa9VFg1zkcR/5KQ==
X-Received: by 2002:a05:6a00:2d95:b0:63b:7a55:ae89 with SMTP id fb21-20020a056a002d9500b0063b7a55ae89mr1137876pfb.27.1684355021883;
        Wed, 17 May 2023 13:23:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 197-20020a6304ce000000b0052c22778e64sm15575293pge.66.2023.05.17.13.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:23:41 -0700 (PDT)
Message-ID: <646537cd.630a0220.6dd66.d520@mx.google.com>
Date:   Wed, 17 May 2023 13:23:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux-kselftest-fixes-6.4-rc3
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-cpufreq: 3 runs,
 1 regressions (linux-kselftest-fixes-6.4-rc3)
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

kselftest/fixes kselftest-cpufreq: 3 runs, 1 regressions (linux-kselftest-f=
ixes-6.4-rc3)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.4-rc3/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
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
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646528e5b41bec2c442e85fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-colla=
bora/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-colla=
bora/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/646528e5b41b=
ec2c442e85fd
        failing since 210 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
