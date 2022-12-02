Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC918641004
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 22:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiLBVbJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 16:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiLBVbH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 16:31:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038B4EF0C0
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 13:31:06 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so6238738pjo.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 13:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4V0IlJVsVzvkONmWShc/60CdLt0YVIWRPcZ/gnk4niY=;
        b=Kc7PLi+lShH/MUn/wODHBBaVTIiO2/9TM638ktZgpsThmJIOYgIO23Txpap1TIb7RE
         T/7lXVh5b1veINHKPhuAnwF/U0uBKYM/5nE3nQh0g1hd3YqUvxD91GxJRI4VoJaaIecL
         p6kd6leBa45/0dq1aDZUThFcdGwXaDfataN8xvAIbxXK7COKE2GH7yjgPsId0KFrEA9K
         56E+ok4Fp1WAGN+9vIBHMIV4rfowRv5ApIvNa8LBXv8N/IJyk0Svi51lXW5HylDXylY3
         9xHk5KzHqw9N+IL3xWHQ37PVqlQ6V+GjO1RD3JIxCxv7Q6nculNxeAGYvlKF0IwSnfEF
         MaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4V0IlJVsVzvkONmWShc/60CdLt0YVIWRPcZ/gnk4niY=;
        b=Rw347QxtOuDnXWeip877XNiP+eKEzz7iu+KY2sIk4IAjx3s76lSHpSTzGOKIaZ2UYa
         mMYH47DtWl0pwgtPLtXAVYl2qK5SWxP/UhyxbMCPgh5PiNkiMbmAywE4f5hHO7eRwOCZ
         jP5qDRkyBum0Jgh+tSYSfVVYvXldzK3KZWE3gu3m0hXh6S7vZ7vkucJ7AAlwsH3T56wU
         56N0YnccRYSKweTsOkA/yjISxVGpESOhf9Oed0qsAhlE/Bbms1zq72lDUfKZhK5x9tZB
         IdqxXprSDsXIsjrgxoqOkT7vdGF7lSXxOMIpMNWiTsvufXXWNN++iYr0IU0EmyxT94E7
         +w5g==
X-Gm-Message-State: ANoB5pl3pzdQViiYOeRSFP8SdoCb7Ah+J+ZKAxoiB6ynNBQt7m/MV3KK
        rwpVvbsvVO/gyEUOapZTcPuP2w==
X-Google-Smtp-Source: AA0mqf6eAqT/EBf1rztpLaymjh2Ye6gJw/2KjIodyRWh7Rhe6Qwa2EEryXXUSM7eEQwq8BCISee8rw==
X-Received: by 2002:a17:90a:9d8c:b0:219:4a19:f984 with SMTP id k12-20020a17090a9d8c00b002194a19f984mr22933313pjp.198.1670016665533;
        Fri, 02 Dec 2022 13:31:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b00189348ab156sm6013335plg.283.2022.12.02.13.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 13:31:05 -0800 (PST)
Message-ID: <638a6e99.170a0220.4d771.bd50@mx.google.com>
Date:   Fri, 02 Dec 2022 13:31:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-24-gd5ba85d6d8be
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 3 runs,
 2 regressions (v6.1-rc1-24-gd5ba85d6d8be)
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

kselftest/next kselftest-livepatch: 3 runs, 2 regressions (v6.1-rc1-24-gd5b=
a85d6d8be)

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
-rc1-24-gd5ba85d6d8be/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-24-gd5ba85d6d8be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d5ba85d6d8be7da660d4ac25761a48c74ade958d =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/638a5f0ff7f51d81992abd01

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/638a5f0ff7=
f51d81992abd02
        failing since 45 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/638a60230303129d6d2abd06

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-24-gd5=
ba85d6d8be/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/638a602303=
03129d6d2abd07
        failing since 45 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
