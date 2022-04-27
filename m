Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65FA511760
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 14:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiD0LyU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 07:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiD0LyT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 07:54:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E0E1F4A1B
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 04:51:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p6so1284910pjm.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 04:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Q/XOBrl12N7vFI/b9u6dHplfKoHTdqnHAutgeCuCw6s=;
        b=uVZ8mg0X6xqOKz2ORHdSPA5K55YYYGWQyvo7IVl3CFxOtwT/cjaJY76D7tYOK7iqpb
         pDlWNSI04mi4i6jN3nnOFMARNactEEDa6Z2zx7jIqjyCDTOzKI8yzemUCzvCi2sCvY0L
         nnKVH8bPTJSjKJUnanvRrUAJnZ9jkJWcdOkgtFF9yVddMapWjaB/4t4gaL2OZPKFmWqz
         5X2Dwwr2iwMBCFr7UaDeXlmDDXoGfQZ7eizJkQMEZXaBkGmD+76XCyb0Hie33Y1XNTrA
         zk7uNEnoosz7Ahdx6Km/wjeCLSMDYt7vr3ZCVzLTXV8ib1VJP7900HE203zfO34lijR7
         iZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Q/XOBrl12N7vFI/b9u6dHplfKoHTdqnHAutgeCuCw6s=;
        b=m1wCsbJUX+/NzjoFWYUZL3Zg1bj20CAD9nP74SRBn4brN+hRfuFmEuwM1f3PN+RTWY
         Tn1lCHKH1v1X+7a9euVe1LraqmOy6xxGR4QL0bhrGEItcvHmzbZMxBBQmHMvVrfAwueT
         lkRj2RUoqfZCwgWdQ/uAuPk8pCEdKH79h/yyp1kA143ghrWp2PV0MPWIKBLpg1N/wdqM
         mXNeAITn+0Qxu2nWH3E8jR6L/kGeBiRZOcGpUGDyI3juMyobuvKnillepw1fN7ZoLhSv
         6ez5BseDDSNNMfWHMVWNtQ2zR6naXXtT94AXFSK4kYGMHHAnbY0cJ2nGeqdZWB08EhsU
         6Gvg==
X-Gm-Message-State: AOAM533xjHLVshb5UFfohtncNUGAjMGhhiyWAGZ//pWR/ORLR54VXNsZ
        SsZ54CLr0sE/JEIlDNcH7nGonP6LpXKGnVE4dMw=
X-Google-Smtp-Source: ABdhPJxTjxu73AekC3s1z+r6a++Oyg6JaR8SLvGKldfJfTf/ICZk1SLPB/uNv+D95JEdYLshvcuPfw==
X-Received: by 2002:a17:902:ba93:b0:157:1905:f4bc with SMTP id k19-20020a170902ba9300b001571905f4bcmr28082870pls.83.1651060266402;
        Wed, 27 Apr 2022 04:51:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b0050583cb0adbsm18116684pff.196.2022.04.27.04.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 04:51:06 -0700 (PDT)
Message-ID: <62692e2a.1c69fb81.9e455.b6a0@mx.google.com>
Date:   Wed, 27 Apr 2022 04:51:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.18-rc3-18-gc7b607fa9325
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next kselftest-lkdtm: 5 runs,
 1 regressions (v5.18-rc3-18-gc7b607fa9325)
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

kselftest/next kselftest-lkdtm: 5 runs, 1 regressions (v5.18-rc3-18-gc7b607=
fa9325)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc3-18-gc7b607fa9325/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc3-18-gc7b607fa9325
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      c7b607fa9325ccc94982774c505176677117689c =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62691eef983b984783ff949c

  Results:     56 PASS, 8 FAIL, 26 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3-18-gc=
7b607fa9325/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3-18-gc=
7b607fa9325/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220422.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_READ_AFTER_FREE_sh: https://kernelci.org/test/cas=
e/id/62691eef983b984783ff94d8
        failing since 21 days (last pass: v5.17-rc5-22-gf6d344cd5fa6, first=
 fail: v5.18-rc1) =

 =20
