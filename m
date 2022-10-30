Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0380612ADE
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 15:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJ3ODH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Oct 2022 10:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJ3ODF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Oct 2022 10:03:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8ABB4A7
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 07:03:04 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l2so8674214pld.13
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Jtoir6GHLbIztKzFOF4oLV5yH6NgdFUUW/uEl36rto=;
        b=S5ZQ8iswwBHBeVFHzBLWQJglcnxtZYUlkryhNO3FNDfMoUfE5shAtlke5iSFs7hb1T
         KRkUcgcZbnWmpLRCpptr/sSwARTZfsLv9m6jiXN/FSR5rT3je1kd77tieSaBdS9AnDQT
         c6DjEnLaJTC3GxMYzZZMxgJbKlHN53XR0lMsTSuqxNLw9xZYOyidHK80k3QIxzDi6Ym9
         mUZFyKSDcUDNz30S7/CYnkeJdy+PnrfbcKagUQkEGi2FZ2cIysz6zlqi8wJdGjVkahT1
         cc5fDsZ7mP3q4bM9bi/Iy+1mAy73jmoRIk60eK6AKu7mX/bq8sNX6f4NkTOB1Wqb4Pyk
         f8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Jtoir6GHLbIztKzFOF4oLV5yH6NgdFUUW/uEl36rto=;
        b=twn9uCLq4+XfE0SuH7Ty5PKqmTK5kuKDD4DSl30xUOkvasG/dCsupavGsLyjeFU2V+
         uhqEcVXrW2qxkL9TSyVJW7Rm8vOoNlm2E3ANrGAddo44dea4p1hZlIEDGFFGt+vPFFeR
         qMiRS5OiMRber7CUebu0zDuk8JmZ6+wPfP9Y3rBXW8DkOy/VEs8TrquBo+Cx2WJawBFv
         TmKglo3oXIKNbIf3VMiAubTcemoDGfXa2C0tkt+mFK+KA0/eynfVEtWzUau3o3zCl2xH
         gdrEmdnyv57eIMiWsF7xBwrXrkzuDXR7fx3VQH2yDyDH/7dfST7G6dXCN2jjM8itwYo4
         xiUg==
X-Gm-Message-State: ACrzQf3HB0a2DP1tBsj5U4qIdbo5zznJl+gTUF1fh/mkCptEaMdvgQci
        t0c11SURfTSbVLtekFwoJ+9Dvw==
X-Google-Smtp-Source: AMsMyM7YW/d9w8NTGoCcg+/aBPjpUrApGFBTb0OI8OFnBhgQYD5Ry8C1RfT4KTe0bdAfAAcbwskFXA==
X-Received: by 2002:a17:90a:fa46:b0:20d:5efa:84fc with SMTP id dt6-20020a17090afa4600b0020d5efa84fcmr26397924pjb.20.1667138584165;
        Sun, 30 Oct 2022 07:03:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id kk2-20020a17090b4a0200b0020d48bc6661sm2442833pjb.31.2022.10.30.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 07:03:03 -0700 (PDT)
Message-ID: <635e8417.170a0220.5813a.395e@mx.google.com>
Date:   Sun, 30 Oct 2022 07:03:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-lkdtm: 3 runs,
 3 regressions (linux-kselftest-fixes-6.1-rc3-2-g3d982441308e)
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

kselftest/fixes kselftest-lkdtm: 3 runs, 3 regressions (linux-kselftest-fix=
es-6.1-rc3-2-g3d982441308e)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.1-rc3-2-g3d982441308e/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      3d982441308ebdf713771c8a85c23d9b8b66b4d4 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/635e7437eeba738b4be7db7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/635e7437eeba73=
8b4be7db7b
        failing since 12 days (last pass: v6.0-rc1, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635e720099da6ea408e7db59

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/635e720099da6e=
a408e7db5a
        failing since 11 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635e71fb43925c2935e7db4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/635e71fb43925c=
2935e7db4f
        failing since 11 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
