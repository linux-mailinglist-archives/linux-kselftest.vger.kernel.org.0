Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE5B6DE7E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 01:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDKXRU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 19:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDKXRT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 19:17:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91416171B
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 16:17:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o2so9436269plg.4
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 16:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1681255038; x=1683847038;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+wSijTP6vFeFSumSwpq/PaC83R+aeqJLIVWLio1cDgg=;
        b=T9K4LFjDGTRZqYd4pk3eFB/GBeC7SANzzBTRaG/nfbya1W2Vj46F6i3SMam+eYsPsa
         Wc+Ej+ZPpePYjhs3LgYfV/SYmiVgFs7uAHfm1w/0BUzuiZajTo6cktQBdZAp9C2Hi2+F
         gWHRJMDyYECupTakupCDFt27860tcaP0HoUz0soX8krOIbJkdQt9Po6GM682zJNnx9yN
         UIIzdrb5qLWokxOSmyMW46Dnl+RmW04d+8YVmE3hLnW2ykxhWBLtPG5Vy3F3Zm0cI3PA
         /JMaV7kh0oN8xU7iyki2bvk3WWK+kMsI0MUZgesvtTQ5sx5fESNYMPgA53Pq9EXPPdcz
         vgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681255038; x=1683847038;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wSijTP6vFeFSumSwpq/PaC83R+aeqJLIVWLio1cDgg=;
        b=H/xZUlbRCBCmvny+oo8B8N7jLSnRXGGaI08w3/pn7v7ORJ/ISsVSVR0vHE21n0jAPz
         R6Tp/NhJDy9ajfR6Xon/RH0MJwS9tDs+OwOz5ZTDUfJlYBCAJI68wCtSV1slQ0PFlcmC
         mjpD+Hk8Fs3GSLEadJEF0OhjRFu0WlU8VbucHZxNqujaRU18zRbAf2gxNFYJlMRzpESo
         ghNQ2rey6QIAdEykZTjc0n91DYY5mVU8cvFbCU7LVJS1BL8hmqtIIrzStg5kG+1IReOy
         YlC3ffLNEp3QeJrJ+jrZJd4UzON3TwAN2rlNyTEWMpoiHoO9n70q8fnyVBqQkWEAaS5j
         +Tzw==
X-Gm-Message-State: AAQBX9cGUuDhgORUG7tmzwyhUgHYyOx/vCZqHsLgSZvWfP9syDLlJqvd
        RG/GZyhTuceuOYVtDkwwn08ANh2nW6gR3zF9Xm5JWw==
X-Google-Smtp-Source: AKy350Y8hJ0LBGA3AZ5rtCNysdv/8MAW+Z0Wv42AVzsY3bGBUEfFa5S2WCTWkeo7tsgCQr0Vpckr+Q==
X-Received: by 2002:a17:90a:ea0a:b0:246:bb31:e835 with SMTP id w10-20020a17090aea0a00b00246bb31e835mr829294pjy.15.1681255038076;
        Tue, 11 Apr 2023 16:17:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090b069500b0023a9564763bsm123879pjz.29.2023.04.11.16.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 16:17:17 -0700 (PDT)
Message-ID: <6435ea7d.170a0220.91ccc.0744@mx.google.com>
Date:   Tue, 11 Apr 2023 16:17:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-17-g266679ffd867
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 8 runs,
 1 regressions (v6.3-rc1-17-g266679ffd867)
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

kselftest/next kselftest-cpufreq: 8 runs, 1 regressions (v6.3-rc1-17-g26667=
9ffd867)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-17-g266679ffd867/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-17-g266679ffd867
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      266679ffd867cb247c36717ea4d7998e9304823b =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6435dc4e5050e9421c2e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6435dc4e5050=
e9421c2e85f2
        failing since 175 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
