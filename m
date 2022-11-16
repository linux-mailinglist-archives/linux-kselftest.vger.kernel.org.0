Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA6B62C92B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 20:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiKPTr5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 14:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiKPTr4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 14:47:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955362A413
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 11:47:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso3420879pjc.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 11:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=68NsJmzUse7r0hbOAIuRHHUvDHLMEtzLwL0/TwuNRQ8=;
        b=V9L/M8qVIEprSSZP5UqlH2Kfeii4BVlT8VYFepIYzhXb8QNc/T/5I6FGIWk81hQvOZ
         3uK5Iivn9xXyN7Go4YGli4NVyw7VTzwHPfv+AvqmkBoNLlWG3UGCE6HGCMsjMko52z18
         FC/hI4rFpO6JNaxEYGvgyomymY6/QBQ1PowzOsL/Mnwb0YeJgPwPy24DFr4dYWmaeflm
         4hNDUwXFQEIdQqgsYg4pOWb8jKndqfDxymDQwDc5+Gr6GAI5Q1CPT/55dM5jlg8cwsrX
         BSBzhExQw3PucPmlkL9BVXSCi7BeDsQ35zy0PkxKO4nwxpCV3FwEqytXEQa9+yYzzaUQ
         moRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68NsJmzUse7r0hbOAIuRHHUvDHLMEtzLwL0/TwuNRQ8=;
        b=qEibSdoLcomaht05mKKr4VVBJD43jhwzhraSEBnxpoANE7AB/7g7qyO6Gx5AE1WOqq
         eZ1ZVDG69WSP3WwVvMLLuDZOUZwJVkxKG4jDJ3VYGrkjsoRVhIN4RJLat142NR/Irwf9
         d9Un3eIZ6d3bE2xAlp4m63D1gHSo4Glo5v7fWyy41u+xxicuUwrMZXXFGul0t1eKAZoC
         jwuCXv19T26vOzeajbnKTn+hdkCkx2gvcwo9byEjxCinqqEb4JUC9wTqOtHG4kkP5ifx
         I/QQJzXcIor0M7TPEQpql1geNmOZ2wI67DO7LFE+Cmfrzz0vu4ZMBvgWR1trBqJ06Z8M
         pyyg==
X-Gm-Message-State: ANoB5pkm4hFzCTkpUAMJU0TgjPfrYj+9dYonjzuAw+BSSZiVkw65UZJh
        oCaNzUt5G1yaD3qzE9xW7gAljbMxVZUiiLno/uk=
X-Google-Smtp-Source: AA0mqf5zqq49uJPhGbgIfpXkSfmLJbOQsR8t/HPXU/lWuuZtfeTfxCboPG2zvGuA0lKqC/8MIG/ljQ==
X-Received: by 2002:a17:902:6bcc:b0:186:dcc3:5d1d with SMTP id m12-20020a1709026bcc00b00186dcc35d1dmr10504845plt.20.1668628075111;
        Wed, 16 Nov 2022 11:47:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b00172e19c2fa9sm12881184plh.9.2022.11.16.11.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:47:54 -0800 (PST)
Message-ID: <63753e6a.170a0220.b0754.4368@mx.google.com>
Date:   Wed, 16 Nov 2022 11:47:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-17-g2dfb010d2aaf
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 3 runs,
 2 regressions (v6.1-rc1-17-g2dfb010d2aaf)
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

kselftest/next kselftest-livepatch: 3 runs, 2 regressions (v6.1-rc1-17-g2df=
b010d2aaf)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-17-g2dfb010d2aaf/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-17-g2dfb010d2aaf
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2dfb010d2aafceeab23ccd502c77784006adedd7 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6375319ad98a3474942abd25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6375319ad9=
8a3474942abd26
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63752d60e40940a4492abd0e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63752d60e4=
0940a4492abd0f
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
