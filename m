Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB684F4CE6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 03:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbiDEXfz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Apr 2022 19:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457678AbiDEQfi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Apr 2022 12:35:38 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F93E30F
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Apr 2022 09:33:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id z128so11454083pgz.2
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Apr 2022 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zWBBZP2Ge2Nksq3DccogUggooHf9rEbUDXGMPb63QNE=;
        b=7Vhgm4+k+KifomvXHJFQrKJ6NiBP7XFIG/215kKOSWP3h4NXZ4vBpebQ/XiP2cyikN
         r1PFAoRePAGNn2UZU2zHwHLm4Q0tpvkabqrtLqNkZTruGTcbG/MharlEycgYEtjPk/4s
         8ONyF0YfQ/lO7xppxkca3dEWaOyAQOHjt0lLVV+zA9i637XhFtgnnxlmSIZ2LFj2n3Hi
         W3SahOy/w26+xv9/dG5suAFEMy5bYfdax5l/dBTduk1ng9z6ELJ6gVh3oTSSzTwKdfHC
         FSdkVxFTeN3QKk3n+9bKHGUOPJ/h8ZS3KzeRPqIoKAQv6Uvs2QJbaE66+9VQ3/HPEjF1
         +OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zWBBZP2Ge2Nksq3DccogUggooHf9rEbUDXGMPb63QNE=;
        b=t15b/frU+tssewcJnRfc6hTwfeswA+NRJqpvOy2R2dpIj8wOg/WQsb77UvPO6i97U0
         6IwjF4pf9EXrDjyCLnhVpUhoOwXPwa1FyNxSATAsmhAP8eaUaXr/eU4/gBWHiENs13c6
         EtnyNNhwQgqpnu7xspwv5Oz+khtX1Bkk04uczUKLpdhT2kQddzDKJv91WE0JSTq1Bcbr
         9Vh4q3lBNQ5vTwd/2SGzMKxYI6JAKajAfZWUu/U+j7pBgui3eeN1NFt1W/SChSxhS3OJ
         ABhGa9++FCe8vlyVcCUyzlu825lp+1LN214qfgEpIqaQwY7hih871mdjP8xIF2ouVa1T
         9Osg==
X-Gm-Message-State: AOAM53342R6wv/H3cj4PR4LQbCdLKnSaxS2gSBqr/H3Hdvew16o1LXyM
        W7TJivokb5iVBrt1KNTuGJIJ1A==
X-Google-Smtp-Source: ABdhPJwkC4uHyHSFwCAUlucx++zTyXvzOun1ivWW1WONm00c6iD/q2fbKk6Hk+YfFU0kJkumEjuZ6g==
X-Received: by 2002:a63:981a:0:b0:398:49ba:a65e with SMTP id q26-20020a63981a000000b0039849baa65emr3540948pgd.231.1649176418716;
        Tue, 05 Apr 2022 09:33:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y16-20020a63b510000000b00398d8b19bbfsm13896995pge.23.2022.04.05.09.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 09:33:38 -0700 (PDT)
Message-ID: <624c6f62.1c69fb81.b133d.4cbf@mx.google.com>
Date:   Tue, 05 Apr 2022 09:33:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc1
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v5.18-rc1)
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

kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v5.18-rc1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc1/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      3123109284176b1532874591f7c81f3837bbdc17 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624c5e5953d4870b59ae0690

  Results:     56 PASS, 8 FAIL, 26 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-=
mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-=
mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_READ_AFTER_FREE_sh: https://kernelci.org/test/cas=
e/id/624c5e5953d4870b59ae06cc
        new failure (last pass: v5.17-rc5-22-gf6d344cd5fa6) =

 =20
