Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C4B7BF2F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 08:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442156AbjJJG07 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 02:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442225AbjJJG06 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 02:26:58 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477A69D
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Oct 2023 23:26:56 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso5571684276.2
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Oct 2023 23:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696919215; x=1697524015; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QFnxWVLyuNAX+fwR6Xo0OeeUeVg9behpFpXUTlogJsw=;
        b=oZ+g64KITQUQ6iTO7d5ggqhEgzgDHYd4YMFoS7fAZbILAhrhcjMyM/ZIoie4R718Ur
         +hJFDmdpwNgW5VvVbQBskwptCDRooC4uj6Qg/gETWiCpVVzFKzMcIpZstuBSsMYvn8eu
         WlwNiHlUY0PeKzoRjzHoYgwghmDxNCmJQDvMAh/TVJVyU7foRpJU1cNwxOGMe3nyz/L+
         hnsFmthdOBt/+Crh839Vdv3taQ2RUtAnbnJEix1TdjCG5Tb+LpmGnaB7unDxcvSYFdB0
         YZtW8oGNkvNm395nfN3lPHpofmQUYNu92EjFj9/iUdUozkw3fvmRDSAdbB/QXKDwF9zq
         s+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696919215; x=1697524015;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFnxWVLyuNAX+fwR6Xo0OeeUeVg9behpFpXUTlogJsw=;
        b=O8IJp9l/hs28Fl8fVZ9uMqs9z3SWVjpPhJHPAVpd5SaGL3VeWr4i7108VH/J/312N4
         OVFT9Edy7Ri1ENVaOnPT902wbNrvetUJPHY9syHcIQv0oxcAQpJv0ee9QDbwkwYulmeO
         ew5HECHgQLv/mXWV76JS1giwhMH08D0E2/3kOXq/IKLomROd0tohZNZjddigxB8qIoKl
         kdw7WoldywNnqogCD2o9ckiUDb8Cu4LpQ8cXcjxXPmy4U23NBTfNQiCFxSrfRNxNKcwr
         lHFE+vtnx+8THeaybQuPMZAciNdjulsp2znK/6jTWM3qaYF0gPKRDYXnkOvMY1xut+uV
         H1vg==
X-Gm-Message-State: AOJu0YxTvQtV/njA0xfpZLQ6qjsBLOecFfi7rKEXY/u2I2VURPzjXsYZ
        oSs2vW8WBt/858msU7Ho0cIhHpwf1E+8GVsvSrzT6g==
X-Google-Smtp-Source: AGHT+IH6lntZK841Coni3FNAEDi6h5AAUWKFrxijQnmEOtP8PO6369GYNXB6GwMNyBmfn1GqecNyjA==
X-Received: by 2002:a25:344b:0:b0:d9a:5244:32e5 with SMTP id b72-20020a25344b000000b00d9a524432e5mr1285548yba.35.1696919215387;
        Mon, 09 Oct 2023 23:26:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q24-20020a637518000000b00573f82bb00esm9340535pgc.2.2023.10.09.23.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 23:26:54 -0700 (PDT)
Message-ID: <6524eeae.630a0220.b2734.8f2e@mx.google.com>
Date:   Mon, 09 Oct 2023 23:26:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-18-g2531f374f922e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 3 runs,
 2 regressions (v6.6-rc2-18-g2531f374f922e)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-cpufreq: 3 runs, 2 regressions (v6.6-rc2-18-g2531f=
374f922e)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-18-g2531f374f922e/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-18-g2531f374f922e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2531f374f922e77ba51f24d1aa6fa11c7f4c36b8 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6524e59941eb7e28c5efcf2e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-18-g25=
31f374f922e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-18-g25=
31f374f922e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6524e59941eb=
7e28c5efcf2f
        failing since 354 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6524e5fc49aca55061efcf00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-18-g25=
31f374f922e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-18-g25=
31f374f922e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6524e5fc49ac=
a55061efcf01
        failing since 345 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-8-g94fea664ae4ee) =

 =20
