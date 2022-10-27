Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005A160F7F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbiJ0Mtm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbiJ0Mt3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 08:49:29 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEA3220D6
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 05:49:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v13-20020a17090a6b0d00b0021332e5388fso1368469pjj.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KeXvE+coebz+SOdTmP9nRqDlOIoO9StTPt0MCvxlYrc=;
        b=mEwDOTdN39HxIjgy91hkz5IkYvcEK2TRrpmdNrIGbHL8NqrCVB3PZoL8jZT/gsIeGu
         +CDzvpnYgK2CiEQv9O5tBqop9OeZqY+ZNmkhNqXQMNDBy/VSXeeULBbMlLxadmEVbG2V
         jgbQzvSUriWNTzeTfUx+EFxeWRliHxuBbPAUweVY4E5jumfz3CA088J74XKQ544YjDfz
         1VJsPHqSthNSqLVoSN1q71Elksva8aub+G2H2fS9kbnCzgDj66coa75OTnXNeyCuFMAr
         TJ17iNHjHumANoEaVG2YNpawtb102AesCj4KWMfuDT+ga9S/iANARjXKuK8kk+x7dHdw
         LLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeXvE+coebz+SOdTmP9nRqDlOIoO9StTPt0MCvxlYrc=;
        b=lu9f0erIM0Tn3pLlOGOg+WcdoWuZB2QVsZa2AzYAsUcLj0Ae+YcMuwpBJ8zVcG6uJ9
         BnwiFI6uIJzsz4bUuDq/e8045xp+nhQY55M2ofioUHV86mV/YTtQ7Rf5A0/2JFiYgT3t
         qP6fXL8KZhjgnD3fIHuuNHmTBYGtYlsRAX3DGapIImuPkJRCG+rBJlB33kjCvo5H4ZPR
         Tbjdrll3G4bDZulGySeoXJSc9YRepvFPbNEC+Sek2JuMPveIemkIPXibDH93RuKGVzFP
         4bNuGc2GX5ttE/nF0/80IddNJ74i3M4ncs2bbuVBHiflmCpyXUx0RN3OrFKBfrEG5sFU
         eI2A==
X-Gm-Message-State: ACrzQf0V25CY5+jnyIxZa5X3EH5Cg/jm6rmVv3Fol3lQLk2TGGzhzAMD
        SYVtUCeRoNw6rAYH4dKwR3uIKuPtTGmZ8Rbt
X-Google-Smtp-Source: AMsMyM5GsoBcujyQ7Bgt25QCfHQHb5audtN5dwXYZwP/sUFTfy3e6HIVIh8Ue3uvMqHBX93cAd1bSA==
X-Received: by 2002:a17:902:dac3:b0:186:a437:f4b9 with SMTP id q3-20020a170902dac300b00186a437f4b9mr21792935plx.29.1666874965049;
        Thu, 27 Oct 2022 05:49:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d4-20020a63fd04000000b00442c70b659esm981272pgh.91.2022.10.27.05.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 05:49:24 -0700 (PDT)
Message-ID: <635a7e54.630a0220.c39e6.174d@mx.google.com>
Date:   Thu, 27 Oct 2022 05:49:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-6-gecc7d67af402
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 2 runs,
 2 regressions (v6.1-rc1-6-gecc7d67af402)
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

kselftest/next kselftest-cpufreq: 2 runs, 2 regressions (v6.1-rc1-6-gecc7d6=
7af402)

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
-rc1-6-gecc7d67af402/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-6-gecc7d67af402
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ecc7d67af402dda4b4d353dfa9837339319c9d4d =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635a7227d21a5bbdebe7db71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora=
/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora=
/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/635a7227d21a=
5bbdebe7db72
        failing since 9 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635a70b755903146cce7db70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/635a70b75590=
3146cce7db71
        failing since 9 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =20
