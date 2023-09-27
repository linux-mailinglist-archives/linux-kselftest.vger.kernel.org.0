Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24877AF96D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 06:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjI0Edp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 00:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjI0Ec6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 00:32:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD705BA6
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:17:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c60f1a2652so45427535ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695784621; x=1696389421; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=veOXpFTU1W2fvGnEMCuqBT0oQsASKEfB5SdgHr4xeVU=;
        b=d4R8fuACXLdiBZNuKhtbwdbQHssGGit1OLMoB7i+4E8P9YXERrYMpQ3zPoOjLQmS9D
         +Zn1DYNpQiVL9e9bbO6ehiwZRGelBUbKqFT542CQcAns2/fXWuLilucSJ7/mMh2gT668
         43f3K/PIaCtV5u1kqrndjoMSE3rdxtkN64wO4hG0DbglhQjRYmKt9b3q+N/EGPw+2fXw
         XxeMZxO/fNO6Xjk4MK0ZaKPGhGRTyO24O/FEcVCH/HxG4JdoUsIfQs3SdQ/yjuT7d5vw
         QsOdvC9qgSjBsc5GnzTYeNLinyZAGz3SoOzZp54pQ5CZTMbgJqVKn4F5nNpGHtn/zNCp
         fIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784621; x=1696389421;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veOXpFTU1W2fvGnEMCuqBT0oQsASKEfB5SdgHr4xeVU=;
        b=ir2IL7/uvzAppsmiTmtXYqmqqrAa18ZhB4Vpb3o/VQRePhrJwNOpStu2fT46URTQ76
         PPcv0MhOpheQosRKXK0dBe1OfEBlCcgNhQ7F9zH1RxGt1Ld2TzpDpijaTCwmcxrF5mEg
         kqyOD6RamQ7mVWomgMUynqsAWx8x/Pjx4PXaFTBscms5Ui70Txhvad9FoJsjA1zAbUzw
         Ub3En/Y5d2jdl6QUy/LlWl8ustK/3drztOtpYM6Sr1HsA5HSYbKvyIeWZUnmfquPvzPq
         av8STvpBsAWRVFRWl4j17FNNxT239vtzHiCk/M8YgjhrV5+2cbcBurS+ReidmCB/2oLR
         QAeA==
X-Gm-Message-State: AOJu0Yz6D1fRUR2lFJliHUqSU8lYrkzAf3CtUVW4DWG1DERRZ+IxIrh9
        ISXIOHpOsC6kAN+waS2SYOb/9A==
X-Google-Smtp-Source: AGHT+IHDeQPRv10OXYo0PuUkHmdOUBZDvm26QSEUmJ7QZCCunGeiQnRtjFcR+tanXkv3qv+bSquSFg==
X-Received: by 2002:a17:902:e80e:b0:1c2:193e:1126 with SMTP id u14-20020a170902e80e00b001c2193e1126mr1346834plg.28.1695784621215;
        Tue, 26 Sep 2023 20:17:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001c62d63b817sm2617626pld.179.2023.09.26.20.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:17:00 -0700 (PDT)
Message-ID: <65139eac.170a0220.ee481.adae@mx.google.com>
Date:   Tue, 26 Sep 2023 20:17:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.6-rc2-2-g078a2ead544c
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 7 runs,
 4 regressions (v6.6-rc2-2-g078a2ead544c)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-cpufreq: 7 runs, 4 regressions (v6.6-rc2-2-g078a2e=
ad544c)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-2-g078a2ead544c/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-2-g078a2ead544c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      078a2ead544c56fbe6a3bed8cc90b5151a328b81 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65139790b9d95bb7618a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-me=
son-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-me=
son-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65139790b9d9=
5bb7618a0a43
        failing since 341 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6513912e97a6dd6f498a0a44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6513912e97a6=
dd6f498a0a45
        failing since 344 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6513986c3e580a7d038a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-su=
n50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-su=
n50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6513986c3e58=
0a7d038a0a44
        failing since 332 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-8-g94fea664ae4ee) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651392ccd11cf0c92c8a0a51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-su=
n50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-su=
n50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/651392ccd11c=
f0c92c8a0a52
        failing since 328 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-13-g67c0b2b52916) =

 =20
