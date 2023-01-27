Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F9767DCD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 05:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjA0Ead (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 23:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjA0Eab (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 23:30:31 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F24936688
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 20:30:30 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 5so3858711plo.3
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 20:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2IvnjHoAoq/dJCNah17xH2YlJBPGecoLdjdKGTDzK18=;
        b=SFKx0rvyJKvkFxIH8wlGKq7FbqbeA20/yaKaQq7tM0AUfBgz7Phw1hJdvDwyelXA9D
         qSTAfh7psjAQUrc9TilITnWR+CCmXNfoZL7AiZaKe7SZaA5jhZOW2hgsuFb9kqXkQR8l
         SV9IUS1lMn3GTWnVjCs8okMEzXhIB8hJWlMiKDJAcdGrxdxTJYMjbZQlTsKnQ+frrpEb
         9tD7z/7/Rq38jQIe70H+gM3PzuMGIFbcRZdlJevxtpxc6ZP2TfkbHSk75rYVo6wOwh9v
         kx+1Sw0sL38J0MhpeMR9iTIP+Pe2AwVdkanoLqcxKcXk8v/5jwlfV+jwNSHb00ltIdaj
         Sr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IvnjHoAoq/dJCNah17xH2YlJBPGecoLdjdKGTDzK18=;
        b=d5vbgJxJwOK8gjQ3sVfzrkIuvLovzylELb+YgrNsrH3JAT8c3PeyglojT4nqX/8Seb
         B7uyj3vuicwi0FYO6fI1YxHYDHKupmNI9XJ3z+RMy+heTVryiMzvDIcE2CGjg5snZqUU
         jr1M1KL0tFj7ShWzaLNVYoXYMwG4OOP9wQgyHvjiYN1Se/gVNRTmbCUysOYoI7xSVp/x
         m/t73TmxVL9GV6WN2/B1xyW4lu4kK6gscsQj/wRh+ZczdlrQUD8IX9Z1LAxuhMc7Ku8E
         myUhvfEmBrb+3V5qJeuulTxcJyfwDUn0UWd3wMh1K1R6syb+KsotZe9daSA9slc41PGm
         0J7Q==
X-Gm-Message-State: AO0yUKVRa8hEX8SvFJB61P5RSq/xO5LL4BJplM+XHUm2pdRi8pfLe4nD
        NT1fkje8h0WNy/5tOI7axve0Vw==
X-Google-Smtp-Source: AK7set/YkF2TccjoZgSc8yjEaOKk2AEM8dlwarKWHRxSoC8dq//Lbp34w1VUnVWwxm/mYMhVj2dKQA==
X-Received: by 2002:a17:903:234b:b0:196:595b:2580 with SMTP id c11-20020a170903234b00b00196595b2580mr26904plh.0.1674793829559;
        Thu, 26 Jan 2023 20:30:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b0019625428cefsm1743486pla.281.2023.01.26.20.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 20:30:29 -0800 (PST)
Message-ID: <63d35365.170a0220.e608c.343f@mx.google.com>
Date:   Thu, 26 Jan 2023 20:30:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-1-g65177e47d303
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 2 runs,
 1 regressions (v6.2-rc5-1-g65177e47d303)
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

kselftest/next kselftest-cpufreq: 2 runs, 1 regressions (v6.2-rc5-1-g65177e=
47d303)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-1-g65177e47d303/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-1-g65177e47d303
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      65177e47d3035c083cff034ffbfc7ab750a4675c =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d345bcc852818d57915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63d345bcc852=
818d57915ebb
        failing since 101 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
