Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B116B582E
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 05:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCKEhk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 23:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCKEhi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 23:37:38 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D350C11F68A
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 20:37:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso6995759pjs.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 20:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678509456;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8SUxGDt0SSMZ/omGymFmLyMHO55c39ChwXxWb/sRO3k=;
        b=HtQWTQExNGf3ZNzX2J/ESm84wNAKjWMH6DsgFzxqKTAVKaY6up+pBNbuznf+Uhvz1C
         boPkarzg+PbFhv8zEIscOT8L6YS0ehq444tCR/J2lBHOg47wtc2oR8NeW4Ze212RtgnM
         nzIkwjHhm+Uca4l9G5ACAYsfSfT/PWx/vGZBnkQyslaWSI3mADvURZbuNMel9iqD+zU8
         CL7Jn6X8OEe4HwVBrEQSkzJTziwUKDaD/xoo6DKXWpRJ/211of3tJeLGLcntF5f0ur6k
         bVzfHRUQCE4fEcl3rxaPoWDa9BjBnpJx6yybWjDw2kAEc+jq76rMlNrRC5b2VO1SJe4E
         bFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678509456;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SUxGDt0SSMZ/omGymFmLyMHO55c39ChwXxWb/sRO3k=;
        b=G6aKkpc0a4vi37Eoi8hCw8smGLWvyBBam0HEvG/41Lbi1sOCqU6ShI24yhcYbAOubW
         p4EblzG3pqHrIM6qeYhYxH/YvYwiFMhFVxlGn3epl7Mt+48xq97jJpDTz2j3QvvTfKJq
         JuM99C0A7nX6BNoiq2k3dHd4OAp1g+HqhSJNYM8jyMLEJD/IDAMA/o3iVEpSHSLf0yqO
         hz4iHQr/0BAjnIh0NRmADdjQtBzmNMHa7NpEtwu+B74g0F9EhR0gJhgOvZGMlYB4/cZb
         DhN+daKQuE+0kl7bpVwm3lNd7u/B2IdB26HCyZbwSV+yZckaEOc72xPeGDbhVF1w8KN0
         mKcw==
X-Gm-Message-State: AO0yUKU0bgzMd/DmgjR6F3y2A01hgsSyfdDwtp1uYrjQ+weGMrBtZFx7
        IfajXkHF56F4+N2NNlvGOkDyqy17r8bQUTiwAdaU9vTW
X-Google-Smtp-Source: AK7set+LzNykiZR4zMhzz4stWnt86Wt34wDW7ZgALxjojeVyUAomcxC/zqz62Y6INHQ+TiU1X6HBdw==
X-Received: by 2002:a05:6a20:a025:b0:cc:1ec7:45e5 with SMTP id p37-20020a056a20a02500b000cc1ec745e5mr26231794pzj.35.1678509456288;
        Fri, 10 Mar 2023 20:37:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bs62-20020a632841000000b0049f5da82b12sm621104pgb.93.2023.03.10.20.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 20:37:35 -0800 (PST)
Message-ID: <640c058f.630a0220.7e009.1afa@mx.google.com>
Date:   Fri, 10 Mar 2023 20:37:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-2-g624c60f326c6e
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-cpufreq: 8 runs,
 1 regressions (v6.3-rc1-2-g624c60f326c6e)
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

kselftest/fixes kselftest-cpufreq: 8 runs, 1 regressions (v6.3-rc1-2-g624c6=
0f326c6e)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
3-rc1-2-g624c60f326c6e/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.3-rc1-2-g624c60f326c6e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      624c60f326c6e5a80b008e8a5c7feffe8c27dc72 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640bf8a0925234c9e38c863c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/640bf8a09252=
34c9e38c863d
        failing since 142 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
