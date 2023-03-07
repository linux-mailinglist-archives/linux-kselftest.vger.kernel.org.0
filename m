Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAA96AF175
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 19:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjCGSoU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 13:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjCGSnv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 13:43:51 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A15AF6BE
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 10:33:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u5so15090535plq.7
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 10:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678213966;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l1NeBGrev1LyOU8vqcdmu2s/IHsO/KK8t6mfkNPPHRA=;
        b=SNu417OKbDjDA1txVpItxqvJUVqzHhTOuZcSwKFJDOMXe0w49pzKi0ocLJ1BdQUqWq
         DUBgJyn+fikyIXOelH/rlHAbTcUYWsJmna1gIHsFkNiQRthM6y12IzgjLAZ84reryQT6
         G9E05dHjEJRxPMUve+jjRPLYXzBHlt48obsJHyjRxe56A5EC1EMphcB1K4ciookYSs2q
         fcgAZK1UP4YuideT3EuJ5qPgl1aFyqAIj2Yiwkbxsrbj/+StbTGBVERUdAFIIywSR2gX
         2npXN2zWoMsCyMDvIIW6x4IpLSSVF8KrDTMJzauovF6/IROvOiX8xuj6FnaCWYesReiI
         yXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678213966;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1NeBGrev1LyOU8vqcdmu2s/IHsO/KK8t6mfkNPPHRA=;
        b=GTOEZ/wOcUM4WSUVaL+y5byUb/wMUMzDl/RRHkU/f1mtt0mhIKGybNVWcehRc4+LtU
         nFBHQ+BkXvaWfI5BwcXN/KkQEdCcOOKf9aewqBE3gQTDk3ftZi64o210+Xrf3njl6rfw
         Yij4lksRiep9+rOisyctW1nRgAiHCIzWOUnwsMBqOiJ7cVTRpI4eUZ7m534aTlxJRrQE
         5q1USVdSvQRpqHSdxDMCjgg+yIgSBIXGObCk9fDSSEmVP3kEbj1INkRzv0zRezJOQUP+
         ZIADXmMVzLV9WpqGpkC4AigUUXv43yMwr5UfJprr8cbBsBEEflJCwOTYaZ/0wnPwKt15
         NqeQ==
X-Gm-Message-State: AO0yUKUSlku7qslx6byzOBs8xyQr/S7O8wW+/9SszEhEAtKIwgrr8o8+
        xs6HfU+xoZmOZ/SS/Zr7tCmBqQetxg9wFVXLGkFtZv3i
X-Google-Smtp-Source: AK7set8O8ts82vsZimDO3vnrGq2nj5vsyuBIjyRI1Mk2HYNy4BEg11s7jFUHyZkZ8Q0HSCZ0sqi7XQ==
X-Received: by 2002:a17:902:ab8a:b0:19c:d559:8661 with SMTP id f10-20020a170902ab8a00b0019cd5598661mr13177029plr.38.1678213966245;
        Tue, 07 Mar 2023 10:32:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090302d200b0019e665b24dfsm8837713plk.1.2023.03.07.10.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:32:45 -0800 (PST)
Message-ID: <6407834d.170a0220.bdab5.00fa@mx.google.com>
Date:   Tue, 07 Mar 2023 10:32:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-1-ge1e17d7debf4
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 3 runs,
 3 regressions (v6.3-rc1-1-ge1e17d7debf4)
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

kselftest/next kselftest-lib: 3 runs, 3 regressions (v6.3-rc1-1-ge1e17d7deb=
f4)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-1-ge1e17d7debf4/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-1-ge1e17d7debf4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      e1e17d7debf486fd3b757df9e009b8d109e4be43 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6407738b05ef778ed18c8648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6407738b05ef778e=
d18c8649
        failing since 70 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64077782ea66f63c348c86e1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64077782ea66f63c=
348c86e2
        failing since 140 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640777d6785d43e8eb8c8698

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/640777d6785d43e8=
eb8c8699
        failing since 140 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
