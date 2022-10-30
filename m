Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91062612ADA
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 15:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ3ODF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Oct 2022 10:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ3ODE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Oct 2022 10:03:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7C6B49E
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 07:03:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l6so8421774pjj.0
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=whSCAQ6ZS1LBVWxe3bYsHoTqrk1ytNqoy/Of/Sai6AE=;
        b=654S/I3oQHHoJbI7GcyFI/k3mZfSzL+PwjzFxh7LHEaRegZEGNMSwX8r6M5l9A9bDl
         N3nKA97Pe38d80zt20iG8fEJib1DUasA7QmBry1ZrKAuIFnkLy4ZKHbymV5Rre0YAhI7
         7i9CtsQY/KxWu1N5ESBN353zu1/nxfUNzejfkL4BKbEGmHZhDmjCS/v8CynPjyCf8c+V
         hS8w0nq2WzcBTHKzsC+F+/dNiYxiWoB0fymS//jcQncltYAfzLeO0bSwjwfeO1Ho13eI
         BHuAodJ1w4wORG31TxV0gJdHCgfNIQti5Svz+dWkcVi+R8/TvEBTxxDjTdUC5eOLI+GB
         oNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whSCAQ6ZS1LBVWxe3bYsHoTqrk1ytNqoy/Of/Sai6AE=;
        b=cFdjQF6wStvHJD7rzN82mISHlpP9NRWNxJqvJn3ziU7PxMvI6RNlmbISiUBmQluFcx
         92ocV3bEMZa7oNkt1G2OZn4SJXo56eZSj/a+eK3S3W1aHbeiBTtEAKVOVEEiIRjhUSpv
         2eB/Jmbk8tGnvIMYLM9crKQ2QAjcrzpJ5Fe1ymKn1STuQ1FBR9SejDL7FWTEkvyY6WYd
         Zn+hQjmRpKi82bd9Nl+aZRqeAHo/pKb5BLrrB40HfaJ+cEnccadcTiOAAT8faMI6skBF
         92VogO7uJ6MVN05j1BhTFwwE1FfmeNo6++fKEMK100LBErTiJy4h4maSR5mGDoxUIrVC
         YJ1w==
X-Gm-Message-State: ACrzQf2CZ9PUmlXHXntBOh++5UQGmvS9eBmYdFWlGQTmuO7Z1FBsW6/C
        CKF3o4jMten1TMCmjB5sOI8Fog==
X-Google-Smtp-Source: AMsMyM7H3LTauh329kFmENyr7kATrbq74AoElDvd8QCjI+irVOK+ARV1dfjVL5taPo3hTon13UdbZg==
X-Received: by 2002:a17:90a:e413:b0:213:c581:8634 with SMTP id hv19-20020a17090ae41300b00213c5818634mr4886494pjb.185.1667138582895;
        Sun, 30 Oct 2022 07:03:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090a2e8200b002086ac07041sm2418121pjd.44.2022.10.30.07.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 07:03:02 -0700 (PDT)
Message-ID: <635e8416.170a0220.f025e.3b5b@mx.google.com>
Date:   Sun, 30 Oct 2022 07:03:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-cpufreq: 2 runs,
 2 regressions (linux-kselftest-fixes-6.1-rc3-2-g3d982441308e)
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

kselftest/fixes kselftest-cpufreq: 2 runs, 2 regressions (linux-kselftest-f=
ixes-6.1-rc3-2-g3d982441308e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.1-rc3-2-g3d982441308e/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      3d982441308ebdf713771c8a85c23d9b8b66b4d4 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/635e7a9ae43fe917a3e7db78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest/gcc-10/lab-brooni=
e/kselftest-cpufreq-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/635e7a9ae43f=
e917a3e7db79
        new failure (last pass: linux-kselftest-fixes-6.0-rc3) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635e72045553ca6f48e7db7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-2-g3d982441308e/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/635e72045553=
ca6f48e7db80
        failing since 11 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
