Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F382697297
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 01:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjBOAQl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 19:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBOAQh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 19:16:37 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F76301A9
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 16:16:36 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id ja21so11104534plb.13
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 16:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b8EBkAoKrY8FTPgv+dPaGY4y9v6DUm/ik9scZnN4gGs=;
        b=GCOSLxZ6iNADzSIXd0qgr/mFdd3jhloPgnZN0oDAu4IMQwwdvpC2cWgbj840+UZwlO
         fDUHqNy3fx9yUSAYt1xaIlQ1miqYDfrTY+unT11uacJ7ri344G5PXdhsNfy5BJNdWjaS
         v1VAm37qjFwbiVzuZ+LnvYtvBMYPC2bIkvWgrQQcct+j2NahMk3rQ1H4m3C3Qru7//S0
         0kOI/p4acQSTByJmhmMZrHYDd08n5S5hX3xRd0HmRMghvT8dRnZSia1LK9qF7rcV5EFF
         hPHvl8R/2l0LM39zcCwg4D3Bw7VJHegWI0hLjzReEV0WTtR8H396W219jkR5nuv+rfGl
         4VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8EBkAoKrY8FTPgv+dPaGY4y9v6DUm/ik9scZnN4gGs=;
        b=FZrwFdnbXqeo4dkRcmbAu8Ry9EMQrWTrh1x+QDGLGKHfOJuXjans02abkQPXuwCCZF
         VLx/owRbijaTSq80OrFqlHJ6ise2f/0UjZPVSvFtwFhi3D2G1gm5bHRjXPBKnWP4Zc3X
         bK/YbiSUuU5NaUGWrw8jgLqAJt4/AQkx8qnfar/+fsYKLh8GMUgko580TU0DHw+oZl+f
         H4mrAEXWF6IDWOe5j5jEeIO9tzT6KqPcY2t9i6Mx7ERER8LzJ1gx6rurN2KLnZdXwHrt
         ujVIZ1v37B59cMtt4zEB7hWlW2kcPltN8RaUjnai9xpzmd0MEZC4363ymhyN+NQ2ae94
         xQOg==
X-Gm-Message-State: AO0yUKVEmNjwzrNQVX7jRuJdIY/axgHKekm94D3vkPnSrPJbJCw3Icgn
        K9/YU1psaWedaIAuUbToa7V7y7KaT9X6jfwyyWw=
X-Google-Smtp-Source: AK7set/mPruR/tTSVQI3nzqtvg2pHpI6flL0sV55Zr+jUjECsdyH6XbpEVNhdFDofXfn3YYojaZKxQ==
X-Received: by 2002:a17:902:d4ce:b0:19a:6ec0:50c2 with SMTP id o14-20020a170902d4ce00b0019a6ec050c2mr560795plg.26.1676420195750;
        Tue, 14 Feb 2023 16:16:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b0019908d2c85dsm10731036plk.52.2023.02.14.16.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 16:16:35 -0800 (PST)
Message-ID: <63ec2463.170a0220.303d3.4410@mx.google.com>
Date:   Tue, 14 Feb 2023 16:16:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-40-g0eb15a47bf43
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 2 runs,
 2 regressions (v6.2-rc5-40-g0eb15a47bf43)
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

kselftest/next kselftest-livepatch: 2 runs, 2 regressions (v6.2-rc5-40-g0eb=
15a47bf43)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-40-g0eb15a47bf43/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-40-g0eb15a47bf43
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      0eb15a47bf437a268b69ab1a1a45fdf1f609b69f =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63ec0fd6cd2a52c3b58c8640

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63ec0fd6cd=
2a52c3b58c8641
        failing since 49 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63ec14a976b5d50c698c864b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-40-g0e=
b15a47bf43/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63ec14a976=
b5d50c698c864c
        failing since 120 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
