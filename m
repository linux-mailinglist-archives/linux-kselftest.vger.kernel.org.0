Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A567C9151
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Oct 2023 01:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJMXYc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 19:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjJMXYb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 19:24:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD04BB
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 16:24:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5aa7fdd1420so862045a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 16:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697239470; x=1697844270; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FlFSF9HUvpKBkhZVLjAS5gDB3+r74h/6/4Z+YYMmqEk=;
        b=Gftn5plA4/uYMyBJ78E2oV9ZiFdHvctk8xL9xdK+UY3WEj7Xl5dcEnGSijJPLfd7kr
         tYdHmP3hrn14ky4PekNiD5Rbd9kopm9cHCiGlc7h+Nab0dQuO/kX6Wh/qVSu7xB7R+3b
         Wo8rnF1nKCt8qlPDzGMi2Ry3MdyN18DvzjV3d6EUyEWypFxDCnvWv4x8MQyvVsOQ/v7X
         I6e7kcO241mXnQrNlN5n5TJqKc4dWvKu3+zxqquM41NcHdYzlULM3Vt7mX0aJ8OBldPE
         11zTPbiGV1VOM6dl6xY1o1dxU6yNqMCK6scU1XCoel5HXXjeGfe7JJpEfv2VOxfxfyDH
         sdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697239470; x=1697844270;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlFSF9HUvpKBkhZVLjAS5gDB3+r74h/6/4Z+YYMmqEk=;
        b=egn1uLd2/XOCZMg3b2s/8LKaMdkDbKu6GR72ap+XSKuLu/l6Hx2GUpAyDd6QJeh8S+
         Y0K9b10rLOwi2WkQDmMA04BH1Jqb6iNWVhQZCzhOvdEKAHdJTDlcZHlaMky5PxrJZrev
         xIPug8y7c0Bb9ZZoDn+iiFSp3DUigkvrFuyQy8iXE/siit/vg1dhuRY26obTXog3Pfpm
         j+hNdeZObFvHUKD6hLgN9WY15yvI03cJXOwGzQV5eQ+Ho/DTXhpOqapfNeJVAQS6jNo+
         wiktE1nOr6J7quyEHYWi/ISHb1SIo9lFAu50QjxzKyj99aI4p6VTL9TS0YcDHF+hIRkm
         JIEQ==
X-Gm-Message-State: AOJu0Yz0kKOs7vddAlbzJpinW7LZ1dcjeTU3tYK3UIKCiRHb4ZK8et9L
        CdakzyG1Cog3+G/QFZJ4AWcXTXEj5Jd6Lmac/J4u+w==
X-Google-Smtp-Source: AGHT+IGPVGlEpAQMhqxCyZot10aufVIvdu0mndNX05EhwaFUVk4Is2Yf/ldAM6g2vr9RcuXCyPUXcA==
X-Received: by 2002:a05:6a20:da9c:b0:16c:b60c:953c with SMTP id iy28-20020a056a20da9c00b0016cb60c953cmr23896804pzb.58.1697239469782;
        Fri, 13 Oct 2023 16:24:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b001c76fcccee8sm4362271plg.156.2023.10.13.16.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:24:26 -0700 (PDT)
Message-ID: <6529d1aa.170a0220.c8af.effc@mx.google.com>
Date:   Fri, 13 Oct 2023 16:24:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-43-g508934b5d15ab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 3 runs,
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

kselftest/next kselftest-lib: 3 runs, 3 regressions (v6.6-rc2-43-g508934b5d=
15ab)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-43-g508934b5d15ab/plan/kselftest-lib/

  Test:     kselftest-lib
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
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6529c4fc47f34109d7efcef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6529c4fc47f34109=
d7efcef8
        failing since 360 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6529c80d454a5673d8efcf13

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meso=
n-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meso=
n-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6529c80d454a5673=
d8efcf14
        failing since 358 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6529c539cf3108f307efcf05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6529c539cf3108f3=
07efcf06
        failing since 360 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
