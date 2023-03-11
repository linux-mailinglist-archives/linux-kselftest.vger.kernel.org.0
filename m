Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F626B582D
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 05:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCKEhj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 23:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCKEhi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 23:37:38 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1013011F690
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 20:37:37 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id kb15so7219986pjb.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 20:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678509456;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w91227JqYHP2N3gjEX8CngAEkDtQ2z2CZ8H5MRjRWhY=;
        b=ZoBueAtOTtwTabIIkdRJIUnvOaDJLYY/PrLeAEzbHXoWMaoL6hantEwiYc50AbI5VV
         AbYC1iIVqdYFNb0FfT3OseMa3RQUNLDrBpGdGVn5Z4nQ9MMG16aMpODp71S1m6+QVRJg
         yxxPI9KHvcSaXleTwlWewXIgJKRBM/djB2uZA7eMbLXmoNfxf2DBHrMZtrOC17zQ8Hy7
         PHi1LVe4/Ez/CexyrUCRQmpO5r9UDEnL55O0CAhoyWFtmdXt7VqkUbObFnKl6UiGcXdW
         oQLddPsITtLPklsqc40+TPHzYxcoFFZljHR4rDifPHowQDz13UX6LMA5D1qJIqTgHux8
         idaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678509456;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w91227JqYHP2N3gjEX8CngAEkDtQ2z2CZ8H5MRjRWhY=;
        b=mNH9xzq1o4XF3NZjE5ddqFug7+fjJci51p8qF5hCb1qCL9A16t6r0CL8Tcq8swxp1k
         hIz1rhtc+rn+CF66Nq0D20RVCUOEuAltHVlTvmjpmI6rsB3gR5NgY/taezRo5Wxm+80X
         LwRkhpSnTp8ndYc/cJxay8m2uozdZdQavwN+PviuFod9daQ42Wlt+l0oJDvXyCNE00dZ
         ge1tw3vn99Ui9XX+paKJBwpgs4NWaSXcHFzusCQXFG9fkAsY4YM9LcpZPF9+fWzb3xEb
         ykzMKTdogivnrvbagqorUfq0T5bj9is/+lU9MNJHi5ywwBgXsqBCAEGN1eE4kbqGXOLx
         ZAkQ==
X-Gm-Message-State: AO0yUKVBehcCZi2X8JVGjK2wbU2MutjWwc/VfDA3RE8NLT1XrudCEiei
        Sn67yT2xy214x7nWDDl61ruuPQ==
X-Google-Smtp-Source: AK7set+nmQhgWO2r7L+ZMUmvOeP4lqDoeFvgmGhJz56MZA27Pm74VXwcMhDkA5wk3yj6StsCU2tfFw==
X-Received: by 2002:a17:903:2281:b0:19a:9686:ea85 with SMTP id b1-20020a170903228100b0019a9686ea85mr30853569plh.17.1678509456564;
        Fri, 10 Mar 2023 20:37:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b00183c6784704sm673682pls.291.2023.03.10.20.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 20:37:36 -0800 (PST)
Message-ID: <640c0590.170a0220.85edf.22a9@mx.google.com>
Date:   Fri, 10 Mar 2023 20:37:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-2-g624c60f326c6e
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lib: 4 runs,
 3 regressions (v6.3-rc1-2-g624c60f326c6e)
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

kselftest/fixes kselftest-lib: 4 runs, 3 regressions (v6.3-rc1-2-g624c60f32=
6c6e)

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

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
3-rc1-2-g624c60f326c6e/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.3-rc1-2-g624c60f326c6e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      624c60f326c6e5a80b008e8a5c7feffe8c27dc72 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/640bf56b4beda27a5f8c863e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/640bf56b4beda27a=
5f8c863f
        failing since 74 days (last pass: linux-kselftest-fixes-6.1-rc3-3-g=
89c1017aac67, first fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/640bf7afa1042534538c864c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/640bf7afa1042534=
538c864d
        failing since 144 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640bf89b5b23c40b588c8659

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/640bf89b5b23c40b=
588c865a
        failing since 142 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
