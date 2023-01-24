Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC7679353
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 09:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjAXIoU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 03:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjAXIoS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 03:44:18 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EBF32533
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 00:44:18 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 88so2565233pjo.3
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 00:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ehelfq+rhNrHlG2fAJjgVDJwU8vfjjSRfMMAMsTQNtg=;
        b=YFJlD5tKkFx9bdax/hNeRn0Ep7fj+Rt/ZaihhDpZN8P37u8+7oWbr5rmPCK9el6Uzt
         hRHv75X3DSKxExRjst7gyCv+DbSAZWEC9oiMLD8D1E7qXX0sxcEAg/14e2erkJQ6Xtoi
         gR4i44rqw2pdoHKFg4NbaxGDit5xeAhukvYZQSSQkArslmTh/6yVOU54qbBjuUIQfUZB
         vt06lunwh4NQctYLY+H3Gyj9KgQO2uO7duN7zLoj5FMF8wXoXpeBLECP1JEmAGLxPmy5
         6UtKrx8MJotuCU0kNbHV9lhBYGlYLwD1KYgbrub84Aq9gL2Zncp643v9aEIy8kAARwwp
         Ii4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehelfq+rhNrHlG2fAJjgVDJwU8vfjjSRfMMAMsTQNtg=;
        b=HWx+ATAoBWArvdKZoQoowYA/QWHV1cCltHB/XVw50YO51/g+CQ0LLJy02i8BRURoXB
         j1Yfv9i3lbu1bbfUKYbavotpwfM1eTEz4oA94usfQCEP2ZSeH5eMAobBIaTpP/hNPOsV
         QKTe/g4UTe12TvcyzTXvrWxlEJvggrpggorYEC16+SBG8MaW/8ppdUQNNAPjFvDQIQSG
         B6cx0jQ5+PWUtGUanwCUdQeYlJAIm1+EsCoorvAz4JJorkvDySHyQ/YV+/0Y3/eArgQ+
         BXhyvvfY/V3Y3oyinKtjYb+ccH5GjUPwkM+riZk0wi16gcXz3ETL9SPS9Eo4UVB460Nu
         clJw==
X-Gm-Message-State: AFqh2kr6W24M8e19mr6T2mBvxT5An3l/MZu6qh4pOl9hGvVs+SJC+Scq
        oTUh2dxwhhuKO/87BZNFAq7Zw4s4A7PRF3IHFlY=
X-Google-Smtp-Source: AMrXdXtN9TPlIsxgsrWNYWCK3JptdGN3yoWhWyB4sNVcnzjF44y4tWsTDXVZan11t45d3TM8piXK5Q==
X-Received: by 2002:a17:902:988e:b0:189:acee:7aa4 with SMTP id s14-20020a170902988e00b00189acee7aa4mr25761009plp.65.1674549857423;
        Tue, 24 Jan 2023 00:44:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902744200b00192a8b35fa3sm1094070plt.122.2023.01.24.00.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 00:44:17 -0800 (PST)
Message-ID: <63cf9a61.170a0220.a9926.2075@mx.google.com>
Date:   Tue, 24 Jan 2023 00:44:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 4 runs, 2 regressions (v6.2-rc5)
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

kselftest/next kselftest-cpufreq: 4 runs, 2 regressions (v6.2-rc5)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2241ab53cbb5cdb08a6b2d4688feb13971058f65 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf8da07ddced786f915ecb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-cpufr=
eq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-cpufr=
eq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63cf8da07ddc=
ed786f915ecc
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf88b5e324ffd662915f07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-cpufreq=
-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-cpufreq=
-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63cf88b5e324=
ffd662915f08
        failing since 98 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
