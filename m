Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C5F691713
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 04:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjBJDRC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 22:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjBJDQ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 22:16:58 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A2A1CAF8
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Feb 2023 19:16:57 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id n2so2892810pgb.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Feb 2023 19:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zFlX2GhNMACdBmGMR95QwMexHzjcaEcrZWFoQWm2uPE=;
        b=vPUQ6rxTpodFxPfXPSD1ukQUpZALDVEO3Nkthmp4E+Ica1+oXzMYKeM3N3fwTryU7D
         dQbvMSpVselEOLcpVyvC1kLzMC/1klV35B2GzBafn4PsZcMS2q7xy02s+QrmV3Yqzdhc
         fawa2TxTI06HOpodbKiC7R/WZX4ekJYfoI3YamGdv2pvyzZFRbnDVfosxmGlyv9QPbA9
         uq89D6ZH+0iWWrvC2muiYI2uwGQL5SEjLzTbEJDO0w1qqDq0OkHkLGUaOpBtKzOruK9P
         nlgxQqd/Gr4PHJ26aSN/FiKiMG4OiCjp6nsIiu5gJaSMSSlu5BnadyDcfI0gRwS2bN28
         LM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFlX2GhNMACdBmGMR95QwMexHzjcaEcrZWFoQWm2uPE=;
        b=pAtIsuIpRwuoBooeDpTa0uSGsZNmPHfJmmiLN4ODhjH93x54ThL3+/KkuEo8Tln7HR
         cnQkQcPG8lP/9zcyh2rBHT2pN3zP/NZH3XYhNZp/i0Ib/uh0+SGYn4JzP1w9FEfkvjoM
         G9HfAbkYCU/m2Irsc9CJgY1yKFPTR38P1uVdQV/Kha96lebLiJlq3fEV4SYi8sS5nEKZ
         Mmu1Xwlx8xjkqdWSORZdRKEKOn+bvt9BJPq2stdolWBF8iuNE7o8lPB633dElM1M+V/1
         4FO2ZnR6yMZ/22rcvXamfaEoUGlf/EIHry3g3nJiTaRXONqYZnoXtSs2G+rnwoj6DLqa
         dCPQ==
X-Gm-Message-State: AO0yUKWclsNxoSSPAk7Cux4LF/u9EplmELheFO+hrdWbYkSkT/wB3VrG
        Z3D2HNyPUbQZjS4RaH2lEPsp+g==
X-Google-Smtp-Source: AK7set8Wn052pgxh/21RtpgULgH9UlArK6g+JXnpVwyDloU83/0tt2g2ZmURAfYgKcITKd7GaU3Lyg==
X-Received: by 2002:a62:53c6:0:b0:594:15fd:895e with SMTP id h189-20020a6253c6000000b0059415fd895emr11808083pfb.31.1675999016836;
        Thu, 09 Feb 2023 19:16:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w3-20020aa78583000000b0059242cd5469sm2247279pfn.13.2023.02.09.19.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 19:16:56 -0800 (PST)
Message-ID: <63e5b728.a70a0220.6eb5e.4887@mx.google.com>
Date:   Thu, 09 Feb 2023 19:16:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-36-g4c853ca1cf79
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 3 runs,
 3 regressions (v6.2-rc5-36-g4c853ca1cf79)
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

kselftest/next kselftest-seccomp: 3 runs, 3 regressions (v6.2-rc5-36-g4c853=
ca1cf79)

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
-rc5-36-g4c853ca1cf79/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-36-g4c853ca1cf79
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4c853ca1cf798f1d74a7bd9e3a0541a3ae8ae77e =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63e5a689b13946b2208c864f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63e5a689b139=
46b2208c8650
        failing since 45 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e5a6176ce09168f58c8656

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63e5a6176ce0=
9168f58c8657
        failing since 115 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e5a62952fa8226d58c863b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63e5a62952fa=
8226d58c863c
        failing since 115 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
