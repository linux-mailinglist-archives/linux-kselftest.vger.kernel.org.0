Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75B67DCD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 05:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjA0Eae (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 23:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjA0Ead (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 23:30:33 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006DE3646C
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 20:30:31 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n2so2522151pfo.3
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 20:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zUCyokH1bfio9iPK8cA8BrxhaPx+rjlTix4uK/BIJa4=;
        b=ps9ytFThGxLRp1Br29f3HxZnOpDdfEVltqmuGoKXPO9H8Mj1XHebgRJWH2Bk/U2ItZ
         USKzwBZ674ue0yBK7gp/uRt3LO8CDu/8Pl6EG1qyz4+jgKPpDQpV6vbS2KK2HW6FcwCr
         7MvLu6eBHo+5ex+A/f+zl0ngnw3B34waub+8+/LmIvZZvU/MyMyjE4c8NKrAs7UPKE8+
         1+uFlk0luq9t3HApVVFbWu4ftSZtHltYBPv+W0PkqCyH4LVk8/wD820fHiCEZQlp3ovy
         I/3Dp6rO2DRVlztluKnuN/dUTqQm0JpmAFPDf1teCzsRCfzJTfm7XPINGxttW4iUom0/
         M0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUCyokH1bfio9iPK8cA8BrxhaPx+rjlTix4uK/BIJa4=;
        b=CMV8BrzqNfLSDOGB9ArOOdco6pRkFMXJZPOS4nQw65PIJ+B6+iFmqp+yec2791lBDd
         kXHMplbsjMKS86/aIYzHF5viVM4rKAPjs1uwzOh7u6hkWK1gachQ9DGXTzRKzBiVb0h4
         09lfXPgO0M3JW/nmIEDJJz03731MAFM9IcOMw6TLv/Zn0aLAY70gUNKZaOi++JSqyX6w
         fHSBKqAJF3XOGJW/cMRuPsNHm6JQnMIqIhLHXEsl/O/vinXxy8DaPxB9bcKtF9lUABck
         sg6xt9x5VdE11k575VrZu8vH0Ic6MqfQLB8ZhngYH5Qw4yoeUcAkGnpdX4MEInr8NgDQ
         ilXw==
X-Gm-Message-State: AFqh2kqYK+mL3Bj3aPzevaWGieI9WFEqTHu1/HDiQgpiIRDFhQYVUcal
        RGEvMALgzvCcOM4/kIvzrtZK0zWlZ/lRUyhCzyU=
X-Google-Smtp-Source: AMrXdXsESXXP/7GtNc42+G4SRqGWQLHbiE6FeDvjkMN+dhwXfwceMcUvHYok9QksmFUVwPtctYDJag==
X-Received: by 2002:a05:6a00:1d23:b0:58d:a91d:e9f8 with SMTP id a35-20020a056a001d2300b0058da91de9f8mr31961605pfx.18.1674793831418;
        Thu, 26 Jan 2023 20:30:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z22-20020a62d116000000b0058134d2df41sm1661695pfg.146.2023.01.26.20.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 20:30:30 -0800 (PST)
Message-ID: <63d35366.620a0220.27dfc.3197@mx.google.com>
Date:   Thu, 26 Jan 2023 20:30:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-1-g65177e47d303
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 3 regressions (v6.2-rc5-1-g65177e47d303)
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

kselftest/next kselftest-lkdtm: 3 runs, 3 regressions (v6.2-rc5-1-g65177e47=
d303)

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
-rc5-1-g65177e47d303/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-1-g65177e47d303
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      65177e47d3035c083cff034ffbfc7ab750a4675c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63d342168aa6b38f82915f75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63d342168aa6b3=
8f82915f76
        failing since 57 days (last pass: v6.1-rc1-23-g00dd59519141, first =
fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d345be0cc74f4cee915ebc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63d345be0cc74f=
4cee915ebd
        failing since 101 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d345bcf7aafbea0d915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63d345bcf7aafb=
ea0d915eba
        failing since 101 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
