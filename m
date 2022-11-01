Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6059614870
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 12:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKALXa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 07:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKALX1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 07:23:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDDBDC4
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 04:23:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b29so13146729pfp.13
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Nov 2022 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W4A8LCCoCx9b2/wplDaPLg6j+hMH8ifzEcZ4MrRw3Qo=;
        b=Z4MeGt9Mb2bTd5chWvL8D94qJIC/t5I0bquGp2zoeDRXk+c8WdUtJXYjc028sL4dDY
         +djsvq80fosJGdI9ee0MBY8bmNoxPlxcaV/b/OS4Gn6KdUBiUZF7JdBLdvW7XhMp7q8S
         oQ3OONWuvefNcpelJgwdXe1jCBjQ2elO0KihNDCn7Mr891IEqHxeF2ks6BUMUnfu1q/x
         0Z2YgxnOGlvcf3w6skQh5eqL+vpcJulWQdUMzLzJJ23Qyvr7uqIWSsQgQpyG1TwlIDy+
         bue+Qr07NfoTTSb6IwbTX9uM5Lz7KuQ9HHsil8JnXvje62bLBff25IIR2VuJLezTFAFc
         IuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4A8LCCoCx9b2/wplDaPLg6j+hMH8ifzEcZ4MrRw3Qo=;
        b=UC7XVjlzmv/gAnwVyiWr8yugg3KNFd+ZRLn4zftEM3/dhKRikOSYCWHxFcxXCwqzpv
         X40TztIkS3YwWoqKYe2BLSDaILxOwx+KAf03yVUriWjxcdWB4IlpAPi3wFGrSdYOsAWe
         hfL7sEiLZIc4zRwuXGCD2BhUf1kXKI7FN/+DrJzIPZKvPE5aebM81pQ5w7tB6uKPB35w
         iodu/6H90L8ZH9nC056FgNHd12ELcb0oTEV/LRXZ2iugCg/3puAdqK68zW02oQyfO8jL
         qcyveecwQYpXCQx4M8BbzBgX8Gs3DdoNXvzRPQjbSkZCbXvWKe4zHT4pcq1YunoAUdw6
         1ojw==
X-Gm-Message-State: ACrzQf15Eu+qpo2nEDYWiV8dorEf0RfjZk95+c0WNgPnjubiLBqg9HGi
        hRBH1qHPr3diVDIBybuCXuzPoZKlPenexKnG
X-Google-Smtp-Source: AMsMyM6IcNgNVEsN+w0gslI0a2F9cSV6uh659TQGxERU4+D8V+uplMeL2P4DAguK+rX2QbV7DyDIrw==
X-Received: by 2002:a65:4c8e:0:b0:46f:75bb:905a with SMTP id m14-20020a654c8e000000b0046f75bb905amr16399995pgt.495.1667301804280;
        Tue, 01 Nov 2022 04:23:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bc11-20020a656d8b000000b00462612c2699sm5676321pgb.86.2022.11.01.04.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:23:23 -0700 (PDT)
Message-ID: <636101ab.650a0220.8d5f2.963a@mx.google.com>
Date:   Tue, 01 Nov 2022 04:23:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-13-g67c0b2b52916
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 3 runs,
 2 regressions (v6.1-rc1-13-g67c0b2b52916)
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

kselftest/next kselftest-lib: 3 runs, 2 regressions (v6.1-rc1-13-g67c0b2b52=
916)

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
-rc1-13-g67c0b2b52916/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-13-g67c0b2b52916
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      67c0b2b5291656cbcb15371f835f5152fae2f7a2 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6360f399a4f97445bfe7db4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6360f399a4f97445=
bfe7db4f
        failing since 14 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6360f594e1a7ce5c86e7dbcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6360f594e1a7ce5c=
86e7dbd0
        failing since 14 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
