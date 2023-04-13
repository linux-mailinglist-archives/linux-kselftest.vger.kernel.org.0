Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F386E15BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjDMUW2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 16:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjDMUWZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 16:22:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1606A276
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 13:22:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mq14-20020a17090b380e00b002472a2d9d6aso1805307pjb.5
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681417341; x=1684009341;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VYZUWhFtPMUbZw2n3go5rf+ztcV2MouY2dl67B32WEM=;
        b=uoKRLVJE+2oxmuOKWc9KGoBn1u98GlBXuyMSMqpjI6PzujH1+GRjl8r7KC2IEBBM/o
         ymEwihx3CUL8JD7lVg/m7U5qmcsN4fFgNWImr6PAsJFNgYcA8qEaLwLV8x5JveZ4vD9k
         froc4P2DTghlRHor9E0ZOOgu2O91xy9SGpLdTQ1s5tYhG3+DTGI62mhe/xTJWDkMF4Q6
         BSBcwEXKhli1KBhpESIpNRZmvGLwUKrlcTZJzVJKMGbn70e7HtcQv9+lEWuTRRcd2wov
         nuvenZ3LfRqRdfNcQ1uRGPiIQyexEEEUKWi2Spj+LZkYzBnlf7NryB3npnY0dE69ttnp
         DSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681417341; x=1684009341;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYZUWhFtPMUbZw2n3go5rf+ztcV2MouY2dl67B32WEM=;
        b=TEIAzJvY4RDJFQOn/tcnbqcIAmDFhjVPfCpHMcpEhRtsrtV8Vxnlodk64Ee1+VNZVi
         hafIeIV7oEBRk3dHFMYXb4KP69YTqCSWcnWFu8+xGoeJsb+OD+HXX4i0torG27bKus+A
         pBd3rH1XsXsOHW5AhY8bGbJNU8leIx73damrHWp5X2z6DyAwajCgnIoyPxzu5nKuumVS
         zw8vFvIoBGiaMnnwkb9c3N+jXAZggiH2U5iyOk4Ml52D2tKuWRjUaloh0U5LgoLzaLSY
         Nd1dMt98RKqNHxltzBOXtA65Y4IfANAQ2hkDbZksJsX/7zeAwmJQiucHk2puQPIYFWRX
         rdWg==
X-Gm-Message-State: AAQBX9fs3vIowXlFdLoRZxA7fyQOXh3vCP93OiW3W4zi3+3qx71n3Tri
        aRh77f9VhCYxJXfph8kzaGyaPQ==
X-Google-Smtp-Source: AKy350bxR/bGpj/I8vN0ogWXFooUU5WM9F9VXPZxngErV9jD4z1OaCP2Fvy3c4mGt0uq2Zl5M8QuwA==
X-Received: by 2002:a17:903:120c:b0:1a3:d392:2f29 with SMTP id l12-20020a170903120c00b001a3d3922f29mr324948plh.20.1681417341283;
        Thu, 13 Apr 2023 13:22:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709029f9600b0019c91989a1csm1835700plq.300.2023.04.13.13.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 13:22:20 -0700 (PDT)
Message-ID: <6438647c.170a0220.4b52c.471b@mx.google.com>
Date:   Thu, 13 Apr 2023 13:22:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-24-g91db4fd9019a
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 8 runs,
 1 regressions (v6.3-rc1-24-g91db4fd9019a)
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

kselftest/next kselftest-cpufreq: 8 runs, 1 regressions (v6.3-rc1-24-g91db4=
fd9019a)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-24-g91db4fd9019a/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-24-g91db4fd9019a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      91db4fd9019a08251a500157cf0d88de457e1a96 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/643856f0b80456bf352e8600

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/643856f0b804=
56bf352e8601
        failing since 177 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
