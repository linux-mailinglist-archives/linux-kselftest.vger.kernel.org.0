Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D1E617C53
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 13:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiKCMR3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 08:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiKCMR1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 08:17:27 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA0963E8
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 05:17:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y13so1414635pfp.7
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Nov 2022 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SRJu51dZwmMSgPRyX+MTYhapFqGSWDLnVQjNXe4SWdI=;
        b=LWSVf6b5mGjhrmiuedyTtliRebTAjgdBn6d1AKTSoHxYNKVAZmTpiu4CBzBt74fw02
         MlGLqzRXlrqriI35F1/kGvUqKtYM5UHjNgHT9gpM1aBGpuky1mC4WgJIhkbdPxPz/Szo
         K1srMBqXeix24KaqI6UdwgPG4la5CxiPz5DQpvlTJNIc8RuRFOsgJsgqC8GGitA52D0u
         YkQNRNYLdOZ8FA+eZuLOZ2SHV/Z/HlGPbEj26CYQc6ottv0HKts6znx9hVGZDE28Iu0J
         rqfqZELYSt5PnmgDrLGjMRzXh0AEIPMx82N8nujRLwqEHACobp7qBChnoPREMSzw4UDk
         l9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRJu51dZwmMSgPRyX+MTYhapFqGSWDLnVQjNXe4SWdI=;
        b=up6SOpfsqs/sjhzS3HJZM/zquvd1DU2LMnlvi0uDKXEdOi6LtF1mam1RPiYZW8Sett
         IB0H7eZve+eL8jNYTlGku+P1gV9H55vhiQn5l7Wus9r9TydadU+ib3s3qkecodeANY6G
         D3g2MP9LO5Pr3oMhMBLEIJ1q4QkD1RHEa/vzBvA1U0PbiiS2lWMVtlr1ARvt8NcI6cMp
         S/f5ZWziuU9hbRqI0DbyXozqeZQIDQPpHjgrp66jsPbphIq12p80o5T0PBZK2kM5re9M
         k1CGpO+wbtHoPQ7/iZEa9JQ4BlNbkwyqreOy8fEkSrWh6kDwGledroPOyJK7sMULk4Z+
         ldZA==
X-Gm-Message-State: ACrzQf1aE4u/2/4Yc3HVEHRHaBUsIqeFbcsigQq9EKL0j7C6esymC6+V
        hDHUNoCLNjtUGBx+LRYK+YgX1dN/XR9CwST7
X-Google-Smtp-Source: AMsMyM7R/IwdxcobonBYarzGwJ/yFXvgRpOm9ABtw+rdhSb/Vu+3gW71eGkRDtuH3C2+n3Ft3/qV7w==
X-Received: by 2002:a65:5942:0:b0:46f:f741:8adc with SMTP id g2-20020a655942000000b0046ff7418adcmr10148704pgu.265.1667477845586;
        Thu, 03 Nov 2022 05:17:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c90-20020a17090a496300b00203ab277966sm3237547pjh.7.2022.11.03.05.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:17:25 -0700 (PDT)
Message-ID: <6363b155.170a0220.1591d.6049@mx.google.com>
Date:   Thu, 03 Nov 2022 05:17:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-14-gd942f231afc0
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 2 runs,
 1 regressions (v6.1-rc1-14-gd942f231afc0)
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

kselftest/next kselftest-lib: 2 runs, 1 regressions (v6.1-rc1-14-gd942f231a=
fc0)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-14-gd942f231afc0/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-14-gd942f231afc0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d942f231afc037490538cea67bb0c667e6d12214 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6363a17a18be19251ce7df5e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6363a17a18be1925=
1ce7df5f
        failing since 16 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
