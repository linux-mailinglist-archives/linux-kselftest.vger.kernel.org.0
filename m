Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CE37AFA3B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 07:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjI0Fot (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 01:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjI0FoE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 01:44:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F4759E1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:16:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso7915187b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695784597; x=1696389397; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bYwADkEvIUUYNyAnGTuI9tDS8vShjoAUjFxCGyYWyOA=;
        b=E5wJoQUOKX7SSBh2bHkzyKJKAMhYZfJy+xX3u75UT7ONbAVJFu/Vgsku/1bvQZsGio
         rkvXDX6drxWhrlFk0IDJse3S9RC7fJ29KIhdD+X1svvjdMnr0YqbDr0ork4eDgcW82n5
         Gv4EsQfnmQcURXRQ9BjAJHmFNukf9C/v3J2rfcY2dmqbNoQoxkG3EkYhxHCLH73rNqfF
         qvRoJq7k+XBh2jdXFUZbm4Kii60v7ZRNujm03/CHtVSoDioweEFctGwGOicmjIX801SN
         coETWVu8HZJXOhdAecBNaheWvQ5YAl3n6Xg64zMq0339h93w7eluqGbM+kLVkC+fOL2f
         02nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784597; x=1696389397;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYwADkEvIUUYNyAnGTuI9tDS8vShjoAUjFxCGyYWyOA=;
        b=wKxNenN8Mrey1zKImlah0t01WP7rq9w9cc3nmN9gcHGxdlK+iZ0329wTv6nf2SwU60
         LA+vJvx+dQAU0mOzWF1xizH5bfLGJxNLxKjeBYIIB4JPONZkS4ML4vuv0L8E1i+Nwp5Y
         DgjCe8+Xq2yS06SiP4wOHZ27jsA1LDF8ylMaRGAVH9ymb3GTrp8LlEqqx+Ncmoc5CYv7
         Rzi5yu8cGEKKKWZouQeFhccZCn3f05LE2EsxqRK+MyhVaPNjQta66eIY7B5tRmq2zt6v
         +mllfmb5cba1osTFABzjworfx05TlDKggANnaaJKZPD0HJRhmvFFzX0CPEi9oqvyon5H
         Tp3Q==
X-Gm-Message-State: AOJu0Yzn7+0FC+FYX4nQfkZUhxHF0QN7f1tVoxaEZ5XgP8yEyuLst3lR
        kQGeQV5XUXZ7tlBcbfRINLmM/Q==
X-Google-Smtp-Source: AGHT+IGzVKp2EQ5x7ewkhwOqk0rxbLkG8Srt7WdSdsX0vUk7vDzzebMPj94AAjQc70Tr+qkhfpJVFQ==
X-Received: by 2002:a05:6a00:1a4e:b0:68f:f6dd:e78b with SMTP id h14-20020a056a001a4e00b0068ff6dde78bmr894804pfv.17.1695784596921;
        Tue, 26 Sep 2023 20:16:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bg2-20020a056a001f8200b0068fe76cdc62sm11059645pfb.93.2023.09.26.20.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:16:35 -0700 (PDT)
Message-ID: <65139e93.050a0220.e599b.f80b@mx.google.com>
Date:   Tue, 26 Sep 2023 20:16:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-cpufreq: 8 runs,
 4 regressions (linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df)
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

kselftest/fixes kselftest-cpufreq: 8 runs, 4 regressions (linux-kselftest-f=
ixes-6.6-rc4-1-g6f874fa021df)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.6-rc4-1-g6f874fa021df/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6f874fa021dfc7bf37f4f37da3a5aaa41fe9c39c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651393cc35be0e6eee8a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/651393cc35be=
0e6eee8a0a43
        failing since 331 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651392c5d11cf0c92c8a0a4b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/651392c5d11c=
f0c92c8a0a4c
        failing since 342 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651396c8799f1d86fa8a0a4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/651396c8799f=
1d86fa8a0a4f
        failing since 330 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651392b79480d42f908a0a47

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/651392b79480=
d42f908a0a48
        failing since 273 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.2-rc1) =

 =20
