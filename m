Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B49564A42
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 00:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiGCWQF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Jul 2022 18:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiGCWQE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Jul 2022 18:16:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB802BDE
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Jul 2022 15:16:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o15so3098421pjh.1
        for <linux-kselftest@vger.kernel.org>; Sun, 03 Jul 2022 15:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+GBclQx7HsKUWSD2aDWmOv06bPC7ptvqbrv1aDDCjZo=;
        b=iqF9smd4Z01xXifWdWvUvlCWRUTenNr61jcIKNF94zsQ+PtYbzfkpKfOeequYJoZx9
         /kOCFz8c/D7FNGbxO9S+Z2HLnZxv/AbzdOZqKE+3X2PDZtbfZZ+g7Kf6O1eV1E0QxvLX
         RTuV919VuibPuWvjojTmcPAau+lHYqUB7XSJyOat0plSy5W7vscW8FCdiwp/CsiIjEH0
         zu4ne3kkwoZxyE3n5Gq+pnUXoM6O8VjqYOoJ86OS9VlZ7EkRbrH47ab0Uj5yEvXe+bnM
         UpQemwm+fFIWU9pqBXKu9Ia9ZCwUWVN039KhSUdMUCloQnAb3XCJTWD0QyEdd2/net3t
         motQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+GBclQx7HsKUWSD2aDWmOv06bPC7ptvqbrv1aDDCjZo=;
        b=A0HkUT29g2T3IM7I6/D5xrQ4IkgwBH2Lf3mnjNAvFlR4BNjwNNPzO/ZVJBJtJBT33H
         Ku8fVMyh5JCMbR9FZ0kLNplE3yNq1RaFCj4mPlIxozoWq6PTSn3rDf/3zTHNTPlqYOP5
         VTWnXTg5k4XESoGGQPioW7Zr0mrv21evbKcafcC+Xgs6lOMcqcnytRVdqXzQ0ei9jjuN
         dXunrT05awZt3lEmMObnu4/Q44KUeFa8y8YFctd9Bcs9bh9OPhxshHLTFMNwZ6KiLSZF
         4CSJ1lwC5ITE65Ui1BkCwMHjw8axnZ7mJJcPyXIs0VOjtuex/kctoMjmhqDE2y++r/1h
         zR6A==
X-Gm-Message-State: AJIora+qRv0Y43H6N/3PvCIRDKo39/Ia/DCdjeGaIuKXRp91YpcF1L+4
        AabGo+2NvZlQB0Dp0zQR4T6TrnzFs7sNLOyz
X-Google-Smtp-Source: AGRyM1stPnjIPv53RE8cIyHfEzlMR/svUhxnHneKBcWOs0R+CQYSL7aWCkhvboP2x8+SQ28rH2Xo0Q==
X-Received: by 2002:a17:90b:17cb:b0:1ec:9d52:46f7 with SMTP id me11-20020a17090b17cb00b001ec9d5246f7mr30550068pjb.221.1656886561805;
        Sun, 03 Jul 2022 15:16:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090aba1600b001ec71be4145sm10879309pjr.2.2022.07.03.15.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 15:16:01 -0700 (PDT)
Message-ID: <62c21521.1c69fb81.86722.fa7f@mx.google.com>
Date:   Sun, 03 Jul 2022 15:16:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc4-7-gb7ecce6800eb
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 3 runs,
 1 regressions (v5.19-rc4-7-gb7ecce6800eb)
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

kselftest/next kselftest-cpufreq: 3 runs, 1 regressions (v5.19-rc4-7-gb7ecc=
e6800eb)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | clang-14 | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
9-rc4-7-gb7ecce6800eb/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v5.19-rc4-7-gb7ecce6800eb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b7ecce6800eb1aa97c486c1aabf64659193d5a4c =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | clang-14 | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c2058055cebd3c1ba39bee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    clang-14 (Debian clang version 14.0.6-++20220622053050+f28c0=
06a5895-1~exp1~20220622173135.152)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.19-rc4-7-gb7=
ecce6800eb/arm64/defconfig+kselftest/clang-14/lab-baylibre/kselftest-cpufre=
q-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.19-rc4-7-gb7=
ecce6800eb/arm64/defconfig+kselftest/clang-14/lab-baylibre/kselftest-cpufre=
q-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/62c2058055ce=
bd3c1ba39bef
        failing since 27 days (last pass: v5.18-rc3-19-g15477b31db104, firs=
t fail: v5.19-rc1) =

 =20
