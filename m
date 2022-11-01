Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7D614871
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 12:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiKALXc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 07:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKALX1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 07:23:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC7DDC
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 04:23:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so1060453pjh.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Nov 2022 04:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4sKcCY49QKf+lH1GRvSBh0ilolH5hkFJIPVpcNyhwMQ=;
        b=HavvXymJ6QFGKm6xTXhsJ3fNRP6rU9nQAsAPrbONVi4MKUwI9zbaAxXwW4rXI91/Tq
         SPvbhykLy17RB/oFg27EfFgvOdqrRrc/FMrWiQ7oxNWJHKM+76TwCmYVK51E+6tByWWY
         8as4eNcwrq//0AcONFyuyWK5lwK7L3jJ25BiQh8ZXGEINfZCphX8bcf8p4EVfp95e6dx
         dzYSC/RvTXLfcRdMZK/xMmtcjDC/mUpoFN1W5cOFwy7s7F3HIhHFTn4YEzQbq2H4OIhr
         v1T9N9pbYuM+AR4umYsIVdGxqH0xVTUTt+V9UA7CwbPlyx53rWYVjf/xb2NRQJ4htLCg
         2sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sKcCY49QKf+lH1GRvSBh0ilolH5hkFJIPVpcNyhwMQ=;
        b=LjG2d94hzXj3/M+Ia+q3Dzp4rw2ijMNdwgS7X4EJX0EE8kLp4MTn/GgAN3XYL0+lDL
         kBi/fV/QocpReLkA5mEwJGsZ1Z0f+Pa4eHep0u0TAqBzoBak+Xfvi23hbaHP734FFfsJ
         QJIbHeqsw57pcpbbpcbBRGw94OR2V2LUEB2mDVv8U9ZOrXIwPULvr3L66N4/dxcaScSM
         LT0HrRSp54o98WGPHHKaIZyn/wm3XCZ9ye5es0Ic0VrAxUE/wxYiAD/KctYVPthxpeGI
         ZCPZNMxrQ0siTJlfmFJ9ObHVQ9RNiyVScf9I6IzmxtE14dnNYQVoHFPJnI8vEcUF6awl
         CTrw==
X-Gm-Message-State: ACrzQf3KPTNb6JAeRzqLt9OJC9ZaKVGYm7WN+sGN9bjTi2EHsOKob4q8
        xdOWhDq0jiGS3byeSOkNke7I0Q==
X-Google-Smtp-Source: AMsMyM7G2o6T0yqAu8n1FPI5A2lmqp4cg+yPKIJQh+QGlg9VUnrHTOeiLUaA0CNfvyiejGj0PnvIZg==
X-Received: by 2002:a17:903:1c9:b0:186:91ce:1658 with SMTP id e9-20020a17090301c900b0018691ce1658mr18998064plh.122.1667301804519;
        Tue, 01 Nov 2022 04:23:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902778600b001867fb4056asm6097686pll.32.2022.11.01.04.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:23:24 -0700 (PDT)
Message-ID: <636101ac.170a0220.54518.a838@mx.google.com>
Date:   Tue, 01 Nov 2022 04:23:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-13-g67c0b2b52916
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 2 runs,
 1 regressions (v6.1-rc1-13-g67c0b2b52916)
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

kselftest/next kselftest-livepatch: 2 runs, 1 regressions (v6.1-rc1-13-g67c=
0b2b52916)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-13-g67c0b2b52916/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-13-g67c0b2b52916
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      67c0b2b5291656cbcb15371f835f5152fae2f7a2 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6360f4f798cb02bbade7dbd3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6360f4f798=
cb02bbade7dbd4
        failing since 14 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
