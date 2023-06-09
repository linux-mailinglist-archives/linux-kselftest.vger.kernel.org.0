Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC5A72A5BC
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 23:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjFIV6F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 17:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjFIV6F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 17:58:05 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EDA2D44
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 14:58:04 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-543ae674f37so972300a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686347884; x=1688939884;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a0n0GFyx+yfmjmLuxPwRO3A1bGq4k30JKzVNl3DGru0=;
        b=aqXyi8NSVJ3zwZvjl3e1kZglUWf4Yv62pL6NjKHXVZ/snce/VP+y985QOYCzYLfoX4
         v6lTfE5qpB4Db7hmHzRN6KbWzhZ+U+CkeEV3WGlihkyQzjzsz9Z3AzXwqgeDT9/9JkWe
         Jq+ihGjGK7pKGHrpNWM68EhvnjqN4sMUki8vsPXxedzD3MGGo4iMSYkTb64/wuo/0f3W
         GKBSJIgTIa6RiwTTPPkfQbTgGcckx40DHuoIfg0pINGD+Sz00YQiAq69xOw/oJGniHBX
         2S/egpP9TU8TA2Hus7OIqMxycU+aG1d4St9No7R96E3hsE79ciIv4GF9l/Ef8pK7BhC+
         W3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686347884; x=1688939884;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0n0GFyx+yfmjmLuxPwRO3A1bGq4k30JKzVNl3DGru0=;
        b=PChK7+10B6aI4J4JfXBHDfTUCKd+UfN7rged1Zq+DMZNH96JBshDFt3HOIhDlv8v4j
         QyjxZVcTJ9jMwGIyhh8TtynRtIcIGYWqqGmhMyCLLNSeNjrYcqK+/9XkvvmP9WjTnMbi
         vg6pGQgKaKOduFqQnv6hfZngXWuyM4wqE5oda3Ma+xAnObu0KFOjd6dmYReD5jo0dVcL
         wAuYG1x/D8Wq+YkvcTc0+1U25P3i0O1KwSb/JYoLktpUpDdyIisiNjUuAUuPgXTQ2ZOK
         pNk4x7OlxDrqX9DKze1FBd6ShP1QHTH3bWnFEny3qs82QRGhnjxQel9GGbg+7anW2HyG
         ye5g==
X-Gm-Message-State: AC+VfDzS6A3fVnQu8c43/Z4rUFtA9fM4oUBHY3sbuC1bCYlP1C8HMvuA
        3zFGd3wheTB2GvQQ1ecHM7qsSA==
X-Google-Smtp-Source: ACHHUZ5YL4Zd12qhH65uRTzV+uNw3Krt7iuGAd7yxEuUx2muS66Nax9+IXATJpxyoEVisMtBPVPncw==
X-Received: by 2002:a17:903:22c7:b0:1b1:1168:654f with SMTP id y7-20020a17090322c700b001b11168654fmr2104900plg.56.1686347883745;
        Fri, 09 Jun 2023 14:58:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001aaffe15f39sm3721603plt.30.2023.06.09.14.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:58:01 -0700 (PDT)
Message-ID: <6483a069.170a0220.15c8c.8ca7@mx.google.com>
Date:   Fri, 09 Jun 2023 14:58:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.4-rc1-9-gd51a218328e0
Subject: kselftest/next kselftest-lib: 3 runs,
 2 regressions (v6.4-rc1-9-gd51a218328e0)
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

kselftest/next kselftest-lib: 3 runs, 2 regressions (v6.4-rc1-9-gd51a218328=
e0)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-9-gd51a218328e0/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-9-gd51a218328e0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d51a218328e0be533ca0b10bc29060aaec70432d =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64838ffedd477d86f1306137

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-gd51=
a218328e0/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-gd51=
a218328e0/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64838ffedd477d86=
f1306138
        failing since 164 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/648392365b89d106dd306193

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-gd51=
a218328e0/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-gd51=
a218328e0/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/648392365b89d106=
dd306194
        failing since 234 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
