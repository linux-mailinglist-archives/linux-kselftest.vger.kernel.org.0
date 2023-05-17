Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E4B7072B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 22:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjEQUFT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 16:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjEQUFT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 16:05:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4FAE45
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:05:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-25343f0c693so848059a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684353917; x=1686945917;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nWU1PIqtGvQbgbMkKGJFm+e8BXNxB3S/WplVIApxpn0=;
        b=KAsYQMuiab/iqaPsEPtwV241s4LwxKgt2BCAgZIrWksGrUlq0nC/R87B75yFtYfXmn
         4O4sS149Yg9nvt1GfTjl0g04jbCUPqDzYeypNSKXh2eDdXVDux6aSMk7gWyXNEB7j0pf
         znYBSw9MSJgAxstxJApbq86kJYU2X9sNZ4oS8wUFjx4nnb/S5eLfuzr7L7OE/LWE7X5M
         Xia5Yk4d/66nnuAcbWk4N1z8c6Q8ha3LUn09/MI8SstuBe7CdJPS91+WEeG7Y9UXa64f
         GpO8I5zGQI5p4DWG2Gm2WZZDEGUQ00NztuBv88L2FfUjWRilw9k8Ox3XRv4kYXyZJiEr
         vTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684353917; x=1686945917;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWU1PIqtGvQbgbMkKGJFm+e8BXNxB3S/WplVIApxpn0=;
        b=kXAZGgaka+5ymyZPN9VNTQFxrJgiCh6bS8ET818s80quK/+0fGHsy0Ho2P0LNmwCeP
         NlJ7KhKQx2VqRqDxxDH/ruo6HNMKOcxO6fMfEAzD3fFU0aGCZ0rOBC1wyKRVkzvj4Bk1
         Sn8aTqoNjy8x50faZKwfPfheWLMIdTY/agcxkeUluJy+8IitNVm742OX4xtxUK1eEMkq
         8XcGiEZNjo8c5L+OrId9g2oWcuA3gDqijiOI5hrHx5y1f+mYQNOd9RUCqTB6vWpjUuXZ
         VbFQ2rP+h+KD36AeJWe6f98Ay/lEVJsOG4hVPi8QF7MhH+YDR8XgoPAY7zn/unSESZCV
         G/aA==
X-Gm-Message-State: AC+VfDwtLfhXEFFFFhv9mtXdRtv9+NJN47yHdS7NsMrAEr/oQc1NNlXh
        A6kpgDeBg9psJUp2Cz/BxopEpaUOQ8SF+hpB2ZF+/w==
X-Google-Smtp-Source: ACHHUZ7cT/6SZKBan4jMngrAJ4DL0mD5dncZAGw24vxwqLaJah63gFSk+1cqSQn2QC0Xp8K4vq6kVA==
X-Received: by 2002:a17:90a:c592:b0:23d:3549:82b7 with SMTP id l18-20020a17090ac59200b0023d354982b7mr1781pjt.46.1684353917262;
        Wed, 17 May 2023 13:05:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090acb1600b002508f0ac3edsm1986796pjt.53.2023.05.17.13.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:05:16 -0700 (PDT)
Message-ID: <6465337c.170a0220.ab2d8.449f@mx.google.com>
Date:   Wed, 17 May 2023 13:05:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.4-rc1-5-g3ecb4a459a1e
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 4 runs,
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

kselftest/next kselftest-lkdtm: 4 runs, 3 regressions (v6.4-rc1-5-g3ecb4a45=
9a1e)

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
-rc1-5-g3ecb4a459a1e/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
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


  Details:     https://kernelci.org/test/plan/id/646520f1864faf0d402e862c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/646520f1864faf=
0d402e862d
        failing since 168 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64652691896ee50e232e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/64652691896ee5=
0e232e85f0
        failing since 211 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64652c1ea4468e94902e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/64652c1ea4468e=
94902e85f2
        failing since 211 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
