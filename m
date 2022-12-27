Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C219656652
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 02:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiL0BF0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Dec 2022 20:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0BFZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Dec 2022 20:05:25 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A6B2739
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:05:24 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id m4so11906469pls.4
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i1546iFyBkBFVpmtIYZ9Q4Qoz5tSgo4KlrSr+xSpAQk=;
        b=em+zJqqItzYw8at3LJB3aGCxnK0z06tWcdOTfEPYgc6suT20pQxKtfYwRLihKf/TUa
         No+yr0vCz1UK2N9sRf3TF8nFOPpaWKRXfvqt303ecIMs9++XDFCrbH842qLdlbB18Img
         naI+ovBUCyCAXmxoTReQ7qeBFF1KSNGZ3AqiElzAM4K5k84VMK0ibhSHRubao3aWOmI6
         zqJgTVW5EJaJTNoVS+HZHCQmF8Yz3JSS7W6vL8al9KgZZhr6ZCwZ53g+eCe+Jmiik/Cv
         EgViggzZedTpnwKt6ybaszhZlYESHl7jdVsxkNaFNIcaYMfRrVH4LIvwxtv+CfEgo5Za
         f6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1546iFyBkBFVpmtIYZ9Q4Qoz5tSgo4KlrSr+xSpAQk=;
        b=haGaTX/qF/YZzVB0Kf2qnixrNrhZx/zry37fuj54dxk+YWGyjWQk1+aKM7csHL63cL
         HkpPj6z1RF8mwkrISGnvuJ038Df8y1hr72F72Q07QWfWwhN4O7qFBkZsCGbk7wxcLfSW
         Pkg1oKyGGE8G1dvfvNM8iwPOPoj8GqrpnQbANqB/PIlEX+JDgnoPLu5bVxykB5xmytSo
         3K/QNxc3tJkh41ko4tAohFXE9uv/ZRgeqlWqCuA6/o9PZKGcJ+/EjsIyHTGwnVShrorD
         ON+nYoQrs7C8g7+vqh9tF+Mz1BLJT9jfxeUy6jqgJqhphHESp9u+TEEM1A4EvL3eHCnc
         frmg==
X-Gm-Message-State: AFqh2kp2tC4/cuRSKfy3uc0F1I3AbJZN+vXxto9926UU4iGQ/NvQS5J6
        866K34tBoBbPzFjGT/bqmShr0A==
X-Google-Smtp-Source: AMrXdXsUYXPyynBw3x6n0bv68GpaKLfoIohuZS0T8NFG0bUdEypk6FoUqmh5xsKl+xFCfz1S6XqLHA==
X-Received: by 2002:a17:902:ee41:b0:190:f415:e861 with SMTP id 1-20020a170902ee4100b00190f415e861mr22151179plo.32.1672103123937;
        Mon, 26 Dec 2022 17:05:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902d18c00b00186bc66d2cbsm7783290plb.73.2022.12.26.17.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 17:05:23 -0800 (PST)
Message-ID: <63aa44d3.170a0220.9d6a6.dd88@mx.google.com>
Date:   Mon, 26 Dec 2022 17:05:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 3 runs, 3 regressions (v6.2-rc1)
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

kselftest/next kselftest-livepatch: 3 runs, 3 regressions (v6.2-rc1)

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
-rc1/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
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


  Details:     https://kernelci.org/test/plan/id/63aa37243f96cdff844eee2e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-s=
abrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-s=
abrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63aa37243f=
96cdff844eee2f
        new failure (last pass: v6.1-rc1-24-gd5ba85d6d8be) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa37ee09a37c9c1b4eee25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-livep=
atch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-livep=
atch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63aa37ee09=
a37c9c1b4eee26
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa363e35bc8a93f04eee1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-livepat=
ch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-livepat=
ch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63aa363e35=
bc8a93f04eee1f
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
