Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C3A610E50
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 12:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJ1KXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJ1KXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 06:23:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9661CB528
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 03:23:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c24so4468364pls.9
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 03:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B24XlwD51TmoFrFXW6JrYM84A8Lscs3o6FOtC/wGrM8=;
        b=6KN4Dh13+MN+X84Hld+UjI5yYNdor6bpBVnP6jGpdxTaz5GL10Z2npmJGoGeI+gsYz
         GLwF6o0f8C789n4xl5pAFs8sumF9eSB+Qn3Fwoe2/J10UBmSHHJgxaray/FYeP7WFz2U
         r/YLw+H9asRgP5Ko9cUHo3Rm73xuI7CpnSF7MN5jif5I9UnK9jekZtywHS3hKcwGnM2f
         NKfsiIYOd16We4rtZpbujEo0NUN+I1jfLGJzs8R0PLp2KzbptTKykXl8su9l8V4nYygJ
         4sMUOx5ew8BcC468fjU0SLy328vu7UxFcFY2SqzXUwGh/IjBvLE/kNYaQem3qb3KPClr
         nbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B24XlwD51TmoFrFXW6JrYM84A8Lscs3o6FOtC/wGrM8=;
        b=VjAN842Uwan/KvG8BuDQ9s1inVIuoQimmsDk+fwGLQFxC96RRVwCuX3hs9wVQOFV/i
         5grcfQQAn7hsJ6WSemnOQU5KKzTpxz9BYShR1FHgmDENg/q8plQHvak+P3Jt0g27TiLB
         MWHe33WZ/1P8x9eQskj24m4QB/HCuTWEX6S6CCAc0cNwXs/j5gd1cKzwecy6HAjOIbRr
         OE4OUbxN//28NtsgcXNM/c2hyKJKFviARPMpSv/psbMZhVoWPLacxTBtMuI5uDNOYm2e
         jIrZ4mFGcKVNTICUtebE0rWq8a/BU30DsVjz5FNeZdHw9MSTc3aAO8lPsH56G9YN49tE
         ZTPg==
X-Gm-Message-State: ACrzQf0rIvu7wknzZ0eNpI33HsAM9Li/9fb3Sx/3hQdvXM4d6ZGoi/M5
        /OTIvyh8MqtkDIN8ZcPCRyBJehGbAhpl/l9a
X-Google-Smtp-Source: AMsMyM7NRZQxe3o3Z/rJ7Jmat3JgO8UGzhtoaUDjg5fqzO9o07F+IoLCy3PaMv2y+naqzTM+We7SkA==
X-Received: by 2002:a17:903:494:b0:186:a227:436f with SMTP id jj20-20020a170903049400b00186a227436fmr27423051plb.133.1666952602325;
        Fri, 28 Oct 2022 03:23:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o18-20020a170903211200b00186b945c0d1sm2698377ple.2.2022.10.28.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:23:21 -0700 (PDT)
Message-ID: <635bad99.170a0220.6cfea.56d4@mx.google.com>
Date:   Fri, 28 Oct 2022 03:23:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-8-g94fea664ae4ee
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 1 runs,
 1 regressions (v6.1-rc1-8-g94fea664ae4ee)
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

kselftest/next kselftest-cpufreq: 1 runs, 1 regressions (v6.1-rc1-8-g94fea6=
64ae4ee)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-8-g94fea664ae4ee/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-8-g94fea664ae4ee
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      94fea664ae4eea69e90abb4bd01997b9c54cd013 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635b9ba8393db5c8b7e7db68

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-8-g94f=
ea664ae4ee/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-8-g94f=
ea664ae4ee/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/635b9ba8393d=
b5c8b7e7db69
        failing since 10 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
