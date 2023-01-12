Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510AF668804
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jan 2023 00:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjALX50 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 18:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjALX5X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 18:57:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B858339
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 15:57:22 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z4-20020a17090a170400b00226d331390cso22705897pjd.5
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 15:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lV1o4cqplruab/QzfCe29up6/hY/RJnZIrv0OQTcY4c=;
        b=bQla+CUUBkZ7M9chGERK0I1sc8KFX1qvPKFpe9QE4uSF0AQJ7+5VynV3W+WmrDWW4p
         tsrCgoL2w26Ih4S1HYgWo9nhmubAcDw/BDjKQvLdxesugkxrJCkmKH9dH1/8BBm3s2YK
         eDXiKH3kYbWolHVEAP/r4MbXLQ9kHVDXJSKG/Xu4xFNaXa0hh0wX+0XCZvrm8etqKXm1
         yhhg2twZk7poAjlfd31RcFOUNVu2xbvw1OMIqOKWO3fGG55Yt7PHeuSa1Sxq/lNGNo5x
         a+UAS5JwPx3K79C1rhpNGul6cyAg7pWu3uRUKDkTjBod1AV6GjxSysOCt4papdlcV230
         yEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lV1o4cqplruab/QzfCe29up6/hY/RJnZIrv0OQTcY4c=;
        b=XCexFk1U+7+H8ikhwsiaEqc3eBF5kkfxFkqdlk21vOimiFvkdFpAMmyKeShLZ1STb3
         2E4B1k6nM1g91pjv8MG6xVcKSZUfesMiJgTNAd+iMmWcj8NFxa5NgFmPcEHm3CqVtpnt
         ruLRHw9Fhnd1r3qcoE/JpDmpEWRrG+RZfY0o4pML0Gy35D1svXaE6b58eJBNmxd0Iv9O
         HY1qKlPAMIdoeXWJNlrAaz/+yK3JRxMGjaiVTJY2GwCgm1MjVfqM6cXRuq2jkoFohNUN
         ABLkSJYiK/LVRXzVlRpsX9ePIBuszG3n8d151yKn+utKjNb3zdyLsP9Bo770AOCZYCu0
         ge3A==
X-Gm-Message-State: AFqh2krX57LoiBN2xuHWse5HWwCuV5lr5DgHqNaPSqf4i7CiCLPOq+Z4
        D89c5Vs5dHmoNyLOdYLU20h1Aw==
X-Google-Smtp-Source: AMrXdXvyMJZWb9VIejdlLycTmnYHvYCBoeTxI4JTnEAGXSDbxdzUC1DK0TbE6laNSWVx6g1OtWeO3Q==
X-Received: by 2002:a05:6a21:3d04:b0:b6:8c6:5e6a with SMTP id bi4-20020a056a213d0400b000b608c65e6amr16124187pzc.0.1673567842034;
        Thu, 12 Jan 2023 15:57:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a1-20020a63d201000000b004ae6e97ed10sm9027213pgg.17.2023.01.12.15.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:57:21 -0800 (PST)
Message-ID: <63c09e61.630a0220.4efba.e51a@mx.google.com>
Date:   Thu, 12 Jan 2023 15:57:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1-1-g9fdaca2c1e15
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-livepatch: 2 runs,
 2 regressions (v6.2-rc1-1-g9fdaca2c1e15)
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

kselftest/fixes kselftest-livepatch: 2 runs, 2 regressions (v6.2-rc1-1-g9fd=
aca2c1e15)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
2-rc1-1-g9fdaca2c1e15/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.2-rc1-1-g9fdaca2c1e15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      9fdaca2c1e157dc0a3c0faecf3a6a68e7d8d0c7b =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c0919c26e6ba657e1d39c3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63c0919c26=
e6ba657e1d39c4
        failing since 85 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c09305328a4cd7561d39c2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63c0930532=
8a4cd7561d39c3
        failing since 85 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
