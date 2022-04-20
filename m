Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26057508064
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 07:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359378AbiDTFI3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 01:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359377AbiDTFI2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 01:08:28 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF4628E25
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 22:05:39 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t13so552327pgn.8
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 22:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=MUifL90MdTE2zz88Yq4ulmwFtpCB5cBq7NsazWd6YwI=;
        b=DXqSR7lwIv0vrz0Qgr1H35yK+g7rDvUy2nNMCeOBVKLHLT/fefkFFpF7TPfpOWmS+M
         CNEc/Ytq6ENFK2tEFtm5Qnn5+4lTj7G4qx2WSboC63O9pKM+IefpZUfsO6aPtZjm77pL
         TLsUmtp0DlrfiW/x1digSSHZ6Yx2o6zWNKTLjTydmB0SI3MEkCWXjbHdu9U301hZhzWZ
         rOMUbQ6QgvukfrvYhDBgG1xc1wnhA++dzdqa2yMVUaDAM/JdGWYc3MTMTEQZ3BfAs/Fp
         7bUvl3mW7Er6c+dIA/WVTQz7THuTKJMzHjIRF+kt3TAdA3TtUYOAQ8wkLBlmQkPt+AtC
         9OVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=MUifL90MdTE2zz88Yq4ulmwFtpCB5cBq7NsazWd6YwI=;
        b=Op6x494Bn5ijAMX60n4Xco9C2rpOPkNLniM9nux//wKNHOW9LyT4SHuPk6FzuOl6wB
         zU+L4pDPr200DzftmDKXmNKjCuXP6BwzlQHQPgy61WYS1zvFusTSF98/NCBSATWsa2mg
         72ZkHmXNPUMQFjxhLsFLPA3Ln3NSM/GkP4hK9gnYYOgRU6qCIFcx3j+xHukjClyAVQN5
         A804TTxwdSXZBX0ddur/iMaFj6NMMQNjPIEWdEc0ENZUY16wr20l2zl6iJw9UUnzwgMT
         89E/Zal+tvbdlCv7xmXKzQeRKENXk9QzA6LhCwRJQbJjCi3UOIjm3RQxi4EFfeqIpEu7
         GJDw==
X-Gm-Message-State: AOAM532qq2mJlYFALd4lnfT8Gr9hSvTC7GHSw8TC8WUQQLogsBNR1N33
        HD3WFBRVZLIXaOt19MckVAsdHw==
X-Google-Smtp-Source: ABdhPJy8fhp4FwoEW6/qOQZQHUbGPR2/7t8WylvbjiTMiMigl/3yX0oNpBmKmhXkKh97pLKdMVGamA==
X-Received: by 2002:a63:cf0c:0:b0:380:fb66:fa2a with SMTP id j12-20020a63cf0c000000b00380fb66fa2amr17761975pgg.273.1650431138783;
        Tue, 19 Apr 2022 22:05:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7820e000000b004f7134a70cdsm17716888pfi.61.2022.04.19.22.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 22:05:38 -0700 (PDT)
Message-ID: <625f94a2.1c69fb81.ac83c.ae82@mx.google.com>
Date:   Tue, 19 Apr 2022 22:05:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc3-3-gabd26d348b2a3
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-filesystems: 7 runs,
 2 regressions (v5.18-rc3-3-gabd26d348b2a3)
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

kselftest/next kselftest-filesystems: 7 runs, 2 regressions (v5.18-rc3-3-ga=
bd26d348b2a3)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | clang-14 | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-14 | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc3-3-gabd26d348b2a3/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc3-3-gabd26d348b2a3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      abd26d348b2a366f8947e8c3c2ab9bc881ac9415 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | clang-14 | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/625f8988298d139edaae067d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-14 (Debian clang version 14.0.1-++20220415063012+3400d=
0293a14-1~exp1~20220415063056.119)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3-3-gab=
d26d348b2a3/arm64/defconfig+kselftest/clang-14/lab-baylibre/kselftest-files=
ystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3-3-gab=
d26d348b2a3/arm64/defconfig+kselftest/clang-14/lab-baylibre/kselftest-files=
ystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220411.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/625f8988=
298d139edaae067e
        new failure (last pass: v5.18-rc3) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-14 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/625f882bd3c2f2bc7fae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-14 (Debian clang version 14.0.1-++20220415063012+3400d=
0293a14-1~exp1~20220415063056.119)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3-3-gab=
d26d348b2a3/arm64/defconfig+kselftest+arm64-chromebook/clang-14/lab-collabo=
ra/kselftest-filesystems-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3-3-gab=
d26d348b2a3/arm64/defconfig+kselftest+arm64-chromebook/clang-14/lab-collabo=
ra/kselftest-filesystems-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220411.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/625f882b=
d3c2f2bc7fae067d
        new failure (last pass: v5.18-rc3) =

 =20
