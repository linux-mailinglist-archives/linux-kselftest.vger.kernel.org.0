Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9095656665
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 02:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiL0BSk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Dec 2022 20:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiL0BSi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Dec 2022 20:18:38 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42032AFB
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:18:33 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so11908434pjo.3
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9y2QVjG+LepLlWJAwSmiYhbldMw2rUhwFB9W7gTboqM=;
        b=w9sX4N/s2XQxG4mg3/mLm402KhFEpiXf5fhcG+byPryRcjI0K0teJy7qw8USVOujGP
         dBbVsgh4WLYTWS+tTFmsFOn26acXgwKk9rfMW/G8zy/t7bzJPYBNB6snKlU23bjX4WNd
         UZTnK9yJ10LHHKg9kES99WAD+WRP0ZLMZSfP+/re4HddgYxr8CdqHeM4m42hOxvc2CqZ
         fDm/I81OJkHl6aV7XSUeyiSuWUFXyXz/m2Mjfv0nRHWSEiqW9hEZ5sblfArUlr0pMkPi
         n8+vStnxnWNIEVJAkryCSQ40pb1e4ZpX6auYdqPuctoCrFRX9y5C4NHi0VoEBIsk+Kxj
         ak5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9y2QVjG+LepLlWJAwSmiYhbldMw2rUhwFB9W7gTboqM=;
        b=Ts8d4RQAcyFq0cJbIuSuY2R0jdodSqieTrSEcHgi/ec1ZXRtrq25q4P8US/FIICCHT
         TK39CRi1FCz97D8BlWGjG5kHZU4GJGb7ZOqEblKCSfZrD11zpI+BRmiAxagoDhfxn1u5
         qdWhUCTzRqzP6pa/eBY3s6yUh280IaCjGPR+N8XZMjqx2hOUmf8t5MQ7Ao/iFUXWPbnf
         u3JhcsuMspr2EsLLGO0+RlD2bkTEhQVvZkDdGFLyy5WgZhv9Wo5iCBFyLtSQndXZCJe2
         ZHt9wXE0gG2lw25d7EMcDP1poxJweCflMZmoMGrOvMzXs26eARx2Ciq/z+T5rM3NrJ64
         stSg==
X-Gm-Message-State: AFqh2kretLIC4gYvKeful4iS2ggJrZ3ynQ+Qdn0Q/wecw6NRD4cVNgmm
        /LvAaWxi859SdddWHMTDHA8ggA==
X-Google-Smtp-Source: AMrXdXunlUVggJzbhW+bCEJJ/Mbm+cHvG5+wgEM0pmY5uWK2AuRzfwQdXNmcyeRQTO42AwG2pJMdcQ==
X-Received: by 2002:a17:903:268f:b0:192:7585:34b0 with SMTP id jf15-20020a170903268f00b00192758534b0mr6316418plb.29.1672103913477;
        Mon, 26 Dec 2022 17:18:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b00174c0dd29f0sm7700543ple.144.2022.12.26.17.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 17:18:33 -0800 (PST)
Message-ID: <63aa47e9.170a0220.e92d7.e5af@mx.google.com>
Date:   Mon, 26 Dec 2022 17:18:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-livepatch: 3 runs, 3 regressions (v6.2-rc1)
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

kselftest/fixes kselftest-livepatch: 3 runs, 3 regressions (v6.2-rc1)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
2-rc1/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.2-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      1b929c02afd37871d5afb9d498426f83432e71c2 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa36fb81ea7efe624eee1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-=
sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-=
sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63aa36fb81=
ea7efe624eee1f
        new failure (last pass: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac=
67) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa37fcf71b4940854eee19

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-live=
patch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-live=
patch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63aa37fcf7=
1b4940854eee1a
        failing since 68 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa3a26b967722bd74eee28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-livepa=
tch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-livepa=
tch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63aa3a26b9=
67722bd74eee29
        failing since 68 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
