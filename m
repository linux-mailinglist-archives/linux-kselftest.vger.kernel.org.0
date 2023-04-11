Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270116DE7E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 01:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDKXRX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 19:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDKXRW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 19:17:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338081726
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 16:17:21 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p8so9503454plk.9
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 16:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1681255040; x=1683847040;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2idc3SFgjN6Ec+n58XVcndX1VfOe0CQwKH6pdqvGWyQ=;
        b=cjcqwep4SmUCHRkWqnUdwWWEIGcsClnwhTU3Q5hnoasCuzIN+KwAyCTUoPAVqjiCU1
         vXhsdBkKFdKRBQIAVitisG+IH89j2Y9MZ9LIfGe3kcMDkEJpJFPRMkIigrylpG2FQCL6
         20YCIOj8dKdrCkj7APL8SPg8hPzcZhWRoHwgm7RUyqbiOBL2rP2sj8A5/8UkssN9LTw5
         E1oF7bscw3Sxidp4scLgWnp8+uzs406FbSW+lOJR5NA0jD5OlcrdnnU130h42WDKPh3/
         W1qeyEllYRkzNN5tU3J68MDSeP48M87d9YyS3mdOvyNkSEqpycYiQ1IKnPn/FcEhMEBR
         1Y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681255040; x=1683847040;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2idc3SFgjN6Ec+n58XVcndX1VfOe0CQwKH6pdqvGWyQ=;
        b=KQxhNgpAPfGyuzwD9zzuqXI/5crHSpOYiRaCbGRAYZ5FHvFGKqW2U692Gm66XF61tp
         zYQfovrJat9WJR+O4ruKBcnfOcN6ONbxRuW/ukKl6AF2ur2GnWMOkRg11bR+lHerTZim
         PUyVDVIH+Q2eAytKcZIJGsjv7di9k3ZofSCoMil/HziVDaD+qxmg7L592Z1xIK6phM92
         z51DZhdSwJh8jyh3Iw2z9xBpqhSIuyifv2Tn+dS5C455iigmw6HqX/oM6/Qq4/g7wGUy
         L9zuKPxdtUsO3zOvYNrBwAMwYP+DkA19mP1gRffQZfElNwYKEQw8EhXVh16AIAIR4Oop
         O0/g==
X-Gm-Message-State: AAQBX9f00vcswV1Q1+FA9XQOjx/0yN3/+IJsJ64hLzMAK+P8cp02HrBY
        zvfe7qRfddLfW3WCl07ajfAD7Q==
X-Google-Smtp-Source: AKy350ZxO6A1V8PPvrC9nRSbLXJxJFU1BnNTpYpX0Qu6ZNm8Cmcxw4/NANY2uU/+LFIyMN439t9qpQ==
X-Received: by 2002:a17:90b:3903:b0:23f:7c82:2468 with SMTP id ob3-20020a17090b390300b0023f7c822468mr16895380pjb.31.1681255040667;
        Tue, 11 Apr 2023 16:17:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id co16-20020a17090afe9000b0024684c6db19sm135776pjb.21.2023.04.11.16.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 16:17:19 -0700 (PDT)
Message-ID: <6435ea7f.170a0220.7c88.0947@mx.google.com>
Date:   Tue, 11 Apr 2023 16:17:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-17-g266679ffd867
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 7 runs,
 3 regressions (v6.3-rc1-17-g266679ffd867)
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

kselftest/next kselftest-seccomp: 7 runs, 3 regressions (v6.3-rc1-17-g26667=
9ffd867)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-17-g266679ffd867/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-17-g266679ffd867
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      266679ffd867cb247c36717ea4d7998e9304823b =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6435dc7e25588a277f2e85fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6435dc7e2558=
8a277f2e85fe
        failing since 105 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6435dc6f25588a277f2e85f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6435dc6f2558=
8a277f2e85fa
        failing since 175 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6435dc52e7ccc9b6702e85fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6435dc52e7cc=
c9b6702e85fb
        failing since 175 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
