Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86669610E52
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJ1KX0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 06:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJ1KXY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 06:23:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7BF1CB52D
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 03:23:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so4088489pjd.4
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 03:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zVCfcliMQw/H5OwWPDg1X12zGndCNKpw6Q14dZAlQLA=;
        b=V0uYhPcAfbjWPj8NM15QLCerXvSu+EYc8gTQUcvHpTZCu3vNd6YOs3K7lbx7WLs8qi
         nOm6WUOxIAg8sYYCs8JOA3bClaG1kJqse8IRrYljD1aZBEPAWqSim4nYnxbqT4/ULMke
         r/1+sRJ2ZMd4zx8zY+PnVTWoR+EJX9G/SFjmyNSpbWCXT0cRE/wTcGkRoD7aEQxcirxz
         RVCMPTdePubIv/ISQV5lkagYVMu0bAJ/OXnos4eN7lIq1yuUZHG0PW7j+jMK4nhZeoql
         fpvTSWUF1zY7IlUVmnKCORImhgmz5IXoWevdxHoka0SwgSp/EPzGFX378bXCSttE2Kwr
         s+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVCfcliMQw/H5OwWPDg1X12zGndCNKpw6Q14dZAlQLA=;
        b=XkBcNrCP97Pf96pc/SZeCkeADWTSPnWZH9RGe3uGQDnrkrKqnT9v1ataCJ6H0qHf0L
         xdPjEtgRTwuJRcjsFoMEcTfdQ82aj86clryWgD1RwSSOMtR22a5vreCTIlnTqfSoUOFg
         jlpUojV7wD4MssR+XFWjk2FNLw2MAEIkopp8+KATmUI6yIGaCCq+iSYotaal71nS3K3o
         sKamOEtnLSSrLgFWLxnoTj+kuehVs8EHU2d8TSOjWtcrJokn4l+XwGBvF6IyVZkKZTnJ
         6XCgi3cbQ1i0l2BOOZ+oUdIUYWG9MPuA5LhNci2kCDVw6Y3uuvdz6hOwpAOfDS2Qn1sM
         Qa0A==
X-Gm-Message-State: ACrzQf0DoKMWKOcBdhsa27KXuQ46mtG7qq2ibkHNOeC66yu8X2cC5saK
        4z+p3J9FUpFTbQP/W5m9sTglA+u/IDL4CN/n
X-Google-Smtp-Source: AMsMyM6xd+UPwHmRDrdo8TwHltuSpVuGXx2q5ygV8YIogi7JtKkGuKvEKPTcchY8mDPooQ3MBFnkBQ==
X-Received: by 2002:a17:90a:c592:b0:213:9c65:b78f with SMTP id l18-20020a17090ac59200b002139c65b78fmr61048pjt.14.1666952603210;
        Fri, 28 Oct 2022 03:23:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001869f2120a6sm2761628plg.108.2022.10.28.03.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:23:22 -0700 (PDT)
Message-ID: <635bad9a.170a0220.b90b2.59c6@mx.google.com>
Date:   Fri, 28 Oct 2022 03:23:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-8-g94fea664ae4ee
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 2 runs,
 1 regressions (v6.1-rc1-8-g94fea664ae4ee)
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

kselftest/next kselftest-livepatch: 2 runs, 1 regressions (v6.1-rc1-8-g94fe=
a664ae4ee)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-8-g94fea664ae4ee/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-8-g94fea664ae4ee
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      94fea664ae4eea69e90abb4bd01997b9c54cd013 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635b9b948516a5368be7db5d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-8-g94f=
ea664ae4ee/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-8-g94f=
ea664ae4ee/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/635b9b9485=
16a5368be7db5e
        failing since 10 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
