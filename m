Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192C96164AC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 15:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiKBOOc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 10:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiKBOOb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 10:14:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DD224F22
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 07:14:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l6so16401752pjj.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GFRjG8i3T4fOS8Rv8e2nX5ZouWI4bfnaD0zolGqsLv0=;
        b=nDcX5xsc/lMAxCm6DPA+g5JhmvrvSwtdzP86CHAhQUmpdPsmGSaMbToum6MUl3zRx/
         /Yh2b1ecdzbxw+MPjUxZri0Bfti+Eva2eb+5fUndRWauYDBC8S6RO41i0qbT219DyiBF
         0oNtCegjDtQgDUMtsyQZ6A/ftB6GzVlYyyXKlsBiOV456J2fHh6/FhYoiyq3CekuUI5r
         maT13/nmIVIS9A2Mhdi2FvXe66MPPvhn86hh6dkRRuFh7Mbo2u5kbRX3L0956r1JCb9J
         ICHj3XtTs7Ff7yi5ZhKduCyJBqUunBo47vjI3o7AVf6Tjpx0y0qllwqQ85r56z/GUrLu
         c+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFRjG8i3T4fOS8Rv8e2nX5ZouWI4bfnaD0zolGqsLv0=;
        b=TySq8Jy6OoljaNdWR+IV8HNGiyLG9MM1jgG7ukZqYNkoC/j4KuL9rPDfvC1BdTjwAl
         rnMUyWu+HbZL7pi2krWIOa5b3h8es5v6f0nXWWa4HIT+j4kcIZVZL0LiP4oKy5dVe7rm
         rQ1C2i9/s8FpQSOiUnuc0jN1OoXURd8lIXwzRwI79SwjKPG4udfkyXKcNHhUn6R1rPtg
         BQ31CKoNSp/0hTUOz1S/9/xHEP4pW/UPiO4ybWeYtjluNBCyRUb4130ZkjcmvruxQO6I
         WLIxYPVTUrCxviyKnnViZ/rzXZVhC5rUS2+JKJMZ3TNwkpYcq9H3V7ySzPjVf2poFK3r
         NtTA==
X-Gm-Message-State: ACrzQf17zjst3fdcuu9kfAgMv6WpVXEJPG45KMj5OR3gZjokk9cwEz4p
        1gUiBYwmgTNKh0NXEgqAxDgXkA==
X-Google-Smtp-Source: AMsMyM4Ykz72abx089+up3PG66h/twa33bkTvW77Y4mwfQuNOFC7e7sDe20gClNqkDHwkWCsfuESTg==
X-Received: by 2002:a17:90b:1c10:b0:213:1bb8:feb with SMTP id oc16-20020a17090b1c1000b002131bb80febmr42530267pjb.214.1667398468062;
        Wed, 02 Nov 2022 07:14:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m19-20020a17090b069300b001fb1de10a4dsm1502251pjz.33.2022.11.02.07.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:14:27 -0700 (PDT)
Message-ID: <63627b43.170a0220.ba683.2661@mx.google.com>
Date:   Wed, 02 Nov 2022 07:14:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-cpufreq: 2 runs,
 2 regressions (linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67)
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

kselftest/fixes kselftest-cpufreq: 2 runs, 2 regressions (linux-kselftest-f=
ixes-6.1-rc3-3-g89c1017aac67)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.1-rc3-3-g89c1017aac67/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      89c1017aac67ca81973b7c8eac5d021315811a93 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626e980720ac3502e7db67

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63626e980720=
ac3502e7db68
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626aeb11e7c17733e7db5b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63626aeb11e7=
c17733e7db5c
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
