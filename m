Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977857233E4
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 02:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjFFAC7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 20:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjFFAC6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 20:02:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E337F9
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 17:02:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-651e298be3fso5276245b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 17:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686009777; x=1688601777;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RK13rVz0BVnqw0pYzzDvcir10s0jRRMldc5Adnz+//E=;
        b=JoJeW2ATLAWi4tfLD5G4cb5oDDmpwKfaXbQkPubldeP5B/8KvC1KQsD7eoZ+B+CteL
         j+7UmtT73pfmLmZeN1Jb9uaiHRei/y4yCUd+Kq34ouJBL+j+KR2I3wQCJxYkXKyGq1uJ
         3ArEjuX4x9GqivSWQKENw1f+lZLs4wRhAaw/JloMTDCiiiGUkFcuJ7stcsCrVW3Fwvvi
         fxikCFBLk/koFOUdNyDao7qqcaQ1q9SNh6FU3jFswLwxOKnTHYZlreavbdpf82N0pCV4
         EGbgFUvdkZ9ulFUbhuThWdiVjrMG0R7mDqn6Q3r+vt/bWSPwcNs8ji+v7euRMmtyP3zz
         hJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686009777; x=1688601777;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RK13rVz0BVnqw0pYzzDvcir10s0jRRMldc5Adnz+//E=;
        b=D3mlKw4rLUbzz3j+XSzWEQ2H1oV5e0RiLVAS0jPd8Cx7Y/1v+dEOCVXj3XysBVtuG2
         r/vTC15N2ErEw/VkWxmbLFFYJ825LycZPt18DcT5/wrTdMiDYwW016+fcoaumQFowXoq
         rx4A/LMwL/xi8mp7EnEt8njDaL08UViQqKkBfdHrUtT+DLAbwqqmsOhUjN5z57PlR+EU
         m73UXHTlBbVPp0N9kDsaaGom/MQIXvx+iibPc8KvqJxr+rWklzdglsKHHreTvOb3VPvg
         6eRGLlh6N4X0nskOjQ6HSqipqTWHty3BWS7e91MOHV0ANgxaP69pGblvKq3Amd56nvYL
         wgBw==
X-Gm-Message-State: AC+VfDw7pKaERuZDqwqi1SbeQo2wH6eQdRSHf9W4S3PTLlQ72HpwXyD7
        eChPLe47ZMBlrT79GmRYTKsmDw==
X-Google-Smtp-Source: ACHHUZ7T9t5eV1QNPQgr/MzvySzrxXMeFKRZwbHbi+ZTsJd17U4abNZWaCGzrF9+arJScdWAoX8cUw==
X-Received: by 2002:a17:902:d490:b0:1ae:10b3:61e9 with SMTP id c16-20020a170902d49000b001ae10b361e9mr498153plg.65.1686009777031;
        Mon, 05 Jun 2023 17:02:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g16-20020a170902869000b001ab13f1fa82sm7121873plo.85.2023.06.05.17.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 17:02:55 -0700 (PDT)
Message-ID: <647e77af.170a0220.4394d.c5f9@mx.google.com>
Date:   Mon, 05 Jun 2023 17:02:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc1-9-g4d1deb59f3ff
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 4 runs,
 2 regressions (v6.4-rc1-9-g4d1deb59f3ff)
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

kselftest/next kselftest-lib: 4 runs, 2 regressions (v6.4-rc1-9-g4d1deb59f3=
ff)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-9-g4d1deb59f3ff/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-9-g4d1deb59f3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4d1deb59f3ff643bd2d442bdd4dd5f58515a1629 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647e64ac2d49db397ff5de32

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/647e64ac2d49db39=
7ff5de33
        failing since 160 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e6ca44c078d9c06f5ded3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/647e6ca44c078d9c=
06f5ded4
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
