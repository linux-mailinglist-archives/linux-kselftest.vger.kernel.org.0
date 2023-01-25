Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59D967BB95
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 21:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbjAYUDH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 15:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbjAYUDG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 15:03:06 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A579B303FC
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 12:03:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso3225120pjp.3
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg/NsDrl/GnJ+OwzBThnucPpfJcGBLDT0UJx2a1EdGE=;
        b=lCT1Om3ZtFfCEnroo7hG3Xd2PwAtPYJWnMfSIV61P3Okg6w9PP/RCpr12rB08GDh27
         E0/HxWlkn6VUCUBAif9+MA0cynmSy5rrPPKx5EvH227alIvLf616KbIetWNi1U7E0QIH
         esMbXthRf5ObSt10neQk6c7t1EyzJouJqVwN6EL0MtiXY/15HeUffHSho9pDt4PJxOkp
         Wo1UYm/GnFI0mhAyOoiS//QIVqVUV5Jtu+FMDzn7/meqkE0xCTMETvEVsEWrAPjvFCbl
         EBv8OJWwDCNGYzKrUuSuLjB723PJ7gVD6/mGAqO8Cyt08F0uydKN9H6CdiPT+B8CC4rH
         xq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kg/NsDrl/GnJ+OwzBThnucPpfJcGBLDT0UJx2a1EdGE=;
        b=vdIKGbjMMy2H9gJ0Ai72TItiHHV0W9lfFBA28/FUiWSHbV1uH1nw7tC9jmE7ryCWmG
         g322K5C09t3/6I2VZdReIACL3DT0XNngLRBo/DF09SbmXY9vWcZckSkl51tIMf4L3RN8
         Na9xGIgUHFYYyQXzpmyjzRstW93t8/0vvS/m5mr/cD1ZfEhORRkYQF5vyv1z9raehKVl
         mAHzFNLf3gAs+qq6cLuCeMPGG72OXDP+5eRUBEjG4vJe3r/dyaZMRQDp4bYYL+duRLcv
         6ssIDaHossM9TZrHHbA7Tsgx1VEXg5RO/XN/zJxHGNgyngLvmmVHzoX4hmo7rdnxw/z8
         tYQg==
X-Gm-Message-State: AFqh2kozurZsq3XZOjQxozvMm89wBkLP1Nv01Y0ZLdCqfKPTJiSHfLkp
        hz0y4Oq98bkYZ1PzqK5y00443g==
X-Google-Smtp-Source: AMrXdXtmQMq1cL9XKefKKrVL1U/sQqxilOWOKZI6s0b+y+O566yT5jF9g4cPgiGc3I6WBb6cm9+viA==
X-Received: by 2002:a17:902:f791:b0:194:4981:2018 with SMTP id q17-20020a170902f79100b0019449812018mr37177384pln.60.1674676984340;
        Wed, 25 Jan 2023 12:03:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jm13-20020a17090304cd00b001933b4b1a49sm4034316plb.183.2023.01.25.12.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:03:03 -0800 (PST)
Message-ID: <63d18af7.170a0220.db88a.7b62@mx.google.com>
Date:   Wed, 25 Jan 2023 12:03:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lkdtm: 2 runs,
 2 regressions (linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8)
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

kselftest/fixes kselftest-lkdtm: 2 runs, 2 regressions (linux-kselftest-fix=
es-6.2-rc5-1-ga49fb7218ed8)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a49fb7218ed84a4c5e6c56b9fd933498b9730912 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d17ab24127539702915ec7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63d17ab2412753=
9702915ec8
        failing since 98 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d17ac74a699e156b915ee7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.t=
xt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63d17ac74a699e=
156b915ee8
        failing since 98 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
