Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5047072B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 22:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjEQUFU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 16:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEQUFT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 16:05:19 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75564115
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:05:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaf21bb42bso9809755ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684353918; x=1686945918;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tMzDT5eIvvtHQ8dPflSz9LHOfIfVo0XkuT9/z2RQzd4=;
        b=HtT9KLZwoG1vF9Rgdjl7Zf3kUsxy/SfbFa35rWjBgJ/f9pJCMSM9VhcUfHFxkCKkQc
         TroSLUstFYcVbVCjtbljpWkdrr0zzSzLrVqc9S2wJnr82xAUejlFAtXcXB/jvWmoJwF8
         33sRPaPU0IeiN/qUd7WW84cJ+8WWtdtx/GRfAI2ochB0yJ5RfU7W3aPgZOvf2g2bXiNI
         1ZD+tXvWjOcVEXGlLagF+Ij8g7LPmjaEIdNZp3RH3SDUIqEIHXIG5FWwmW9I3Uc2TXeQ
         qxhazfKiJvZ9bT9vda0zhacxagnmWJAIHP+P3yM6G0XK3Ygg3+sLD/3c9CIV1ledd3Qw
         rSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684353918; x=1686945918;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMzDT5eIvvtHQ8dPflSz9LHOfIfVo0XkuT9/z2RQzd4=;
        b=b4HostFbd9+AtvIvLmB88Hw2ebX90svdK/yisutzwFmD85Ga1E60T/ossHCDgVzkXL
         9uiemKRWNqFphRNdjM98JHunsPyNzsxaU7fY2l+WIrv4HzjHDrtTy1G3cbtHpiHcIRsI
         y7+fO7IIrcZP9rrwA8y1y5tSdGHb77f5QfkpUFr2SLqC69lAIxIkHieLPBEw4asq0ZUU
         6RJNxfbpvqzkBNn5HXzR5MheTMEanLqBf5mxVHTzIBHGoLgLkFOVNbuHwJAMft4h+CBQ
         a/Gr5ZIUGA1ff3vY+Vp58B/xGv5s+ymVcrTmL970z6I0fCz+iSEBrmI2LUGTkV8/bKFm
         I0WQ==
X-Gm-Message-State: AC+VfDy3Z2IvRZeogGA+tOZNcL7b9YNawVUoee/MoVSDAjy0gwnvYufh
        Fk9eMo3JWph4Dm09m7yK2kztBuMoiDKJoBqw6U1kyw==
X-Google-Smtp-Source: ACHHUZ6L7hu2pe62yjU6c57MXRkka5pN+sR/UV1P/wiS9Y3LzKIqO39rkxEycJA6BmJnjdSC5ma6Aw==
X-Received: by 2002:a17:902:ebd2:b0:1a6:dd9a:62c5 with SMTP id p18-20020a170902ebd200b001a6dd9a62c5mr28430plg.10.1684353917920;
        Wed, 17 May 2023 13:05:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001ab1d5726dcsm7382678plh.243.2023.05.17.13.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:05:17 -0700 (PDT)
Message-ID: <6465337d.170a0220.c3112.e4da@mx.google.com>
Date:   Wed, 17 May 2023 13:05:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.4-rc1-5-g3ecb4a459a1e
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 4 runs,
 3 regressions (v6.4-rc1-5-g3ecb4a459a1e)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-seccomp: 4 runs, 3 regressions (v6.4-rc1-5-g3ecb4a=
459a1e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-5-g3ecb4a459a1e/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-5-g3ecb4a459a1e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      3ecb4a459a1eeab1ad135f87057aa3ea4c9af1b8 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/646520b630465c15672e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-s=
eccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-s=
eccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/646520b63046=
5c15672e85f2
        failing since 141 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646526671da08b5ea92e8639

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/646526671da0=
8b5ea92e863a
        failing since 211 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64652c210be3ffd4d82e85e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64652c210be3=
ffd4d82e85e9
        failing since 211 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
