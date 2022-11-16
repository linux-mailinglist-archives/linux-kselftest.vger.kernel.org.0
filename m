Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995FB62C92A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 20:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiKPTr4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 14:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKPTr4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 14:47:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4498C2CE2E
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 11:47:55 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so3507330pji.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 11:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yq228k34BuIDsyWJ2Wgg8MEi30MafzswLzfpcoz60M0=;
        b=Mb/Emvtb4AcR3KYUGTRPIrg398w+l1bxv7ACIVosiOnPLI1RNPx0I+fNC6PRg0AZ7B
         4tV3vAJGDQQpFhoylWl+Pq1JPz+3h2CLxPIcGmHdztWlJnobsHHjbIPPPJOCJwmPamXo
         UKMJAKcmRfAiCwszQcOV7AZ/LSCcG6p3feEiSY6g0+R3XDjsHrTCwWc9uOIodGDv2/d3
         AeT4S0scwwRaJofgOjoOTFrhvCOpPAm/j6CL7Z7LKAW/S9QXgLMibP0RjPlPS3xR3ZS6
         Pnsj4dyAsSjwfvQl5tvECj07q2DZmoQLdR/elpwN9Wz9eRnrnwgLf/rYYVyZhlqpdHTx
         RNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yq228k34BuIDsyWJ2Wgg8MEi30MafzswLzfpcoz60M0=;
        b=jmVOr1I4GvbrwBdzqrrqWPG63SkExUpqi0/R7imotPfngpI7luUbn/KE3BS5yL0xQ5
         e4EVGZQ1cPHFflusYCD7KfmFMi+cTDXT+ePlmpeSEkiw9nfh/API8XsCBlhtorKrwazU
         4IKtcFq+YXI5pk6gP/XGjG0/mbk5dPyZOjCp3dLbviv6XTUEyBydw5EQ5LVCamGkvXxJ
         87EdhBN69+p93wBafCn2iwd0qReMf0lCmu8hH7K6Df5wXKXpGBNsCwlp7VOlQiMcSY0v
         HJ9vIzdPAmjV1D5bVd9AWr+dN/6wt/mYuIZeFf8X57JwXFidoTTuz0j3nzagd92eMSY7
         VeWA==
X-Gm-Message-State: ANoB5pktrqYFjscs1RXtYQ1pqEMqR3NdoSD3/K8plNVM6WYxuFU5AkHH
        BLc+5AgSAXPviLPBoC9L53Rg60iSK9GwS8VRbas=
X-Google-Smtp-Source: AA0mqf7hQwrJ4V8+flmFmQPzeDBylzsSFlhmptV/ZLtOlw6sp4uZbEV0FbBWVAb+wtzB2zSn1ZNihw==
X-Received: by 2002:a17:902:ebc3:b0:188:6baf:1ffe with SMTP id p3-20020a170902ebc300b001886baf1ffemr10668687plg.113.1668628074816;
        Wed, 16 Nov 2022 11:47:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090a4d8e00b0020af2411721sm1979609pjh.34.2022.11.16.11.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:47:54 -0800 (PST)
Message-ID: <63753e6a.170a0220.44e39.31d8@mx.google.com>
Date:   Wed, 16 Nov 2022 11:47:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-17-g2dfb010d2aaf
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 5 runs,
 4 regressions (v6.1-rc1-17-g2dfb010d2aaf)
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

kselftest/next kselftest-lib: 5 runs, 4 regressions (v6.1-rc1-17-g2dfb010d2=
aaf)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-17-g2dfb010d2aaf/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-17-g2dfb010d2aaf
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2dfb010d2aafceeab23ccd502c77784006adedd7 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | clang-15 | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/637532c4673decc9dd2abd0f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-m=
eson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest/clang-15/lab-collabora/kselftest-lib-m=
eson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/637532c4673decc9=
dd2abd10
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63752e7c75aeef660c2abd39

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63752e7c75aeef66=
0c2abd3a
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6375318550ec96d3c22abd08

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6375318550ec96d3=
c22abd09
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63752d613dd87f62162abd08

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-17-g2d=
fb010d2aaf/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63752d613dd87f62=
162abd09
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
