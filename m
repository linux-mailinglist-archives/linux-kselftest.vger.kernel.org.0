Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45034629BDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 15:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiKOOVA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 09:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiKOOUv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 09:20:51 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8BE2B191
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 06:20:47 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id io19so13273493plb.8
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 06:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SgEd5Hq13Eamrt782jE/rrStZOJ/rG4XLEO/Z50vyx0=;
        b=xISAaxel1RszogfSMWeqz2oJpVv5TAD8/nZImn44jVURNBI9n6OCIO2M806HiIi1BX
         Odk9tOHNqT0sDFAK9D6E8NWzGhs+5eYXcd1ln4gM+dXGTE3L7jTinUeuHkB+3iCJshs/
         Ew4FfbZ8Z9xydBmURr+Mo4GtXChy9nnMqlSC5i4102MTsydAAijdN5D3SuvcAJnY0Z5U
         yLewvtWRFNB5A1uoIR+Dv2WJDj0iuU3ukcHRNxZ2VLKZ8FauMPYEB25W6U5kAOkwe5dV
         +nLQ69L65QQLdP7WNRKZoE1e4A0wH1+WLy3SIAMX6pB8je5zeeZIldyd6UPIovJcKzRN
         tGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgEd5Hq13Eamrt782jE/rrStZOJ/rG4XLEO/Z50vyx0=;
        b=CefO3ndQYrRN0yyflygIhtByrMvRqoFZXkrJ1WkbhJ4PldhD06ZX+VBphOYebDSpk+
         F54wuu0f5uT71UMkTdUMyrOiVaKzjy/o9gfyRBkGeLx5FgBP8lQA6JnwSafsQpp9UGg3
         tjiWP3SEDDHSuNKCrkUhiWxhgkI/bRZWdXJYSJtXwvHL4m79e9Se04VCeg6CHY9H1i1I
         Bl39dNXA0Qvmv/iWGAzEuUfat2Alp/2b6qlHJvKj0o/eVAf3hBIzUIffPpmJ5gBeSeue
         ECxXY1KkOW8TQvMTnoMF6QZfupb/Ia2dH6bGVVBLijrjPmivO5mGWNAxfJ0Gtb8MwFfe
         UWlg==
X-Gm-Message-State: ANoB5pnzsyVmtkmp+PkKvDi/bzrS/V51vng38fd1wbULpqPTW1xavC/0
        lGCWNN7ltuQiU1QaXcwg2b0qzg==
X-Google-Smtp-Source: AA0mqf4Ivg+X37Z13teWo9jaqZ/PiUz4EbOrcK9RKsoywVlmsUasYFsCGt1f1JCbIl+wUp/t5Iygeg==
X-Received: by 2002:a17:90a:fd89:b0:213:74a:845c with SMTP id cx9-20020a17090afd8900b00213074a845cmr701378pjb.240.1668522047042;
        Tue, 15 Nov 2022 06:20:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c2-20020a170903234200b00186ff402525sm9938173plh.213.2022.11.15.06.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:20:46 -0800 (PST)
Message-ID: <6373a03e.170a0220.946a0.e6b9@mx.google.com>
Date:   Tue, 15 Nov 2022 06:20:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-15-ga1d6cd88c897
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 3 runs,
 2 regressions (v6.1-rc1-15-ga1d6cd88c897)
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

kselftest/next kselftest-livepatch: 3 runs, 2 regressions (v6.1-rc1-15-ga1d=
6cd88c897)

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
-rc1-15-ga1d6cd88c897/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-15-ga1d6cd88c897
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a1d6cd88c8973cfb08ee85722488b1d6d5d16327 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6373926376f474b0a7e7db7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6373926376=
f474b0a7e7db7c
        failing since 28 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637393f38ccd0836f5e7dbdd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-15-ga1=
d6cd88c897/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/637393f38c=
cd0836f5e7dbde
        failing since 28 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
