Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F191A7AF9A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 06:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjI0EsV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 00:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjI0Erk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 00:47:40 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1514D59D7
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:16:37 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3aec131773cso655502b6e.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695784596; x=1696389396; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nXwc7Y8j9h1ztrErrIF7V0atiI5z1IeQNSdANo9A14U=;
        b=tL2R+SU6iDOP86lUk1HBV8CsAm9lLZauSIXYZJIVlunH7HXhYm8tghc4ou+LZnBY4q
         EyHxLQgG3ZeVYe4W7ivqjW653rcFbSzhDwQNpDyPhxrUQfCDKOdJaVWoo5axFdbQJKH/
         K3vs635EAhrjI94bbJ2/Z+kwmAwP+Raa2bRDRfKUQX9y4Mvj802nDHhW52df08WwV7/o
         lBT1D90RTUZ1viNB/vHQ0AAFhXS7s3Qwr8LK4hjbEfyhsdgpcIKgFuHlX0jYMwzMgelI
         00nuAQtwKK4Xnp5LpgXyqFx6NR88Ewsjve0X9YHovpR1yOwdzPonffFqObyyCHs68WdF
         it+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784596; x=1696389396;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXwc7Y8j9h1ztrErrIF7V0atiI5z1IeQNSdANo9A14U=;
        b=QBE2a9e1EQuREyB/lYCpFsaKZhBiBXjHHv4o1W9xh3JNjyX1qd8W8600RTGK7bxytQ
         2jIiatwvKdHxHCJqp2jwgjBit3ess5ZvUJSLiDPC0DaNnZCtrpd4DqF1X2maIfB/NI4k
         xrpZE4OVhYqS42ucQViBbXsQXpHmRSvhLF7q8w2Jx9kZXRMS3VnK2EXSziqUpvW3qLna
         MkkDag4ddsRMLosyTNtzY46m8A+Sd/H4cgp3X4uE2qyNDAUGp3diTmkgklIr2u0BfSqh
         N/0QMkUo2aG99F1zXjMWsBYE1GyQ4SrjwW7HzVDP1kPTDKhQEU2gtkfUm0SrJkPZWKcm
         DkSg==
X-Gm-Message-State: AOJu0YyyucORuyQDse5zT6cTogvVnFOXC8z/QHiFFfWgiAeutoRFCakZ
        elmFxNfn87l7II27jBS2iDqrQbe6qSHfdjZbjBXW6A==
X-Google-Smtp-Source: AGHT+IHQvjqbgP7FqkroKNa0hIzFU2X4uxdekonr8wn4IyleoGtSQCz7xjkCdF7WdS1CI1RgjjAtpg==
X-Received: by 2002:a54:4e14:0:b0:3a4:644:b482 with SMTP id a20-20020a544e14000000b003a40644b482mr886411oiy.52.1695784596420;
        Tue, 26 Sep 2023 20:16:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a10-20020a62d40a000000b006926506de1csm10862796pfh.28.2023.09.26.20.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:16:35 -0700 (PDT)
Message-ID: <65139e93.620a0220.5f722.fb90@mx.google.com>
Date:   Tue, 26 Sep 2023 20:16:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-livepatch: 1 runs,
 1 regressions (linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df)
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

kselftest/fixes kselftest-livepatch: 1 runs, 1 regressions (linux-kselftest=
-fixes-6.6-rc4-1-g6f874fa021df)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.6-rc4-1-g6f874fa021df/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6f874fa021dfc7bf37f4f37da3a5aaa41fe9c39c =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6513921250fa2e3c048a0a4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6513921250=
fa2e3c048a0a4f
        failing since 342 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
