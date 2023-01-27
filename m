Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C2067DCDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 05:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjA0Eae (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 23:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjA0Eae (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 23:30:34 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6A16DFCB
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 20:30:32 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g23so3808765plq.12
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 20:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W0i7TUl+sSuoUfJTrtyP1dsn66s6bKO+MYXWUBNbS94=;
        b=tEegPT8dXFiRPkkuRz5ohF6WpoUx8fm5OtvU3vUIh3P2SHRl1WziTnxZIpOEjx478O
         t3VneXjIeXZ8ObXj3JhnEjkqYT8Cq7ERRlr/7D9OWGyCyzLzArCCruxmPRQ4/iyEKGyT
         etOuCgJn5fM4lNI78W33yRzt1JAPw8wq4QGtgWsNbWB4WmaoUG9mhBpEy5BHRFL2eLQs
         yLKZe73IgTAMXBaX7VdzX1yrE+xeSlK1XTkoQ7Caw3lN1fU2Kg9sst11QtSfjdTQw+Ln
         4GGb6kz2oN/VKiZBsZfMzLnP7TFxWmssGghOxplt5FsTT7FS05zMjP9VnSEdH0ih7/kr
         f/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0i7TUl+sSuoUfJTrtyP1dsn66s6bKO+MYXWUBNbS94=;
        b=qe+3V6gmOsRygprwURVNWXk0JUwVXUCwT4VeN2G8y23wLoNPcAdHOD5UQvjNVAcRLN
         yBXiL2e76Y6ECgUc5ilZi9kxEPyZYjUL/K8R9YylPJObUFmp2EtV88JTafhqCj1tiXsO
         hVPbh3us+OZh7WrqPZDGqfk7RH7xa7UZj+0E+wSyvWbTivWRTmXZxgxjI8gKKSRqJKoA
         ORhhNGYfMomd1ZMdnpTFMrD0guElEPZLZ9hvSN7IbvNS3J+hSbaCvBvzlhiaKoaxKZCF
         Jy7CmJ3DeHgGf/fPIjRXrSMJomdxqepfoKFzzwXswqCNprDqDRS9v10VoJi/XNqdjp+9
         6yIg==
X-Gm-Message-State: AO0yUKVnTxGe4+qDGKRSQHSabIQ2deX8cTII+TTXPz1o6DrPMmw6e4uY
        MNG+u+weUw6JDU9CWtUW3BdpKA==
X-Google-Smtp-Source: AK7set+jRKndwtfLlCjjjb9GlfMx+lNqZr0+HBltjrLmbCbhclDzRU8EGqptZcMmZY0tpnIKojfNBA==
X-Received: by 2002:a17:902:ec88:b0:196:1d60:b1b8 with SMTP id x8-20020a170902ec8800b001961d60b1b8mr12731746plg.34.1674793831777;
        Thu, 26 Jan 2023 20:30:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ja10-20020a170902efca00b001960441f604sm1747542plb.277.2023.01.26.20.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 20:30:31 -0800 (PST)
Message-ID: <63d35367.170a0220.1a635.3424@mx.google.com>
Date:   Thu, 26 Jan 2023 20:30:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-1-g65177e47d303
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 3 runs,
 3 regressions (v6.2-rc5-1-g65177e47d303)
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

kselftest/next kselftest-seccomp: 3 runs, 3 regressions (v6.2-rc5-1-g65177e=
47d303)

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
-rc5-1-g65177e47d303/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-1-g65177e47d303
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      65177e47d3035c083cff034ffbfc7ab750a4675c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3405ec7a2ac6144915f6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-s=
eccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-s=
eccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63d3405ec7a2=
ac6144915f70
        failing since 31 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d345c9b09d84ae3c915ebc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63d345c9b09d=
84ae3c915ebd
        failing since 101 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d345b89d00097637915eda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63d345b89d00=
097637915edb
        failing since 101 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
