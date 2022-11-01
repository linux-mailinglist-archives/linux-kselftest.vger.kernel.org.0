Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9762661486F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 12:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKALX1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 07:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiKALXZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 07:23:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C42DA2
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 04:23:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u6so13249581plq.12
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Nov 2022 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/TT7xw3z8Ydb5NFye5QCxTSIVEBHjwSDhUq34YgBNzA=;
        b=ceA4RBMH6tfIQkhYtke0JTIThg6iSkRmpgqUar7zeUDDeAcLFtN/uZZvqqYawKjaff
         QL/9XV2hueTl36b7HUeg1fZHZZDWQ5BETsXkUSCnzZ63TwpQlYAuw4T+A8gaDMswFw52
         PohDE9OaXezEyK2OO0w4V/aiDYd/Zz39Tzh059G1ML9LFQEFdxElYMSlapeMkj/R0vU4
         mq0ebc8gtXmB4/M7wsf/V6veZ74Mje7Uyd9cHqDAMRj0Q8PhjctIOTW4S4ZI4RXbdNVl
         izd36i0bIW81ah1Xf8pB9Q8ggqbojj3IBfqQaUBqA4SRITEUJuxbx5PLw6/qZk9nQG7m
         15gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TT7xw3z8Ydb5NFye5QCxTSIVEBHjwSDhUq34YgBNzA=;
        b=ikFspN3ZrE2aqmZkQnnzpI+JTkkX60bNTcxzb+niDl09z7OyHRm2SoUlrEZM7IurXY
         ttTKvd8nkL7N0gnVEh09DSobtK92tCBvq1lddc6mmu7VXHtYYWpQqqElaQ6SDuRsMQNF
         C+0IfMvAYqPBX00hwrohgxJ5aNS2w5Mc1B1FqmfjwRP2hRh+s1XyrXb52E/7hOWbhpQl
         jH1tKdUxwk6IpqVyqlS+qR0XzCkFq1GdSArkSsicHmpJl3uOSx0NfYde/tLsP2DbZVMc
         XRD+TaQcGNktsXG4bSxOS5RdFJKZpxy5cM4gIEWzbGGFeGkeA51cHAw2S6wA0HzhxbNm
         3z/Q==
X-Gm-Message-State: ACrzQf2Om6GgUWrifq4XcejDa1l6AwGdWC49uz+GXOuQgPlyJY8DoGnK
        FywbtENum3Kw4PSr/u5QheltsQ==
X-Google-Smtp-Source: AMsMyM7kNLKIct/dFki1VEdhFR1PXRhnqxjLK8WqDSzAUCwlyGjkHOnaFQkC1cQbvC425n/biUr9PQ==
X-Received: by 2002:a17:90b:152:b0:213:dfd6:3e5e with SMTP id em18-20020a17090b015200b00213dfd63e5emr10387090pjb.229.1667301803508;
        Tue, 01 Nov 2022 04:23:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a190-20020a624dc7000000b0056d2797bf05sm158094pfb.217.2022.11.01.04.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:23:23 -0700 (PDT)
Message-ID: <636101ab.620a0220.40c02.0389@mx.google.com>
Date:   Tue, 01 Nov 2022 04:23:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-13-g67c0b2b52916
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 1 runs,
 1 regressions (v6.1-rc1-13-g67c0b2b52916)
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

kselftest/next kselftest-cpufreq: 1 runs, 1 regressions (v6.1-rc1-13-g67c0b=
2b52916)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-13-g67c0b2b52916/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-13-g67c0b2b52916
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      67c0b2b5291656cbcb15371f835f5152fae2f7a2 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6360f5281728a4be66e7db75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6360f5281728=
a4be66e7db76
        failing since 14 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
