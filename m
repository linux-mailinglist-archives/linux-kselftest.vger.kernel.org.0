Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4276DCDA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 00:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDJWnf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Apr 2023 18:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDJWne (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Apr 2023 18:43:34 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD0C1BCC
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 15:43:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso8996745pjs.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 15:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1681166613; x=1683758613;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y918wImN3jrW4Kx3kZxDbB0FzkKDq8S71AJQs27YjsQ=;
        b=BDJLYn6uS8i1p8xS1IMUo4dLx6ZDi0gkUY0b/Yu+sNHYoFf404e5QxFGKfrq+932dG
         akNLZohxQkzbSFVjJWg+5eRiAFoR/t8DGS8vdCW3Z5yRrwe+YA0/eHfmzz76GAutgsyr
         9zrUArCu1czD3mqBxv2JUOupto5hXeQwn01X/ye6HKfodr9uRGNMgaIJHTRl7bc/fwFU
         h9IW3cV1gQGfJmK91gYjhxYV3dSuHokvnA4zE6Jo4qXsX3SSlYZveMMuWknXdkMAz1ym
         qABn53VkmXgeB11QEhXY9Wa/2p9UNgoXkA+rOnwi+KvYSFxHMb78fdR/jGNAlTYNJqpQ
         2K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681166613; x=1683758613;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y918wImN3jrW4Kx3kZxDbB0FzkKDq8S71AJQs27YjsQ=;
        b=xYxp5QQGEjtoDiNzeEB2vGM89tusgfQnS9sDhWs5mgUconCrUrwyK6z5YabV8RV2zK
         Ucp5HspfbNl0cau+RX+qtuOZ8dwf14iEIRnaBup+wLdIpjnehk4h8iZQSwfdSSRtF8M0
         w405yXQEJ6vfnl0IkC0Dl4ei4tSsKzP6QSxhvlccifrhS1u+GhRg7R6gytmmCgVioZKq
         wIIZkj3RD8r+714UukngIc+wfucjqeHTNamCFnStZDKtHxiGO/xuH96KzFHLNPDE8yKV
         uWdrC0B+ojSTbsNXiogNT9RxifteGEEjnOhVkdqLt1YFWI7ytIrp25/9BsL+A61BtDYS
         eEkA==
X-Gm-Message-State: AAQBX9c963gHx+Ao8kWC194YRKvnWaooJH1RhwN1AcsIMV6g6DpqW4Be
        AUt2gU0QN9LEIwEnw52D/L9hpg==
X-Google-Smtp-Source: AKy350Y78DK+SHGehfpl7MpzWhdCsRI7up8ufF4hPIAH0FP0xxWo8hIN+veu9ZJPTSeFiz/FSt9rqg==
X-Received: by 2002:a17:902:ca95:b0:19f:27fe:95c3 with SMTP id v21-20020a170902ca9500b0019f27fe95c3mr8233445pld.41.1681166613411;
        Mon, 10 Apr 2023 15:43:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z19-20020a170902ee1300b001a4f7325466sm8138341plb.276.2023.04.10.15.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:43:33 -0700 (PDT)
Message-ID: <64349115.170a0220.dabfe.f913@mx.google.com>
Date:   Mon, 10 Apr 2023 15:43:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-14-g5874a6a187f2
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 8 runs,
 4 regressions (v6.3-rc1-14-g5874a6a187f2)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-lib: 8 runs, 4 regressions (v6.3-rc1-14-g5874a6a18=
7f2)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-14-g5874a6a187f2/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-14-g5874a6a187f2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5874a6a187f2e814542d7fdf918fd29f79ff25c3 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64347baff9764bbe142e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64347baff9764bbe=
142e85f2
        failing since 104 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/643484e97a3f9d9ae22e860a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/643484e97a3f9d9a=
e22e860b
        failing since 174 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64348ae2cfcb1b8f342e85ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson=
-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson=
-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64348ae2cfcb1b8f=
342e85eb
        failing since 172 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6434819b365b6ccede2e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6434819b365b6cce=
de2e85ea
        failing since 174 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
