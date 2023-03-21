Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3320A6C2E90
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 11:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCUKTt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 06:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCUKTs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 06:19:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985C9769E
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 03:19:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso19536188pjb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679393977;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl+FwRGh4hvoziO8pK9liQQ805PYz4OYfydTOH82AJk=;
        b=x1BC9xOWjkWXWCvodiNUX2daSdsqEAQk0+LEj1pVENRJ7EjeZ3YOukuLsrIsue3fMP
         ZjwquLoeizwUmxPLPb9dzpJYD57TKkRsdevIgonrcEGHbqE6keZGZ2bPJ+jOn3u6wD17
         VkSnRM/JzsAI1sTnZuoozRBU+EdUpamqE1g/GSCPqXMH80cZATcKVZ+W8uYVi7pIXkdO
         GWsDzKrNck/uxcDcpkFcW1OPq3t3++WE/0C1eshS2ZVqMK5qxAKGBXHeSgWDa0lo0NXd
         dM5mv3UsnWN2bd39l3CZR/3+ScAwu0tzI32pw0+qO4D+40ABoJUjG3FMGCzhDX7Bv/Tu
         SBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679393977;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rl+FwRGh4hvoziO8pK9liQQ805PYz4OYfydTOH82AJk=;
        b=c+NsXXMsgfeW0PN2DDwalHAhSjHamzQa61voYCu5CuxvntMaDJrUkjsjvJRCmq0TkZ
         YZ1zj9ohqkDdkvHKbDJ8XUDU9tI9FXoHtbHD+CuNlLl0U9M30R+8KRLcXdAdjvlVCAon
         zgoptH43IsmJPjo9po0KvpvYwMcvijtwsogwl0AjuS7GKfSaM0A8acFG6ZLG2Ms6utRC
         MDl7cpth2rqzewdMWXL27DyisqgiqRQbVii8qaUdshdC1dVZJIrTuvH97+QjjUltFmRo
         eBkOupD+PglVXxGGcbOnICR85Z59sAKc5dRyV78oAEjFvpBtQugoFfJtccJVPuljPxAx
         dLhA==
X-Gm-Message-State: AO0yUKVGjyl1xzvbET8IQIld9ZO0bo+Eivs2G/BqjGptrlmONecSmfOG
        +bLpvBfCKMZyrJdve0MYPlbJWg==
X-Google-Smtp-Source: AK7set+4ZvyY19jX27JvFSrWErzyOOKYbWekU6FsASdvWCe0tusT1IlFHZ/YjhwQxvJ8AG2Fzul94A==
X-Received: by 2002:a17:90b:4d05:b0:23f:2757:ce99 with SMTP id mw5-20020a17090b4d0500b0023f2757ce99mr1882060pjb.49.1679393977103;
        Tue, 21 Mar 2023 03:19:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y6-20020a170902b48600b001a1ea1d6d6esm197678plr.290.2023.03.21.03.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:19:36 -0700 (PDT)
Message-ID: <641984b8.170a0220.ebdc2.038e@mx.google.com>
Date:   Tue, 21 Mar 2023 03:19:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.3-rc3-1-g05107edc91013
Subject: kselftest/fixes kselftest-cpufreq: 4 runs,
 1 regressions (linux-kselftest-fixes-6.3-rc3-1-g05107edc91013)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-cpufreq: 4 runs, 1 regressions (linux-kselftest-f=
ixes-6.3-rc3-1-g05107edc91013)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.3-rc3-1-g05107edc91013/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.3-rc3-1-g05107edc91013
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      05107edc910135d27fe557267dc45be9630bf3dd =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6419754bdbcd9d64ef9c9591

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6419754bdbcd=
9d64ef9c9592
        failing since 153 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
