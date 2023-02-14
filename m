Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0CD695764
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 04:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjBNDYH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 22:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjBNDYF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 22:24:05 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6475C196AF
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 19:24:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v23so15712717plo.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 19:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ik++eVJo/Lhfl2bkIlLH8q4hZ73wsK1c225XRqfBCYk=;
        b=3OYOKhjUL+b5ATEtuY6q+7SnMUwGp+hrS5oRaM4vXpoVP1T1phPI+Pr3nRh2f9o5k4
         eepoMwqbxE+vPf3/uCIc4k+lC8wclhHAdbuOSm/o+lNP5Ao+VQnwil/PEzCyDOvxs8BG
         f828HFw3YMM8RijiIO3Fi/C/1fJMeqd4eA539guP6JO5dfBogii4P/iwKpEyJClMRnVo
         yshbjSYPQWn2HfwGkIUUETJrkyw/x1jldF+pXMcLuJSLNnhRs2wsFk0ZgKvuhgfsrmgH
         PJUqFGeWLQXoaV71NqJKBn/sMBNWgqjyizclzsv3r771+9pLD7SbZBEO2xin2cA+P/8V
         MApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ik++eVJo/Lhfl2bkIlLH8q4hZ73wsK1c225XRqfBCYk=;
        b=hbRDRbvc3UW0QwafyFDAe/EAWLCSidrMbB1QfaSEzPJoPhU+79WvMPX7PRFT9FgmCg
         ezRGqQH7gB6Jv1BH9MSJGGRKNVb39EKDE1HB109s0zdzmydkd/6SNRvYvmlX3AH1rYrV
         t6f/EXCQEAxeZbjwDYIFQcGJZt4nxif9BTAygOd6vMJQ4ucSJjskyMMo48pxTcSoxOzb
         FOyAsExzRQia/QLb240pKtXD3jIZx/h5UBvQzdtJ9iWDS5gTypct9TWJQlnYo1igRheM
         Eh3DD2PdSMcD9d2hin9liW6EAS/fX60reHhItiY4XsZid4KggwIgFLpSXaHb7tMVvP/E
         uTyg==
X-Gm-Message-State: AO0yUKU2isALowR6nUdBlfgUt8RPedjd7kG3lcyJ+AGDnDv7oYZpLqoL
        wV4khGfAiLO9qsB3pXVby3PS7g==
X-Google-Smtp-Source: AK7set/dtxDgZhN5sNhOwOom0LNagR5rc+VsZqQn5e5pfQZraQpBSqFFTX31LJE2JmyM4+o+QcKefg==
X-Received: by 2002:a05:6a20:7f81:b0:be:e450:69b3 with SMTP id d1-20020a056a207f8100b000bee45069b3mr1209390pzj.0.1676345042978;
        Mon, 13 Feb 2023 19:24:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f24-20020aa78b18000000b0058e1b55391esm8829605pfd.178.2023.02.13.19.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 19:24:02 -0800 (PST)
Message-ID: <63eafed2.a70a0220.a1dca.feef@mx.google.com>
Date:   Mon, 13 Feb 2023 19:24:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-39-gaca5a0944c30
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 3 runs,
 3 regressions (v6.2-rc5-39-gaca5a0944c30)
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

kselftest/next kselftest-lib: 3 runs, 3 regressions (v6.2-rc5-39-gaca5a0944=
c30)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-39-gaca5a0944c30/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-39-gaca5a0944c30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      aca5a0944c309c56267b0c1d001aa999ddb2fb1e =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63eaea6776f7b019558c8639

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63eaea6776f7b019=
558c863a
        failing since 49 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63eaf29a2ed0b42c4a8c8717

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63eaf29a2ed0b42c=
4a8c8718
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63eaf1876345625b4c8c863d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63eaf1876345625b=
4c8c863e
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
