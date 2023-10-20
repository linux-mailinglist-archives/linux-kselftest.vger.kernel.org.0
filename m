Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1577D0F8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 14:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377326AbjJTMUz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 08:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377028AbjJTMUx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 08:20:53 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F731106
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 05:20:51 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57bc2c2f13dso383187eaf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697804451; x=1698409251; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x1fvqxqYu+jMQFb9kMufxG9Ni7l+eIdMQM3aRljIUfo=;
        b=g4riLuphrGzZt4QjO5IswZDtRd0f//r92woK2QIUKCV+HDBKCZDAnwgV2W2SvyTpro
         1gKZ6DZjueZdirWdf9NiDQrEZbt9oCqV5jtWHXUjiaRXute9WlvbHort/zRlPAw4/K7P
         2R/JzENOwzhtVOMbEtxa1Q0i0sCmvTit8OPWQaYIa+lEKV6wVrM1sgs9B7uxnuHel/g4
         Kit//oOQYZu6D7baYBnguEc/8VzcV7JhETxTq3oV0ZBhAZGdCm2YFq5AWGBSJD3zlXZ9
         wBBsYNjt7mc36avMN9uq231Dz2efzAV5pCXypVACFU45wMByqHFWtW5eqVRXqFuCnXru
         +Esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697804451; x=1698409251;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1fvqxqYu+jMQFb9kMufxG9Ni7l+eIdMQM3aRljIUfo=;
        b=um72aFyt2LldoHx1cOXM0+bPIeMHC2Cy55VZcrF2t+8x+lIQg504MqZsHjjrL0hRa8
         i0wkSJzwjZcNoWkOWE1iMlUaJzf5AUndd1LdhXJ2ObMWnKz1HULln2CCejckly6wPy0y
         JEmmja5RzacRLIxrUrld5SZrSgHogFx9ooeKT5ZLbP0yaviqzMuixTMls0LySbEw9p0i
         11c+IfMuiLdUAww3HIlYm5IKNut+/3iM3Jso7kNoXb0Zt+PlTiNWpIEZ7FvkbtHag4Pw
         dvPwJvgEELFdnekSWloBUdk4hgYx7HAEWbVdJb0LE6+6LYyUiShVYshIjw+HuLQbZp/N
         BGig==
X-Gm-Message-State: AOJu0Yyp9MYCOfo5S/uwGpWHSD/zZdGxbTCnTAfFIl6a+UfpvLS8jaeZ
        D28S1Hhb9Z/3/jezo3I2Ka9W1wHtRAlBMzaUoDDEVw==
X-Google-Smtp-Source: AGHT+IGrs6hzH0me6hVnx4vd2NURym85FVa/PJG7YrqzVMRCBLb40Dop7mfkfIHpp7Cej8ocT/ioPg==
X-Received: by 2002:a05:6358:6f9c:b0:134:c37f:4b5c with SMTP id s28-20020a0563586f9c00b00134c37f4b5cmr1171514rwn.22.1697804450597;
        Fri, 20 Oct 2023 05:20:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y22-20020aa79436000000b00672ea40b8a9sm1452174pfo.170.2023.10.20.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:20:47 -0700 (PDT)
Message-ID: <6532709f.a70a0220.e7bb2.4ae4@mx.google.com>
Date:   Fri, 20 Oct 2023 05:20:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-livepatch: 1 runs,
 1 regressions (linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6)
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

kselftest/fixes kselftest-livepatch: 1 runs, 1 regressions (linux-kselftest=
-fixes-6.6-rc5-1-gcf5a103c98a6)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      cf5a103c98a6fb9ee3164334cb5502df6360749b =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65326464bf8eaf4028efcf0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/65326464bf=
8eaf4028efcf0c
        failing since 366 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
