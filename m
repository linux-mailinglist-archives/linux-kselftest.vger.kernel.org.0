Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7013D6C2E94
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 11:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCUKUB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 06:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCUKT7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 06:19:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A4855B8
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 03:19:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d13so15135060pjh.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 03:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679393980;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6mkf5swjDQU+L8jzHonV0ZiPQnOLIE9Y2a1XD0MaqMk=;
        b=ybVX/0i1F6Ti213X9txI2Aatt8zr1GYS5hWhE+KbFd8LffhEFEjsiwqq6yxxPmbuil
         OdfDYTJ36ANbWFnEleR68mfXZgWPEBA8Arie+CKtDjDcvbc85Iy9EEkSXECZLdCwoL5M
         OzXcOdoU39t4m3Ff13iV1ARl6du9++3bWMX3qwYt2ZkF+I4wbR6OUjAovq09EbqrsJOT
         DsaUnHnzBvDPCUNFr/SSA23u6TKGfSt3QrsQM6waz5v4uJHK0AMUxQjS4RMy8YClUDk+
         CNowhZR5RVEON0TV1w3zXO+hZKm/25b0is7GhHy6aEmJBCy3EGN4alYW9VGmMsY53kOx
         gs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679393980;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mkf5swjDQU+L8jzHonV0ZiPQnOLIE9Y2a1XD0MaqMk=;
        b=jyiOzbOnTAkYXZbkZ3nrJLXJhLULmsufvwnCgpinPBp98optKxhHAN1xSss5n67vuk
         T1y4xoRBVLDuVEUvp3Lf562GZVzfdxDiNrPGpDwlkXBrMt3fT6iZ1ix0P1amWOQgwUDd
         rcOxdPAyfflWRLz+D9qjEb9DrkR9CteQmRzOB9ZByU6vcnAO5p0B7be2hIc13Fx+i2k7
         icbrzUUFK/mO5Qv/dkfjnFWgrECKyqxluwPSxkTmLfKvfvQjh9pt/JnLqQrBMGDew4vP
         7BhjFPoFj76bNytQLE/wFG6YvJY+ovVkBc/SX/HF4KiVbN0IZExACPEQHxNocbQyQWgP
         92RQ==
X-Gm-Message-State: AO0yUKVAEXPDEEeriC/b8Mu3t/EbPkRHo1EK6yXmb0ll47xGpZGojSfx
        f9+6RKrWqrQbVFH6jAbQqNIYiQ==
X-Google-Smtp-Source: AK7set+kqw8+b4cZllO/i7xuq8jJdrirk5ldgwbGRYyI25dL4KetYRL517/SPiiR2UoDg/0jWi9Lfw==
X-Received: by 2002:a05:6a20:dc9e:b0:d9:e367:edd1 with SMTP id ky30-20020a056a20dc9e00b000d9e367edd1mr2686835pzb.15.1679393980053;
        Tue, 21 Mar 2023 03:19:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a24-20020a62e218000000b00627f2f23624sm4119648pfi.159.2023.03.21.03.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:19:39 -0700 (PDT)
Message-ID: <641984bb.620a0220.c3e65.7025@mx.google.com>
Date:   Tue, 21 Mar 2023 03:19:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.3-rc3-1-g05107edc91013
Subject: kselftest/fixes kselftest-seccomp: 4 runs,
 3 regressions (linux-kselftest-fixes-6.3-rc3-1-g05107edc91013)
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

kselftest/fixes kselftest-seccomp: 4 runs, 3 regressions (linux-kselftest-f=
ixes-6.3-rc3-1-g05107edc91013)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.3-rc3-1-g05107edc91013/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.3-rc3-1-g05107edc91013
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      05107edc910135d27fe557267dc45be9630bf3dd =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/641976b86ce7b1e2cf9c9530

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm/multi_v7_defconfig+kselftest/gcc-10/la=
b-collabora/kselftest-seccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm/multi_v7_defconfig+kselftest/gcc-10/la=
b-collabora/kselftest-seccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/641976b86ce7=
b1e2cf9c9531
        failing since 84 days (last pass: linux-kselftest-fixes-6.1-rc3-3-g=
89c1017aac67, first fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641975c3db2fd30d439c9508

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/641975c3db2f=
d30d439c9509
        failing since 153 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6419729500650bc4949c952e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.=
txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc3-1-g05107edc91013/arm64/defconfig+kselftest+arm64-chromebook=
/gcc-10/lab-collabora/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/641972950065=
0bc4949c952f
        failing since 153 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
