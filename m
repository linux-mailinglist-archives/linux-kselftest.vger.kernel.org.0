Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB507C914E
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Oct 2023 01:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjJMXYa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 19:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMXY3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 19:24:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F42FB7
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 16:24:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ba172c5f3dso86405b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697239467; x=1697844267; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Am/GRxZemjOJvG97/3Xi1c5RIZ2AmdhnCB+C/yvoeA=;
        b=yL8Pj+pT03bX/iKYgAm4BcWsKqEFbtDcGeoXMG0U8wxxN472TO5241jN4wds8mRHXU
         QM4BujTbJyi3vZO4HiZ4PD9J3vsFPuVRvO8uUPaeC+HLQ1XXvJQhXoGMG3AnzGMS3jGk
         VldtvqPxFAnTsy1KZAE9NSnGVw6UKq2RUnjD3fnf/tUMCJKYRVylbN4E3//elAjqQhr6
         YopupygoFGf/9EOY015oVM2VV0KuXamlWC2LiqBglUGmIGjzzuXmbLHRnGIXWM5OElcz
         9AvUpfXTqcY2eUpKf8WPY6E4pC4EQKE1HJ5k6WyPASc1d9GjtzZCTUvAMooijkRo1n++
         YUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697239467; x=1697844267;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Am/GRxZemjOJvG97/3Xi1c5RIZ2AmdhnCB+C/yvoeA=;
        b=R7QedUnLxQw/S4wCgz4w+Vfc+/9sfrOPVmBiAJ0qVkZlolvlqiJGsyvnI8qVRhWxQ5
         kJkGYoHAq08XJcBzYGpoYyMWacHyvSp7A3TkIyIjcuZmmhNhsLXCSuP/8FOsc7naJ0oP
         k9BbJvYauzIsuCiLrZvU2+vnh96rgpUeEvIgYTiHWC4lR11rY0APq4qejbJWgnlZTrEu
         yixc6O21iKtArRWHy+5z1Pawo5iGrzbQFpgEWU8xC/U6aND0MJ5aoD/SqVV1HjrUQXIn
         4w/vMZQxvBkv9IhxLigaNBY0oMQO4PqFH14Nnaex2nyvyR6oiMRYTzUNT5YihA8NEFod
         kU0Q==
X-Gm-Message-State: AOJu0YxqboIUTP4QNIo4cvrFDRutM0nnC3F6S95/MIU6ZYYhRJf3OTj2
        F/U6SGFj8jludUU+4sJJnI/lUQ==
X-Google-Smtp-Source: AGHT+IEi7ZziBSWg8+s1b698idegTosqPNrhQ5kzHZYci7rVgIRDaK3r+vhaulNhNv5kURk+R1jsXw==
X-Received: by 2002:a05:6a00:398d:b0:68a:4103:9938 with SMTP id fi13-20020a056a00398d00b0068a41039938mr27880928pfb.0.1697239467559;
        Fri, 13 Oct 2023 16:24:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x5-20020a056a00270500b006889511ab14sm14001799pfv.37.2023.10.13.16.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:24:26 -0700 (PDT)
Message-ID: <6529d1aa.050a0220.d6943.8903@mx.google.com>
Date:   Fri, 13 Oct 2023 16:24:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-43-g508934b5d15ab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 7 runs,
 3 regressions (v6.6-rc2-43-g508934b5d15ab)
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

kselftest/next kselftest-cpufreq: 7 runs, 3 regressions (v6.6-rc2-43-g50893=
4b5d15ab)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-43-g508934b5d15ab/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-43-g508934b5d15ab
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      508934b5d15ab79fd5895cc2a6063bc9d95f6a55 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6529c7541c18548c20efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6529c7541c18=
548c20efcefa
        failing since 358 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6529c5439cf00bc96befcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6529c5439cf0=
0bc96befcef4
        failing since 360 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6529c6dc09c08e8b90efcf39

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6529c6dc09c0=
8e8b90efcf3a
        failing since 349 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-8-g94fea664ae4ee) =

 =20
