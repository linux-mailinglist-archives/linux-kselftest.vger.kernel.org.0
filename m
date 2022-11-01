Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A29614872
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 12:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiKALXd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 07:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiKALX1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 07:23:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D459D6B
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 04:23:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso12658993pjc.2
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Nov 2022 04:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rIbQNtyyQOJX1srAropNgSmHdsiSbq6eH+eyv5jqL88=;
        b=Uftwp/4ar40Ah9FSZsBtbbTf6waj3oQ4j8YqLNZndbFggInsw1BDYgQ9sztCLEwJry
         hlNncHvPjtZkOcvNAPjuOSRZTKWrnbH40UXUSQbkrSTlP8jnB9ZGLKCBUl85P+FwSaIy
         37pReypOIfQ4pSFRtFljPCu0orqKWYzciZdlnhxAmD5zHl/wASuEaCU364hRvrJrlAOB
         omsqG15fL2QPEDbu2cs4+/xGZnMMMXwFJ4a1hqK51aSh5hAZ8Nfq7siobJcueywJ0H2H
         qMZaNJIIYAM+eOCi4JD/CXaUEWvKvqM2226TOGjfdhW9rqcZUlMqrJxFczULlWRDZrsH
         N0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIbQNtyyQOJX1srAropNgSmHdsiSbq6eH+eyv5jqL88=;
        b=upBO2NTUAa26BuWabhrHVGVqiF96mHkcBCN/QQUQmOqQ5MLmbpwe6C74NWYzF4oWwu
         HjdolbaW/ap5E9ZADEAznZRtzAwbt80Ot83QCkpsWQm1kyd8EROvxvCHBbCT9HCrgZzQ
         +yZrfAGNv6D7lMhScy5x8khHaPGSqmLAHYgoBri13Haj5x+HhETvtIUUAMEltTY20CmR
         5NlTI59vkeLjzQYiLiuDH5Fp+PyVNU7OGvsZXr/FYfxWpsw54ldLCqxxgNnFae6jwQGy
         dVvd9829iD0lbtogjZpUW1LKhpX1RKqiIgtxUfwryz6OU5F5kwHMt6PBYLmSLmyl/MMC
         3nhw==
X-Gm-Message-State: ACrzQf0FiVnny2OHtF6qukJ14qI52EqkU5IsDwl69q3ZWELktptdfMVV
        hIoxPc0vggXOibLlt9Ew9pdurex/QAfb3VB7
X-Google-Smtp-Source: AMsMyM4oBwZ7miEhg3c/JhkRByaFXG5LiTWvkEfNRyM+IU+tVYIK2rDmZfBQpkoSXAwo/eTgBiFgrQ==
X-Received: by 2002:a17:902:d510:b0:17f:8642:7cb9 with SMTP id b16-20020a170902d51000b0017f86427cb9mr112620plg.174.1667301804846;
        Tue, 01 Nov 2022 04:23:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bb1-20020a17090b008100b00210125b789dsm5717957pjb.54.2022.11.01.04.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:23:24 -0700 (PDT)
Message-ID: <636101ac.170a0220.3537d.9ac8@mx.google.com>
Date:   Tue, 01 Nov 2022 04:23:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-13-g67c0b2b52916
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 3 regressions (v6.1-rc1-13-g67c0b2b52916)
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

kselftest/next kselftest-lkdtm: 3 runs, 3 regressions (v6.1-rc1-13-g67c0b2b=
52916)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-13-g67c0b2b52916/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-13-g67c0b2b52916
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      67c0b2b5291656cbcb15371f835f5152fae2f7a2 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6360eef8202500781ce7db71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6360eef8202500=
781ce7db72
        failing since 70 days (last pass: v6.0-rc1-1-gf1227dc7d0411, first =
fail: linux-kselftest-next-6.0-rc2-1-gab7039dbcc61) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6360f47da321c51b1ae7dbde

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6360f47da321c5=
1b1ae7dbdf
        failing since 14 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6360f38637744a5bb2e7db4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6360f38637744a=
5bb2e7db4f
        failing since 14 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
