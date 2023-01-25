Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECFA67BB97
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 21:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbjAYUDJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 15:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbjAYUDH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 15:03:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64DA12587
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 12:03:05 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so3259406pjl.0
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 12:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ho2Hi2912fVWCTL/MUkeOLiuJ+v7kgAR/cNl539SRB4=;
        b=5TUit6OKPOu2R0uuTKRZJw2Jq2yS5J1P9vrY0moXS6u71K6NvXpy41mekPYu+NQI9Q
         Z9SJmCi0zQmM2H9gD4UYI54BaB1X21bb6Tb1f+sfkxQ04oEGX1qI36WZNHQN3fr2951x
         vuPkaCWylbHazyWLu2Rp8lUh5Ylj6vR/DCL7ZkeUXm8VfXhNFJKOvB3i+L1FEAx/h14n
         q/F15Zx9aT6DTxyVexEFOjHS0LJ+GCkA7JAXxpikIIc11gAQp5zoh9nFkkUJLZ44GwXy
         liTM6FAXsbAZ2jJRVT4qF8OmnGljyXtTc6Q+iK4mH57wsZ7YXXbPRaclMspvhziBAtNo
         /nrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ho2Hi2912fVWCTL/MUkeOLiuJ+v7kgAR/cNl539SRB4=;
        b=NPWb8rz+7Xc7AOZUnaZEQuXFGYhaH+2z0LPD3W7PjNYyiIu+/LecjNJ9MXqW96uf56
         jlkZpb6k73Hn8b77tIwLL27Vd2exJAJHsV3mYKlb2sHXlh9hUSAZXeffnQ29A9+DjnSi
         +6hRp88Bw4obgrzQxrZAN6fD/mUnCdOU+qNYNyTqAmgD+ZtMuCBFjfmT/bvSA0uoNx9Z
         0+aWeg4ExnIisfc9mRaEuIVUE3QGNclseMSliNy/WDVrO8y3pxp6nT0i4GlBiqP+ATJf
         YCJ8++aCJ/jmCKkPxemPqbREGiWxnAfFFipPohGULtqZCGcod2sKN5rrEaFdSJSnJv+6
         tQow==
X-Gm-Message-State: AFqh2koUGR0OH5YLupDVo6xt+KfsbyGx+BPLg+iowxFjWrG75REKX0Gr
        r1DqpGxd5gJLg0zLRgn9ncFgdZDlXM5pf3Inf7I=
X-Google-Smtp-Source: AMrXdXuzcIaKpblSzcTTY2x8tTd19aNvNUzRxEsZt9X6bL0nPhAVDujDAFJ8kqPPeXzY0w3t+QNItg==
X-Received: by 2002:a17:90a:4a95:b0:225:c3ab:3137 with SMTP id f21-20020a17090a4a9500b00225c3ab3137mr35230686pjh.44.1674676985168;
        Wed, 25 Jan 2023 12:03:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090a7c4600b0022c03785e9dsm2078619pjl.18.2023.01.25.12.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:03:04 -0800 (PST)
Message-ID: <63d18af8.170a0220.95a3.3653@mx.google.com>
Date:   Wed, 25 Jan 2023 12:03:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-seccomp: 2 runs,
 2 regressions (linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8)
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

kselftest/fixes kselftest-seccomp: 2 runs, 2 regressions (linux-kselftest-f=
ixes-6.2-rc5-1-ga49fb7218ed8)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a49fb7218ed84a4c5e6c56b9fd933498b9730912 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d17aad1d9ce2c271915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63d17aad1d9c=
e2c271915ebb
        failing since 98 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d17ab44a699e156b915ebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16=
.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63d17ab44a69=
9e156b915ebc
        failing since 98 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
