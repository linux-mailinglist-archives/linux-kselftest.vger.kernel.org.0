Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EFA634459
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 20:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiKVTKb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 14:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiKVTKa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 14:10:30 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DDF8CF32
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 11:10:29 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id b62so14902169pgc.0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 11:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s6LTAU2vW7Epq3Ib3HTt0LazxGLlUIaVwIFCiXC9SPE=;
        b=YdsEzR+w74yfV3wZAGTje5Pxa7ezEthOjtGymX1nJRAoHTZCysidgWd3a16rgs3K0Q
         AjLGmPVliGcyElxbxEBiedHBtl5X1jXfD2IbdLqQw4Oq1YEwvxdQWZYJtiuB9KPs/Pfw
         pycpzszWit5cwoezuXZsE9+hiHeb4FNs5O/Q53aG3JUNOBES23i+jVCdZFa5xQK4ejtj
         4sBYLEzCcUkLmwqFzdycOaCMO6g9vJ1ZCjdqDKQuasOdL1N65HRldSbs22PUVZXYqPUc
         MZoqBumVTzg8Mgk7Sfz9zaPkD6ZvkedVOJQuMmrt3p9MKRbpEu9m4Mr8PW91pR1W3smZ
         yD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6LTAU2vW7Epq3Ib3HTt0LazxGLlUIaVwIFCiXC9SPE=;
        b=MLOb3cnDwpKTMxu7gGYxssgM+E6q+a4p1OyfT7EV0TkEIAqjLae7CwTdznXWbjnbvA
         ArgfUvxt/+zjnMk3cs6AxH0Gga+tG6XEpJMnGW/HflJZxrKXvN5rh+zHKVNrNqTyfWZL
         XsjeQaS/hGMVt28/fBmkIf9qtE3wF4pac+TMQQe8sAY5FylHBGByDZS8zlXyw2YtW834
         djE2q73bhl4hFtELpBP7038GXQI1oYU+C+3ozePEeUSRlQmtIA3MjGKPMyjaBc/pcMmO
         yRtWm9K7pvXZ9y1YF0zZU1pE6MifOMgie6kmBc51nTQM8lUZGMRAr2IY86FeGG/TZE/k
         SlpA==
X-Gm-Message-State: ANoB5plM4l6kh/ulvKQ14Y22PhknfrbqfkHqm4/pf1DfpzmmOjjiHlUJ
        wVSH85IMLhLM63ioX8L2hXYYvq5bAbm7P2AOt/o=
X-Google-Smtp-Source: AA0mqf7JDob2RO4gGAfbXKonUM3K/1g9WLt5yDTbD0Vtb9kaJebzLrDnd1GgP+xcxPMDAEJccz2rVw==
X-Received: by 2002:a62:5f81:0:b0:56b:bb06:7dd5 with SMTP id t123-20020a625f81000000b0056bbb067dd5mr5886180pfb.3.1669144229190;
        Tue, 22 Nov 2022 11:10:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b0018934d1ed31sm1967995plk.177.2022.11.22.11.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:10:28 -0800 (PST)
Message-ID: <637d1ea4.170a0220.6a6f4.32be@mx.google.com>
Date:   Tue, 22 Nov 2022 11:10:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-18-gc93924267fe6f
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 2 runs,
 2 regressions (v6.1-rc1-18-gc93924267fe6f)
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

kselftest/next kselftest-cpufreq: 2 runs, 2 regressions (v6.1-rc1-18-gc9392=
4267fe6f)

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
-rc1-18-gc93924267fe6f/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-18-gc93924267fe6f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      c93924267fe6f2b44af1849f714ae9cd8117a9cd =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637d143b3daba947322abd03

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/637d143b3dab=
a947322abd04
        failing since 35 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637d134deaebc784522abd03

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/637d134deaeb=
c784522abd04
        failing since 35 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
