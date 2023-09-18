Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39C07A5650
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 01:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjIRXry (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 19:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjIRXrx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 19:47:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD78B6
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 16:47:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68fbd31d9ddso3949153b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 16:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695080866; x=1695685666; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FQHFM/kdATfoY/eSB31xDiefofazChzE7fTEjvkIsDY=;
        b=HFinyxziuhtWaT/Qd/VpLqorMoNou0C2b+jq14oG17oAhAI2n7WrLPmTePTdeVe7eK
         p+uNENV/lSQE6FGtfj2C4BWx++vVfjYLP0D7shcEIR/7gAJxHwEPHllRUSk3ssPp41S9
         24DIIju5PHPBzz/ncL+MqIox9EuJ9iRLeSHCi3yuGRTPfAyHHnVksaregZFAh8USXpWv
         TG0sWPEPpGdkzowZ62BvDKPUvmBOxXZqF310Bd4olZK4qD51cHUCTopKHQNP8dO8G385
         KK15XT3PzqQYBJq3k+7YRjkdMDjzAv4XCidHdIMCN2fSxFd5U5A4oeVuhfA2TNZBUaYi
         z7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695080866; x=1695685666;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQHFM/kdATfoY/eSB31xDiefofazChzE7fTEjvkIsDY=;
        b=onvs/+CRonqyYF9oOzJ9dHwM+cI6mLqKnRNcNJK6ZDNIRwoM6xjtO8xTm/hBnB3zDm
         fIb32ZeOUTW1yxbcTNcTWlUDLZkBFQst8RRhNbXZ5Vgpf5KaQQgTNrSmftnWHOaLGabm
         yGNn349fjTU/ollm83TCtvczKPyBT4a7igw+V5Y0NIghoicO/8aoZGuvDQLc0a40zMYS
         cQ/l/4Lh1GhWT2i+UalMZ2LmCend6xq/tPpvSID4q+kShqgXAJShs2uApm0C/8xRzG+D
         DTHk7yztrbSgoyU6B6DLSD2PB337gnrqbsKxxVwBr361lu8kz+9wESH+VjdxdUiSMSBO
         x0+g==
X-Gm-Message-State: AOJu0Yx7X9tM+a3R4wjouMqP44mLStrl7CRnc2tkvDnyss6KIGJ5fG3e
        2cQIDhBqyPjJXfcae5odJFU8Lw==
X-Google-Smtp-Source: AGHT+IFcQRARqs5tviYgjHiU+99m/SBFNN5H+VTtgOFKDaHs9jQtjFZ2nKJyqoXV2HgQeSQexMClFg==
X-Received: by 2002:a05:6a20:3952:b0:148:f16f:113f with SMTP id r18-20020a056a20395200b00148f16f113fmr3601226pzg.12.1695080866609;
        Mon, 18 Sep 2023 16:47:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r11-20020a62e40b000000b006879493aca0sm7562781pfh.26.2023.09.18.16.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 16:47:46 -0700 (PDT)
Message-ID: <6508e1a2.620a0220.a63d0.b64d@mx.google.com>
Date:   Mon, 18 Sep 2023 16:47:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.6-rc2
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 1 runs, 1 regressions (v6.6-rc2)
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

kselftest/next kselftest-seccomp: 1 runs, 1 regressions (v6.6-rc2)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ce9ecca0238b140b88f43859b211c9fdfd8e5b70 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6508d49fae03a69f168a0a57

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccomp=
-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccomp=
-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6508d49fae03=
a69f168a0a58
        failing since 336 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
