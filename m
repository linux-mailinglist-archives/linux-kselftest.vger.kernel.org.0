Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2762C929
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 20:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiKPTrz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 14:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKPTrz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 14:47:55 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8B2A413
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 11:47:54 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s196so17703499pgs.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 11:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tvKhmz7tEx1sw0js/pCff0FtSqmdypThBxQXDIeBszw=;
        b=et20udFhpVL4RkJYi0EelJjpTLOHVaRbAe89W1nvgUXu0sIfVxTnFI2lpzG8DkgTwg
         fi+DAeenLlRGsoSPaezbAn+xIUtJ8sMEBqNSajDLVfb72FfjxocgVXM9j6eVt3tpY/Dz
         yChwPl/WA4BwpCvY6ZRclZ7IsVbi+AlX8IpNItFV0bYNrPzaDiEA8dpXJ2tSHJQQY4RO
         QO0KeoDpm/6unvk2peP5VIPfNsjGVOM9P7ipvUAmkZ39aEZ9LmiUVb7hVp0zX+Y2R2MK
         IKT3sPOL+O6JWCnXec27X2fLWVj1SYcmFZ0YQsxZwOYZkSqTjJUb3CaxGKAczr8YpJYa
         T7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvKhmz7tEx1sw0js/pCff0FtSqmdypThBxQXDIeBszw=;
        b=edrbAV8PY1M+383vfh9kknz7aIfTWQENhDjHd57xxG1neZwaIp3vCuCJvDeuaHkgvX
         Kyy3bcpUfc6PoLlaVLx2DHbxAnEpwYoZUnu0H31BZB96sd0nXAet4lT9Wen9zP+0NPWq
         xm54Jouqb87/xBVfkCtKBw8HkZutcdoo9iIRfuIxQlVUoTgRdV9A2JucQ2aeOVv1zjHh
         jSUaZ1Y5Q7l57MKMbhdH9nl72BLcVPHdbgriqzRkWsxGFX9yhUPCv2no/Fo6dkZIXTNq
         DO4lOZjzgAJjOVO0LGBuTDyRvp3tUPQXLNa1hvAQxnJKA8wPDhG96MjMyYQ7rsgOut1a
         xmlw==
X-Gm-Message-State: ANoB5pn8ElHYhYT40cuO0blvgsS+70Xl8sl8OYYQ21IuvbifL51bFIF+
        06aRETjDRdvZ/XK4+M3aCTATlQ==
X-Google-Smtp-Source: AA0mqf4us2j9DTj0k8CvKeAYmqb3dnN0R29jfu7I0Xw78IQbv+2AS/tulffs4U6cB4gBCYwRJdi/6A==
X-Received: by 2002:a63:4d43:0:b0:470:537b:c39a with SMTP id n3-20020a634d43000000b00470537bc39amr22062040pgl.614.1668628073802;
        Wed, 16 Nov 2022 11:47:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g2-20020aa79dc2000000b00561b53512b0sm11303258pfq.195.2022.11.16.11.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:47:53 -0800 (PST)
Message-ID: <63753e69.a70a0220.38417.24d7@mx.google.com>
Date:   Wed, 16 Nov 2022 11:47:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-17-g2dfb010d2aaf
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 2 runs,
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

kselftest/next kselftest-cpufreq: 2 runs, 2 regressions (v6.1-rc1-17-g2dfb0=
10d2aaf)

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
-rc1-17-g2dfb010d2aaf/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
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


  Details:     https://kernelci.org/test/plan/id/637531858416612ca62abd04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/637531858416=
612ca62abd05
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63752d755d6f8029942abd13

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63752d755d6f=
8029942abd14
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
