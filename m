Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A16F697293
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 01:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBOAQg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 19:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjBOAQf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 19:16:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81975301A5
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 16:16:34 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso2695492pju.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 16:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=La5SKwini7U2Q5gRkRwxj3s/vgqCyfZsqFdsNscyEXk=;
        b=jg9FyFukfKjTJM+RgpWRFNUhwIsK1M8FE0j7b2DaCXvlvXvu7Mel6yxPXIhSIk5uAx
         aWIpuvyI9VtgYNyjPALfafGvjv25aRC7xafTYnhhPDX1XqF8GdbR6i/5CtOiKER1S16+
         3NNBpflf4lsxxyZ2Q3PPchn1yQNY68v00dr1P8SFbS79HHSzEXBVTgODfxyltzE0sCDr
         uIBpTqaBaUjrIrjto9aDLBSXAJnm1rqASWVBvaeNIBdyv79NkCzhBIf/mN8dLcBbHIzP
         XZkbk53VWHg33tNmFFaFgyIA2J8x4DhCyqVdKzxwhKG7K9z6PEiT79u27tjl6xTQfT0L
         FpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=La5SKwini7U2Q5gRkRwxj3s/vgqCyfZsqFdsNscyEXk=;
        b=1S0dSzZd+v5OuJoUAzyZTkSWIC3xI5hXrvrKCfetHMzHpxRnuC0AT2fCcEH8jfr2xY
         lx2WVEUkIVWB3+EFyXVP5b5DqHnt+m7goX5wxz9n9fgPqDaTRgAdI6nI+H3r4gv14BcB
         Q/XGueq/+XxFBrJCm5xHIxt/jEYvEP0xmm5py1tAxZucF80EYJ2yLh1N1oacNmfxFT0N
         SUZw9l+3lZKJXtBxuZMNSaenOr//CFlJPpfZXJ62ti9lgi2MHLPr+D00kB24Kw8JvDjQ
         us47YvdzGwz+6C5yKRCWpOauGya+DtyQfQzX0vKXpTWJ4k+AhqPElZ6aEMSTbRX+sJkk
         57sA==
X-Gm-Message-State: AO0yUKURxV6Ecq8XARMAFNnDOOGnziNQCrAglBvx7YkJ6RcgO2cVIJ+j
        P/fvValrcic9Y51S2ESA8MqxCkZOZzh+oduP
X-Google-Smtp-Source: AK7set9cWTjCTh7O4x8f4zw6hZMSepRNonNnucED/3tphBM3gRcQrwBplAAmzdzDvCiW2QGkEAT1Pg==
X-Received: by 2002:a17:902:fa8e:b0:19a:98bb:32fa with SMTP id lc14-20020a170902fa8e00b0019a98bb32famr390667plb.16.1676420194015;
        Tue, 14 Feb 2023 16:16:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b0019ac69a6348sm308395plk.133.2023.02.14.16.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 16:16:33 -0800 (PST)
Message-ID: <63ec2461.170a0220.3ab03.0ed8@mx.google.com>
Date:   Tue, 14 Feb 2023 16:16:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-40-g0eb15a47bf43
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 6 runs,
 2 regressions (v6.2-rc5-40-g0eb15a47bf43)
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

kselftest/next kselftest-cpufreq: 6 runs, 2 regressions (v6.2-rc5-40-g0eb15=
a47bf43)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-40-g0eb15a47bf43/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-40-g0eb15a47bf43
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      0eb15a47bf437a268b69ab1a1a45fdf1f609b69f =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63ec1e7c6660673b878c8643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63ec1e7c6660=
673b878c8644
        failing since 117 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63ec1477fd6eadcc5e8c863f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63ec1477fd6e=
adcc5e8c8640
        failing since 120 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
