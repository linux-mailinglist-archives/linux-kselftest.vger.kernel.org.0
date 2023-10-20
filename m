Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3417D13BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 18:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjJTQLm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 12:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTQLk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 12:11:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52931D7
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 09:11:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ca6809fb8aso7553415ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697818299; x=1698423099; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=90G7dCVLlvdr3m/DCg0YHNq+xXYytcx7WKjM5EX2xug=;
        b=n/yU6ztT5qLwYSUrqKqdOmyu4zLzQfqbOq1fTRySw6Ho0FtNsHS7E4I5Z2KonZeKtP
         IJCOV0LD9t3BAoYQIGueozqavH1NVLcdUiBZ4oKJfhepKBZHmBXB9gKdvcuJhX3zig8I
         02j/5x9tH9B0ymB6jrxVGNStYBormn62R6307858xnAaBGM4pfR893AD+QagtXPeplXY
         9sv6Un+v/frmxFkDfjIisMwo8oY57J3uq+p59CJfOJ9Q5e9ndIDJNoWqD510/PmoipSK
         +hAtqsgSDTu6dy/AqMGY6MJanvrtOGL1cmthUmb7kyXs6f6saStRE8pwV7xijpVn32nX
         D+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697818299; x=1698423099;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90G7dCVLlvdr3m/DCg0YHNq+xXYytcx7WKjM5EX2xug=;
        b=Q2E7pszMBhX5gbLVSkOXDVqkhqbF6ParpwpN1TDZmbgI9mVaBnyWVMKzSnJsRShFR1
         BhnwevDP5JUX08tFj68EIb1G2yml04sbrAoiqWisSH+vOZDrPP/A0yOXMm2udc2sX+1k
         YIgRb1ycZYu2Mjnjm7lyxJTb2LzuLQ/cMA/x1E0upokUncwVOYsInsTI/hEC4kDSWLdR
         yhnBDcLBO3t+7oDOrCjz3N2xu8lHsuEWR9+tRAfrbs86nA/st4Iwskx306nTSLFIyO06
         +bMOSd2lv1qnF6m2fnI2cOiyYqZAE4MANN2qYcuN7Y78hArOPeRc62MooWJtZMcr9dWF
         Woxw==
X-Gm-Message-State: AOJu0Yyt6vTCwgr9javE7on7rGgLQwM3NLLw5yu1lqkbv6b6Er3KBb97
        caae0HqFKGa7eJIk+7J3KJuL0g==
X-Google-Smtp-Source: AGHT+IGDmDd6Zn6clTBPMlL0NlH1qgu5DB0YZM4Pa+UIgspGO6qbdFsfVw9Lso08vRRHvJj9SU8tNg==
X-Received: by 2002:a17:902:d4c8:b0:1ca:de3:fcad with SMTP id o8-20020a170902d4c800b001ca0de3fcadmr2203922plg.59.1697818298569;
        Fri, 20 Oct 2023 09:11:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b001c724732058sm1688307plb.235.2023.10.20.09.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 09:11:37 -0700 (PDT)
Message-ID: <6532a6b9.170a0220.a4db1.5d7d@mx.google.com>
Date:   Fri, 20 Oct 2023 09:11:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-51-g5247e6dbed00
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.6-rc2-51-g5247e6dbed00)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.6-rc2-51-g524=
7e6dbed00)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-51-g5247e6dbed00/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-51-g5247e6dbed00
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5247e6dbed0041147a83137f89cd45043301de5c =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65329986640d8c7964efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6532998664=
0d8c7964efcef4
        failing since 367 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
