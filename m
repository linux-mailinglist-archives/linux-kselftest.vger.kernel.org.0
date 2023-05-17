Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0749F7072EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 22:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjEQUXt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 16:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjEQUXr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 16:23:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A6B83C2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:23:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6436e004954so1287130b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684355024; x=1686947024;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z0zgUj7kCSuTpAhNqfMTsT/oq92jd1eLaQng+rzMdcw=;
        b=wbBrom3jCjO5KQs6wJGae/ya6h2Z7hMr2smeTD28iBQ1+bIB9kI4md0+OBXfFaYNRN
         YwkO3G6uYzDi0lCUlbemF+WSwhUVXxsuhPVMgRDWnTe8/YMZ5QsCaB1FyM+64POu1OaW
         ZMUy7q7PSMUKLziHIfvE4wqNrVd9KopsSddYQf6bkXrtCv8X0OsJXTHTTVaY7ie7jlIy
         ouEyG4fmubGzZglKhAnmAyCAbL97ow0kY3JZHr0pS6VQH0nzSf0PEOWRHyXoyx+P/wwt
         wv4D7b/KQe89qHauq46DjcxND7LJBC5dvr/jcVTDm1lnYiggzUxN6ONBkgH4MZTrE2JO
         x75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684355024; x=1686947024;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0zgUj7kCSuTpAhNqfMTsT/oq92jd1eLaQng+rzMdcw=;
        b=gFrxlgaaBW4Pm0uk99djTrhO+mqlUPXZGEOVav1XM0CIn0EauxqG34vff66mYHk6Vl
         6ffXaYFjV7X/LU4rO2spvcFWzumBRJOY3wq9MMsoq4JKIk/h4iGuVPgB1AuRHEhOdcb5
         6WMYF33r/uF0sV9zRBw9T2x/wyEtioEPxv8XwJGgD11Zu5IqW807oTYq0c8ybdsGydqS
         kiEIRZfqC+qsbru+3MFCga7Q1P3PctNarUq1aQ4rVfVR4MlIY+bBixvS1r+SWs/ksW9Y
         L89qNzEknmEy8fMVztZR0wt6hvuVetEJjN67EzMKsUJpOGuuUiobRDGfuJjMnirN2wBG
         mSfQ==
X-Gm-Message-State: AC+VfDxFnIVtm4d7ZHgh6LejyGQpy8plXcN0DGQ21+c98ft/4jrM7HCd
        bwB5S9cHYtA7e/2hwIhn4oHOAY0tGivhHD3qmdf2Cw==
X-Google-Smtp-Source: ACHHUZ4o7q0/eNmNye9nRaEh0OxywbcpvxWftlWRIGZ35eX0jOgD3s/KHQKJ1ddNILTVXEOzIgSktw==
X-Received: by 2002:a05:6a00:23c5:b0:645:b13e:e674 with SMTP id g5-20020a056a0023c500b00645b13ee674mr1156444pfc.26.1684355023927;
        Wed, 17 May 2023 13:23:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b0062e0515f020sm15539307pfb.162.2023.05.17.13.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:23:43 -0700 (PDT)
Message-ID: <646537cf.050a0220.fc6f9.f423@mx.google.com>
Date:   Wed, 17 May 2023 13:23:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux-kselftest-fixes-6.4-rc3
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-livepatch: 2 runs,
 2 regressions (linux-kselftest-fixes-6.4-rc3)
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

kselftest/fixes kselftest-livepatch: 2 runs, 2 regressions (linux-kselftest=
-fixes-6.4-rc3)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.4-rc3/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.4-rc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      dbcf76390eb9a65d5d0c37b0cd57335218564e37 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6465232b6fb64b151d2e8614

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kself=
test-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kself=
test-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6465232b6f=
b64b151d2e8615
        failing since 141 days (last pass: linux-kselftest-fixes-6.1-rc3-3-=
g89c1017aac67, first fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64652885005e0850c92e861a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-colla=
bora/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-colla=
bora/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6465288500=
5e0850c92e861b
        failing since 210 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
