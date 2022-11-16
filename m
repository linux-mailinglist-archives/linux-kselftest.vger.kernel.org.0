Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E246F62B12B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 03:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKPCRW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 21:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiKPCRM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 21:17:12 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F8A23E8D
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 18:17:11 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so1014387pjk.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 18:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=84nrPKHPmFZIyIHVGK6iP5bLSH5ckP5eW2zJMTVojHk=;
        b=T43FLehRARBn8+iw04j+tkP3GGUPKLG4OaDdt4UMHIG/+OguEjNON7bWl/lqLiJhnq
         ++jDR/VxxFBgi2kKHcXk2rbDl7tOpwX2m1nf7Lr9zldX9jLeLApTFrvn6HKA36TPuIiL
         CbBgqG3pHhCumg9+TJlcG38CuVNclFjxPX1+CjMowYa+DZoTrdmjlSqmxBOVuKSb3G72
         p59IiCjRh90WSUT3OgL8d50mDTILckiVAhJtI9Zwvk/Kn7IxHIwG973qXJLDtTk7iEwY
         6Gft9ib3QE1t45iF6gcyzYBENfslUGgE8kLV2/cyrvD/zkjREA/66OUvtpNEzLv5jccl
         st4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84nrPKHPmFZIyIHVGK6iP5bLSH5ckP5eW2zJMTVojHk=;
        b=XN75HGpjTdjnFEa9Kr0TUyHxA6Iw/aQ+Op9puBjvdyWQ0VOt/FoUIJeRuta+UqTe+m
         G4YVckrL/JSZ5spcbnK1fK3WZwzZKy4axgP5IPouPFRTtOffP19NjHVLo4fv0ZlTgQPA
         RCSQGfST1KD/8hTUHmOMYhYNBzO1MSrki0RkHHh9w3VEZPozdScOn2GTzDVkvDr3xwcT
         YSZZQWhpbtuIRThEQ6mpkpMxyCzfa7LDQxcG76VbnZKALbbI5hgByfIHUYEYjim8j4tT
         DEpZePWejRDZ7gSHZfTqDOGYdrFntFDQGUfe1svcm6v98UUcyjF+YSLKGjFKN+h++/7q
         S5QA==
X-Gm-Message-State: ANoB5pkde5v+pZnmmr1SuSl5Cvfn6qONEinE1G6/T+s7LT3IUKctZcZ1
        kwb6qbnTezbcjT7HYPtoQzAQvTZbnzOhQN/1Mzk=
X-Google-Smtp-Source: AA0mqf7/6yYXQ14ojOjmEocThgrD4cb0ABWZahu6CRwv7/lDrLAsQ2w08WGd6FhKeINIieXMzGmHXg==
X-Received: by 2002:a17:90a:3849:b0:20a:8d65:978 with SMTP id l9-20020a17090a384900b0020a8d650978mr1311172pjf.94.1668565030601;
        Tue, 15 Nov 2022 18:17:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x128-20020a623186000000b0056da2ad6503sm9521860pfx.39.2022.11.15.18.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:17:10 -0800 (PST)
Message-ID: <63744826.620a0220.fb7d5.ec84@mx.google.com>
Date:   Tue, 15 Nov 2022 18:17:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-16-g35eee9a363be
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 5 runs,
 4 regressions (v6.1-rc1-16-g35eee9a363be)
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

kselftest/next kselftest-seccomp: 5 runs, 4 regressions (v6.1-rc1-16-g35eee=
9a363be)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-16-g35eee9a363be/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-16-g35eee9a363be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      35eee9a363becb854109e35d568299bafc97c9d1 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637439fd87edcf64ce2abd37

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/637439fd87ed=
cf64ce2abd38
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63743c551fe7c969d32abd6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63743c551fe7=
c969d32abd70
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637439fd49522291552abd20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/637439fd4952=
2291552abd21
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63743b8dec6a37dc0e2abd29

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63743b8dec6a=
37dc0e2abd2a
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
