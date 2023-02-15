Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D803697296
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 01:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjBOAQj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 19:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjBOAQh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 19:16:37 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6BF301A5
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 16:16:35 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id r8so18726962pls.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 16:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uWA9cQF4sFKaBKraHBNi1xUkSejUZgqRv2Foa5BiWkg=;
        b=WPJn65WsVaZFIF52FFkQx6rs1vOLODISbuwfPdxLTNbkgvR13z5UORrhulT1miRRwO
         REB2XMxIoIRlIaBRFDUut1e8MDzOnKaIy2KiV76ENOGF+RUYzxK7n6ZteDP91y8ULfW+
         UGKiSrLBAzCRzP6KnVg8kIZfKsMd2oCUVq1KtV4a20FEa5YWscrj0/PG54oKhz54wEpr
         o7BOzz4tIZ8RD3C9Sggxtc1w3vCuTElgpBOB4a4XIHYMjCx/0IknmvDVsCjJhDGj6LU5
         vIA+6DD22eZfPm2fV+Z7PRy4Ln984kbuZIGDMgF0uSzx1JgZSnfWNimR/vLiv9T5dNNs
         VACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWA9cQF4sFKaBKraHBNi1xUkSejUZgqRv2Foa5BiWkg=;
        b=w5CXf6G4JcZecrE+UbApF5ZK5o4H7N+PDmK7xeuf7wjLp181exEMkgtk2glBn3Kx9p
         XCK2cXm0lszAaBmeoomKigIDSiP5v2zyM4jXVRmxhd6azqHTUqK7hB/pm1+OFRe3kqHD
         wKy04RFhv2AUjdeJNbzV08f03ex7gYeBHYtWzmE6tVo/8nBiguK1EyIc3/wucLFbiFJo
         Jb6jRAYt0h1TGhuJHoqwSgAJBMHON96qBfAcAB+XHvdxxN2SQQ3hNM0zpu1zVH3/uYka
         XXbzP7CubUMr15ENX+sQAOLXkCMkwfKXWsqofOorF3eTzumUQZkY19SUESsK5GQ6+TMZ
         j1nw==
X-Gm-Message-State: AO0yUKXCrXYY6eN7EIBCn+LItGr9I2bsl/NsjC3uGoTt3gRS7/RmNl4H
        w2hySRFKUXpzf8Jp0cyHuZyibP6BYAo0KMWV
X-Google-Smtp-Source: AK7set+vItC3VU9eFktAryUR2xYhReOlrlnojdvk40gwPju4Cz+1/GrMzblN1dpDCEnyMQ9QO06BVA==
X-Received: by 2002:a17:902:f693:b0:19a:b1b4:f51f with SMTP id l19-20020a170902f69300b0019ab1b4f51fmr501019plg.38.1676420195349;
        Tue, 14 Feb 2023 16:16:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170903054d00b00198b01b412csm1624021plb.303.2023.02.14.16.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 16:16:35 -0800 (PST)
Message-ID: <63ec2463.170a0220.d3a3.2fba@mx.google.com>
Date:   Tue, 14 Feb 2023 16:16:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-40-g0eb15a47bf43
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 4 runs,
 3 regressions (v6.2-rc5-40-g0eb15a47bf43)
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

kselftest/next kselftest-lkdtm: 4 runs, 3 regressions (v6.2-rc5-40-g0eb15a4=
7bf43)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-40-g0eb15a47bf43/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-40-g0eb15a47bf43
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      0eb15a47bf437a268b69ab1a1a45fdf1f609b69f =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63ec0fb81ca4c907f68c8656

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63ec0fb81ca4c9=
07f68c8657
        failing since 76 days (last pass: v6.1-rc1-23-g00dd59519141, first =
fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63ec14a88c6ab738058c8639

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63ec14a88c6ab7=
38058c863a
        failing since 120 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63ec14abd0c80a50b08c8650

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63ec14abd0c80a=
50b08c8651
        failing since 120 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
