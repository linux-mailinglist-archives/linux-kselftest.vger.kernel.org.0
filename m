Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC5159CDFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 03:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiHWBmT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 21:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiHWBmS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 21:42:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360F65A814
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 18:42:18 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q9so1935102pgq.6
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 18:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=Di11AWl5Q5q0RsNhfwBYj99irBlgbwwQvPxXLiQyxfo=;
        b=xgSLKRrGbB/FMdnXR6J8RAwzZWY6IRJme4t+KQMK93IGVzsMy5ogAuFu1DfYntvasV
         35vl6yiLtTDNXnjBURslKeMcFS2CtQEMy+hK/fSjt1mOEr7OsbqWv7T1R+raPGZjQ6l8
         Ntyv5RRUrlSwcEmfxEQH8tXBdKqUuV5Wl+KfxZnyA9eIpZ1oQejb+VwBC0kl02XCdNRY
         Iq6llLxYsKAK6mVeHIMapiFwDMttmKQw3AN03p3U2M5X7b1uZMspZ9YFViMXUPryMyeF
         2vtn6yhuLh5lpba6XgoZJy4c4lHVAEGKAO+LVKM7l0Jf2BpXr17/yOCmUMFX62Zxq82R
         1vYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Di11AWl5Q5q0RsNhfwBYj99irBlgbwwQvPxXLiQyxfo=;
        b=AZ10b4MChh6KmPztoErjL1pS78BVGOZIkerTRF2pOVqTUY25RLPWn1BZBK9foNQaQJ
         xSPCrqxI6+WAXVzY3zEkk0n6/i2OvGHJ8hTQC7M6fiPjmCIHIAd4XN8D/Cy86et8Npv7
         f7hUjooJ+052JnR4LBfcew8Lmi7WfldRHIgQoG5Xk09rIoPiGU3xftnjeMPANs2/pn9H
         wV9shVdNeOFnjUq7rPDk7MnBHWCXBnhwv1BK1TOyePKGzqkBUG7q9gElJdJEIkT3uTxY
         GyRVVqQ5e6P8b+ZILjDhoKzQzjbFidQMpBjd0w0h4AgvaGWUEy7LxOIvDcBv9VN/smky
         3EFg==
X-Gm-Message-State: ACgBeo3gQ3DyY44V8ZHgWQXeXHbAzaiJFV9QvzCDPDGiEZDp4AoCantj
        64H08xHRy5+qaAqNuuRjHmGAY5lFe/U+pLT0
X-Google-Smtp-Source: AA6agR7dBviIPXTVA6M2Ctz5/ZDrlSG7wdmNINcn/Msg0euA8G4xMR+UP+p4X6IgK8I1wkKJjCt2GQ==
X-Received: by 2002:a63:4e56:0:b0:428:ee87:3791 with SMTP id o22-20020a634e56000000b00428ee873791mr18652063pgl.11.1661218937617;
        Mon, 22 Aug 2022 18:42:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d15-20020aa797af000000b0053605d5e1adsm7413032pfq.206.2022.08.22.18.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 18:42:16 -0700 (PDT)
Message-ID: <63043078.a70a0220.44991.d925@mx.google.com>
Date:   Mon, 22 Aug 2022 18:42:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-next-6.0-rc2-1-gab7039dbcc61
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 1 regressions (linux-kselftest-next-6.0-rc2-1-gab7039dbcc61)
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

kselftest/next kselftest-lkdtm: 3 runs, 1 regressions (linux-kselftest-next=
-6.0-rc2-1-gab7039dbcc61)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/linu=
x-kselftest-next-6.0-rc2-1-gab7039dbcc61/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: linux-kselftest-next-6.0-rc2-1-gab7039dbcc61
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ab7039dbcc61229aa635357b847a643973497561 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63041d999ebcc423ea35565c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/linux-kselftest=
-next-6.0-rc2-1-gab7039dbcc61/arm/multi_v7_defconfig+kselftest/gcc-10/lab-c=
ollabora/kselftest-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/linux-kselftest=
-next-6.0-rc2-1-gab7039dbcc61/arm/multi_v7_defconfig+kselftest/gcc-10/lab-c=
ollabora/kselftest-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63041d999ebcc4=
23ea35565d
        new failure (last pass: v6.0-rc1-1-gf1227dc7d0411) =

 =20
