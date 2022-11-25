Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1E46390E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 21:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKYU4r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 15:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKYU4r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 15:56:47 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43662FFDC
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 12:56:45 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so8652910pjk.1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 12:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xeENbJ2SLdCHb0eOIGfxunJtDPoMEEv/fdD9FKw32Rk=;
        b=QbHZvYjuWXgowAFWXlK4EXYc8nLRqgj3oMxF4VoFFMMBHrNNsqh0aOLB28Wu9aOskV
         lXKiNoEse3/l9H56OP574VtQH2af0hir1u38uvm1mTcKWIBr08tx+W3sIeDAJC2Okr9p
         pqynJ3rsA7zF4kTlYSYj6PuBXpPFjL3tal6b5nfO+bVXQBktm8o24np101sFJzwpivTR
         XgVOq7UHtxgUx5/XrCb5mfxabmOkPKYmt1USF702x9V2qFwsFNaXCf0CqmXZmVAfP2mX
         zHvYjbktGdP11qoXNARdbRQemy1ULlbi0QXc8Wqbt9FzPLkwLg+MRT7hQsd6x2rb3Jm7
         0kDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeENbJ2SLdCHb0eOIGfxunJtDPoMEEv/fdD9FKw32Rk=;
        b=f7Jc4FRh5SbfEYhsVZpy3qVw3A2jl61jNJm7iGH/vWYJbEt90jwYkZBQc1OoR02jSw
         qzl4Z+PHyA/MR94edNq1e6LH8Xx5D5ynDVXim3HZKe4J85iNax74q30LVHZT7PvbUrek
         CczduzkI711XZKWaa8QJAwxjJIFRn+6usQ/oRo1JlYyDXUAzjrutC3JuOQhc38hQHw4R
         xDoo/TJhGUvctC6TRPR0/zBe/j04h1V3Fm9/mQUWJKU5Lxr70x3VtBJAq/vQkT8LiVyf
         S1y/GQJWRhmdS69xaPpCA0kKVsEV6iWU/K5EwWFNU4tB/OrpgI0eW0hWDORNwnIGqAJb
         nSxg==
X-Gm-Message-State: ANoB5pkKN59sd7BpxlVW0k3OAUKOxR+jYktAl/KWPcuDXiK2ucLqTQB8
        b32gv8tXqtAlKVe1WMG6GLRzdQ==
X-Google-Smtp-Source: AA0mqf6vZyR/fA3zvbmw9zQJ95dBsIq2NRtK33l2Im8u3T8dpp0EWUnvNz9G0Sg2cfYh4E9v46gxow==
X-Received: by 2002:a17:90b:2316:b0:20a:74b8:ea2a with SMTP id mt22-20020a17090b231600b0020a74b8ea2amr49934872pjb.73.1669409805303;
        Fri, 25 Nov 2022 12:56:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902d2c800b00189327b022bsm3802974plc.286.2022.11.25.12.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 12:56:44 -0800 (PST)
Message-ID: <63812c0c.170a0220.5cb27.50f4@mx.google.com>
Date:   Fri, 25 Nov 2022 12:56:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-23-g00dd59519141
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 2 runs,
 2 regressions (v6.1-rc1-23-g00dd59519141)
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

kselftest/next kselftest-cpufreq: 2 runs, 2 regressions (v6.1-rc1-23-g00dd5=
9519141)

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
-rc1-23-g00dd59519141/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-23-g00dd59519141
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      00dd59519141398120b4baa65c0ab4b67dfd3e19 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63811e0ad9a0c5b4722abd21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63811e0ad9a0=
c5b4722abd22
        failing since 38 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63812160816d74e7712abd21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63812160816d=
74e7712abd22
        failing since 38 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
