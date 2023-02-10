Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064D2691710
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 04:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBJDRA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 22:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjBJDQ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 22:16:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C73E1B308
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Feb 2023 19:16:56 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id bx22so3954610pjb.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Feb 2023 19:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+UIPa3zXeYcfy5PKJCeKCzlI95VKnqWYvVe8yxHtzPw=;
        b=WbCuIiZCL/d+l9H33fPBztKLp9bUZ5h/GXlHLUAb75cjv5fRxQfKjB4r818xv39lEv
         HtWcUKbnuBv2X8bgBloxQiS921eX/8d6i++PbpH7g/zahQRmwsWGDJtWD1naJxgbBUB+
         e/9wPl+zN8lwH3GCDkksCFpcwBCIEg+39tox4BGejrDvygQLKGWm52AOI85nHEI2FWHD
         Xelp2se83KKw9hrx6PxLPHStqhkcbcUw57qsxdsSao8zLL0p3aIYGY4puXYkphEqxBdh
         N7gSAG3HnTbvvxAkqVbgqAy8hgR6V62qXJs44HQ2MdPALC9MdegFSSeQdhcovqdkDh1G
         rHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UIPa3zXeYcfy5PKJCeKCzlI95VKnqWYvVe8yxHtzPw=;
        b=4ICfujbC7uWAlGUSixPJrqHDsWYWdpucedk47I9Zpv7d/+tKcSftgjix5JjF6x9CoV
         Q7VB+vW1q/6AyNP7o7zHvc6U3hUqNKU58nv2Mc49zy/oXZlAGdP3itpUki668GzDvvzm
         y/kLWit+DT4ypaz+R6oeIcPI0zmyKricw6IUxyz83OiL6Z6NfEMk++JUx7hS4oLHc8w7
         UTlSQ+kglOsOvdaNCEw3G34MINGa9xRd0ykd1HZdFbmmyZHM0VbWMZPUX5532Hs3AGHL
         Gmj3CjxYjMSFObmkAnTzwfERVBd2DTzyxqv1OKEjrl/XwM5Khi5SgnHTiHy5AtCKmX2O
         bCHg==
X-Gm-Message-State: AO0yUKUOHgzu+3yBwxm45AEgq97usnQIt3m+7ZwV2Sw3sNlMBkCaB99b
        uWzh2vdra1qciTU5CU/JMBil6zHOGb9ISt2oQ84=
X-Google-Smtp-Source: AK7set8GHniJFYy6haiJnXQLzZROFsJ4prDF94Fduv0BO7EuRPNs+r++LDZGUq4d+EEWmxs7ixDVDw==
X-Received: by 2002:a05:6a20:12cc:b0:be:22b4:9e6a with SMTP id v12-20020a056a2012cc00b000be22b49e6amr15861870pzg.61.1675999015832;
        Thu, 09 Feb 2023 19:16:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l16-20020a62be10000000b00580cc63dce8sm2137227pff.77.2023.02.09.19.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 19:16:55 -0800 (PST)
Message-ID: <63e5b727.620a0220.a2c56.4196@mx.google.com>
Date:   Thu, 09 Feb 2023 19:16:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-36-g4c853ca1cf79
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 2 runs,
 2 regressions (v6.2-rc5-36-g4c853ca1cf79)
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

kselftest/next kselftest-livepatch: 2 runs, 2 regressions (v6.2-rc5-36-g4c8=
53ca1cf79)

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
-rc5-36-g4c853ca1cf79/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-36-g4c853ca1cf79
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4c853ca1cf798f1d74a7bd9e3a0541a3ae8ae77e =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63e5a68ece592798a08c8646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63e5a68ece=
592798a08c8647
        failing since 45 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e5a61c6ce09168f58c8659

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63e5a61c6c=
e09168f58c865a
        failing since 115 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
