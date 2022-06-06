Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249D853F166
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jun 2022 23:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiFFVHw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jun 2022 17:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiFFVGu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jun 2022 17:06:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE13E8FD73
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jun 2022 14:00:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y196so13682126pfb.6
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jun 2022 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=N9ZRDMmM1rBmA1GKxCiFaV0yctjH9N1zB7qH1NoV3Yo=;
        b=GQHAowfna4vG9/LRddnJ2EmUjai4lQArNK76O0MwvFRMQ1Ad2MFYF1Q0WhmZhnWNaM
         S3Gnum1gAUWE/5J05enamsAOhvYwI6fXbcJdUPniYxXj8Zy1BeMyfziD6WYjGoNnAcMi
         GZuVGTIKZN5c+pFyM7UOP86aQxiKesMpHLpRnJqzK9Md19am4P+IUJw2dYsS1EUoBOis
         EHvfVZy92JVFeNOV0GsTJA2Noyx09N4kH6dfC+24B/ItTjerAhLk4kFmIBnNHsVbEniB
         Ru9sUeqgzoWq+DBLUsK4qYOLVl9NCULcoVAlrk3kE4sxH7ro0xxOtms23YMU94zYksJy
         duyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=N9ZRDMmM1rBmA1GKxCiFaV0yctjH9N1zB7qH1NoV3Yo=;
        b=JMYRKlGHpxh+mVX895nJAd6U3Q6+35j8o1aVl/j+ktJPT2LeMp6NhQp9eyeDUdC5tA
         x9ruWUIsK5Zu4IFddFRwNoDL9kX+0toZC3qkcrHUGhLCzRMRjWaEn11OHHXVqGU13mpW
         KNVxi2QRAcuYA5XlC/Ipd7kaLm3j37dIZiaWcz5GHofuI7aC3vuQDrbDKFM+l4Cv3Rs7
         ngn02DEsUW1ILgNr5GJQozFKokY50HmuaH0yc6lZoI+0YJBzpmmXBYYE5kWwenyA3stz
         +mqO/SAKDSfVbEDFOTPdeITPjnSaHiSdj8ioGKaCqFRqT4xIeb7nZ0syydo6akX755WQ
         +9gQ==
X-Gm-Message-State: AOAM531RM5aQbQsVHCjGpwmipaPNtpdQa4NyEHijaYH2+xBCxKTE+nUW
        oPVLzyuv9OHOM9iV3vo0Frx5oAKcu7xEZzEx
X-Google-Smtp-Source: ABdhPJwtg7lBrtRErEZu5jph+63Nc7Q0rxxOfJIUpay2+f6cLrr7HPYcnMHNGEsJVO4EU7OZHbwY+A==
X-Received: by 2002:a65:6808:0:b0:3fd:208f:b764 with SMTP id l8-20020a656808000000b003fd208fb764mr16535368pgt.484.1654549240394;
        Mon, 06 Jun 2022 14:00:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 19-20020a621713000000b0051b8e5d7260sm11313898pfx.49.2022.06.06.14.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:00:38 -0700 (PDT)
Message-ID: <629e6af6.1c69fb81.1d5ab.8e17@mx.google.com>
Date:   Mon, 06 Jun 2022 14:00:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc1
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 11 runs, 1 regressions (v5.19-rc1)
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

kselftest/next kselftest-lib: 11 runs, 1 regressions (v5.19-rc1)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | clang-14 | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
9-rc1/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v5.19-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f2906aa863381afb0015a9eb7fefad885d4e5a56 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | clang-14 | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/629e5e7aa0aed65494a39bf0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-14 (Debian clang version 14.0.5-++20220603023205+576e5=
b39ae4d-1~exp1~20220603143239.145)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.19-rc1/arm64=
/defconfig+kselftest/clang-14/lab-baylibre/kselftest-lib-meson-gxl-s905x-li=
bretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.19-rc1/arm64=
/defconfig+kselftest/clang-14/lab-baylibre/kselftest-lib-meson-gxl-s905x-li=
bretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220603.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/629e5e7aa0aed654=
94a39bf1
        new failure (last pass: v5.18-rc3-19-g15477b31db104) =

 =20
