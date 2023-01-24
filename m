Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47D7679355
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 09:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjAXIoW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 03:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjAXIoU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 03:44:20 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6760437B4C
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 00:44:19 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id b12so10840289pgj.6
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 00:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RlrnMgs6feKQzj0RIlXRGjtztSmGwqyjEunbLpVGG/o=;
        b=QEJMwRJnOhtZBGcn7QckHbaqPJX2HEkFOzxYfsOSGXO4C/VeBAMzDN4iFJ9PAuckX3
         qkFnNrhBNtclDOoEqcaWGiiE1R+o65wCTLRyskBsC1BET0rH6Fp/DYZJVyXbJpbRlgzv
         5aLoISmPgL5Q6BmEHGXdgxLP7i0+WTAEhQhvn6AFi/rvttBFBOzIcdWKQQGnxCVqgMzr
         coB593yRpFdNBZwSekgPQ9byWGWeiOyQ0XvElqRneX4XaHx+FiiNXuXvSgwvGtTiyrxL
         w4deEH5tNqDMO1UtTtdCdYNaLlX94Q3X/WRuThqG1EZsHKJ/zulQzhNEVVrNVCgiL2Vo
         nP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlrnMgs6feKQzj0RIlXRGjtztSmGwqyjEunbLpVGG/o=;
        b=1UXT0jYQyPk65BAiT326O8ztcQFeOWqdktWNl1C8sz80OPy9koqr27NZx6Qr4d7pGE
         n+pTjyDqpVYbeD3lLpqTk3j1Gmeowj7/34GtAdo3kJ1PxFtJ2Fh/MYjw9gZLhbX1J+yt
         mG9t3LQXCMpJlq4zIH9FBIdCYJDbKEHaXIBBt0Rpifp3LNjH/paedvBp9QdNtrgSL1HL
         m+VRq+BTtxEHAUq7R2ElNKNh398dXoP3vw6X6edEKlJCfBrhDqj+JHsgSDPSDQWgsC8H
         hOBZqe+URL42Xr5WQ1yW7Migc+qjP0WlLCs4gJh1+ozfqGajLLTt0otYNQZ6H4gO8Y8G
         VImQ==
X-Gm-Message-State: AFqh2kp5fIjGKZPWX3CbXfkma3fVlPEe2P48877rjEliA91ZUPG55QMJ
        6q8LkpIH8FEv0O899EmLQ8Z5SXQfMoCqQrF5YFI=
X-Google-Smtp-Source: AMrXdXvapvud9PobgzwhmxAV5HT8k+St8Y4k0MmB7BfS8NOYcmLJKuE0u1zOaXABlv0Dm75dXQUD8A==
X-Received: by 2002:aa7:88d5:0:b0:58d:a683:bb2d with SMTP id k21-20020aa788d5000000b0058da683bb2dmr36718838pff.30.1674549858610;
        Tue, 24 Jan 2023 00:44:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 194-20020a6214cb000000b0056b9ec7e2desm991443pfu.125.2023.01.24.00.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 00:44:18 -0800 (PST)
Message-ID: <63cf9a62.620a0220.6bc10.1a0b@mx.google.com>
Date:   Tue, 24 Jan 2023 00:44:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 3 runs, 3 regressions (v6.2-rc5)
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

kselftest/next kselftest-livepatch: 3 runs, 3 regressions (v6.2-rc5)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =

mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2241ab53cbb5cdb08a6b2d4688feb13971058f65 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf90ffb55d03c31b915ed1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-s=
abrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-s=
abrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63cf90ffb5=
5d03c31b915ed2
        failing since 28 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf8da17ddced786f915ece

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-livep=
atch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-livep=
atch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63cf8da17d=
dced786f915ecf
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf88b310f038d28b915ec0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-livepat=
ch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-livepat=
ch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63cf88b310=
f038d28b915ec1
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
