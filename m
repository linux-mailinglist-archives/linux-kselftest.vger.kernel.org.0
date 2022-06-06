Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB7653F15F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jun 2022 23:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiFFVHF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jun 2022 17:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiFFVGw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jun 2022 17:06:52 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DD939C3
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jun 2022 14:00:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 123so3564676pgb.5
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jun 2022 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=OV8GBxDTDbZWCaGTqHq8bMm+iic1FmTCgJmt4NWRfhY=;
        b=td2l6GbINmXvBKYH1Yp34tBcTDPmhuCL08kvXOXyIb/WtWF9cOKu7BwJcBHF1CQOja
         A2Z+V+WPKlGLxSgGlS6BBPeGr4ngaSHOTDn9EHdvSFKp0V5Y7rR4O+bUvoNMcfJPSfY8
         QdEe/Js1/HKlRXODuMDnrCtjkq3cLWAmXOou9TAUn/OJCldWWS1oPTejA0ifiK/d+qmW
         jG3LX7I7f/2OBeO4T4dj/aX0HawFV6m7oDhXPonu04pky85Clm7SjQC3Tm9qH7koWWLh
         bQ59lIkCb0WH7zMbUtQgptKJzN5hlk3mY07y/bsuuDB1hZ/8ch1g2qcQVNncjeXRnuDG
         x/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=OV8GBxDTDbZWCaGTqHq8bMm+iic1FmTCgJmt4NWRfhY=;
        b=kqtDC/eYKcCwty1OCDk8vzblkPvxX4uvCgKPNdzSBm27XfiUFDuxn9YtbOP9KETknD
         lq22hnl2z0xE6Ebk3aPnffSV2gXWCwkEfk53L7SP2Nqwj/yuVXuG9wo4lc9YiaXRylE8
         IitKS4eaPDSmpshnVKmMKz9f8zuftmZp7egEtZLcgQO+mNVXzeXkIIkNAg5I8Y72dat4
         bmEZWzohNEgqq0OmvbFN2AwgBupQn0xfc3wbPLDc9JMzxxE7zlG8H42GoiuBKbnL1lH7
         WsZWBC1w9qHrzTUYyuzXiikfQSr2qfrPfI59VFaxKEwoiLF+Ps06afTXVh1HZi48YYbo
         GV7w==
X-Gm-Message-State: AOAM532dVXtSPVZ327UJfJdyDFqV+Mydi0SHVRpVGqWewYc6kgqOcjqf
        Svzq3/kZoO3jrQ8uGAjmJg/BTw==
X-Google-Smtp-Source: ABdhPJyRb/01RODZtm+fKZq1SHfcN15QRs3Ab9vVHMlPv3Dkr3M3fNPu8UXNczKqRzC3uf5LI8sdcg==
X-Received: by 2002:a63:6904:0:b0:3c6:5a3c:64bd with SMTP id e4-20020a636904000000b003c65a3c64bdmr22675973pgc.371.1654549244498;
        Mon, 06 Jun 2022 14:00:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n19-20020a170903405300b00163f35bd8f5sm10789087pla.289.2022.06.06.14.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:00:40 -0700 (PDT)
Message-ID: <629e6af8.1c69fb81.d50d.8b95@mx.google.com>
Date:   Mon, 06 Jun 2022 14:00:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc1
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 5 runs, 1 regressions (v5.19-rc1)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-lkdtm: 5 runs, 1 regressions (v5.19-rc1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-14 | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
9-rc1/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v5.19-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f2906aa863381afb0015a9eb7fefad885d4e5a56 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-14 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/629e5f5cf23ab74506a39be8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-14 (Debian clang version 14.0.5-++20220603023205+576e5=
b39ae4d-1~exp1~20220603143239.145)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.19-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/clang-14/lab-collabora/kselftest-lkdt=
m-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.19-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/clang-14/lab-collabora/kselftest-lkdt=
m-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220603.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/629e5f5cf23ab7=
4506a39be9
        new failure (last pass: v5.18-rc3-19-g15477b31db104) =

 =20
