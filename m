Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A676E2A94
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 21:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDNTSc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 15:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDNTSb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 15:18:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC5144AA
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 12:18:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a51d304648so10369535ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681499908; x=1684091908;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p7yhkKDPxsCekXEV0zKPCeRRFwf5KcvoiNbJwayhHec=;
        b=Q6hZJzbffwAHniyjL7/8NAbf6n7+lzzBzJw5DWS0c5UWwpD+uKLcL2dXHPzgTd6SA4
         f4B1kBcyrGcCeF1+DS8QJYvsr91u8cCb6xK+joxJWFeq39+S7aSeiMZpP+MXrLbacc6/
         00SkXPD8AZlkMadn8JpkIylrZ0ZAfbG5ooTTeiJQWzFH2xNWP/SNgyj4IodfSdXYIqbG
         V7g8+rQGbM3oWb5uhbkHBReGF0nIhqxGL9CNs5GUyAp/ImXqcr2Hd72SYRAZfeE46dWj
         4NBnGGXEVhjfCRPEPwXIf9B3VVs6dny8z9t4vupGtBs1Bt65jOE98ZxaSv8RRe4arBe+
         ay9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681499908; x=1684091908;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7yhkKDPxsCekXEV0zKPCeRRFwf5KcvoiNbJwayhHec=;
        b=Ski/FUB+8FIn09ilW82K2TxoOiBuXSDiRRzB72zQWDzPo3Y8hLl5hcV6B0VtSITtJY
         87d8EQSkLeEvx1EO6URyj//hSid8zh9LfhLontuKIXWgg9T6C2P2wenUxytXdpy97LxM
         e9N1Qv1hUQRIL1tx+hikLjPzypB8SXuEVV2mBXtxnJekJh0kji60xbd7xcUCzqZnZJaf
         8yVoOi7Q56KFgJdMtXDdbFA8AYDsn+9dRIwoVo6fiueLTe3hBPg5eNNZTBRI3wkhtDN8
         5Woko0bYj6pCDfNJTI42ZsXjH+wSqhu4YUvQtLe3CJZ7bBwykBEjPMK+mD8qt4AfhZC1
         xeUg==
X-Gm-Message-State: AAQBX9fU5PvxbbbDXrcyBh/dEUKqKIsl39MWqVYVRS6YsuJRuZsUxEil
        Ur2sKLBVFH2mcQuAwhVf4eIT5w==
X-Google-Smtp-Source: AKy350aWNONoIFzmTNoSyzj6/hml0VrM/Ux5txGP0q8DncSPBZurmLJIB2BuSNhMgGPgpM1mtLQ0RQ==
X-Received: by 2002:a05:6a00:188c:b0:63a:ea04:4966 with SMTP id x12-20020a056a00188c00b0063aea044966mr10970537pfh.8.1681499908676;
        Fri, 14 Apr 2023 12:18:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z22-20020aa785d6000000b0062dd9a8c1b8sm3374117pfn.100.2023.04.14.12.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 12:18:28 -0700 (PDT)
Message-ID: <6439a704.a70a0220.f3eab.7f6a@mx.google.com>
Date:   Fri, 14 Apr 2023 12:18:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-25-g50ad2fb7ec2b
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 4 runs,
 3 regressions (v6.3-rc1-25-g50ad2fb7ec2b)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-lib: 4 runs, 3 regressions (v6.3-rc1-25-g50ad2fb7e=
c2b)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-25-g50ad2fb7ec2b/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-25-g50ad2fb7ec2b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      50ad2fb7ec2b18186b8a4fa1c0e00f78b3de5119 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/643994c930404d2fe82e860b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/643994c930404d2f=
e82e860c
        failing since 108 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/643995069b187b7cbd2e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/643995069b187b7c=
bd2e85e8
        failing since 178 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/643999b67867b7afd12e8652

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/643999b67867b7af=
d12e8653
        failing since 178 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
