Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03964612ADB
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 15:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJ3ODF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Oct 2022 10:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3ODE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Oct 2022 10:03:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55488B4A1
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 07:03:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y4so8713800plb.2
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6290cCSZe9NP0vRQ8oVaDKzAeUsJSZPIfU/goxP7W78=;
        b=4OJmutVgQvBREfxa4B2UwYObSqui/As77UEsGUGeWGlqqS1j2HyT69qDLpc70rDDzF
         gR0Uk5L8IEEaED1khYEPyF8AxUt817aotlxmuNVJO8LwJPc/rvZBIACi9z2X3Q7AJ51a
         7ZQEwd200KZvQ5nfOc+A4FEIEWKOhCdG+Pz6UsC7ov8qkonOwYXAq+MWzuG01DlgwP/2
         rJy4xjcjMUVX0cSHq3cDmuNMkwAmt29b2Ly3jd3fGjVsI1elUlIlSRsnkQRFyetY3FST
         E+CcQ0NIw2T5h6v5q/V0oXMHEhrLZeIcnbwIS4KTwRyxH3GZyGnET80JWNTb+dBb1HbA
         5/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6290cCSZe9NP0vRQ8oVaDKzAeUsJSZPIfU/goxP7W78=;
        b=mXItauRWeB5w1DmRvc645WeWazGF3HhsAYANmhhmZaSXL9+HulvVmNyicTyYPCKnov
         DYzYL8RXecduDtamOH6dq1ML/kR3RqjW99RrQ4PZx+luEWsmUiKCH9EhGijFS+kXaJNO
         Mn+SR9vZFuT9xrewfKIe+PuYss0LPeXr+3NlYnD7xKyONZWJZH/g05nkF627KAr45rya
         F/6DeDLGNdMfIKGr+yC7CWJLoaD2bHpVYzKihuaY78yA7yVryDahh6zvGqCMlOyJV2Sl
         mrZ9l8NnQnrPu0t1HU+dl/31sPaN2LxW8pZIToAxxVJg90X1qW0AjcwQdEWqO3p2jVXq
         e1yQ==
X-Gm-Message-State: ACrzQf1KChehpb9Tmw0vLBnIIJ5BKDPsMhh8PjVT30fh4J3HZ/Ouzs/b
        0fqVjv6f0PrZEdWo0Mo5TP+zhQ==
X-Google-Smtp-Source: AMsMyM7d+0NVOh49OwW6kYuVxcxDkjF7pkyh+9pKaKFCuG742jj/P533sEUX5RHJaZu4xTN/i4NUjw==
X-Received: by 2002:a17:90a:1042:b0:213:9d9c:c800 with SMTP id y2-20020a17090a104200b002139d9cc800mr11465673pjd.53.1667138583873;
        Sun, 30 Oct 2022 07:03:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ft10-20020a17090b0f8a00b00210c84b8ae5sm2434430pjb.35.2022.10.30.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 07:03:03 -0700 (PDT)
Message-ID: <635e8417.170a0220.4093f.39e2@mx.google.com>
Date:   Sun, 30 Oct 2022 07:03:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-livepatch: 2 runs,
 1 regressions (linux-kselftest-fixes-6.1-rc3-2-g3d982441308e)
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

kselftest/fixes kselftest-livepatch: 2 runs, 1 regressions (linux-kselftest=
-fixes-6.1-rc3-2-g3d982441308e)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.1-rc3-2-g3d982441308e/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      3d982441308ebdf713771c8a85c23d9b8b66b4d4 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635e71fd99da6ea408e7db50

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/635e71fd99=
da6ea408e7db51
        failing since 11 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
