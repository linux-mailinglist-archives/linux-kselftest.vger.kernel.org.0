Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284BF7D0F8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 14:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377235AbjJTMUv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 08:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377028AbjJTMUu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 08:20:50 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014B4106
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 05:20:48 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7a67ebc2cb3so26936839f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697804448; x=1698409248; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0uQmaHEZ0krQzgOxqjU6yHRT9UwudlOk3Xqp5PzNxqw=;
        b=oFMebFiRsP9C9S/ROxxeSeogDPa3irUKE1swjiILtsPJOA45/tkVpQJpF2hioIa5kv
         UmmiCS3x2h4orxSRcMOyPj5iU80EOfRAgVCo2jUEr0iDcgnM6gpfxGkJb27w71r7DAQ0
         vo5vhaymcCUpFvebM3eQqqb64Fs7na1UHiGYm2XC3aLKVYVbDnfQadWHIYHM9Yfm/D/I
         gBTGKqXTtfu7Ly2JM5OX0cpTdXSlWvRQswonkTUrd7Wk9aeYnWRe92hZksehZeOL7nMU
         id3kZE66I7CNr5g75jdEzsJ6kDbGzz6rR7xkyxoG4WLuWuau19cMpAmld8W0zJYimr9B
         6l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697804448; x=1698409248;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uQmaHEZ0krQzgOxqjU6yHRT9UwudlOk3Xqp5PzNxqw=;
        b=waOHrwFo8UiCQDBpwRgcbLpE17lPtH3txTBT2BleH1ljCZfHgJaVgBPX3toe/UVE3W
         tXdzdWDy6WAJVA7rgcp3+dczZeYD0M0CF+k8+GVXyooz6BpFnhtA0KhxBV+sV7m/MJHI
         C8M4dZ0HfLT5sYhxK5bA1pYwpyTX01k5OIqWuIJqJQgUT1OCq4Wl3hfapPu2d3EQYtbr
         y7jAdUGP+lRNNH7dsiNz0ejo+O2fHTxlBFzaz6DrMgmZxNer275abE0Ne2CRlsy7kOH/
         3ZCflgPF0f/cLT6DjLExMrGx2pmW6dEFxGjrR2IBSmCRUgAn464SeMN6H9jhy3FMoMPw
         Gk9w==
X-Gm-Message-State: AOJu0Yxku205ZvaFp7NZ+t0XqDjzCHYyYKAFjExOULZbyupQ7wRKk0K0
        K5rz37kXDu1p8x+dsz0LuYUkB/UeiG5SAu9zjAhfrA==
X-Google-Smtp-Source: AGHT+IFVrkvpUwkqF53YtdsIb1QOsa9Oz38s5qw5URx05QlIYZ92zr9s2PuhLCOmUn1ukWDb254ONQ==
X-Received: by 2002:a92:ce92:0:b0:34a:be3f:9ee6 with SMTP id r18-20020a92ce92000000b0034abe3f9ee6mr1818807ilo.12.1697804448311;
        Fri, 20 Oct 2023 05:20:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j33-20020a632321000000b0058563287aedsm1322786pgj.72.2023.10.20.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:20:46 -0700 (PDT)
Message-ID: <6532709e.630a0220.3548c.41e6@mx.google.com>
Date:   Fri, 20 Oct 2023 05:20:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-cpufreq: 8 runs,
 4 regressions (linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6)
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
ixes-6.6-rc5-1-gcf5a103c98a6)

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
ux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      cf5a103c98a6fb9ee3164334cb5502df6360749b =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6532669e9bf897e808efcf05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6532669e9bf8=
97e808efcf06
        failing since 354 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/653264306c819f477defcefb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/653264306c81=
9f477defcefc
        failing since 366 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/653266049e888714cdefcf00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/653266049e88=
8714cdefcf01
        failing since 354 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6532638317e87f5732efcf04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6532638317e8=
7f5732efcf05
        failing since 297 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.2-rc1) =

 =20
