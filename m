Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142B06AF2E4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 19:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjCGS5Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 13:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjCGS5E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 13:57:04 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA78B422B
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 10:44:29 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so12729409pjg.4
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 10:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678214666;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0RS/od+5q8Nju5ARp4oTgKadbwOYlKgIahtMkeovlbQ=;
        b=i2CtUdaqMIe4UfQ50vd2Wc5KwmiY7Rf5NU+Dk6HOqNWjVr7c0Bp89Wd5drKypenvo3
         lwsR9iSSAWxBdLAUCSEyUHs2ZpTVK3lvGGu7g/j54fbaA8ms34FFphFJ5ZtQ8CaiUGhZ
         wkKdFWURZ7fuf3rvTl2ilJuutmkF4rvqxrwRxIXtxoJZCiu0Gs2FkE+SmsuSOguEis1S
         qKrq/dhNQ8fMS1PlkdczGUK91aeN2MtpSO0QEak1W6tO0eKcrr/37YYJMsv8VoDCVuYX
         jELbYfg/Owc70P4q/rMqKMwV4TSdE2mmffVp2aS8WBchOs9lTaXkAdJlj4t494GkuvF1
         IQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214666;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RS/od+5q8Nju5ARp4oTgKadbwOYlKgIahtMkeovlbQ=;
        b=UY2BWelMTsMBaAP8wR7J5cKdxNUoIdFoNPKszkj4RQqP+e4+5pAmiEMd8JOAlecAhK
         Hpa/WyYgVZeJiVYhcUtS5OWh014iXei2dmRA6hJE+7ki6KCfFgJe89drdn6SZXfGz22i
         SbTPxGlf/IAARqHy1mA30487I8+0S7iNh9BWv8pPHrICVudZvsMRK0C6SbTvDBn4oTMt
         O9r/EMJkt67Vw1ZMovcVecrJTq/b+zgGRP78hGXNRd55EZRP7L+cQCZSnwgRJUHpdSne
         Ajru/QuhR7sKQ7WfsYXRzsBv1T99wzcB6IUiwfWFLKGzCupQJqn0V++0dOUbk1uwRjis
         QlSw==
X-Gm-Message-State: AO0yUKUmsC2eYrNnQpU3oF0d7WSBdMGb+S6BdtyvuUXnCt45pSO3AuCq
        jvWia/aftQ4DsaRpABvr/yatfw==
X-Google-Smtp-Source: AK7set9Nkuv+fHjzrvm9FkMZxrKD7WHaCBYEm6T9+mLVk0XUz7Eqm1+T+NstaCPVFe3RmHMn/1Pv3g==
X-Received: by 2002:a17:902:d702:b0:19c:dedd:2ace with SMTP id w2-20020a170902d70200b0019cdedd2acemr13804847ply.18.1678214666753;
        Tue, 07 Mar 2023 10:44:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ks16-20020a170903085000b0019a8530c063sm8675877plb.102.2023.03.07.10.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:44:26 -0800 (PST)
Message-ID: <6407860a.170a0220.6c950.08ac@mx.google.com>
Date:   Tue, 07 Mar 2023 10:44:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-1-g2da789cda462
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lib: 4 runs,
 3 regressions (v6.3-rc1-1-g2da789cda462)
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

kselftest/fixes kselftest-lib: 4 runs, 3 regressions (v6.3-rc1-1-g2da789cda=
462)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
3-rc1-1-g2da789cda462/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.3-rc1-1-g2da789cda462
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2da789cda462bda93679f53ee38f9aa2309d47e8 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6407747d438024499e8c863d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6407747d43802449=
9e8c863e
        failing since 70 days (last pass: linux-kselftest-fixes-6.1-rc3-3-g=
89c1017aac67, first fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/640773ffe0e29234bd8c8638

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/640773ffe0e29234=
bd8c8639
        failing since 140 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64077bb9a3406820a08c8699

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64077bb9a3406820=
a08c869a
        failing since 139 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
