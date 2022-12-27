Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F24656651
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 02:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiL0BFZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Dec 2022 20:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiL0BFZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Dec 2022 20:05:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446EF2727
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:05:23 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso2276175pjc.2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RDtgTJf+o3ksXZ/DOlxfzgju0Ht+tlmm/APJechrRLU=;
        b=Z4U/PY6d+CUEWDvuOKwvT6vTk6OYIG7e/t+R87IqyKncq/rwalzm+OHj1fWzMGdTOb
         FUMzPFEKOcZ3/2CTF9JHEGkc39whuTTdsQh3B9tAlX+RI1QLhLm2F4mlBuJvKOHxDKXg
         CQj30IGYJiX3ORmD4/CxDHDRYfbIBTAq1Hb3UhyD947rDDkzL3rKBGht/9cLgvEi0o/P
         JAakEqh2qGqVQLNPpJ/oytsIWfHPC+5sHOq5obUA7hx5URjJIhMw2f+QU61/jfkVU8UZ
         ofYnjive8iiJvNQSoSSu7Y/ZecWrrxBBa2SylENu4sxZnoJvGq2QcnrInUTX+LmleSWe
         qo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDtgTJf+o3ksXZ/DOlxfzgju0Ht+tlmm/APJechrRLU=;
        b=APWriQdPsp6ow2a+cCcS9ilartCmp/wsbM8umA352xA2FBdzkqGsWgE+RFBGAF7GW9
         g2/rktTWb0riu1kqzfj33Ghc1uHYuMIlhzx9QnP2nuSJ/qZNjh80Bz1MoVilQbRgTJcv
         mpfaW/3Ofi/9agcgwXVnADCeAA/guGikuv3FUHFSRfcADnGRS1AHv+3gEsdh8YPIvGUh
         CveGXKg1g61bPzjcm4TCAHVZ8ZxWr9Zqjv9/XHv/XZEb/Izz59FSP1rzqZ2XXyFbOQkj
         Rwl6flz8kt2HeHtbk2+PYVOmT3KGiHGcYax6PMSZw6Y+30K6dpJ/y7zr6fbnXaOWcIbU
         oUkw==
X-Gm-Message-State: AFqh2kosH7rcbsa0W0y5LxiISGMlCJZNqj9sr2IWBebINEi1yLV7RzFl
        i+A8G8i9ANQv3b38gcWKzVfmNA==
X-Google-Smtp-Source: AMrXdXsllcex/8vrQS1sJr0H3zsHyz8YXgmvBJWPmutPYF+zujfoa2kcsrLbSmIUbu8hWkALpuhDNg==
X-Received: by 2002:a05:6a20:3d85:b0:a3:587b:56ac with SMTP id s5-20020a056a203d8500b000a3587b56acmr32645901pzi.52.1672103122727;
        Mon, 26 Dec 2022 17:05:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h27-20020a63385b000000b0045dc85c4a5fsm6755397pgn.44.2022.12.26.17.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 17:05:22 -0800 (PST)
Message-ID: <63aa44d2.630a0220.61795.b92f@mx.google.com>
Date:   Mon, 26 Dec 2022 17:05:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 2 runs, 2 regressions (v6.2-rc1)
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

kselftest/next kselftest-cpufreq: 2 runs, 2 regressions (v6.2-rc1)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc1/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      1b929c02afd37871d5afb9d498426f83432e71c2 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa37eb4e8ad6a4194eee22

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-cpufr=
eq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-cpufr=
eq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63aa37eb4e8a=
d6a4194eee23
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa3662882f4d5fde4eee31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-cpufreq=
-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-cpufreq=
-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63aa3662882f=
4d5fde4eee32
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
