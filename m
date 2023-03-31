Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED43A6D2684
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 19:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjCaRUZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 13:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCaRUY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 13:20:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197911BF77
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 10:20:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so24074644pjz.1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680283222;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MYfjxNXyrjvgc3XlXVfdvi/FdVJr6SGSXl2in3DBTz4=;
        b=vdJd5Cl5VoYUYLQpuLLf4guYku9uJGKkUWNJVdvyJmZFBA60vb9t2c/DTZnWQPIklH
         cpdZmo7uU7k08l6EjQFmrJrWphIsUT2Klsv4Os7AoxiAty80nQ4WB7Zvrdix5qvSYxw2
         z576v6nHE5zAClbWKzvAFngxm9qB1UBp3Y0Mnj5AItzdkEW+KDwHWxu21nGYImeREcbu
         3YEZ7l15WyUoKLN9uqW3zgYYmoj89TnbBbkcapGeGJMy7czy9I9DEFQAB0jf2Bqzo4Wa
         hjUxE/Szylr4LwmeI+KG8Bu15+OpLPLs7NGPHIxmYoA8nnAV6+E8spB+BUpfRAxo6YJl
         Lcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680283222;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYfjxNXyrjvgc3XlXVfdvi/FdVJr6SGSXl2in3DBTz4=;
        b=xllsYGo9Ij8it/2FVE2ThyUucHLinpRO6k4EWRu/Wt4dCVN/NH6FBmmt/Y6Vzsh4WO
         tw7CRjY46cQ85wdKIrECI5BAicXDqLlQKIngEHPdphCKv9z3qxAqS9Yec/UMAenHKTwq
         7MJY0njsFpu5TJZqmnlIBa6Ei6+03OPljIjVjqQF3lZi8iNziV5kRutHusCpgcS2IJm8
         vRTiHF5o3aTpEzoy3INPoAsVQ6rBYqjiHsE0k37csWLT415CTJNJw5hgMpH/ttZhvLyp
         eQbtRBRw2bA6Ff6JmlP2me907h9wGVsHjF2wbqhZZITrW8l41FnGstnQ5L9b/hHX8Too
         GqBg==
X-Gm-Message-State: AAQBX9c9UMxIsuJ9Yaq5iiWs6QVqYYPTXAsFC8OvCf+Za4j6V3i1ZFM9
        7Qo8va70SMc83JomwRncDOUygg==
X-Google-Smtp-Source: AKy350bI7rMKkdK+wXqTq3aAJ00f01PWdA81mM2aFakNDFlG+7+xBLB0UUIkLWHBuFSVK8nxwQpOUQ==
X-Received: by 2002:a17:90b:17c5:b0:23d:31c3:c98d with SMTP id me5-20020a17090b17c500b0023d31c3c98dmr33481448pjb.15.1680283222402;
        Fri, 31 Mar 2023 10:20:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s33-20020a17090a69a400b0023faa95f75csm5262600pjj.36.2023.03.31.10.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:20:21 -0700 (PDT)
Message-ID: <64271655.170a0220.c3c76.b5f1@mx.google.com>
Date:   Fri, 31 Mar 2023 10:20:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657
Subject: kselftest/fixes kselftest-cpufreq: 4 runs,
 1 regressions (linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657)
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

kselftest/fixes kselftest-cpufreq: 4 runs, 1 regressions (linux-kselftest-f=
ixes-6.3-rc5-1-gf1594bc67657)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.3-rc5-1-gf1594bc67657/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.3-rc5-1-gf1594bc67657
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f1594bc676579133a3cd906d7d27733289edfb86 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642705bc3f662119ae62f817

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.3-rc5-1-gf1594bc67657/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/642705bc3f66=
2119ae62f818
        failing since 163 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
