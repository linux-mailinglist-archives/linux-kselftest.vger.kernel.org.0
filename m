Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BFB610E51
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 12:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJ1KXZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 06:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJ1KXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 06:23:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6AD1CB52C
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 03:23:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h14so4306246pjv.4
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 03:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d6hERmbccYwACgi3EH2y4GS9VWjjcFkH4TlpezIzjpM=;
        b=65FyApc2nHaUWAwK1udU8jetndL1FPPl6LV+sQjZ1PofjdWXxQuUglF/L05/oAaE2N
         wISm8VUyFVxopBGRCkfEaPFpMd1KWlIaApaIW5pIHUhSmxM6jdqxYAWrHf+jppLv7RNp
         5Y6rq04II1DX2/e9qR0Gq8NdHFpVrxgNHNXKjWXtjPh1TJUi27jNjTIWwoylANShu5cS
         lISqSzDjPNVjFPdwY4Cl+T20zAKLrsT3HQdMJaTfgHhxh/n1da4T1Vdk5b+jrmZOhOEy
         uDTP0DFg9NO2pSnggrr1K3zCxViVewFJOUK1cgdrHXmrFqzYGEr8NiHWd3lkY9tcajOB
         nRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6hERmbccYwACgi3EH2y4GS9VWjjcFkH4TlpezIzjpM=;
        b=FEkCTecdM8Iw0silCHsJfnbAubPiyzKTGqqXCREL6ktl+DurnpF8lDZc+4Evut9WsN
         adUmMhxPx4ubBDQyEdrW4V0+T5mEdRfymW7Og4QE7J1pLKsPHwJ8xkf1HGXF6ZAvJJdK
         v2wnGoG7ymmn6iJsQSbiQ7sdLIhJKpwbCsMhzCo60OTz15jKBXzoc07YG2pbaq+bHPEr
         /ZU97dTUyGToYTQX+rcD/OJufQXWEHl+B0ogvvInQd4zMY9VqkSf1rrNSrLIy8b+eRIx
         3F3rvcKQlbq1wbJDbK5qZc6kTLotLAjttBnmw9NjkDuvoLOCHaFCEqemWvzbHPKgQ9mF
         HTkg==
X-Gm-Message-State: ACrzQf0W90GwEvHHg3semveP9gXYGJZzYSoabAf8W9UXB9HM9BqdZC/6
        jgdu461VQuzmwHhe/iGlGGfGXA==
X-Google-Smtp-Source: AMsMyM5sdDtjOfeCaVgt7l/7Q9q980INkXTgjmpA9OXkCHvAw5dBr2Kw6cuw9eksjAZZsIKmcO2y6w==
X-Received: by 2002:a17:90b:1bc9:b0:20d:75b8:ee5d with SMTP id oa9-20020a17090b1bc900b0020d75b8ee5dmr15815530pjb.147.1666952602637;
        Fri, 28 Oct 2022 03:23:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x3-20020aa79403000000b0056bdb5197f4sm2575805pfo.35.2022.10.28.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:23:22 -0700 (PDT)
Message-ID: <635bad9a.a70a0220.b7258.4e88@mx.google.com>
Date:   Fri, 28 Oct 2022 03:23:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-8-g94fea664ae4ee
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 3 runs,
 2 regressions (v6.1-rc1-8-g94fea664ae4ee)
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

kselftest/next kselftest-lib: 3 runs, 2 regressions (v6.1-rc1-8-g94fea664ae=
4ee)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-8-g94fea664ae4ee/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-8-g94fea664ae4ee
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      94fea664ae4eea69e90abb4bd01997b9c54cd013 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/635b9f2d7703413198e7db66

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-8-g94f=
ea664ae4ee/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-8-g94f=
ea664ae4ee/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/635b9f2d77034131=
98e7db67
        failing since 10 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635b9ba7adae52ab3fe7db4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-8-g94f=
ea664ae4ee/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-8-g94f=
ea664ae4ee/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/635b9ba7adae52ab=
3fe7db4f
        failing since 10 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
