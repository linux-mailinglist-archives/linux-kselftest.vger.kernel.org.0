Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C50B62B129
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 03:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKPCRU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 21:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiKPCRJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 21:17:09 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F1D12ACB
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 18:17:08 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z26so16149058pff.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 18:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dkj7eBj2da0qNhF+jr4t/XAZVJk83dQtjwsXLOQtf20=;
        b=4K/Kuqwp0Vckn4pe/hxlNheku5Ujsa5oIkgGYWchG6pnG3aYl9/xO1GFodOR+6hhMl
         spWMXmVxCnoDyn9KwgoRk9MJwAmRtvwj6UFROrTC6xclrYGVVsMso+evTqJtqtGUwVL/
         bGvVIscA1KbqVVSVdAVEfnOHsBpV2LR5FTEX8mdm+Y8J/vd7QJa6lNEb/TgTQ5g6MYoP
         oojyyV2LpBUyM5tz0sQdAjGQ5NuGa6F4NtmHmxfIVAXskrMH15ja6zTA9BdfMYstPidI
         7DSwgE8fR9OgUc9d5CbUqyxTfqrXMitxddrJluABHEgydWk1kWll8Q0Z2IXyUXwYmbOW
         2IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkj7eBj2da0qNhF+jr4t/XAZVJk83dQtjwsXLOQtf20=;
        b=gnSrGQvP/ElFHtyPI8AghWnG2MfQGHTi2s2J0Rd1Tw0cvKN5/iz+LXFVrYYHLIOfI1
         8Xkb6z64a3UVkbds0BNPTrlBljxFYd+LF+96TZ+D246XqQaPcM9HzEMvQt0tcen6UpUm
         SxZQ8gh2+BJUKWX8vLGA+rHx0bF838y21V8sP4UvJUDLbRMDyhujddp3sI9gIpmGZyzE
         qIfSweljaPUr/icVQQGSZZSkhMzDi6D7is/racdlCaLWL/fzHZlPSWUc5ZGDMBGxX1xt
         gGeXdKR8IyeZm0ha63eC7nFWl/JJjuUFG/DgpNNyb4bz7orEKlZzowh38BEBPIO9w8Ng
         DC9g==
X-Gm-Message-State: ANoB5pky30nbsvHhYc2M2YZRS++n9HDidOnTfT9+SBOl5ectCs2fnFM3
        8J1dZz1ol2GeFUu9HbM1cvxPqg==
X-Google-Smtp-Source: AA0mqf5xFPp18Uv5wc8Q0BwtNt0p6m33QrJy/bU+SNQanKkqxNYUfdPyn6WuX9TMM8ZcfxOtIleCwA==
X-Received: by 2002:a63:d4f:0:b0:470:7b17:2215 with SMTP id 15-20020a630d4f000000b004707b172215mr18719667pgn.94.1668565028375;
        Tue, 15 Nov 2022 18:17:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o28-20020aa7979c000000b0056babe4fb8asm8588837pfp.49.2022.11.15.18.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:17:08 -0800 (PST)
Message-ID: <63744824.a70a0220.6e4f4.d5c8@mx.google.com>
Date:   Tue, 15 Nov 2022 18:17:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-16-g35eee9a363be
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 2 runs,
 2 regressions (v6.1-rc1-16-g35eee9a363be)
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

kselftest/next kselftest-cpufreq: 2 runs, 2 regressions (v6.1-rc1-16-g35eee=
9a363be)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-16-g35eee9a363be/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-16-g35eee9a363be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      35eee9a363becb854109e35d568299bafc97c9d1 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637439e987edcf64ce2abd20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/637439e987ed=
cf64ce2abd21
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63743d1e3882d6e89d2abd2d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-16-g35=
eee9a363be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63743d1e3882=
d6e89d2abd2e
        failing since 29 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
