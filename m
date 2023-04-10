Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDABB6DCDA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 00:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDJWng (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Apr 2023 18:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjDJWnf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Apr 2023 18:43:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0A1BDB
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 15:43:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o2so5964298plg.4
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 15:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1681166614; x=1683758614;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DVvBvoau/VeICf2aTzRpTz3yaMraYSzkNbJDtKRgcaA=;
        b=7qTGvPt0wZ46puHq2d7yCCbf+FGrNGoURtgDQIRoWZN+21Kma2eZGXl3FN+C67ud3n
         wcAttkhLdCU36d2ZVXrQfpPwWan0655PILIRriU90G07l4kpXOqFpoveAPtKVWe2DnZy
         v6IbTeNRVBeyzxGI/X35YC7ZdSgSOU9y/a4cmnmIqnY+VarldTOdp7GBmA03rBKVrNFs
         PebJ+hWVYwlB9xwdSaglX2T30s6jplkFjSFlF/tYLHzYKR4iR1kmICvJD5y5EcWkVQJN
         8H5KI7U3/K6ZgDUlqM3DIIKzcXkszChCdyo9FetFf1xnzN81TgY7QMWzIsy+xAT/du+9
         OoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681166614; x=1683758614;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVvBvoau/VeICf2aTzRpTz3yaMraYSzkNbJDtKRgcaA=;
        b=Ymu6w9N96Ji1fEYwEESJMxJu4lrhPYBFJgU0V3tcYeoq+rrqr1W/nc+lOqX7uKbOmm
         ykWZayKj+CM5+XH6HqJxntSO6JtkLObmvCeihx1DCxQeYcMcYvT2nVTFzdHf9ni4zJdt
         wdJ2sozima8AkpFOiVrsgznjv0mzwd4tT6OCzIlEu3meyB8BcW+auH9wekSHHGsv1Ay+
         DVKvWK6kEW8v30IG/MRVqMVYEtdM3b9UqBmYeglCJpCtWkT8YEMqQ/01EQty6nCCkzwj
         EdspQTamRLC9lhGM2cEuyx/HrjLhs2XwaXRE4FCxB+5hP8r7s+7gqgunKlFRzB2HoJrj
         nE6w==
X-Gm-Message-State: AAQBX9ev0kJxddYj1YRAeieXqJri8tqDZMWB5v+aB8Kkb1xt1iByjRJe
        QyhH4bTuNi3DHGTIys3F5De7ok8Uq+cLJf/Lc1A=
X-Google-Smtp-Source: AKy350b1WEa3Mh/LFAQtS8ZGSG+2mJbACtDEjU3HUeILb4O7XOv0+Od2PxOdXcYqxw/kqj2mtUjlfQ==
X-Received: by 2002:a17:902:c402:b0:1a6:34ea:6bc6 with SMTP id k2-20020a170902c40200b001a634ea6bc6mr8206820plk.14.1681166613811;
        Mon, 10 Apr 2023 15:43:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ja6-20020a170902efc600b001a522cd8536sm5367972plb.95.2023.04.10.15.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:43:33 -0700 (PDT)
Message-ID: <64349115.170a0220.a282c.9cdb@mx.google.com>
Date:   Mon, 10 Apr 2023 15:43:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-14-g5874a6a187f2
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 2 runs,
 2 regressions (v6.3-rc1-14-g5874a6a187f2)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-livepatch: 2 runs, 2 regressions (v6.3-rc1-14-g587=
4a6a187f2)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-14-g5874a6a187f2/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-14-g5874a6a187f2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5874a6a187f2e814542d7fdf918fd29f79ff25c3 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64347be64c89b6021d2e85ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/64347be64c=
89b6021d2e85ee
        failing since 104 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64348231291f5811772e85ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6434823129=
1f5811772e85ee
        failing since 174 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
