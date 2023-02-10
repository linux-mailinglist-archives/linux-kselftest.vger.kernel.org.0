Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7A691712
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 04:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjBJDRB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 22:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjBJDQ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 22:16:58 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179EE1C7CE
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Feb 2023 19:16:57 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v23so5165255plo.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Feb 2023 19:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PA5aLSo5Rec+iwcXxZ/x9pp5HtXrv9H9oYO88vTNWaw=;
        b=YuNu2GqWugKRnttmxIrW/qwm9Yvu6dI8JpmXKuee1B1y9ofpPM8iE0VO4h5rY+MTrW
         dBCzmR60Daj9oKEA+NBeLmX7FBBDjEb53X8JS/+oJ52lfh5yqRSClQPRtNeH476tew9j
         cwkRz8e7qZs3U8xIgOIildWdj46mK0n77mm7Ul3n1ZtaBtS7lIlVNIwNvPSm4mT/CieA
         NBeB7vCMLx31EwncL+zV4a255mnYW4Djrh/j8SNZCQqoDBqSXuFghcoDzLWW8g0WgcHA
         w2LoYhrQs3/Dg1lWbx6evpjwfquId1Fdmaq6Gfgyan2AfdfgCp4vztzgkxBYtgNOs39U
         PLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PA5aLSo5Rec+iwcXxZ/x9pp5HtXrv9H9oYO88vTNWaw=;
        b=ZW2fEAOZ0Mewy2L73demUOIN/P82sYUe8966yt3IBYKqBNVoBjawozC0D9NK+ualue
         TfEoYXVFF94oX7clPALrWyKLPgwdnYBFbUc078oeukmPIozoiLgI7+FZloqLxmzicz6e
         9wuvxL9QNGZYJaTcK3PH2KQ+3/rg/Aa72XeAy464IkIZmR0gQ6KPtkLiNg3xN6VMaigR
         n/aPa39uNqWJP8p+ONVJLSUYjMLDZoDF7E18rF1ioRDcKRywQ6f+EXYpqKFS1WkpYPNH
         elprYZkSonvtVkfEbvtZnSkth5gL5BOilPeh9Ob7pxMhLXNaR9HXmwY5XS0MBecorigf
         8g5A==
X-Gm-Message-State: AO0yUKVFyutC5nSe+iHZFYdgwNBeLOK+h7PqmNe+P5I3m32oN5KjbQ89
        Og4E6qxtCumtS6Iwr8WgOaoMdw==
X-Google-Smtp-Source: AK7set/p10V4CucydK58f5zU3fso6J6yXvN0Crb+A940zWLwXxBj7q739VYZPASvXwbRbn7ULvx6fA==
X-Received: by 2002:a17:902:c70a:b0:199:49fc:610d with SMTP id p10-20020a170902c70a00b0019949fc610dmr6337003plp.15.1675999016625;
        Thu, 09 Feb 2023 19:16:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902ed9200b0019904abc93dsm2227584plj.250.2023.02.09.19.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 19:16:55 -0800 (PST)
Message-ID: <63e5b727.170a0220.ec177.40af@mx.google.com>
Date:   Thu, 09 Feb 2023 19:16:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-36-g4c853ca1cf79
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 3 regressions (v6.2-rc5-36-g4c853ca1cf79)
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

kselftest/next kselftest-lkdtm: 3 runs, 3 regressions (v6.2-rc5-36-g4c853ca=
1cf79)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-36-g4c853ca1cf79/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-36-g4c853ca1cf79
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4c853ca1cf798f1d74a7bd9e3a0541a3ae8ae77e =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63e5a68fce592798a08c86ab

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63e5a68fce5927=
98a08c86ac
        failing since 71 days (last pass: v6.1-rc1-23-g00dd59519141, first =
fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e5a62952fa8226d58c8635

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63e5a62952fa82=
26d58c8636
        failing since 115 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e5a62552fa8226d58c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63e5a62552fa82=
26d58c8630
        failing since 115 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
