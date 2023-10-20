Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174997D13C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 18:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjJTQLp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjJTQLo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 12:11:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8969B114
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 09:11:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-694ed847889so954390b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697818302; x=1698423102; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R20pJR6nWDIZBiyIpdcKQRbrvuNnY/U82AvLufH9wCM=;
        b=ewRZwdeVGMF4hUu6k5b8tH53emWg1N/2dOaYaQD2TWw6zUR1tWem65My1muvme+O6f
         hoQf54AKgniKCbep4RZDcv+Olph72xo8125+IwSXCLBSqaompJooTzYpJKLvyFfUWtR8
         mSI8dzxzZIRpzHHk8y5HgalxQCEcYSHsk1Cm4h2jeycWpHcXuRep23lAmON/Be2SEyl7
         QO0tmhSxR1rCaB5H1xM+I+3wadEqaU3Q7uoxd8WYBn2owBKe7z0k+iuVEc8N3/u0aUdB
         8ct4AagjT5iR+1nUL94EteKsfrxfDxu3lAZRT4fPR+rLpngiZp7k3wK862ktF9AAQ7Kh
         VRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697818302; x=1698423102;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R20pJR6nWDIZBiyIpdcKQRbrvuNnY/U82AvLufH9wCM=;
        b=buEgZzcOPKuIKA96bxS2/nqiW6jaevNHO6Y3Jf6x+XpFM1D2JGVRb6wd5V2sNU/ooL
         y3ftiVg7XV/0CuuPPHWN4cc4bKRccnWGZ41VHhjTmkgflXX+epUZRMTrNr/dzgCsJT5l
         /nP3Wm1bn8uut5a8ely92whqxFOYiW/LznkuFu8aUcjxTFwyTsyWKZUrxqS9SrdkIpch
         FU+FwlYq6oB6nxYHskh+l1YPXTm4l4gNRx29Xd3OGPHeMVySS5RypGV2owS+RXzmxWmd
         rOFuqONfa7FiDrL3ZEKC5K9GleDp/7FXZo4U7KlTw2yIb4qI3prQ3UXJDsGdV0SJK+ry
         GWUQ==
X-Gm-Message-State: AOJu0YxdibtLmq/cSsIwbNEMjeszWiXX1Uya4R2iJACqTVSPwwFthkk+
        BD4D5FqQ7YE0buwOkV3Kis2ETA==
X-Google-Smtp-Source: AGHT+IHXDtLj+zG/X7RLQqDBLUllbwlnMFjMxQLFptus/ba+DnzoUTVWa7u6fmnTofjczDQGm6df6w==
X-Received: by 2002:a05:6a21:7746:b0:15d:42d5:6cb5 with SMTP id bc6-20020a056a21774600b0015d42d56cb5mr2234193pzc.28.1697818302026;
        Fri, 20 Oct 2023 09:11:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00008400b006be22fde07dsm1712302pfj.106.2023.10.20.09.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 09:11:38 -0700 (PDT)
Message-ID: <6532a6ba.050a0220.6eaea.6167@mx.google.com>
Date:   Fri, 20 Oct 2023 09:11:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-51-g5247e6dbed00
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 2 regressions (v6.6-rc2-51-g5247e6dbed00)
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

kselftest/next kselftest-lkdtm: 3 runs, 2 regressions (v6.6-rc2-51-g5247e6d=
bed00)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-51-g5247e6dbed00/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-51-g5247e6dbed00
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5247e6dbed0041147a83137f89cd45043301de5c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532997c7ca6fe2120efcf09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6532997c7ca6fe=
2120efcf0a
        failing since 367 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/653299b617bc944cf5efcf16

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/653299b617bc94=
4cf5efcf17
        failing since 367 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
