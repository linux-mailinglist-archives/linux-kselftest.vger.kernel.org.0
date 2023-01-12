Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C361668802
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jan 2023 00:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjALX5Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 18:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjALX5W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 18:57:22 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDAB302
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 15:57:21 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso20971329pjl.2
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 15:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CqeSZIKp9ssprWuMN5UdfJbQXqw3WY1PHKXggLvMd8w=;
        b=zJukC2T7ljRBZuCM6NQYREaZsBfGLNS0T/XGGsMU9jNv7VWLWDpCDeHZUmLtfsPlMI
         AFG6EMD2BH7M1n5qtSG1H9UhL/TO06aeUMpSWWPx1OGsYN2FeP3IHHJZ2IYuYd6bVY+4
         pZsgcwpAjDBHUHv4dkILrESB5DZ3yy9cJ00ni5KpcDKEl2lrm2VGl2uTWvBb7PRvhYOl
         oh2sx+sZcOwjVOf1l8zgPVXq+hm5P5ukVIVgSFK8sO/Cis0bmwbZSJidaVGaXmRQ5xcU
         o+COcbDOZGFzhViTPlZkSdCS2aN/8uCDWqGZAx4/ob9qQ7ED6eBZwbqs00z0/bD1f4nK
         w39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqeSZIKp9ssprWuMN5UdfJbQXqw3WY1PHKXggLvMd8w=;
        b=GJU/GokPmpIY7/h6tgE+WUv83+8u9KjIJ+SEsyCJlXN0K2h30Grdd551rVkX25Ed0n
         6/HR7ohTKCJf0/u5AL/kw/LzNhmibfqgGv2EohY6peLAnrAlej3hv3yNVeIonSSxaRNM
         O24HV8eMRneBA0RRDvM3l+WtQHsD3S23umS9MfHfiuHDlAN9i3quuYBUv06HpLvpl/dm
         21s/3/+SrSljsNdDNhj8Rwj62lkt1FiMz95yDyd6gFFCdPILIuLnvdwiLu6RyqzkOtqB
         ygNwRtyD3C89HCn0cYHYJXhF+3nUsAm1UTcmEVHpn65zVT1R33rqficnWDEwp5VpCd2J
         Lgzw==
X-Gm-Message-State: AFqh2kqY3l9zPKwW7CPoEeq0cX6dqL/KLJvHOMFZHvR9WUKn0pcoCc2v
        KMQSWXk8wwjXd86ZfnMhk/qb8nO/as6Pki0mQq1ARw==
X-Google-Smtp-Source: AMrXdXviUufEib1gF9H4k//w8QzWIV+9g/FV1p25F3e0GCflPXLxlZ+2APCpRUrVznVOX91hGO7LdQ==
X-Received: by 2002:a17:903:1209:b0:193:2303:c9e5 with SMTP id l9-20020a170903120900b001932303c9e5mr27291088plh.20.1673567841160;
        Thu, 12 Jan 2023 15:57:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709026b0a00b001898ee9f723sm12820197plk.2.2023.01.12.15.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:57:20 -0800 (PST)
Message-ID: <63c09e60.170a0220.76020.56c3@mx.google.com>
Date:   Thu, 12 Jan 2023 15:57:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1-1-g9fdaca2c1e15
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-cpufreq: 4 runs,
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

kselftest/fixes kselftest-cpufreq: 4 runs, 2 regressions (v6.2-rc1-1-g9fdac=
a2c1e15)

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
2-rc1-1-g9fdaca2c1e15/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
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


  Details:     https://kernelci.org/test/plan/id/63c0925fcc631c2df81d39cb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63c0925fcc63=
1c2df81d39cc
        failing since 85 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c093044d4bf8a99a1d39c6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63c093044d4b=
f8a99a1d39c7
        failing since 85 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
