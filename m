Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934B754EF85
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 05:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379785AbiFQCpc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 22:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFQCpb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 22:45:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0496540E
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 19:45:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a17so791979pls.6
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 19:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3xh9lqpEIL2sga2iNFwml8RFiVx2jUHDkj7pVPZUNtw=;
        b=8F/C+R79CGZFBk37C+dpjxU7uopuHhyqGj3YML2oSyQjv7Dq/w6FfSp+FOhlc4RqI0
         pSJ8QdB8231hBHp4gGDk1+JjvvBxML8HhJjpCuBWijRACndv/ab9hS336Pazwu1sxWTe
         VcZuHd5d5QZkmDekwmENLAplmYED9FIkXT6lreOAWmuqKQ9DB8ex3gzywuv7DtFZQ7xS
         +XFcwrF1slKsXNBb+OijsYaWu8ogGJxgH0fClxvstc/PwPIKd1S6y20lSeyo5Q1q+QqF
         8dlwYQXDDCnk2F/HM+Xz9nMXiypEt43x5w2S98ZbmdDlnQzJ61SZBVPOTABXcsnlCiXX
         VOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3xh9lqpEIL2sga2iNFwml8RFiVx2jUHDkj7pVPZUNtw=;
        b=0+DW5YfLUvuf6iZRgKJJb7kWir5bDMItWl0cCCALDjvOus9jfIwUlcqGzd8r0Ew/cG
         aYKh+JklBGdM6PovSEYQWpUeUZ4IRH8G9a7EdiB5sBFtm8ypvLpcL07Xou+3eQ2aL7jt
         npTGpxe25PJbdYTuuSuX6wYZxhoEbxXlvYV3UGb51CgdtHUeS4s36Twc/0bHSUjaNbCA
         7ArWCSmbFea36q7Pr6GqQ7M5e8TKJcLohK2DqqXhKM+9V9iCHQr9gOyes9lUumQf+FSH
         mOr6o0zXyEJ0JpWIXmS12BOEA0xIjvnHltqxmRewrOBhVHP1Rkhuufyr2Vgx8us4hh6e
         k6Kg==
X-Gm-Message-State: AJIora8tdNF60f+k4f8jmD34XQVug1z82F+IXZV1dmtWy/JE64uAMkRc
        5MwFp1Sf1sk7yI/HVW4navE2fHCLRqUhNC9woFM=
X-Google-Smtp-Source: AGRyM1v0PX+F4lE5u9XxL//PT3OGgHzSVhW6WZUpZ9in5bzPW7zqCL+JlbCqUY4tX+mmMpqxkEN9RQ==
X-Received: by 2002:a17:902:e54c:b0:166:6322:e747 with SMTP id n12-20020a170902e54c00b001666322e747mr7452142plf.151.1655433930418;
        Thu, 16 Jun 2022 19:45:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d13-20020a62f80d000000b00522d206bd04sm2524437pfh.178.2022.06.16.19.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 19:45:30 -0700 (PDT)
Message-ID: <62abeaca.1c69fb81.da07b.3ad3@mx.google.com>
Date:   Thu, 16 Jun 2022 19:45:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc1-4-g9b4d5c01eb234
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-cpufreq: 2 runs,
 1 regressions (v5.19-rc1-4-g9b4d5c01eb234)
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

kselftest/fixes kselftest-cpufreq: 2 runs, 1 regressions (v5.19-rc1-4-g9b4d=
5c01eb234)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v5.=
19-rc1-4-g9b4d5c01eb234/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: v5.19-rc1-4-g9b4d5c01eb234
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      9b4d5c01eb234f66a15a746b1c73e10209edb199 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62abdaae5c31e13acda39bd2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v5.19-rc1-4-g9=
b4d5c01eb234/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-cpufre=
q-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v5.19-rc1-4-g9=
b4d5c01eb234/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-cpufre=
q-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220610.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/62abdaae5c31=
e13acda39bd3
        new failure (last pass: v5.19-rc1) =

 =20
