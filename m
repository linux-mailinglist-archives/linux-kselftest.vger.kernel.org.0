Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873E8656655
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 02:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiL0BF3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Dec 2022 20:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiL0BF1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Dec 2022 20:05:27 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B182726
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:05:25 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 124so8038677pfy.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rHJWN4GqCPTBRWUzWIHPKASmYHtWXUbOr47dP58wTXM=;
        b=DUfPJstJwDe238nQktlpKqRKxFedSbJfu/qRwwg5PJkeaNSvnKx7HjY7eeeda+enLn
         6oYZwcjxuLOMnGWx09sfhlrMvw3A0GupDVSgNSue1YYzh98rnNc+/yglUMdF2FnqcdPL
         CFEmkHdZCmHHmcdD+n8Xlz0UBCTOUB1Oyr81863WeS+HWO4Z1tRhYgM0awLVHt++CH3j
         gG8Li1MHq3qnorO/BGMADyXIN82FkrZnWZeBk3sDddpBgsyTY96+nw2Gb51shfGyFQ2/
         KlnLwVTnLZokhGplvs6lWBcV3zkb2b5oWqKxgIOc9y7td3MMqMMMeJmvz1BOwkCuwFSt
         jVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHJWN4GqCPTBRWUzWIHPKASmYHtWXUbOr47dP58wTXM=;
        b=U57GyPgTguLYXGixrRO4c35f6as2BACSiAYrkzrEdmUaaZLbmI3mAtfHcsaisX/zbC
         9kYTvY4uny9khk+24+sFQYeX7e8K4btvn7m7/rHbAIHNe2Jyqe1M07V1g/j5s9+FmqSH
         HkS0t4ZH5qliGnswYkwNY8UrPqlwCRtFsXGrp1T8IlaOnwlR9TLkzbCJx9mBFrcJmN4f
         EG5ciEUb/msJ8V93eY6X2H9OnCwmJSy/y+q7Cn6JiG3MWVDjVtAcreh8jkvKxflg5AE2
         27qrCET7I5Lt4m8lOBstCNo4CdcmG5GwfrATqrMvgCk8ZQm29ykmOgz3ErVvsxIbxWjn
         zBEA==
X-Gm-Message-State: AFqh2krdqGwdF2DC0EaS1ViYYK/iI6eAfd+AClvWBXvzVK1ZaKw8NlE4
        PljFVX7BAmrJ3KRCqC2itygd3w==
X-Google-Smtp-Source: AMrXdXvQ294QRY91MKLHfTxY7VnBMTmIYn/swASOSWVj2fHe8VmfTnN4FyDgtvY5/rjWDec445KB+Q==
X-Received: by 2002:a05:6a00:13a4:b0:57f:f7a4:511a with SMTP id t36-20020a056a0013a400b0057ff7a4511amr28037761pfg.2.1672103125133;
        Mon, 26 Dec 2022 17:05:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v6-20020a626106000000b005815533e156sm888645pfb.44.2022.12.26.17.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 17:05:24 -0800 (PST)
Message-ID: <63aa44d4.620a0220.fa36d.17ae@mx.google.com>
Date:   Mon, 26 Dec 2022 17:05:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 5 runs, 5 regressions (v6.2-rc1)
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

kselftest/next kselftest-seccomp: 5 runs, 5 regressions (v6.2-rc1)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc1/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      1b929c02afd37871d5afb9d498426f83432e71c2 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa36fa81ea7efe624eee1a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-seccomp-imx6q-sab=
relite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-seccomp-imx6q-sab=
relite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63aa36fa81ea=
7efe624eee1b
        new failure (last pass: v6.1-rc1-24-gd5ba85d6d8be) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa37ec09a37c9c1b4eee1f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-secco=
mp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-secco=
mp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63aa37ec09a3=
7c9c1b4eee20
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa364435bc8a93f04eee2a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccomp=
-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccomp=
-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63aa364435bc=
8a93f04eee2b
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa37e409a37c9c1b4eee19

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-secco=
mp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-secco=
mp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63aa37e409a3=
7c9c1b4eee1a
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa364735bc8a93f04eee30

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccomp=
-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccomp=
-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63aa364735bc=
8a93f04eee31
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
