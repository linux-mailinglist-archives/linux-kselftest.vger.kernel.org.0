Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368E968A482
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 22:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjBCVSZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 16:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjBCVSX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 16:18:23 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613E32365F
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Feb 2023 13:18:21 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 203so4650885pfx.6
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Feb 2023 13:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2WHelJ0/hB14wSqZkWU++oDG68vsCrC7C3SlffhoobE=;
        b=Iu7Rbr34b0RFNVIBci41WZlWD3asvyvN3w1UlPXRiE3FzZuRKS5fDnOLKsJyxzUr3P
         y7HEY1QWJDzLbPcO2rbjNN4DL3jNb/NQQy8kHp/814BQlpjkH5gLLXX0a1rFOuSBzjsX
         +p05b3SHrSiowgCwB6MBpvRAJGbkGpIYNgWUoaw+ReU50Zp8CXQz7jDJbkTpBOQJ4NMn
         TIO+oWX0sdMD3Wd4S3FVbpnDLooAl0A3d+wFFd5fwxmJOZlCx6czWio//bacXQ5lX/Gz
         ZPUdA0qVyLHCAnLt3ZS3nynKD78FAnApK6nbh5mk+mNg0lUzA547OY4i7WE4vSCAN0g1
         IgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WHelJ0/hB14wSqZkWU++oDG68vsCrC7C3SlffhoobE=;
        b=sGdCBPizceBRtnIBoLQONfUGC4SpcIjs3jNefLsa0vXxsSa7ELOa5uIMI2gYl5U37T
         qz+SuWpYPd3Gg2/h14PksY1A452kcr6EoywK85y8PpLboqN54PvFCXzIBvOb8MjXUp4Y
         vESJcNArgB3JIMI6FrOI7GQbejqQO+0NkQkEKHMRJ+nc7IqZN2W5qc+ZeVUmW6l9tGay
         qe0IZJHarNUn0UygIO6rJTC49zMn6QJqS15fsZiM3yB0M6k0dzMLwa4M+ARL9VspURE1
         cMpMAIXn2vujYpbKSRoAbcTf7E/WyVRPh0inXDQ6s4nERZmIzp4jOy+nszrd+59Enqja
         ZGkw==
X-Gm-Message-State: AO0yUKWhxWVnP8gtOxQYnwYzGdx5BHu+xFYkNFST3IV5mAMIkHwy3LRG
        3b9bkCcglBwyAy2xpv1qv2UWNg==
X-Google-Smtp-Source: AK7set8LAWTEKxqSeD3f8CYPmNwflajchntqzIj7DLg0asz920trfdpDJuA0itRVDYHqAwqrEigb9g==
X-Received: by 2002:a05:6a00:e09:b0:590:921d:5740 with SMTP id bq9-20020a056a000e0900b00590921d5740mr12883039pfb.13.1675459100881;
        Fri, 03 Feb 2023 13:18:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e11-20020aa78c4b000000b00581dd94be3asm2286413pfd.61.2023.02.03.13.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:18:20 -0800 (PST)
Message-ID: <63dd7a1c.a70a0220.dd384.494b@mx.google.com>
Date:   Fri, 03 Feb 2023 13:18:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-35-gb23b16d35135d
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 3 runs,
 3 regressions (v6.2-rc5-35-gb23b16d35135d)
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

kselftest/next kselftest-livepatch: 3 runs, 3 regressions (v6.2-rc5-35-gb23=
b16d35135d)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =

mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-35-gb23b16d35135d/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-35-gb23b16d35135d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b23b16d35135d8c067abde6a6e1467127c3dea87 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd692dec84f8c18e915ebc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63dd692dec=
84f8c18e915ebd
        failing since 38 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd6ec9cd46c7b04a915ecb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63dd6ec9cd=
46c7b04a915ecc
        failing since 108 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd67eb520a67e0f6915ebc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63dd67eb52=
0a67e0f6915ebd
        failing since 108 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
