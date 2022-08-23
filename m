Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9582959CE00
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 03:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiHWBmU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 21:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiHWBmS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 21:42:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6945A811
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 18:42:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id w13so5898780pgq.7
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 18:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=DE7PJ+b2iF6rQvtIr13Yh8sxsnueuaHEz7LipeCEi4Y=;
        b=OwCKcYoDQZNZxT4ls0PAeUxu9pSwniocKwQhSBy8jN+HMPNHp1+UJLl+d+bRsuauyc
         NS8oW6V0UiOHGSqoD5DUBf8jB0W/YfVEdUcMy+kq8wfnE17LrPzmHGhhfHHD6atbjp2a
         gL7jpEkBSQuJ/VBBl7EuQoQgOl5KY8KZfCJPPdQjaHYsED33SkG/QsQ2XwvecLgLqUuT
         eVp6MEm7g8rcPXGnZequ/ophaHiKhhVqBxbzXgkIgolek52AaNm3aCLEWpgOu6qj/Tcc
         k5/z73k4AQzN/f7jr0OXqq5l6ONMU3WG6fN/tHoA/ua/gxdocKzD3EZIUSsr8sHPem48
         KM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=DE7PJ+b2iF6rQvtIr13Yh8sxsnueuaHEz7LipeCEi4Y=;
        b=A1UMkfq6Hk/8zt1q8PsR92hHsHPEtXMDEYBINgGcLtsq8WTMz/OOvoE/GxMZwGYZja
         JdokF3FgnLYHkK2FXjEK7zMJ5mbgVn0i2PW0BiheSaguvEjVvn/dq661m+oo9dIw4qOC
         vORKtVjxnBrAwlNEsxa6xo+iTxofIst0Z3nbe0weV0jIwPf1XnINOlhfJPAxoNQqcsNF
         lOGjTYn+ZPQKu3F2ETDj2qAAS45lsxp/Z839H1jNG8MeTAQvFCeiPpoA9c0MqXi2CKco
         od9I+xCailZG4zwD48d63ZxE3O/xqBT/WCYxybbuTZGGIpd997qRSU5bdNfwb2iQnNsS
         /6+A==
X-Gm-Message-State: ACgBeo1O4KCRwI+UC/MfexMxrnB+/OybejjkazdVudaY9Oc9zghYxbVh
        Or8ZUxg/1AV4hLpQoMicsmMUlR30aLtWoQB+
X-Google-Smtp-Source: AA6agR7qFvU6q8qCfvjBzy9VbG+IaiFUTlSNklXZIPLUJON1p6p6p7kaJLKfiE/LFD8ASJtW0k3cnQ==
X-Received: by 2002:a63:484e:0:b0:429:411b:1d8c with SMTP id x14-20020a63484e000000b00429411b1d8cmr18838944pgk.623.1661218936286;
        Mon, 22 Aug 2022 18:42:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c25-20020a631c59000000b0041b29fd0626sm7970224pgm.88.2022.08.22.18.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 18:42:15 -0700 (PDT)
Message-ID: <63043077.630a0220.a5e3e.ead0@mx.google.com>
Date:   Mon, 22 Aug 2022 18:42:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-next-6.0-rc2-1-gab7039dbcc61
Subject: kselftest/next kselftest-lib: 7 runs,
 1 regressions (linux-kselftest-next-6.0-rc2-1-gab7039dbcc61)
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

kselftest/next kselftest-lib: 7 runs, 1 regressions (linux-kselftest-next-6=
.0-rc2-1-gab7039dbcc61)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-10   | defconfig+kselftes=
t | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/linu=
x-kselftest-next-6.0-rc2-1-gab7039dbcc61/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: linux-kselftest-next-6.0-rc2-1-gab7039dbcc61
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ab7039dbcc61229aa635357b847a643973497561 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-10   | defconfig+kselftes=
t | 1          =


  Details:     https://kernelci.org/test/plan/id/6304220408d7d305ea355646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/linux-kselftest=
-next-6.0-rc2-1-gab7039dbcc61/arm64/defconfig+kselftest/gcc-10/lab-baylibre=
/kselftest-lib-meson-g12b-odroid-n2.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/linux-kselftest=
-next-6.0-rc2-1-gab7039dbcc61/arm64/defconfig+kselftest/gcc-10/lab-baylibre=
/kselftest-lib-meson-g12b-odroid-n2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6304220408d7d305=
ea355647
        new failure (last pass: v6.0-rc1-1-gf1227dc7d0411) =

 =20
