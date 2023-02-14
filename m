Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C688695765
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 04:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjBNDYH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 22:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjBNDYF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 22:24:05 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1555215CAE
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 19:24:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id mg23so7293321pjb.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 19:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+tqZ7Jgn4iI68vRE0+Yt/y5KepB3pXel0B8dLuvy1JY=;
        b=lh2PCcFNg82w9KT6mke+t4CbUGf1w9Qb+2FLaOerjAplj46qn6lkfj7jeRcibcCqQh
         Gj6nj3QMbet8NQ/z8OJwjyRQhlrs4PyuvJo9h6GOQJopmykqU2sqWMfE9bsfZAEZ20a3
         pg7HC5SujrnZvDhkBJGGXAcCNEUThMLi81fqF/M6heANZvGo4N3cpvHGQNNAuglc3K+D
         +E9zO58nCsJYT9VmxXR6W42jOMyLiJoq0KgnF1uJDfFuwVmvPyR+aTgPSenYi5LqO4yV
         4gvwJbwx2bXZ/GtFBYta0s975+SJHTGus41lNqOddqitHk4O8EpECrbqAi129q7f2TRX
         fEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tqZ7Jgn4iI68vRE0+Yt/y5KepB3pXel0B8dLuvy1JY=;
        b=aKojGIw53EIeER7LeDGXpAZsrUCCwpfv8IalXCIBkWfU0XKBFIckS5q55YcSeN+he1
         O4ujnhQt1Qp1iCZSP0dQnE0Zs+51/qQ3EmDkw3fpwA3TZKFr7s0UHbSCt5q/lsf063H1
         rq9CCNxWMdH5BZXBDMjGcfbaNywXSZLee/WhHTKKZuiQgMEPD024z31swDr88xK0xgsY
         +nYY1ng7RAnKeUMovY3/+3Nl6ACrFMGw9ItSkhtszHuJPKeECnBmu7YakcPmpUblHHFs
         4czKjyvErfWIrvtFFPMHWoC051y/hmVAcFUlaXDHB1kyIwS42X19f/eKIKtWf9pEf/eG
         HcUA==
X-Gm-Message-State: AO0yUKUbysE3ZHcVaxoR7mSNsCM4LUR9+WVAOLsVwvxCpJEFPqTJ6P0U
        h4JOa3yWPCEVyzifE7vugNMQ0A==
X-Google-Smtp-Source: AK7set94/RngceEiLMLKC620UCyvaaU2VyosGEikGV7mEECivyDMNsfwbzGlYULD+kg0td2SMxJ0Og==
X-Received: by 2002:a17:902:b10b:b0:19a:974b:93f0 with SMTP id q11-20020a170902b10b00b0019a974b93f0mr895806plr.64.1676345043561;
        Mon, 13 Feb 2023 19:24:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jc19-20020a17090325d300b0019607547f29sm264107plb.304.2023.02.13.19.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 19:24:02 -0800 (PST)
Message-ID: <63eafed2.170a0220.d2681.0b61@mx.google.com>
Date:   Mon, 13 Feb 2023 19:24:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-39-gaca5a0944c30
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 4 runs,
 3 regressions (v6.2-rc5-39-gaca5a0944c30)
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

kselftest/next kselftest-lkdtm: 4 runs, 3 regressions (v6.2-rc5-39-gaca5a09=
44c30)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-39-gaca5a0944c30/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-39-gaca5a0944c30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      aca5a0944c309c56267b0c1d001aa999ddb2fb1e =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63eaeb57204640e4288c8654

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63eaeb57204640=
e4288c8655
        failing since 75 days (last pass: v6.1-rc1-23-g00dd59519141, first =
fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63eaf15fcc1125c4948c86c4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63eaf15fcc1125=
c4948c86c5
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63eaf00a0b4ffef5498c8699

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63eaf00a0b4ffe=
f5498c869a
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
