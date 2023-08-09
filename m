Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72063775154
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 05:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjHIDWV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 23:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHIDWU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 23:22:20 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238751BF2
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 20:22:20 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-56433b1b12dso3775417a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Aug 2023 20:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691551339; x=1692156139;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SxtoiWbH92FG4H6ej5f+vWyf9JNwrKKc1b3ptzf4JYE=;
        b=057SEzPucxW0pwjfc1nDzL74FOEVrJ9wyMYIAz2PS3NiUuA2hNC7avc2KY50sRVlQr
         qFqUnoAAZbzrWZdzDvVIdan7c6d49fHpBO+cAyJK07aO+qcsQWTHB6fOV3eD8sffdaRl
         re4gvaQg7C3V1lArJhuk3Bzp66zRyJXDsuZymMd9f+O+Wj8A39cyIiyo3jMck+xyq55V
         xI+ZQRGKVVLwgWs0uywQfLP0SvKTsODPGuXyUnP7AC5sjLJbgVob1Aprtdi2/SnnM/K3
         sZcOGIqnBcJNJ6VCA+DcevBiPWwoWE3bGCKYMFOPkhKwNtxtSmeWPmcw1Z5jkez6OJ9L
         YrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691551339; x=1692156139;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxtoiWbH92FG4H6ej5f+vWyf9JNwrKKc1b3ptzf4JYE=;
        b=bOtCw+TW8rFy6M84uNmx2Gj2gJ1qU+swie5L4TSFPDOdDOQDPN8ZXXqLz/mYFN/zJB
         OypMBRiOzBl4B7RnnRNywHM3EJmf27L865rUxUcXOMq8TXiLdyVBY/KsiFu+HBTLvx7K
         dtFNdhYh6pUS5IpeSB71SjHJUGv82oRfGmJeAty03o/FtD4WbZfA9vM8lcTFLLaA1EJ6
         36j9aao4HHf8ZV0Bqt+MB+//Spt+7iAKliz+P+4FylpeSNVEQhv/KJyQ9+tK4fxqrLXi
         ZyFUG2a/chTm36MsGl2PEfurC0TpPNF8ZxZfopyeb4sTZotImiWsychNQ27Vnnz+okJO
         0tKA==
X-Gm-Message-State: AOJu0Yzqg25sHejsDlBJBM7jmFarwBm8/BVHtlVwh/dAS+mULbC0MAlG
        sIm+gs0m7IalkdkeNDMLcjMCDw==
X-Google-Smtp-Source: AGHT+IERemwJMoDmvMA2NavBrGs9KYRF9h6R2PeoODx1SE3MV619aijmqNBx3cZk39KseyUttb7QNA==
X-Received: by 2002:a17:90b:888:b0:268:352c:9d13 with SMTP id bj8-20020a17090b088800b00268352c9d13mr1172826pjb.0.1691551339620;
        Tue, 08 Aug 2023 20:22:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090adc0900b002640b7073cfsm297304pjv.14.2023.08.08.20.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 20:22:18 -0700 (PDT)
Message-ID: <64d3066a.170a0220.a52c1.0aa1@mx.google.com>
Date:   Tue, 08 Aug 2023 20:22:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.5-rc3-26-g2b2fe6052dd01
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next kselftest-seccomp: 2 runs,
 1 regressions (v6.5-rc3-26-g2b2fe6052dd01)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-seccomp: 2 runs, 1 regressions (v6.5-rc3-26-g2b2fe=
6052dd01)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.5=
-rc3-26-g2b2fe6052dd01/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.5-rc3-26-g2b2fe6052dd01
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2b2fe6052dd01fdb4e9a31031c2c9d8f03cf7753 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2fa2ce56d88a33435b1f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.5-rc3-26-g2b=
2fe6052dd01/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.5-rc3-26-g2b=
2fe6052dd01/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64d2fa2ce56d=
88a33435b1f7
        failing since 295 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
