Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC527D0F8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 14:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377332AbjJTMUz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 08:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377209AbjJTMUy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 08:20:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5ADD41
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 05:20:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27cfb8bc7eeso615990a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697804452; x=1698409252; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2iJjGAU7KUMFLPTjjZhqvhRIpT8gr3t3UZ9MaRvEo0c=;
        b=de63NQyPopMONy1tlL7qxLmkg4Um68UEXMNolCddTacPV1FTgcT/W84jd3n4+WFKHK
         3boMmOavHaTHO5adcIS+RMZxFLXdFQLu5gqJw5CHKxnm8lOzFPaNn00+UTo+NuFNcLGE
         OZ0VFhwAHza2505y1NcVCErgwLyvS9FWk6o73amWPMiCmtbq4cmJYfC7TJjio3dFBBsL
         GPqxbtkzmM8d+Funeqw6HNC0eH7K3h/spjh+b4I6dZ5qhsx1iNXXyxpt5nsrpZO8sAyq
         fN8/qJtVe6bJg4ZfQP57se057q8hI+WOeQikMimyO+8MO/dU1gpNX0TRpM5kq3X6jHHD
         Fjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697804452; x=1698409252;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iJjGAU7KUMFLPTjjZhqvhRIpT8gr3t3UZ9MaRvEo0c=;
        b=QYfW/yE8Ke3MYsd2YYgbnyuHzv4X5vQxkUA1o3CoEKy8+OMqMY8P0tQIWJqBLcsxBf
         FMFW5Uop9QsZIsEgacdSrVKwDo7a5oYiJDwyk78B5mrJSb3yYUTQKiV2hz2vC39SPvZk
         UmR6H/tvPLOmaQxM9AXI5jkkYp/5sghxIetKZSXWZhhidbQAniTTRvqk08nhf7bRlQVC
         GNC6oaXR870dnfAvg/SQf68HqtfBobAfAhn+QKj47B6Dl/24BB103ohEQXbvz9t8mjki
         qZHjVxYFXhailAdL7QQtLAr/PbOuG8GNzk5UZodDY0BZ2jEanx7ywziWOib6eel8booP
         DnaQ==
X-Gm-Message-State: AOJu0Yxhe6WOaKC7ivqz2471KWFgB5h2eIwSFalU0XQxm5dbcNFP9D3Q
        YCkMvXpBMjacaWUkILd0IaVE6Q==
X-Google-Smtp-Source: AGHT+IFWWm/QzR6h/mLZ2kZr6aBJYyDH+MMXOE9Ra3k71Ds4W3r1qZDVA4VOoXAsZ3vyg6DJ5gdKPg==
X-Received: by 2002:a17:90b:394f:b0:27d:2dde:5979 with SMTP id oe15-20020a17090b394f00b0027d2dde5979mr1887214pjb.5.1697804452357;
        Fri, 20 Oct 2023 05:20:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j11-20020a17090aeb0b00b00262ca945cecsm3110458pjz.54.2023.10.20.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:20:46 -0700 (PDT)
Message-ID: <6532709e.170a0220.fd6c8.a079@mx.google.com>
Date:   Fri, 20 Oct 2023 05:20:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-lib: 3 runs,
 3 regressions (linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6)
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

kselftest/fixes kselftest-lib: 3 runs, 3 regressions (linux-kselftest-fixes=
-6.6-rc5-1-gcf5a103c98a6)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6/plan/kselftest-lib/

  Test:     kselftest-lib
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
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/653263c517e87f5732efcf27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest/gcc-10/lab-collab=
ora/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest/gcc-10/lab-collab=
ora/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/653263c517e87f57=
32efcf28
        failing since 367 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/653266688bbcae9cebefcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/653266688bbcae9c=
ebefcefa
        failing since 354 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/653264446c819f477defcf25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc5-1-gcf5a103c98a6/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/653264446c819f47=
7defcf26
        failing since 366 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
