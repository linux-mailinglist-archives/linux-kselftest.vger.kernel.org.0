Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1667AFA42
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 07:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjI0Fpm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 01:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjI0FpA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 01:45:00 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13095BB1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:17:02 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59f1dff5298so116212127b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695784622; x=1696389422; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B60rFbZx9lTb2E7tiR7dmcO8D3Pizx2v1GPP4AXApHM=;
        b=IBYxaET0uSLcYx06SbjQrHpjdOro7pz3HXZ8NaVfuXx1gUiipfGkRk58Q+d/eWVwh4
         zqvlgzZSLDvQAuLEiyDGkyv8dl3gr2kxsOxZdtWD3CfQRK0Nt2JvWGvdK+cd84TLc5Wp
         WCclECnhMmQChx8l7WjoherFqIslyULG5dxg3yH7Q4hVYm9XE9lRNiyj8SjgKgI51fir
         0x1oOVwo5yUivtJDb0daqjApqvuuDy2nnZC7f4a2Ms/NWTuNTQogL5z09R9eJzf4kc3f
         40IVpnCBZtmMpsxIjJYQ4AZOGwChlUSjkUdF3+icHV0rhW2isgiT9nco7w//b4hbSyMZ
         waGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784622; x=1696389422;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B60rFbZx9lTb2E7tiR7dmcO8D3Pizx2v1GPP4AXApHM=;
        b=WmMDRhfF5+I+dpdB2bCYuSyo4hSgPM3XMwpHp5llXYexAmb9BiiXUckfLylt85P+Jq
         O0pqZ/0KOv1bVCEAJ7outhHC+8SPgYs6KHULbzqIdZlBpTkB/6GpNQOaubUnp5a7bBhz
         0syHhcA2BGVJET/t1jYV8cp/uw7dTBWqNgVhcE3mJp0qkS5WhS0nQaffTzDBB35NFw4q
         hRqQnIxZ/8+5vyy1FtXDiDc0HsrQUvQuT5Ma7X1zZBInbji4LPyGWlgodOG1JYuNZ59w
         uO3s/+VdFWAKuJWxkDcYma5e6VqOTGJb1NCCfoZvVAM86EOmEoClh3tgjXB4d58t/xze
         5RYg==
X-Gm-Message-State: AOJu0YwPjLtabn+bxVgHzR+vDNSW9Gm8gsYL4X8nRCC+qUEWH1eqHNkb
        UGK8LK3/OTuQiNn0aBhHKrJz43w7qp3T6ZvVxSKf9Q==
X-Google-Smtp-Source: AGHT+IG13Io9WoNPcxmNRbJH4bAgGHBM+5PjSeZicSKtFF/gYNwlYFnFcC2AVC08ltMGZz0e2EhlAA==
X-Received: by 2002:a81:8947:0:b0:586:6a71:b018 with SMTP id z68-20020a818947000000b005866a71b018mr836312ywf.20.1695784621788;
        Tue, 26 Sep 2023 20:17:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w88-20020a17090a6be100b00263f41a655esm7529762pjj.43.2023.09.26.20.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:17:00 -0700 (PDT)
Message-ID: <65139eac.170a0220.a32c6.bde0@mx.google.com>
Date:   Tue, 26 Sep 2023 20:17:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.6-rc2-2-g078a2ead544c
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.6-rc2-2-g078a2ead544c)
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

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.6-rc2-2-g078a=
2ead544c)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-2-g078a2ead544c/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-2-g078a2ead544c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      078a2ead544c56fbe6a3bed8cc90b5151a328b81 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6513913503509d96518a0ab0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6513913503=
509d96518a0ab1
        failing since 344 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
