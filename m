Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EE06C2E91
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 11:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCUKTz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 06:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjCUKTy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 06:19:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED64C178
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 03:19:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so19680014pjt.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679393979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f6Aeb17dJWMruPwvitj4TXBvGZEtfKXJnsOcs5RHWkg=;
        b=Sx9Q7PCxzUtC7WiSMil1Mth/iYBH/tW7gnHU/lPnqsHSYs3EGPuyUZNCtxqpmlsphH
         BFy5YdXKz3/TBv+hasNuiQGLuhf9Zq7e8E7nOMRYTh0p5MKVpsvBabQew7q66H3jvAAl
         RfUFUNMyIKrvEQWzwRi32jdlMQg/eOg4FrW5eKD3NAIAVt4DbUlG2MPG/WugzvQw5fc6
         I1YTYUM6A1413pjdAzHF3ni8/TNqrhiTbjayO5gjLEsfCmK1//wiDTue7/+gvX0Rl2EX
         jBNG9K9Ny0MWCxVGDEAK9dvjoBlgtPHMpV7leM6fG9UMY/xGnPfcapj6Zusl0W2bfKtQ
         yLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679393979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6Aeb17dJWMruPwvitj4TXBvGZEtfKXJnsOcs5RHWkg=;
        b=Ir8AxIhdbuvv4qLC5UIDf+qsZGoRswmThQCl1qV0os8SZ6w6lJwaedwhyS6Kd+zwiG
         eVMnfClOosq1zKTYZXQSKL/oATrGqgWeE9YlTFIgeLHb3/tbf8VYlqJwtaz0ydQOWvoa
         mMgM0wrsCRz8cwN2Jf7bzfeLwrQFsEUPLQA/g5BQx8SlyNK6mUN+rt+OW6mlc+YoGoUi
         VnbTNFfkPU0DViWPnLVwxJpiWJt14IIKtPIROTB4ApwbYTbX/mLF9qJUosQ351FSaUD5
         2FrSTVH33/+jwsYgqDFTkDhF6+k1gY5wfMTHtXX7OBr9rAaaYXDh4R7ow03OlKpdae1i
         gQig==
X-Gm-Message-State: AO0yUKVo/by1w8mXYMQVix19ZO/8YQ597OMo7ijUUM9jbUWiaZMDJeFB
        Y1nU79MURFkJWwnt3G/0Tfu4xA==
X-Google-Smtp-Source: AK7set96C0GzFD3qEb8C91CkiN1scDVocuPqGkcl/3MoSbXBWc/roM5iS2bDJysb9JVFvldlyELpMQ==
X-Received: by 2002:a17:902:ebcf:b0:19b:107b:698e with SMTP id p15-20020a170902ebcf00b0019b107b698emr1636554plg.14.1679393979076;
        Tue, 21 Mar 2023 03:19:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902bb8b00b001a06eb43880sm8394792pls.153.2023.03.21.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:19:38 -0700 (PDT)
Message-ID: <641984ba.170a0220.b337.edc3@mx.google.com>
Date:   Tue, 21 Mar 2023 03:19:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.3-rc3-1-g05107edc91013
Subject: kselftest/fixes kselftest-livepatch: 2 runs,
 2 regressions (linux-kselftest-fixes-6.3-rc3-1-g05107edc91013)
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

kselftest/fixes kselftest-livepatch: 2 runs, 2 regressions (linux-kselftest=
-fixes-6.3-rc3-1-g05107edc91013)

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
ux-kselftest-fixes-6.3-rc3-1-g05107edc91013/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.3-rc3-1-g05107edc91013
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      05107edc910135d27fe557267dc45be9630bf3dd =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6419777dc2343e8dc19c9534

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm/multi_v7_defconfig+kselftest/gcc-10/la=
b-collabora/kselftest-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm/multi_v7_defconfig+kselftest/gcc-10/la=
b-collabora/kselftest-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6419777dc2=
343e8dc19c9535
        failing since 84 days (last pass: linux-kselftest-fixes-6.1-rc3-3-g=
89c1017aac67, first fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64197588492aed4d759c9512

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6419758849=
2aed4d759c9513
        failing since 153 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
