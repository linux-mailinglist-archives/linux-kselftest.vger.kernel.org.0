Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB8F68A480
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 22:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjBCVSY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 16:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBCVSX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 16:18:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E84D26CCD
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Feb 2023 13:18:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso6107026pjb.4
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Feb 2023 13:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RHpVEFiV7XUeiljzgI2mR7cU0GbYfKb6oJ23gLuuQEI=;
        b=FbKRC+4buduZqjghHE6slNT0cw5E/7YEyC1HaAl+CXgyGx3tYyKval7Do4hcxPa5qE
         Yp9TbAvrOFdHQcNBdujZZ6kSzhaU3rfYfDIV4WvPw/pQjHTUi/JmxIo4RruqqIGqqM0V
         aJ/Pf5yYdw+G6gOX1hmQ2zY5A1F9WvKLnuKdY0vGAaQCOhKmQSgYc96MEpf5yZVeK2UE
         f+3NaZdgVLgMrCCqplrdS2oCI5CJRRwcR+gDvuBpdz24kUq3nMQPD5PeJCnoI1EgJs4e
         wsLDGHZkOdRbzQ2i/yuV3Xik1uIIx0dU/VRxYa5oCjanENrtTlKAVluscgAGn799bNg3
         4peA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHpVEFiV7XUeiljzgI2mR7cU0GbYfKb6oJ23gLuuQEI=;
        b=u+iMmW64z+tJSdcnTWzW0IwKc6pwIU7DV245e9lScpOiC9VS8w9yqp5GAP0HQA+id7
         SUlvb+g+YG+HWlk5tRT5Y8oYBDzTqRkbZ9uZPLbfN1ygRIH2ie5OP0GMLJEhPM13yIm5
         D+Gl/Ro6aTXKvdp2weCDCNeOvx0KH/FSqLUkv8lGNEyEhXBU8BqLi+eSP9m8qGF0b3MJ
         FM87wNRD2AtBfgRAhWvujOQiG2SJ1jUfNGmR9weJgOqHt6aXnn+zvsnObv+Ajlrlreim
         xyB7oYdxdPdg73pSPcWJDnjsodZhk7Vj5VyIQzMLX8FmUScpMG7CpvdUn2sQiboBJXvt
         Hz5w==
X-Gm-Message-State: AO0yUKVcBXw4/Fwj0sr3QnVaPcLf7GnzTpmt2DlLn86lrQ7ulqKz/SIO
        9r/vSVL3SgipIdFXclFaVhiHFg==
X-Google-Smtp-Source: AK7set/ORCt+MdnKN/I0Kti+5+Np3ICXh2AinVCm5txvG9eiXFUAkp9CJXAPVCDq9/liQIAAIS0uQw==
X-Received: by 2002:a05:6a20:d044:b0:ad:97cc:e957 with SMTP id hv4-20020a056a20d04400b000ad97cce957mr5155714pzb.39.1675459099985;
        Fri, 03 Feb 2023 13:18:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v9-20020a63ac09000000b00478eb777d18sm1877261pge.72.2023.02.03.13.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:18:19 -0800 (PST)
Message-ID: <63dd7a1b.630a0220.40402.3700@mx.google.com>
Date:   Fri, 03 Feb 2023 13:18:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-35-gb23b16d35135d
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 4 runs,
 2 regressions (v6.2-rc5-35-gb23b16d35135d)
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

kselftest/next kselftest-cpufreq: 4 runs, 2 regressions (v6.2-rc5-35-gb23b1=
6d35135d)

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
-rc5-35-gb23b16d35135d/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-35-gb23b16d35135d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b23b16d35135d8c067abde6a6e1467127c3dea87 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd6ebcc5f1746c03915ed5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63dd6ebcc5f1=
746c03915ed6
        failing since 108 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd67e967df066bae915ee8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-35-gb2=
3b16d35135d/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63dd67e967df=
066bae915ee9
        failing since 108 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
