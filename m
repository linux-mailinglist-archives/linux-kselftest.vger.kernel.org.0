Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE73612ADD
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 15:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJ3ODH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Oct 2022 10:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJ3ODF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Oct 2022 10:03:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A8EB49E
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 07:03:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v17so5673595plo.1
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IFykk5VP73K3/DSGh/3eQsOFQXoSZJCju8jAvk4c2QU=;
        b=1RaoDYAqyCLFRnsn9CXK1TuVk/H4srwPdkaQJYO4ARlqnu8VnrG0UJNsPTLXMZX45N
         uoaA5rUBB5uyQclE4NRCFkvtblaCgJLUygMvb3kVOq2NDKWFZzpd+Rj/ua7uTrx9h88r
         xxqAg6sRcxiBmK+iB2dbVe4BlZUWZcqqXfVVr9LCzssyT11mmLhzUnFNn3SM7fLnsiQI
         s/ePdk9menQMwZF+dsymEICv4FDx6Rz93T0DXkQPbEF8RXMDKBFSsEacL+iG9Rauqze5
         HjYLepAhaxEIPx8yfTkVYZ7VfMgY0iY/CEPAu2F9OdL/oLOUi4MH/9Bb04P2UHl6h1uZ
         dkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFykk5VP73K3/DSGh/3eQsOFQXoSZJCju8jAvk4c2QU=;
        b=3mciPlH62WtsiAk2YLSyjrA6L2m8qZqbPTfWscimPOegQCO8+eJ7tD745v6oqpYKT0
         FLfMesRdUmuWQFwXTTaEDcK6JTyWJYcmURwwo1IZ6ZTulgWyAHhchSnGWleeZSzKS0XM
         A9uvw9H9uCWBcTiKRtGO0LvcO/OUG4LRTOpD3J4JZ81eu/PtSzbXaomiDMMZrfjMDCHi
         8YySAY5e2JAmNqGD9M46oRhPKRdzowbHxyXXR8oPTJVVolikps6VImMeXAU3cnFfawaL
         cbkoQ15RXOGSawRqvSfeVAHzzDtkrGpfPgYmKqbZtOY6fx9nVykapFuSk/sxNnRtmyFp
         MrfA==
X-Gm-Message-State: ACrzQf0jSdPZkIXPXA9k+Hk/6yke2J+Ihf/GinGoVTs7qwXP2//hORmf
        aRmI0NbOVDcopNCT4Aacmjz0lg==
X-Google-Smtp-Source: AMsMyM6mPuidFLXin8KeoXIR9tVYEP9Rg7By7T8sqHrPociPJVDcp9S5Az33ZaVbNaUAyvOOMQJHuw==
X-Received: by 2002:a17:902:9b82:b0:183:fffb:1bfe with SMTP id y2-20020a1709029b8200b00183fffb1bfemr9585086plp.173.1667138584665;
        Sun, 30 Oct 2022 07:03:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b0016f196209c9sm2752485plh.123.2022.10.30.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 07:03:04 -0700 (PDT)
Message-ID: <635e8418.170a0220.2e5ec.4555@mx.google.com>
Date:   Sun, 30 Oct 2022 07:03:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-seccomp: 4 runs,
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

kselftest/fixes kselftest-seccomp: 4 runs, 3 regressions (linux-kselftest-f=
ixes-6.1-rc3-2-g3d982441308e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.1-rc3-2-g3d982441308e/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
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
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/635e791d0b6ad2c57de7db53

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/635e791d0b6a=
d2c57de7db54
        new failure (last pass: linux-kselftest-fixes-6.0-rc3) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635e71fc43925c2935e7db51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/635e71fc4392=
5c2935e7db52
        failing since 11 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635e71fa00e160f2bee7db65

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.t=
xt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/635e71fa00e1=
60f2bee7db66
        failing since 11 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
