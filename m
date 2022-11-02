Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF036164AB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 15:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiKBOOb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 10:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiKBOOa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 10:14:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC63240B2
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 07:14:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 4so16730361pli.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 07:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RnW7lA0FMJItFEutDnxUehkdBbA4SQD+cVB/AG3NYNo=;
        b=iTCPOAEwrXb6i4XZvI7DlgVuwxNGAJJ8JS3CId5cCJyUrPSsFmOdM/YNs5OVjaOOl0
         fUF9FJeIyshAAV2N2Fu8AcZsXghmJaAQlPyMOXovfPwRrfdQQrvQUyRvGtOw3MZTl1F4
         WuzBphtKYVuttX6z4Pk9h1s6703HQQrETsgyy2M6rXUqq9pCYkwQo9NI7GqxG/0srqV8
         YS0Bi95JxGvxHFXmeppASnK4BdXfSjavEZXowXE9Ud68p3BOmTiInorWxiWGQscc1pNI
         ZDxFZqzTJLee8x0OwmK6dmV7jjtsRpKnlaB8lv+DmOTBan6HlT0OKyBnc0Gf8z7ogdaR
         aAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnW7lA0FMJItFEutDnxUehkdBbA4SQD+cVB/AG3NYNo=;
        b=aPmmGgXJXOz5P/qEQpGLWkk6xmqjNBZM2Sq54b3D3vbGs3doZnj7SlN7u3mN597dJ2
         Y3kh1A7l/cwhlnaRZ5i0SSAyV6r8fk6EoBmY8wX2+1EqHsuqsf0kPH6HvekBDG1xxbNP
         0twuFsuIOrc+99VARJgTgQaMAr4YcSpic/nWCK71ldBoCM02iTo5h+NRMvFaplnP0f8X
         MrlQ0B3vvMSJ6kd1KcO0mFpFC0/YvTKQ6r+hbOqQiSV0D6k+8HY3IqUIB3RoiKjQIkBc
         Tdd06l0qshNXeD5b/nOn6P0N02hZz78ByXDI2JCcq/2Pa2+ihOkHQ02qzD+3JpsN8eY4
         qGQw==
X-Gm-Message-State: ACrzQf3lyyDysOll+AIo2nQbx6V4anoFAFHm04IIvJYnFjiTRVyt5D+D
        /0gyaLFYpewYGGZUuzVZZ7oDp8WjkdRfizCW
X-Google-Smtp-Source: AMsMyM6PXr3kR3UmoBmPaiUQutT4gWMXnQKuAK+oBYhOAHYvh5Fnje3hnb4d9YZxk8XPLUPJQureLg==
X-Received: by 2002:a17:90b:4a46:b0:214:27dc:a111 with SMTP id lb6-20020a17090b4a4600b0021427dca111mr4957652pjb.28.1667398468801;
        Wed, 02 Nov 2022 07:14:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ik23-20020a170902ab1700b00172951ddb12sm8419639plb.42.2022.11.02.07.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:14:28 -0700 (PDT)
Message-ID: <63627b44.170a0220.7340d.fb81@mx.google.com>
Date:   Wed, 02 Nov 2022 07:14:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-lib: 3 runs,
 2 regressions (linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67)
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

kselftest/fixes kselftest-lib: 3 runs, 2 regressions (linux-kselftest-fixes=
-6.1-rc3-3-g89c1017aac67)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.1-rc3-3-g89c1017aac67/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      89c1017aac67ca81973b7c8eac5d021315811a93 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626e9e0720ac3502e7db6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63626e9e0720ac35=
02e7db6e
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63626aec11e7c17733e7db5f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.1-rc3-3-g89c1017aac67/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63626aec11e7c177=
33e7db60
        failing since 14 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
