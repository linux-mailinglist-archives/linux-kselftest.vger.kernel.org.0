Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE127BF2F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 08:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442235AbjJJG1A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 02:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442233AbjJJG07 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 02:26:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C1E97
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Oct 2023 23:26:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so3925270b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Oct 2023 23:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696919217; x=1697524017; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n/7qE3w3vTlnTZ3eROYy7CXd2i+JgRwjcugkfaTgLBQ=;
        b=RC8Z9S25Qz6F2H0B/1zDaSb5eGbyKOvtxY/FgaiKIdqhDwb/oQ28DGQBk62ElnmeYa
         wtLlf5CmAeXxE1jve/wbvd6cKyNwfMY182kjKBAx6w6JT7REAnbdP3Pi8ZKbqMvK/y/z
         896BPz+qV07WTVgyEGMdLPycaEOGvxVr5MEMBl+OUxQb3m47wvTyZLaS+tUJLP/0T/U6
         ibxk+nIBi5ks1bYFCEbgZaUEGPfKXFhTKRl2OThqMWZP7C5YVN1/ujWMS8QAQfivsOt+
         iEjcRAIkJOI1x/K21K7XCnfw5m7WoSx7UqciRU1NOL9gLX600Mxp7FvFfOGcOaHiuiur
         CBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696919217; x=1697524017;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/7qE3w3vTlnTZ3eROYy7CXd2i+JgRwjcugkfaTgLBQ=;
        b=eEUA9LpVH0ski1OWX/5jvrDPVT3pmHxRjDdw5sYEjU6U3vQa/cHwGvwafxUU9/Vdld
         WB08ixhH8Xz+9gmOrAIgbUgAnRiS38xFDkTFziMuLd36BA3eki5nT8X0spov3KpLrHNG
         vtcMLMbiS1NzGQMETRiAwNcmP5Rkt5GnHOP3bnxFfqbQuEqtg4gOTnn320aX5/rycYbB
         KrNE5lE4+Gb04OvGZB21psGqI/bpuTfp0vLl4P+IaTH5pHUnF+UIY7Qd7/rjRZMz6EA0
         aqYU+TYLusRD7maWyY9Oi+uld/Ovti/Nm107wS36JGsHfHyJ+Nq/ulCRgWPOFzU3jKex
         q/FQ==
X-Gm-Message-State: AOJu0Yzjjb7Fyr3PwnypFpnGB/LyYoir8GeVDyHxEqsrgXEZUGEGiMzK
        P7HbgmVjXT8Z2C4m72vpyW1L0w==
X-Google-Smtp-Source: AGHT+IGm+BMgRSgoPo7h9iRaEcq0r2PO8mQmkXV5R+g5RP4IrN5qajP7LTBLsGGPF6Nd9fmvA6CxBA==
X-Received: by 2002:a05:6a00:acb:b0:68e:3bc8:17d1 with SMTP id c11-20020a056a000acb00b0068e3bc817d1mr15604254pfl.29.1696919217257;
        Mon, 09 Oct 2023 23:26:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z23-20020aa785d7000000b00690d64a0cb6sm7387149pfn.72.2023.10.09.23.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 23:26:55 -0700 (PDT)
Message-ID: <6524eeaf.a70a0220.25ae2.29d4@mx.google.com>
Date:   Mon, 09 Oct 2023 23:26:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-18-g2531f374f922e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 1 runs,
 1 regressions (v6.6-rc2-18-g2531f374f922e)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-seccomp: 1 runs, 1 regressions (v6.6-rc2-18-g2531f=
374f922e)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-18-g2531f374f922e/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-18-g2531f374f922e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2531f374f922e77ba51f24d1aa6fa11c7f4c36b8 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6524e454e2290a6d03efcf87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-18-g25=
31f374f922e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-18-g25=
31f374f922e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6524e454e229=
0a6d03efcf88
        failing since 354 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =20
