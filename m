Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1094D6B5831
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 05:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCKEhn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 23:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCKEhk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 23:37:40 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7296811FF8E
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 20:37:39 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id a9so7701654plh.11
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 20:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678509458;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PlKUBJ/aWchqdO2CnPd/0Am+rnazDrLiH+cNMLqdf+o=;
        b=kGDKUBQdiFJCYi5tKoAoWaQJVybSVOXmVi1kuD7OKuvZRwGRF1las1yGqAnQpaMn9W
         gt3YtSy5ehYUNn8x23sIldz1nIRJneJmg0SJoFD4IRIvDe7o134e+/ftXwFg3AzpAMxe
         5eD+h9soqWZVjjv58sswtm9l8sNxjO7e4fhqiPDbUXHXiF625nmPrVk7GdwsLiTYbRRJ
         XZRozg0ObREaGp4UlMGeCe2aiEoDNJ5Zp7b3iQzQOTIPYdkFmXGX9yHCMVZXhUZYiT8f
         J4vDY+n/gLn+51Yi/XEuxro3vGh8z66TnJV0BaNnrw8voZku36OSYllPXnl36ua8iLlo
         7u6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678509458;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlKUBJ/aWchqdO2CnPd/0Am+rnazDrLiH+cNMLqdf+o=;
        b=y4gqcgfaBnSgT1IvtMD3s0HeDSxk77MF+oktb6xQLCLSIvs7wRnJnD16+vRfkfGUfW
         kclEwWiN86iFSGOTJMnP8s+bciOFkhm3pPmiORUtoyrSbvSa6adQ2UxktXs5+RriBr28
         J8R18RODm7kKW6DKu3DpU301FE4xh1IPJWWMd3R7ZKssVtsrFpq9NqdWe4jlFIvKwiM+
         12yItMnvLDvfXYtkINAZqFZuSnXH9HlMUWi5a4SoBQgLxeQU70Fpdz6V9OfLlPPDHGqb
         VvqbDpb2TVaHK/jrYIzefang7Tcq/Uvy4KB9Os5QylOH9bwFLu/itFxa/D05SBdicAD2
         n98w==
X-Gm-Message-State: AO0yUKXuqXpt6stlTA4/pMUPe0fbh3iRYrNjpn1jbGj3XaoOfEvyBSK/
        vD4QCgVeSBifydxkI5gxcEXQn6QKpqpUXYYJTYTFpI5g
X-Google-Smtp-Source: AK7set/19afWU4grue7fD5pOxLnMcOQWAuXfs9tcx3PzjkwHXeVvx1OnixnpHbUctZm++hh0a2IYOw==
X-Received: by 2002:a05:6a20:4c1f:b0:cd:80c:677f with SMTP id fm31-20020a056a204c1f00b000cd080c677fmr22146750pzb.31.1678509458129;
        Fri, 10 Mar 2023 20:37:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n18-20020aa78a52000000b005a8a5be96b2sm573240pfa.104.2023.03.10.20.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 20:37:37 -0800 (PST)
Message-ID: <640c0591.a70a0220.15e6c.1bcb@mx.google.com>
Date:   Fri, 10 Mar 2023 20:37:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-2-g624c60f326c6e
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-seccomp: 7 runs,
 3 regressions (v6.3-rc1-2-g624c60f326c6e)
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

kselftest/fixes kselftest-seccomp: 7 runs, 3 regressions (v6.3-rc1-2-g624c6=
0f326c6e)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
3-rc1-2-g624c60f326c6e/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.3-rc1-2-g624c60f326c6e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      624c60f326c6e5a80b008e8a5c7feffe8c27dc72 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/640bf45346638877f48c8631

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-seccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-seccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/640bf4534663=
8877f48c8632
        failing since 74 days (last pass: linux-kselftest-fixes-6.1-rc3-3-g=
89c1017aac67, first fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640bf8a00c77a636768c864a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/640bf8a00c77=
a636768c864b
        failing since 142 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640bf89f0c77a636768c8646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/640bf89f0c77=
a636768c8647
        failing since 142 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
