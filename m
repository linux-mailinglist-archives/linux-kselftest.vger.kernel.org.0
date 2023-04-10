Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3203E6DCDA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 00:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjDJWnf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Apr 2023 18:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjDJWne (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Apr 2023 18:43:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAEB172C
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 15:43:33 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-634b28df952so561987b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 15:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1681166613; x=1683758613;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dgbi8jdsgO983jbr3l6rn6DvYPRjpLcqLud8I+A1A8k=;
        b=rAD9tXgCx304/rFNxt2uSzSxxOqFyA1d+O4e6IflAZsGBMr95YF6f+1eBwWAItONMq
         El2S34h3X3xzGloCXQd687Zsnb262VyfulMjEOWf36GG9qfeIXb6IV3AalNekuh7rvA9
         TkX9EJvNzOo9PgkR6pmqOI1L7+XtHLdkuXlPuhKxOgPfFC+abHMmilb3PgYK0o9Gz92q
         kxBzv/ZFxHji4kcHGKX+ECOLoukGqjuLIHxOy6SwO+5nU7beFFnFSj1C656XGFYUQqRX
         jm1r8TTzY/y2KJBCJw1aziG0dCOXUNxft6lid+MDn7bU93jerugFLAzsk2eX5GOADfui
         +rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681166613; x=1683758613;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dgbi8jdsgO983jbr3l6rn6DvYPRjpLcqLud8I+A1A8k=;
        b=MRnloq9hOt2GNTuaImado2kNAVu9YcJ0B2jzAdZ9RhrZfAG3iNe5NBpMmoq8d2Q12Y
         wu+KwpK5b5u60rk5Fqy7D1R6OQJDg+KDe6JoyEF+zkDTV1vaHQCSJw/bzcOFTkOsTDhB
         ITioOn6N5BzZejKfYbGfhM2GAjDUzeyPczZBxTiCtTXuy4y4lNlMsIyQs8fLDxWa6pH1
         DvupEZV+mRt8EQChS4ng9urV0+91s8ujxTAhvn8uL/Sx0bI2GZAyfnoc7Ut5WVQv8zUV
         A+hYqQRpZtZrG8yWpkH1I+BW+kO8JkcpifDESCavNDb0iG9AQrTOewTDhoASzXh0GbFH
         thPg==
X-Gm-Message-State: AAQBX9egs/Q9ZBjEgi9McBZkrNQ3fIvL3L+YgYC8fP1wOS/tsT4DWj4T
        AzacNczDktXXAPtTi1doqRanjNnpK04+3DMVtZM=
X-Google-Smtp-Source: AKy350a/+2CTvujhwwsBuAxC9/07RNya8eXYE6HQmjVRnbQg79CTqH1RK5PiCNVs+4H94YHzg96GrA==
X-Received: by 2002:a62:3087:0:b0:63a:d2e4:cc35 with SMTP id w129-20020a623087000000b0063ad2e4cc35mr1313793pfw.31.1681166613114;
        Mon, 10 Apr 2023 15:43:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h20-20020aa786d4000000b00638ac6f9a0bsm2081829pfo.11.2023.04.10.15.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:43:32 -0700 (PDT)
Message-ID: <64349114.a70a0220.3067e.49bd@mx.google.com>
Date:   Mon, 10 Apr 2023 15:43:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-14-g5874a6a187f2
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 7 runs,
 2 regressions (v6.3-rc1-14-g5874a6a187f2)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-cpufreq: 7 runs, 2 regressions (v6.3-rc1-14-g5874a=
6a187f2)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-14-g5874a6a187f2/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-14-g5874a6a187f2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5874a6a187f2e814542d7fdf918fd29f79ff25c3 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64348b1f24aaf7600b2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/64348b1f24aa=
f7600b2e85e7
        failing since 172 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64348210e3ffd7435f2e87a3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/64348210e3ff=
d7435f2e87a4
        failing since 174 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
