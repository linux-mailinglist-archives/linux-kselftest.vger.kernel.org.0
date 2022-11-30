Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2213963D6ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 14:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiK3NjH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 08:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiK3Niv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 08:38:51 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7070A2CE19
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 05:38:35 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so2079805pjd.5
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 05:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HYI7Myg6HEKItK/LnMmec4NKahQAF0usObjx5xEY4Xg=;
        b=MCVY7nmHLGGmObun3qGOnNIesCq7S4j2qJGHTtaajI27XhivxqIPlfTv40c5PkbCqQ
         lflFIf9rgbMt4plJnjL0uYOxYIbxvwQ0easT0ZyhsiWkGX+iXjK97oqckmJgUValRzMI
         INr8lzl0U6fk+SUd+yDrNpynltMHQ5qlS6X/wKiRrx+Bx9gClPiVbnxRNxfrk16InhJ1
         w+CPH9nW4TQIpXZmDjvBOm0Fpo0TGz3+ehJWjGbCNY4ieqo0rw6y8Gwn2IJTwxVx6V0G
         BK9UBmW7fXSoWceLJjS3Uv2vaT1TgBuD0OciO+4ycvYRewb9syjo8RZYKnwBPg9bK7J9
         7HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYI7Myg6HEKItK/LnMmec4NKahQAF0usObjx5xEY4Xg=;
        b=77nZhPVJImeorhTCpdgLE23iJiEtt7ygGe1quSqJRXaUlikc0OXo70m3Q9cWleOyjZ
         2i4aVZFhYJ1Pei7q+SLMDs1HBvmsE+lJe/aCwAe4dO1xmv05dWDf5gJUvmkKN2/ixGn1
         rhqTsPpesEyvipWrl4NoqP3VgtYKetaRmxnfzsif+E6nYLaE0O0qpdZgXHbbxaKCmfPi
         rtuV0wbBG66fHmMkGdLseYaOJyeMzYdTu16xZUmsP1nEtq87SaZooQk14Z74D5lq6ixO
         vAM0J2gbNQ5Y64rNw+sIvE5Uy2X0Ms3GiZ60L4a8UE+Rvsw6fY0ix9fEwT3V3rkgfd1r
         D4Eg==
X-Gm-Message-State: ANoB5pkOYyRRMRKgTlilzOTmIuwxdwt4e01QrzP1+8sBkdDgrKQKjd7u
        ZzSL36VI/g0UvjTLuHgZ76PLWQ==
X-Google-Smtp-Source: AA0mqf7hjR2fGXqOcbFHUiYApXZm6e70cuQkOm/m3TFA00Y2lvMtYZgdhDnx5CB+QkFoqwTjCvLSaw==
X-Received: by 2002:a17:903:22d0:b0:186:9405:290a with SMTP id y16-20020a17090322d000b001869405290amr42658945plg.133.1669815514935;
        Wed, 30 Nov 2022 05:38:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x27-20020aa7957b000000b0057534fcd895sm1399611pfq.108.2022.11.30.05.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:38:34 -0800 (PST)
Message-ID: <63875cda.a70a0220.28eaa.211f@mx.google.com>
Date:   Wed, 30 Nov 2022 05:38:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-23-g8008d88e6d16
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 3 runs,
 2 regressions (v6.1-rc1-23-g8008d88e6d16)
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

kselftest/next kselftest-seccomp: 3 runs, 2 regressions (v6.1-rc1-23-g8008d=
88e6d16)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-23-g8008d88e6d16/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-23-g8008d88e6d16
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      8008d88e6d160c4e73de5be7c3dcc54e3ccccf49 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/638750399b8d4fdce72abd16

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/638750399b8d=
4fdce72abd17
        failing since 43 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6387504e9e58bc411e2abd2d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6387504e9e58=
bc411e2abd2e
        failing since 43 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
