Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EABD50ECB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 01:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiDYXnl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 19:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiDYXnj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 19:43:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC8F19C3D
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 16:40:33 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso856468pjj.2
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 16:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=euSReeHKrSW8f17Npb9YYKMb4nIVPHdGDcW9OpEuVcI=;
        b=7qzSgoc2o5aVcKxCwngxVkQ/Q7r2OrmALEVMWHlpMKDGGJiEQ70qmAiOOzojP/zPQK
         sgjLy4vrv9T4rSaQrXfAV4eFttgHpuO1sToQzdrGyNxVKwLX7JqFetSXqTpok6YIPbZb
         Ns5PokCHtKNgbsHx7MyzaN/YBdN7+84/cIr9jA5S8l3vTbCBP2zpDi0AWBfF7JzI/iOY
         zguICf1iRaPN7Yl2Bd31FPqBlb5tkKWPRlfRtjJgaX0UXK6vzo4RxNqWm4fRMDqyuGS0
         oTortAWmDL25+HBo206eMPQxq06np5T+yG8WqKfMpw0INsDaqJfCy/N75oEUheo9dd4r
         O2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=euSReeHKrSW8f17Npb9YYKMb4nIVPHdGDcW9OpEuVcI=;
        b=QLSd0/IVk21RqfVFuHbehgNSGD0LpZFpYjWsz6ngcyuWrvQMkdGRdafol+jbqMCgC7
         CiNZ53FppBbiILJq1WDdE4etBFQRhPYx1xw3TXwZMmzTeGwwJ80nL22tpG3JypP6/g85
         msQ6Y7JYK7rSyZE0q95iay26ANvNt/9vTDGykQNBZm4zE3oL9NHpFhDBbSI17AmvtHNP
         tY13m05qBoeIG2SzUkp2zq85Ehl/mWUYmrtivskMGg0VyW5xxRCvILvkNdV6o2t1tH4w
         PyJk0kxUNKBDCNJgHEQ1ulbF0FZSwjmk0SdgXUrd1pAP0r9nu1vg+nkPS3EMoDbbJ6Go
         DDpg==
X-Gm-Message-State: AOAM532X5l1sHJTCcajL36qpnfT4XTe2YsVn8hkq+wj3pjgLEMjW9d1X
        9aRdJ1IEBuLz47Nnokn/PL4jui91xJq+ay2obes=
X-Google-Smtp-Source: ABdhPJyA8ACBVgSFbKFMF5dCVxqAPv3KJE+syeca06VG7btUXyutRTWIxmoJZOYuz3Oxx417GXcwlA==
X-Received: by 2002:a17:902:9305:b0:158:9543:70a4 with SMTP id bc5-20020a170902930500b00158954370a4mr20833550plb.119.1650930032701;
        Mon, 25 Apr 2022 16:40:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bb19-20020a17090b009300b001cda0b69a30sm388041pjb.52.2022.04.25.16.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 16:40:31 -0700 (PDT)
Message-ID: <6267316f.1c69fb81.f2f93.1518@mx.google.com>
Date:   Mon, 25 Apr 2022 16:40:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.18-rc3-9-g170d1c23f2a3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next kselftest-seccomp: 5 runs,
 5 regressions (v5.18-rc3-9-g170d1c23f2a3)
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

kselftest/next kselftest-seccomp: 5 runs, 5 regressions (v5.18-rc3-9-g170d1=
c23f2a3)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 4          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc3-9-g170d1c23f2a3/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc3-9-g170d1c23f2a3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      170d1c23f2a356932259034f73d579d0bab857d6 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 4          =


  Details:     https://kernelci.org/test/plan/id/62672294ad69f5ebf7ff949c

  Results:     87 PASS, 4 FAIL, 8 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3-9-g17=
0d1c23f2a3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3-9-g17=
0d1c23f2a3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220422.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf: https://kernelci.org/test/case/i=
d/62672294ad69f5ebf7ff949f
        failing since 60 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence_no_tid_in_err: https://kernelci.org/test/case/id/62672294ad69f5ebf7ff=
94a0
        failing since 60 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence: https://kernelci.org/test/case/id/62672294ad69f5ebf7ff94a1
        failing since 60 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/62672294ad69f5ebf7ff94a5
        failing since 60 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/626723767c1ab4f619ff9474

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3-9-g17=
0d1c23f2a3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3-9-g17=
0d1c23f2a3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220422.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/626723767c1a=
b4f619ff9475
        new failure (last pass: v5.18-rc3-3-gabd26d348b2a3) =

 =20
