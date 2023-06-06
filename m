Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97DA7234A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 03:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjFFBkC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 21:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjFFBkB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 21:40:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A810F
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 18:40:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2568befcf1dso4141225a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 18:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686015600; x=1688607600;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XNdpCvsbaTZFnN+t5SDVUoqpEurb3IMhTuvtB99l2w4=;
        b=B6ZDmdzdSecZT/Lc6Z5b4TxsXY+UluiMEigczCcqhGIp2IHLT8XlsqV1vRUMyPJ1S+
         Lyyw+rW9M7Z0ZeB6pRl+1wXoPPqzw4YRZW8XA7Ys3G1My1BLk+upZlSWtb27vQgK63XK
         G5Wh3TglW+w0PFobm3haGYMT3yYpto2uEv934cguJamIIwEFP7D1Axgule34BwcZStsF
         hiHCUcwBU2id2GwiA6e9Mttr6rwSWtmNJhLYHRVDMk4GgKpg8w+Jr1UmEwAycNU3JNsn
         fzLylvY09+kULeWvBrDJcGbgayamTZH9ZcMvblJkxA7Xpa/NtBPY6T1O8ByOZy5wvngs
         7pzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686015600; x=1688607600;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNdpCvsbaTZFnN+t5SDVUoqpEurb3IMhTuvtB99l2w4=;
        b=iAWYUgZRFwkmbuC1ngPB0219/q0GjZ40IKlAOkxjIWt9N35PYUzzYCi8uOUoKv1/qe
         XpfuuzKtVRxlIZA5EaAGy7CG2ykvD5vlCTE9xKwVezkvsCaCQT0o3fswsKfAYGn7yp57
         mLyAqhHsPXLV4+iLkPN8+ddtHMiCoYay+sctWKGwsw2s6y8zt5gN7wEJyCVhh5znPbfg
         JlQcSC8upOWW92EqzRgvirzcXMgY0Oifp4bQ4TUw570oU4HWE7BsESh+RA4XMpHl/wvv
         RcW5xYl9IvKHpc4Bap0NTgH1Kr6NVfoTYOo4YX+UvP23zshJ8MR25xAvnzlpYvE0nDk2
         ASBQ==
X-Gm-Message-State: AC+VfDxKUGEe9hcCOwEKkMYhpVU/1A1XX9J1zOA2DS05TnQFNUox+nod
        a2XvNqQQcexydVJfFzHBrg0orA==
X-Google-Smtp-Source: ACHHUZ6wl+9hnqMrLjevEHWZAGXiTPN6g6IZ3OJlClH9gqG7ybkRDCPND7uBcQFbWOlPzR1GEc8wfA==
X-Received: by 2002:a17:90a:1b65:b0:258:de1b:9dcc with SMTP id q92-20020a17090a1b6500b00258de1b9dccmr793267pjq.9.1686015599962;
        Mon, 05 Jun 2023 18:39:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a284600b00247735d1463sm6860817pjf.39.2023.06.05.18.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 18:39:59 -0700 (PDT)
Message-ID: <647e8e6f.170a0220.a4f7b.d063@mx.google.com>
Date:   Mon, 05 Jun 2023 18:39:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc1-8-gd909ae0a8562
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 6 runs,
 4 regressions (v6.4-rc1-8-gd909ae0a8562)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-lib: 6 runs, 4 regressions (v6.4-rc1-8-gd909ae0a85=
62)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-8-gd909ae0a8562/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-8-gd909ae0a8562
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d909ae0a8562b404eb1aa9dae6b2f15c9e163984 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647e7ce9f5ec59d59df5de41

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/647e7ce9f5ec59d5=
9df5de42
        failing since 161 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e7d3da60c129798f5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/647e7d3da60c1297=
98f5de26
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e7f3c51fb84cc26f5de99

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson-=
gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson-=
gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/647e7f3c51fb84cc=
26f5de9a
        failing since 228 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e8138d6459b574af5de85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-8-gd90=
9ae0a8562/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/647e8138d6459b57=
4af5de86
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
