Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29E46FBBD3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 02:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjEIAHK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 May 2023 20:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjEIAHJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 May 2023 20:07:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE2D49D9
        for <linux-kselftest@vger.kernel.org>; Mon,  8 May 2023 17:07:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6435bbedb4fso5609883b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 08 May 2023 17:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683590828; x=1686182828;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iv/3wQ5Rm2hXwyeA06Mys0dZcD/7Gx1c/bCnxWRdPbk=;
        b=KD3u2YIF+e5JwDU+kUICT9dRIMFszt8OV13/ZdTkj3fsz2UJjoiURMvFlACv+sa/S7
         2e84nAirX6WtRXIyLyZ2g6D2jr3353yJVUYD7sHL0AVZpM7uwklZ6FlMjEiCWNEsBZqB
         T29u9Sf5U33a4TqYCWu0Q6LDNOa4kyH3opEwcDhz3OxvL8OFTU77YOCKpPr13m7JTqwj
         yWpD+820LWNFRr3imvokCvQsYhpoLseHbG1LgJPkwSTtHbJY/EGe5QWFyTr1rqJCNarL
         Tn8h2l+nIzegJU1mwi0wncGch8w4sbszIv6lfVJZDjv8pJalC1fjoAomq6Cyc6/1dN33
         K0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590828; x=1686182828;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iv/3wQ5Rm2hXwyeA06Mys0dZcD/7Gx1c/bCnxWRdPbk=;
        b=a1smZXE2j/tQigw/GLF6ndG+NVOLV0P1MMaOnOZP66EKmVlW9Lf+tAE/yxGCUjGj+5
         RBa92rlMW218SF0QBFPhV+gShesQdfImgw0SsD7lgw7MgR2YF0Zl79iWhCKuTmhYigEo
         gp6JZOD57cgVG+UOPn7V0tIIT+PioSi6cGxLXFfAQxllvUL2/MNLEB10mBCOdyIAIOmX
         nkmEwGfLYzx/Om4MPFxe+P2d/AEkFgAuTWuRMHh+EwWCCe1fEYs2dTGjNOhANUL+3zKf
         IJS4Czgmum0S+VxFEFS/tNIV6PXlpKgKNWLApQJvmgTs7iPjwb0RNEmVpNMOHHA+A/Hs
         i03g==
X-Gm-Message-State: AC+VfDzNV1ZiGGgMYKqcs79riYc7faPtky/ft44i9/+9oggdUthuouBZ
        3PIHXBiTbYxR/w8jjrOdkuOt4w==
X-Google-Smtp-Source: ACHHUZ4afV9ZfR3XpPPFztsuOHlLDGiIDEkntnpO3brSenFls0dGF+s1Eb56SqOiK+7C1R5kYcbfYw==
X-Received: by 2002:a05:6a00:c85:b0:646:e18a:a002 with SMTP id a5-20020a056a000c8500b00646e18aa002mr1064129pfv.14.1683590827876;
        Mon, 08 May 2023 17:07:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j19-20020aa783d3000000b006460751222asm530474pfn.38.2023.05.08.17.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:07:07 -0700 (PDT)
Message-ID: <64598eab.a70a0220.8f797.1d45@mx.google.com>
Date:   Mon, 08 May 2023 17:07:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.4-rc1-3-gd7eafa64a158
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-livepatch: 3 runs,
 2 regressions (v6.4-rc1-3-gd7eafa64a158)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-livepatch: 3 runs, 2 regressions (v6.4-rc1-3-gd7e=
afa64a158)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
4-rc1-3-gd7eafa64a158/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.4-rc1-3-gd7eafa64a158
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d7eafa64a158cc9f1d26b3c615d4ada3c17c02ee =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64597d249582b592152e86ad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230421.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/64597d2495=
82b592152e86ae
        failing since 132 days (last pass: linux-kselftest-fixes-6.1-rc3-3-=
g89c1017aac67, first fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645984aa32a3f705092e861b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.4-rc1-3-gd7=
eafa64a158/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230421.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/645984aa32=
a3f705092e861c
        failing since 201 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
