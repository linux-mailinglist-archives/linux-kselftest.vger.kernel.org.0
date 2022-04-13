Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4694FF988
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiDMPAR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 11:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiDMPAQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 11:00:16 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC20963BD6
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Apr 2022 07:57:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a21so2215230pfv.10
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Apr 2022 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ZNK7KkhZjydv5Ioo19jJx8pucp3jvVpvqCz6MU8nwws=;
        b=xOXOMxgDFKzElbzTyeibFP2vq8BqpzsSqH8eBfKyuAQXBPXlK75v+RZWWpJLWb7DPL
         veEAklUWmXDqzPnPP+0GcVWSblvhp4mW3PSqhkHScnLySgH78NzsAx/PYtOHaS4TxPz4
         0BXt4LdNEe6CVuNu3FM+0Rw4jGZzQUysjJBXzb9aTpO9+ValpTxSReZjsPEI1yw2VxJi
         AYFoWMd72batmPY9+lo6HX9WwW2rGnrwWbguT4cdtMzJKgcwus1o2WBDQDMWu/WfcEvJ
         jGcslqLkP0x4jcDJlLz+MYurDIw/nBoPJhbSdTfrnTtYQj4nXqdnstcgzYTwzMDvEfmB
         p55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ZNK7KkhZjydv5Ioo19jJx8pucp3jvVpvqCz6MU8nwws=;
        b=b1O4PfPigWrIakhaCiF90o7oEMbZGScCmo4Q+SPM2+Oz7tyLYOPMm1HmK6TiEPkl/V
         4MsHEUTD1utcbnnfjPXiSsjHlr3Qklziun0d+/0E39GPC5kNE5XpFDMNH9X2Afvi7g2L
         UPul4OfQyqCFjLl+zM9Flw7Vp2HCz0kEKShE72TSr3vnLJMZqg2aSIGUJgIGQm2L/IMa
         Y1yUujBZwYDCtwOIZu9qmuHqeBiGZGhspCQrHM9jHpAxQAr9k5qh0t+CPXWfyMX8NI4M
         79rgtbS+94KpErjmVNaz0lM/CktT0uxVomofmKNASGzTBxR3Qbh6ebLm15rJfcBkBcU3
         RP5w==
X-Gm-Message-State: AOAM5302R3bU211iTLFZ7gHnyVrfIjPFZsswqjFyxBhx5YpJn7YGAI8V
        KNDoZqPDQmcrtuLGBphfutgPjQ==
X-Google-Smtp-Source: ABdhPJx7ls9NpaBuw+qMjmFZXDA518UP8khwsxSe+0QkQbgJxtuaUoKhTd1/whHRDiETP3SkkrKT1w==
X-Received: by 2002:a05:6a00:890:b0:4f6:686e:a8a9 with SMTP id q16-20020a056a00089000b004f6686ea8a9mr43541231pfj.83.1649861874350;
        Wed, 13 Apr 2022 07:57:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b00385f29b02b2sm6388668pgc.50.2022.04.13.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 07:57:54 -0700 (PDT)
Message-ID: <6256e4f2.1c69fb81.9392d.071c@mx.google.com>
Date:   Wed, 13 Apr 2022 07:57:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: linux-kselftest-fixes-5.18-rc2-1-gce64763c6385
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-rtc: 4 runs,
 1 regressions (linux-kselftest-fixes-5.18-rc2-1-gce64763c6385)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-rtc: 4 runs, 1 regressions (linux-kselftest-fixes=
-5.18-rc2-1-gce64763c6385)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-5.18-rc2-1-gce64763c6385/plan/kselftest-rtc/

  Test:     kselftest-rtc
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-5.18-rc2-1-gce64763c6385
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ce64763c63854b4079f2e036638aa881a1fb3fbc =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6256d64e93f3050e2cae06a5

  Results:     7 PASS, 3 FAIL, 8 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-5.18-rc2-1-gce64763c6385/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-rtc-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-5.18-rc2-1-gce64763c6385/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-rtc-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/arm64/initrd.cpio.gz =



  * kselftest-rtc.rtc_rtctest_rtc_alarm_alm_set: https://kernelci.org/test/=
case/id/6256d64e93f3050e2cae06ab
        new failure (last pass: v5.18-rc1-7-g79ee8aa31d51) =

 =20
