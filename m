Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009F27072F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 22:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjEQUXu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 16:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjEQUXr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 16:23:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F282383F0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:23:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ae52ce3205so8490755ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684355025; x=1686947025;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aqKaAWV0fS8XbVbPBAuy69MC0ieO2Z9Btc8q8B9fvVk=;
        b=c+b/8FqnY1E6//jseVfiW3GWhKoalBjZ9vnIfk0Xfuh/58wVDPhULPAN0rAfv1z1Mp
         lcdVD0vIpatKkUnYRifo8AUm4J7+LdoJ55hYiCwWUPZDQpRqrbDHh0ZnS+iwf0Gh2GgS
         vAFDCzTgThpmg7rHP/9vI9e8P+K2rYCgJ42LM4GE5aNuuHxlTr9Y6JHN4Ukd5rOXJdeT
         UZ/aOtUzx6E5rAQNFS5JHjnIHiC9Am+cyhKroAj/GtbkG1RKeXuK4zjVP7faycbcMRtd
         tBIsrD6imWImWDSUDpzJzXZPaRfNXUMAV38hAV/j+jUXiNRJY1NzX6UPj9JH7THTczR3
         yphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684355025; x=1686947025;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqKaAWV0fS8XbVbPBAuy69MC0ieO2Z9Btc8q8B9fvVk=;
        b=kwC5YeU2rlOTZeN6NOuIk8QyzhI9uQfb2R+4YlZu1CHm63KkGsA+8QwWkh1JlwE+F+
         RyDgfeShZc9mKdmIvlAqh7kEGQPpcxs2+Mi2jgXup9r2zXG216IBsELnsBhha6Ngcy5b
         ujlwJWgbO5qkOFkU70FsqAAwIQQYLgDRjorbNIQdPRntozBVByKzoMByUkhrzuM4YKo1
         rqemCStCR3JWWbxuQJA4Jtk1tpzS/PNdBYPk0f4zCikPOx9aTXgTh/YCIh7D8s9FN9Mk
         jgnnilF+Rs2OhoXtOfslsQRqJPN6M1/jGqKpT8ISMHkRT8+2Hr+AdZx9yNAkp9O1Dn0y
         d1iQ==
X-Gm-Message-State: AC+VfDwnJ9wNt7pRogQR8FN+Iw4CuUx6SeDYuhYIHgNgXg4PoILMXhqd
        e48+bCPJMW3nW4d9lIpnqZBtQw==
X-Google-Smtp-Source: ACHHUZ4iP0T/EO3Nac8NPe2xqIQNkP2WkFa3M4KsBgQeE/1XClzfO4Iep58hRtqWQTDtKKw5YLvEEg==
X-Received: by 2002:a17:902:e945:b0:1ac:8ee4:5e1b with SMTP id b5-20020a170902e94500b001ac8ee45e1bmr82386pll.14.1684355025481;
        Wed, 17 May 2023 13:23:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b001ac7f583f72sm17941034plx.209.2023.05.17.13.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:23:43 -0700 (PDT)
Message-ID: <646537cf.170a0220.56037.495a@mx.google.com>
Date:   Wed, 17 May 2023 13:23:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux-kselftest-fixes-6.4-rc3
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lkdtm: 3 runs,
 3 regressions (linux-kselftest-fixes-6.4-rc3)
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

kselftest/fixes kselftest-lkdtm: 3 runs, 3 regressions (linux-kselftest-fix=
es-6.4-rc3)

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
ux-kselftest-fixes-6.4-rc3/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.4-rc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      dbcf76390eb9a65d5d0c37b0cd57335218564e37 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6465241c1999629ee92e862b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kself=
test-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kself=
test-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6465241c199962=
9ee92e862c
        failing since 211 days (last pass: v6.0-rc1, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465299dd171e4bed72e85fb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-colla=
bora/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-colla=
bora/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6465299dd171e4=
bed72e85fc
        failing since 210 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64652d185f6eb5d5842e865c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-colla=
bora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-colla=
bora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/64652d185f6eb5=
d5842e865d
        failing since 210 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
