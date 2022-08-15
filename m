Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC80594C9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 03:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiHPAwT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 20:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbiHPAuS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 20:50:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D76E198ED7
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:46:19 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 73so7468183pgb.9
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=s+5DDHW7Ep0I01pqjUHUxN+ddFqbNh3mpW5AIbX7aqU=;
        b=Ey1VolUHz9iWXDgNx9Ol2dXniPKIErtgx70ZlEnGYgc3CICo/mwoAsNr9Q4/4ZPJTC
         wYyxB9jcTnzqqLXx2hGZgccmMaSOhZXJpPsdgBG88UnR9furk5+2gSR2PdvA6zUyPcNI
         lX8YprJHL9xAfBfFwMeWWB0UaPWH94PEg8OjVLq4+VPERbtNq37GQ9bpKdJsWMbJ2QAd
         MZV3BgsGkfqP3AMtAzDr7n+PZEcPDLdsdbwjDQ868VB3jwKrt1bDncmJS2gTmjw3HMul
         JE8FkQ0D+o52jbgK/KuTZjx4GGrmO64F0d+bV3OQvlwwW1TreD6yN6ImF2tiFtBo6bJN
         DsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=s+5DDHW7Ep0I01pqjUHUxN+ddFqbNh3mpW5AIbX7aqU=;
        b=M2/AKHNYmNoAmZ65etK1TuaNi38BITd+QEm/ts74L38louGyhTu10JSxRHYn+1he1F
         rTFUWwr0XprRlAYgylw5XEi5M4NfplaMeq6Lbrd/G9Qjct/i1rhadjDgG8+O+ejSO5zx
         90eC0K+Lh+TlxZxiF8huYK0r4nituYrcWAM9htJtBEv9KybaBaF/rsmLOYccHJ1sDOKA
         z68VkfkMbRTqawtZfvDdfH4gdIOZNR6vi92zEo1TunsF0h9cWTMmTaB2MxqU7Nr9xNFQ
         OiZk2F1pE59qnqRKkh/GLhcnpGEOH9HVRYHStXJpuYlqEhJaFtHR6EhPfzd9Re2ZrTNM
         bKxQ==
X-Gm-Message-State: ACgBeo3qTCfFXNuaXOr4x/L43Dg6vcLpN34es3BI4zmsrOG495qks9lG
        UGncw08CGL/NC1bQIM2lLjpxerTyQt9I3bZZ
X-Google-Smtp-Source: AA6agR7ApsksiZDioXDg751pC0EQMGBp7iag6ZX0ljZhzxYwfHPXkaWFg66FtQBeGsAbtWB+0Z6Clw==
X-Received: by 2002:a05:6a00:4147:b0:52e:2d56:17c8 with SMTP id bv7-20020a056a00414700b0052e2d5617c8mr18012253pfb.51.1660596379352;
        Mon, 15 Aug 2022 13:46:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d206-20020a621dd7000000b0052dcd14e3desm6915899pfd.183.2022.08.15.13.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 13:46:18 -0700 (PDT)
Message-ID: <62fab09a.620a0220.5e53c.b4bf@mx.google.com>
Date:   Mon, 15 Aug 2022 13:46:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.0-rc1
Subject: kselftest/fixes kselftest-cpufreq: 2 runs, 1 regressions (v6.0-rc1)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-cpufreq: 2 runs, 1 regressions (v6.0-rc1)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
0-rc1/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.0-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      568035b01cfb107af8d2e4bd2fb9aea22cf5b868 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62faad04683b2e848d35564e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.0-rc1/arm64=
/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-cpufreq-meson-gxl-s905x-=
libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.0-rc1/arm64=
/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-cpufreq-meson-gxl-s905x-=
libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/62faad04683b=
2e848d35564f
        failing since 59 days (last pass: v5.19-rc1, first fail: v5.19-rc1-=
4-g9b4d5c01eb234) =

 =20
