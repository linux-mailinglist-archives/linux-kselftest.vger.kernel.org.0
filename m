Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C41C564A43
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 00:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiGCWQF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Jul 2022 18:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiGCWQE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Jul 2022 18:16:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269852DE5
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Jul 2022 15:16:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a15so857492pjs.0
        for <linux-kselftest@vger.kernel.org>; Sun, 03 Jul 2022 15:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=j9/LhblNYIv/AuedoZ6G1vU7VrvKdln0GMcvhVg3AdE=;
        b=l44jsVuO8DPonDNP0YADAQC+H6aUmcaptAAJew55Z5Cor9w8l8IPafBkye1A6CRCU6
         I//PD7SkYQSZCO9txwtgFtKsRC3XAXsVQxUhQSbIX6agoFGKUr45fkTDppQrOkjsEbwu
         shJf/NFywcRsIL94kk1b4SUttJpo5yjOhcyvSx54xUrF881XOUN0e6Ey21wx1DeCyH5X
         qGUAhMUGoZ8mktn3mzO5GiGhlA2/JRkGviUnX7siiWs48waCGxEKQ/UeY4G3seHsFOOg
         91zariVRhhyUR+xPJgwSwL0FRFfDO8fFLeAwGEKuCx8FLOJUr2FTp+J95F2qztku6KmA
         wDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=j9/LhblNYIv/AuedoZ6G1vU7VrvKdln0GMcvhVg3AdE=;
        b=V09/2Ihpe68HMFK25G5Ws0vCvWzC+zIMdM24ZGppkOkRlgTzTQkjFg4nv22D39zYNA
         OGs9saaKHwW7SyoQjBscVBMcY690ol26aHnRVr2nC3qkIt+EPvLR6WGTMzQ18YdTid+i
         ZBahhvlZNhnBqEgBNf5bc6WpNvdgSC72FHgwJU89JToTqLK+V1pn6G/k3ktE5raVRm+u
         MfoX9f+cyazRtaPQwX4LQkRc1MKg6IuN9bAZQNtJV6oSyvWvVddZSX5szpEdHTImH2qM
         LKzxKunXb0643+GDky4wiLwMVchUCcfTCtI09w1ZDiUAVySUG7HDAMl303cMfZ2trl9s
         dpmw==
X-Gm-Message-State: AJIora/sM3XFcYsOEwSvrIjvVbJ5FUwEbBp/qmFihwHu5PlzqHcAHaJm
        u4/ga8Z5vhEAoxqdVxniGU11ng==
X-Google-Smtp-Source: AGRyM1sAxV896pcKqQRHtx9yB6NFsw+fCULS3QBISRbfEChj2hh7ZjtxDXYqC4EPv6fJBQy4gSr2Ww==
X-Received: by 2002:a17:90b:4d84:b0:1ec:aa85:b8ea with SMTP id oj4-20020a17090b4d8400b001ecaa85b8eamr30785548pjb.194.1656886563677;
        Sun, 03 Jul 2022 15:16:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f15-20020a63e30f000000b0040d376ea100sm19124271pgh.73.2022.07.03.15.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 15:16:03 -0700 (PDT)
Message-ID: <62c21523.1c69fb81.858b2.b083@mx.google.com>
Date:   Sun, 03 Jul 2022 15:16:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc4-7-gb7ecce6800eb
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 5 runs,
 2 regressions (v5.19-rc4-7-gb7ecce6800eb)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-seccomp: 5 runs, 2 regressions (v5.19-rc4-7-gb7ecc=
e6800eb)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | clang-14 | defconfig+=
kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
9-rc4-7-gb7ecce6800eb/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v5.19-rc4-7-gb7ecce6800eb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b7ecce6800eb1aa97c486c1aabf64659193d5a4c =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | clang-14 | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c206014c894b87a2a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-14 (Debian clang version 14.0.6-++20220622053050+f28c0=
06a5895-1~exp1~20220622173135.152)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.19-rc4-7-gb7=
ecce6800eb/arm64/defconfig+kselftest/clang-14/lab-baylibre/kselftest-seccom=
p-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.19-rc4-7-gb7=
ecce6800eb/arm64/defconfig+kselftest/clang-14/lab-baylibre/kselftest-seccom=
p-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/62c206014c89=
4b87a2a39bce
        new failure (last pass: v5.19-rc1) =

 =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c2045daa2c8e653ea39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.19-rc4-7-gb7=
ecce6800eb/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.19-rc4-7-gb7=
ecce6800eb/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/62c2045daa2c=
8e653ea39bce
        failing since 5 days (last pass: v5.19-rc1, first fail: v5.19-rc4-4=
-g43fe0cc46b62) =

 =20
