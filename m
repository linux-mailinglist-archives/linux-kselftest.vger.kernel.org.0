Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F96682CED
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 13:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjAaMsR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 07:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjAaMsP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 07:48:15 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F777392A8
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 04:48:14 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id g68so9948241pgc.11
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 04:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OU4LVxnHbCYJlQvBwRtddfF6DOOdtutwwv6jNjBZ+wA=;
        b=7EEYtiXIBg7y+6kKD2A2VnexjYfOtyPtH0j1zOPWP75cm5EodAGobiLeHd7KyYN1qw
         NpGP8Jp0W94TVsNS9Q1WRIb3SQoOGUcUMM+JpZPLA+Ps3y8i8wsPB66CWSWCIArMbnMy
         Lkn8GVM/Uyg4HZ4iR3iTUVj5kYHKptg3Ol/v2fldSzSv00i5m3poZ43qcNqcL18EAwOh
         rfMxqV3d7MCOpvDBa92pEahkizkg0rVE5YIQQyMp05H861Jdc3nj5s3r9ZOAycDs0oOO
         TnWDpq2UftG/7B8haNnGwNz7HjqDvH018eHJ1unorH+EGKxw7I3aUlZpi2e3iondNPKw
         +2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OU4LVxnHbCYJlQvBwRtddfF6DOOdtutwwv6jNjBZ+wA=;
        b=Ki0K8H8GLwleb2ddolkOMnr2dQDHXc0+++HISMDcoCxnNIbgTfukNgtNT24zkFIKF+
         m/BGnuvQXYnUCEonQZqMPJYdQdDJLOPHCCjWwyyj2VGhT2nObIL9w/ujroaF8k3Ffb6D
         dVtG1oFZC5CgBmyMkGX+B/7stYVVfo51Tm2T8VR3CNsOUWoX3zV12rm7Xevp+bQSWhVg
         ZlF4BLUkRfh6em4I/iP/QHlATzyk4zW5mNe2zgRDKvrXXTZimDnum4UEUhy/iWJ518OR
         4k/47ugRSIxVV1g4XCOrkqO53Oubz+efPEdTMOQa41GK5EZTM8L4czKTmeuFGJcvoekx
         8WxA==
X-Gm-Message-State: AO0yUKX3imIFJgP2PmBv6Bdxy9Nk7ty5sf13F6pR+5eI9wKBQh116XhT
        zfKQ0Czjvo9mR5dt5lezu1suhva4pWWeQfq6wVJvCQ==
X-Google-Smtp-Source: AK7set9O5LdA5+PRfyTonIrau3UR39eg/rl5d3nllhrRpOR2om8lMxeg3fA6X5ok/zMhx89mikodSA==
X-Received: by 2002:aa7:88cd:0:b0:593:cfbb:3446 with SMTP id k13-20020aa788cd000000b00593cfbb3446mr6902282pff.11.1675169294125;
        Tue, 31 Jan 2023 04:48:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id br13-20020a056a00440d00b00581ad007a9fsm9353656pfb.153.2023.01.31.04.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:48:13 -0800 (PST)
Message-ID: <63d90e0d.050a0220.60371.f738@mx.google.com>
Date:   Tue, 31 Jan 2023 04:48:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-31-gc837391e4499
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 2 runs,
 2 regressions (v6.2-rc5-31-gc837391e4499)
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

kselftest/next kselftest-livepatch: 2 runs, 2 regressions (v6.2-rc5-31-gc83=
7391e4499)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-31-gc837391e4499/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-31-gc837391e4499
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      c837391e449979b550a9aabfcc253d245b5436a1 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63d8fd3b4ae191194c915f6a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63d8fd3b4a=
e191194c915f6b
        failing since 35 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d9026fc245471590915ed9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63d9026fc2=
45471590915eda
        failing since 105 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
