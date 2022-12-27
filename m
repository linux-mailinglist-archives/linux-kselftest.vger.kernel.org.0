Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D916E656653
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 02:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiL0BF1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Dec 2022 20:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiL0BFZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Dec 2022 20:05:25 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34B42729
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:05:23 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d3so11878823plr.10
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A1ye6XZ/sgruhOXMcMZcJyuLHbyAu5MssW2pLfhgJL8=;
        b=2Iw3ofyDl3viJ2CUDMPmSiTbmaCTObbfXw63+wVaJNe7StN1QeQAJKr7PlZ2vdo5ki
         XDXGC0+2LxeGvboCME8J/+ekYaxj1/SAK2+v0oMFVPhdB6siggGEiA1rARoCXENvRrqM
         qxBBOVjlwKQsogCwTI4dR46jP68eLzkcmVaWL6/+/ca7uEvHw2T5Q9oiFCvEYKI9QcJx
         ry72Jd2bcOBY/eC/w43+P5kzzG9uZ9zM+9kpntmSOUp81s4ws054u/Ped4yduW9hqtuE
         jlB9lx66bFKMTVsv+AOwzfCHbaAgYoDfjaTYyK/c4y28AEbxVXEylG64nS6YMG3+Rk1B
         AjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1ye6XZ/sgruhOXMcMZcJyuLHbyAu5MssW2pLfhgJL8=;
        b=4kAYVMYuFnou/C1oWp9i7VRVtfIBDu9iNlkB6ma2yG2ynAhjzRqqa4DPWIr8im94tK
         X/QbyLYrYER1tyV6TggqE461G+Fn0KBsobNA/AMmaNAdwr4iszqbWl+kZ8vn4DvWOJPQ
         6DhzZDOjMCv1XHr5c1Q+zGST9d9esozjfyOzLcOca6i4nmt906qImNSd9ye1UYLCoj7g
         aTBf1SIRNXvkkqffUPJHzFN8yrxmvMBKp9qrPUzWukN7PjUoa+/rB4ZvH1AbccLXlmTS
         nUr0iFtIHgBfP3znkmri2Fjq/WKd1WoQf4HfJ3582hgiTgQaMypVrfu8Iga4i4it5xLQ
         cLfA==
X-Gm-Message-State: AFqh2koLPP5q3wieCnFCsDVcrlZsvdiK9lk48fPrN68n55RlPMbzodep
        +dyOEDGd2QbXNxwqfEjqw9233w==
X-Google-Smtp-Source: AMrXdXtlIIzLGcM0+upJCkjy+HXAJ8QPVzHtbFgAtpPpjY1BdHTj0/DLcMqopy2taYyKajl2LvyMAQ==
X-Received: by 2002:a17:902:e801:b0:190:d283:7faf with SMTP id u1-20020a170902e80100b00190d2837fafmr29047608plg.13.1672103123023;
        Mon, 26 Dec 2022 17:05:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b00189c536c72asm7671277plk.148.2022.12.26.17.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 17:05:22 -0800 (PST)
Message-ID: <63aa44d2.170a0220.6d0a0.e496@mx.google.com>
Date:   Mon, 26 Dec 2022 17:05:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 7 runs, 7 regressions (v6.2-rc1)
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

kselftest/next kselftest-lib: 7 runs, 7 regressions (v6.2-rc1)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | clang-15 | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc1/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      1b929c02afd37871d5afb9d498426f83432e71c2 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa3723fc66e337b14eee1f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-imx6q-sabreli=
te.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-imx6q-sabreli=
te.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63aa3723fc66e337=
b14eee20
        new failure (last pass: v6.1-rc1-24-gd5ba85d6d8be) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | clang-15 | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa384f8c7432e95f4eee20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest/clang-15/lab-baylibre/kselftest-lib-meson-g12b-a311d-kh=
adas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest/clang-15/lab-baylibre/kselftest-lib-meson-g12b-a311d-kh=
adas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63aa384f8c7432e9=
5f4eee21
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa3952ff58cce7e54eee19

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-meson-g12b-a311d-k=
hadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-meson-g12b-a311d-k=
hadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63aa3952ff58cce7=
e54eee1a
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa366efb023bb8a84eee1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khad=
as-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khad=
as-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63aa366efb023bb8=
a84eee1d
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa365a882f4d5fde4eee28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meson-g12b-a311d-kha=
das-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meson-g12b-a311d-kha=
das-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63aa365a882f4d5f=
de4eee29
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa37f809a37c9c1b4eee2a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lib-m=
t8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-lib-m=
t8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63aa37f809a37c9c=
1b4eee2b
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa364035bc8a93f04eee23

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lib-mt8=
173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lib-mt8=
173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63aa364035bc8a93=
f04eee24
        failing since 70 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
