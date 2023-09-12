Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28A79CFC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 13:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjILLXj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjILLXN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 07:23:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E611736
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Sep 2023 04:22:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf7a6509deso36909045ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Sep 2023 04:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694517760; x=1695122560; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bcTXIsNlElNz2bXKo0qoAWEc5UYGi1aW9V2JLoofXS0=;
        b=onDS4XImRjd3rBdCTC85rK/fWwE8KAv/R+bkuje4KhV+qmZZJQkDl1PZhj+FtTyI+Q
         diqsP4sQdXUe6HK07wq7C4n/0VV9+16XibZaKyfIcFFj4V/9cS+Y/yy9C0qwbzSyecv5
         BqNXvVTdB03IZaV5qWnG4yi/u4h4n6dZx7lmSsSoErmt6/N0oUgy89ajG37C+KmvmWvo
         UNsOFutyuTBRcaKlIVJm56XkFc9sdYqgA0XkB+Szk0OcCct9oowmpShMLMfywovqA2wP
         28SDxSInDKs66a4ujKprXLil+3mtLZdp+Uci5YYNtf/TBI25F273F82xPh2GE6Y4yLk4
         otig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694517760; x=1695122560;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcTXIsNlElNz2bXKo0qoAWEc5UYGi1aW9V2JLoofXS0=;
        b=hpvDXADZiFl//JqBQBO36LW/CPtt080ikLdvY0jwjuzXusXty+5XY2Mcy5D4PcvvKs
         ieebutUZc3VqWtRP1q4qCzsqFjae/sWYWFlKfQSSertjMpeRau1HvnOV0ghm50P6927/
         ScqGOGdCJtLI2LGhfDcfiFrSGAv7m6QEyvsvJ/9p8hzq3RKIoYuLCIp+8HrgNXMiz0Cn
         MOYRmd0xl9IdlIzQMqR8HEmDBzz+bmTjTNMC4n1RIDe8nYnCQAqDEJ0brm/Kg4ZK3p8z
         BXAtjMzDlBSbFytvHI+toN5qs3mXGZwHzvNzu70Mhs8Q0pa4HD9e3A8zx3mqr5GgOIhj
         Ar2A==
X-Gm-Message-State: AOJu0YwbZN+NOOfS2+Mll79dPbvEbsMozb6iNwk0tqpVBqKaLaXvKOQ3
        1tGTMrZEwKdAJLJwUld6VODRJA==
X-Google-Smtp-Source: AGHT+IHGR7UhldY2FH3Mbbhzl49sEDF20spBuw5r5WPeeNh+s7V11ZteRR4W3YWqneQZA2QNPzjvUQ==
X-Received: by 2002:a17:90b:4f8a:b0:269:2356:19fb with SMTP id qe10-20020a17090b4f8a00b00269235619fbmr9576784pjb.15.1694517760627;
        Tue, 12 Sep 2023 04:22:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a194700b00262d662c9adsm7209334pjh.53.2023.09.12.04.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 04:22:40 -0700 (PDT)
Message-ID: <65004a00.170a0220.9c526.23c7@mx.google.com>
Date:   Tue, 12 Sep 2023 04:22:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.6-rc1-3-g7ab6fe6625c9
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-seccomp: 2 runs,
 1 regressions (v6.6-rc1-3-g7ab6fe6625c9)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-seccomp: 2 runs, 1 regressions (v6.6-rc1-3-g7ab6f=
e6625c9)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
6-rc1-3-g7ab6fe6625c9/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.6-rc1-3-g7ab6fe6625c9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      7ab6fe6625c9bdcb8fa5f61c8f8e30e13f689284 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65003c84c3716bcbd58a0a4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.6-rc1-3-g7a=
b6fe6625c9/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.6-rc1-3-g7a=
b6fe6625c9/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65003c84c371=
6bcbd58a0a4f
        failing since 328 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
