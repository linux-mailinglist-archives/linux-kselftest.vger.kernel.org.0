Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730736E15C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 22:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDMUWa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 16:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDMUW2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 16:22:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A0493CE
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 13:22:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51452556acdso1000120a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681417342; x=1684009342;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h4s4JO6Ru06UTL3WkNefPdigKbB3/MEoUPXmMKiGss8=;
        b=00ATybpI1q59SLkBN+jAKxdh1qg/yBQ2WLCVYfEGmGkub1fRMBiu4sA9vd73oiyz20
         ne0cPFQiBGNP9lekFgdZIP/SgsegzznD9pnYqnobX+gF7d4MFkOH7XUIKl2A5zTHh9KB
         94gJkjKGnbXa86ALKFX4lpTl+3uif8RPHDIpmtBBZyt0vNki/O1YQCRl8Etjjr4Klb1j
         9NSKCLxEqwKPkb/1H/wtS/pXrmTsmMmCe+maLt1mgEVnoD7MUz2cer1BtuOnCHr8eSOu
         Lpx84NA/Z8AMXCk48yc9d3ngupZSPvyPS35pn0EM3JXumYzDmSWsFF+5+jq/p0g2w2wd
         SJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681417342; x=1684009342;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4s4JO6Ru06UTL3WkNefPdigKbB3/MEoUPXmMKiGss8=;
        b=fIXTUu6cqMmFg1IaBh17At+ujbwf8zxjyFz0ywH0rgwljMR+ctsuBEmPrDEtMhw3NN
         i9Ntdlh7MRLO6hS2/xxwV52vlvTM9BPH32RzzxXLkufQyWw4BwzFsY9eJvf66kEGpnkD
         MF1RGi5qqyBrwonk9aRiM3/H5OrjEtNOJoLxbccU/lEIUYkvD4uOZBWsyXFigwqrL6m0
         Ijp2OCDO861GBPFi6Bi1kO/WYoZEJfrb3YC7Ri6UqBNp6B6mfDcTdlKFlE3zgy90ZID7
         2JgaZcWRQat3lZTszfz7WMMe7z2Sa31vANEAkLwcPpoXSUXqqE8D/1OdABRbRgCUiUZA
         rwhw==
X-Gm-Message-State: AAQBX9cva/lOhHLAAgDEjmEWYyYMkx2qK9oPX9kjfE61aEdHsp5wGDlt
        3jv3C77JWUuGP9oNTGHNgC4RANJr+DTsRJfzsvyPrXt2
X-Google-Smtp-Source: AKy350bty8wQSaymwZz/lz+jah/R15tAik++fj060mQcvOwujKSjcS1g5A5Js4YmxXQ1I2bcBvHHog==
X-Received: by 2002:a05:6a00:17a4:b0:62e:43ce:e6ab with SMTP id s36-20020a056a0017a400b0062e43cee6abmr5033543pfg.13.1681417342337;
        Thu, 13 Apr 2023 13:22:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79144000000b0062e0515f020sm1753453pfi.162.2023.04.13.13.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 13:22:21 -0700 (PDT)
Message-ID: <6438647d.a70a0220.277e.4073@mx.google.com>
Date:   Thu, 13 Apr 2023 13:22:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-24-g91db4fd9019a
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 3 runs,
 2 regressions (v6.3-rc1-24-g91db4fd9019a)
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

kselftest/next kselftest-livepatch: 3 runs, 2 regressions (v6.3-rc1-24-g91d=
b4fd9019a)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-24-g91db4fd9019a/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
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
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/643857245f07b6ebbb2e861d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/643857245f=
07b6ebbb2e861e
        failing since 107 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6438563abbae4d04dc2e8616

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6438563abb=
ae4d04dc2e8617
        failing since 177 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
