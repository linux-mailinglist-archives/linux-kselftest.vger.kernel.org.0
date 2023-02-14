Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FD5695763
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 04:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBNDYG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 22:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjBNDYF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 22:24:05 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AE318A92
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 19:24:03 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o13so13869157pjg.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 19:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YgaNTyEkEGGL84gQiwdVlFfOsWiLu9AKF2EkGCdw0g8=;
        b=SkGgyxoQy6LjD70F6XKgyCBipOhlnJSapwLxWhl8+MogKcQyqIl6nppFYy1AJd+ANw
         cK7hQWHJ190uaOfcFDjVBx/pQti49E7l4nBQSPNDXn10xWko+hARDfJPBB3B4dI8zm/9
         VX+TVq9s3xPdPYcOgUi3KucTJeaTyghIXRrbbnRUnhmdaOEu44Ywp96LPyeTSnUoKW1v
         qWgTetCZBs179enEDREenUWolDKaO4M2QSS8pwu6ywvNL2ous4HCojAQip2YZO3dK7YX
         quopiuOemG10jm3kqHURZaMb8mNSxOGcSQ5rVOHyH/lpTQACkCH1NtniohmlyLj3J/Jp
         YkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgaNTyEkEGGL84gQiwdVlFfOsWiLu9AKF2EkGCdw0g8=;
        b=e5BH5raXRWcnO8KpnDDJG5qD1lOzmpCv+Dwq8M3j/tGbWgMYG5LO5ZNweTJplIhQkB
         VDKPzKzeoeKpDXd8KngUT06gmwiedA4mwCDaIwyh9nKtllI+fo6SYKN8Yh6pbZo5BzHz
         0VsJqHhfHKv+l5+WrTS+7HgYRa4eesqq7rnIX8ElkPu04gHuDr0PPPHbQdG4F45XMjT3
         aYO9xEULttlUOqzgaou3H742XXR56Ga3D0f1GHomQRaa7z+lJGCpgcACnbunMzoMH/ps
         3lUDXjDk/rghCtdo1VlIyhSkfbeeXYNTDUnIOxomvKBC/agxWYkSb/lP58UzYZQeZDqO
         0q/Q==
X-Gm-Message-State: AO0yUKV7LtDOEi7qJXTPeityEqWtmd/uJsUQNBRRdzQVEKHA15RHLwWg
        PS2PeHqlZRDRX3vCe8y79u0t7Q==
X-Google-Smtp-Source: AK7set9ipwDziDXLAhVh/ZjgSu3jOzYqxk3IjxLfeGhPisekOsXT7rF6AXf6H3+NycMBNeElZTwynA==
X-Received: by 2002:a17:902:c405:b0:19a:8334:edc5 with SMTP id k5-20020a170902c40500b0019a8334edc5mr1467946plk.37.1676345042794;
        Mon, 13 Feb 2023 19:24:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001963a178dfcsm7614934pln.244.2023.02.13.19.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 19:24:02 -0800 (PST)
Message-ID: <63eafed2.170a0220.37ee6.eeb2@mx.google.com>
Date:   Mon, 13 Feb 2023 19:24:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-39-gaca5a0944c30
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 2 runs,
 2 regressions (v6.2-rc5-39-gaca5a0944c30)
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

kselftest/next kselftest-livepatch: 2 runs, 2 regressions (v6.2-rc5-39-gaca=
5a0944c30)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-39-gaca5a0944c30/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-39-gaca5a0944c30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      aca5a0944c309c56267b0c1d001aa999ddb2fb1e =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63eaeb8978995288fe8c8667

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63eaeb8978=
995288fe8c8668
        failing since 49 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63eaf0408b19c99daf8c8725

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63eaf0408b=
19c99daf8c8726
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
