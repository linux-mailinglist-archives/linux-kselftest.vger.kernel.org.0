Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1186FBBD2
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 02:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjEIAHJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 May 2023 20:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjEIAHI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 May 2023 20:07:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A549CF
        for <linux-kselftest@vger.kernel.org>; Mon,  8 May 2023 17:07:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaf21bb427so37176105ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 08 May 2023 17:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683590827; x=1686182827;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HugOPv+Ompt3toduOnMOhX19jyUoeD6O7fBiT8QzD0Y=;
        b=egn1oZLpe3APZS43159hLHRyIbUfxmQAFxsPlBwzdns46+LZ7lvRXyfgAEIu6WT+cn
         y0wPUs3A1oYHnqMDZZUmxi1XrtlExHDKTIyi3TJZheJFYOD9BAeCH38Cqb7rFaCW58Vf
         vqNPBRpAwvXJxQu9vJ+ZubL7LTWf/MzDKfhuBxYs/seRIOWyY/XgOx/BY7muQBVODLvj
         ZajaqgsirsrSU1dFKc2xwSmmfMgo0LnleNRcEPKgRkEZ274WvGNc8kuCDpm41kTRybgr
         ogJb0vIADvA1YxEIftLHJIQU8oafETnUr6K8BDPLsUoJsl3ho1L+AeoHVNMmK759uhke
         X8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590827; x=1686182827;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HugOPv+Ompt3toduOnMOhX19jyUoeD6O7fBiT8QzD0Y=;
        b=XUaKg7iAhb/G2plzxOTm++xB3fWQno2fMhtTz/IdstwrwgpVyP/73lxDIsac37s1z1
         bdtuNAClwyzToU/8wkNS6SowZp3J/PQaI7htvkx3gGmj57taXQDBx1VqQwpXNnemu41g
         OF2izX+IfyLyJviy3ftlE6JC8bGoNZvSVLrz5oeAQSwzkXOsv+AxUr1xPIb/nbf/c0l+
         IAzt9hqpFnWvcVE39Ofuo6U0udaZyDcQu+R7TfZR1M/nSFvG4yNjuOq8sEDjH8DMs9c3
         WNE+8MjQmkDEktGy3tw0VCVjO8v9gKHcpPhSkmmRVfNJeVz6WhrjWFh4CKcYMEwO8LvD
         U2Qw==
X-Gm-Message-State: AC+VfDzpt4J981kOjEzLHXsufL7pGn7//4xNZX8P/OYU52flN8Qv4BjI
        C3Rp5D7FH8LVFmbVXKcHUlu8G//jztdY6JGZZpZy6Q==
X-Google-Smtp-Source: ACHHUZ4OHNpxH29//HN2Vm38XV1XF6SMX/sAXMdk7PByO3EpWEt+Z92v+HvtKJ7h4X16lemEu9AGCQ==
X-Received: by 2002:a17:903:124a:b0:1ac:4d01:dfec with SMTP id u10-20020a170903124a00b001ac4d01dfecmr14468128plh.54.1683590827290;
        Mon, 08 May 2023 17:07:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id em8-20020a17090b014800b0023cfdbb6496sm10639638pjb.1.2023.05.08.17.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:07:06 -0700 (PDT)
Message-ID: <64598eaa.170a0220.5c45b.50a7@mx.google.com>
Date:   Mon, 08 May 2023 17:07:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.4-rc1-3-gd7eafa64a158
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-cpufreq: 9 runs,
 1 regressions (v6.4-rc1-3-gd7eafa64a158)
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

kselftest/fixes kselftest-cpufreq: 9 runs, 1 regressions (v6.4-rc1-3-gd7eaf=
a64a158)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
4-rc1-3-gd7eafa64a158/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.4-rc1-3-gd7eafa64a158
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d7eafa64a158cc9f1d26b3c615d4ada3c17c02ee =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645984baa2669fd9ca2e8625

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230421.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/645984baa266=
9fd9ca2e8626
        failing since 201 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
