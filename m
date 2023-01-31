Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E69682CEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 13:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjAaMsP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 07:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjAaMsO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 07:48:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFA7234EE
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 04:48:13 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l4-20020a17090a850400b0023013402671so2225093pjn.5
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 04:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uBcW9TJRIe/ClLPTNmgpfm9AgkGxMCe94pN0o2qdqT8=;
        b=GYsbb2eZ2rKe2Z2lF6Y/Mj5fGJgfcdxLuCL6a3HEQwFBFI98k/dCHf/mh9YSo9RpjN
         4iyHWrJvHaguaDQ8KhCdSoucS6n0W0e/0HZ4HpTr90GD/EgKcwchZgGNJiqOEJjOsZxi
         ZvwJkkvZwQ7O5J+AWFa2LaOnrwAw2SeDkix9+4ys6loByZKydT2Xvz5tcjPI+gqHI8/j
         kL68E/NolyaRIKxViOZi/vDikSdTyb4VC/TqhiU3cHftKjST7MEwl7gj20BsCUJWhCjk
         pRRjqcwdocuvGVhPneitukzVHsA1RezGg+U3cT+phVFghH9c0gjsfa50j+iYSI9WOpwL
         zIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBcW9TJRIe/ClLPTNmgpfm9AgkGxMCe94pN0o2qdqT8=;
        b=4j5rE1dbObRc7GRpCErYNaJcENyfFOapCqL5xnjQsGDL1SOp2SDEUvq7aRnEDAXBdI
         0QkvOIoTg8lX+Rdqv6c4fh9e7/JMvthiOX3MKya70ebvhwViHuo4e/Y127Ux//F5M3Sn
         leaWWeLeUoC5WM7ZJeh7N75n0zF+VtheU+wXkdbG1j5sbADinWgw1YtqU/gvDjGUpdFI
         VQ8BQLiFtMfrGtm9bQitah8mrdfAlKdKpdIGQWuvneUF0j8KSfbnhHz2/DSIqKF07+5s
         RajNYn5Otr1cibMi6FmI16XpJEjYLbFVuvBZC55iRR/UvMxIZEAmTQCxPq6yYegaar6J
         yEfw==
X-Gm-Message-State: AO0yUKXlVwIb0MRLJKB06tcn5BF1UiiMXMGIJ2J/fqENQtY06HS1R+Va
        yzSL2GOQMiyEGPW0te7QFb4gqTsAzKEhstE7k/1Q3w==
X-Google-Smtp-Source: AK7set8gNJkzIvYc37p1EL4NIFSWrVKbtW+UzhgPw4WE2I6ev7eL/BeuflVZ+09etbz5pTMuxJ0/dw==
X-Received: by 2002:a17:90b:3e81:b0:22c:8636:bd66 with SMTP id rj1-20020a17090b3e8100b0022c8636bd66mr10432617pjb.37.1675169292985;
        Tue, 31 Jan 2023 04:48:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h2-20020a17090a648200b002296094b9cdsm10689889pjj.24.2023.01.31.04.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:48:12 -0800 (PST)
Message-ID: <63d90e0c.170a0220.bde5c.1208@mx.google.com>
Date:   Tue, 31 Jan 2023 04:48:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-31-gc837391e4499
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 2 runs,
 1 regressions (v6.2-rc5-31-gc837391e4499)
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

kselftest/next kselftest-cpufreq: 2 runs, 1 regressions (v6.2-rc5-31-gc8373=
91e4499)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-31-gc837391e4499/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-31-gc837391e4499
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      c837391e449979b550a9aabfcc253d245b5436a1 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d902e3ff986f2e55915f28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-31-gc8=
37391e4499/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63d902e3ff98=
6f2e55915f29
        failing since 105 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
