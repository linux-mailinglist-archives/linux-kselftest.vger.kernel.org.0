Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49E6E15C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 22:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjDMUWb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 16:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjDMUWa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 16:22:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088BD974C
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 13:22:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w11so16849611pjh.5
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681417343; x=1684009343;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PiV9BoKKUTLI8xKE0CUlxFmr+CrgUlQAWaM6QKU5fO4=;
        b=1MQDoD+rsQTftYYsLfHXIhrcDEri/6/KuXORmWfhBeZS2aLTUBaf+FkwR3Sj6O5p92
         aJVzD1I3u/YolLRtY3N6lmEbhsVoiriJW/ia8Sbuo+cHsXKZO39GhdUurFdVQt8kiNz7
         2iG0EiILWY3o72cGru4ZYSuqnP4AEVXQfP6WKmJfWNTA+gxvhmIyyekvN/OaJTJ0HvIg
         cAq65eLFhR2XAXbu4s2iiqsXySrwT5+4Npk4YeArvcI1bahCu/+i+Dc6U6Vh09uieWki
         lkgim1OCHUQNhtuyeHWhzDuVV8b+oq1nPpbWT4+jWrzyVIeh+vn9wHPn6KtX7VtPTJ9+
         dC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681417343; x=1684009343;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiV9BoKKUTLI8xKE0CUlxFmr+CrgUlQAWaM6QKU5fO4=;
        b=RueUbfwe1HYNRvIz8rOE31xl5x9z1erX0UlXL7Y+P2tzRVvS6qcgyk1FnwFTtmjIqg
         EPWay4rnOcE0Cy7QQPmOPwHnbPK7SLRkOK6g5564G2ocWEGgqvUVOvGC6QlEh3aLjKFU
         huPO2gJOKFbnvSW1P6Ey/bHFRR33wQM0Wc0z3FJ5AizC9Tdzda8Xy5Tjgs80wEz7vf+g
         W554ekCfT+ghtLTMzw7eEinyLE6T9qvvHJSpT6WUyl28KitsU5QL7oSbbaIN83v1O6y5
         y6Rlif40oElT1yr1Je0xfRwXnlMbjSU9jDN6YyTKzaA0GimF/SO3W/3BAB4aJNSnVGBQ
         Pl/Q==
X-Gm-Message-State: AAQBX9c3kqjXvdPH0VRbDlphdaMu+Q4bJwB7kcNFhINDdVJXluuyctVB
        WBqWInitniWR80jo2cdecZ21P9F7I0Q5LVbXormHUDjt
X-Google-Smtp-Source: AKy350bV51VtbGU6PVW0J3aVNzVOI0csWyGmTQbmDNQlEmBW1FOxXO6clOEhDtF0MoUpgBar7Dqg7g==
X-Received: by 2002:a17:903:124b:b0:1a5:1a3a:692d with SMTP id u11-20020a170903124b00b001a51a3a692dmr274215plh.22.1681417343394;
        Thu, 13 Apr 2023 13:22:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ij8-20020a170902ab4800b001a514d75d16sm1870348plb.13.2023.04.13.13.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 13:22:22 -0700 (PDT)
Message-ID: <6438647e.170a0220.c4314.4721@mx.google.com>
Date:   Thu, 13 Apr 2023 13:22:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-24-g91db4fd9019a
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 7 runs,
 3 regressions (v6.3-rc1-24-g91db4fd9019a)
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

kselftest/next kselftest-seccomp: 7 runs, 3 regressions (v6.3-rc1-24-g91db4=
fd9019a)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-24-g91db4fd9019a/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-24-g91db4fd9019a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      91db4fd9019a08251a500157cf0d88de457e1a96 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/643856dee1972f3f8a2e85e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
seccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/643856dee197=
2f3f8a2e85e9
        failing since 107 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/643857ca802f1b66b02e860a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/643857ca802f=
1b66b02e860b
        failing since 177 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/643857b8b8462e354d2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-24-g91=
db4fd9019a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/643857b8b846=
2e354d2e85e7
        failing since 177 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
