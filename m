Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655F869552B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 01:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjBNAHB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 19:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBNAHA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 19:07:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298C31A664
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 16:06:56 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id e17so6457443plg.12
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 16:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zXs/RagKSl0y3NbNnIO/OU2ZGddoD4tPGM6qhqwcZYw=;
        b=AP7W/HOg1QJdYDmTsyY4Mn8rmkcKqRZjAPjm29VMfcppf79LP9ZLRohPsPTRZpebWg
         rQRzhg2XGDCa1Y1GfqreRqsYoa/JeXQ/PJoLqIESFD/v95liHfn+waSKNO48vderF4WD
         /RxIhE0AJooAVY0cuzPLgz6p1vpvHPbDGbED37pWpqwJIxrOQzj3VPhVefI5sCsqZqEY
         fjqO7IGTbPcqtFgmO+U2XHpAdAR/05emF4/A86c8XxlPbC3lydUth2KNRTBzTVwx6+YB
         fX+66dD6stqqzuZHYlcfoCq6BB3zRcgdiEs6B+GbCFDvBMjJfi5jBo8DavSOjv0x223U
         hcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXs/RagKSl0y3NbNnIO/OU2ZGddoD4tPGM6qhqwcZYw=;
        b=CvpBueH0yXup1tbcUDao4VPTbj6MOZ4Z2zRi5D7SkrNUAz5kmB3e2rNzf7aIUJ5k5k
         nPJzaZCtBMwdoj84TzKoOWz8/YVO3Wg5h+/zESCH7fWPvPe/AUB00Zbcgi39RkDkt+9L
         ziREVp7rMRMFWzhwDq9dFlOuFgSr+JrNyWPl4dedkdTh1SsSOO9+DCBP43SqaYyqh4C0
         uHzFnLEdJQI4yenIsN0FdqdFzWgWy5/Yhm34Y5qdEeUIKhEqTaFCUZC3YKHZ32VMc6e5
         kAGlJ6uIj98KHWmZd1LFCNUq0l+qoBmpuBiB6L37yKj6uFAkwNTH5G/gGb7CW7K3+R+I
         tNSw==
X-Gm-Message-State: AO0yUKXTIiHRwfTzeogQLIHh6ng3RKtzH1SNbb2Lj/PzqTyJDDvYHOOV
        Yu7ZNEiZVYIg8+adKDYuzf73DxpK5FAEI09nLf8=
X-Google-Smtp-Source: AK7set8B2xWj9yU/jxzIMElOz5JoZnSup+MMiNh2cGveYv7oqtEZw1wkSB+5ZzgO3lM5f6zxqwtNRQ==
X-Received: by 2002:a17:90b:4d04:b0:234:d78:9b58 with SMTP id mw4-20020a17090b4d0400b002340d789b58mr339712pjb.19.1676333215695;
        Mon, 13 Feb 2023 16:06:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w23-20020a17090a15d700b0022bf0b0e1b7sm6147097pjd.10.2023.02.13.16.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 16:06:55 -0800 (PST)
Message-ID: <63ead09f.170a0220.f4b93.a9fc@mx.google.com>
Date:   Mon, 13 Feb 2023 16:06:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-36-g6e81461b06b6
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 3 runs,
 3 regressions (v6.2-rc5-36-g6e81461b06b6)
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

kselftest/next kselftest-lib: 3 runs, 3 regressions (v6.2-rc5-36-g6e81461b0=
6b6)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-36-g6e81461b06b6/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-36-g6e81461b06b6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6e81461b06b6a4a24bf97fca37d9b89f72ce8126 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63eabbe55c141162f08c8752

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63eabbe65c141162=
f08c8753
        failing since 48 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63eac39713622c965d8c86f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63eac39713622c96=
5d8c86f8
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63eac2c72cea262a488c8664

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63eac2c72cea262a=
488c8665
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
