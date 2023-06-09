Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C5D72A5BB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 23:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjFIV6E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 17:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjFIV6D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 17:58:03 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB430E8
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 14:58:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b01bd7093aso9480775ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686347882; x=1688939882;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X65Q+xT5LBPga+PTy5c8sNk+r1WqG9nDi55vHnqwZoE=;
        b=ubGicfYiUJR5ScV8MSt41o9xTudBeygHaFdYm3JENp6QUefWN3JPj9MLnOpeSAeB52
         5e8sXWzMU1Q4/HFt8qovOm8QNOOcmrxiSEeClN1IiCmthj09jNYn2JBEJzl7CsMNqu3P
         X3uJBpHiD8uFqypeFbQbYc9HsrQIb18r+0BYxt2YOefK5hrrFND9hbFcGzdMg8o1sViU
         nU+NVsN9D00lsnTOUf5XwnpdjbySVF7N0X/p3UMvIzo19z1IyWK46YQUM69KcPB2jWrB
         q0qbmihWVtvMuGTs8X2oISttT4NuS3BHZQcutv6hkQbgQx2BYj0jW8uYdvR7oVRevtfb
         J0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686347882; x=1688939882;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X65Q+xT5LBPga+PTy5c8sNk+r1WqG9nDi55vHnqwZoE=;
        b=HcmhQ4X+6Zjr0EtBF0FQVou6Zu/fQ91U558cmO90uyQJqTqJp+v+RSd5uc7c3Yw5fB
         9HOL2Qt5l8YeEeJoZKiZOC9FocIjOwSeCCwLUq8Tnv6QixwXjE+GnKQl5DLlkf5OJipU
         eaUZh9jzBVTlJFi3IiA0rHCKpp8XteP67iao6xK7eUV23xcYA2/KCMTey3xlB3qoTqHD
         TpbZrOmkuBTDPBF6fnfbUp5hqaCaFkDai32v9rATEHeEniwfkP5EkM2jR4Bjx2XtRrTT
         xdcXu080kvJwBcJeCFc2wyOeUhDiNMFmuMZjw+hW3OsEYztc71GRnhBnMBll/91yRFCg
         ezTw==
X-Gm-Message-State: AC+VfDxPuXLJ+QiilkyncCI2Qw1XPWvXQ1vfwY5Hr407p4WSkr4zVxY+
        eXqoIW77NYRvH5Wba9Nh+RhLqpysEV/z1YK74gb4CQ==
X-Google-Smtp-Source: ACHHUZ5SRSXZ5d3DWjU7rgf4vkmvzlaYzDY9qq1EB+WSJNTeQ9xHfjvw70niXaGyVEy96j6vYMJAwQ==
X-Received: by 2002:a17:902:e809:b0:1b0:5e97:ee2e with SMTP id u9-20020a170902e80900b001b05e97ee2emr91017plg.19.1686347882332;
        Fri, 09 Jun 2023 14:58:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902a5c400b001afa7040a70sm3709919plq.276.2023.06.09.14.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:58:01 -0700 (PDT)
Message-ID: <6483a069.170a0220.9495d.8441@mx.google.com>
Date:   Fri, 09 Jun 2023 14:58:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.4-rc1-9-gd51a218328e0
Subject: kselftest/next kselftest-seccomp: 1 runs,
 1 regressions (v6.4-rc1-9-gd51a218328e0)
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

kselftest/next kselftest-seccomp: 1 runs, 1 regressions (v6.4-rc1-9-gd51a21=
8328e0)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-9-gd51a218328e0/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-9-gd51a218328e0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d51a218328e0be533ca0b10bc29060aaec70432d =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64838ffde577c4f3aa306169

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-gd51=
a218328e0/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-s=
eccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-gd51=
a218328e0/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-s=
eccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64838ffde577=
c4f3aa30616a
        failing since 164 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =20
