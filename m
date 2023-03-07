Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE566AF2E3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 19:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjCGS5X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 13:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjCGS5E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 13:57:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21368B4F6B
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 10:44:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so17443945pjg.4
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 10:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678214667;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lXGBGXzhKr0XuEkE9bz/q4TrNrkvmHhhVt6ebPNJcIw=;
        b=rLieD5yAgm7VTapQLKWdQW2X/nnAmVNs3BznrJ9EeWhC2toIkSlyUcag6fMDscJnbV
         eVUi13KwhaoJgWfciN7NqnCYeS237kBctYZH+YgM4/+fmW9oy+ibLXNnJ4tFoMZDzCMA
         9sc5fcvqLXLec/t5rBH5kMVibBOnJqE9ggO6MVI6hrTVy2Gg6hlIC5ZhFv3hbKg2wyX5
         DZd24r06vMnej0QuKw+nJdhU6i4TFrUfw4v4ssDnTRT7UnRjcqQ+Csm6uGVPZcSRQUJB
         Bb4lD+yVG8oQP9/I2ToWrTUvxPJcQqJbjaein4JwPYqa+tFHRpF0t2iPXVdZlCr4Acy9
         DF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214667;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXGBGXzhKr0XuEkE9bz/q4TrNrkvmHhhVt6ebPNJcIw=;
        b=0DTgbxbIPZfW48175fMVlpbhzrqplWt9YcjDnHDKfRWtQzVWsdJP4VZ5f/RpzRUSee
         VQ0AhuINq2ESlag0LVss2weRw6XkAaSMKqomErAzPBknzm4NhvWngIQNOL/18xeC0vCE
         o3lch6wFwoCsetOrBmrQZGvmDFmVABPbf3vtFOV6RA/8XETXs6a53QAnPPyWO2Tcl9p/
         W9rR0M0D7LxTYsMVqI0MJDoPW5BowAwUTlUrLKpw01U5vIDbVcQ0HnEwQ53zIM/Db2eU
         cmJUhAzruHBhaDzRcch8NTHR9FgYkkiIruYxLqwfdB1TJpct8ygZuNDdbwSaIBbyUIfV
         8REA==
X-Gm-Message-State: AO0yUKX81u78ThXzOXfrFHXx6Z/oWNRDTS6F2kTN2LAwUcuPeP8fnuWC
        w8/3NDbPvt/N3cCQZmPqS0kyegP9nWxzZCSkRvA3Fw==
X-Google-Smtp-Source: AK7set/jOkbVUzTqzlXDsUwYSQLiMmbBqqcmmE2uHvUN/0nj/UzEj3uKrmEeLGRmn/iagEhW47gHWg==
X-Received: by 2002:a17:90a:1a17:b0:237:75a1:ef39 with SMTP id 23-20020a17090a1a1700b0023775a1ef39mr16451720pjk.27.1678214667052;
        Tue, 07 Mar 2023 10:44:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id fv24-20020a17090b0e9800b002340f58e19bsm7671257pjb.45.2023.03.07.10.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:44:26 -0800 (PST)
Message-ID: <6407860a.170a0220.ccc27.dc4c@mx.google.com>
Date:   Tue, 07 Mar 2023 10:44:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-1-g2da789cda462
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-livepatch: 3 runs,
 2 regressions (v6.3-rc1-1-g2da789cda462)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-livepatch: 3 runs, 2 regressions (v6.3-rc1-1-g2da=
789cda462)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
3-rc1-1-g2da789cda462/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.3-rc1-1-g2da789cda462
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2da789cda462bda93679f53ee38f9aa2309d47e8 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/640774637b9e4564338c863b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/640774637b=
9e4564338c863c
        failing since 70 days (last pass: linux-kselftest-fixes-6.1-rc3-3-g=
89c1017aac67, first fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64077cd67119378d438c8641

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/64077cd671=
19378d438c8642
        failing since 139 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
