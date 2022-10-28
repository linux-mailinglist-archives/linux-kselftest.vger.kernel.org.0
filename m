Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20FF610E54
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 12:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJ1KX2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 06:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJ1KXZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 06:23:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94E71CB516
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 03:23:24 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b29so4412158pfp.13
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g2CfsTgMX12Tq2R+NusU48gkRVh744rDyDoGlan3hPw=;
        b=BxG0oJm+o+yiN573kTLN9a2ymmtQMETVKYE9YXSi/GAmnNU86X2WvPIRfYu9/e0kte
         opSdzK313bkEBK51x7k/QqNdMg4a1t/d8jAmZnDZ4YtoCO/P129iUV2r4cKeVjfEPxOa
         WBEtYTjBje3J68O0qZhFYQdstLDAKCY5RiLgaiU1UgJHHsk4Re0qrNkYTI0bCQKZfn1f
         SILKp9fCV5z1PNbt5hR/mcarvEoE1RMc0Wg3nTMqJID0/t8KJTbyrZG2DPdTbiRkpZcq
         +I3jeYOItfYYYe28s8K+FY4cpc0JELBnAkoNhuMNFm1Kat697xl7gofgnMZZ5Chlyzux
         xnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2CfsTgMX12Tq2R+NusU48gkRVh744rDyDoGlan3hPw=;
        b=IyZ74EftnD+emJMWxpTrpRpgm/zm62+qqqNEXYSQljaF2WSb8k6I7AqubOk57OsNnV
         T7SldeA64hYBbFNHcY8CAHIY7JJPxGkZAmcxHzrpJuiCFxiRw8ubhsyAj0KD8WedxR69
         E4LNzJVI9dGXb/W6BPm29elwryvMWIEuDIlF5Ubjq7r2goqRMj9dia/M+kBTNGZ3dp34
         Iz+eRkvwmbZl2I53nxQzDwcpFQMYxQqDW9sLaA4Dluztz6hGod3XdowsEJn3G9N3iHrs
         D9xFn6t4M/5V1r7FLrAeVZE8r66Lx05lqnnEvZta3F2krHyPKEHqcGcLmDiCmBfGvetA
         nbCA==
X-Gm-Message-State: ACrzQf1IVkSukIaLpCiQseaqibdVE8nQjgUB1xWvVghv6vAyf68mEbTa
        EBiDHOiF+NZzcV5QdrCewUuBAQ==
X-Google-Smtp-Source: AMsMyM427J5c0sRT/SmQTigIbhmzccWoB+LlpGRx4T+yvyGfZaeVX6WAvf7NfgNzzZThtd+6ZWEC9g==
X-Received: by 2002:a63:5f91:0:b0:46f:53ce:8005 with SMTP id t139-20020a635f91000000b0046f53ce8005mr6049600pgb.428.1666952604338;
        Fri, 28 Oct 2022 03:23:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w35-20020a634763000000b0046ef0114367sm2469938pgk.71.2022.10.28.03.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:23:23 -0700 (PDT)
Message-ID: <635bad9b.630a0220.4385c.5015@mx.google.com>
Date:   Fri, 28 Oct 2022 03:23:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-8-g94fea664ae4ee
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 3 runs,
 2 regressions (v6.1-rc1-8-g94fea664ae4ee)
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

kselftest/next kselftest-seccomp: 3 runs, 2 regressions (v6.1-rc1-8-g94fea6=
64ae4ee)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-8-g94fea664ae4ee/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-8-g94fea664ae4ee
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      94fea664ae4eea69e90abb4bd01997b9c54cd013 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635b9b9f393db5c8b7e7db54

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-8-g94f=
ea664ae4ee/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-8-g94f=
ea664ae4ee/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/635b9b9f393d=
b5c8b7e7db55
        failing since 10 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635b9bb2adae52ab3fe7db62

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-8-g94f=
ea664ae4ee/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-8-g94f=
ea664ae4ee/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/635b9bb2adae=
52ab3fe7db63
        failing since 10 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
