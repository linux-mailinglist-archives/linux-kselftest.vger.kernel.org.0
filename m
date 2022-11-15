Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1288629BDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 15:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiKOOU7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 09:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiKOOUr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 09:20:47 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBF92A260
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 06:20:46 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 140so12775672pfz.6
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s+K920xhdH8nLXNNYn/9VzI8wPGPRgzPlfKdGEhYoIs=;
        b=68VHTUNQEDYGtXGkNmopdjQlVu21DEKig7BfzkBR94L44fdfzeDkulXOLB8VdT5ceh
         ZhsvhVimls1xlTic/DYc5/pPzGZDL2ZTq0fAyHL4B16YMcOzjX/NN5tQBR8NVUtqgLiG
         3j4enuASxy3PwbAifAnV955Iw5F0QUn6+lAguDHuiX+IynUTN0pGj75rgRvfGsPc8wdD
         fJqYmS/o1hO086denPfYnP+vKufoL7Zh9hK1UQgim9UZ6MKrG9NjteQ7eK0hMbKhk89G
         S2g3MnraN4wRWKHDc6vUSStT1QygsonKSYJqcgpQUhROEpZvw5D1nWnIaDdLeIW8Vrbv
         2wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+K920xhdH8nLXNNYn/9VzI8wPGPRgzPlfKdGEhYoIs=;
        b=ZuQcmpBHpo+DqZFnqL0klHSgWNblPPjWmDONwHTj+ABt/VSWjk4oivPijprYxWo6WV
         sKomTxOvn6KgNxd1M+vgMaDypdzUKu6BTGfMrU9Ok/Qus5J1Uieu2gXbelWe2E51Yg0A
         HoiPKRfS9ujvKemXfTgAdjd0TfIUpToFv/qBENH/g7BMu9Sv0NQOTklxCKSPCa1Mbn+N
         hi1lwBsWh2X59T0nWPGcvSxNf190KZ2qhnio5+anqwqu/rKtwqENBU/hrkn1stqX98So
         8ewrQvNdId1Ng0w1rkNBuORzKxqUDwmD5oEBauvBlARuP7OYbKfKpp19o7gBRKnNhMUI
         c2Bg==
X-Gm-Message-State: ANoB5pmu71UVV2A/RVdJ9Yiai3ygMQMmPYoJrJ464wlSMYau8tUB0tD0
        ZE5+ES+GUHE/mN0tLv/K7GepaLo3BjW4u087LZ4=
X-Google-Smtp-Source: AA0mqf5EACtdiMyqmcMijblNqpJ/v7m270IDHlEf7wTACWD8KkW9lwonyFYiOHBBRzA84MIhndU+pw==
X-Received: by 2002:a62:f245:0:b0:572:8c05:6e2c with SMTP id y5-20020a62f245000000b005728c056e2cmr1356083pfl.85.1668522046287;
        Tue, 15 Nov 2022 06:20:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b00177f25f8ab3sm10015446plh.89.2022.11.15.06.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:20:45 -0800 (PST)
Message-ID: <6373a03d.170a0220.b5033.ed43@mx.google.com>
Date:   Tue, 15 Nov 2022 06:20:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-15-ga1d6cd88c897
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 2 runs,
 2 regressions (v6.1-rc1-15-ga1d6cd88c897)
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

kselftest/next kselftest-cpufreq: 2 runs, 2 regressions (v6.1-rc1-15-ga1d6c=
d88c897)

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
-rc1-15-ga1d6cd88c897/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-15-ga1d6cd88c897
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a1d6cd88c8973cfb08ee85722488b1d6d5d16327 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63739262604aabc640e7db81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63739262604a=
abc640e7db82
        failing since 28 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6373935237b1359068e7db4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6373935237b1=
359068e7db4f
        failing since 28 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
