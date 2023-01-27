Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7114C67DCD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 05:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjA0Ead (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 23:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjA0Eac (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 23:30:32 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E856E46177
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 20:30:30 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso6746377pjs.4
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 20:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pHS5sj2TdT+t226wnjKR//rf5uzyDghZko6CEQ+y7yQ=;
        b=3fE8h3P5r4vq7CUVmkD1gFnIXFLjQCBJAbt5jtbReSM7JsQS9rrHuLsc+RVt/DY03C
         TyecmdduSDuxHaXEOAVnK4MurFfaaqM+L7jIA4bGAGDXA2lRdg+IsKNaq3OjUmMNtbpG
         RgdbbFyOh5YT98ixB3aZGwKIkCHiKTYn00EeHVXYKQ/B/wjSEszE4P8y71qZ8h5U4Log
         bf9yGJE7UhOqCJse3lTCGDkdbl9MyV200hXn4GrPhVw/iO42/+MR7SfxfwecRZfoA73x
         0ob/0OwRQiFWUg6nArC3XvIciXByRi+jD1caT4m9HEjv2SF7B1WPLPERsbd+L6z0qAW8
         hzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHS5sj2TdT+t226wnjKR//rf5uzyDghZko6CEQ+y7yQ=;
        b=uYZQbeKTGCYoW2DZgwNKCs7CB6pCugDg/JuFPIe+1JxXR2GBRAQ9C8UpY39UKrDwTK
         UnzuoVO5NbgTKtcwIxP5dxf0cvSKAU8+4mUPpR1Equ7oBXcmyuzEPcgB8OGKcf+3S1EI
         JyclO+jBjhg47wq0XfNyfUX0aeBio6biQ5XIzge5s/1kIzyHMRngkRfgesW4PbWw3yRp
         yzL2XNCNt4Glh+3epvGuzaAmOn/3NTqwwtmpJAAUDDMzX3Y2RcJieauw5FUKClv33to3
         WlkjdywWeVWlyUfOa02+JwlyLrj7Om9EJUCfITR+OB7PolwuEogAgGoKCBnM1S+V3ows
         V3qg==
X-Gm-Message-State: AFqh2kqTzZdTUbQQmRCZJ6A2vuuQbUyDYmPsXYw/Xm4AQUEK5moFvpHN
        Iuqn0ByfNUtk8VK5V37IhIbqkN+CBuSKpf9fZFk=
X-Google-Smtp-Source: AMrXdXse8x6MZ5a6+sCn/SoitLCef7toN2xt2SHmU3AuNzefcruGgg0x2wWGweVgNq+shaZBLM4JBg==
X-Received: by 2002:a17:90b:1e10:b0:229:f562:896e with SMTP id pg16-20020a17090b1e1000b00229f562896emr30326520pjb.36.1674793830379;
        Thu, 26 Jan 2023 20:30:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f9-20020a639c09000000b004b4d4de54absm466555pge.59.2023.01.26.20.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 20:30:30 -0800 (PST)
Message-ID: <63d35366.630a0220.c3b6.0e27@mx.google.com>
Date:   Thu, 26 Jan 2023 20:30:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-1-g65177e47d303
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 4 runs,
 3 regressions (v6.2-rc5-1-g65177e47d303)
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

kselftest/next kselftest-lib: 4 runs, 3 regressions (v6.2-rc5-1-g65177e47d3=
03)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-1-g65177e47d303/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-1-g65177e47d303
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      65177e47d3035c083cff034ffbfc7ab750a4675c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63d340ae89b67cd4bc915ec0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63d340ae89b67cd4=
bc915ec1
        failing since 31 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d34667f252e745d8915ef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63d34667f252e745=
d8915ef4
        failing since 101 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d345b504610af15b915ecc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63d345b504610af1=
5b915ecd
        failing since 101 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
