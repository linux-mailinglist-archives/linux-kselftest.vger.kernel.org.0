Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF1D641002
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 22:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiLBVbH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 16:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiLBVbG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 16:31:06 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92592EE95A
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 13:31:04 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id k79so6048560pfd.7
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 13:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WiXEPF1mHMgCOSZqEMBn1cGj+5EerpXPTZP6LfZXGxU=;
        b=LGicjWv7R5p1FrLzP/7dwWfTTJPII5bXU5XbtYe5fLdgA6Ecaav5PmD19DpTQ20MZI
         fhS02ttFl6SxOBeCEtH01qDPRd3mOFDMJ1mDcMU2lATNL5YHKAVCevCXUBRkoYQTDCMN
         KrCap6eK6+C86EK3TO9zteG7VA6QGYvhbmqkxp0nzj9iDPaHyC7KnxlW0cD48km1SdPX
         NlRvB9zeQ1qAorw0toUuTAIQtRYbd/hKVzL5bTmFo/nqwqmVJXJF98YbhZPms5Fo2HdB
         lPGux41cGAUh22swrxiyk6boALQP8bV9nd6DIRl6JL1RubwFwCAWxQrXC9Q4cBYSaedb
         MTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiXEPF1mHMgCOSZqEMBn1cGj+5EerpXPTZP6LfZXGxU=;
        b=lLpdL12lsiaNyCQ1GEsNgbUqN1Uwx/rgJlE/Gw5zoXo78qPuVY/kJMj2YjyBFeSDnS
         eIfqGXfGyGXPCnKBXZRHUiMPQ0PpS7xsDgEhsWvvRN9ng7NNMYzpz45HAmVZl8P3Evhb
         S86gjAOG5yOhAsfFw9ZJWhboy6xUBLkaZi7bM3JfxCJjCNU6qxGqIOfrt04fQnjNINvz
         gG4zbM8cdp+9/aRg1Kn0nCOnINbCjYfb2J09bNo3c6iFmuOJ9ZcCyT4QAwKlW6O6pkAL
         IioEybm8zteOodWO30ylu7RSc+H4VJPRFHGOO/UccD9pcQvY7e6pvlhX3FA+a7/SHSP5
         DzYw==
X-Gm-Message-State: ANoB5pmB58qY6o7Upyd9R9AEdbothOmjuYyIvqk+t4t6Z4VoovcuKbuO
        zS2TUaf7sL1+SWm9vn2ufi5J7C8DlkduAu1F1IDV4w==
X-Google-Smtp-Source: AA0mqf7ePyiJNVzcHQldBrdzm6UH9bbB2Z8WB+N5s7q39wEK6TL+j+tztbZBvwz348Cp0c2TbhE7TQ==
X-Received: by 2002:a05:6a00:1ca0:b0:575:a3dc:a297 with SMTP id y32-20020a056a001ca000b00575a3dca297mr19083345pfw.52.1670016664082;
        Fri, 02 Dec 2022 13:31:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a63df4c000000b0045ff216a0casm4572816pgj.3.2022.12.02.13.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 13:31:03 -0800 (PST)
Message-ID: <638a6e97.630a0220.f56b8.9260@mx.google.com>
Date:   Fri, 02 Dec 2022 13:31:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-24-gd5ba85d6d8be
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 2 runs,
 2 regressions (v6.1-rc1-24-gd5ba85d6d8be)
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

kselftest/next kselftest-cpufreq: 2 runs, 2 regressions (v6.1-rc1-24-gd5ba8=
5d6d8be)

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
-rc1-24-gd5ba85d6d8be/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-24-gd5ba85d6d8be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d5ba85d6d8be7da660d4ac25761a48c74ade958d =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/638a5f13f7f51d81992abd12

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/638a5f13f7f5=
1d81992abd13
        failing since 45 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/638a603c40f902a2e82abd12

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/638a603c40f9=
02a2e82abd13
        failing since 45 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
