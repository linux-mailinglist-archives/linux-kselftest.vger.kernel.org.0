Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFE682CEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 13:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjAaMsQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 07:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjAaMsP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 07:48:15 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4677635277
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 04:48:14 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e8-20020a17090a9a8800b0022c387f0f93so13848535pjp.3
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 04:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vN8hfF0qn/Dzfs0jdfG/jw4wF2gOo9kRCdTZJSP7AsI=;
        b=GOYyWheuY0zakQuy+gTw+09iN4CwN2VIVG9uNSla38ZUcpiYLNneWgeBx+BN5L72PK
         ArHfJC4SykmcwOwnSZBpdfPu0K35dErz/ts6a/DTVDzj5mYnMQ4CiD5McxluSiKKv8Lq
         uclTQeUsId3gbl5WZC0ietJh32XO0lR40Z9q7nsQfK49nJ3rskVVpU2Q/fPng16g2eIO
         fZ1hT7f4MzrvprArquc8aixqmdWAW87fCPjjZykrYLYd71K/cr23sVoU73f9n++XoTB5
         QKmyiTbpl4ddxqETE6CgwzoRU3hyntweFSKRzBWQ+rUV43xE0V2Xf96G4xW2Q/RDQzjZ
         IA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vN8hfF0qn/Dzfs0jdfG/jw4wF2gOo9kRCdTZJSP7AsI=;
        b=1wVLRyR4yaquE0SOv4yUe80gPFz6ORDDn7M+1aoaKWQ8lNfGMmjGDuSHkYdrTcsl4P
         8XAAKWZf9LRbw9cXJB5GtsdjrMUD2+tbjrDSKzeaBL02xa443AqQTxP2w7n7g+Y/VX5z
         kuMOoMGsiA5urEX7DWCLuvJy7slpJZimJ1qrBKl8RnqKTm2AiZV4vB0Xa0L8Q5I/YmTw
         w9+GuDwTtlb9SO8AtCJF2nXH/lRCnDt4mO5F9VkvqO9o+Jb5HnwxrMvMmRmUveqG1ooK
         rrCJ0Odml1iKUG+LsTtLfT3n9/TnTnFmhcI+J7KFviumY57V8LJ6TDU4zcRFWrIBwMMJ
         49ww==
X-Gm-Message-State: AO0yUKUCHqHPFy5jwB5uKR49MUKsbG6D/F2y68DmcrVPWPPcfjXAjaTH
        0IyWfAPNsKB7Ju0jGql+15SUbnVMqeRk3ThKn7Lf4Q==
X-Google-Smtp-Source: AK7set9FHSZTt7tukCc+iXPdazS/r7M/2ganowUp+cCLmKWhCqw6Q6TlkUC5MbRM0ZdQSfoAaCBdyw==
X-Received: by 2002:a17:902:e881:b0:197:8e66:6335 with SMTP id w1-20020a170902e88100b001978e666335mr5605245plg.20.1675169293792;
        Tue, 31 Jan 2023 04:48:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001960e64fc24sm9664136plg.119.2023.01.31.04.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:48:13 -0800 (PST)
Message-ID: <63d90e0d.170a0220.72fe5.0157@mx.google.com>
Date:   Tue, 31 Jan 2023 04:48:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-31-gc837391e4499
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 3 runs,
 3 regressions (v6.2-rc5-31-gc837391e4499)
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

kselftest/next kselftest-lib: 3 runs, 3 regressions (v6.2-rc5-31-gc837391e4=
499)

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

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-31-gc837391e4499/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-31-gc837391e4499
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      c837391e449979b550a9aabfcc253d245b5436a1 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63d8fd397d91a87731915ec0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63d8fd397d91a877=
31915ec1
        failing since 35 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d901259152a956d4915f21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63d901259152a956=
d4915f22
        failing since 105 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90232334c490530915f00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63d90232334c4905=
30915f01
        failing since 105 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
