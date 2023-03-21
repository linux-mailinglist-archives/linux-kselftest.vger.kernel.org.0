Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19666C2E92
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 11:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCUKT4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 06:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCUKTz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 06:19:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B140AC17A
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 03:19:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso19711497pjb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679393979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3x8gJGuDWETW4/JTboyknnpCK05SnBr9ujSK7I1BR7Y=;
        b=6iYayN1ySFw4DNnVnO/6ZVCMzIspEgZrHU+UfF/BSvogGlFWRk5YD/Y7fXAP2V4ohp
         JM6ievgH08naiTfdhT8hkjL39o4U11LhR7M7MtER3w5uyg8b/BvIlZGx3DO/Wlcmts/t
         11veGl1WErBhZZT/tm8fmNR+lr0lWi0PeC+2wEU+01BBtEMvE/bhNVVovVWZgu/66X3D
         dXRGVLedrAwf4P41ZuEo761CtnR9VPm3vJimLsILrxRh2j1p5oWzueeQgbh0P5XfXQHY
         Y6n1MBCaJSAO+0LdgYmgdfjaR+FGy8HoefXTvsLz0gw3H1BVp+d/Ab7W8zDd6KtlwYvf
         ey2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679393979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3x8gJGuDWETW4/JTboyknnpCK05SnBr9ujSK7I1BR7Y=;
        b=VOcm8+DljbEUIWbiZKDOHDHWEF0m2NsI8SX+qZRZhRAuQBvaY1eBXEUf3Gke1t0mNL
         TZ/igd9yon7FM02Zvg+a3DEP1vo1no7pSiJIV+u3TBAxuXNbFxT3oUBYyeeWHlOOemaA
         iZTZ2hfJ/H899zjXfSkxJSWec+NbZ+KxHk9rrpEcKYX1HtJ3c5jhqUqxxEcd5u4/khb/
         FwNKN+cUd5JQVwMX9PL9f4g95c5S+8GnzlGaOFNw3hRCC6FgO7fkjdcK4PpIErUKwlNB
         eAC3mTItmzJIYeViIR7gw4IN6dw+AhYrURkSeHxn6am8KFILLuz4zGoCI/XpWcu7nNKv
         b+3w==
X-Gm-Message-State: AO0yUKUGZG81z0YkciO4bqc3ZYqjFEfZOx9NVs+hQVocZvaVst14vuby
        5FNP4NeX6uqWuKyFnZXe4yZYvg==
X-Google-Smtp-Source: AK7set/IgA0PhEzzu0BG4z+wQ45lTse6M/HXpLrRZs1KXdW1dSqLHPewG4Ta/h15y9MthFE7IHvH/w==
X-Received: by 2002:a17:90b:1bc7:b0:23f:6d4e:72b3 with SMTP id oa7-20020a17090b1bc700b0023f6d4e72b3mr1865837pjb.25.1679393978788;
        Tue, 21 Mar 2023 03:19:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090aaf0400b0020b21019086sm2074323pjq.3.2023.03.21.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:19:38 -0700 (PDT)
Message-ID: <641984ba.170a0220.a5bfc.0c16@mx.google.com>
Date:   Tue, 21 Mar 2023 03:19:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.3-rc3-1-g05107edc91013
Subject: kselftest/fixes kselftest-lib: 2 runs,
 2 regressions (linux-kselftest-fixes-6.3-rc3-1-g05107edc91013)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-lib: 2 runs, 2 regressions (linux-kselftest-fixes=
-6.3-rc3-1-g05107edc91013)

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
ux-kselftest-fixes-6.3-rc3-1-g05107edc91013/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.3-rc3-1-g05107edc91013
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      05107edc910135d27fe557267dc45be9630bf3dd =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6419768d298611d7239c950c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm/multi_v7_defconfig+kselftest/gcc-10/la=
b-collabora/kselftest-lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm/multi_v7_defconfig+kselftest/gcc-10/la=
b-collabora/kselftest-lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6419768d298611d7=
239c950d
        failing since 84 days (last pass: linux-kselftest-fixes-6.1-rc3-3-g=
89c1017aac67, first fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64197539dbcd9d64ef9c9520

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64197539dbcd9d64=
ef9c9521
        failing since 153 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
