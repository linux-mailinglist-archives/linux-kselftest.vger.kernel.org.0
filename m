Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6718F7D0F90
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 14:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377209AbjJTMU5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 08:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377028AbjJTMUz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 08:20:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9AAD49
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 05:20:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9b7c234a7so5966185ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 05:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697804453; x=1698409253; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r7YqiNcRaNkc1cr+WAUvCLbT2Pv+7qBnSP4iPYLsctg=;
        b=RKY+cYSTrv/6uj+ibavBKiudEwNA1p9GTApodQCmyTJKcPP/W7zBF9Yefx2LzNnalt
         j/JD0u/T6jM1WQkAsDvHc6jSdjEDYVQJF79A1XqYAq8oGox3YDUQvosCKv12wch/duGR
         2CQzpZaiargTY3hMxJfg0vMpKpk+hyLBZt8digursyAZicUJ2DwRiuLTb0wuc5cKp59/
         7rJxCPncJbejgAIOXphfXw6wn0BmCTJ3jSxRMfnSQM1h/c/LACpKpbiRuItmyepc46nw
         3ufw8Ro3WJVlOeB20Pr8IxuQBHxb0/4WAlA1Ze2m7wn4FKReh2PEABy6bK0H19pyJckc
         FFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697804453; x=1698409253;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7YqiNcRaNkc1cr+WAUvCLbT2Pv+7qBnSP4iPYLsctg=;
        b=CPlSEm+dSWSglX7eCRfeGX3ooIx7/+Qz/H4XN+2cIsfkytWbCZ09IW+itcJ1pP6Gkv
         08BMrg+L85liUm9h1DBq+oBtNSuDC0NIAn2JQVaq32eXGlKmZujf7XUvwi2MP8d0l9RP
         w7Yfhs+TGPZKuBBwx3xZK7Z+Giux97z8kDhqUJHUfOFwNMrJLrieDWTutofBQklSwQQU
         FqQJbKanBfTI+oWuqJYAn8iiGC97vANuMj4CvmHf5rTryXTbxAoKTijuhJgkhkSCrk8P
         of860qFWJZZf9erajcI1u20wYkrjJl/boADyK2A5uUis4q+toUM0wFI0+GCbcLcc/IJE
         v1yQ==
X-Gm-Message-State: AOJu0YyBYVKOopiPHjq9FpM/edflbtw7wb5pm9LODAcGfHNFQbC+s3cQ
        cfGJbw/Xm1Eed/RBd28OxS4I3XTmocL/gwYfyhgtyw==
X-Google-Smtp-Source: AGHT+IE0SkDyzGnZs84i1XrDx9445Gb9H1hILmt7L3ghjqzS53RpUcglqVy8/HQMr5sDZXHfw4gOAA==
X-Received: by 2002:a17:903:41cc:b0:1ca:89c7:c7a1 with SMTP id u12-20020a17090341cc00b001ca89c7c7a1mr2446671ple.65.1697804453090;
        Fri, 20 Oct 2023 05:20:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001c9cc885022sm1398362plb.259.2023.10.20.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:20:48 -0700 (PDT)
Message-ID: <653270a0.170a0220.e3b88.46dd@mx.google.com>
Date:   Fri, 20 Oct 2023 05:20:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-lkdtm: 3 runs,
 2 regressions (linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-lkdtm: 3 runs, 2 regressions (linux-kselftest-fix=
es-6.6-rc5-1-gcf5a103c98a6)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      cf5a103c98a6fb9ee3164334cb5502df6360749b =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532641b6c819f477defcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6532641b6c819f=
477defcef4
        failing since 366 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65326431bf8eaf4028efcefa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65326431bf8eaf=
4028efcefb
        failing since 366 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
