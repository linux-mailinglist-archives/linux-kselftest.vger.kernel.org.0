Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A71A7AFA08
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 07:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjI0FXs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 01:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjI0FW7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 01:22:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FB01704
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:17:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c47309a8ccso83488755ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695784623; x=1696389423; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w9k+t49ZPYXHfpAXM48YKTl4RhDf37So98/9DiMdh74=;
        b=Lv8tVBdNWsFmH9ZikX41jdAXyNrPC2cJgQ/sbUeJIYlRrdL9oojh4aSwIdmrJ/Zmow
         ctvpt0iNiJ7Mk4jXsBf4tl73eOfYdx25eif+CthoTZ1OTcmStiIpb7XkYED3ZyZYZGWm
         3z+AMkoZbOJ1kLt7i82j02Ujo2/flro93MIrVKpvZFxUHND/YN7FbquHAOXsOoZWJX5B
         OaOwijkpjHKqKM8lLCmXaFqGElkbEZxm8Gqqb4LFocX4p2Uokz8bTxij2m4BsNC0qvRk
         P/AH2wZcYx00VP/8X0PGah9gZDY0P1hkAEnV610QBIk/i0dnL162DXngPETzVlBSepmX
         qtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784623; x=1696389423;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9k+t49ZPYXHfpAXM48YKTl4RhDf37So98/9DiMdh74=;
        b=Tn4P3YTDFZZd2i9r2ucflnP2kjkUw7Kg2LluudhHct0C8b271okCyleczNYoBCy9ug
         rDMJjIBg9oHqfrYkvmU1L7V3ic7FHyH9v31vsdUqQeRaweXZavRO43HnJ8LMZOw7k4X1
         rCw/zf1mIKkLZTdK8emMJj44hB4/AR6jBJVWbSoU8prfMEWMU9bOuJ2Vhv+5dBfF+hGV
         hNF98IVKb4XmwiP4P+kKVO0Jc/VDOkjiQLuCNnIOYfF4uIncTyglXVyKoC2xd0vn6n60
         IjTsg9V3HeymNPntJiK77CPu5hrT3LU0dAaOK4mVejCkSAOl7aqtnQUSpFPJfL3Mews3
         9+vQ==
X-Gm-Message-State: AOJu0YzcpLqv253LJCJXfXmM0y1iB/694g4z/0vw6p2zipkoDiPtMbpl
        gikGpdNLDQbWYGdVzgcfZW72BA==
X-Google-Smtp-Source: AGHT+IErI2UrbVCzOz5W1mC96v0EJzA3pQR/0EAxVLeMbMQKU9BetzMFsTvsXb80JUaiVLU6jCYSDg==
X-Received: by 2002:a17:902:e88b:b0:1c0:bcbc:d66 with SMTP id w11-20020a170902e88b00b001c0bcbc0d66mr1674195plg.7.1695784622983;
        Tue, 26 Sep 2023 20:17:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709029a0a00b001b53953f306sm11791560plp.178.2023.09.26.20.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:17:00 -0700 (PDT)
Message-ID: <65139eac.170a0220.d7fa8.318f@mx.google.com>
Date:   Tue, 26 Sep 2023 20:17:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.6-rc2-2-g078a2ead544c
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 2 regressions (v6.6-rc2-2-g078a2ead544c)
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

kselftest/next kselftest-lkdtm: 3 runs, 2 regressions (v6.6-rc2-2-g078a2ead=
544c)

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
-rc2-2-g078a2ead544c/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-2-g078a2ead544c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      078a2ead544c56fbe6a3bed8cc90b5151a328b81 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6513915f03509d96518a0ac3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6513915f03509d=
96518a0ac4
        failing since 344 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651391491116b4bcc38a0a56

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/651391491116b4=
bcc38a0a57
        failing since 344 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
