Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FABD617C55
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 13:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiKCMRb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 08:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiKCMR1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 08:17:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C426443
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 05:17:26 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 78so1470604pgb.13
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Nov 2022 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7GQdpPc0rCBoMdwi005HAJWQlARDitb1d2hb7+PNYD0=;
        b=wsk3fdRZtvzo43czo7uf4ofG5PoYSEIo3pag7D5LazXlFK4S1V28KD7aumawAa8Tnt
         fShwxnY/7CrjPf1p3BKwtIu5GxfBORagjqCQwawvvPxyznWJ1xiri8Tw36sUa4ZOVN1J
         gyOUkyf+3huQrKWQFPQTCvfuNhThYv9wOvphjsCQGzmPCwxNbgsq5MaTel9fFIwtdFaJ
         cfr9jy2n6Vpyw5IDPiO6WLdhrbv+BfasiyxiJnNWKK4caZ6mOKAkwmXTSYOvyBwmz9fv
         7ysKQiLkC7eEdEg8MhdX0uQrz9Xj/z4U2wf+cgV5WaL+RWaRohDaNMnpRA6qgHRrgOn8
         Zj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GQdpPc0rCBoMdwi005HAJWQlARDitb1d2hb7+PNYD0=;
        b=d6vo0pjdwpEHE8laG3lc+PjRE8KWHMr+aBQ2Bg/mbFiGVvET+FlBQTb8LK8g18rrTB
         AkiKWMhuZY1IDg537/CWP/Y0tzbdiqre2e1jQ2Jw+MN1bttfbZ3ZsRDAKXZT9Po4aW0u
         Sy9wJvmD7vjzUY6DkGhXnjMmVgv+4KyUI92INKRI1UspTfuz0bphagqNHXhELjUj21D6
         WvHoPoeVoLYsPeRzqkPej2QkIcg0B7SJjAHibCrWNAD5PqRXIl99twdL5tDxatpDh7g+
         v9j7+1WJ+HY0zSEHgqKYA0u4QsX0Ij/emgSl03BYyTjo2K9/9fl9B5M9F8aS3B+PROb9
         KAew==
X-Gm-Message-State: ACrzQf3nyBhEt0+zI+Kgho8wdaC7YXxNlF4baPlUdId8USscneMBfCRH
        cLgICsKKJZwKj+LGWw+I/09w6yA63FC5KnrR
X-Google-Smtp-Source: AMsMyM5vOXf00O92lxDkJed6OMv82vSHSMv2vr7E0+dPj3BDcsViTtMTxfSUmt4jeYlMpzzw0uz97w==
X-Received: by 2002:aa7:8687:0:b0:560:3299:a6c0 with SMTP id d7-20020aa78687000000b005603299a6c0mr30203754pfo.81.1667477846401;
        Thu, 03 Nov 2022 05:17:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d16-20020a63ed10000000b00459a36795cbsm670630pgi.42.2022.11.03.05.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:17:26 -0700 (PDT)
Message-ID: <6363b156.630a0220.30471.0ecc@mx.google.com>
Date:   Thu, 03 Nov 2022 05:17:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-14-gd942f231afc0
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 3 runs,
 2 regressions (v6.1-rc1-14-gd942f231afc0)
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

kselftest/next kselftest-seccomp: 3 runs, 2 regressions (v6.1-rc1-14-gd942f=
231afc0)

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
-rc1-14-gd942f231afc0/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-14-gd942f231afc0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d942f231afc037490538cea67bb0c667e6d12214 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6363a19537e742c598e7db84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6363a19537e7=
42c598e7db85
        failing since 16 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6363a19a37e742c598e7db87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6363a19a37e7=
42c598e7db88
        failing since 16 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
