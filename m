Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27887AFA46
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 07:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjI0Fqt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 01:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjI0FqV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 01:46:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB685FDC
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:17:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso9126667b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695784624; x=1696389424; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aH/WD5/fqMyadwc8Nk8Rcpjw/4tLpjsocczZepAczHc=;
        b=Rb5Z65564/pPjHQrtaIbglJBorprnIdP8919DyDVy5xe5dW9WCeeWETcWNOJ4DiT9f
         Lq0QjV6YHdZ7B5CjnsxQBueySM2kl9btrclg6ypklU5Npv+85QBcYF6mXEI4/xTPzWY2
         V2Sxey9aOHAec+juAPmcQ6rHuf35K2DEpu6F55A4XPKXZ11Q2CJr9EekJOkf6ytfOM+u
         82E8Ef3a8rAXCG41Ohgl/TuIyU3VU5m/HbuS48qfAyHYdCtigDv41AX4WVnJ0WPEfdKx
         MlKPttExqHY4JwFCbFkUG0K18nwb/HrWqgRCig55uIxN5YzgNltBXi87Tao7w9q+jSLr
         4RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784624; x=1696389424;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aH/WD5/fqMyadwc8Nk8Rcpjw/4tLpjsocczZepAczHc=;
        b=meoXjMkefqlB/+k6MscScrANUQRPXNyBl9LRpB4lTgN2+RUFTiaWHjgecjYN2HkG39
         IStHvOvatj6r4ZTOcboDefV0Wwe7g/JotFZp6iwYz6kaQeQV9zXj5t1k5ed3ZnmgDp4P
         poMxu3/7CGC5/+SCkDgjaBr+k6KDgPqWXQDKBfotaaI3P40MNet/66MpVE/SnQcP4dF0
         eDE2D7rm1hRGZ7wbvvubmGR0Y/9wD5jdfV3+UEJkg5lGofb2+oCgsNJ5Pma3Nm9pXAvR
         iUyNnCNUJ87QnJR3jJZYe0kv80D33KptjpYjlZxY8ylTYx7sKfB29G/PvEXyVX+QZxEp
         m9uw==
X-Gm-Message-State: AOJu0YwYMzDGrSlKpJ+3oNvbrUkn3/0VxBZ6/ZbO9dC0JhyjHjyGgag4
        sXKBzzv6fD3cqcoJd9O/z+5TwmLDWGoE7IPlDEpfuA==
X-Google-Smtp-Source: AGHT+IEE2XdZ/ojux5ikmwXkvXE5PzlGiKUTMneVORQQisKImzzTMBHelybu2kU0VLQK/A9mvowTdA==
X-Received: by 2002:a05:6a20:1590:b0:14e:315b:d9c with SMTP id h16-20020a056a20159000b0014e315b0d9cmr947641pzj.22.1695784624493;
        Tue, 26 Sep 2023 20:17:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id nn5-20020a17090b38c500b002749a99318csm10757978pjb.26.2023.09.26.20.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:17:00 -0700 (PDT)
Message-ID: <65139eac.170a0220.6193d.d873@mx.google.com>
Date:   Tue, 26 Sep 2023 20:17:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.6-rc2-2-g078a2ead544c
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 3 runs,
 3 regressions (v6.6-rc2-2-g078a2ead544c)
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

kselftest/next kselftest-lib: 3 runs, 3 regressions (v6.6-rc2-2-g078a2ead54=
4c)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-2-g078a2ead544c/plan/kselftest-lib/

  Test:     kselftest-lib
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
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6513921a2191b1417f8a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6513921a2191b141=
7f8a0a43
        failing since 344 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651397d5b9d95bb7618a0a4d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson-=
gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson-=
gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/651397d5b9d95bb7=
618a0a4e
        failing since 341 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6513915b03509d96518a0ac0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6513915b03509d96=
518a0ac1
        failing since 344 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
