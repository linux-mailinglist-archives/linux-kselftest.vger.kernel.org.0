Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBC66164AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiKBOOf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiKBOOc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 10:14:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DE725287
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 07:14:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y4so16717449plb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FO7mbzKnmRWN8tQNH/V8rwSv9kX+ZBPzaML2BcIu2HM=;
        b=AfmVT/wzqJo+UL74krDq8v7tKsmcpTZd/YbFL6zhQm05Wu3P36zn6RfgOzOXRdkbGH
         Y2nwFsCY8zkc3B+RZ8WZviMuLd+JC+sTpnrK7vokiui3mw+CA4zEu9BovYfw++Han5jr
         th+gw5gNHsFZYqKOogvhYuZtyek3skoqKZ1wy5EqjDPiVc5d7Ca8GRRB2EvTgaXavX5z
         CZ/fmFoxFFJ/FBWKyeQbhe7M2bjPMWSU1xnSkOqcJlqkHebx+jXYZ88rZ0bqOVgDleEb
         ulksebCVwxJBkXB+z21BxWLh5BRDprxU3MHWj4ug4Vbo6xkpnfOfzJcXE3PRdhVE2dT7
         8tMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FO7mbzKnmRWN8tQNH/V8rwSv9kX+ZBPzaML2BcIu2HM=;
        b=HcR97IUiBtfQTaxgU5dq1yFUjmvAKep7qSDk2yoZvR2DE2gVpOhnqPzFf/6YtaqsPN
         r8wyZXfaZ53SZamCtAEZ7QNgvZ5ES7AJsTiE2gaEilUjt5O2tgerBSI93LAqvvo3enrd
         fPTsyWnDUAvLDQ1/ic7QziLZvzazWlg/jC7YI/GZ3kU639H7MHUkTRo5SAQYVlKG72Uu
         eKKFWZubRzeeJUjicKRY54T7oIOxgdbZ/w5WznHEvRXz+5J607VTeg3SYv5rwXmJp5gY
         pl4TADFpTYRGrDVhWqIrYiewzO3dZhYIGO25QsQbEWT1G49WI/cAoLLrHca2brzzOx7d
         5DrA==
X-Gm-Message-State: ACrzQf3xNeFWhfHWiRzQxHsLRMF0ROs5NKNKbKxwIiDJcdLv5zuyAfWO
        sRmFaa4lkE2qQkeGqXHjQwQ/9c9F2CUhfrSG
X-Google-Smtp-Source: AMsMyM6iDYJLhlOeBYWCBxGYtNz6ltn/NjCDMwUyXa7JzVJwWbP2vcqkux/AMMDATYCGBSbNHrAW0w==
X-Received: by 2002:a17:902:d48d:b0:186:cf83:4be3 with SMTP id c13-20020a170902d48d00b00186cf834be3mr24790715plg.22.1667398469680;
        Wed, 02 Nov 2022 07:14:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g206-20020a6252d7000000b0056232682a7esm8567074pfb.2.2022.11.02.07.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:14:29 -0700 (PDT)
Message-ID: <63627b45.620a0220.30a21.fcf2@mx.google.com>
Date:   Wed, 02 Nov 2022 07:14:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-livepatch: 3 runs,
 2 regressions (linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67)
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

kselftest/fixes kselftest-livepatch: 3 runs, 2 regressions (linux-kselftest=
-fixes-6.1-rc3-3-g89c1017aac67)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.1-rc3-3-g89c1017aac67/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      89c1017aac67ca81973b7c8eac5d021315811a93 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626ea00720ac3502e7db73

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63626ea007=
20ac3502e7db74
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626af011e7c17733e7db67

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63626af011=
e7c17733e7db68
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
