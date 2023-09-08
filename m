Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E462F798C75
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 20:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343603AbjIHSQY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 14:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343630AbjIHSQT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 14:16:19 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC0F2694
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 11:15:51 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso1781621a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694196940; x=1694801740; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bzJP90890J6DS2ILmbqR2WVOWLTtiT+JlksVWQCV4ig=;
        b=bl1ujU67u+ixwOtWaNyzQYq6xi+db+hRTqrSlc9fo1MBXyOQDzUHcSWOl1EE1DZck8
         ihVhFlX8uf1jAE5kx5bHDrex0bjQD5kAXNPCgD7MJuqG2Mhoe3EAz/EQBxy103HmFB5D
         4P+0PoOgIuOw5w05cwwbmTraKHXQyT0ivyCKIFkWyLWjAgYtM77l/lfu3av2Ib7vcSVC
         TIpYX0gEHPBZai/qHms8Jo8g6JQVGctlqByrmoEL4d1QMsyLKqa8rcE+gyydzdbfxbYl
         9wAjbc/1ZhxjRtGxSuV9g2fR2h4Xf3nLMyipdp7MBk95+znL5kR0r0dT119oHVSwX8up
         U12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694196940; x=1694801740;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzJP90890J6DS2ILmbqR2WVOWLTtiT+JlksVWQCV4ig=;
        b=jvyvhDdsq9XrGjYEh5J2Sfv3jbpxFbYqequXIwSOpIrRf3/U0x3Vu5TXHAkpEbsfyJ
         LftZkprfbSQ0y8VNOaTJ8i7fgEp0Ye9i/HqLcyveQ8Xqlp+Zte65SEAh4yVi8xbfjnJe
         R1f7E8+9DpmRyxUcL7X//qalutoVQ3GIEzAfl5Qd9/buCkfu8yCNE7tS8UKkRCfwx8MA
         leP3jrClZAGHrWHMoPBh6YkCz/lZPGPnotpd3/xlDXSeD65bz/cGKdgQ1z0Vz4hc4NDz
         mN6ir231Gb+TI/R46cBhzkKPNn9sfPg4EHPGJivQxrhcgvG6yysAWcGDEIv/PEXfBLUc
         Xw9Q==
X-Gm-Message-State: AOJu0YxZ1o648w1x2BNh2SOCgf31Zq/u2W/23B6alkiqZxyNbOXbBBl0
        IerVRYhxrxpwAwqxwqXEVRPjjA==
X-Google-Smtp-Source: AGHT+IG0SwDIfppHqNdGwPcCJeyT+JHKoYho2GCcjlhn6+AsFFggC/8y6hZlSv40pk2Mc9WSvFBLTQ==
X-Received: by 2002:a05:6a21:a58c:b0:140:4563:2243 with SMTP id gd12-20020a056a21a58c00b0014045632243mr3966325pzc.50.1694196940044;
        Fri, 08 Sep 2023 11:15:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7810b000000b00687a4b70d1esm1579235pfi.218.2023.09.08.11.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 11:15:39 -0700 (PDT)
Message-ID: <64fb64cb.a70a0220.b726f.3ec1@mx.google.com>
Date:   Fri, 08 Sep 2023 11:15:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-next-6.6-rc1-4-g3f3f384139ed
Subject: kselftest/next kselftest-seccomp: 2 runs,
 1 regressions (linux-kselftest-next-6.6-rc1-4-g3f3f384139ed)
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

kselftest/next kselftest-seccomp: 2 runs, 1 regressions (linux-kselftest-ne=
xt-6.6-rc1-4-g3f3f384139ed)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/linu=
x-kselftest-next-6.6-rc1-4-g3f3f384139ed/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: linux-kselftest-next-6.6-rc1-4-g3f3f384139ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      3f3f384139ed147c71e1d770accf610133d5309b =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fb56d8bff248dd32286dd3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/linux-kselftest=
-next-6.6-rc1-4-g3f3f384139ed/arm64/defconfig+kselftest+arm64-chromebook/gc=
c-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/linux-kselftest=
-next-6.6-rc1-4-g3f3f384139ed/arm64/defconfig+kselftest+arm64-chromebook/gc=
c-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64fb56d8bff2=
48dd32286dd4
        failing since 325 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
