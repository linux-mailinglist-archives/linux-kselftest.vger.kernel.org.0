Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995564C54AA
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Feb 2022 09:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiBZIpX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Feb 2022 03:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiBZIpW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Feb 2022 03:45:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32B61B84EC
        for <linux-kselftest@vger.kernel.org>; Sat, 26 Feb 2022 00:44:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e13so6694752plh.3
        for <linux-kselftest@vger.kernel.org>; Sat, 26 Feb 2022 00:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=hleVd6AMEiCC0Gx10crdH6ea4EGESWOa/Luc+HHS9KQ=;
        b=duItfAcvtHLHLZ3FuOS/LUPwMI7VBJMGsQeOoKYRqMCbnrxmBbu6K6lIJ4uWShGDd+
         DPbwf1tHbOVn1nej0UVybyRH5FWuMwt1bsHbqRYJeUGzm+L88G6ItNUMjWIj8aofNLgz
         1u1229lYDsl6ahMSVFG8mym6T3XW3hmvkt+B1Q/wS3bCtOr35dYCQ8Ak0tkXOtKSVtG6
         kZKo36wkiTIChmpFXxdbAD7wp+hVVtFfGedfyZB4tZjhM7AJav3X7kMDQWE07hhAoCIt
         86YeagvuJU8LlfMSrQ3Ov0kVC9HnVEJqrr/S69jtl7+BO4irMlhdLPAwcLuTfiz5+w/g
         5ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=hleVd6AMEiCC0Gx10crdH6ea4EGESWOa/Luc+HHS9KQ=;
        b=fl243E2NF+xb8Lt8y4ym/LWfb2CD1WNFnMzbmChgV46FppTF7z9nWikIvwv70pQEf+
         muNt4It0WX5jTwElFG3tIB8BtvtecU+4BK/lBeDRQwvTcR6ExS+BojPiNbjmuEg1LGvn
         geThXWpuXp3pb3nQbzDU5abVpRyORFg13YntLhAKgkGeSJWz9gnmEc6pqGEq8PlfXvKT
         mCXItSmRFVFhPalEzXl7Td+aGxLhq/qu9lbQATBzQoUBqwepusxhNYhfbXh4ql7gxY5l
         A8sSASX/9n/TJj15wlycUxnX4iPA2JPmGMqbcWC1xMtWjI8NMwYjYWj7UIymxfz15tyX
         mBNA==
X-Gm-Message-State: AOAM532KRO6IILlQ5EtZrTeRBbLGOqd4FR7OgxkPn+O/uETmzBLl6+f3
        jTzHjtxU9ygyTaKZEhpU9orokHIB+MUluBVDSSA=
X-Google-Smtp-Source: ABdhPJwgxHt3FuFkhVcQsSX5t0teDiUcdp9sTMDe24/oJk1lgobYqSk6fTjYRde+ixXk9xJPsVdqaQ==
X-Received: by 2002:a17:90b:3682:b0:1bc:3891:b266 with SMTP id mj2-20020a17090b368200b001bc3891b266mr7067302pjb.137.1645865087160;
        Sat, 26 Feb 2022 00:44:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00230600b004e1aaf9b302sm6296166pfh.143.2022.02.26.00.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 00:44:46 -0800 (PST)
Message-ID: <6219e87e.1c69fb81.aebf4.04b9@mx.google.com>
Date:   Sat, 26 Feb 2022 00:44:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.17-rc5-17-g2aaa36e95ea5
Subject: kselftest/next kselftest-rtc: 4 runs,
 1 regressions (v5.17-rc5-17-g2aaa36e95ea5)
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

kselftest/next kselftest-rtc: 4 runs, 1 regressions (v5.17-rc5-17-g2aaa36e9=
5ea5)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
7-rc5-17-g2aaa36e95ea5/plan/kselftest-rtc/

  Test:     kselftest-rtc
  Tree:     kselftest
  Branch:   next
  Describe: v5.17-rc5-17-g2aaa36e95ea5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2aaa36e95ea586ad23edfcc1d474e8b735a4d1c3 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6219d8f3528d314f79c62974

  Results:     7 PASS, 3 FAIL, 7 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.17-rc5-17-g2=
aaa36e95ea5/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-rtc-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.17-rc5-17-g2=
aaa36e95ea5/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-rtc-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220218.1/arm64/initrd.cpio.gz =



  * kselftest-rtc.rtc_rtctest_rtc_alarm_alm_set: https://kernelci.org/test/=
case/id/6219d8f3528d314f79c6297a
        new failure (last pass: v5.17-rc5-16-g1900be289b59) =

 =20
