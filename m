Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E6A564A44
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 00:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiGCWQF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Jul 2022 18:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGCWQE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Jul 2022 18:16:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B262DE2
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Jul 2022 15:16:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so1473376pjn.0
        for <linux-kselftest@vger.kernel.org>; Sun, 03 Jul 2022 15:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aiOhuUkwT8/B/Ym08v5/1JRr787wUf2VbIg9qyF9GII=;
        b=v9p0fY6T7ROJWaeitmmvYUMoucj2W4FONgoDaU1E5A3i+iKXcUfG9bmDWH0wh2HC2Q
         XbnDs+ze0AdVNDa/n7/JaOI+YTwWbEAKtPg/7MoR0LPZPXTYO9XvlMtE7PWUrxrAP+TZ
         5kJujfw5KEayH0wCym7B2WFOih9kSKlQiDG+7GbS9HRkUk8uOsOMDLUDis7j2L7tDzRx
         Sm5FqOPq73vk4+y8iYMZsHzbxrDhbmIlGhJlEkE66kmk6Trz6bsclboNAonU1iMc/2dk
         S7R7HtBGHEwNBcwDs1i/ZAyjdUb0eGNzOH3XcBgMcxnWms1tC5hsjxIu5lwpsVP6B5wm
         tMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aiOhuUkwT8/B/Ym08v5/1JRr787wUf2VbIg9qyF9GII=;
        b=DIhJd7vm25zIV2t5YjR/lhTU3F1bbHO2xaBhOk3x1PPcpxEcQm3qoXTbGYWM29AV0l
         X6ExA/KWaVZJV4KYspO6R5fYmLGOckKzGV4hA/TW0yj6mJT5OyD9RA5XHhrQ+n+2IGgg
         3ccHiUr3vrtMfxv7AJWfK/AB1uqSmx104QHQFr9r7wRlNpaY51/j8eORWBsxtTtC40dc
         hbwy/aknkiSs0LQqO3F48S6PLXLzx4gIuu3W/HWAieHOpXKCSHKqS+QigrBIQJ0mxIpk
         NN0LfSEkTi7CauX2DiEaYQ9/mC13Qh2wTy5kri3D85rBxFyiwnFgVJ/NI47kRvdXMtTC
         6YkQ==
X-Gm-Message-State: AJIora+OgCCXPn75j0snmjgk+5M7o0l/F7VFToG6fEb1i1Nd8yKD91uj
        SsccH6hqAa4Ryudw3Qf7gbqirksqhmfJouz9
X-Google-Smtp-Source: AGRyM1vTl2NTrc2M63V7COiSUwuwSAGE9Q66sSPYLc+p7d3cohzIB/T20YGdW5z/eplPzFdb73s4wQ==
X-Received: by 2002:a17:902:b488:b0:16a:7013:69f0 with SMTP id y8-20020a170902b48800b0016a701369f0mr33715404plr.118.1656886563505;
        Sun, 03 Jul 2022 15:16:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id cp2-20020a170902e78200b0015e8d4eb1d7sm19537014plb.33.2022.07.03.15.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 15:16:03 -0700 (PDT)
Message-ID: <62c21523.1c69fb81.36199.b839@mx.google.com>
Date:   Sun, 03 Jul 2022 15:16:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc4-7-gb7ecce6800eb
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 9 runs,
 1 regressions (v5.19-rc4-7-gb7ecce6800eb)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-lib: 9 runs, 1 regressions (v5.19-rc4-7-gb7ecce680=
0eb)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | clang-14 | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
9-rc4-7-gb7ecce6800eb/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v5.19-rc4-7-gb7ecce6800eb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b7ecce6800eb1aa97c486c1aabf64659193d5a4c =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | clang-14 | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c205ed9cf4be2098a39bf6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-14 (Debian clang version 14.0.6-++20220622053050+f28c0=
06a5895-1~exp1~20220622173135.152)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.19-rc4-7-gb7=
ecce6800eb/arm64/defconfig+kselftest/clang-14/lab-baylibre/kselftest-lib-me=
son-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.19-rc4-7-gb7=
ecce6800eb/arm64/defconfig+kselftest/clang-14/lab-baylibre/kselftest-lib-me=
son-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/62c205ed9cf4be20=
98a39bf7
        failing since 27 days (last pass: v5.18-rc3-19-g15477b31db104, firs=
t fail: v5.19-rc1) =

 =20
