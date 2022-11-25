Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099806390E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 21:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKYU4u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 15:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiKYU4s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 15:56:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826912FFDC
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 12:56:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so3618320pjd.5
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 12:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H8Eo651eZv0ecHoALK2bAjB2kUaR3rCjP6sXIq2qczw=;
        b=xoPQVAw3ZFOJUsAycmHhJ/+I/0ZjzEMJsiXBPaoC+DdN8q93HW67Ma8XYHL+oPAgZf
         ldgow3Uk8TH90EMjrj0DCVWCYFBmM/fHEdrUYLIkiL06UFpjdWgMuFhpb62RVm2pPguE
         GfmLHR3XELVuVRVBxE0I4+NpfpKsq4QlGL8ZIPYw7YF9H+D4e7OiVHpEqQKEySMR1KNr
         s+HC9qLMCDBN1ttXt9VVf0ULAplfwLOp7MxsHYFMnwBqbM3fqOzDY7pcqeAiJyzQUL7H
         J5m/ASUuLE/P2ExxaG6TIVcQHrYML3HvSPAvf/Ru0WLaBzBZ0mt2PrDLUAKzGOD99Ct0
         xKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8Eo651eZv0ecHoALK2bAjB2kUaR3rCjP6sXIq2qczw=;
        b=oSF1ay3TgIe84FK9nc0aHh7xkA3+y954XRhzR6jKzDwmRiWtSO7Hrt57xtgXlWIoGM
         EyMhHY/eHn7vaU+nUzS4j3h6wSY9neCgzJmdTwwlzHCbQk7C1FPK8ghUm7Iad4/ZlJm1
         rEEH3V2yAGiO00yGbZ+foEj003/duaKzE1rrAv1gwT8zSJ4PrMjlhg6dADhStJMjpLMK
         d3x0HPT4Zo1GewGIaUVgZhXiHmiAc9EhdLiAmQOcigNdQOgEnh1LlZ7TzBtu9WYFVHul
         5WXc3R9l0/5I3AvRXXabuGsnHxCgLJdA/qlquK7ASiqVQOUojfue9nOdDsK8UHVgHXbt
         k0SQ==
X-Gm-Message-State: ANoB5pme9yqvM/Uu7dYWskRa11ojkbnOX31Fzn0JKm7Ln0KB9Sev+xAm
        1QmRRwEd8zy/glZ73BTJPhC1XhwvHgpJp4nBMZk=
X-Google-Smtp-Source: AA0mqf7MSmxSz9/OTyAgzypVU9wd5yQbfamW0XuqYeig+xLM3do8BcibncaeL0Pj/yeDg9DXzlXErg==
X-Received: by 2002:a17:903:300c:b0:186:aed3:3ab7 with SMTP id o12-20020a170903300c00b00186aed33ab7mr20630439pla.88.1669409807037;
        Fri, 25 Nov 2022 12:56:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090a3b4900b002135e8074b1sm5353031pjf.55.2022.11.25.12.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 12:56:46 -0800 (PST)
Message-ID: <63812c0e.170a0220.8edbf.890f@mx.google.com>
Date:   Fri, 25 Nov 2022 12:56:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-23-g00dd59519141
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 5 runs,
 4 regressions (v6.1-rc1-23-g00dd59519141)
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

kselftest/next kselftest-lkdtm: 5 runs, 4 regressions (v6.1-rc1-23-g00dd595=
19141)

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
-rc1-23-g00dd59519141/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-23-g00dd59519141
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      00dd59519141398120b4baa65c0ab4b67dfd3e19 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63811d8e97952707e62abd1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63811d8e979527=
07e62abd1f
        failing since 38 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6381213e644eec8ddf2abd00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6381213e644eec=
8ddf2abd01
        failing since 38 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63811d9fa966de385d2abd0e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63811d9fa966de=
385d2abd0f
        failing since 38 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63811f14349065db402abd32

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63811f14349065=
db402abd33
        failing since 38 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
