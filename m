Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2577777EE01
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 01:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbjHPX66 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 19:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347256AbjHPX6r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 19:58:47 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C92E1FFF
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 16:58:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6889078ee66so951409b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 16:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692230326; x=1692835126;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qCrHQhkh8nqO8UgkRxywxPr/H+4hfuHYxYoAWDp+dCw=;
        b=epJjwaG9FKn0fvpeCZ/RmoVhqZwMLXjFb6IW5jAWkMM3yGuIHOXB+1gEWWzow2iGzD
         EA4N3VHEfgmWBY+A/Rn9k/T7SBykCbOgBcNjWWRLqiDvjdNUMaLRI1LtXBYhL3j4WXwt
         2pdEk1M5j2U2jZxI517IE4EqSVS7IsWr2kStrn5EH1sYwHaCC8vh8oqC2KD1spoGDKD3
         7rj8/q1kWX1oeoXEPC1PQO4oOQWD64InJFgalaYNEf84pRGjaKrlrF6ED8rI/kPTnjES
         LVM7fvOVC9dzG7yPW1Z8wd7PHFTAu4s8IDblMEMmSLH5/ABMEvKdi+z61BlthTxDl6yr
         kkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692230326; x=1692835126;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCrHQhkh8nqO8UgkRxywxPr/H+4hfuHYxYoAWDp+dCw=;
        b=IwCQuiPUSUARUl2GzSyDW6c+kgSaC2d+rIkWzrwY21oQuK6Sdy/ZySxreArDHVV4Ny
         mA7MuSwXqtcWzBYN5ZF53ZLOYmViZqfvoVL4vuvOdWnEph5H5zqKu9nKN9r0MQS23fS0
         Cj7RjWvgYR25HAcTw3Ezstol0IvAJhGGOYvJF8mxKdoUr8Ni4XElgNYIgTbeJ99kpCid
         FXsvx04MZpwOYiftSNMNxUF7aAO6B5POJsU7o1MmJxWwIErGsYT3qsMLa30mTetjDacz
         b93UYnDb12SN51S0ecp4KOUz7EJcbEGXYod2PnnKo38B3pgYseirjwT4wWnt90yVVCze
         HoXg==
X-Gm-Message-State: AOJu0YzRmSN2tWoyIpCTkRohSQZ2OdvOAM5q8s4mGrCx1yMPooMT5iPS
        KQOhY0NyIT1tee6rsPyeEimLRDe3WlcoMR4hCFsgQQ==
X-Google-Smtp-Source: AGHT+IHIaY06W9YWK0xJMHQj+odmvRMW7Q64NFL+RHe8ucGI0v2GG7qj5iK1+ZlpgVXZW1bXXTxPkw==
X-Received: by 2002:a05:6a00:23c1:b0:687:5bd6:b6d1 with SMTP id g1-20020a056a0023c100b006875bd6b6d1mr3793954pfc.3.1692230325888;
        Wed, 16 Aug 2023 16:58:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x22-20020aa784d6000000b006875be4163csm3494133pfn.17.2023.08.16.16.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:58:45 -0700 (PDT)
Message-ID: <64dd62b5.a70a0220.ba1c8.867a@mx.google.com>
Date:   Wed, 16 Aug 2023 16:58:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.5-rc3-32-g9b1db732866b
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next kselftest-seccomp: 2 runs,
 1 regressions (v6.5-rc3-32-g9b1db732866b)
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

kselftest/next kselftest-seccomp: 2 runs, 1 regressions (v6.5-rc3-32-g9b1db=
732866b)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.5=
-rc3-32-g9b1db732866b/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.5-rc3-32-g9b1db732866b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      9b1db732866bee060b9bca9493e5ebf5e8874c48 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd560fd1781e463035b1e3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.5-rc3-32-g9b=
1db732866b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.5-rc3-32-g9b=
1db732866b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64dd560fd178=
1e463035b1e4
        failing since 303 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
