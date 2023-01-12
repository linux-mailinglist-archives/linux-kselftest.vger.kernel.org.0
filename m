Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7357668803
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jan 2023 00:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjALX5Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 18:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjALX5W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 18:57:22 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A85253720
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 15:57:22 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v23so20745594pju.3
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 15:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lO83B4RowE7H34KDmQRL3hFeZvT5UzWIOAwLJyndMSg=;
        b=YAvr3eT41LtT0VRpji9kmgJA4gJoUhS2K3Qpbr5gFGvyyLFTnV/PqCfG3Va3xd44UO
         ab36cNeH7gaZyoFmNAdjqZcUckQaZ0vO9pPQy1ANzsR0Qtsscy4m2WEPWBwB9IV1A5wF
         jIiysiohZTWG4a1GsuHmvQlRMe4b0AwB8odGj/6+4/9+iDo/XeUK+P3iBRgRsSFcDUS/
         wnJqL63/VNRlza8g/kxQy53K8wVqVBBXXTj6Rslzd/UOX+oQRJ/toXNCc0Cw5z8yq09H
         avFltoeJz34OepsB2IPb1+qjt6M2jN0tjC47is5I2PwEExWxVmQ+YVz6juwkcg/1/dP7
         5bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lO83B4RowE7H34KDmQRL3hFeZvT5UzWIOAwLJyndMSg=;
        b=3N6iaUoHfSnX/6XtUIwZ/FBbX35rqAqcyyt2TkJ09Axuhx2+0uv2yPSM5F+dSzI+f7
         9TtUpwdyEnFhhVi4cyqqtAW4hJt9mKqTsxmH/32zKLv3TpKiEKmAenpvngsaA+bV0x7i
         6e3KWXiw/shTf/nIVBswed1buUNFCtWxdJNBZI1y0PA1Kl5KcAqkJDeASRtvOXIEEXOO
         PL6V2dGa2zSGiprFx2p4XQO1L2RUEa5+lWkZaEeT0V16WmIt2G+J7fF4naqmAS3qvg7G
         J5B9mwb1W9qiMElswv3EpzZU7+kXidgg6oUfYitX/bg1sZiZJErqma74PgUFjWZTUht4
         IXyg==
X-Gm-Message-State: AFqh2kr50pBet9KtddH8NAJLay21ss7p80hUhpEhxVIzD63yqJh3a90F
        0AO6+O5hcEhXt8YMEwnlpYnhvg==
X-Google-Smtp-Source: AMrXdXs/J9EZ38VpAhld8vAxyi18/sZ8K/2MFS4gLS/m1qkglQQJv46tYK6UMG5utUG+0IPayCesFw==
X-Received: by 2002:a17:902:854a:b0:191:4539:d2c1 with SMTP id d10-20020a170902854a00b001914539d2c1mr7270792plo.47.1673567841589;
        Thu, 12 Jan 2023 15:57:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b0018099c9618esm12794039plg.231.2023.01.12.15.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:57:21 -0800 (PST)
Message-ID: <63c09e61.170a0220.501cb.5246@mx.google.com>
Date:   Thu, 12 Jan 2023 15:57:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1-1-g9fdaca2c1e15
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lib: 3 runs,
 3 regressions (v6.2-rc1-1-g9fdaca2c1e15)
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

kselftest/fixes kselftest-lib: 3 runs, 3 regressions (v6.2-rc1-1-g9fdaca2c1=
e15)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
2-rc1-1-g9fdaca2c1e15/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.2-rc1-1-g9fdaca2c1e15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      9fdaca2c1e157dc0a3c0faecf3a6a68e7d8d0c7b =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c08c3f2a81d02bce1d3ac8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63c08c3f2a81d02b=
ce1d3ac9
        failing since 86 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | clang-15 | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c09188bdc043f3ba1d39e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63c09188bdc043f3=
ba1d39e9
        failing since 85 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c09318328a4cd7561d39c8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1-1-g9f=
daca2c1e15/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63c09318328a4cd7=
561d39c9
        failing since 85 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
