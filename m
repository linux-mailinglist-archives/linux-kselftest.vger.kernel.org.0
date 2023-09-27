Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B350B7AF8DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 05:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjI0D5G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 23:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjI0Dzy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 23:55:54 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0223F59F2
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:16:41 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77574c5979fso17240985a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695784600; x=1696389400; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fIQeR44823yAEpOfbp5VmqDEOQEZFCNa7aIx5njGKPw=;
        b=Y8rGEUN2op4rzoyxN2A5+Zb6OZcjMUa9tsaBJKecPZj7X4oJLKgix9ep9gTIHReKYU
         lSZ+2ZJK2RiuuS8/uIZW0jlalDwZrorXzC/0xaNuJi2FtjUZyUoXS2z3EaPBHKRZeNSt
         9D55br9ZM4+7/8U/bXCf/KXyiW0otgpqkZ8DOF2e5unuRIL6hl0VVUqpAQVr9hSX8D+z
         r9KNPWYU4S5KtiUx637N/8c52+0YvqDmxno4Cd/RxP8H2rJNjMQci5G1BtWsMKHZKNDf
         Ubuykw618Z1baZ3fWQH+qHqfAWNUPFbPK0E7C9RaEa2BKFx2FwhGNvcg7UmocaecT8lr
         raCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784600; x=1696389400;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIQeR44823yAEpOfbp5VmqDEOQEZFCNa7aIx5njGKPw=;
        b=AWzfdv+TfDrJv3Amb41ujXQRcEBRcPECfbPsab+ObBMYoTAeRJ/7qZ8kh7HZZDivSH
         iqNCAeyfgO/UOHxQDfg+qVwnCcQUqKRi969XooA6CpSpVn8yYYX4SaI0QZuJbHyNkgW7
         Lnbq2TTZ8okFH/gS4Ef9FX/CHHOMcOx6YL8Mw9XU0X1WiEbag2vOaGM7Wobi4ahhO1+5
         gCSTMz10/D6HEuu6myrfkx1GHFLP+CVT+ne4r2deseQUXsgmBUf5wYMPdghNmJsWt4w/
         hQ2ohtGk0uOE43+EyHASi+zQalNe3gRdkaZWQqS/ZF3UlIUMHk6sdETh+vxi8NsGysuC
         TmHA==
X-Gm-Message-State: AOJu0YzWOxD0WmJWR6/wPPLTxlPdQz5ChJe5N3pYj9ND7w88Kk404pln
        fJ6KGbdXB6F3rB51/dTrXZG9Q3Tx2xzrrqEB9Hiriw==
X-Google-Smtp-Source: AGHT+IHY6uLIpew1rjGZOiq0/6miLEQ9U2P6czyEqltslWlk1wmM1tWkQdIJAu+emOG2IMXSzmxD3Q==
X-Received: by 2002:a05:620a:2092:b0:774:2915:d180 with SMTP id e18-20020a05620a209200b007742915d180mr775764qka.37.1695784600062;
        Tue, 26 Sep 2023 20:16:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7851a000000b0068a2d78890csm13686pfn.68.2023.09.26.20.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:16:38 -0700 (PDT)
Message-ID: <65139e96.a70a0220.9a536.0083@mx.google.com>
Date:   Tue, 26 Sep 2023 20:16:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-seccomp: 3 runs,
 3 regressions (linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-seccomp: 3 runs, 3 regressions (linux-kselftest-f=
ixes-6.6-rc4-1-g6f874fa021df)

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
ux-kselftest-fixes-6.6-rc4-1-g6f874fa021df/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6f874fa021dfc7bf37f4f37da3a5aaa41fe9c39c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651394dcf12a3a434d8a0a8a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/651394dcf12a=
3a434d8a0a8b
        failing since 331 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651392edd11cf0c92c8a0a5e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/651392edd11c=
f0c92c8a0a5f
        failing since 342 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651392c0d11cf0c92c8a0a48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.t=
xt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/651392c0d11c=
f0c92c8a0a49
        failing since 342 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
