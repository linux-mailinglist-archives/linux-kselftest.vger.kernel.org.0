Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B287D13C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjJTQLn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 12:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJTQLm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 12:11:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427F7D57
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 09:11:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9e072472bso7480485ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697818300; x=1698423100; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FRZ5KsYJqbzMnk4+1n6yJNzMBPAs5VI/7aZAuM8e9PI=;
        b=ugYQGDkpHm9TLb+tBxFWGVYIPe5WGe1d3POMliK9MEGkAs2hZSs/if/dtHnh+7arA/
         N8LP5bZ9kdiyWTHTw8S7Yy1bVOX93fv1+Quf4i8i1NRvgXjPdcCwBl8oENahRakqEJDR
         gqxUXg+xUcsbyoL0mYH85o9tqPo2Dai44am8fyBf8tfh6SOEOEzvEtqfK+KdFKvVyFXf
         einw6CucyPqcDOV6korDr4dQGtlEKDdhOyKIGVWWbiEZ3udxJ3cB2sU+1RNi3EYu5zuO
         Sl5K+SiHgQm+umZL8BBVjBGw4rOFvcyGNZPhrvqSQ3oLLRHmpnJhcQX4p43DkkYi0FOS
         yMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697818300; x=1698423100;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRZ5KsYJqbzMnk4+1n6yJNzMBPAs5VI/7aZAuM8e9PI=;
        b=MaKyR1QNYMH3/FHyvoYoy3kq7/ZXn0f5dLwaFPgtMLlhn8FRfXGgRs8NJwSYsiTpT/
         09qDOPuyhsoEoSeVb713e5qV1Z8ceZK44bsE4zzNRlZPgpLHxqNsGmHgbSJH/JaeUHcE
         uD10ErtX1GaBQ1HbNL/46frrS0RU99n14ovQzvGSeH6X9VZ25N/U6znODPLGwQUxH2S2
         xL2jS/+1W3qJKI1zlATuDpIOVuzHU0uoGms2/Q5mbCdMzaxeufNe49q80RSgsgDPJUwD
         ULfjEgHl/Xxsm3IuZi6C1XuG6HqZYKH4BOfEegHIMkgPrpQ+WhIoU+dFj3PCAysUhtxP
         NS0Q==
X-Gm-Message-State: AOJu0YytNlMHHgKKb3AsOSRig8r0xTS1lxk9LDqVQ29vV/2IvvF5uwnt
        rJioQxKbq7/LmiWcz3EWlCPmpQ==
X-Google-Smtp-Source: AGHT+IFHmx5+i3Ih7AVP5Yydo9YmftykA+FPtUAO8FqN5nuT3hpVWe2zEgI+4smCOxgCb9QCNQiO5w==
X-Received: by 2002:a17:902:ec8e:b0:1c9:dfb8:a58f with SMTP id x14-20020a170902ec8e00b001c9dfb8a58fmr2918439plg.20.1697818299559;
        Fri, 20 Oct 2023 09:11:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ji19-20020a170903325300b001c452f827casm1700784plb.257.2023.10.20.09.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 09:11:37 -0700 (PDT)
Message-ID: <6532a6b9.170a0220.61a24.5ee1@mx.google.com>
Date:   Fri, 20 Oct 2023 09:11:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-51-g5247e6dbed00
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 3 runs,
 3 regressions (v6.6-rc2-51-g5247e6dbed00)
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

kselftest/next kselftest-lib: 3 runs, 3 regressions (v6.6-rc2-51-g5247e6dbe=
d00)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-51-g5247e6dbed00/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-51-g5247e6dbed00
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5247e6dbed0041147a83137f89cd45043301de5c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6532992d69d113fe83efcf05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6532992d69d113fe=
83efcf06
        failing since 367 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6532a2c12f43abecb6efcef8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson=
-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson=
-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6532a2c12f43abec=
b6efcef9
        failing since 364 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532998b640d8c7964efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6532998b640d8c79=
64efcefa
        failing since 367 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
