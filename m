Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B55507F73
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 05:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359072AbiDTDKq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 23:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359238AbiDTDK3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 23:10:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BFCDFA8
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 20:07:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i24so668493pfa.7
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 20:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=890bIKde3Ga9+qAy7uCzwMeyrNY5bEiNbxBap2BPfM8=;
        b=Rj5aOmdCbq/AlJU74of8Trvy7EqcyEJ8O2kD2nRvSUwYz5fP/FTIWc05TPobijzMNx
         x7AuXK+SVv4iAR7V1xqzUIwObgPoR+Ej/ouRdYb7Xqbz3jCZ4nT+wZytmwhrcg+ILUn+
         ckdLVSgBYJqLKTz3Dvvm9yQdKL8tfO/wY16vHleAog8JxIQn1LzE5yp80O5wVXoJ13mv
         TFzdLGYnWvyFZ3JZJ0MmwN7F4O/WNqS1ibGhRxmdmgcb0NRrhTqjCMXQS9Tyk7+Rmrvz
         UpfiF1W8tFzEBcR+CMNBXdnD9LvoWGOMF1BPr0kDZHCRLnn4lzD1k7N62YYuIvPgzB+M
         yBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=890bIKde3Ga9+qAy7uCzwMeyrNY5bEiNbxBap2BPfM8=;
        b=UokoxJHSAp7Hnlww8j16odJiqLVejFM2En5APpeHECSzpQbgaN41xUbm1QtNJQZVNn
         aREVqP5f9cGK6x0RxwZgY+Jpsr8NGot/9xRa0GjaME5cr+TZDgeR5b2LaXOqJiCsB0yP
         n8gs1nTjDHjW1wrHWUE15D4qg7sEAcI8Zd8zFcwD3wSsaG1SypyHzVlN24Q/77ORhhhi
         pgrdnXHQ3444zjEcG4WLbDK2zAV1sHLSOHXx0m8+sENfZr5i48lQttJg1f9SQ0HjYmHm
         iGkHg3KmDMWHd2wvfVjiFqoVWPLCl8YcAmzmqtRdTtOvn2MPMIlBL7XVXxyXSBx1luLB
         q/iA==
X-Gm-Message-State: AOAM533Zs1zum1wMUSwFSRRVP07e4wowF++KY+KJy6v1MYEa3qmgYw0Z
        4k5qWfOcyVe2AbGwZI7njdJ3mw==
X-Google-Smtp-Source: ABdhPJyOgs77qfKyjF5cqt/27NTdiloinyiMv9gZBMrX0TBqw7Y5nNfW62KBfjrbrEsOdwZX0JgFKA==
X-Received: by 2002:a63:9711:0:b0:398:5cf2:20bc with SMTP id n17-20020a639711000000b003985cf220bcmr17215559pge.480.1650424057478;
        Tue, 19 Apr 2022 20:07:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j63-20020a636e42000000b003987df110edsm17846845pgc.42.2022.04.19.20.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 20:07:37 -0700 (PDT)
Message-ID: <625f78f9.1c69fb81.48a40.adb4@mx.google.com>
Date:   Tue, 19 Apr 2022 20:07:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc3
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 5 runs, 1 regressions (v5.18-rc3)
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

kselftest/next kselftest-lkdtm: 5 runs, 1 regressions (v5.18-rc3)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc3/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b2d229d4ddb17db541098b83524d901257e93845 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/625f69bc9d4b290d60ae067d

  Results:     56 PASS, 8 FAIL, 26 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-=
mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-=
mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220411.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_READ_AFTER_FREE_sh: https://kernelci.org/test/cas=
e/id/625f69bc9d4b290d60ae06b9
        failing since 14 days (last pass: v5.17-rc5-22-gf6d344cd5fa6, first=
 fail: v5.18-rc1) =

 =20
