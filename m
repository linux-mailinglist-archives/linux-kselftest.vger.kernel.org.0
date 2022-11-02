Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDBE6164AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 15:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiKBOOe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 10:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiKBOOb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 10:14:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E512C240B2
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 07:14:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso2284707pjc.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SEzAi1gqLEFmqpLuBtU1pOYSQtUDc+4Onj9zlcWo130=;
        b=adrwCQe9PDid7ZGQHMQo5qdu4Ulu6LZOWpYgtZA9C1fAMgvQcL+PCLt0fU/UnVJxt6
         RZ+wt0ypbN80daciIpswgoST6P2o1nyOQvi+nYUrDVL91SrKeF/JKdWYEUknIcotkqnO
         slhTk5gl0BzG7wYLVJds2E4fTMMSx2qvegtfhR/pgwNp/AM8F5Dp4dkffFNamSe8Se3s
         dWOwrGo1b40bdh6ErPc53n3+Kbb4n8wsPXAlA2wOI4EnYuH5jdhlnqi25dxYNUyAT5iM
         bGA/2riA1DMBWfxPgV1ySwotFeQvfetAeVqj7K7W4v8Zah51JqfhZJH+TzzPuTmMssDt
         q3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEzAi1gqLEFmqpLuBtU1pOYSQtUDc+4Onj9zlcWo130=;
        b=0olz++mIckKrBT7CUB59UlkoFWMEmBXp7xErGj7Tpt5iLd+CVYfs7bGvakUyR94BAY
         2nfKISIfcEH/yffj1Cyn4gR5wy/OnxOFjYlrO8uo6dJoFaYCH9siNOih5mQIbYpvnVoO
         EwyEx57U24RMNGuawF6c2qapusGR1uUHmwEgeQv2IgQ1ytU0jRAD1z319KRMoQU9Nb4h
         w6nKjtppu+2Ld50IYbVMQpea1yWZx7S+BgCmI1vk1g+1lcoAaOUDdJFU6iMyoMcBjSvq
         wx4/3smaTrNccZdNzfr30PEOvdQ19PNO4lnqkcU9QnxM4GEPOB6lmrAwUVW3OTNgcUGG
         lpSQ==
X-Gm-Message-State: ACrzQf3m+rZmWe+S4YypanA+BBN+arVuTSQ/mwracx4uJe+k9QVa8yZn
        SQZq8p+enMXgSloWNTCB6PMOLg==
X-Google-Smtp-Source: AMsMyM6nFV+vfyMIq2QOmKe/94mVSXNpGIHxZGxzUGXI4BYtUabHS8ZAL105lb5YLSJq5PaAJ/5X/g==
X-Received: by 2002:a17:902:e812:b0:187:2ab:7d6f with SMTP id u18-20020a170902e81200b0018702ab7d6fmr24906502plg.137.1667398470440;
        Wed, 02 Nov 2022 07:14:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o24-20020aa79798000000b0056b8b17f914sm8491978pfp.216.2022.11.02.07.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:14:30 -0700 (PDT)
Message-ID: <63627b46.a70a0220.bc22c.01d8@mx.google.com>
Date:   Wed, 02 Nov 2022 07:14:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-seccomp: 5 runs,
 4 regressions (linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67)
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

kselftest/fixes kselftest-seccomp: 5 runs, 4 regressions (linux-kselftest-f=
ixes-6.1-rc3-3-g89c1017aac67)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.1-rc3-3-g89c1017aac67/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      89c1017aac67ca81973b7c8eac5d021315811a93 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626ea90720ac3502e7db79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63626ea90720=
ac3502e7db7a
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626adedb2e30d21ae7db55

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63626adedb2e=
30d21ae7db56
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626e9e0720ac3502e7db70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16=
.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63626e9e0720=
ac3502e7db71
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626af211e7c17733e7db6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.t=
xt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63626af211e7=
c17733e7db6e
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
