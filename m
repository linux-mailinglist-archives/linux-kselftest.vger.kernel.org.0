Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA096E2A96
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 21:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDNTSd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 15:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjDNTSb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 15:18:31 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D49444B2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 12:18:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b6d0b9430so178237a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681499909; x=1684091909;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=trMYr1vNOQwDOknZqmDTW4kYmQcEm0Y4CwXNamUC1YY=;
        b=v3cwY212DvCY65+fKcbjcuhQm7fl+ZyBU/zPU+XKxyZemK0UU5uYHOmFUfOK0cOfty
         ZSIvK7wRCdi5HhpN1l7SKHtzd7TNjfaLUdp1UTPsR3narj+CjnKmaB0TWlE0KiwiL7RL
         SDKCOkXaXMDWtKMxhUtMNNWlozHa1dnhDvYn6jx3DYhCOzwLwvXsn5vO+CWxqBCpd6NE
         yZ8BoKTcI3KxrDF19d1BviqQnuawqBS8cmL3h0bwr2o7tZI0Tdfr5JNDBenbfvH9UxTq
         m3ib5kFuMuv/IuJeEXhpMRZY2IRn1Kx+JLjauHbkAfgyrgpsySZWOTJLeIhIqNsuC++J
         o5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681499909; x=1684091909;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trMYr1vNOQwDOknZqmDTW4kYmQcEm0Y4CwXNamUC1YY=;
        b=XYGirwmu5NVm6/vgw7goEvtts1Oi7YucBqwbrHLsGzhCr+RTdrK3yRVWhKpztSGF2D
         QP0GGfs8loXMSWEJBleU3D+aUWq17i4RCi3eaPLjOU8/BC0UhIfkJONqkdC8d1FMfEFF
         vqYu7XBePBRuewG8fr4oAHTkx5AWf2KncjvoY4N/rhMAt7dCr9kY17oc+j1Ofka7eyZ7
         VgDmA0ekOzHBELeX2P6Kt66tAePNhJ2atI9EtL91ohyxQ4K6o6BfvxvI05HcCeSkCe4x
         XZcBlDaRUc7pT2eQOWJ6azRp8xVsN1/an1X4I/EuLa7rqxRcgO2l8LVUg6uq4GK/u3EW
         mQTQ==
X-Gm-Message-State: AAQBX9dVhGDqP9GXncRaz2pnWvEv1zAvIUYd5MaT2PqlSyFYlJAO2GNm
        JTO1Div3zS2MZD5vsLjSAbUeCA==
X-Google-Smtp-Source: AKy350YicYBKauV8XtiD/oQ62f8C2ZdS6/tRyD7EF3b45spkomBOp0sJx21DMIVljbgjB/Y1xs+PZQ==
X-Received: by 2002:a05:6a00:10d5:b0:624:2e60:f21e with SMTP id d21-20020a056a0010d500b006242e60f21emr8734115pfu.29.1681499908976;
        Fri, 14 Apr 2023 12:18:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s6-20020a62e706000000b0063b6ad9f535sm1394713pfh.8.2023.04.14.12.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 12:18:28 -0700 (PDT)
Message-ID: <6439a704.620a0220.55b44.3872@mx.google.com>
Date:   Fri, 14 Apr 2023 12:18:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-25-g50ad2fb7ec2b
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 2 runs,
 2 regressions (v6.3-rc1-25-g50ad2fb7ec2b)
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

kselftest/next kselftest-livepatch: 2 runs, 2 regressions (v6.3-rc1-25-g50a=
d2fb7ec2b)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-25-g50ad2fb7ec2b/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-25-g50ad2fb7ec2b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      50ad2fb7ec2b18186b8a4fa1c0e00f78b3de5119 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/643994e07f544f46d42e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/643994e07f=
544f46d42e85ea
        failing since 108 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6439997b2d27e84df62e8618

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6439997b2d=
27e84df62e8619
        failing since 178 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
