Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AF57234A3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 03:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjFFBkF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 21:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjFFBkD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 21:40:03 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFEEE8
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 18:40:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b0201d9a9eso40597535ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 18:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686015601; x=1688607601;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oyOXwKve9PG3syUqq935caEJ+h+YsLlO8OWpr73aLv0=;
        b=q/AEx2mcsd7euJZIQk3+XaWhRRuNe8O0Kb4tTfqlso2+egdmuJ+xePQzjc4NNDGldW
         on2Jr0y/FvL1TtDdME8Mm5RVqFpSmtpyrAvcWTKZk8byLshd84t4OmEbsMIikxQZAzoY
         z95EYlXG0Gv5mpH6Rkdu9JK6d2x8Nnnq24Pzs/9jJJCyjm9fanGSuAxfrq3qmxWK1yxh
         hk8Xx4IfsuqH32tSJZki5uxi9TO2zMdiNektiMOBt3hdgo0fJTaYYqzxAqfWeE3zEPGh
         RJU3JT0X2VJ7CR+23+0PEhfCtLhQqLmNv0KOarlE/vS0oYU+5LJqwwIbnODI8Pn2AekD
         IXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686015601; x=1688607601;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyOXwKve9PG3syUqq935caEJ+h+YsLlO8OWpr73aLv0=;
        b=G5TqGpgZgfGuJeIxqh91WQYoOgNJP3karZeP7vSTWahfKR4qMfak1MkcB6t26LCiNz
         m+2cyyf0jR1dEeWtHiSVLfmQGjNV4Kgfti+W0u1UMVda7OSQm8vtpLKYcph4pKCbbICs
         iETWjesreYWZ73z5kmEnW2nIL7XDjk8W+c+tAztmCq4Uv2hWSCJdcR68y/HQ3O6T+LL0
         73/c9z23R6/MAyU4oOOoE3x90F2waFImim6Mm3bjmRHj+l2vhxaOv25yqHztRnsvbdrS
         q+QWrQP4vh38gLZfw1S2Ld6eQfNBQFzsdV+0wBXXQ76WS3vuHM8j31I5l8c+31FWF9pd
         BH8w==
X-Gm-Message-State: AC+VfDwhOsawMzbwOXgYsYHwU0uiD00FxLuy+Xx1iZdzCJ8C7frZXcpa
        eumRjTrtGUWiEOtEO2KsLgsFTQ==
X-Google-Smtp-Source: ACHHUZ7G6/N7MnPC61EgSTwD+9tE15C/UCan0vLYVPd1EKA8ZcJYTixg61G51Trz3VC4KKR/Uz/2NQ==
X-Received: by 2002:a17:902:dac4:b0:1b0:62e2:1f84 with SMTP id q4-20020a170902dac400b001b062e21f84mr12417301plx.5.1686015601162;
        Mon, 05 Jun 2023 18:40:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090274c100b00198d7b52eefsm7144700plt.257.2023.06.05.18.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 18:40:00 -0700 (PDT)
Message-ID: <647e8e70.170a0220.d88c3.d3d4@mx.google.com>
Date:   Mon, 05 Jun 2023 18:40:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc1-8-gd909ae0a8562
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 2 runs,
 2 regressions (v6.4-rc1-8-gd909ae0a8562)
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

kselftest/next kselftest-livepatch: 2 runs, 2 regressions (v6.4-rc1-8-gd909=
ae0a8562)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-8-gd909ae0a8562/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-8-gd909ae0a8562
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d909ae0a8562b404eb1aa9dae6b2f15c9e163984 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647e7dda20f123c37ff5de4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ivepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ivepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/647e7dda20=
f123c37ff5de50
        failing since 161 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e81347c3f279101f5de5a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/647e81347c=
3f279101f5de5b
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
