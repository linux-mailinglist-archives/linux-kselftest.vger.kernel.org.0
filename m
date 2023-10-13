Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C514A7C9152
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Oct 2023 01:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjJMXYd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 19:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjJMXYc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 19:24:32 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59C4B7
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 16:24:31 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-35742cbb670so9829555ab.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 16:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697239471; x=1697844271; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IXl3FibCprWHoox/WJanVobo6QzH1EcfA70a8knFS0Y=;
        b=J/r5u34PdU0CatuSTriKmTCHMIeTdZaSBThKuIbj0GoC92HwruTK8phqc5aNOcf8eN
         oEfZesmGHALn6yS8ocjPVwOMB0GmunfPlBbD7goRnUR6+hiPcJVnauVhBMzdS4VaAy6w
         YHrTBAueVuGiv7g0zDVx1WteXmYYbmoMT2h4QE/bdKW/YgCggRs2HCTXlylrTMcivLcv
         vAed0m0TQVkIdOIhEmv3pnU6ktjQ3aVhzsruCmtBK5OybiRujSsKc+yy3xf5jrugUT0a
         VRB8Gd60qr0R8Kh6ebR9uN5TQ0DaBimJB1tBA/rKBtLHeqAUS7vAyuKFRDnC7aL3igbW
         PBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697239471; x=1697844271;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXl3FibCprWHoox/WJanVobo6QzH1EcfA70a8knFS0Y=;
        b=V6jCRdjXMim9Iu4mTngmzz8n27aTUOaFDm1KEMQ+dWTF+G4IcgE0qxRb+/ql6K7ueG
         Q6hsIBtddVDD55fGYIYXKRY9SzqLT415vbutpxaQ9hpopd/i5kY/JNW2/bGoF7qlI5pB
         GogoYXokP02Tx/1QrY/eNE1/JDXcWe4nPYr4rQlixfn+HM5Al86y34+SAgX+5UsC4Z7P
         VyGhqxMhsCdCVhop+mM8H/es+cYh0Sak8tpIMSRo8A9FBWG6dxUhJn1sEzj6nEB8Xgv6
         feYD8n0s/0j7bg0eD3EpkUDvk77hHpnntqCwK6r63wph9oXARujcB0q92AxkmaciSeTF
         NGYg==
X-Gm-Message-State: AOJu0YwhPDXsSQDym8NnYfeYyFv9xfaLxIf/4MUGelN8RIpQ3jqBLIvi
        igSxPKq1sfXNPQqcdyph5eOlmg==
X-Google-Smtp-Source: AGHT+IFH/aubP+KTTRWoFJ35LLIsbq7yRyeMuPcJuvnUYdUFjkTi7EdD5kG88whyNjuX8AXRwq64mQ==
X-Received: by 2002:a92:50f:0:b0:351:5aed:c13c with SMTP id q15-20020a92050f000000b003515aedc13cmr28003841ile.14.1697239471063;
        Fri, 13 Oct 2023 16:24:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a001e00b00274262bcf8dsm677690pja.41.2023.10.13.16.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:24:27 -0700 (PDT)
Message-ID: <6529d1ab.170a0220.ef37d.4273@mx.google.com>
Date:   Fri, 13 Oct 2023 16:24:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-43-g508934b5d15ab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 4 runs,
 3 regressions (v6.6-rc2-43-g508934b5d15ab)
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

kselftest/next kselftest-seccomp: 4 runs, 3 regressions (v6.6-rc2-43-g50893=
4b5d15ab)

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

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-43-g508934b5d15ab/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-43-g508934b5d15ab
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      508934b5d15ab79fd5895cc2a6063bc9d95f6a55 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6529c851684e410081efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6529c851684e=
410081efcef4
        failing since 358 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6529c53acf3108f307efcf0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6529c53acf31=
08f307efcf0c
        failing since 360 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6529c51785eaf29b70efcf0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6529c51785ea=
f29b70efcf0c
        failing since 360 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
